Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3FF2EB5A1
	for <sched-ext@lists.linux.dev>; Wed,  3 Sep 2025 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934616; cv=none; b=OkgzBygC4uHXlobanPa3SXykaPpKsR3S+RUhdJUd4slC0IsOIseKtK15JQjdnMYD4Nl2mjlfpTiMpJZd66aIDEOIHFPmupyVZDFzOyBPbGw3kts+33rgJ2VfhHGC3zDuxlma3Fd1wu4yhwqvdXmYy4/aR4tFz4FL7UE9qqBipDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934616; c=relaxed/simple;
	bh=E94B3/I+ey8U/6ABm8kiPpbbVtCdMVHMMGK9O95zHXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FikLaCI4SX6e/0rIPgqXGIv3XEVumb4N6ItEUXumG12ZOPLX7phyhbSlghJbYO1yUzjEwuT4JGvHLDs574IG1xU2z+2ZUfASHDm19LbtcQkKVaUxYalok46tTWnc7TRBW7bbkXHgIWkpj4BuBMVAhD8dVrcEZ9w/wzH8Y+G/T0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55AAB1BD0;
	Wed,  3 Sep 2025 14:23:26 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.93.203])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6A8B3F694;
	Wed,  3 Sep 2025 14:23:32 -0700 (PDT)
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
Subject: [PATCH v7 2/3] sched_ext: Introduce scx_bpf_cpu_curr()
Date: Wed,  3 Sep 2025 22:23:10 +0100
Message-Id: <20250903212311.369697-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903212311.369697-1-christian.loehle@arm.com>
References: <20250903212311.369697-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide scx_bpf_cpu_curr() as a way for scx schedulers to check the curr
task of a remote rq without assuming its lock is held.

Many scx schedulers make use of scx_bpf_cpu_rq() to check a remote curr
(e.g. to see if it should be preempted). This is problematic because
scx_bpf_cpu_rq() provides access to all fields of struct rq, most of
which aren't safe to use without holding the associated rq lock.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                       | 14 ++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e15f1b0501a1..6ea81b6a6b2d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7452,6 +7452,19 @@ __bpf_kfunc struct rq *scx_bpf_locked_rq(void)
 	return rq;
 }

+/**
+ * scx_bpf_cpu_curr - Return remote CPU's curr task
+ * @cpu: CPU of interest
+ *
+ * Callers must hold RCU read lock (KF_RCU).
+ */
+__bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu)
+{
+	if (!kf_cpu_valid(cpu, NULL))
+		return NULL;
+	return rcu_dereference(cpu_rq(cpu)->curr);
+}
+
 /**
  * scx_bpf_task_cgroup - Return the sched cgroup of a task
  * @p: task of interest
@@ -7617,6 +7630,7 @@ BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_RET_NULL)
+BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_RET_NULL | KF_RCU)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index e9b006226cf6..03e614506fa3 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -92,6 +92,7 @@ bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct rq *scx_bpf_locked_rq(void) __ksym;
+struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
--
2.34.1

