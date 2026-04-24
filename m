Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F662512C8;
	Fri, 24 Apr 2026 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994343; cv=none; b=MgFgkGU2nu4l+mtlLSvpYP4hQPxa6NqV/lIOX5aJIE1Tj4ZkOiExmfr+PGjlYsX3tCYZ1NY+GjF6aKZCXfm9EokCy7g76YLz/+iYfECRN0a/7S+UCE6vss0qVx9bttRlPaZItj/PXt0jM3mmNrmw/4j2+xOOKP+IsOIdtCYie1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994343; c=relaxed/simple;
	bh=uP54tN+3Hp8vh8q+K1Yw91i9zeNJBnvABeKhnVGsEyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hxPdGnSMmrjVrq+H4VFiVGaLR6i4P2sGVCKSyNXQM5ob2ef3bt4Nu1l803OAG0hjCNr+HkI9fPsEPOul3IYBxYV09s10imols+XNN30bery/YLcby2qn2/nXbn0aljGw2E+WvKGbmDDBQBnfkEXPABIKGPcER4SEeQVT+ODo2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjV9cgcY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjV9cgcY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0791C2BCB3;
	Fri, 24 Apr 2026 01:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776994342;
	bh=uP54tN+3Hp8vh8q+K1Yw91i9zeNJBnvABeKhnVGsEyY=;
	h=From:To:Cc:Subject:Date:From;
	b=jjV9cgcYMCWnZ26OeK6uwPatY/qetj+zTkiX5bzfYPQSbU1fZpUE2lB/OZ2rhcVl3
	 jpvDC/aHpOTzCWBqLgsdSf4s2Zlnko7U8hC9bug2+3zj4F3uBcLdhJURqlCyBMVObk
	 weZv5fprIPuAF3gLp2g8Jye4mBDUhkMjrgzGyTuxvCGc8qTZeg/WCdyECKVTKYH+Sh
	 nXKRGLAYmtp5vacQrJvNdLE7qSAfFrHV2mzyXx0KM5AwIx6Gk6Z+Dk6V1dvCjU9Hef
	 v81Rj54p64q/z4RCRUO75hukGVeU42b5S4E2Mrn1LiybNCfApYOVwwCZX07Fb3Nz+G
	 5I0lFhFYnKvaA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomzhao@126.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/17] sched_ext: Add ext_types.h for early subsystem-wide defs
Date: Thu, 23 Apr 2026 15:32:04 -1000
Message-ID: <20260424013220.2923402-2-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce kernel/sched/ext_types.h as the early-def header for the
sched_ext compilation unit. Included from kernel/sched/build_policy.c
before ext_internal.h so every later header and source in the unit
sees its content without re-inclusion. Later patches add their types
here (struct scx_cid_topo, scx_cmask, scx_cid_shard, etc.) so the
subsystem has one place to stash types shared across the TU.

Move enum scx_consts (SCX_DSP_DFL_MAX_BATCH, SCX_WATCHDOG_MAX_TIMEOUT,
SCX_SUB_MAX_DEPTH, etc.) here as the initial content. Ops-facing
content stays in ext_internal.h.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/build_policy.c |  1 +
 kernel/sched/ext_internal.h | 32 ---------------------------
 kernel/sched/ext_types.h    | 43 +++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 32 deletions(-)
 create mode 100644 kernel/sched/ext_types.h

diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index 755883faf751..180ade38625e 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -58,6 +58,7 @@
 #include "deadline.c"
 
 #ifdef CONFIG_SCHED_CLASS_EXT
+# include "ext_types.h"
 # include "ext_internal.h"
 # include "ext.c"
 # include "ext_idle.c"
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 4a7ffc7f55d2..c35098668fb1 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -8,38 +8,6 @@
 #define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
 #define SCX_MOFF_IDX(moff)	((moff) / sizeof(void (*)(void)))
 
-enum scx_consts {
-	SCX_DSP_DFL_MAX_BATCH		= 32,
-	SCX_DSP_MAX_LOOPS		= 32,
-	SCX_WATCHDOG_MAX_TIMEOUT	= 30 * HZ,
-
-	/* per-CPU chunk size for p->scx.tid allocation, see scx_alloc_tid() */
-	SCX_TID_CHUNK			= 1024,
-
-	SCX_EXIT_BT_LEN			= 64,
-	SCX_EXIT_MSG_LEN		= 1024,
-	SCX_EXIT_DUMP_DFL_LEN		= 32768,
-
-	SCX_CPUPERF_ONE			= SCHED_CAPACITY_SCALE,
-
-	/*
-	 * Iterating all tasks may take a while. Periodically drop
-	 * scx_tasks_lock to avoid causing e.g. CSD and RCU stalls.
-	 */
-	SCX_TASK_ITER_BATCH		= 32,
-
-	SCX_BYPASS_HOST_NTH		= 2,
-
-	SCX_BYPASS_LB_DFL_INTV_US	= 500 * USEC_PER_MSEC,
-	SCX_BYPASS_LB_DONOR_PCT		= 125,
-	SCX_BYPASS_LB_MIN_DELTA_DIV	= 4,
-	SCX_BYPASS_LB_BATCH		= 256,
-
-	SCX_REENQ_LOCAL_MAX_REPEAT	= 256,
-
-	SCX_SUB_MAX_DEPTH		= 4,
-};
-
 enum scx_exit_kind {
 	SCX_EXIT_NONE,
 	SCX_EXIT_DONE,
diff --git a/kernel/sched/ext_types.h b/kernel/sched/ext_types.h
new file mode 100644
index 000000000000..19299ec3920e
--- /dev/null
+++ b/kernel/sched/ext_types.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Early sched_ext type definitions.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2026 Tejun Heo <tj@kernel.org>
+ */
+#ifndef _KERNEL_SCHED_EXT_TYPES_H
+#define _KERNEL_SCHED_EXT_TYPES_H
+
+enum scx_consts {
+	SCX_DSP_DFL_MAX_BATCH		= 32,
+	SCX_DSP_MAX_LOOPS		= 32,
+	SCX_WATCHDOG_MAX_TIMEOUT	= 30 * HZ,
+
+	/* per-CPU chunk size for p->scx.tid allocation, see scx_alloc_tid() */
+	SCX_TID_CHUNK			= 1024,
+
+	SCX_EXIT_BT_LEN			= 64,
+	SCX_EXIT_MSG_LEN		= 1024,
+	SCX_EXIT_DUMP_DFL_LEN		= 32768,
+
+	SCX_CPUPERF_ONE			= SCHED_CAPACITY_SCALE,
+
+	/*
+	 * Iterating all tasks may take a while. Periodically drop
+	 * scx_tasks_lock to avoid causing e.g. CSD and RCU stalls.
+	 */
+	SCX_TASK_ITER_BATCH		= 32,
+
+	SCX_BYPASS_HOST_NTH		= 2,
+
+	SCX_BYPASS_LB_DFL_INTV_US	= 500 * USEC_PER_MSEC,
+	SCX_BYPASS_LB_DONOR_PCT		= 125,
+	SCX_BYPASS_LB_MIN_DELTA_DIV	= 4,
+	SCX_BYPASS_LB_BATCH		= 256,
+
+	SCX_REENQ_LOCAL_MAX_REPEAT	= 256,
+
+	SCX_SUB_MAX_DEPTH		= 4,
+};
+
+#endif /* _KERNEL_SCHED_EXT_TYPES_H */
-- 
2.53.0

