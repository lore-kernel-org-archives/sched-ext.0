Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EBC2F6594
	for <sched-ext@lists.linux.dev>; Tue,  2 Sep 2025 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811553; cv=none; b=n4ZaK8FM6dX+18e3IxB6r5QjGeZMu6jMWmKEbcmfFYxUL7Cjqtg+W+d8KPT8gpkw3NWtgbxSS5noXlTutxzQy4BIsDx2wweywHy69d8TkLxnaMhNJQMJadwrskUyADl9PQCcheM0A9vYEieIKeLiPf9bg9R25lv0Og+L9bWDVBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811553; c=relaxed/simple;
	bh=ZgLcD+Uip94yvizlqHhEv7KW/s+A49+1dOGZmLQf2g8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UPxiX6MY7kcLkPu8tu3pSSWJw6wqBnkzUWpbWOkq6h0CSSFLaSDySTSoFWFfd8XXBJT+1VzoES5sVDxBWK7Ma0cFdkbs5PM7jwhqShK6V9mTbYY0Gs3ymIfdt7AVJriral7Pcj8l8Qgp2P4h73wWLy/r4I0c5X9AqvW6+q/jy3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A20D02720;
	Tue,  2 Sep 2025 04:12:22 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.90.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3EA23F694;
	Tue,  2 Sep 2025 04:12:28 -0700 (PDT)
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
Subject: [PATCH v6 1/3] sched_ext: Introduce scx_bpf_cpu_rq_locked()
Date: Tue,  2 Sep 2025 12:11:41 +0100
Message-Id: <20250902111143.2667154-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902111143.2667154-1-christian.loehle@arm.com>
References: <20250902111143.2667154-1-christian.loehle@arm.com>
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
 kernel/sched/ext.c                       | 23 +++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4ae32ef179dd..9fcc310d85d5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7430,6 +7430,28 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 	return cpu_rq(cpu);
 }
 
+/**
+ * scx_bpf_cpu_rq_locked - Return the rq currently locked by SCX
+ *
+ * Returns the rq if a rq lock is currently held by SCX.
+ * Otherwise emits an error and returns NULL.
+ */
+__bpf_kfunc struct rq *scx_bpf_cpu_rq_locked(void)
+{
+	struct rq *rq;
+
+	preempt_disable();
+	rq = scx_locked_rq();
+	if (!rq) {
+		preempt_enable();
+		scx_kf_error("accessing rq without holding rq lock");
+		return NULL;
+	}
+	preempt_enable();
+
+	return rq;
+}
+
 /**
  * scx_bpf_task_cgroup - Return the sched cgroup of a task
  * @p: task of interest
@@ -7594,6 +7616,7 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
+BTF_ID_FLAGS(func, scx_bpf_cpu_rq_locked, KF_RET_NULL)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index d4e21558e982..f5be06c93359 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -91,6 +91,7 @@ s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
+struct rq *scx_bpf_cpu_rq_locked(void) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
-- 
2.34.1

