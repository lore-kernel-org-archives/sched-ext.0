Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769832E72F
	for <sched-ext@lists.linux.dev>; Sun, 12 Apr 2026 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776017903; cv=none; b=Drt1eMd5pDx4DB0CtN5IuBCxzW4gX4V1DLJ17WHpqCjj2QdLlb00jALmlVSKxCWf2A59C1mAoXkDsCOhWjgAPrYqEjPWlT8O45Jk4NfJ2TMcKP7mhIDZzuYyGO2NcQibB70AG2KcxFzzdwOSmO0Fd3uY5EyqrU5FgadWty7KpSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776017903; c=relaxed/simple;
	bh=PFVCOffAPTXBDK7gsUNjcLIhH9SzTZK2CoweMyo/t14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1cNNG7L9/Toc6BMEANnzfNM9Ml7WyHUikHwAIWh0P/lpVkxeQE7k9LaHhrUh0g6lnJgJxSVnz6utJPdhN5u6hYRYhGqG5xRjc1TKbubzcRhMpGUGvDg1Ls/J6WxoQJ6cNvJk51GzCUHCiu/ZHCLcnVax2Y4Y4K96v1apxUEsjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwnrVI3U; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwnrVI3U"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f0884bcfaso1936378b3a.1
        for <sched-ext@lists.linux.dev>; Sun, 12 Apr 2026 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776017901; x=1776622701; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d0lXBCiOMkoFu4Tr3Z4bw4jVhAqhzUpwDXkACUdSblo=;
        b=OwnrVI3U765XVeoaQhOFPXiw1KBBXpUBX3FVxNS1CV0uyp5fH0NNNzie7gDBd68Lw1
         qWfPqe3IJ4q0tU+Vei0E9JInPHlZmUOcOk/nvEMdPiG2qUwFOs1nz01PMK3LlYzVBP+E
         MB67d/gCnyVg9Bp84yMcgy8oTAN4yft1WzGPpF14HRp2/h98RAo032fkSdvgiKU9VSLd
         h+WckzEq599iIAOY0NMunp+p+yUcNVKHDFzDpnhKZKqRfQVnJOB3NVb9ETnbjSyVysIs
         gUptfgjxSaBPHfdTRO7K09QYn+2e58EqCbyE71VOWX6w8ONCXMdm4ygzNUkDRszB2iDs
         m0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776017901; x=1776622701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0lXBCiOMkoFu4Tr3Z4bw4jVhAqhzUpwDXkACUdSblo=;
        b=syhxbfMwHpgGLzJ+TDbo/TzU70tyXvO1vk7WWIT3XK0Vss18VRUA01C4ibQfKlB1eR
         6FU3ikykuP1jLPwEqmbB7HCDMcObxwbxF+ElUkG3VYuXSza207RLTVbMMJhA+f7rP8TJ
         xJGDXS/FgYuWZgs+5kSAivVEjodLR6RmKISaHmfvwLQ4iTs6IsjUBwHX/MAOXKXw0yrA
         ASPJdwAj5Dz/urasNPRLQLsAvJ0XOwylNKGqwnqPUfaSLxeg+JLV8G3k+k9GcWkwkvz8
         S9orEYRqqefPpLGgx2AoxZroSVYEnwefijl4RzEnlDFMqjMs8rnSQ1jOsRWPrBG5hI7o
         qZFg==
X-Forwarded-Encrypted: i=1; AFNElJ8C37X945Ql5IA+vvdcIa1I5wBtYmsDY7qxHw/oSlwIDbfv1rJr1XpMA78oV7z01nnWUMXg/xo5mqw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxPku0P30ilcBTdnMicDUS21mz+xCgT28TIAnf6FngtZAjwsadg
	cmePYbP+VuCNHXZzATaa3AkCoR7ddRljmqFzkmteM8BkLg9ABtPm5Mxo
X-Gm-Gg: AeBDiesY2Jw9wgiyINVeH0V+qGmCLz0GsR4MLnp0jg346odnyQl9ST38x4X4GsA3gmB
	myibYT9gpCqE94ts6UCx+9ob2nNo+ig5UkSxRqTbwEPBe4C8JpF1oMmlXA7rJPcy//aoi0P1R9d
	0bTW0A6M5LiDR2mhYi5boMPhNO/Nmn8OT6cgpvQPO/jOg2c++aXHC94BHs0N8zi6v6Mn+KKJj7X
	8+lqZlowrQdbdvmqxIbXLw0iwoqe+9ox6/Eno8A6F626N/TWNI7W6DZ+afp6f2ZYxpfIZ/Y8cbr
	Rk8t289HuPeHhGUqmL+mAobDL+qISjpejyaXioAIWy+OfjqD9clOwXS9Uze6SCGfW4FF/kqamE6
	X6Mvl3vGgD2RYb+klPH8wdIQy95O5+TL1uh52akF+0yAuO2w1kDKDVTJRcqZfkwDgVbCvyLknZc
	0+bIF8eo2oppTj8Juoq2KDmhfuiZfIS1X9GKH7GC3sjrHA8XoygrQ=
X-Received: by 2002:a05:6a00:4684:b0:82f:1d38:f692 with SMTP id d2e1a72fcca58-82f1d38fc86mr4656821b3a.6.1776017901412;
        Sun, 12 Apr 2026 11:18:21 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:da32:10f:5734:2b9c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b3b29sm8921394b3a.36.2026.04.12.11.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 11:18:20 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH] man7, man2: document SCHED_EXT policy
Date: Mon, 13 Apr 2026 02:16:58 +0800
Message-ID: <20260412181743.276652-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the sched_ext(7) manual page and update existing scheduling
documentation to include the SCHED_EXT policy.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 man/man2/sched_setattr.2      |  11 +++-
 man/man2/sched_setscheduler.2 |   4 ++
 man/man7/sched.7              |  13 +++++
 man/man7/sched_ext.7          | 100 ++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 man/man7/sched_ext.7

diff --git a/man/man2/sched_setattr.2 b/man/man2/sched_setattr.2
index 80a0ac726dcf..d60678f00e72 100644
--- a/man/man2/sched_setattr.2
+++ b/man/man2/sched_setattr.2
@@ -81,6 +81,10 @@ a deadline scheduling policy;
 see
 .BR sched (7)
 for details.
+.TP 14
+.B SCHED_EXT
+for extensible scheduling policies implemented via BPF
+(see \fBsched_ext\fR(7)).
 .P
 The
 .I attr
@@ -95,7 +99,8 @@ struct sched_attr {
     u32 sched_policy;      /* Policy (SCHED_*) */
     u64 sched_flags;       /* Flags */
     s32 sched_nice;        /* Nice value (SCHED_OTHER,
-                              SCHED_BATCH) */
+                              SCHED_BATCH,
+                              SCHED_EXT) */
     u32 sched_priority;    /* Static priority (SCHED_FIFO,
                               SCHED_RR) */
     /* For SCHED_DEADLINE */
@@ -218,8 +223,10 @@ This field specifies the nice value to be set when specifying
 .I sched_policy
 as
 .B SCHED_OTHER
+,
+.BR SCHED_BATCH ,
 or
-.BR SCHED_BATCH .
+.BR SCHED_EXT .
 The nice value is a number in the range \-20 (high priority)
 to +19 (low priority);
 see
diff --git a/man/man2/sched_setscheduler.2 b/man/man2/sched_setscheduler.2
index b4c35543e5bf..825eb7290ee7 100644
--- a/man/man2/sched_setscheduler.2
+++ b/man/man2/sched_setscheduler.2
@@ -67,6 +67,10 @@ and
 for running
 .I very
 low priority background jobs.
+.TP
+.B SCHED_EXT
+for extensible scheduling policies implemented via BPF
+(see \fBsched_ext\fR(7)).
 .P
 For each of the above policies,
 .I param\->sched_priority
diff --git a/man/man7/sched.7 b/man/man7/sched.7
index 00926cd34ecf..2e73a4c716b9 100644
--- a/man/man7/sched.7
+++ b/man/man7/sched.7
@@ -116,6 +116,13 @@ and
 .BR sched_get_priority_max (2)
 to find the range of priorities supported for a particular policy.
 .P
+Since Linux 6.12, there is an extensible BPF scheduling policy
+.RB ( SCHED_EXT ),
+which allows for custom scheduling algorithms to be implemented as BPF
+programs.
+See
+.BR sched_ext (7).
+.P
 Conceptually,
 the scheduler maintains a list of runnable threads for each possible
 .I sched_priority
@@ -529,6 +536,12 @@ priority (lower even than a +19 nice value with the
 or
 .B SCHED_BATCH
 policies).
+.SS SCHED_EXT: Extensible BPF Scheduling
+Tasks with this policy are managed by an extensible scheduler class,
+which allows for custom scheduling algorithms to be implemented as
+BPF programs.
+See
+.BR sched_ext (7).
 .\"
 .SS Resetting scheduling policy for child processes
 Each thread has a reset-on-fork scheduling flag.
diff --git a/man/man7/sched_ext.7 b/man/man7/sched_ext.7
new file mode 100644
index 000000000000..7ea467e18b84
--- /dev/null
+++ b/man/man7/sched_ext.7
@@ -0,0 +1,100 @@
+.TH SCHED_EXT 7 2024-04-13 "Linux" "Linux Programmer's Manual"
+.SH NAME
+sched_ext \- Extensible BPF Scheduler Class
+.SH SYNOPSIS
+.B #include <linux/sched.h>
+.PP
+.B #define SCHED_EXT 7
+.SH DESCRIPTION
+.B sched_ext
+is a scheduling class whose behavior can be defined by a set of BPF
+programs, known as the BPF scheduler. It allows for the implementation
+of custom scheduling algorithms that can be loaded and unloaded
+dynamically.
+.PP
+When a BPF scheduler is loaded, it can take over the scheduling of
+tasks that use the
+.B SCHED_EXT
+policy, as well as tasks using standard policies like
+.BR SCHED_NORMAL ,
+.BR SCHED_BATCH ,
+and
+.B SCHED_IDLE ,
+depending on how the BPF scheduler is configured.
+.SS Switching to and from sched_ext
+The feature is enabled via the
+.B CONFIG_SCHED_CLASS_EXT
+kernel configuration option.
+.PP
+A task can explicitly request the
+.B SCHED_EXT
+policy using system calls such as
+.BR sched_setscheduler (2)
+or
+.BR sched_setattr (2).
+If no BPF scheduler is currently loaded, tasks with the
+.B SCHED_EXT
+policy are treated as
+.B SCHED_NORMAL
+and scheduled by the default fair-class scheduler (CFS/EEVDF).
+.PP
+When a BPF scheduler is loaded:
+.IP \(bu 3
+If
+.B SCX_OPS_SWITCH_PARTIAL
+is NOT set in the scheduler's flags, ALL tasks with policies
+.BR SCHED_NORMAL ,
+.BR SCHED_BATCH ,
+.BR SCHED_IDLE ,
+and
+.B SCHED_EXT
+are scheduled by
+.BR sched_ext .
+.IP \(bu 3
+If
+.B SCX_OPS_SWITCH_PARTIAL
+IS set, only tasks with the
+.B SCHED_EXT
+policy are scheduled by
+.BR sched_ext .
+Tasks with other policies remain under the control of the fair-class scheduler.
+.PP
+If the BPF scheduler terminates (either normally, due to an error, or
+via a SysRq command), all tasks are automatically reverted to the
+fair-class scheduler.
+.SS System Interfaces
+.B sched_ext
+exposes several interfaces in sysfs for monitoring and control:
+.TP
+.I /sys/kernel/sched_ext/state
+Shows the current state of the BPF scheduler (\fBenabled\fR, \fBdisabled\fR, etc.).
+.TP
+.I /sys/kernel/sched_ext/root/ops
+Shows the name of the currently loaded BPF scheduler.
+.TP
+.I /sys/kernel/sched_ext/enable_seq
+A monotonically incrementing counter that tracks how many times a BPF
+scheduler has been enabled since boot.
+.SS Safety and Debugging
+System integrity is maintained regardless of the BPF scheduler's
+behavior. If a runnable task stalls or an internal error is detected,
+the BPF scheduler is aborted.
+.PP
+The following SysRq sequences are available for emergency management:
+.TP
+.B SysRq-S
+Aborts the current BPF scheduler and reverts all tasks to the fair-class
+scheduler.
+.TP
+.B SysRq-D
+Triggers a debug dump of the current scheduler state to the
+.B sched_ext_dump
+tracepoint.
+.SH SEE ALSO
+.BR sched (7),
+.BR sched_setscheduler (2),
+.BR sched_setattr (2),
+.BR bpf (2)
+.PP
+.I Documentation/scheduler/sched-ext.rst
+in the Linux kernel source tree.
-- 
2.48.1

