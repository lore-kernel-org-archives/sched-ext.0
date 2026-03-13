Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC79175A8F;
	Fri, 13 Mar 2026 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401484; cv=none; b=bDVgcGi4F4crfTKcJLD3TiQW7d5iOoZDl2V8/y85MF+QGEgr6K2ZgmCBwTU3qGyS9R9TONzRiosn5dmhXW+AqnKa7y6l3y/Ravfia2hH5nhtQfOUYbIFiG7VpfcoxBDu/BXAk7KmfWNGMlMQDMh0hQnfazm1UslbHtBUAHexnT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401484; c=relaxed/simple;
	bh=Byjea9nUwjzOQGFNv354O5RpX9A3T7knN0wa58UPY4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgHLSqyZBdvNyOGtwWmMciMH05tQdKSs7+FByCKy8Ucy7oBp7lsxnlXxSiGpOd8gQt1BcuatpITKyFr4OWKZTJgefmiAiDraG4ignHo65som2mVsuvvjwI52xxEKn+melfaTHctNA/7yx0pyS3L7O5qIGqg7hhUPKqNlA/GB2EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll7ZJlOz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll7ZJlOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CFBC19424;
	Fri, 13 Mar 2026 11:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773401481;
	bh=Byjea9nUwjzOQGFNv354O5RpX9A3T7knN0wa58UPY4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ll7ZJlOzH/fAiuDHMq/WJ+IpdtL+XV8bPqCnqzmDuCzNgf6e2PktTVNjXZt/juwU7
	 aBKLH6ABIMZNyyqNK2Yo7dZqcIhj6MRf9SDlx2ghLLpTh8pAuU1sCQaTVQ/ZNs+bJx
	 YeGaTgVne72RwiGTm7FU34j5wHfg4s5BA9PgVqhSiz9DLLG9XitCulKmq21wWrN7Jr
	 /mML+vtT9T3okp88hbPz3Mkp52H7I9JVCuaWqrH10oHxzqEJv8d9vvXE1reuDvklrO
	 Ld3xoKQqN3D9KbrTpO47tm4ngcGGFLVaKqRYXBTd+uAmN7klmEaAXUjbF1yksaClpF
	 IKFlwLrqnPpkg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] sched_ext: Add SCX_OPS_ALWAYS_ENQ_IMMED ops flag
Date: Fri, 13 Mar 2026 01:31:14 -1000
Message-ID: <20260313113114.1591010-7-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313113114.1591010-1-tj@kernel.org>
References: <20260313113114.1591010-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCX_ENQ_IMMED makes enqueue to local DSQs succeed only if the task can start
running immediately. Otherwise, the task is re-enqueued through ops.enqueue().
This provides tighter control but requires specifying the flag on every
insertion.

Add SCX_OPS_ALWAYS_ENQ_IMMED ops flag. When set, SCX_ENQ_IMMED is
automatically applied to all local DSQ enqueues including through
scx_bpf_dsq_move_to_local().

scx_qmap is updated with -I option to test the feature and -F option for
IMMED stress testing which forces every Nth enqueue to a busy local DSQ.

v2: - Cover scx_bpf_dsq_move_to_local() path (now has enq_flags via ___v2).
    - scx_qmap: Remove sched_switch and cpu_release handlers (superseded by
      kernel-side wakeup_preempt_scx()). Add -F for IMMED stress testing.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c                   | 31 +++++++------
 kernel/sched/ext_internal.h          |  9 +++-
 tools/sched_ext/include/scx/compat.h |  1 +
 tools/sched_ext/scx_qmap.bpf.c       | 66 ++++++++++++----------------
 tools/sched_ext/scx_qmap.c           | 13 +++++-
 5 files changed, 65 insertions(+), 55 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 553730836000..f7def0c57b51 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7755,20 +7755,25 @@ void __init init_sched_ext_class(void)
 /********************************************************************************
  * Helpers that can be called from the BPF scheduler.
  */
-static bool scx_vet_enq_flags(struct scx_sched *sch, u64 dsq_id, u64 enq_flags)
+static bool scx_vet_enq_flags(struct scx_sched *sch, u64 dsq_id, u64 *enq_flags)
 {
-	if ((enq_flags & SCX_ENQ_IMMED) &&
-	    unlikely(dsq_id != SCX_DSQ_LOCAL &&
-		     (dsq_id & SCX_DSQ_LOCAL_ON) != SCX_DSQ_LOCAL_ON)) {
-		scx_error(sch, "SCX_ENQ_IMMED on a non-local DSQ 0x%llx", dsq_id);
-		return false;
+	bool is_local = dsq_id == SCX_DSQ_LOCAL ||
+		(dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON;
+
+	if (*enq_flags & SCX_ENQ_IMMED) {
+		if (unlikely(!is_local)) {
+			scx_error(sch, "SCX_ENQ_IMMED on a non-local DSQ 0x%llx", dsq_id);
+			return false;
+		}
+	} else if ((sch->ops.flags & SCX_OPS_ALWAYS_ENQ_IMMED) && is_local) {
+		*enq_flags |= SCX_ENQ_IMMED;
 	}
 
 	return true;
 }
 
 static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p,
-				    u64 dsq_id, u64 enq_flags)
+				    u64 dsq_id, u64 *enq_flags)
 {
 	if (!scx_kf_allowed(sch, SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
 		return false;
@@ -7780,8 +7785,8 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
 		return false;
 	}
 
-	if (unlikely(enq_flags & __SCX_ENQ_INTERNAL_MASK)) {
-		scx_error(sch, "invalid enq_flags 0x%llx", enq_flags);
+	if (unlikely(*enq_flags & __SCX_ENQ_INTERNAL_MASK)) {
+		scx_error(sch, "invalid enq_flags 0x%llx", *enq_flags);
 		return false;
 	}
 
@@ -7875,7 +7880,7 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
 	if (unlikely(!sch))
 		return false;
 
-	if (!scx_dsq_insert_preamble(sch, p, dsq_id, enq_flags))
+	if (!scx_dsq_insert_preamble(sch, p, dsq_id, &enq_flags))
 		return false;
 
 	if (slice)
@@ -7901,7 +7906,7 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id,
 static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
 				 u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags)
 {
-	if (!scx_dsq_insert_preamble(sch, p, dsq_id, enq_flags))
+	if (!scx_dsq_insert_preamble(sch, p, dsq_id, &enq_flags))
 		return false;
 
 	if (slice)
@@ -8028,7 +8033,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
 
-	if (!scx_vet_enq_flags(sch, dsq_id, enq_flags))
+	if (!scx_vet_enq_flags(sch, dsq_id, &enq_flags))
 		return false;
 
 	/*
@@ -8189,7 +8194,7 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local___v2(u64 dsq_id, u64 enq_flags,
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
 
-	if (!scx_vet_enq_flags(sch, SCX_DSQ_LOCAL, enq_flags))
+	if (!scx_vet_enq_flags(sch, SCX_DSQ_LOCAL, &enq_flags))
 		return false;
 
 	dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 2ef855f7c861..b4f36d8b9c1d 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -182,13 +182,20 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_BUILTIN_IDLE_PER_NODE	= 1LLU << 6,
 
+	/*
+	 * If set, %SCX_ENQ_IMMED is assumed to be set on all local DSQ
+	 * enqueues.
+	 */
+	SCX_OPS_ALWAYS_ENQ_IMMED	= 1LLU << 7,
+
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
 					  SCX_OPS_ENQ_MIGRATION_DISABLED |
 					  SCX_OPS_ALLOW_QUEUED_WAKEUP |
 					  SCX_OPS_SWITCH_PARTIAL |
-					  SCX_OPS_BUILTIN_IDLE_PER_NODE,
+					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
+					  SCX_OPS_ALWAYS_ENQ_IMMED,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 50297d4b9533..9e0c8f3161e8 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -116,6 +116,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_ENQ_MIGRATION_DISABLED SCX_OPS_FLAG(SCX_OPS_ENQ_MIGRATION_DISABLED)
 #define SCX_OPS_ALLOW_QUEUED_WAKEUP SCX_OPS_FLAG(SCX_OPS_ALLOW_QUEUED_WAKEUP)
 #define SCX_OPS_BUILTIN_IDLE_PER_NODE SCX_OPS_FLAG(SCX_OPS_BUILTIN_IDLE_PER_NODE)
+#define SCX_OPS_ALWAYS_ENQ_IMMED SCX_OPS_FLAG(SCX_OPS_ALWAYS_ENQ_IMMED)
 
 #define SCX_PICK_IDLE_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", #name)
 
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 6d34115cb8bd..f3587fb709c9 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -11,8 +11,6 @@
  *
  * - BPF-side queueing using PIDs.
  * - Sleepable per-task storage allocation using ops.prep_enable().
- * - Using ops.cpu_release() to handle a higher priority scheduling class taking
- *   the CPU away.
  * - Core-sched support.
  *
  * This scheduler is primarily for demonstration and testing of sched_ext
@@ -47,6 +45,8 @@ const volatile bool print_msgs;
 const volatile u64 sub_cgroup_id;
 const volatile s32 disallow_tgid;
 const volatile bool suppress_dump;
+const volatile bool always_enq_immed;
+const volatile u32 immed_stress_nth;
 
 u64 nr_highpri_queued;
 u32 test_error_cnt;
@@ -144,8 +144,10 @@ static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu)
 {
 	s32 cpu;
 
-	if (p->nr_cpus_allowed == 1 ||
-	    scx_bpf_test_and_clear_cpu_idle(prev_cpu))
+	if (!always_enq_immed && p->nr_cpus_allowed == 1)
+		return prev_cpu;
+
+	if (scx_bpf_test_and_clear_cpu_idle(prev_cpu))
 		return prev_cpu;
 
 	cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
@@ -238,6 +240,22 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 */
 	tctx->core_sched_seq = core_sched_tail_seqs[idx]++;
 
+	/*
+	 * IMMED stress testing: Every immed_stress_nth'th enqueue, dispatch
+	 * directly to prev_cpu's local DSQ even when busy to force dsq->nr > 1
+	 * and exercise the kernel IMMED reenqueue trigger paths.
+	 */
+	if (immed_stress_nth && !(enq_flags & SCX_ENQ_REENQ)) {
+		static u32 immed_stress_cnt;
+
+		if (!(++immed_stress_cnt % immed_stress_nth)) {
+			tctx->force_local = false;
+			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | scx_bpf_task_cpu(p),
+					   slice_ns, enq_flags);
+			return;
+		}
+	}
+
 	/*
 	 * If qmap_select_cpu() is telling us to or this is the last runnable
 	 * task on the CPU, enqueue locally.
@@ -558,40 +576,11 @@ bool BPF_STRUCT_OPS(qmap_core_sched_before,
 	return task_qdist(a) > task_qdist(b);
 }
 
-SEC("tp_btf/sched_switch")
-int BPF_PROG(qmap_sched_switch, bool preempt, struct task_struct *prev,
-	     struct task_struct *next, unsigned long prev_state)
-{
-	if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
-		return 0;
-
-	/*
-	 * If @cpu is taken by a higher priority scheduling class, it is no
-	 * longer available for executing sched_ext tasks. As we don't want the
-	 * tasks in @cpu's local dsq to sit there until @cpu becomes available
-	 * again, re-enqueue them into the global dsq. See %SCX_ENQ_REENQ
-	 * handling in qmap_enqueue().
-	 */
-	switch (next->policy) {
-	case 1: /* SCHED_FIFO */
-	case 2: /* SCHED_RR */
-	case 6: /* SCHED_DEADLINE */
-		scx_bpf_reenqueue_local();
-
-		/* trigger re-enqueue on CPU0 just to exercise LOCAL_ON */
-		if (__COMPAT_has_generic_reenq())
-			scx_bpf_dsq_reenq(SCX_DSQ_LOCAL_ON | 0, 0);
-	}
-
-	return 0;
-}
-
-void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
-{
-	/* see qmap_sched_switch() to learn how to do this on newer kernels */
-	if (!__COMPAT_scx_bpf_reenqueue_local_from_anywhere())
-		scx_bpf_reenqueue_local();
-}
+/*
+ * sched_switch tracepoint and cpu_release handlers are no longer needed.
+ * With SCX_OPS_ALWAYS_ENQ_IMMED, wakeup_preempt_scx() reenqueues IMMED
+ * tasks when a higher-priority scheduling class takes the CPU.
+ */
 
 s32 BPF_STRUCT_OPS(qmap_init_task, struct task_struct *p,
 		   struct scx_init_task_args *args)
@@ -999,7 +988,6 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .dispatch		= (void *)qmap_dispatch,
 	       .tick			= (void *)qmap_tick,
 	       .core_sched_before	= (void *)qmap_core_sched_before,
-	       .cpu_release		= (void *)qmap_cpu_release,
 	       .init_task		= (void *)qmap_init_task,
 	       .dump			= (void *)qmap_dump,
 	       .dump_cpu		= (void *)qmap_dump_cpu,
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 5916bbe0d77f..e7c89a2bc3d8 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -21,7 +21,7 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-P] [-M] [-H] [-d PID] [-D LEN] [-S] [-p] [-v]\n"
+"       [-P] [-M] [-H] [-d PID] [-D LEN] [-S] [-p] [-I] [-F COUNT] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
@@ -36,6 +36,8 @@ const char help_fmt[] =
 "  -D LEN        Set scx_exit_info.dump buffer length\n"
 "  -S            Suppress qmap-specific debug dump\n"
 "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
+"  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
+"  -F COUNT      IMMED stress: force every COUNT'th enqueue to a busy local DSQ (use with -I)\n"
 "  -v            Print libbpf debug messages\n"
 "  -h            Display this help and exit\n";
 
@@ -68,7 +70,7 @@ int main(int argc, char **argv)
 
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:PMHc:d:D:Spvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:PMHc:d:D:SpIF:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -121,6 +123,13 @@ int main(int argc, char **argv)
 		case 'p':
 			skel->struct_ops.qmap_ops->flags |= SCX_OPS_SWITCH_PARTIAL;
 			break;
+		case 'I':
+			skel->rodata->always_enq_immed = true;
+			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ALWAYS_ENQ_IMMED;
+			break;
+		case 'F':
+			skel->rodata->immed_stress_nth = strtoul(optarg, NULL, 0);
+			break;
 		case 'v':
 			verbose = true;
 			break;
-- 
2.53.0

