Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777293019C3;
	Tue, 28 Apr 2026 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408548; cv=none; b=OcgmGjRqXiFA265Uh5lpFsFfeXErk34sAV6xdC7aA2/xvafbvHXsH6Td+xaMMVDMKapAZ5LtrefBYC/dIGMVEbuVJVbNp//cwg7uXAunfqQi+hjGvyE89e6Gdonc9GyAosPextNu3LTkMdqFDv+YFIIdPmwTSQf3ScH0Rmp10bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408548; c=relaxed/simple;
	bh=hpxRPBasPuZymHxXJcvVyTL1jXWM9kPjNtxC94ogP6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PK82hQWrwpWgZG5VjEvlTKIbM/CFko596QGzCOkOtP9okopm7TWljXKvMt7WtL+NsfKuDSyRdzlZdJfHtbBGQlfSl6XeWPcVQ1XD+nspXbFBu81kY9ulBcxh5fXwXxFWjZIW+mSDkgfkwfvbMQvqoIMIMM1zJLHt7PVcAAwDmyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8jPE1EQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8jPE1EQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA2AC2BCB3;
	Tue, 28 Apr 2026 20:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408548;
	bh=hpxRPBasPuZymHxXJcvVyTL1jXWM9kPjNtxC94ogP6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z8jPE1EQly9xmNpYf+fj86BrjmDZsgMKyBX+VYOFYfmV87But1zNmp5cTBu8pi9GS
	 NFRl5hGyt9G9j6upnWhQBz7JinrlUSWUtNJVn4JYDEcdynuyZyTiXzswzXCMY2DKv9
	 pLU7RXdPMDmQuaqydshH95D9KctTBb/an6KJwp/HNAu08aRfNLG+Fuw6OxCfg9VLCy
	 /RsfziEt0RothqGipRir6H528BGOc4hhA4g/BbPzYM9d5W2wZixOgumHa0lKlZTGSS
	 4W1WD4w9DbFS3QsZy1MQhdj/OiplFa7x7UXtvjPkgj+MMOQ6KPqDCnfCDdb2rzDt5z
	 8Fj/AwVMdQjOw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/17] sched_ext: Add ext_types.h for early subsystem-wide defs
Date: Tue, 28 Apr 2026 10:35:29 -1000
Message-ID: <20260428203545.181052-2-tj@kernel.org>
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
index ffb386889218..1d92f7d7a19f 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -59,6 +59,7 @@
 
 #ifdef CONFIG_SCHED_CLASS_EXT
 # include <linux/btf_ids.h>
+# include "ext_types.h"
 # include "ext_internal.h"
 # include "ext_idle.h"
 # include "ext.c"
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index a54903bb74b3..1b2ea6fa9fd6 100644
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
2.54.0

