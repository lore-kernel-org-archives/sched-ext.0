Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875E126CE3A
	for <sched-ext@lists.linux.dev>; Fri,  1 Aug 2025 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057880; cv=none; b=OktYU4vSRW726gBdOvf3h5MU5TZ9QEBWm+tCEDZ6piapcVEXuSTKKYc96dWqhIdZ++9Ed2RXjlmUMGHh+bCm7iS+xnRozGxylzqj6TatgRDmeJ6Ownm0/w2SGKz/WR+1qBapWxyuumWRWz8QhnTA6Sr/SH0aQUE2zpvzTiV/dvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057880; c=relaxed/simple;
	bh=iATzpBZIaYhRZrN9pHWg+tfbUaPW7A7zMYAgThJhUKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ush9D3wWpC8FvIbOj9QQrjsPcF3lF67aOGUgC6qOLE5IrtzM8wNRPQcS9j+rKbqDaLusv4dqDBtmsheGf0QhyQs7aaIHmiroajsZOFsYiVgjDYuh0gvY6oxrnqabyt2ZlPhI6a1F0Jzs1J06tnNaOkteorah6u3q1sjHYeKB2yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6B961515;
	Fri,  1 Aug 2025 07:17:50 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.27.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D376C3F673;
	Fri,  1 Aug 2025 07:17:56 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: christian.loehle@arm.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: mingo@redhat.com,
	peterz@infradead.org
Subject: [PATCH 2/3] sched_ext: Provide scx_bpf_remote_curr()
Date: Fri,  1 Aug 2025 15:17:40 +0100
Message-Id: <20250801141741.355059-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801141741.355059-1-christian.loehle@arm.com>
References: <20250801141741.355059-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide scx_bpf_remote_curr() as a way for scx schedulers to
check the curr task of a remote rq, without assuming its lock
or acquiring any.

Many scx schedulers make use of scx_bpf_cpu_rq() to check a
remote curr (e.g. to see if it should be preempted). This is
problematic because scx_bpf_cpu_rq() provides access to all
fields of struct rq, most of which aren't safe to use without
holding the associated rq lock.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c                       | 15 +++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b734f55f3318..92e66bb0b5f2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7436,6 +7436,20 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 	return cpu_rq(cpu);
 }
 
+/**
+ * scx_bpf_remote_curr - Fetch the curr of a rq without acquiring its rq lock
+ * @cpu: CPU of the rq
+ *
+ * Neither a rq lock nor a task reference is acquired.
+ */
+__bpf_kfunc struct task_struct *scx_bpf_remote_curr(s32 cpu)
+{
+	if (!kf_cpu_valid(cpu, NULL))
+		return NULL;
+
+	return cpu_rq(cpu)->curr;
+}
+
 /**
  * scx_bpf_task_cgroup - Return the sched cgroup of a task
  * @p: task of interest
@@ -7600,6 +7614,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_RET_NULL)
+BTF_ID_FLAGS(func, scx_bpf_remote_curr, KF_RET_NULL)
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

