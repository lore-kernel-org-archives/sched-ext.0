Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9643E63BA
	for <sched-ext@lists.linux.dev>; Tue, 14 Apr 2026 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776171581; cv=none; b=EMIi5j3jWnW/3UL5fUck1bbf/b8npMRN65WsbgiqemIGcWtxQiPxcNTE07Ck8oraTEERkqgK5Ru/KWU8gbSaWTgdy1MVYKrFR5uIrH1hNm03W3xENocNnkYGjAgfe339utQXRJmwhhWuXSyDNUrVM18cD+4Imio55JMA7N+C1VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776171581; c=relaxed/simple;
	bh=WQHdgxfWlX0aPB6RR7aILl83Gc2XgUcket5ljTMUvjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sSkWyhmDj0Z0CfUqjFdZ3tBPJFBSr156ctMiNNb7z7kt1KIkVbu/AvUN4luHEZ1CtQRTYgRWBo0cDTquEbmOgB5EilJ4y1Hs7J1agK6uZG5R7vWbrkYuFU85pLvYfhxuZ/nawIKDSqpmGraOfp4BLyLTLCBi8QF4D0WU+SbAIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKdtkZhT; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKdtkZhT"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66b2d49ffb0so7282906a12.3
        for <sched-ext@lists.linux.dev>; Tue, 14 Apr 2026 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776171579; x=1776776379; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cdLGnEYh10cO+yUbeSf7mdF0hSaGC/uTtDvKw2e8EtU=;
        b=YKdtkZhTZTWcjhoYyF0LNPq4gTVMHcnEpnL6Lj+TchoIZ9s9G090xfLQzfvvqTwMzb
         8HyOzmt428aeMkt/QAt2SuMZLs01bxUAgC/Q0YdJfRIb28SSkyf6eVHFZxODwerkx2Ij
         w0urtZlYb5fi7ncAWKWEx3oTPi+AqfOHidE3bMqiN7uf1V4j2irtl/QJ8Ieer493XPV8
         dWPtqPKYjtimqb+Vz6T67zV+E56MkdLDtTn9UO9FdFCJ8z9N91ataLa4bjHYqVmRpE5U
         qqQl9pgEXX+FZScdDalRTTRKm9aLSULa51OHQrg3dzzX6/G/Gy6EO0GLrEbTaZ6lSx4D
         SYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776171579; x=1776776379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdLGnEYh10cO+yUbeSf7mdF0hSaGC/uTtDvKw2e8EtU=;
        b=nQgnc/Ba/x2PKKzdGvr65crJvjPe1Rt9XW0a2aY98Y7MLAny8z0ldJ0bvHV6+vfBb7
         NL03JInF73/5RrR7vQbffSwFwivirgScKwyFQHenB9DcQDrJk+pWprAfSzjw3THy+5cz
         exJlE9ltCelIRYHODZKfvHRyjzi7kf8gwbk6GvoQwJje156s00ep0IfwcGbpvZMx/wVw
         kDYE5FuD1aJAtfaqEUsXhzo+UgDN1Vu+gd2vr1Lcb+wkIQryYpTFFv75CbHq5yhPXxb5
         XpbgpEhQx8Ix0RE2PJOJO5RmO/YoPAJM/0SEvms1vH7uhW1XUCGECyPfyIrMBuGnqpqu
         e+6A==
X-Forwarded-Encrypted: i=1; AFNElJ97CpMswxx0dLCvxixdObAZAtMtzsYqMyiVlJtPfBz887MYKyloiJqsjbAC0DESmXCzb5x34S6MOBQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxqrNvroY2RZdwtUqtKfa3WWKfp7PLjayO/1hMj5SoZwgOob9rW
	5XP7Goq8uC93vg/O1Znvbfk2z3R79/tQ8tAlihk//1xO8UsJBKKHCEWc
X-Gm-Gg: AeBDietAt6/FnsS1i09Fxkjqv9sBMZSdZMmtqq12s2DI+dTKlTp7KJEP6NCEXDKfN/C
	13e47AvVOAXZBbvaY/JiWIsNvkAnyJgmvMzabC/q5iytsU17m7SlOkbDtnGJQ0kdoW7sqL5IanU
	3VOkmCaN1u3kQMZ/9pckf7zkjOAHJv/ZRVbEyQvberyXvuBC5znMSHX9TucCgbDm3lQnrOUVSEg
	9IgNHDW66uHOP2hKkgkIsZiuQopBpAvGnnlxr1C9eYMLjcOxJRvdkb/2AfAQoxy8fRqByqocU+D
	PyL/K9H0rbOU+tzklHk+/Af3raz67V20p9tmL/lRwL+mRuNoTmI2H/lXodvKSdaIMzlWLa1qWBz
	a7X3MWAuEIBCKK6n1VgKnhxxXSJHs0JGgqeUBWAms+XlDJl4DlyGqSIQltIAZ52Igbqt9Hfk2k5
	/fNmeezNYQhrAxVsoKPPMlJ+Adt68EAtGF9L5B5QMY/JTQQwuw4xl8lVyNGdU4Fb1EJPyD8tI=
X-Received: by 2002:a17:907:78c:b0:b96:ef71:49f9 with SMTP id a640c23a62f3a-b9d724f02f4mr994414966b.9.1776171578288;
        Tue, 14 Apr 2026 05:59:38 -0700 (PDT)
Received: from alala.sintef.no ([78.91.103.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6dfd89a9sm402687666b.25.2026.04.14.05.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:59:37 -0700 (PDT)
From: Fredrik Boettger Bratberg <fredrik.b.bratberg@gmail.com>
To: fredrik.b.bratberg@gmail.com
Cc: Henrik Austad <henrik@austad.us>,
	Peter Ziljstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	sched-ext@lists.linux.dev
Subject: [RFC PATCH] sched: add CONFIG_SCHED_EXT_RT_EXPERIMENTAL to move SCHED_EXT above SCHED_RR/SCHED_FIFO
Date: Tue, 14 Apr 2026 14:59:33 +0200
Message-Id: <20260414125933.3520885-1-fredrik.b.bratberg@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: fredrikBB <fredrik.b.bratberg@gmail.com>

sched_ext is a great tool to quickly develop and test custom scheduling
policies. However, a current limitation of sched_ext is that it is fixed
between the idle and fair classes in the scheduling class hierarchy. This
makes it problematic to implement new real-time policies with sched_ext.
For research and experimental purposes, it is useful to have the option to
increase sched_ext priority relative to the other classes.

One particular use case is the implementation of mixed-criticality
schedulers such as EDF-VD, where real-time capabilities are required. In
such cases, a priority equal to or higher than that of SCHED_RR and
SCHED_FIFO is desired in order to limit interference by other tasks.
Framed differently, this option enables experimentation with custom
real-time scheduling policies in sched_ext.

A recent paper published in the 2025 Real-Time Systems Symposium (RTSS)
"Enabling Flexible Scheduling in ROS 2", would presumably also benefint
from this feature. The paper aims to address and improve the real-time
capabilities of Robot Operating System 2 (ROS2). As part of their paper
they implement an EDF using sched_ext. They do not explicitly address the
issue of their EDF SCHED_EXT tasks effectively having a lower priority than
SCHED_NORMAL, but it is a known limitation of the current sched_ext class
placement

This change conditionally reorders sched_class selection such that, when
enabled:

  STOP > DL > EXT > RT > FAIR > IDLE

Normally, it is possible to schedule all fair-class policies under
sched_ext. CONFIG_SCHED_EXT_RT_EXPERIMENTAL removes this possibility in
order to prevent fair-class policies from effectively increasing their
precedence in the scheduling class hierarchy. This is done by forcing
scx_switched_all() and scx_switching_all to false.

This patch has been tested on a BeagleV-Fire development board with
PREEMPT_RT enabled on the 6.18.6 kernel, and it made SCHED_EXT tasks be
preempted by SCHED_RR / SCHED_FIFO tasks to a much lesser extent as
desired. However, it still occasionally happen that SCHED_EXT tasks gets
preempted by other tasks which do not run in an hard IRQ context. Comments
regarding why this can be the case are also greatly appreciated.

Reviewed-by: Henrik Austad <henrik@austad.us>
Signed-off-by: Fredrik Boettger Bratberg <fredrik.b.bratberg@gmail.com>
Cc: Peter Ziljstra <peterz@infradead.org> 
Cc: Tejun Heo <tj@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Henrik Austad <henrik@austad.us>
Cc: linux-rt-devel@lists.linux.dev
Cc: sched-ext@lists.linux.dev
---
 include/asm-generic/vmlinux.lds.h | 13 +++++++++++++
 kernel/Kconfig.preempt            | 16 ++++++++++++++++
 kernel/sched/core.c               |  6 ++++++
 kernel/sched/ext.c                | 11 +++++++++++
 kernel/sched/sched.h              |  8 ++++++++
 5 files changed, 54 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e04d56a53..3fe9504c4 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -133,6 +133,18 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
  * used to determine the order of the priority of each sched class in
  * relation to each other.
  */
+#ifdef CONFIG_SCHED_EXT_RT_EXPERIMENTAL
+#define SCHED_DATA				\
+	STRUCT_ALIGN();				\
+	__sched_class_highest = .;		\
+	*(__stop_sched_class)			\
+	*(__dl_sched_class)			\
+	*(__ext_sched_class)			\
+	*(__rt_sched_class)			\
+	*(__fair_sched_class)			\
+	*(__idle_sched_class)			\
+	__sched_class_lowest = .;
+#else
 #define SCHED_DATA				\
 	STRUCT_ALIGN();				\
 	__sched_class_highest = .;		\
@@ -143,6 +155,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	*(__ext_sched_class)			\
 	*(__idle_sched_class)			\
 	__sched_class_lowest = .;
+#endif
 
 /* The actual configuration determine if the init/exit sections
  * are handled as text/data or they can be discarded (which
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index da326800c..553d22605 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -189,3 +189,19 @@ config SCHED_CLASS_EXT
 	  For more information:
 	    Documentation/scheduler/sched-ext.rst
 	    https://github.com/sched-ext/scx
+
+config SCHED_EXT_RT_EXPERIMENTAL
+	bool "[EXPERIMENTAL] Increase sched_ext priority above SCHED_CLASS_RT"
+	depends on SCHED_CLASS_EXT
+	help
+	  This option increases sched_ext's class precedence above SCHED_RR and
+	  SCHED_FIFO which improves the real-time capabilities of sched_ext.
+	  Normally the sched_ext scheduler is placed in between the fair
+	  and idle scheduling class, which can cause exessive preemption of
+	  SCHED_EXT tasks by both real-time and fair class tasks.
+
+	  Note that this option will force SCX_OPS_SWITCH_PARTIAL, meaning only tasks
+	  with the SCHED_EXT policy can be scheduled by sched_ext. This
+	  is in contrast to the default behaviour where all SCHED_NORMAL,
+	  SCHED_BATCH, SCHED_IDLE, and SCHED_EXT tasks are scheduled by
+	  sched_ext when the BPF scheduler is loaded and running.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index eb47d294e..93d16f665 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8654,8 +8654,14 @@ void __init sched_init(void)
 	BUG_ON(!sched_class_above(&rt_sched_class, &fair_sched_class));
 	BUG_ON(!sched_class_above(&fair_sched_class, &idle_sched_class));
 #ifdef CONFIG_SCHED_CLASS_EXT
+	/* Reorder BUG_ON if sched_ext is moved in the hierarchy */
+	#ifdef CONFIG_SCHED_EXT_RT_EXPERIMENTAL
+	BUG_ON(!sched_class_above(&dl_sched_class, &ext_sched_class));
+	BUG_ON(!sched_class_above(&ext_sched_class, &rt_sched_class));
+	#else
 	BUG_ON(!sched_class_above(&fair_sched_class, &ext_sched_class));
 	BUG_ON(!sched_class_above(&ext_sched_class, &idle_sched_class));
+	#endif
 #endif
 
 	wait_bit_init();
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 31eda2a56..dea807971 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4776,7 +4776,15 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 * All tasks are READY. It's safe to turn on scx_enabled() and switch
 	 * all eligible tasks.
 	 */
+/*
+ * If sched_ext is elevated in the scheduling hierarchy, we cannot allow
+ * sched_ext to schedule tasks part of the fair classes.
+ */
+#ifdef CONFIG_SCHED_EXT_RT_EXPERIMENTAL
+	WRITE_ONCE(scx_switching_all, false);
+#else
 	WRITE_ONCE(scx_switching_all, !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
+#endif
 	static_branch_enable(&__scx_enabled);
 
 	/*
@@ -4819,8 +4827,11 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		goto err_disable;
 	}
 
+/* When running with SCHED_EXT_RT, only allow switch_partial */
+#ifndef CONFIG_SCHED_EXT_RT_EXPERIMENTAL
 	if (!(ops->flags & SCX_OPS_SWITCH_PARTIAL))
 		static_branch_enable(&__scx_switched_all);
+#endif
 
 	pr_info("sched_ext: BPF scheduler \"%s\" enabled%s\n",
 		sch->ops.name, scx_switched_all() ? "" : " (partial)");
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2f8b06b12..6e9c1cae7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1762,7 +1762,15 @@ DECLARE_STATIC_KEY_FALSE(__scx_enabled);	/* SCX BPF scheduler loaded */
 DECLARE_STATIC_KEY_FALSE(__scx_switched_all);	/* all fair class tasks on SCX */
 
 #define scx_enabled()		static_branch_unlikely(&__scx_enabled)
+/*
+ * If sched_ext is elevated in the scheduling hierarchy, we cannot allow
+ * sched_ext to schedule tasks part of the fair classes.
+ */
+#ifdef CONFIG_SCHED_EXT_RT_EXPERIMENTAL
+#define scx_switched_all()	false
+#else
 #define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
+#endif
 
 static inline void scx_rq_clock_update(struct rq *rq, u64 clock)
 {
-- 
2.34.1

