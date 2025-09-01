Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5528F276027
	for <sched-ext@lists.linux.dev>; Mon,  1 Sep 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733179; cv=none; b=gWvdjjWEUzalN8GdZlbdVnue+4CUUge3Wh6ctPKy1DVcHGWzF6r/pmZrxEuZBaVMYFJJoNUfpTy+fv29juv37P0jz28pBpgukO1BQ9JXVda4S0CZ11XlZxKNGGM+p7XTkTJcLhGog116C0ICOwuLEpi+8xmh3RBUCXOELnKeSXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733179; c=relaxed/simple;
	bh=CnZ1AkoEVJJCR0lQztmsLSPspC1yUeEPw84wsW1/LQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eupY7C9UUQBpdsvcpFMmFC6PG3b0YgqsV3nDezAJDC40AkspRn8v2wQZDMNFgex9Jjr06c5dSIxbOZVGTU3POXllc2WaoKtTw+tMoqjeku+WsLaHG0JhDbDpKR3p62Y9fHdnC45RK2DqXv6oc3CVUix4TeL/tYLD+GWjzFVh92w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D2B2681;
	Mon,  1 Sep 2025 06:26:09 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.36.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 18C843F694;
	Mon,  1 Sep 2025 06:26:15 -0700 (PDT)
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
Subject: [PATCH v5 2/3] sched_ext: Introduce scx_bpf_remote_curr()
Date: Mon,  1 Sep 2025 14:26:03 +0100
Message-Id: <20250901132605.2282650-4-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901132605.2282650-1-christian.loehle@arm.com>
References: <20250901132605.2282650-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide scx_bpf_remote_curr() as a way for scx schedulers to check the curr
task of a remote rq without assuming its lock is held.

Many scx schedulers make use of scx_bpf_cpu_rq() to check a remote curr
(e.g. to see if it should be preempted). This is problematic because
scx_bpf_cpu_rq() provides access to all fields of struct rq, most of
which aren't safe to use without holding the associated rq lock.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c                       | 14 ++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9fcc310d85d5..e242a2520f06 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7452,6 +7452,19 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq_locked(void)
 	return rq;
 }
 
+/**
+ * scx_bpf_remote_curr - Return remote CPU's curr task
+ * @cpu: CPU of interest
+ *
+ * Callers must hold RCU read lock (KF_RCU).
+ */
+__bpf_kfunc struct task_struct *scx_bpf_remote_curr(s32 cpu)
+{
+	if (!kf_cpu_valid(cpu, NULL))
+		return NULL;
+	return READ_ONCE(cpu_rq(cpu)->curr);
+}
+
 /**
  * scx_bpf_task_cgroup - Return the sched cgroup of a task
  * @p: task of interest
@@ -7617,6 +7630,7 @@ BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq_locked, KF_RET_NULL)
+BTF_ID_FLAGS(func, scx_bpf_remote_curr, KF_RET_NULL | KF_RCU)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index f5be06c93359..dd3d94256c10 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -92,6 +92,7 @@ bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct rq *scx_bpf_cpu_rq_locked(void) __ksym;
+struct task_struct *scx_bpf_remote_curr(s32 cpu) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
-- 
2.34.1

