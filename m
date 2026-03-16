Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FE838E5D6
	for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655384; cv=none; b=pp31mY9YYWmnWx7m0AwjnJq0RTRXo4Jm6G1CwxAjbk6afPl3xVR3kMGBl/uNK1xTZfXr0neIIt6b9QMNYP/FX8dpgjUPVPX46NdTI+fzPwaiVou22/0IxyFFLezes4+dcHv+FJ7N/wqgKJ6C1FJeDVT+W1M3Jsyc4fuAXmIB3lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655384; c=relaxed/simple;
	bh=GllGj6xZhSDS16w8+jOsHbmWKwR3CFBW/xrXou7tlFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlCW1xw6L3WPKaYyORLXih5PHZyc82mSfK3oC1Q64GxhtXcvDcf4Pb8uM6Et8ax6qQT5JPiGXjhDHEm+73pOL9OMLnfqf/izQbZbL3iORWLBJhZpLlpSTYwUQ3PL7KUgNH4IIY/nXoNQ1LuFdufWFeLw+CG+2n3qrDDEhDoOz+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81AAD14BF;
	Mon, 16 Mar 2026 03:02:55 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.28.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 02BFE3F73B;
	Mon, 16 Mar 2026 03:02:58 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	shuah@kernel.org,
	dietmar.eggemann@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 1/2] sched_ext: Prevent SCX_KICK_WAIT deadlock by serialization
Date: Mon, 16 Mar 2026 10:02:48 +0000
Message-Id: <20260316100249.1651641-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316100249.1651641-1-christian.loehle@arm.com>
References: <20260316100249.1651641-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

SCX_KICK_WAIT causes kick_cpus_irq_workfn() to busy-wait using
smp_cond_load_acquire() until the target CPU's current SCX task has been
context-switched out (its kick_sync counter advanced).

If multiple CPUs each issue SCX_KICK_WAIT targeting one another
concurrently — e.g. CPU A waits for CPU B, B waits for CPU C, C waits for
CPU A — all CPUs can end up wedged inside smp_cond_load_acquire()
simultaneously.  Because each victim CPU is spinning in hardirq/irq_work
context, it cannot reschedule, so no kick_sync counter ever advances and
the system deadlocks.

Fix this by serializing access to the wait loop behind a global raw
spinlock (scx_kick_wait_lock).  Only one CPU at a time may execute the
wait loop; any other CPU that has SCX_KICK_WAIT work to do and fails to
acquire the lock records itself in scx_kick_wait_pending and returns.
When the active waiter finishes and releases the lock, it replays the
pending set by re-queuing each pending CPU's kick_cpus_irq_work, ensuring
no wait request is silently dropped.

This is deliberately a coarse serialization: multiple simultaneous wait
operations now run sequentially, increasing latency.  In exchange,
deadlocks are impossible regardless of the cycle length (A->B->C->...->A).

Also clear scx_kick_wait_pending in free_kick_syncs() so that any stale
bits left by a CPU that deferred just as the scheduler exited are reset
before the next scheduler instance loads.

Fixes: 90e55164dad4 ("sched_ext: Implement SCX_KICK_WAIT")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 26a6ac2f8826..b63ae13d0486 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -89,6 +89,19 @@ struct scx_kick_syncs {
 
 static DEFINE_PER_CPU(struct scx_kick_syncs __rcu *, scx_kick_syncs);
 
+/*
+ * Serialize %SCX_KICK_WAIT processing across CPUs to avoid wait cycles.
+ * Callers failing to acquire @scx_kick_wait_lock defer by recording
+ * themselves in @scx_kick_wait_pending and are retriggered when the active
+ * waiter completes.
+ *
+ * Lock ordering: @scx_kick_wait_lock is always acquired before
+ * @scx_kick_wait_pending_lock; the two are never taken in the opposite order.
+ */
+static DEFINE_RAW_SPINLOCK(scx_kick_wait_lock);
+static DEFINE_RAW_SPINLOCK(scx_kick_wait_pending_lock);
+static cpumask_t scx_kick_wait_pending;
+
 /*
  * Direct dispatch marker.
  *
@@ -4279,6 +4292,13 @@ static void free_kick_syncs(void)
 		if (to_free)
 			kvfree_rcu(to_free, rcu);
 	}
+
+	/*
+	 * Clear any CPUs that were waiting for the lock when the scheduler
+	 * exited.  Their irq_work has already returned so no in-flight
+	 * waiter can observe the stale bits on the next enable.
+	 */
+	cpumask_clear(&scx_kick_wait_pending);
 }
 
 static void scx_disable_workfn(struct kthread_work *work)
@@ -5647,8 +5667,9 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 	struct rq *this_rq = this_rq();
 	struct scx_rq *this_scx = &this_rq->scx;
 	struct scx_kick_syncs __rcu *ksyncs_pcpu = __this_cpu_read(scx_kick_syncs);
-	bool should_wait = false;
+	bool should_wait = !cpumask_empty(this_scx->cpus_to_wait);
 	unsigned long *ksyncs;
+	s32 this_cpu = cpu_of(this_rq);
 	s32 cpu;
 
 	if (unlikely(!ksyncs_pcpu)) {
@@ -5672,6 +5693,17 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 	if (!should_wait)
 		return;
 
+	if (!raw_spin_trylock(&scx_kick_wait_lock)) {
+		raw_spin_lock(&scx_kick_wait_pending_lock);
+		cpumask_set_cpu(this_cpu, &scx_kick_wait_pending);
+		raw_spin_unlock(&scx_kick_wait_pending_lock);
+		return;
+	}
+
+	raw_spin_lock(&scx_kick_wait_pending_lock);
+	cpumask_clear_cpu(this_cpu, &scx_kick_wait_pending);
+	raw_spin_unlock(&scx_kick_wait_pending_lock);
+
 	for_each_cpu(cpu, this_scx->cpus_to_wait) {
 		unsigned long *wait_kick_sync = &cpu_rq(cpu)->scx.kick_sync;
 
@@ -5686,11 +5718,20 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 		 * task is picked subsequently. The latter is necessary to break
 		 * the wait when $cpu is taken by a higher sched class.
 		 */
-		if (cpu != cpu_of(this_rq))
+		if (cpu != this_cpu)
 			smp_cond_load_acquire(wait_kick_sync, VAL != ksyncs[cpu]);
 
 		cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
 	}
+
+	raw_spin_unlock(&scx_kick_wait_lock);
+
+	raw_spin_lock(&scx_kick_wait_pending_lock);
+	for_each_cpu(cpu, &scx_kick_wait_pending) {
+		cpumask_clear_cpu(cpu, &scx_kick_wait_pending);
+		irq_work_queue(&cpu_rq(cpu)->scx.kick_cpus_irq_work);
+	}
+	raw_spin_unlock(&scx_kick_wait_pending_lock);
 }
 
 /**
-- 
2.34.1

