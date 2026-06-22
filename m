Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E7035200C;
	Mon, 22 Jun 2026 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160642; cv=none; b=p5iCH79/5287Y512huXC9cogkXz4cJpyhoF8k+Rd/eETQyRqU7r58QpVX0MSThACUBliMEoU1jRjuj7RXerJl9XluCM4eKnGmkqRy5mbuirVcI77lRkDULrF5TsoPLgL9jNVklrWfZNZw+f7HDm+iFwjWbyc9cxoF5iTTTrtjHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160642; c=relaxed/simple;
	bh=7HULovNxjUp15J9s5xzdQ89gceTc2YFGK8lpH/4mVRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc+udvgZ4zPPL8CoEV5Hl/CJvS8xWKDHZMbutaEVomfImAyWmE7p52VgWnLBXKMiXr5DQ520h6/1a5pjUgdd8s6J4yCFdoTLMrVIQ87+iw0HA5xpudVMv4lFM/KeqRj2536c3afCXZOP0AIWanYJRiSRz/u3i2YvVb0YrDTHtZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOQvj6q3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOQvj6q3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0219B1F000E9;
	Mon, 22 Jun 2026 20:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782160633;
	bh=E3uU3ThG/A2D12qAK0ptnKC8O+aAJd+dVYsVAW78QSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dOQvj6q3i++35tP25z+bIWXPU9eqz4b+LemzvziPXIJf4D0wApnxyALUIS+/wA70s
	 PO6kZbjEiKiY95JG/K7lFzaGMTzCfQzNi1eBpZObfMfdsplWoKoDKpgzj2k/vULwAT
	 5Jc9vGjiCqa5IyFXHO/9fRCRsb78wfX65daZZYsxP/wAPcVtOUoYvsnq3ROwEB4p0E
	 Wkneq73ITGCq/zfKLgVfZkbUlklDTN8xVdWLNZXqIG0EZRqmjOh8yQN7dbtmSkkdtZ
	 15vApYxaTfw9xE7lXjdbC6AtEuMdxVOOIUQIGZvNM4QlHfdXFTmLuQ6f9+W5zRHFs0
	 hhKnuXzYsTrpw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	sched-ext@lists.linux.dev,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH v2 sched_ext/for-7.2 1/2] sched_ext: Make kernel/sched/ext/ sources self-contained for clangd
Date: Mon, 22 Jun 2026 10:37:12 -1000
Message-ID: <20260622203712.1286063-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622173904.1169407-1-tj@kernel.org>
References: <20260622173904.1169407-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sources under kernel/sched/ext/ build as a single translation unit:
build_policy.c includes the source files and headers. An LSP/clangd editor
parses each as a standalone unit, sees no types, and reports a flood of
errors.

Give each header its dependencies and include guard, and have each source
include the headers it uses.

ext.c, arena.c and the ext headers now parse clean standalone. idle.c and
cid.c still reference a few macros and helpers defined in ext.c. The next
patch moves those to shared headers.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
v2:
- ext.c includes <linux/sched/clock.h> for sched_clock_cpu() (Andrea).
- idle.h forward-declares struct cpumask/task_struct instead of
  including ../sched.h (Andrea).

v1: https://lore.kernel.org/r/20260622173904.1169407-1-tj@kernel.org

 kernel/sched/ext/arena.c    |  4 ++++
 kernel/sched/ext/arena.h    |  2 ++
 kernel/sched/ext/cid.c      |  3 +++
 kernel/sched/ext/cid.h      |  2 ++
 kernel/sched/ext/ext.c      | 13 +++++++++++++
 kernel/sched/ext/idle.c     |  3 +++
 kernel/sched/ext/idle.h     |  4 ++++
 kernel/sched/ext/internal.h |  8 ++++++++
 kernel/sched/ext/types.h    |  6 ++++++
 9 files changed, 45 insertions(+)

diff --git a/kernel/sched/ext/arena.c b/kernel/sched/ext/arena.c
index 493c2424f842..5783694ec21d 100644
--- a/kernel/sched/ext/arena.c
+++ b/kernel/sched/ext/arena.c
@@ -15,6 +15,10 @@
  * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2026 Tejun Heo <tj@kernel.org>
  */
+#include <linux/genalloc.h>
+
+#include "internal.h"
+#include "arena.h"
 
 enum scx_arena_consts {
 	SCX_ARENA_MIN_ORDER		= 3,	/* 8-byte minimum sub-allocation */
diff --git a/kernel/sched/ext/arena.h b/kernel/sched/ext/arena.h
index 4f3610160102..c378ae5fbc02 100644
--- a/kernel/sched/ext/arena.h
+++ b/kernel/sched/ext/arena.h
@@ -8,6 +8,8 @@
 #ifndef _KERNEL_SCHED_EXT_ARENA_H
 #define _KERNEL_SCHED_EXT_ARENA_H
 
+#include <linux/types.h>
+
 struct scx_sched;
 
 s32 scx_arena_pool_init(struct scx_sched *sch);
diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index aeaea88f34c5..af83084ec740 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -7,6 +7,9 @@
  */
 #include <linux/cacheinfo.h>
 
+#include "internal.h"
+#include "cid.h"
+
 /*
  * cid tables.
  *
diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
index 6e657fd147b0..41d0802c6af3 100644
--- a/kernel/sched/ext/cid.h
+++ b/kernel/sched/ext/cid.h
@@ -33,6 +33,8 @@
 #ifndef _KERNEL_SCHED_EXT_CID_H
 #define _KERNEL_SCHED_EXT_CID_H
 
+#include "internal.h"
+
 struct scx_sched;
 
 /*
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 00fe6cc6d7e2..f3253c946764 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6,6 +6,19 @@
  * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
  */
+#include <linux/bitmap.h>
+#include <linux/btf_ids.h>
+#include <linux/rhashtable.h>
+#include <linux/sched/clock.h>
+#include <linux/sched/isolation.h>
+#include <linux/suspend.h>
+#include <linux/sysrq.h>
+
+#include "../pelt.h"
+#include "internal.h"
+#include "cid.h"
+#include "arena.h"
+#include "idle.h"
 
 static DEFINE_RAW_SPINLOCK(scx_sched_lock);
 
diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index 2077373d8da3..8e8c6201b7df 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -9,6 +9,9 @@
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
  * Copyright (c) 2024 Andrea Righi <arighi@nvidia.com>
  */
+#include "internal.h"
+#include "cid.h"
+#include "idle.h"
 
 /* Enable/disable built-in idle CPU selection policy */
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
diff --git a/kernel/sched/ext/idle.h b/kernel/sched/ext/idle.h
index 8d169d3bbdf9..87a0e58f1eb7 100644
--- a/kernel/sched/ext/idle.h
+++ b/kernel/sched/ext/idle.h
@@ -10,7 +10,11 @@
 #ifndef _KERNEL_SCHED_EXT_IDLE_H
 #define _KERNEL_SCHED_EXT_IDLE_H
 
+#include <linux/btf_ids.h>
+
+struct cpumask;
 struct sched_ext_ops;
+struct task_struct;
 
 extern struct btf_id_set8 scx_kfunc_ids_idle;
 extern struct btf_id_set8 scx_kfunc_ids_select_cpu;
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index b04701190b23..1f5312b3b387 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -5,6 +5,12 @@
  * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2025 Tejun Heo <tj@kernel.org>
  */
+#ifndef _KERNEL_SCHED_EXT_INTERNAL_H
+#define _KERNEL_SCHED_EXT_INTERNAL_H
+
+#include "../sched.h"
+#include "types.h"
+
 #define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
 #define SCX_MOFF_IDX(moff)	((moff) / sizeof(void (*)(void)))
 
@@ -1651,3 +1657,5 @@ static inline struct scx_sched *scx_prog_sched(const struct bpf_prog_aux *aux)
 	return rcu_dereference_all(scx_root);
 }
 #endif	/* CONFIG_EXT_SUB_SCHED */
+
+#endif /* _KERNEL_SCHED_EXT_INTERNAL_H */
diff --git a/kernel/sched/ext/types.h b/kernel/sched/ext/types.h
index 8b3527e21fca..bc74eafd43f1 100644
--- a/kernel/sched/ext/types.h
+++ b/kernel/sched/ext/types.h
@@ -8,6 +8,12 @@
 #ifndef _KERNEL_SCHED_EXT_TYPES_H
 #define _KERNEL_SCHED_EXT_TYPES_H
 
+#include <linux/types.h>
+#include <linux/jiffies.h>
+#include <linux/overflow.h>
+#include <linux/time64.h>
+#include <linux/sched/topology.h>
+
 enum scx_consts {
 	SCX_DSP_DFL_MAX_BATCH		= 32,
 	SCX_DSP_MAX_LOOPS		= 32,
-- 
2.54.0

