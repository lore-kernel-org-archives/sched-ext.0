Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AB1368294
	for <sched-ext@lists.linux.dev>; Fri, 19 Jun 2026 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884780; cv=none; b=rC8QzVolB92m7L7I0tQI7mmYChd70o3t8HmFjGRCyqgvpQEmLRkS/ILgP2msP+zyIhbZVFyZ7fqfURl45dzGHFnkfHJ02IkjsTx77fcLQ/Txm+CAP17WhtLvYjVdwy90RoEBhjpWbhTQSXs4weOOs9FbqmJrqsoZW5g5DrSk6aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884780; c=relaxed/simple;
	bh=sd1T8E+V6BrZa/5tBOY4+7obeBjnUs0gVWH7h5SeEiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h28sk+K1E8xbK/jCvAQ8ew8bzhuhZXMc/PwZQXh2hYcyOdsdDp2iX+x8OhEYp0uq9fURStjXVEFBi6MJIbXQ6XygQt9i0WeOxUWwppZM8gDeNo41U6Pq0NwBodGDVVTEZ00KOt6lx7ck11WIvDSJVdHqZb+WZTT2xfbA4cW4gIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EEjHjKdY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EEjHjKdY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49B1827DC;
	Fri, 19 Jun 2026 08:59:31 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.27.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 65E4F3F763;
	Fri, 19 Jun 2026 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781884775; bh=sd1T8E+V6BrZa/5tBOY4+7obeBjnUs0gVWH7h5SeEiI=;
	h=From:To:Cc:Subject:Date:From;
	b=EEjHjKdYuhENkOgFAq3+0lWM8UzmPFzOde6vO54KQoNi3pp6AFa61V4yb8l2O6qTG
	 fACXpV7jnvvt/bLTX3+idsdL5V5R1WDuA21Ik2y3YNNriLO/FYk9/G1DGjn5U0TDqA
	 lXfqUpERsmkCdy2xZsG495dHoatJeIfSIsgQmNio=
From: Christian Loehle <christian.loehle@arm.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	gnq25@mails.tsinghua.edu.cn,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] sched_ext: Remove deprecated scx_bpf_cpu_rq()
Date: Fri, 19 Jun 2026 16:59:20 +0100
Message-Id: <20260619155920.156257-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_cpu_rq() exposes rq pointers without requiring the rq lock and
has emitted a deprecation warning since commit
5c48d88fe004 ("sched_ext: deprecation warn for scx_bpf_cpu_rq()").
The supported replacements cover the intended uses:
scx_bpf_locked_rq() for locked rq access and
scx_bpf_cpu_curr() for remote curr lookup.

Remove the kfunc, its BTF registrations, the deprecation warning
state, and the BPF-side prototype and compat fallback.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c                       | 30 ------------------------
 kernel/sched/ext_internal.h              |  1 -
 tools/sched_ext/include/scx/common.bpf.h |  5 ++--
 tools/sched_ext/include/scx/compat.bpf.h | 17 --------------
 4 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0db6fa2daea3..72d99dd3fe89 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -10222,34 +10222,6 @@ __bpf_kfunc s32 scx_bpf_task_cid(const struct task_struct *p)
 	return tbl[task_cpu(p)];
 }
 
-/**
- * scx_bpf_cpu_rq - Fetch the rq of a CPU
- * @cpu: CPU of the rq
- * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
- */
-__bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu, const struct bpf_prog_aux *aux)
-{
-	struct scx_sched *sch;
-
-	guard(rcu)();
-
-	sch = scx_prog_sched(aux);
-	if (unlikely(!sch))
-		return NULL;
-
-	if (!scx_cpu_valid(sch, cpu, NULL))
-		return NULL;
-
-	if (!sch->warned_deprecated_rq) {
-		printk_deferred(KERN_WARNING "sched_ext: %s() is deprecated; "
-				"use scx_bpf_locked_rq() when holding rq lock "
-				"or scx_bpf_cpu_curr() to read remote curr safely.\n", __func__);
-		sch->warned_deprecated_rq = true;
-	}
-
-	return cpu_rq(cpu);
-}
-
 /**
  * scx_bpf_locked_rq - Return the rq currently locked by SCX
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
@@ -10540,7 +10512,6 @@ BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cid, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_locked_rq, KF_IMPLICIT_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, scx_bpf_cid_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
@@ -10575,7 +10546,6 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
 BTF_KFUNCS_START(scx_kfunc_ids_cpu_only)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_cpu_rq, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_IMPLICIT_ARGS | KF_RET_NULL | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, scx_bpf_cpu_node, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap, KF_IMPLICIT_ARGS)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b04701190b23..38f099ccd24f 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1165,7 +1165,6 @@ struct scx_sched {
 	 * but it doesn't really matter.
 	 */
 	bool			warned_zero_slice:1;
-	bool			warned_deprecated_rq:1;
 	bool			warned_unassoc_progs:1;
 
 	struct list_head	all;
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 9591a6e778ce..bd51986c4c42 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -96,7 +96,6 @@ s32 scx_bpf_pick_any_cpu_node(const cpumask_t *cpus_allowed, int node, u64 flags
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
-struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct rq *scx_bpf_locked_rq(void) __ksym;
 struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
 struct task_struct *scx_bpf_tid_to_task(u64 tid) __ksym __weak;
@@ -983,8 +982,8 @@ extern struct irqtime___local cpu_irqtime __ksym __weak;
 static inline struct rq___local *get_current_rq(u32 cpu)
 {
 	/*
-	 * This is a workaround to get an rq pointer since we decided to
-	 * deprecate scx_bpf_cpu_rq().
+	 * This is a workaround to get an rq pointer now that
+	 * scx_bpf_cpu_rq() has been removed.
 	 *
 	 * WARNING: The caller must hold the rq lock for @cpu. This is
 	 * guaranteed when called from scheduling callbacks (ops.running,
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 87f15f296234..133058578668 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -233,23 +233,6 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
 	 scx_bpf_pick_any_cpu_node(cpus_allowed, node, flags) :			\
 	 scx_bpf_pick_any_cpu(cpus_allowed, flags))
 
-/*
- * v6.18: Add a helper to retrieve the current task running on a CPU.
- *
- * Keep this helper available until v6.20 for compatibility.
- */
-static inline struct task_struct *__COMPAT_scx_bpf_cpu_curr(int cpu)
-{
-	struct rq *rq;
-
-	if (bpf_ksym_exists(scx_bpf_cpu_curr))
-		return scx_bpf_cpu_curr(cpu);
-
-	rq = scx_bpf_cpu_rq(cpu);
-
-	return rq ? rq->curr : NULL;
-}
-
 /*
  * v6.19: To work around BPF maximum parameter limit, the following kfuncs are
  * replaced with variants that pack scalar arguments in a struct. Wrappers are
-- 
2.34.1

