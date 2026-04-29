Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012141C2F6;
	Wed, 29 Apr 2026 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486895; cv=none; b=Jm0gVovyEVTXfCCXq2v/Ms/8qoeTQSWisrW2Is0hhI5cibarNX3CibXU1xvEpwzUd/xnxBBCc0hVI23SIpmp4BPBg6Ph9SLBIKwFyj4cCajLQl2M+GHTK5v67yFyvtLZwh2EYe5bOmqwfM38FmJbEKxlI5YcT1VevIp/Kzru/sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486895; c=relaxed/simple;
	bh=meFyt0LODci4ns+8qKbWAW0jCyRpsKaA++YM4h32LGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=go+vXHk1/WHgewgXozD+G2Jqy9RVGrWfMFiE/8wDSCUz+iA0eqbfu+d6DThsGZCwkL7Lt0LuZyx/lYLbBNZs8iW62Y2MHvNnVRfK3kNGkms8YwmKmgYq2U4l4vYwudHy2Lv3sYcVzyqSqkx6aj34GDsOt5vuKKHm8V2sK7e+pn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qovKDHaR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qovKDHaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EC9C2BCC6;
	Wed, 29 Apr 2026 18:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486895;
	bh=meFyt0LODci4ns+8qKbWAW0jCyRpsKaA++YM4h32LGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qovKDHaRYKQyoVbQMBYy1GNwNJtR/k3X0W2FvifG4Qkvj0J5dgxJQ6xDm/CGGw8JT
	 E5HRpaR4c00LhUAOO3X5M9Fb6nydVAeEUz47/jzPZ4di5APty2bxuxpC5xDGRS6wwr
	 VdcAZCLlVV4BStc6JemEyB+OqB6e6fLspVPEXk032EAr7Nbzws6XmSUeEpr3De08Ar
	 kZQ6lijoP82GB3iv3yPvdNIOdcX9sSEtbxvRjpjMUj7qkruVVtip9x9N/DjNR5xJ0S
	 lt2piz89IXQw0q5a6nCiGCxVAYsQOV6KpDgU+0Gn5JOMpwYmjAnSR7ezu4hmJ7sBVN
	 DJZs+KO2vUyLQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 02/17] sched_ext: Rename ops_cpu_valid() to scx_cpu_valid() and expose it
Date: Wed, 29 Apr 2026 08:21:16 -1000
Message-ID: <20260429182131.1780125-3-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429182131.1780125-1-tj@kernel.org>
References: <20260429182131.1780125-1-tj@kernel.org>
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
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Changwoo Min <changwoo@igalia.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c          | 22 +++++++++++-----------
 kernel/sched/ext_idle.c     |  6 +++---
 kernel/sched/ext_internal.h |  2 ++
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 920ebd441e52..0d0833bd8d20 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1067,7 +1067,7 @@ static inline bool __cpu_valid(s32 cpu)
 }
 
 /**
- * ops_cpu_valid - Verify a cpu number, to be used on ops input args
+ * scx_cpu_valid - Verify a cpu number, to be used on ops input args
  * @sch: scx_sched to abort on error
  * @cpu: cpu number which came from a BPF ops
  * @where: extra information reported on error
@@ -1076,7 +1076,7 @@ static inline bool __cpu_valid(s32 cpu)
  * Verify that it is in range and one of the possible cpus. If invalid, trigger
  * an ops error.
  */
-static bool ops_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where)
+bool scx_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where)
 {
 	if (__cpu_valid(cpu)) {
 		return true;
@@ -1691,7 +1691,7 @@ static struct scx_dispatch_q *find_dsq_for_dispatch(struct scx_sched *sch,
 	if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
 		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
 
-		if (!ops_cpu_valid(sch, cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
+		if (!scx_cpu_valid(sch, cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
 			return find_global_dsq(sch, tcpu);
 
 		return &cpu_rq(cpu)->scx.local_dsq;
@@ -3274,7 +3274,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		this_rq()->scx.in_select_cpu = false;
 		p->scx.selected_cpu = cpu;
 		*ddsp_taskp = NULL;
-		if (ops_cpu_valid(sch, cpu, "from ops.select_cpu()"))
+		if (scx_cpu_valid(sch, cpu, "from ops.select_cpu()"))
 			return cpu;
 		else
 			return prev_cpu;
@@ -8822,7 +8822,7 @@ static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	struct rq *this_rq;
 	unsigned long irq_flags;
 
-	if (!ops_cpu_valid(sch, cpu, NULL))
+	if (!scx_cpu_valid(sch, cpu, NULL))
 		return;
 
 	local_irq_save(irq_flags);
@@ -8919,7 +8919,7 @@ __bpf_kfunc s32 scx_bpf_dsq_nr_queued(u64 dsq_id, const struct bpf_prog_aux *aux
 	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
 		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
 
-		if (ops_cpu_valid(sch, cpu, NULL)) {
+		if (scx_cpu_valid(sch, cpu, NULL)) {
 			ret = READ_ONCE(cpu_rq(cpu)->scx.local_dsq.nr);
 			goto out;
 		}
@@ -9308,7 +9308,7 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu, const struct bpf_prog_aux *aux)
 	guard(rcu)();
 
 	sch = scx_prog_sched(aux);
-	if (likely(sch) && ops_cpu_valid(sch, cpu, NULL))
+	if (likely(sch) && scx_cpu_valid(sch, cpu, NULL))
 		return arch_scale_cpu_capacity(cpu);
 	else
 		return SCX_CPUPERF_ONE;
@@ -9336,7 +9336,7 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu, const struct bpf_prog_aux *aux)
 	guard(rcu)();
 
 	sch = scx_prog_sched(aux);
-	if (likely(sch) && ops_cpu_valid(sch, cpu, NULL))
+	if (likely(sch) && scx_cpu_valid(sch, cpu, NULL))
 		return arch_scale_freq_capacity(cpu);
 	else
 		return SCX_CPUPERF_ONE;
@@ -9372,7 +9372,7 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf_prog_au
 		return;
 	}
 
-	if (ops_cpu_valid(sch, cpu, NULL)) {
+	if (scx_cpu_valid(sch, cpu, NULL)) {
 		struct rq *rq = cpu_rq(cpu), *locked_rq = scx_locked_rq();
 		struct rq_flags rf;
 
@@ -9485,7 +9485,7 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu, const struct bpf_prog_aux *aux)
 	if (unlikely(!sch))
 		return NULL;
 
-	if (!ops_cpu_valid(sch, cpu, NULL))
+	if (!scx_cpu_valid(sch, cpu, NULL))
 		return NULL;
 
 	if (!sch->warned_deprecated_rq) {
@@ -9542,7 +9542,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
 	if (unlikely(!sch))
 		return NULL;
 
-	if (!ops_cpu_valid(sch, cpu, NULL))
+	if (!scx_cpu_valid(sch, cpu, NULL))
 		return NULL;
 
 	return rcu_dereference(cpu_rq(cpu)->curr);
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index f0f4d9500997..860c4634f60e 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -916,7 +916,7 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 	bool we_locked = false;
 	s32 cpu;
 
-	if (!ops_cpu_valid(sch, prev_cpu, NULL))
+	if (!scx_cpu_valid(sch, prev_cpu, NULL))
 		return -EINVAL;
 
 	if (!check_builtin_idle_enabled(sch))
@@ -989,7 +989,7 @@ __bpf_kfunc s32 scx_bpf_cpu_node(s32 cpu, const struct bpf_prog_aux *aux)
 	guard(rcu)();
 
 	sch = scx_prog_sched(aux);
-	if (unlikely(!sch) || !ops_cpu_valid(sch, cpu, NULL))
+	if (unlikely(!sch) || !scx_cpu_valid(sch, cpu, NULL))
 		return NUMA_NO_NODE;
 	return cpu_to_node(cpu);
 }
@@ -1271,7 +1271,7 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu, const struct bpf_prog_
 	if (!check_builtin_idle_enabled(sch))
 		return false;
 
-	if (!ops_cpu_valid(sch, cpu, NULL))
+	if (!scx_cpu_valid(sch, cpu, NULL))
 		return false;
 
 	return scx_idle_test_and_clear_cpu(cpu);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 26668bbce2b3..d8fb0b0b652c 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1358,6 +1358,8 @@ DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
 
 int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id);
 
+bool scx_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where);
+
 /*
  * Return the rq currently locked from an scx callback, or NULL if no rq is
  * locked.
-- 
2.54.0

