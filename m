Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583263909A9
	for <sched-ext@lists.linux.dev>; Sun, 31 May 2026 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241279; cv=none; b=isZZGPGE/ecbIUxGHza4OPbcp2g6KNeojJVCtNq/S0LACAGuOuCwIQP5JGUwylPd9yv4UEGE8mKCOYaLJed4hMCB0SSLfvb11tfRQtXXeUOW90Jh1utFw+ltxCKPu31HL+eKaG6Elt/b14NKHoIbJiO7Z2AwJLXslRDVcbwc3/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241279; c=relaxed/simple;
	bh=OnyzdsPvb2VVK+jblskJN4wpnGwAr20TCywLCNXdBg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVL/Sh5r7KHbnyzm05AcJ/Bjz1FH2prBAfRh3P4L1LozP64yWoEkzyYZ7Yj1F8Y32w+aF8oTBnODBl0OGFrKYd+dUIgsgSfvosIrRtj18dD73c7kthxShN6pM2xhkAogIqinPsUuWEAtNw8TiyM8ZPwBHPSCw7/EIpHgSd4TwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBF6thix; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBF6thix"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c2d792c8so3102565ad.1
        for <sched-ext@lists.linux.dev>; Sun, 31 May 2026 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780241276; x=1780846076; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dRI8XaV8GqMcpPiucNvllomgPC9XiBTTrB9N8R+RrM=;
        b=RBF6thixBaHx4wFvdRDgPesuXJ4W5Gz+YLwzB8t40mWqxqo45Llc8+l72C+Rn7pmp2
         DXcwjFSansJzXCxbSr+L93hALncTfYnZ4wtnU0PsE2Isx48iNienyeWE/7Uf8JOFv8Pn
         YUcw0IZWz4zp0Dy8kY24duvXQe6WI13EE9siK+d95WOCSHKQATdt3AnLKmEOZZjONNGH
         G/Wy0tDd6byRaAQ9eeZPkKzVWRbU0awzw4Rmwux5GLvYHZLQGnWTWqDgZfXcaeRTplBe
         487WElDZWzQsgey1Q6nrffsLsp05HtKxUIC3LIByLXRFTkTUQWdJiJ+ZO7qRxYn4j+aO
         bYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241276; x=1780846076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4dRI8XaV8GqMcpPiucNvllomgPC9XiBTTrB9N8R+RrM=;
        b=mBnCosmRGdT8SnKjjDYE/tQVklKJPe05mY49Q+d+nDXlIC5JrAxH+Ygc8fKzJqOGqu
         E4f1MVHI6Fgl6OBGTsYTbqgv8C90Fb0XXAArSY2VqF15T+q0BijJ/5ZA79e610O2RgHJ
         boWn+eE88G3P7AlYcnfuVleu/VbrDjqeLIQdsgTC7aNBILvGRTO25atcERJpLUiB0UFu
         xDuey4tso75CvMPxwuEnUjP99WbRD1540CIxyh3VOUlIbelCNdkDCQeftEkZRtncFJ6v
         wAoUdIo+R1NgkBnEpws1AZsaAYxoOJEQOX+qXLwdA1SGbtLOKSNU+MW8pgHD52dVJfyM
         zROQ==
X-Gm-Message-State: AOJu0YwXlpMswOwV6hXdGHJlci0AaiXhcajZiBfLR+lrdbXDhn5XsARZ
	zE4EvsGO04G6vpVbXTDVAOakayGfxe1CTVRNCdDbgllF53ZprheYLpw0t4GfgA==
X-Gm-Gg: Acq92OEyKRpDZBYb5KFAuoXAEW6YUhaPTirAUfDx0sd8fet2VaCBMBQRCddSxDc+2Xw
	0M0bru/cg7MAfbh4apKVnhf9SWWsnhaQf6hQaZx9aB9TkzxeMHyKsG7xLZvJEPdEWF/xP+2NxS4
	3sc7l9iW/z+c8i34MrNnv+xro0SZOxpPNEDUcMwcdD+eKbdynF4Cys9lhJxpoZf9sKOopTid8PE
	a17IoQ7QL6UoPeTu8ZdeAJXZj8K4x+mznWeBo9fdMl6cvAH+l32zn24VnnwzMzui4yvQ87VBGoz
	Syw3W+4QA1N+BFD5brDyetdw4ZgrdjKDDUPB/vSWg1mIF6FJTz+79WkucYajog6eGjke3dJISLT
	4rmCmCnoOTZ/DmnNF4AL2j5ud699g0+g96+sDX7j5/k5ptm1cSI6E2VtmeNibKRuYWkmcG9JZHU
	0aH6FaRAQBvVQSBgy1myDLdfaa9b4GGyuTOdu/7PHlWrlzNXggxodhH0+Q+50TegIaAf+twBOZS
	Q==
X-Received: by 2002:a17:903:41c9:b0:2c0:c0fa:1659 with SMTP id d9443c01a7336-2c0c0fa18a9mr37485775ad.33.1780241276439;
        Sun, 31 May 2026 08:27:56 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:1fc8:a0da:7205:7281])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a00c13sm83921845ad.28.2026.05.31.08.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:27:55 -0700 (PDT)
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
Subject: [PATCH 1/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Date: Sun, 31 May 2026 23:25:26 +0800
Message-ID: <20260531152646.1206799-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260531152646.1206799-1-yphbchou0911@gmail.com>
References: <20260531152646.1206799-1-yphbchou0911@gmail.com>
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
index ffad1a90196f..0c37b5fd58b0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5205,6 +5205,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
 
 /**
  * handle_lockup - sched_ext common lockup handler
+ * @exit_cpu: CPU to record in exit_info. Pass the stalled/hung CPU, not current.
  * @fmt: format string
  *
  * Called on system stall or lockup condition and initiates abort of sched_ext
@@ -5214,7 +5215,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
  * resolve the lockup. %false if sched_ext is not enabled or abort was already
  * initiated by someone else.
  */
-static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
+static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
 {
 	struct scx_sched *sch;
 	va_list args;
@@ -5230,7 +5231,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
 	case SCX_ENABLING:
 	case SCX_ENABLED:
 		va_start(args, fmt);
-		ret = scx_verror(sch, fmt, args);
+		ret = scx_vexit(sch, SCX_EXIT_ERROR, 0, exit_cpu, fmt, args);
 		va_end(args);
 		return ret;
 	default:
@@ -5252,7 +5253,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
  */
 bool scx_rcu_cpu_stall(void)
 {
-	return handle_lockup("RCU CPU stall detected!");
+	return handle_lockup(-1, "RCU CPU stall detected!");
 }
 
 /**
@@ -5267,7 +5268,8 @@ bool scx_rcu_cpu_stall(void)
  */
 void scx_softlockup(u32 dur_s)
 {
-	if (!handle_lockup("soft lockup - CPU %d stuck for %us", smp_processor_id(), dur_s))
+	if (!handle_lockup(smp_processor_id(), "soft lockup - CPU %d stuck for %us",
+			   smp_processor_id(), dur_s))
 		return;
 
 	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU %d stuck for %us, disabling BPF scheduler\n",
@@ -5286,7 +5288,7 @@ static void scx_hardlockup_irq_workfn(struct irq_work *work)
 {
 	int cpu = atomic_xchg(&scx_hardlockup_cpu, -1);
 
-	if (cpu >= 0 && handle_lockup("hard lockup - CPU %d", cpu))
+	if (cpu >= 0 && handle_lockup(cpu, "hard lockup - CPU %d", cpu))
 		printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
 				cpu);
 }
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 9bb65367f510..2f15a4d3c534 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1509,8 +1509,6 @@ __printf(5, 6) bool __scx_exit(struct scx_sched *sch, enum scx_exit_kind kind,
 	__scx_exit(sch, kind, exit_code, raw_smp_processor_id(), fmt, ##args)
 #define scx_error(sch, fmt, args...)						\
 	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
-#define scx_verror(sch, fmt, args)						\
-	scx_vexit((sch), SCX_EXIT_ERROR, 0, raw_smp_processor_id(), fmt, args)
 
 /*
  * Return the rq currently locked from an scx callback, or NULL if no rq is
-- 
2.48.1

