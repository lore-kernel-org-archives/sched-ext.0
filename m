Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA92B254846
	for <sched-ext@lists.linux.dev>; Mon,  4 Aug 2025 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306900; cv=none; b=oGWkZqD04FBDrV5PD5mmkzJIfCgkGNyb4E8v34xCD2wlt2801yoi6cEk9qnl9WhVk2UMMUtRH1WgBy0QRK5s192agPdzPy94iuXrYmVEJtbkbft7H4O9KOqKMqvtEibzc6GtZemIlQBi7r5pZuzMw685wGW3f3fAZPqT7vjAVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306900; c=relaxed/simple;
	bh=5H2g4ROH68kWoK7NzqORbbWAnCo1V6t5mQSMrhel89s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=flz9Sao8wXB/kd3l5wGSs157iFOp8Hk/w0ibXWyhznnrpH+x2Err3JpTR6Th8nwHbing1nEbWyx2IM137/eBWq4d5OUnQTaOVTID+13qdfrQn+dR8324T4Q8hN+TLpCyU/v/BT48bNx6It4u1vUrE12dOt7ngqsUuwsJVMOoiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 496F41C25;
	Mon,  4 Aug 2025 04:28:10 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.25.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 66B503F673;
	Mon,  4 Aug 2025 04:28:16 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: tj@kernel.org,
	arighi@nvidia.com,
	void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	changwoo@igalia.com,
	hodgesd@meta.com,
	mingo@redhat.com,
	peterz@infradead.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2 2/3] sched_ext: Provide scx_bpf_remote_curr()
Date: Mon,  4 Aug 2025 12:27:42 +0100
Message-Id: <20250804112743.711816-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804112743.711816-1-christian.loehle@arm.com>
References: <20250804112743.711816-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide scx_bpf_remote_curr() as a way for scx schedulers to
check the curr task of a remote rq, without assuming its lock
is held.

Many scx schedulers make use of scx_bpf_cpu_rq() to check a
remote curr (e.g. to see if it should be preempted). This is
problematic because scx_bpf_cpu_rq() provides access to all
fields of struct rq, most of which aren't safe to use without
holding the associated rq lock.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c                       | 24 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3ea3f0f18030..1d9d9cbed0aa 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7426,6 +7426,29 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 	return cpu_rq(cpu);
 }

+struct task_struct *bpf_task_acquire(struct task_struct *p);
+
+/**
+ * scx_bpf_remote_curr - Fetch the curr of a rq without acquiring its rq lock
+ * @cpu: CPU of the rq
+ *
+ * Increments the refcount of the task_struct which needs to be released later.
+ */
+__bpf_kfunc struct task_struct *scx_bpf_remote_curr(s32 cpu)
+{
+	struct task_struct *p;
+
+	if (!kf_cpu_valid(cpu, NULL))
+		return NULL;
+
+	rcu_read_lock();
+	p = cpu_rq(cpu)->curr;
+	if (p)
+		p = bpf_task_acquire(p);
+	rcu_read_unlock();
+	return p;
+}
+
 /**
  * scx_bpf_task_cgroup - Return the sched cgroup of a task
  * @p: task of interest
@@ -7590,6 +7613,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_RET_NULL)
+BTF_ID_FLAGS(func, scx_bpf_remote_curr, KF_RET_NULL | KF_ACQUIRE)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index d4e21558e982..e5d4ef124532 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -91,6 +91,7 @@ s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
+struct task_struct *scx_bpf_remote_curr(s32 cpu) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
--
2.34.1

