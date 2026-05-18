Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E43ED11F
	for <sched-ext@lists.linux.dev>; Mon, 18 May 2026 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110012; cv=none; b=nWi7pfHNGAt1PIs8U4AA1K7RvUgaWeAT5v27xB9FChT8mgwsr39Nj8OkS4fvjDcBG3C5ldiJWVsE1eBgODyzdCouyBkDXarJYMO+jy3mQyZLHShOGR+rJiXSizg7ew9uD+mjrgPs/zWJHV8qyLYHzMNq2dsQLDV8if5QNs77Yuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110012; c=relaxed/simple;
	bh=gfn4n8kLvSvmBLrFa7nK9KJ0o4ezPxYyfGoVBhhjmmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGIMcqKzDR0QbCoYw1fBbs2oG7pVHruLO5iRdPWXYjuLrjNB0kYVA15ul2pGQze75G/C87/a8R696EtpOu8c6QXkBZeiLGfWUBuNOo8UqFfoon2T2cLkIgV7p9STBiZKPeHypY67HtZG0cwSeNpFPFMh5vIa+qfvoYm8JEKXFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EP2Lrj8B; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EP2Lrj8B"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3680540a6efso1103786a91.2
        for <sched-ext@lists.linux.dev>; Mon, 18 May 2026 06:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779110010; x=1779714810; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2yV5ygy34zIi+9sEwrpb4LJsBjHapnVySkb2gOudNI=;
        b=EP2Lrj8BemGIErtfsDpDAbJ0b4OnVDgkafSN8dBy9gi/BHN66hVFXIJYHsmTe90+ev
         gLm4447vVhB6bbD/8PhJcHN0tpXNahqvbd+dUuKYZHBnx2Ah2om+AHr2wQMxTB8ajSY4
         KKpbCfBvfEb45vmK91+ouWIszBEVskESgoqvgyPRK95oSz71MYDUhQNf/aLphZWiko6y
         AoH2Fx2aX+jyaY3LvGSKHYHLBUQbdvVs4rIraSsnR1yFL1femkEyriClTYdk1YYhWK67
         5aUxVmDHgXMVg2YSADzdURxfSfYbHUatinA1DV/KoTfuErWd0ySAmWYWY7KTB7GJLobt
         2grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110010; x=1779714810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k2yV5ygy34zIi+9sEwrpb4LJsBjHapnVySkb2gOudNI=;
        b=XqdGgqHliPmFLi6lgPjxEH8KYLTVvwuB76h7EWEAWtp9DS5XGECvBDPr/ydhjuxNOr
         NZslPDZPL3XGI0jNtNZBV6HcrOTxRiqpr9GrqsAr4GHO3+blCJFl5OiJp5FtMI1RJL3P
         2jH5tFL3jS6DYTP0SABtdW7zykEuK3uz0i8hbHzWw+aTe/Q9m7hRiaATmSnoh8mTZIX3
         Qcow3ASEC0Yq2BRz69x4jiC72umKMSV7s5aQxpAMKOUtbg6AhVOuDGOEqfRafQJslFi0
         KZ6JEqtq9+sbpwgQKdn2pHdCDxa2t1GlubT4VhSBadlB2vbR+cLtaZhBJOI8J24f+lk/
         izkw==
X-Gm-Message-State: AOJu0YzzdJIHWiNvd4Zkom9yum9D30DQX/6UdE5m8PSYGSXjsSpPc76i
	OJNfTTBAqeI5aNah2gz94MROGNzfXYipjawB1q+jhj9Vi6BxoA0mY1bA7t3kbw==
X-Gm-Gg: Acq92OFH5zoTEpRkNEfVDUKUnyhFINi0mxAWM7o+O52879l2R2k/ED3T0u8nD16faw6
	ZSvKWBK52V7WhBdA5m1wV8lVu+7yqGjVYObftvUVZs/n0J+Vl+9bv+cwgmRnY9STC4lfInHG32q
	Ut04HkA4hg+iH+aMOohQQK/Eu30jdzijo4tO1sKXqXqQF56Fk59Sw2t9ZgAFoPGDwqRB8BmMzN4
	+vYic/JM8vq6Bm6sFOkZnxbcG37AxUMZsWx3cWDVqOvWtu68uDXf0vsObGg5D9O14DrfCLyc42I
	BTB9E8jF66aNUlguCQOmaqEj+HJU+vhZAkU/frTMr90AHZ7HzhlEoTr4RHN6vU4XUdnajbYUsna
	0JAVL0N6ZukkxOr4TRoIacROMMPEQW760tfCQMCffl7Qcxpb2A8lhCaXvztjSzPe7AN6SNv6yv1
	8+zFlH+1Ol43bRL2alzR9P1faC45e6+pr4zPVJ2zUzsoUwl2aDWyYD
X-Received: by 2002:a17:90b:1d83:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-36951889fe9mr13316303a91.1.1779110010242;
        Mon, 18 May 2026 06:13:30 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c31b:5187:c514:ac40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369512424c2sm11241781a91.4.2026.05.18.06.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:13:29 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH v3 1/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Date: Mon, 18 May 2026 21:11:48 +0800
Message-ID: <20260518131311.1170786-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260518131311.1170786-1-yphbchou0911@gmail.com>
References: <20260518131311.1170786-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_lockup() uses raw_smp_processor_id() for exit_cpu, which is wrong
for two paths:

- scx_hardlockup_irq_workfn() has the hung CPU in a local variable but
  irq_work may run elsewhere. Pass the local cpu explicitly.
- scx_rcu_cpu_stall() records the detector CPU rather than the stalled
  one. Pass -1 for now. The next patch fixes this properly.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c          | 12 +++++++-----
 kernel/sched/ext_internal.h |  2 --
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9c458552d14f..22b1356aa4eb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5141,6 +5141,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
 
 /**
  * handle_lockup - sched_ext common lockup handler
+ * @exit_cpu: CPU to record in exit_info. Pass the stalled/hung CPU, not current.
  * @fmt: format string
  *
  * Called on system stall or lockup condition and initiates abort of sched_ext
@@ -5150,7 +5151,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
  * resolve the lockup. %false if sched_ext is not enabled or abort was already
  * initiated by someone else.
  */
-static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
+static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
 {
 	struct scx_sched *sch;
 	va_list args;
@@ -5166,7 +5167,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
 	case SCX_ENABLING:
 	case SCX_ENABLED:
 		va_start(args, fmt);
-		ret = scx_verror(sch, fmt, args);
+		ret = scx_vexit(sch, SCX_EXIT_ERROR, 0, exit_cpu, fmt, args);
 		va_end(args);
 		return ret;
 	default:
@@ -5188,7 +5189,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
  */
 bool scx_rcu_cpu_stall(void)
 {
-	return handle_lockup("RCU CPU stall detected!");
+	return handle_lockup(-1, "RCU CPU stall detected!");
 }
 
 /**
@@ -5203,7 +5204,8 @@ bool scx_rcu_cpu_stall(void)
  */
 void scx_softlockup(u32 dur_s)
 {
-	if (!handle_lockup("soft lockup - CPU %d stuck for %us", smp_processor_id(), dur_s))
+	if (!handle_lockup(smp_processor_id(), "soft lockup - CPU %d stuck for %us",
+			   smp_processor_id(), dur_s))
 		return;
 
 	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU %d stuck for %us, disabling BPF scheduler\n",
@@ -5222,7 +5224,7 @@ static void scx_hardlockup_irq_workfn(struct irq_work *work)
 {
 	int cpu = atomic_xchg(&scx_hardlockup_cpu, -1);
 
-	if (cpu >= 0 && handle_lockup("hard lockup - CPU %d", cpu))
+	if (cpu >= 0 && handle_lockup(cpu, "hard lockup - CPU %d", cpu))
 		printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
 				cpu);
 }
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 7258aea94b9f..3ccfea06cba0 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1490,8 +1490,6 @@ __printf(5, 6) bool __scx_exit(struct scx_sched *sch, enum scx_exit_kind kind,
 	__scx_exit(sch, kind, exit_code, raw_smp_processor_id(), fmt, ##args)
 #define scx_error(sch, fmt, args...)						\
 	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
-#define scx_verror(sch, fmt, args)						\
-	scx_vexit((sch), SCX_EXIT_ERROR, 0, raw_smp_processor_id(), fmt, args)
 
 /*
  * Return the rq currently locked from an scx callback, or NULL if no rq is
-- 
2.48.1

