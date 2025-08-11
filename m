Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82185285078
	for <sched-ext@lists.linux.dev>; Mon, 11 Aug 2025 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947334; cv=none; b=gLp+XS1FVtZDxIy/CCg7CFk1gEYPfhZfVUuiJ+Iz+NE4FT5covLUkr7+oRug/+b2BY1FJIHpFqbCZ+sojxE8gCfm26ZPsj29KzPQhCtlGJE/8SRx7JeZ/D3cBv+fmOQWUztikGry2fh5u+8DbUuRY5ueHNyPsHBqQkA6eTASxUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947334; c=relaxed/simple;
	bh=5nx1DrxNB3Sn0esWx/qM3ys/wu10WGO/lfN3dbQwdxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kuHauwDP//3m8Z4G3MH6TWq8yu60vxHMepyV3jlVeFgLbXAbeXPBMpE6L1nRNuSwkXaqGgIBW47irEdxuxi0wdiG7qJgPBam8zkgkktdHveASI+8wVDIYDebl2u7I6hx79W+M2nNl064NICiHu8GwTTTXa/uiDEYuAnqi7ifSjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF837204C;
	Mon, 11 Aug 2025 14:22:03 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.55.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7BEB73F63F;
	Mon, 11 Aug 2025 14:22:09 -0700 (PDT)
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
Subject: [PATCH v4 2/3] sched_ext: Provide scx_bpf_task_acquire_remote_curr()
Date: Mon, 11 Aug 2025 22:21:49 +0100
Message-Id: <20250811212150.85759-3-christian.loehle@arm.com>
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

Provide scx_bpf_task_acquire_remote_curr() as a way for scx schedulers
to check the curr task of a remote rq without assuming its lock is
held.

Many scx schedulers make use of scx_bpf_cpu_rq() to check a remote curr
(e.g. to see if it should be preempted). This is problematic because
scx_bpf_cpu_rq() provides access to all fields of struct rq, most of
which aren't safe to use without holding the associated rq lock.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c                       | 24 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 14706c36ca83..ded4ace36090 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7447,6 +7447,29 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq_locked(s32 cpu)
 	return rq;
 }
 
+/**
+ * scx_bpf_task_acquire_remote_curr - Fetch the curr task of a rq without
+ * acquiring its rq lock
+ * @cpu: CPU of the rq
+ *
+ * Increments the refcount of the task_struct which needs to be released using
+ * bpf_task_release().
+ */
+__bpf_kfunc struct task_struct *scx_bpf_task_acquire_remote_curr(s32 cpu)
+{
+	struct task_struct *p;
+
+	if (!kf_cpu_valid(cpu, NULL))
+		return NULL;
+
+	rcu_read_lock();
+	p = cpu_rq(cpu)->curr;
+	if (p)
+		p = refcount_inc_not_zero(&p->rcu_users) ? p : NULL;
+	rcu_read_unlock();
+	return p;
+}
+
 /**
  * scx_bpf_task_cgroup - Return the sched cgroup of a task
  * @p: task of interest
@@ -7612,6 +7635,7 @@ BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq_locked, KF_RET_NULL)
+BTF_ID_FLAGS(func, scx_bpf_task_acquire_remote_curr, KF_RET_NULL | KF_ACQUIRE)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 7451491347ed..2105cd0ee178 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -92,6 +92,7 @@ bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct rq *scx_bpf_cpu_rq_locked(s32 cpu) __ksym;
+struct task_struct *scx_bpf_task_acquire_remote_curr(s32 cpu) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
-- 
2.34.1

