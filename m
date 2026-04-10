Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903B38945D;
	Fri, 10 Apr 2026 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802655; cv=none; b=JOwGsREsIte6EUYUtTlhap1v5/4XOgABolIKDrlw4gX1E7BYezlCl+OOIy5h2wAmfnZLsMY3k/QzT3zt8zPJtPDu9kMMIzULAgzI9+WVyStdUhEAG3xpubcXmiDAOYqPJ6aTZYRvK+yvZ9QoQYX2AbNTqvEq9vG2ccvEMGI8kEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802655; c=relaxed/simple;
	bh=9vSBY+enlAtW5Cio64IZAWkGOIGbaEMccNJk8lZRGXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwVE5bL5mtPYApHv+8C2tKIbXCaLXfiZeTotyLArsI0J4I3+5+nXueHvfxG5qZYLDWTUQFOXTN2KKpsubFmHr/mIFbAEOuyUhDxOAQoQ0Y2vEwehUym73RcxYrYs53Z8m16bWXLYkbZbsbWY+EEt/R62MfFQeBbmtFShLfSgJ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVHaWuxn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVHaWuxn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B43DC19424;
	Fri, 10 Apr 2026 06:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775802655;
	bh=9vSBY+enlAtW5Cio64IZAWkGOIGbaEMccNJk8lZRGXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVHaWuxn/JKpUAU4QcfqeVtJB14/tLcsiMBsjsPOdyHDlm/Ql2xgIigNuiSGLZLcq
	 q5JFk2hVEsSKjzaoONY4g0XPoCldwsr3c7HAZLTaTBCC06MhwpbYPbJu9n/giLMdWr
	 40Y8d6yR+o4HJGgXHbkUMUnPOtiGTm3WTR/hWxLBWkNw57fk/QfBbyCK17s/m4tBOl
	 4zlkS6MIAkHbzkbykm3TfjuvV7bIEGfNfD9cTbnB7nyrHoHp1yxHtCtJu5nwNXNGgs
	 u8IBmqnezk6Ia0qkKnR7nudxf/dKTNS8Yu8gMhCvx6ma8/Qa7OD1mEZtxSwt3NWDPN
	 XDSrQkPE8dUIg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/10] sched_ext: Add verifier-time kfunc context filter
Date: Thu,  9 Apr 2026 20:30:43 -1000
Message-ID: <20260410063046.3556100-8-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410063046.3556100-1-tj@kernel.org>
References: <20260410063046.3556100-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move enforcement of SCX context-sensitive kfunc restrictions from per-task
runtime kf_mask checks to BPF verifier-time filtering, using the BPF core's
struct_ops context information.

A shared .filter callback is attached to each context-sensitive BTF set
and consults a per-op allow table (scx_kf_allow_flags[]) indexed by SCX
ops member offset. Disallowed calls are now rejected at program load time
instead of at runtime.

The old model split reachability across two places: each SCX_CALL_OP*()
set bits naming its op context, and each kfunc's scx_kf_allowed() check
OR'd together the bits it accepted. A kfunc was callable when those two
masks overlapped. The new model transposes the result to the caller side -
each op's allow flags directly list the kfunc groups it may call. The old
bit assignments were:

  Call-site bits:
    ops.select_cpu   = ENQUEUE | SELECT_CPU
    ops.enqueue      = ENQUEUE
    ops.dispatch     = DISPATCH
    ops.cpu_release  = CPU_RELEASE

  Kfunc-group accepted bits:
    enqueue group     = ENQUEUE | DISPATCH
    select_cpu group  = SELECT_CPU | ENQUEUE
    dispatch group    = DISPATCH
    cpu_release group = CPU_RELEASE

Intersecting them yields the reachability now expressed directly by
scx_kf_allow_flags[]:

  ops.select_cpu  -> SELECT_CPU | ENQUEUE
  ops.enqueue     -> SELECT_CPU | ENQUEUE
  ops.dispatch    -> ENQUEUE | DISPATCH
  ops.cpu_release -> CPU_RELEASE

Unlocked ops carried no kf_mask bits and reached only unlocked kfuncs;
that maps directly to UNLOCKED in the new table.

Equivalence was checked by walking every (op, kfunc-group) combination
across SCX ops, SYSCALL, and non-SCX struct_ops callers against the old
scx_kf_allowed() runtime checks. With two intended exceptions (see below),
all combinations reach the same verdict; disallowed calls are now caught at
load time instead of firing scx_error() at runtime.

scx_bpf_dsq_move_set_slice() and scx_bpf_dsq_move_set_vtime() are
exceptions: they have no runtime check at all, but the new filter rejects
them from ops outside dispatch/unlocked. The affected cases are nonsensical
- the values these setters store are only read by
scx_bpf_dsq_move{,_vtime}(), which is itself restricted to
dispatch/unlocked, so a setter call from anywhere else was already dead
code.

Runtime scx_kf_mask enforcement is left in place by this patch and removed
in a follow-up.

Original-patch-by: Juntong Deng <juntong.deng@outlook.com>
Original-patch-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 124 ++++++++++++++++++++++++++++++++++--
 kernel/sched/ext_idle.c     |   1 +
 kernel/sched/ext_idle.h     |   2 +
 kernel/sched/ext_internal.h |   3 +
 4 files changed, 125 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6d7c5c2605c7..81a4fea4c6b6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8133,6 +8133,7 @@ BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
 static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_enqueue_dispatch,
+	.filter			= scx_kfunc_context_filter,
 };
 
 static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
@@ -8511,6 +8512,7 @@ BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
 static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_dispatch,
+	.filter			= scx_kfunc_context_filter,
 };
 
 __bpf_kfunc_start_defs();
@@ -8551,6 +8553,7 @@ BTF_KFUNCS_END(scx_kfunc_ids_cpu_release)
 static const struct btf_kfunc_id_set scx_kfunc_set_cpu_release = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_cpu_release,
+	.filter			= scx_kfunc_context_filter,
 };
 
 __bpf_kfunc_start_defs();
@@ -8628,6 +8631,7 @@ BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
 static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_unlocked,
+	.filter			= scx_kfunc_context_filter,
 };
 
 __bpf_kfunc_start_defs();
@@ -9603,6 +9607,115 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
 	.set			= &scx_kfunc_ids_any,
 };
 
+/*
+ * Per-op kfunc allow flags. Each bit corresponds to a context-sensitive kfunc
+ * group; an op may permit zero or more groups, with the union expressed in
+ * scx_kf_allow_flags[]. The verifier-time filter (scx_kfunc_context_filter())
+ * consults this table to decide whether a context-sensitive kfunc is callable
+ * from a given SCX op.
+ */
+enum scx_kf_allow_flags {
+	SCX_KF_ALLOW_UNLOCKED		= 1 << 0,
+	SCX_KF_ALLOW_CPU_RELEASE	= 1 << 1,
+	SCX_KF_ALLOW_DISPATCH		= 1 << 2,
+	SCX_KF_ALLOW_ENQUEUE		= 1 << 3,
+	SCX_KF_ALLOW_SELECT_CPU		= 1 << 4,
+};
+
+/*
+ * Map each SCX op to the union of kfunc groups it permits, indexed by
+ * SCX_OP_IDX(op). Ops not listed only permit kfuncs that are not
+ * context-sensitive.
+ */
+static const u32 scx_kf_allow_flags[] = {
+	[SCX_OP_IDX(select_cpu)]	= SCX_KF_ALLOW_SELECT_CPU | SCX_KF_ALLOW_ENQUEUE,
+	[SCX_OP_IDX(enqueue)]		= SCX_KF_ALLOW_SELECT_CPU | SCX_KF_ALLOW_ENQUEUE,
+	[SCX_OP_IDX(dispatch)]		= SCX_KF_ALLOW_ENQUEUE | SCX_KF_ALLOW_DISPATCH,
+	[SCX_OP_IDX(cpu_release)]	= SCX_KF_ALLOW_CPU_RELEASE,
+	[SCX_OP_IDX(init_task)]		= SCX_KF_ALLOW_UNLOCKED,
+	[SCX_OP_IDX(dump)]		= SCX_KF_ALLOW_UNLOCKED,
+#ifdef CONFIG_EXT_GROUP_SCHED
+	[SCX_OP_IDX(cgroup_init)]	= SCX_KF_ALLOW_UNLOCKED,
+	[SCX_OP_IDX(cgroup_exit)]	= SCX_KF_ALLOW_UNLOCKED,
+	[SCX_OP_IDX(cgroup_prep_move)]	= SCX_KF_ALLOW_UNLOCKED,
+	[SCX_OP_IDX(cgroup_cancel_move)] = SCX_KF_ALLOW_UNLOCKED,
+	[SCX_OP_IDX(cgroup_set_weight)]	= SCX_KF_ALLOW_UNLOCKED,
+	[SCX_OP_IDX(cgroup_set_bandwidth)] = SCX_KF_ALLOW_UNLOCKED,
+	[SCX_OP_IDX(cgroup_set_idle)]	= SCX_KF_ALLOW_UNLOCKED,
+#endif	/* CONFIG_EXT_GROUP_SCHED */
+	[SCX_OP_IDX(sub_attach)]	= SCX_KF_ALLOW_UNLOCKED,
+	[SCX_OP_IDX(sub_detach)]	= SCX_KF_ALLOW_UNLOCKED,
+	[SCX_OP_IDX(cpu_online)]	= SCX_KF_ALLOW_UNLOCKED,
+	[SCX_OP_IDX(cpu_offline)]	= SCX_KF_ALLOW_UNLOCKED,
+	[SCX_OP_IDX(init)]		= SCX_KF_ALLOW_UNLOCKED,
+	[SCX_OP_IDX(exit)]		= SCX_KF_ALLOW_UNLOCKED,
+};
+
+/*
+ * Verifier-time filter for context-sensitive SCX kfuncs. Registered via the
+ * .filter field on each per-group btf_kfunc_id_set. The BPF core invokes this
+ * for every kfunc call in the registered hook (BPF_PROG_TYPE_STRUCT_OPS or
+ * BPF_PROG_TYPE_SYSCALL), regardless of which set originally introduced the
+ * kfunc - so the filter must short-circuit on kfuncs it doesn't govern (e.g.
+ * scx_kfunc_ids_any) by falling through to "allow" when none of the
+ * context-sensitive sets contain the kfunc.
+ */
+int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	bool in_unlocked = btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id);
+	bool in_select_cpu = btf_id_set8_contains(&scx_kfunc_ids_select_cpu, kfunc_id);
+	bool in_enqueue = btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_id);
+	bool in_dispatch = btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id);
+	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
+	u32 moff, flags;
+
+	/* Not a context-sensitive kfunc (e.g. from scx_kfunc_ids_any) - allow. */
+	if (!(in_unlocked || in_select_cpu || in_enqueue || in_dispatch || in_cpu_release))
+		return 0;
+
+	/* SYSCALL progs (e.g. BPF test_run()) may call unlocked and select_cpu kfuncs. */
+	if (prog->type == BPF_PROG_TYPE_SYSCALL)
+		return (in_unlocked || in_select_cpu) ? 0 : -EACCES;
+
+	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+		return -EACCES;
+
+	/*
+	 * add_subprog_and_kfunc() collects all kfunc calls, including dead code
+	 * guarded by bpf_ksym_exists(), before check_attach_btf_id() sets
+	 * prog->aux->st_ops. Allow all kfuncs when st_ops is not yet set;
+	 * do_check_main() re-runs the filter with st_ops set and enforces the
+	 * actual restrictions.
+	 */
+	if (!prog->aux->st_ops)
+		return 0;
+
+	/*
+	 * Non-SCX struct_ops: only unlocked kfuncs are safe. The other
+	 * context-sensitive kfuncs assume the rq lock is held by the SCX
+	 * dispatch path, which doesn't apply to other struct_ops users.
+	 */
+	if (prog->aux->st_ops != &bpf_sched_ext_ops)
+		return in_unlocked ? 0 : -EACCES;
+
+	/* SCX struct_ops: check the per-op allow list. */
+	moff = prog->aux->attach_st_ops_member_off;
+	flags = scx_kf_allow_flags[SCX_MOFF_IDX(moff)];
+
+	if ((flags & SCX_KF_ALLOW_UNLOCKED) && in_unlocked)
+		return 0;
+	if ((flags & SCX_KF_ALLOW_CPU_RELEASE) && in_cpu_release)
+		return 0;
+	if ((flags & SCX_KF_ALLOW_DISPATCH) && in_dispatch)
+		return 0;
+	if ((flags & SCX_KF_ALLOW_ENQUEUE) && in_enqueue)
+		return 0;
+	if ((flags & SCX_KF_ALLOW_SELECT_CPU) && in_select_cpu)
+		return 0;
+
+	return -EACCES;
+}
+
 static int __init scx_init(void)
 {
 	int ret;
@@ -9612,11 +9725,12 @@ static int __init scx_init(void)
 	 * register_btf_kfunc_id_set() needs most of the system to be up.
 	 *
 	 * Some kfuncs are context-sensitive and can only be called from
-	 * specific SCX ops. They are grouped into BTF sets accordingly.
-	 * Unfortunately, BPF currently doesn't have a way of enforcing such
-	 * restrictions. Eventually, the verifier should be able to enforce
-	 * them. For now, register them the same and make each kfunc explicitly
-	 * check using scx_kf_allowed().
+	 * specific SCX ops. They are grouped into per-context BTF sets, each
+	 * registered with scx_kfunc_context_filter as its .filter callback. The
+	 * BPF core dedups identical filter pointers per hook
+	 * (btf_populate_kfunc_set()), so the filter is invoked exactly once per
+	 * kfunc lookup; it consults scx_kf_allow_flags[] to enforce per-op
+	 * restrictions at verify time.
 	 */
 	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_enqueue_dispatch)) ||
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index f99ceeba2e56..ec49e0c9892e 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -1491,6 +1491,7 @@ BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
 static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_select_cpu,
+	.filter			= scx_kfunc_context_filter,
 };
 
 int scx_idle_init(void)
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index fa583f141f35..dc35f850481e 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -12,6 +12,8 @@
 
 struct sched_ext_ops;
 
+extern struct btf_id_set8 scx_kfunc_ids_select_cpu;
+
 void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops);
 void scx_idle_init_masks(void);
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 54da08a223b7..62ce4eaf6a3f 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -6,6 +6,7 @@
  * Copyright (c) 2025 Tejun Heo <tj@kernel.org>
  */
 #define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
+#define SCX_MOFF_IDX(moff)	((moff) / sizeof(void (*)(void)))
 
 enum scx_consts {
 	SCX_DSP_DFL_MAX_BATCH		= 32,
@@ -1363,6 +1364,8 @@ enum scx_ops_state {
 extern struct scx_sched __rcu *scx_root;
 DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
 
+int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id);
+
 /*
  * Return the rq currently locked from an scx callback, or NULL if no rq is
  * locked.
-- 
2.53.0

