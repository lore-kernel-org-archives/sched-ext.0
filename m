Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792713831;
	b=BKjApRLCRb3Xi6ZS6IvAWqOapKyT7/CO80IrWA8yppC45XMIerqqcBpZtiE/uv2InxU8
	 gcQsiRzcfkv0sRSXo0SLnkfLmELPOoXd8X7LK7WYWtGxDGsBBZAY+cq4IgXX6zXT0f+Wn
	 Gune+YUHZiNXPbyeCQCyQIj5DKAYglw40j7L0Yl7Yy91w0Myz5/u0SSZHfU5juuSmf6RS
	 nL+QJIS8vcslY5Fshbi4VmfKV5QyBHVLYn6K7zeaJ+UMb9fklHpVY/YBXVtoOGwXULe+r
	 3/datQ+BNcwXB0woKfF+tbWdgdjEnPIhpsCZNSEMkML9f35+minrtk5Wdntrt8Qcivg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792713831;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=g6MeidWyMBWnPmAPMAlzHAQn0B3NB5do8G09UFj8+KY=;
	b=ymYxV/woB2fwYwJk2OhVFyd5myNoUqENOQoMobjLz3G+i0/VsVTIy7yD68txcEcxEJpB
	 +goI/PU4PKuFBhi8K/DGZgRifKGp7IdHxbecCbFnNxVVASSzHqsVcgJuAy51OZygNZQvn
	 KC3KBhoKtIGnEUefdICNXCWAUXO94ZJt2M6DZLxU60/z2WvJCoSumTUYZ1DJwx1JxI1H4
	 TJOIwAgeub0rppR3cAyU1hJk797hc0lTFdJpKQO4JCvhxnV0g/1JP6Xok3MuTD/hQt3al
	 bEEYINtB1rBT5H46bgcFWPdKTGOJHVBpDvO5mZP3AzcnzqKJwFMFV0eBeI6E3KK5puQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSqMNh81;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB22606A320;
	Fri, 23 Oct 2026 00:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSqMNh81
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370701F01825;
	Fri, 23 Oct 2026 00:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792713830;
	bh=g6MeidWyMBWnPmAPMAlzHAQn0B3NB5do8G09UFj8+KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fSqMNh81EJE2kV8Qx4gGwD0shwCuM3it5FdvGT2k/BmnKZvg3mRHlxvNgkVfuHdGH
	 XjtycswTJdIJ1u/bXmcHuIiCH08ImBwywROjX/kS1yRmDgLf0iAZ2QwEPkmq664NXV
	 ss6anQIZlU2YLU8kIbFsxnfoXdxkc85KzXuSI1I6OmQKQWohG5MfvXbJz873YR/TEH
	 IVDA8dWfpBcRfP3TiMYLUWvl0Bg3nZVl5wCQ4rdjNpfM4XQgthBFcD6+SeIh1La6VG
	 Ta+KVxi+7+C7bycsUhTwyquR8SXB346YytUICFtyMV9EgMs3JuTBKpVCdOhgQV4Uhw
	 5n0VIJVbNtiKA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched_ext: Regenerate tools autogen enum headers
Date: Thu, 22 Oct 2026 14:03:47 -1000
Message-ID: <20261023000348.2726436-2-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023000348.2726436-1-tj@kernel.org>
References: <20261023000348.2726436-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regenerate enum_defs.autogen.h and enums_abi.autogen.h from the current
vmlinux.h. The enums added since the last regeneration lacked presence
markers and ABI values.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 .../sched_ext/include/scx/enum_defs.autogen.h | 11 ++++++++++
 .../sched_ext/include/scx/enums_abi.autogen.h | 21 ++++++++++++++-----
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 4fa82033b99c..27b45040c88a 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -23,6 +23,8 @@
 #define HAVE_SCX_CAPS_REENQ_ON_LOSS
 #define HAVE_SCX_CID_SHARD_SIZE_DFL
 #define HAVE_SCX_CID_SHARD_MAX_CPUS
+#define HAVE_SCX_CID_SCHED_NONE
+#define HAVE_SCX_CID_SCHED_SELF
 #define HAVE_SCX_DSP_DFL_MAX_BATCH
 #define HAVE_SCX_DSP_MAX_LOOPS
 #define HAVE_SCX_WATCHDOG_MAX_TIMEOUT
@@ -71,6 +73,7 @@
 #define HAVE_SCX_DSQ_LOCAL_ON
 #define HAVE_SCX_DSQ_LOCAL_CPU_MASK
 #define HAVE_SCX_DSQ_ITER_REV
+#define HAVE___SCX_DSQ_ITER_HAS_REENQ
 #define HAVE___SCX_DSQ_ITER_HAS_SLICE
 #define HAVE___SCX_DSQ_ITER_HAS_VTIME
 #define HAVE___SCX_DSQ_ITER_USER_FLAGS
@@ -100,6 +103,7 @@
 #define HAVE_SCX_ENQ_APPLY_SLICE
 #define HAVE_SCX_ENQ_SLICE_DFL
 #define HAVE_SCX_TASK_DSQ_ON_PRIQ
+#define HAVE_SCX_TASK_DSQ_REENQ
 #define HAVE_SCX_TASK_QUEUED
 #define HAVE_SCX_TASK_IN_CUSTODY
 #define HAVE_SCX_TASK_RESET_RUNNABLE_AT
@@ -188,6 +192,7 @@
 #define HAVE_SCX_SLICE_INF
 #define HAVE_SCX_REENQ_ANY
 #define HAVE_SCX_REENQ_CAP_REVOKE
+#define HAVE_SCX_REENQ_MARKED
 #define HAVE___SCX_REENQ_FILTER_MASK
 #define HAVE___SCX_REENQ_USER_MASK
 #define HAVE_SCX_REENQ_TSR_RQ_OPEN
@@ -195,15 +200,21 @@
 #define HAVE___SCX_REENQ_TSR_MASK
 #define HAVE_SCX_RQ_ONLINE
 #define HAVE_SCX_RQ_CAN_STOP_TICK
+#define HAVE_SCX_RQ_OPS_ONLINE
 #define HAVE_SCX_RQ_CLK_VALID
 #define HAVE_SCX_RQ_BAL_CB_PENDING
 #define HAVE_SCX_RQ_SUB_IDLE_RENOTIFY
 #define HAVE_SCX_RQ_ROOT_IDLE_RENOTIFY
 #define HAVE_SCX_RQ_PROXY_RETRY
 #define HAVE_SCX_RQ_PROXY_TICK
+#define HAVE_SCX_RQ_PROXY_PENDING
+#define HAVE_SCX_RQ_PROXY_BLOCKING
 #define HAVE_SCX_RQ_IN_WAKEUP
 #define HAVE_SCX_RQ_IN_DISPATCH
 #define HAVE_SCX_SCHED_PCPU_BYPASSING
+#define HAVE_SCX_SCHED_PCPU_ECAPS_ENABLED
+#define HAVE_SCX_SCHED_PCPU_ECAPS_REPORT
+#define HAVE_SCX_SCHED_PCPU_ECAPS_OFFLINE
 #define HAVE_SCX_SLICE_OOB_DUR_BITS
 #define HAVE_SCX_SLICE_OOB_ID_BITS
 #define HAVE_SCX_SLICE_OOB_DUR_MASK
diff --git a/tools/sched_ext/include/scx/enums_abi.autogen.h b/tools/sched_ext/include/scx/enums_abi.autogen.h
index 1186daa9cb14..5cf54dcf5ffe 100644
--- a/tools/sched_ext/include/scx/enums_abi.autogen.h
+++ b/tools/sched_ext/include/scx/enums_abi.autogen.h
@@ -35,6 +35,8 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_cap_flags", "SCX_CAPS_REENQ_ON_LOSS", 0x3LLU },
 	{ "scx_cid_consts", "SCX_CID_SHARD_SIZE_DFL", 0x18LLU },
 	{ "scx_cid_consts", "SCX_CID_SHARD_MAX_CPUS", 0x200LLU },
+	{ "scx_cid_sched_consts", "SCX_CID_SCHED_NONE", 0xfffffffffffffffeLLU },
+	{ "scx_cid_sched_consts", "SCX_CID_SCHED_SELF", 0xffffffffffffffffLLU },
 	{ "scx_consts", "SCX_DSP_DFL_MAX_BATCH", 0x20LLU },
 	{ "scx_consts", "SCX_DSP_MAX_LOOPS", 0x20LLU },
 	{ "scx_consts", "SCX_WATCHDOG_MAX_TIMEOUT", 0x7530LLU },
@@ -83,10 +85,11 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_dsq_id_flags", "SCX_DSQ_LOCAL_ON", 0xc000000000000000LLU },
 	{ "scx_dsq_id_flags", "SCX_DSQ_LOCAL_CPU_MASK", 0xffffffffLLU },
 	{ "scx_dsq_iter_flags", "SCX_DSQ_ITER_REV", 0x10000LLU },
+	{ "scx_dsq_iter_flags", "__SCX_DSQ_ITER_HAS_REENQ", 0x20000000LLU },
 	{ "scx_dsq_iter_flags", "__SCX_DSQ_ITER_HAS_SLICE", 0x40000000LLU },
 	{ "scx_dsq_iter_flags", "__SCX_DSQ_ITER_HAS_VTIME", 0x80000000LLU },
 	{ "scx_dsq_iter_flags", "__SCX_DSQ_ITER_USER_FLAGS", 0x10000LLU },
-	{ "scx_dsq_iter_flags", "__SCX_DSQ_ITER_ALL_FLAGS", 0xc0010000LLU },
+	{ "scx_dsq_iter_flags", "__SCX_DSQ_ITER_ALL_FLAGS", 0xe0010000LLU },
 	{ "scx_dsq_lnode_flags", "SCX_DSQ_LNODE_ITER_CURSOR", 0x1LLU },
 	{ "scx_dsq_lnode_flags", "__SCX_DSQ_LNODE_PRIV_SHIFT", 0x10LLU },
 	{ "scx_enable_state", "SCX_ENABLING", 0x0LLU },
@@ -112,6 +115,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_enq_flags", "SCX_ENQ_APPLY_SLICE", 0x2000000000000000LLU },
 	{ "scx_enq_flags", "SCX_ENQ_SLICE_DFL", 0x4000000000000000LLU },
 	{ "scx_ent_dsq_flags", "SCX_TASK_DSQ_ON_PRIQ", 0x1LLU },
+	{ "scx_ent_dsq_flags", "SCX_TASK_DSQ_REENQ", 0x2LLU },
 	{ "scx_ent_flags", "SCX_TASK_QUEUED", 0x1LLU },
 	{ "scx_ent_flags", "SCX_TASK_IN_CUSTODY", 0x2LLU },
 	{ "scx_ent_flags", "SCX_TASK_RESET_RUNNABLE_AT", 0x4LLU },
@@ -169,10 +173,10 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_kick_flags", "SCX_KICK_ALL_FLAGS", 0xfLLU },
 	{ "scx_opi", "SCX_OPI_BEGIN", 0x0LLU },
 	{ "scx_opi", "SCX_OPI_NORMAL_BEGIN", 0x0LLU },
-	{ "scx_opi", "SCX_OPI_NORMAL_END", 0x21LLU },
-	{ "scx_opi", "SCX_OPI_CPU_HOTPLUG_BEGIN", 0x21LLU },
-	{ "scx_opi", "SCX_OPI_CPU_HOTPLUG_END", 0x23LLU },
-	{ "scx_opi", "SCX_OPI_END", 0x23LLU },
+	{ "scx_opi", "SCX_OPI_NORMAL_END", 0x23LLU },
+	{ "scx_opi", "SCX_OPI_CPU_HOTPLUG_BEGIN", 0x23LLU },
+	{ "scx_opi", "SCX_OPI_CPU_HOTPLUG_END", 0x25LLU },
+	{ "scx_opi", "SCX_OPI_END", 0x25LLU },
 	{ "scx_ops_flags", "SCX_OPS_KEEP_BUILTIN_IDLE", 0x1LLU },
 	{ "scx_ops_flags", "SCX_OPS_ENQ_LAST", 0x2LLU },
 	{ "scx_ops_flags", "SCX_OPS_ENQ_EXITING", 0x4LLU },
@@ -200,6 +204,7 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_public_consts", "SCX_SLICE_INF", 0xffffffffffffffffLLU },
 	{ "scx_reenq_flags", "SCX_REENQ_ANY", 0x1LLU },
 	{ "scx_reenq_flags", "SCX_REENQ_CAP_REVOKE", 0x2LLU },
+	{ "scx_reenq_flags", "SCX_REENQ_MARKED", 0x4LLU },
 	{ "scx_reenq_flags", "__SCX_REENQ_FILTER_MASK", 0xffffLLU },
 	{ "scx_reenq_flags", "__SCX_REENQ_USER_MASK", 0x1LLU },
 	{ "scx_reenq_flags", "SCX_REENQ_TSR_RQ_OPEN", 0x100000000LLU },
@@ -207,15 +212,21 @@ static const struct __scx_enum_abi_val __scx_enum_abi_vals[]
 	{ "scx_reenq_flags", "__SCX_REENQ_TSR_MASK", 0xf00000000LLU },
 	{ "scx_rq_flags", "SCX_RQ_ONLINE", 0x1LLU },
 	{ "scx_rq_flags", "SCX_RQ_CAN_STOP_TICK", 0x2LLU },
+	{ "scx_rq_flags", "SCX_RQ_OPS_ONLINE", 0x4LLU },
 	{ "scx_rq_flags", "SCX_RQ_CLK_VALID", 0x20LLU },
 	{ "scx_rq_flags", "SCX_RQ_BAL_CB_PENDING", 0x40LLU },
 	{ "scx_rq_flags", "SCX_RQ_SUB_IDLE_RENOTIFY", 0x80LLU },
 	{ "scx_rq_flags", "SCX_RQ_ROOT_IDLE_RENOTIFY", 0x100LLU },
 	{ "scx_rq_flags", "SCX_RQ_PROXY_RETRY", 0x200LLU },
 	{ "scx_rq_flags", "SCX_RQ_PROXY_TICK", 0x400LLU },
+	{ "scx_rq_flags", "SCX_RQ_PROXY_PENDING", 0x800LLU },
+	{ "scx_rq_flags", "SCX_RQ_PROXY_BLOCKING", 0x1000LLU },
 	{ "scx_rq_flags", "SCX_RQ_IN_WAKEUP", 0x10000LLU },
 	{ "scx_rq_flags", "SCX_RQ_IN_DISPATCH", 0x20000LLU },
 	{ "scx_sched_pcpu_flags", "SCX_SCHED_PCPU_BYPASSING", 0x1LLU },
+	{ "scx_sched_pcpu_flags", "SCX_SCHED_PCPU_ECAPS_ENABLED", 0x2LLU },
+	{ "scx_sched_pcpu_flags", "SCX_SCHED_PCPU_ECAPS_REPORT", 0x4LLU },
+	{ "scx_sched_pcpu_flags", "SCX_SCHED_PCPU_ECAPS_OFFLINE", 0x8LLU },
 	{ "scx_slice_oob_consts", "SCX_SLICE_OOB_DUR_BITS", 0x2bLLU },
 	{ "scx_slice_oob_consts", "SCX_SLICE_OOB_ID_BITS", 0x14LLU },
 	{ "scx_slice_oob_consts", "SCX_SLICE_OOB_DUR_MASK", 0x7ffffffffffLLU },
-- 
2.56.0

