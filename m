Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9735B30100E;
	Tue, 28 Apr 2026 20:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408549; cv=none; b=gHlnKBTF6bC8tjpx6kTAwMK1nJyauRrVf+utrt5GCNj1Uv0F1qJ9bTZqldZs0kn1Sq/eYik3AkI/38tS4RJbza8P/OG99DcsCRGsyW1O6Tqbzh8XzpDgaqwoOkUZ0dWFQqIEG64I9ETfr6Bl92Q1Yh6zjBBG8bcaHcBXpgM++7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408549; c=relaxed/simple;
	bh=IOl4Qa3EppS40lTQMbO2l9qOemM2ZXNbszj7pDzBGbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhnWhtRtjQXyzer4omk5jTOxLT3zMI4GmcufNz4iHvikCpty67+NH5fF9hS5/dJ0g1/XmC5JG3YOPQHkZRn9mVHLpDpkbdAyyAUM3qufqiMehFFm8ezvJvD93KX1ZZT7Gz5iLxiFJo0GU9uSzrvgrTcBWW9gvrJbVsbBnOQN8eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoS6aaJd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoS6aaJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2805CC2BCAF;
	Tue, 28 Apr 2026 20:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408549;
	bh=IOl4Qa3EppS40lTQMbO2l9qOemM2ZXNbszj7pDzBGbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoS6aaJdYh17wBBMvZiZHRAudxln1rmJ9s0ztvbH6ONZ1XO6PgOJncN4R9mRsMctR
	 UVH4a9cNwkmA1b6ob3qs9MW15fh6LGWCgWo+IRrTh8fPhIkXFrRjJrYZI7vCGIKjMr
	 tvQOrfXloa9yQCnqeExS6KwL6T7SRrwbvQ4IYwpJAaT4cVXxJQs9DMxo6FlINWJHar
	 Xu1crcaPPzfVu9Mi6UxdIP/v29r4Ew93+anBsYrdWSOr/FxNXrP7SGUa8rKWdQqcdH
	 HH1oTg6ayjA/yDXp4eLJ/5Ejpb/IoD+d19RoWbUbB9Rts8E5Dm5p0xIntaPk8rfaUL
	 ntLxLlecdufYg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 02/17] sched_ext: Rename ops_cpu_valid() to scx_cpu_valid() and expose it
Date: Tue, 28 Apr 2026 10:35:30 -1000
Message-ID: <20260428203545.181052-3-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428203545.181052-1-tj@kernel.org>
References: <20260428203545.181052-1-tj@kernel.org>
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
---
 kernel/sched/ext.c          | 22 +++++++++++-----------
 kernel/sched/ext_idle.c     |  6 +++---
 kernel/sched/ext_internal.h |  2 ++
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 11893f00be06..980231c547ec 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1062,7 +1062,7 @@ static inline bool __cpu_valid(s32 cpu)
 }
 
 /**
- * ops_cpu_valid - Verify a cpu number, to be used on ops input args
+ * scx_cpu_valid - Verify a cpu number, to be used on ops input args
  * @sch: scx_sched to abort on error
  * @cpu: cpu number which came from a BPF ops
  * @where: extra information reported on error
@@ -1071,7 +1071,7 @@ static inline bool __cpu_valid(s32 cpu)
  * Verify that it is in range and one of the possible cpus. If invalid, trigger
  * an ops error.
  */
-static bool ops_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where)
+bool scx_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where)
 {
 	if (__cpu_valid(cpu)) {
 		return true;
@@ -1686,7 +1686,7 @@ static struct scx_dispatch_q *find_dsq_for_dispatch(struct scx_sched *sch,
 	if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
 		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
 
-		if (!ops_cpu_valid(sch, cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
+		if (!scx_cpu_valid(sch, cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
 			return find_global_dsq(sch, tcpu);
 
 		return &cpu_rq(cpu)->scx.local_dsq;
@@ -3269,7 +3269,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		this_rq()->scx.in_select_cpu = false;
 		p->scx.selected_cpu = cpu;
 		*ddsp_taskp = NULL;
-		if (ops_cpu_valid(sch, cpu, "from ops.select_cpu()"))
+		if (scx_cpu_valid(sch, cpu, "from ops.select_cpu()"))
 			return cpu;
 		else
 			return prev_cpu;
@@ -8791,7 +8791,7 @@ static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	struct rq *this_rq;
 	unsigned long irq_flags;
 
-	if (!ops_cpu_valid(sch, cpu, NULL))
+	if (!scx_cpu_valid(sch, cpu, NULL))
 		return;
 
 	local_irq_save(irq_flags);
@@ -8888,7 +8888,7 @@ __bpf_kfunc s32 scx_bpf_dsq_nr_queued(u64 dsq_id, const struct bpf_prog_aux *aux
 	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
 		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
 
-		if (ops_cpu_valid(sch, cpu, NULL)) {
+		if (scx_cpu_valid(sch, cpu, NULL)) {
 			ret = READ_ONCE(cpu_rq(cpu)->scx.local_dsq.nr);
 			goto out;
 		}
@@ -9277,7 +9277,7 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu, const struct bpf_prog_aux *aux)
 	guard(rcu)();
 
 	sch = scx_prog_sched(aux);
-	if (likely(sch) && ops_cpu_valid(sch, cpu, NULL))
+	if (likely(sch) && scx_cpu_valid(sch, cpu, NULL))
 		return arch_scale_cpu_capacity(cpu);
 	else
 		return SCX_CPUPERF_ONE;
@@ -9305,7 +9305,7 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu, const struct bpf_prog_aux *aux)
 	guard(rcu)();
 
 	sch = scx_prog_sched(aux);
-	if (likely(sch) && ops_cpu_valid(sch, cpu, NULL))
+	if (likely(sch) && scx_cpu_valid(sch, cpu, NULL))
 		return arch_scale_freq_capacity(cpu);
 	else
 		return SCX_CPUPERF_ONE;
@@ -9341,7 +9341,7 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf_prog_au
 		return;
 	}
 
-	if (ops_cpu_valid(sch, cpu, NULL)) {
+	if (scx_cpu_valid(sch, cpu, NULL)) {
 		struct rq *rq = cpu_rq(cpu), *locked_rq = scx_locked_rq();
 		struct rq_flags rf;
 
@@ -9454,7 +9454,7 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu, const struct bpf_prog_aux *aux)
 	if (unlikely(!sch))
 		return NULL;
 
-	if (!ops_cpu_valid(sch, cpu, NULL))
+	if (!scx_cpu_valid(sch, cpu, NULL))
 		return NULL;
 
 	if (!sch->warned_deprecated_rq) {
@@ -9511,7 +9511,7 @@ __bpf_kfunc struct task_struct *scx_bpf_cpu_curr(s32 cpu, const struct bpf_prog_
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
index 1b2ea6fa9fd6..f59cd58b8175 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1352,6 +1352,8 @@ DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
 
 int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id);
 
+bool scx_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where);
+
 /*
  * Return the rq currently locked from an scx callback, or NULL if no rq is
  * locked.
-- 
2.54.0

