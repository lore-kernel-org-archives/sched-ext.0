Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA90D1F4C8C
	for <sched-ext@lists.linux.dev>; Mon, 11 Aug 2025 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947327; cv=none; b=X9pHRlWJuAjpNJyps0t1u49KknsW1wEUd22wsc8ba3Nm3CEL9JsespNcd1SZt6N3AyOt3ljARkXx+m7Ezd4YmaDjveGHI45+/6yVYqhhIui/RIadduYaX+anMcwpgQssrG18gG4DbBizWhzEicNcYIarpXFBSaQDqyQKgoqBL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947327; c=relaxed/simple;
	bh=rs1rz9seRhodTia6WJevCMyrbdJdVy+CPiy7SqP4Obo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=orfqd3OgRq73B5qeB0XGoMCM5RCXDirk82yAGr0HtaBI9HRdoYM9vSmD5WUNRXSGC6eSTqFVekXRbX+CFi/tjQQHr7DspvZAu6DAF7h78qbwBB/24YN33zJKWqi/gkcoLuXXG9traxWruk4/5p6unSPmzKFr4A4NdEwYgEXc0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0474F1E8D;
	Mon, 11 Aug 2025 14:21:57 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.55.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1FACD3F63F;
	Mon, 11 Aug 2025 14:22:01 -0700 (PDT)
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
	jake@hillion.co.uk,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v4 1/3] sched_ext: Introduce scx_bpf_cpu_rq_locked()
Date: Mon, 11 Aug 2025 22:21:48 +0100
Message-Id: <20250811212150.85759-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811212150.85759-1-christian.loehle@arm.com>
References: <20250811212150.85759-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most fields in scx_bpf_cpu_rq() assume that its rq_lock is held.
Furthermore they become meaningless without rq lock, too.
Make a safer version of scx_bpf_cpu_rq() that only returns a rq
if we hold rq lock of that rq.

Also mark the new scx_bpf_cpu_rq_locked() as returning NULL.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c                       | 22 ++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7dedc9a16281..14706c36ca83 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7426,6 +7426,27 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 	return cpu_rq(cpu);
 }
 
+/**
+ * scx_bpf_cpu_rq_locked - Fetch the locked rq of a CPU
+ * @cpu: CPU of the rq
+ */
+__bpf_kfunc struct rq *scx_bpf_cpu_rq_locked(s32 cpu)
+{
+	struct rq *rq;
+
+	if (!kf_cpu_valid(cpu, NULL))
+		return NULL;
+
+	preempt_disable();
+	rq = cpu_rq(cpu);
+	if (rq != scx_locked_rq()) {
+		scx_kf_error("Accessing not locked rq %d", cpu);
+		rq = NULL;
+	}
+	preempt_enable();
+	return rq;
+}
+
 /**
  * scx_bpf_task_cgroup - Return the sched cgroup of a task
  * @p: task of interest
@@ -7590,6 +7611,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
+BTF_ID_FLAGS(func, scx_bpf_cpu_rq_locked, KF_RET_NULL)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index d4e21558e982..7451491347ed 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -91,6 +91,7 @@ s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
+struct rq *scx_bpf_cpu_rq_locked(s32 cpu) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
-- 
2.34.1

