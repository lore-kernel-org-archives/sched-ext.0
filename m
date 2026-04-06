Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E71518B0A
	for <sched-ext@lists.linux.dev>; Mon,  6 Apr 2026 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490590; cv=none; b=Cfqzus8HoDfd5pVZW8dr41DV9XtvU8GFO3qAfbFcnjXZqy+W0wwWccpY6871kbqfBBBUUA+0N41uCDy+rB8iKIlRNj4b7RwgbX5nNUDoD9fXl+t/edtGKxYVGcxZLPePAwTdjMvcr+sp6gvp9V3Rk5VYBtA7Pt7JSb2/ejQDhEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490590; c=relaxed/simple;
	bh=ZoHZENmCbRCycsVzUrMwAZi1fWTtn3WKOB6VMUPSBPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S26o7UxYPMHR/2k3GyFY9kD1f9+l+UzJH6he6NIcSOMv1RCoWfKOhOGI2Ul2oifr2WCYFnkAsEBNjqDyfW+OmFDyE6XA/huTmIE3zbK59kFiwGbOIdY2eRLjqoVAZ0/MqU6Bfui1NXFbx1wr4GcZTS9Kjj1OagTX8oTHual6mOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WB0AS9Mw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB0AS9Mw"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so3836364a91.2
        for <sched-ext@lists.linux.dev>; Mon, 06 Apr 2026 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775490588; x=1776095388; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjnJQa8GPjzvH5Zu8GQYlU6e6yP8S2uOJ3KZuzg49HA=;
        b=WB0AS9MwbOGQ9xfVevg8x3rKkG5RGr7Cb+9rxgxbA5m+tJ0yvpdgN9fe7BRK5u8E1n
         r2j56W823GM5nrEOoSn+nqKnJ+2J0KqfEUO/2kqgcpZCPDcJD869HaULtiGLfcBY81wP
         5oXTBWV51E5zCeNeiCbGC0UKOlXSdPjWVHo5pWEWKgJjc7Hk+LnF0GS8R75Qa8dmTYhu
         z1RPiWI6sz3XupaQ45c61+6RR02DG4yRppdXLM8NHuP6cBjM2XNPwxQIRwJYOuW91696
         0laL2lqurS2ZV+W+Vl+WhdYgPP6DIRT2bjVLQ89ftkDcPJyJ+0AYLNL5YxQtvnBk9GzQ
         VQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775490588; x=1776095388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pjnJQa8GPjzvH5Zu8GQYlU6e6yP8S2uOJ3KZuzg49HA=;
        b=hzZ0y3IYJbPV4npaLaI4522y7lO5ICuDiB5RCGDkpEYwZb0tuPe8KQTcwE7iwsONjd
         IzCoE+ri0IdPIqJha5x8py9DUyPjnkeR+XWL+Zepj1nIOTZYiXbLDVPS7EiHQRiXK5Nm
         XV4pSmNmAmN7eniPoarbC6DqdFI2Xoch4n34KbpHE4qtRpKWTjv33++doF31V18Ws6q0
         LdZnJNkSgyPnZYKfRV7fLsyGMegCst9AmJsibK3zhGNyhLcpxxkBF1B00FsRXFHD96Yh
         qc38QnVuHAjaOD2OEG17N/zihnjUARqFvhJQcwRA7NhaukQH2X5Z1QwOtt1ERwPDQqXN
         /j+Q==
X-Gm-Message-State: AOJu0YyKjkXrvC+e2y99/wMJXzAahMgM+3WQ2c8aU33lctYlz8lAQl1j
	e9PlH4+4RvLcAciQk5b7LPcCn2GXhxVMPNzbUy8ZmCenmu3yQUsQiO9yN1KjFg==
X-Gm-Gg: AeBDiesoXmW4s8zkKY9fRhjIlNQ/SRlJpEzCdOBiXLUNqCuAuryT9tn5WOv8z6rMUtY
	0MCbfZkHcVcc8tQAk3MOE2/ezOLYywN/khqhQLN4pjW7xxNmuAg9xbUml6jeOb7V74pF6lC8EMc
	wcxWnKU7WdrlaatnItFUEApZeJVrq74S6OAW+ip6eZFpnMhAvwobITaeOIkY3LGmugBU0auIAN+
	SPixLw0Jm15BJxRj4siFbLqhJv5YXYbx59hepvSbelqKaw6mklyzb0G0+IpZUHYiKa8Hi1bgJnx
	kVgxs9YPG6aseYmUulpt4SsnuFrzD25D0XAch8fM/4sHTRl4/WaHQAjhqBw3WEr6wIvEqqmkeeO
	rqBJfxrWjZ7Lqm33YzwL8lx8AGWnhpO+/pBUsiQrRold9A1D7vwKMxwTYwq5/09owgF0aPcA1hX
	/ywnogJchHwC6VglWiKBMrUCVLdWe2nPQsh6xsvATTdLWlhdnj8mNA1ac3sQQJlUE=
X-Received: by 2002:a17:90b:3bd0:b0:35b:e529:7089 with SMTP id 98e67ed59e1d1-35de67f0e5emr11149297a91.10.1775490588192;
        Mon, 06 Apr 2026 08:49:48 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:6100:c268:4a0b:d6d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f50e9sm14186609a91.6.2026.04.06.08.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 08:49:47 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com,
	Juntong Deng <juntong.deng@outlook.com>
Subject: [PATCH v4 1/2] sched_ext: Add verifier-time kfunc context filter
Date: Mon,  6 Apr 2026 23:48:31 +0800
Message-ID: <20260406154834.1920962-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260406154834.1920962-1-yphbchou0911@gmail.com>
References: <20260406154834.1920962-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce verifier-time kfunc context restrictions for SCX,
using the struct_ops context information in struct bpf_prog_aux.

Per-group kfunc sets are defined via SCX_KFUNCS_* macros in
ext_internal.h, keeping the per-group lookup sets and the
aggregated filtered set automatically in sync.

The groups are:
 - SELECT_CPU: ops.select_cpu() and ops.enqueue()
 - ENQUEUE_DISPATCH: ops.enqueue() and ops.dispatch()
 - DISPATCH_ONLY: ops.dispatch() (rq-locked only)
 - DISPATCH_UNLOCKED: shared by DISPATCH and UNLOCKED
 - CPU_RELEASE: ops.cpu_release()
 - UNLOCKED_ONLY: sleepable ops

scx_ops_context_flags[] maps each op to its permitted groups.

The filter handles three cases:
 - SYSCALL progs may call unlocked and select_cpu kfuncs
 - non-SCX struct_ops may call only unlocked kfuncs
 - SCX struct_ops may call whatever their op's flags allow.

The four per-group BTF set registrations are replaced by a single
scx_kfunc_set_ops_context_sensitive covering both struct_ops and
syscall program types.

Previously, __scx_bpf_select_cpu_and(), scx_bpf_select_cpu_and(), and
scx_bpf_select_cpu_dfl() were accessible from BPF_PROG_TYPE_TRACING
programs via scx_kfunc_ids_idle. These kfuncs are no longer available
to TRACING programs, as they internally call task_rq_lock() and cannot
be used safely from arbitrary tracing contexts where pi_lock state is
unknown.

Co-developed-by: Juntong Deng <juntong.deng@outlook.com>
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c          | 206 ++++++++++++++++++++++++++----------
 kernel/sched/ext_idle.c     |  13 ++-
 kernel/sched/ext_internal.h |  64 +++++++++++
 3 files changed, 227 insertions(+), 56 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b757b853b42b..525592851b5b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -613,12 +613,8 @@ static __always_inline bool scx_kf_allowed(struct scx_sched *sch, u32 mask)
 
 /* see SCX_CALL_OP_TASK() */
 static __always_inline bool scx_kf_allowed_on_arg_tasks(struct scx_sched *sch,
-							u32 mask,
 							struct task_struct *p)
 {
-	if (!scx_kf_allowed(sch, mask))
-		return false;
-
 	if (unlikely((p != current->scx.kf_tasks[0] &&
 		      p != current->scx.kf_tasks[1]))) {
 		scx_error(sch, "called on a task not being operated on");
@@ -8493,24 +8489,11 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
-BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local___v2, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
-#ifdef CONFIG_EXT_SUB_SCHED
-BTF_ID_FLAGS(func, scx_bpf_sub_dispatch, KF_IMPLICIT_ARGS)
-#endif
+SCX_KFUNCS_DISPATCH_ONLY
+SCX_KFUNCS_DISPATCH_UNLOCKED
+SCX_KFUNCS_SUB_DISPATCH
 BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
 
-static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_dispatch,
-};
-
 __bpf_kfunc_start_defs();
 
 /**
@@ -8543,14 +8526,9 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(const struct bpf_prog_aux *aux)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_cpu_release)
-BTF_ID_FLAGS(func, scx_bpf_reenqueue_local, KF_IMPLICIT_ARGS)
+SCX_KFUNCS_CPU_RELEASE
 BTF_KFUNCS_END(scx_kfunc_ids_cpu_release)
 
-static const struct btf_kfunc_id_set scx_kfunc_set_cpu_release = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_cpu_release,
-};
-
 __bpf_kfunc_start_defs();
 
 /**
@@ -8611,18 +8589,10 @@ __bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node, const struct bpf_prog_a
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_unlocked)
-BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_IMPLICIT_ARGS | KF_SLEEPABLE)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
+SCX_KFUNCS_UNLOCKED_ONLY
+SCX_KFUNCS_DISPATCH_UNLOCKED
 BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
 
-static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_unlocked,
-};
-
 __bpf_kfunc_start_defs();
 
 /**
@@ -9528,8 +9498,11 @@ __bpf_kfunc void scx_bpf_events(struct scx_event_stats *events,
  * from the scheduler's POV. SCX operations should use this function to
  * determine @p's current cgroup as, unlike following @p->cgroups,
  * @p->sched_task_group is protected by @p's rq lock and thus atomic w.r.t. all
- * rq-locked operations. Can be called on the parameter tasks of rq-locked
- * operations. The restriction guarantees that @p's rq is locked by the caller.
+ * rq-locked operations. Can be called on the parameter tasks of any task-based
+ * SCX op. The restriction guarantees that @p is one of the tasks being operated
+ * on by the current SCX callback. When the rq is not held (e.g. ops.select_cpu()
+ * called from try_to_wake_up()), @p->sched_task_group is stable under @p's
+ * pi_lock.
  */
 __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
 					       const struct bpf_prog_aux *aux)
@@ -9544,7 +9517,7 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
 	if (unlikely(!sch))
 		goto out;
 
-	if (!scx_kf_allowed_on_arg_tasks(sch, __SCX_KF_RQ_LOCKED, p))
+	if (!scx_kf_allowed_on_arg_tasks(sch, p))
 		goto out;
 
 	cgrp = tg_cgrp(tg);
@@ -9557,6 +9530,141 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
 
 __bpf_kfunc_end_defs();
 
+/*
+ * Map each SCX operation to its allowed kfunc groups. Indexed by
+ * SCX_MOFF_IDX(offsetof(struct sched_ext_ops, op)).
+ */
+const u32 scx_ops_context_flags[] = {
+	[SCX_OP_IDX(select_cpu)]		= SCX_OPS_KF_SELECT_CPU | SCX_OPS_KF_ENQUEUE,
+	[SCX_OP_IDX(enqueue)]			= SCX_OPS_KF_ENQUEUE | SCX_OPS_KF_SELECT_CPU,
+	[SCX_OP_IDX(dequeue)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(dispatch)]			= SCX_OPS_KF_DISPATCH | SCX_OPS_KF_ENQUEUE,
+	[SCX_OP_IDX(tick)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(runnable)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(running)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(stopping)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(quiescent)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(yield)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(core_sched_before)]		= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(set_weight)]		= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(set_cpumask)]		= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(update_idle)]		= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(cpu_acquire)]		= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(cpu_release)]		= SCX_OPS_KF_CPU_RELEASE,
+	[SCX_OP_IDX(init_task)]			= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(exit_task)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(enable)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(disable)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(dump)]			= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(dump_cpu)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(dump_task)]			= SCX_OPS_KF_ANY,
+#ifdef CONFIG_EXT_GROUP_SCHED
+	[SCX_OP_IDX(cgroup_init)]		= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(cgroup_exit)]		= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(cgroup_prep_move)]		= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(cgroup_move)]		= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(cgroup_cancel_move)]	= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(cgroup_set_weight)]		= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(cgroup_set_bandwidth)]	= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(cgroup_set_idle)]		= SCX_OPS_KF_UNLOCKED,
+#endif	/* CONFIG_EXT_GROUP_SCHED */
+	[SCX_OP_IDX(sub_attach)]		= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(sub_detach)]		= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(cpu_online)]		= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(cpu_offline)]		= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(init)]			= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(exit)]			= SCX_OPS_KF_UNLOCKED,
+};
+
+/*
+ * Aggregated set of all context-sensitive kfuncs. Each kfunc appears exactly
+ * once; the shared macros from ext_internal.h keep this in sync with the
+ * per-group sets used for lookup in the filter below.
+ */
+BTF_KFUNCS_START(scx_kfunc_ids_ops_context_sensitive)
+SCX_KFUNCS_SELECT_CPU
+SCX_KFUNCS_ENQUEUE_DISPATCH
+SCX_KFUNCS_DISPATCH_ONLY
+SCX_KFUNCS_SUB_DISPATCH
+SCX_KFUNCS_CPU_RELEASE
+SCX_KFUNCS_UNLOCKED_ONLY
+SCX_KFUNCS_DISPATCH_UNLOCKED
+BTF_KFUNCS_END(scx_kfunc_ids_ops_context_sensitive)
+
+static int scx_kfunc_ids_ops_context_sensitive_filter(const struct bpf_prog *prog,
+						      u32 kfunc_id)
+{
+	u32 moff, flags;
+
+	if (!btf_id_set8_contains(&scx_kfunc_ids_ops_context_sensitive, kfunc_id))
+		return 0;
+
+	/*
+	 * Allow unlocked kfuncs (both sleepable UNLOCKED_ONLY and non-sleepable
+	 * DISPATCH_UNLOCKED) and select_cpu kfuncs from syscall prog type
+	 * (e.g. BPF test_run() call). None of these require the rq lock.
+	 */
+	if (prog->type == BPF_PROG_TYPE_SYSCALL &&
+	    (btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id) ||
+	     btf_id_set8_contains(&scx_kfunc_ids_select_cpu, kfunc_id)))
+		return 0;
+
+	/*
+	 * add_subprog_and_kfunc() collects all kfunc calls, including dead
+	 * code guarded by bpf_ksym_exists(), before check_attach_btf_id()
+	 * sets prog->aux->st_ops. Allow all kfuncs when st_ops is not yet
+	 * set; do_check_main() re-runs the filter with st_ops set and
+	 * enforces the actual restrictions.
+	 */
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS && !prog->aux->st_ops)
+		return 0;
+
+	/*
+	 * Non-SCX struct_ops: only allow unlocked kfuncs. All other
+	 * context-sensitive kfuncs assume the rq lock is held, which wouldn't
+	 * be true for other struct_ops implementations.
+	 */
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
+	    prog->aux->st_ops != &bpf_sched_ext_ops)
+		return btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id) ?
+		       0 : -EACCES;
+
+	/* SCX struct_ops: check which kfunc groups are allowed for this op */
+	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+		return -EACCES;
+
+	moff = prog->aux->attach_st_ops_member_off;
+	flags = scx_ops_context_flags[SCX_MOFF_IDX(moff)];
+
+	if ((flags & SCX_OPS_KF_UNLOCKED) &&
+	    btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
+		return 0;
+
+	if ((flags & SCX_OPS_KF_CPU_RELEASE) &&
+	    btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id))
+		return 0;
+
+	if ((flags & SCX_OPS_KF_DISPATCH) &&
+	    btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id))
+		return 0;
+
+	if ((flags & SCX_OPS_KF_ENQUEUE) &&
+	    btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_id))
+		return 0;
+
+	if ((flags & SCX_OPS_KF_SELECT_CPU) &&
+	    btf_id_set8_contains(&scx_kfunc_ids_select_cpu, kfunc_id))
+		return 0;
+
+	return -EACCES;
+}
+
+static const struct btf_kfunc_id_set scx_kfunc_set_ops_context_sensitive = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_ops_context_sensitive,
+	.filter			= scx_kfunc_ids_ops_context_sensitive_filter,
+};
+
 BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
@@ -9605,23 +9713,15 @@ static int __init scx_init(void)
 	 * kfunc registration can't be done from init_sched_ext_class() as
 	 * register_btf_kfunc_id_set() needs most of the system to be up.
 	 *
-	 * Some kfuncs are context-sensitive and can only be called from
-	 * specific SCX ops. They are grouped into BTF sets accordingly.
-	 * Unfortunately, BPF currently doesn't have a way of enforcing such
-	 * restrictions. Eventually, the verifier should be able to enforce
-	 * them. For now, register them the same and make each kfunc explicitly
-	 * check using scx_kf_allowed().
+	 * Context-sensitive kfuncs are grouped and filtered via
+	 * scx_kfunc_set_ops_context_sensitive, which uses the BPF verifier's
+	 * struct_ops context information to enforce per-op restrictions at
+	 * load time instead of via runtime checks.
 	 */
 	if ((ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_enqueue_dispatch)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_dispatch)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_cpu_release)) ||
-	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					     &scx_kfunc_set_unlocked)) ||
+					     &scx_kfunc_set_ops_context_sensitive)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
-					     &scx_kfunc_set_unlocked)) ||
+					     &scx_kfunc_set_ops_context_sensitive)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_any)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index ecf7e09b54ae..8f9f3d33c223 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -1469,11 +1469,18 @@ BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu_node, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_IMPLICIT_ARGS | KF_RCU)
-BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_IMPLICIT_ARGS | KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_IMPLICIT_ARGS | KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_idle)
 
+/*
+ * select_cpu kfuncs are context-sensitive: they can only be called from
+ * ops.select_cpu(), ops.enqueue(), or an unlocked context (e.g. BPF
+ * test_run() call). They are filtered by scx_kfunc_set_ops_context_sensitive
+ * in ext.c; this set is used only for grouping / lookup in the filter.
+ */
+BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
+SCX_KFUNCS_SELECT_CPU
+BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
+
 static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_idle,
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b4f36d8b9c1d..71c59bf1258b 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -6,6 +6,70 @@
  * Copyright (c) 2025 Tejun Heo <tj@kernel.org>
  */
 #define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
+#define SCX_MOFF_IDX(moff)	((moff) / sizeof(void (*)(void)))
+
+/* Each flag corresponds to a btf kfunc id set */
+enum scx_ops_kf_flags {
+	SCX_OPS_KF_ANY			= 0,
+	SCX_OPS_KF_UNLOCKED		= 1 << 0,
+	SCX_OPS_KF_CPU_RELEASE		= 1 << 1,
+	SCX_OPS_KF_DISPATCH		= 1 << 2,
+	SCX_OPS_KF_ENQUEUE		= 1 << 3,
+	SCX_OPS_KF_SELECT_CPU		= 1 << 4,
+};
+
+/*
+ * Per-op allowed kfunc groups, indexed by SCX_OP_IDX(). Declared here so it
+ * can be referenced from ext_idle.c via extern.
+ */
+extern const u32 scx_ops_context_flags[];
+
+/*
+ * Macros listing context-sensitive kfuncs by group. Used to define both the
+ * per-group BTF sets (for lookup in the filter) and the aggregated
+ * scx_kfunc_ids_ops_context_sensitive set (which the filter is attached to).
+ * Keeping them in sync via macros avoids error-prone manual repetition.
+ *
+ * SCX_KFUNCS_DISPATCH_UNLOCKED covers kfuncs that appear in BOTH
+ * scx_kfunc_ids_dispatch and scx_kfunc_ids_unlocked.
+ */
+#define SCX_KFUNCS_SELECT_CPU							\
+	BTF_ID_FLAGS(func, __scx_bpf_select_cpu_and, KF_IMPLICIT_ARGS | KF_RCU)	\
+	BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)			\
+	BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_IMPLICIT_ARGS | KF_RCU)
+
+#define SCX_KFUNCS_ENQUEUE_DISPATCH						\
+	BTF_ID_FLAGS(func, scx_bpf_dsq_insert, KF_IMPLICIT_ARGS | KF_RCU)	\
+	BTF_ID_FLAGS(func, scx_bpf_dsq_insert___v2, KF_IMPLICIT_ARGS | KF_RCU)	\
+	BTF_ID_FLAGS(func, scx_bpf_dsq_insert_vtime, KF_RCU)			\
+	BTF_ID_FLAGS(func, __scx_bpf_dsq_insert_vtime, KF_IMPLICIT_ARGS | KF_RCU)
+
+#define SCX_KFUNCS_DISPATCH_ONLY						\
+	BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots, KF_IMPLICIT_ARGS)		\
+	BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel, KF_IMPLICIT_ARGS)		\
+	BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local, KF_IMPLICIT_ARGS)		\
+	BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local___v2, KF_IMPLICIT_ARGS)
+
+#define SCX_KFUNCS_DISPATCH_UNLOCKED						\
+	BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)			\
+	BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)			\
+	BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)				\
+	BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
+
+#define SCX_KFUNCS_CPU_RELEASE							\
+	BTF_ID_FLAGS(func, scx_bpf_reenqueue_local, KF_IMPLICIT_ARGS)
+
+#ifdef CONFIG_EXT_SUB_SCHED
+#define SCX_KFUNCS_SUB_DISPATCH							\
+	BTF_ID_FLAGS(func, scx_bpf_sub_dispatch, KF_IMPLICIT_ARGS)
+#else
+#define SCX_KFUNCS_SUB_DISPATCH
+#endif
+
+#define SCX_KFUNCS_UNLOCKED_ONLY						\
+	BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_IMPLICIT_ARGS | KF_SLEEPABLE)
+
+extern struct btf_id_set8 scx_kfunc_ids_select_cpu;
 
 enum scx_consts {
 	SCX_DSP_DFL_MAX_BATCH		= 32,
-- 
2.48.1

