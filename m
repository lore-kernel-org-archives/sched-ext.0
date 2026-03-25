Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0B53FFD
	for <sched-ext@lists.linux.dev>; Wed, 25 Mar 2026 04:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774414339; cv=none; b=KPiVpMSui7jvLS/GO+DxVM57E4gdgvvCKoZyY2WmtlK3xWM061k5C0sBTrSoccx9SkywL4UuSCLgTcl5mw9jQYd3ejTfMgjUcjjwPb/2zHRohruc/AjAghpMne7QmLXrmBbpZHcGROWgucQ9/uFsu3EZplclIxL1mqSBMXzHYXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774414339; c=relaxed/simple;
	bh=6H6rqdCnEvKIZUdATnioqwaFwZx9ecXuvDhcOdjxkmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JogUpGEzCLG7s5Lif5kKmrBNxUQeNmG7NkQyb1xnPK9drhv9yXQOEH9AKxBNRp5PTRsWut/5VWcXASZbV4CR/LMdU8jhuq9YCD3+/el8PU1X8Lcp8odPnqStM8EDqGqxvX1jgUp6UIMDF4XyARZTo7w6yh9rcpa75ViMfYmY7ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1bz4JqC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1bz4JqC"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ab077e3f32so21482685ad.3
        for <sched-ext@lists.linux.dev>; Tue, 24 Mar 2026 21:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774414337; x=1775019137; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Pz19kWYlpuli/aK4+VZWGlvZO5fdBmrysj6fGcScZk=;
        b=F1bz4JqC/ilyP5/rIuHn8vmpwjUZgSdoLzdftNOTSgKTbjsVXz7NmxvsAFjvqArI25
         EPQ+pi1q1AvLhq1AVORNsyMrKlno0BYCuRjEpbW4Rvmxpqi2pUJK5jHndWbhZIjwCR49
         z/DHH/FP6+6BP6jnprP9xaGAZAYF7TfvmSdnVWFImaa9iXBe5zt7owSwdMAVs1UUrDAO
         40RBoXXjZa0u0SOI8KJZ3dIVuWWNvVGVgOCs5EV1mMRjwmZqXN/ok3sqZusZiI0Z8/Fa
         wmAR2ItUueEVLcw6xp3XbuqAj1yli6rdOT1lYcNgjuupU+/koxS/qpsLNszjUmmb5uhV
         XToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774414337; x=1775019137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Pz19kWYlpuli/aK4+VZWGlvZO5fdBmrysj6fGcScZk=;
        b=fzPeWl2KBWRo2xZdgPte0pVp9m9nymNWiqzA7bxX4q/jP6ITNrD+XrxinNVlJKPfWo
         iqx2zgDdCLcV9auedyIt9t7ZcoeMwDQoFC3LZ4naybYcDTYL3d43qS5fN2LJq39h79+a
         HVC3gHAB1ieZlgs/ihBGgMD+khtAYkCYdNxKgMjhxKbYMxRgIf48sRgMi5YDqRotVIn2
         FP6l6rtbF96aMBHWm1sZnmrIg5++ELhfiJYXH4iT4zCmK/YkP+mOWPjSHRwq0/vH35hf
         knxenir8tEuKp79DtGhKu3+dwZ/FQf9OOQ2vbBG/zqnDE89jsBUSk/k6UYB+FTEu7YAD
         7KNA==
X-Gm-Message-State: AOJu0YyLjhBtQYHC6/dKsMZuO1+i8psaVKD3TC94N/4Zr9yihMfaVfDf
	oxLhGvlvwHBCJbdbP8zW958+nLdxsQ5ASSpPhq1yCIDroq4yjuWNJVe9NN8Q3w==
X-Gm-Gg: ATEYQzytyfEEGvb8uPlOKm4b3qx2Mz+FlGr/SSndzKs+i3qfEpO+uJ2+bSzQit9+TSW
	6+KRcaFw/t7+fpCPXTK/YpuMsxRNaUDXqvoRkUCMQsMWd1L3K6ZO0kdn34csf36n+OygRgf1Txm
	8bHfUVZVQokBm47Hn5zFaU0tVkXLubjBbUqVYag2azaSe5LRQPPeubj5ph+zwk2RlGde1voWxxi
	+A13Oi1GFJITIwbHDESZqmuTU6tf048foUphR1fCJ8u6b0rTgLt7t7pvzqQ7VgP9YAjjrnFGZ/c
	9QmC/UdlpTQGqXjRnvbH+T+VqnkjXBonl1SUqCVvH9c/+YE8LMJ59FEBJddmOmunK6JUB7hYgAV
	bqfbtuXauip6X1ntR4ozFbzkiCQ7Vy1kiNTuAYC2yNhKRGZIssph0pYpIIoCktfxr8wwJ5sLXxl
	b4/B6Pskbb5vHJzrBJbYCyn+L2xPxofUO0jWqTn1SvkWHnxDjAFBXI
X-Received: by 2002:a17:902:db08:b0:2b0:69bf:a3df with SMTP id d9443c01a7336-2b0b0aadc58mr21651495ad.27.1774414336491;
        Tue, 24 Mar 2026 21:52:16 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:76ad:4f09:3dce:2442])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083549f63sm160576015ad.30.2026.03.24.21.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 21:52:16 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH] tools/sched_ext: Regenerate autogen enum headers
Date: Wed, 25 Mar 2026 12:51:48 +0800
Message-ID: <20260325045209.1981413-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regenerate enum_defs.autogen.h, enums.autogen.h and enums.autogen.bpf.h
using the upstream scripts [1][2] to sync with recent kernel enum
additions.

[1] https://github.com/sched-ext/scx/blob/main/scripts/gen_enum_defs.py
[2] https://github.com/sched-ext/scx/blob/main/scripts/gen_enums.py

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/include/scx/enum_defs.autogen.h | 10 ++++++++++
 tools/sched_ext/include/scx/enums.autogen.bpf.h |  9 +++++++++
 tools/sched_ext/include/scx/enums.autogen.h     |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 40b30dad8ede..da4b459820fd 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -20,6 +20,7 @@
 #define HAVE_SCX_BYPASS_LB_DONOR_PCT
 #define HAVE_SCX_BYPASS_LB_MIN_DELTA_DIV
 #define HAVE_SCX_BYPASS_LB_BATCH
+#define HAVE_SCX_REENQ_LOCAL_MAX_REPEAT
 #define HAVE_SCX_SUB_MAX_DEPTH
 #define HAVE_SCX_CPU_PREEMPT_RT
 #define HAVE_SCX_CPU_PREEMPT_DL
@@ -51,18 +52,21 @@
 #define HAVE_SCX_ENQ_HEAD
 #define HAVE_SCX_ENQ_CPU_SELECTED
 #define HAVE_SCX_ENQ_PREEMPT
+#define HAVE_SCX_ENQ_IMMED
 #define HAVE_SCX_ENQ_REENQ
 #define HAVE_SCX_ENQ_LAST
 #define HAVE___SCX_ENQ_INTERNAL_MASK
 #define HAVE_SCX_ENQ_CLEAR_OPSS
 #define HAVE_SCX_ENQ_DSQ_PRIQ
 #define HAVE_SCX_ENQ_NESTED
+#define HAVE_SCX_ENQ_GDSQ_FALLBACK
 #define HAVE_SCX_TASK_DSQ_ON_PRIQ
 #define HAVE_SCX_TASK_QUEUED
 #define HAVE_SCX_TASK_IN_CUSTODY
 #define HAVE_SCX_TASK_RESET_RUNNABLE_AT
 #define HAVE_SCX_TASK_DEQD_FOR_SLEEP
 #define HAVE_SCX_TASK_SUB_INIT
+#define HAVE_SCX_TASK_IMMED
 #define HAVE_SCX_TASK_STATE_SHIFT
 #define HAVE_SCX_TASK_STATE_BITS
 #define HAVE_SCX_TASK_STATE_MASK
@@ -75,6 +79,8 @@
 #define HAVE_SCX_TASK_REENQ_REASON_MASK
 #define HAVE_SCX_TASK_REENQ_NONE
 #define HAVE_SCX_TASK_REENQ_KFUNC
+#define HAVE_SCX_TASK_REENQ_IMMED
+#define HAVE_SCX_TASK_REENQ_PREEMPTED
 #define HAVE_SCX_TASK_CURSOR
 #define HAVE_SCX_ECODE_RSN_HOTPLUG
 #define HAVE_SCX_ECODE_RSN_CGROUP_OFFLINE
@@ -114,6 +120,7 @@
 #define HAVE_SCX_OPS_ENQ_MIGRATION_DISABLED
 #define HAVE_SCX_OPS_ALLOW_QUEUED_WAKEUP
 #define HAVE_SCX_OPS_BUILTIN_IDLE_PER_NODE
+#define HAVE_SCX_OPS_ALWAYS_ENQ_IMMED
 #define HAVE_SCX_OPS_ALL_FLAGS
 #define HAVE___SCX_OPS_INTERNAL_MASK
 #define HAVE_SCX_OPS_HAS_CPU_PREEMPT
@@ -131,6 +138,9 @@
 #define HAVE_SCX_REENQ_ANY
 #define HAVE___SCX_REENQ_FILTER_MASK
 #define HAVE___SCX_REENQ_USER_MASK
+#define HAVE_SCX_REENQ_TSR_RQ_OPEN
+#define HAVE_SCX_REENQ_TSR_NOT_FIRST
+#define HAVE___SCX_REENQ_TSR_MASK
 #define HAVE_SCX_RQ_ONLINE
 #define HAVE_SCX_RQ_CAN_STOP_TICK
 #define HAVE_SCX_RQ_BAL_KEEP
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 5da50f937684..dafccbb6b69d 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -67,6 +67,12 @@ const volatile u64 __SCX_TASK_RESET_RUNNABLE_AT __weak;
 const volatile u64 __SCX_TASK_DEQD_FOR_SLEEP __weak;
 #define SCX_TASK_DEQD_FOR_SLEEP __SCX_TASK_DEQD_FOR_SLEEP
 
+const volatile u64 __SCX_TASK_SUB_INIT __weak;
+#define SCX_TASK_SUB_INIT __SCX_TASK_SUB_INIT
+
+const volatile u64 __SCX_TASK_IMMED __weak;
+#define SCX_TASK_IMMED __SCX_TASK_IMMED
+
 const volatile u64 __SCX_TASK_STATE_SHIFT __weak;
 #define SCX_TASK_STATE_SHIFT __SCX_TASK_STATE_SHIFT
 
@@ -115,6 +121,9 @@ const volatile u64 __SCX_ENQ_HEAD __weak;
 const volatile u64 __SCX_ENQ_PREEMPT __weak;
 #define SCX_ENQ_PREEMPT __SCX_ENQ_PREEMPT
 
+const volatile u64 __SCX_ENQ_IMMED __weak;
+#define SCX_ENQ_IMMED __SCX_ENQ_IMMED
+
 const volatile u64 __SCX_ENQ_REENQ __weak;
 #define SCX_ENQ_REENQ __SCX_ENQ_REENQ
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index fc9a7a4d9dea..bbd4901f4fce 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -26,6 +26,8 @@
 	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_QUEUED); \
 	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_RESET_RUNNABLE_AT); \
 	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_DEQD_FOR_SLEEP); \
+	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_SUB_INIT); \
+	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_IMMED); \
 	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_STATE_SHIFT); \
 	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_STATE_BITS); \
 	SCX_ENUM_SET(skel, scx_ent_flags, SCX_TASK_STATE_MASK); \
@@ -42,6 +44,7 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_WAKEUP); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_HEAD); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_PREEMPT); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_IMMED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_REENQ); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
-- 
2.48.1

