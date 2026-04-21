Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A73382F30;
	Tue, 21 Apr 2026 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755988; cv=none; b=QLZOWou5CO8BNMSzczTYcDPrBuKaBmwUb4GdkvetzaagNhqZpjeL47S8fbJ24Rm7uat+s70WdUxRh6RqtXRhZpMi5BWZZ70xBk07lZ4U5npzwb3Eu3FscqNTQ2WfSaQ4f9N4RFVaXkCEcoTH+aLhKn0Im/DucsfucI4iQK8RRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755988; c=relaxed/simple;
	bh=Byud9Y3i1ZAffmc4IzdV5kUXgo5JSFXJu7hERBwY2JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8Mr3jao9e8IHh9yKARdhcmZQKpJHjkvAuql1/QglVT8t7Cse+nady8POpjDGj2MMZBIh0CxYujXlzlQj08le6w2MZXHUqtPxmnjg+SF7v52Zv6tM5uZymMZerPebNjpQ727c4tDFtItmDRsDmy+iqMyXLI+fRmoHHLplIEOAlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6L3D7uI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6L3D7uI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98557C2BCB0;
	Tue, 21 Apr 2026 07:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776755987;
	bh=Byud9Y3i1ZAffmc4IzdV5kUXgo5JSFXJu7hERBwY2JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V6L3D7uIF4kZGG+U1eda5Fm2+dNze3LYivkpCEuRUOHzKreqiOXYANZftVPHf1ngz
	 msn4jqXjJMDKJyHc3We2FVtjgYSPG+qsRr1lsOU1jpoPsfnTL5G+d/5/Zv0dPDcdFI
	 S1ZLMnNRlukLf3K1BBkRY5EHzQXQ/R+UtrI3bSJXq/6taj0ZEew2iIWuPUBUQRCdRC
	 mpScFhcVQDTzqPX1amdM9cR0nnpe9HmV+85LxhOmH0qWHL/YKYaiOXpaiK7JAKFWHJ
	 RDPITqdHq/ltqYXt1fo9E2KmMLRlInLWk/1CtrGuWFwS4DN4rjf4KUf1gAIwN3iZKg
	 WfrPj/XMNCBtg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/16] sched_ext: Rename ops_cpu_valid() to scx_cpu_valid() and expose it
Date: Mon, 20 Apr 2026 21:19:30 -1000
Message-ID: <20260421071945.3110084-2-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421071945.3110084-1-tj@kernel.org>
References: <20260421071945.3110084-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the static ext.c helper and declare it in ext_internal.h so
ext_idle.c and the upcoming cid code can call it directly instead of
relying on build_policy.c textual inclusion.

Pure rename and visibility change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 22 +++++++++++-----------
 kernel/sched/ext_idle.c     |  6 +++---
 kernel/sched/ext_internal.h |  2 ++
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0a53a0dd64bf..8c7450c5ebfa 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1055,7 +1055,7 @@ static inline bool __cpu_valid(s32 cpu)
 }
 
 /**
- * ops_cpu_valid - Verify a cpu number, to be used on ops input args
+ * scx_cpu_valid - Verify a cpu number, to be used on ops input args
  * @sch: scx_sched to abort on error
  * @cpu: cpu number which came from a BPF ops
  * @where: extra information reported on error
@@ -1064,7 +1064,7 @@ static inline bool __cpu_valid(s32 cpu)
  * Verify that it is in range and one of the possible cpus. If invalid, trigger
  * an ops error.
  */
-static bool ops_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where)
+bool scx_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where)
 {
 	if (__cpu_valid(cpu)) {
 		return true;
@@ -1677,7 +1677,7 @@ static struct scx_dispatch_q *find_dsq_for_dispatch(struct scx_sched *sch,
 	if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
 		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
 
-		if (!ops_cpu_valid(sch, cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
+		if (!scx_cpu_valid(sch, cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
 			return find_global_dsq(sch, tcpu);
 
 		return &cpu_rq(cpu)->scx.local_dsq;
@@ -3259,7 +3259,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		this_rq()->scx.in_select_cpu = false;
 		p->scx.selected_cpu = cpu;
 		*ddsp_taskp = NULL;
-		if (ops_cpu_valid(sch, cpu, "from ops.select_cpu()"))
+		if (scx_cpu_valid(sch, cpu, "from ops.select_cpu()"))
 			return cpu;
 		else
 			return prev_cpu;
@@ -8678,7 +8678,7 @@ static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	struct rq *this_rq;
 	unsigned long irq_flags;
 
-	if (!ops_cpu_valid(sch, cpu, NULL))
+	if (!scx_cpu_valid(sch, cpu, NULL))
 		return;
 
 	local_irq_save(irq_flags);
@@ -8774,7 +8774,7 @@ __bpf_kfunc s32 scx_bpf_dsq_nr_queued(u64 dsq_id)
 	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
 		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
 
-		if (ops_cpu_valid(sch, cpu, NULL)) {
+		if (scx_cpu_valid(sch, cpu, NULL)) {
 			ret = READ_ONCE(cpu_rq(cpu)->scx.local_dsq.nr);
 			goto out;
 		}
@@ -9163,7 +9163,7 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu, const struct bpf_prog_aux *aux)
 	guard(rcu)();
 
 	sch = scx_prog_sched(aux);
-	if (likely(sch) && ops_cpu_valid(sch, cpu, NULL))
+	if (likely(sch) && scx_cpu_valid(sch, cpu, NULL))
 		return arch_scale_cpu_capacity(cpu);
 	else
 		return SCX_CPUPERF_ONE;
@@ -9191,7 +9191,7 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu, const struct bpf_prog_aux *aux)
 	guard(rcu)();
 
 	sch = scx_prog_sched(aux);
-	if (likely(sch) && ops_cpu_valid(sch, cpu, NULL))
+	if (likely(sch) && scx_cpu_valid(sch, cpu, NULL))
 		return arch_scale_freq_capacity(cpu);
 	else
 		return SCX_CPUPERF_ONE;
@@ -9227,7 +9227,7 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf_prog_au
 		return;
 	}
 
-	if (ops_cpu_valid(sch, cpu, NULL)) {
+	if (scx_cpu_valid(sch, cpu, NULL)) {
 		struct rq *rq = cpu_rq(cpu), *locked_rq = scx_locked_rq();
 		struct rq_flags rf;
 
@@ -9340,7 +9340,7 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu, const struct bpf_prog_aux *aux)
 	if (unlikely(!sch))
 		return NULL;
 
-	if (!ops_cpu_valid(sch, cpu, NULL))
+	if (!scx_cpu_valid(sch, cpu, NULL))
 		return NULL;
 
 	if (!sch->warned_deprecated_rq) {
@@ -9397,7 +9397,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
 	if (unlikely(!sch))
 		return NULL;
 
-	if (!ops_cpu_valid(sch, cpu, NULL))
+	if (!scx_cpu_valid(sch, cpu, NULL))
 		return NULL;
 
 	return rcu_dereference(cpu_rq(cpu)->curr);
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index c43d62d90e40..11d11ea6ca6b 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -917,7 +917,7 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 	bool we_locked = false;
 	s32 cpu;
 
-	if (!ops_cpu_valid(sch, prev_cpu, NULL))
+	if (!scx_cpu_valid(sch, prev_cpu, NULL))
 		return -EINVAL;
 
 	if (!check_builtin_idle_enabled(sch))
@@ -975,7 +975,7 @@ __bpf_kfunc s32 scx_bpf_cpu_node(s32 cpu, const struct bpf_prog_aux *aux)
 	guard(rcu)();
 
 	sch = scx_prog_sched(aux);
-	if (unlikely(!sch) || !ops_cpu_valid(sch, cpu, NULL))
+	if (unlikely(!sch) || !scx_cpu_valid(sch, cpu, NULL))
 		return NUMA_NO_NODE;
 	return cpu_to_node(cpu);
 }
@@ -1257,7 +1257,7 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu, const struct bpf_prog_
 	if (!check_builtin_idle_enabled(sch))
 		return false;
 
-	if (!ops_cpu_valid(sch, cpu, NULL))
+	if (!scx_cpu_valid(sch, cpu, NULL))
 		return false;
 
 	return scx_idle_test_and_clear_cpu(cpu);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 4a7ffc7f55d2..1345ccc01026 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1382,6 +1382,8 @@ DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
 
 int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id);
 
+bool scx_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where);
+
 /*
  * Return the rq currently locked from an scx callback, or NULL if no rq is
  * locked.
-- 
2.53.0

