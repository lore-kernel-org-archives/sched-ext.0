Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179528507E;
	Sat,  7 Mar 2026 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843302; cv=none; b=tNzazxpP47OnzK+4CtTSscUwLkL+kWXnb/xiUS2ubSRSSSB0vWBF6TKtz84qjpHr4nuYNVaPDWviOIflasuso6MKyCXl72qbQNf4P4Skbc2voEyalrwm1bdZt5YJUHeabv3y671kiNO6WXB4ddPyq2zy/P/6Edwcp6boxdLNKHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843302; c=relaxed/simple;
	bh=Ke5N3bTDiciGMOY3eQjfLjz6BYV6EQJ+huLRZYucz04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUJ7Fp4BYRkaXkV8Y/4XCrjN8rghbVxU2im1ANTeGLMbAhca3EvQJnQMjEFSmDtf24q8u1m4aTmuHG/O5D7R9Dcjci7WY9TNjBEAmn6NnycAouMMomJj9CGBVCk8KIeu/m8urjSN5VlzvA4Wf5Lp6D4achUrjNqN468WPkQefk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHpBzMWq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHpBzMWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172C4C4CEF7;
	Sat,  7 Mar 2026 00:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772843302;
	bh=Ke5N3bTDiciGMOY3eQjfLjz6BYV6EQJ+huLRZYucz04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHpBzMWqUmRmthT2JsJJKTcNNib4nEnJwWp6yiNzM/hTYicyfm714R4bf9+5zreTJ
	 eRAn/aEj1gUb+e8jpz7XLqSuysQjnv0KqnI9L4ORdPt9bCI2veMjKFWtUD7rhhmFTQ
	 muHpSTfphRJhpk9aV+C3IXMZB9MU8nvgqIVKzEPRd2UsOvOhPZrSbiMLpUEzEfsM3g
	 D5jLmUPMVNVj4pPss88zKjlZNynSMQqNXjsaCjZ1ctXPR2p2RvFph4ChX7ESBjeoyc
	 U2IK8LIngnpmegZwtoG0IuQBGtIq7AiPfG7fgaGKXXgTj225rV+UZTJx/SOq5iaorW
	 KSwBiS6kId/hg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/3] sched_ext: Add SCX_OPS_ALWAYS_ENQ_IMMED ops flag
Date: Fri,  6 Mar 2026 14:28:17 -1000
Message-ID: <20260307002817.1298341-4-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307002817.1298341-1-tj@kernel.org>
References: <20260307002817.1298341-1-tj@kernel.org>
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
automatically applied to all local DSQ enqueues.

scx_qmap is updated with -I option to test the feature.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c                   | 29 ++++++++++++++++------------
 kernel/sched/ext_internal.h          |  7 +++++++
 tools/sched_ext/include/scx/compat.h |  1 +
 tools/sched_ext/scx_qmap.bpf.c       |  7 +++++--
 tools/sched_ext/scx_qmap.c           |  9 +++++++--
 5 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index eae8fc3e7b8a..a7ac4126e62f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7633,20 +7633,25 @@ void __init init_sched_ext_class(void)
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
@@ -7658,8 +7663,8 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
 		return false;
 	}
 
-	if (unlikely(enq_flags & __SCX_ENQ_INTERNAL_MASK)) {
-		scx_error(sch, "invalid enq_flags 0x%llx", enq_flags);
+	if (unlikely(*enq_flags & __SCX_ENQ_INTERNAL_MASK)) {
+		scx_error(sch, "invalid enq_flags 0x%llx", *enq_flags);
 		return false;
 	}
 
@@ -7753,7 +7758,7 @@ __bpf_kfunc bool scx_bpf_dsq_insert___v2(struct task_struct *p, u64 dsq_id,
 	if (unlikely(!sch))
 		return false;
 
-	if (!scx_dsq_insert_preamble(sch, p, dsq_id, enq_flags))
+	if (!scx_dsq_insert_preamble(sch, p, dsq_id, &enq_flags))
 		return false;
 
 	if (slice)
@@ -7779,7 +7784,7 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id,
 static bool scx_dsq_insert_vtime(struct scx_sched *sch, struct task_struct *p,
 				 u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags)
 {
-	if (!scx_dsq_insert_preamble(sch, p, dsq_id, enq_flags))
+	if (!scx_dsq_insert_preamble(sch, p, dsq_id, &enq_flags))
 		return false;
 
 	if (slice)
@@ -7906,7 +7911,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
 
-	if (!scx_vet_enq_flags(sch, dsq_id, enq_flags))
+	if (!scx_vet_enq_flags(sch, dsq_id, &enq_flags))
 		return false;
 
 	/*
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index cd4272117be4..20142d101ddb 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -182,6 +182,12 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_BUILTIN_IDLE_PER_NODE	= 1LLU << 6,
 
+	/*
+	 * If set, %SCX_ENQ_IMMED is assumed to be set on all local DSQ
+	 * enqueues.
+	 */
+	SCX_OPS_ALWAYS_ENQ_IMMED	= 1LLU << 7,
+
 	/*
 	 * CPU cgroup support flags
 	 */
@@ -194,6 +200,7 @@ enum scx_ops_flags {
 					  SCX_OPS_ALLOW_QUEUED_WAKEUP |
 					  SCX_OPS_SWITCH_PARTIAL |
 					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
+					  SCX_OPS_ALWAYS_ENQ_IMMED |
 					  SCX_OPS_HAS_CGROUP_WEIGHT,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 9b6df13b187b..fc4077b5a717 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -115,6 +115,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define SCX_OPS_ENQ_MIGRATION_DISABLED SCX_OPS_FLAG(SCX_OPS_ENQ_MIGRATION_DISABLED)
 #define SCX_OPS_ALLOW_QUEUED_WAKEUP SCX_OPS_FLAG(SCX_OPS_ALLOW_QUEUED_WAKEUP)
 #define SCX_OPS_BUILTIN_IDLE_PER_NODE SCX_OPS_FLAG(SCX_OPS_BUILTIN_IDLE_PER_NODE)
+#define SCX_OPS_ALWAYS_ENQ_IMMED SCX_OPS_FLAG(SCX_OPS_ALWAYS_ENQ_IMMED)
 
 #define SCX_PICK_IDLE_FLAG(name) __COMPAT_ENUM_OR_ZERO("scx_pick_idle_cpu_flags", #name)
 
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index a4a1b84fe359..dfd5ce222e39 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -47,6 +47,7 @@ const volatile bool print_msgs;
 const volatile u64 sub_cgroup_id;
 const volatile s32 disallow_tgid;
 const volatile bool suppress_dump;
+const volatile bool always_enq_immed;
 
 u64 nr_highpri_queued;
 u32 test_error_cnt;
@@ -144,8 +145,10 @@ static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu)
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
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 9252037284d3..38b088bd44d5 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -21,7 +21,7 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
-"       [-P] [-M] [-d PID] [-D LEN] [-p] [-v]\n"
+"       [-P] [-M] [-d PID] [-D LEN] [-p] [-I] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
@@ -36,6 +36,7 @@ const char help_fmt[] =
 "  -D LEN        Set scx_exit_info.dump buffer length\n"
 "  -S            Suppress qmap-specific debug dump\n"
 "  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
+"  -I            Turn on SCX_OPS_ALWAYS_ENQ_IMMED\n"
 "  -v            Print libbpf debug messages\n"
 "  -h            Display this help and exit\n";
 
@@ -68,7 +69,7 @@ int main(int argc, char **argv)
 
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:PMHc:d:D:Spvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:PMHc:d:D:SpIvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -121,6 +122,10 @@ int main(int argc, char **argv)
 		case 'p':
 			skel->struct_ops.qmap_ops->flags |= SCX_OPS_SWITCH_PARTIAL;
 			break;
+		case 'I':
+			skel->rodata->always_enq_immed = true;
+			skel->struct_ops.qmap_ops->flags |= SCX_OPS_ALWAYS_ENQ_IMMED;
+			break;
 		case 'v':
 			verbose = true;
 			break;
-- 
2.53.0

