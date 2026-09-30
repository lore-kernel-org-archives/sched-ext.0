Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E76027727;
	Wed, 30 Sep 2026 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726667; cv=none; b=CjHZUv2ra/Pr0IsBhwblM63dM1PxA8YRftTe2s0s3nMZFx+KP80gtbKMpgCZnw2O5iwPCJbR1VztOJE3aOn7MylH6rnaH2QUDHSU8EQx6gxHPyjutJFLzshmckNeMXRKyGFp80MrTpfkNTuXkEypIGmfXeQKrPtYsPsGKERo0Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726667; c=relaxed/simple;
	bh=rAga7vJuUOzWmcRgnYZ4hStj5TYVYNO8YYKhyHTrVPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlPp9BVX2pZXTcUE++sD+ZhHXz0L39t+WNBCtTw5IkNInw8GbNYuYaUQhhZXZfTbQb4zDFL9n3tEydAWpfSZ9UleMm9F5rTtb9bgTVC4tOR4wPIzreY0AwIfPnB932W+sJy3C2aQe7FqzN71psAgpDlZeKPbc7ntfRtzvYqrcww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwLOK8d5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwLOK8d5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16B61F000FF;
	Wed, 30 Sep 2026 00:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726666;
	bh=EWO7YhPAVRWvRrFjItllDbzX2ACwpvEg0lnuk1dniLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AwLOK8d5+UISWzDl7k7rp+tHnnEmp1l6IdlC0HxShfEuoTfeKlt3JLxm8zbfhAgL8
	 8EWlDpuUmsTcP/ZxUn07LPt0IvpM+oTd/UV/qhK/Xev1SAuWNqrXjuXWAZffyNoh0J
	 TZ7z1Ngxv97bLGwJFeGdF9WPoCANx9yvXejyoaFYhfYsuJOtXLRnV+7oqEucdNbUez
	 OWsg6RYuD0xpVtWJw9LZNsOI1+LXS54Do1mAGL2o+BZTfTDy3kdQkJH8ENjN2XbLFV
	 KcOjD2Kwz3zxND/JlEvkNXAKhnMM4OwxL3uQjYjCfGc5YnGTPN/iz3gMsU9rwLpiWM
	 bMfvkNXRIWvyQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] sched_ext: Sync tools autogen enum headers from the scx repo
Date: Tue, 29 Sep 2026 14:04:22 -1000
Message-ID: <20260930000422.3350352-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930000422.3350352-1-tj@kernel.org>
References: <20260930000422.3350352-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync the four autogen enum headers with the scx repo at c9b90b3ad3d0
("scheds/include: Sync with kernel sched_ext/for-7.4 (c6fe97c34a1a)"). The
enum definition and ABI tables pick up the enumerators the kernel gained
since the last sync. The two lookup tables are taken verbatim from scx's
copies so the files stay identical: their task state lookups move from the
removed scx_task_state to scx_ent_flags, where 7203d77d6e04 ("sched_ext:
Simplify task state handling") put the states, and until now resolved to
zero. The only entry the kernel copy gains is SCX_RQ_BAL_KEEP, which scx
keeps for older kernels and which zero-fills here.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 .../sched_ext/include/scx/enum_defs.autogen.h |  3 +++
 .../sched_ext/include/scx/enums.autogen.bpf.h | 15 ++++++++------
 tools/sched_ext/include/scx/enums.autogen.h   | 20 ++++++++++---------
 .../sched_ext/include/scx/enums_abi.autogen.h |  6 ++++++
 4 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 9707abeee00d..4fa82033b99c 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -171,6 +171,7 @@
 #define HAVE_SCX_OPS_ALWAYS_ENQ_IMMED
 #define HAVE_SCX_OPS_TID_TO_TASK
 #define HAVE_SCX_OPS_LAZY_RESCHED
+#define HAVE_SCX_OPS_ENQ_BLOCKED
 #define HAVE_SCX_OPS_ALL_FLAGS
 #define HAVE___SCX_OPS_INTERNAL_MASK
 #define HAVE_SCX_OPS_HAS_CPU_PREEMPT
@@ -198,6 +199,8 @@
 #define HAVE_SCX_RQ_BAL_CB_PENDING
 #define HAVE_SCX_RQ_SUB_IDLE_RENOTIFY
 #define HAVE_SCX_RQ_ROOT_IDLE_RENOTIFY
+#define HAVE_SCX_RQ_PROXY_RETRY
+#define HAVE_SCX_RQ_PROXY_TICK
 #define HAVE_SCX_RQ_IN_WAKEUP
 #define HAVE_SCX_RQ_IN_DISPATCH
 #define HAVE_SCX_SCHED_PCPU_BYPASSING
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 0a5478afbe79..405a3e6b8f33 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -1,9 +1,9 @@
 /*
- * WARNING: This file is autogenerated from scripts/gen_enums.py. If you would
- * like to access an enum that is currently missing, add it to the script
- * and run it from the root directory to update this file.
+ * Definitions for SCX constants. Keep this table in sync
+ * with rust/scx_utils/src/enums.rs.
  */
 
+
 const volatile u64 __SCX_OPS_NAME_LEN __weak;
 #define SCX_OPS_NAME_LEN __SCX_OPS_NAME_LEN
 
@@ -22,6 +22,9 @@ const volatile u64 __SCX_RQ_CAN_STOP_TICK __weak;
 const volatile u64 __SCX_RQ_BAL_PENDING __weak;
 #define SCX_RQ_BAL_PENDING __SCX_RQ_BAL_PENDING
 
+const volatile u64 __SCX_RQ_BAL_KEEP __weak;
+#define SCX_RQ_BAL_KEEP __SCX_RQ_BAL_KEEP
+
 const volatile u64 __SCX_RQ_BYPASSING __weak;
 #define SCX_RQ_BYPASSING __SCX_RQ_BYPASSING
 
@@ -136,15 +139,15 @@ const volatile u64 __SCX_ENQ_IMMED __weak;
 const volatile u64 __SCX_ENQ_RESCUE __weak;
 #define SCX_ENQ_RESCUE __SCX_ENQ_RESCUE
 
+const volatile u64 __SCX_ENQ_BLOCKED __weak;
+#define SCX_ENQ_BLOCKED __SCX_ENQ_BLOCKED
+
 const volatile u64 __SCX_ENQ_REENQ __weak;
 #define SCX_ENQ_REENQ __SCX_ENQ_REENQ
 
 const volatile u64 __SCX_ENQ_LAST __weak;
 #define SCX_ENQ_LAST __SCX_ENQ_LAST
 
-const volatile u64 __SCX_ENQ_BLOCKED __weak;
-#define SCX_ENQ_BLOCKED __SCX_ENQ_BLOCKED
-
 const volatile u64 __SCX_ENQ_CLEAR_OPSS __weak;
 #define SCX_ENQ_CLEAR_OPSS __SCX_ENQ_CLEAR_OPSS
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index 60a1e5576126..7ec2e5e41cb2 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -1,7 +1,8 @@
+#pragma once
+
 /*
- * WARNING: This file is autogenerated from scripts/gen_enums.py. If you would
- * like to access an enum that is currently missing, add it to the script
- * and run it from the root directory to update this file.
+ * BTF enum lookups for SCX constants. Keep this table in sync
+ * with rust/scx_utils/src/enums.rs.
  */
 
 #define SCX_ENUM_INIT(skel) do { \
@@ -11,6 +12,7 @@
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_ONLINE); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_CAN_STOP_TICK); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_BAL_PENDING); \
+	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_BAL_KEEP); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_BYPASSING); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_CLK_VALID); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_IN_WAKEUP); \
@@ -32,11 +34,11 @@
 	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_STATE_BITS); \
 	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_STATE_MASK); \
 	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_CURSOR); \
-	SCX_ENUM_SET(skel, scx_task_state, SCX_TASK_NONE); \
-	SCX_ENUM_SET(skel, scx_task_state, SCX_TASK_INIT); \
-	SCX_ENUM_SET(skel, scx_task_state, SCX_TASK_READY); \
-	SCX_ENUM_SET(skel, scx_task_state, SCX_TASK_ENABLED); \
-	SCX_ENUM_SET(skel, scx_task_state, SCX_TASK_NR_STATES); \
+	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_NONE); \
+	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_INIT); \
+	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_READY); \
+	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_ENABLED); \
+	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_NR_STATES); \
 	SCX_ENUM_SET(skel, scx_ent_dsq_flags, SCX_TASK_DSQ_ON_PRIQ); \
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_IDLE); \
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_PREEMPT); \
@@ -49,9 +51,9 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_PREEMPT_LAZY); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_IMMED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_RESCUE); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_BLOCKED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_REENQ); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
-	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_BLOCKED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
 	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
diff --git a/tools/sched_ext/include/scx/enums_abi.autogen.h b/tools/sched_ext/include/scx/enums_abi.autogen.h
index 251eea9b81e7..1186daa9cb14 100644
--- a/tools/sched_ext/include/scx/enums_abi.autogen.h
+++ b/tools/sched_ext/include/scx/enums_abi.autogen.h
@@ -102,6 +102,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_enq_flags", "SCX_ENQ_RESCUE", 0x400000000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_REENQ", 0x10000000000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_LAST", 0x20000000000LLU },
+	{ "scx_enq_flags", "SCX_ENQ_BLOCKED", 0x40000000000LLU },
 	{ "scx_enq_flags", "__SCX_ENQ_INTERNAL_MASK", 0xff00000000000000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_CLEAR_OPSS", 0x100000000000000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_DSQ_PRIQ", 0x200000000000000LLU },
@@ -118,6 +119,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_ent_flags", "SCX_TASK_SUB_INIT", 0x10LLU },
 	{ "scx_ent_flags", "SCX_TASK_IMMED", 0x20LLU },
 	{ "scx_ent_flags", "SCX_TASK_PROTECTED", 0x40LLU },
+	{ "scx_ent_flags", "SCX_TASK_RUN_TRACKED", 0x80LLU },
 	{ "scx_ent_flags", "SCX_TASK_STATE_SHIFT", 0x8LLU },
 	{ "scx_ent_flags", "SCX_TASK_STATE_BITS", 0x3LLU },
 	{ "scx_ent_flags", "SCX_TASK_STATE_MASK", 0x700LLU },
@@ -135,6 +137,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_ent_flags", "SCX_TASK_REENQ_IMMED", 0x2000LLU },
 	{ "scx_ent_flags", "SCX_TASK_REENQ_PREEMPTED", 0x3000LLU },
 	{ "scx_ent_flags", "SCX_TASK_REENQ_CAP", 0x4000LLU },
+	{ "scx_ent_flags", "SCX_TASK_REENQ_PROXY", 0x5000LLU },
 	{ "scx_ent_flags", "SCX_TASK_CURSOR", 0xffffffff80000000LLU },
 	{ "scx_exit_code", "SCX_ECODE_RSN_HOTPLUG", 0x100000000LLU },
 	{ "scx_exit_code", "SCX_ECODE_RSN_CGROUP_OFFLINE", 0x200000000LLU },
@@ -180,6 +183,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_ops_flags", "SCX_OPS_ALWAYS_ENQ_IMMED", 0x80LLU },
 	{ "scx_ops_flags", "SCX_OPS_TID_TO_TASK", 0x100LLU },
 	{ "scx_ops_flags", "SCX_OPS_LAZY_RESCHED", 0x200LLU },
+	{ "scx_ops_flags", "SCX_OPS_ENQ_BLOCKED", 0x400LLU },
 	{ "scx_ops_flags", "SCX_OPS_ALL_FLAGS", 0x7ffLLU },
 	{ "scx_ops_flags", "__SCX_OPS_INTERNAL_MASK", 0xff00000000000000LLU },
 	{ "scx_ops_flags", "SCX_OPS_HAS_CPU_PREEMPT", 0x100000000000000LLU },
@@ -207,6 +211,8 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_rq_flags", "SCX_RQ_BAL_CB_PENDING", 0x40LLU },
 	{ "scx_rq_flags", "SCX_RQ_SUB_IDLE_RENOTIFY", 0x80LLU },
 	{ "scx_rq_flags", "SCX_RQ_ROOT_IDLE_RENOTIFY", 0x100LLU },
+	{ "scx_rq_flags", "SCX_RQ_PROXY_RETRY", 0x200LLU },
+	{ "scx_rq_flags", "SCX_RQ_PROXY_TICK", 0x400LLU },
 	{ "scx_rq_flags", "SCX_RQ_IN_WAKEUP", 0x10000LLU },
 	{ "scx_rq_flags", "SCX_RQ_IN_DISPATCH", 0x20000LLU },
 	{ "scx_sched_pcpu_flags", "SCX_SCHED_PCPU_BYPASSING", 0x1LLU },
-- 
2.55.0

