Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5827B2F8E93
	for <sched-ext@lists.linux.dev>; Wed, 10 Jun 2026 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105261; cv=none; b=tJ4dXPR2y/L2E9Xf7KSlKlEHeJq8ukdeNGAlodPJsjnGo8klxhYr6qpEysCzxZxxX6QdIubV+qxS3klxBYIK7ZObaesKpViHijcU/mz6F8HNcod5TkD1yTSlZaLQaX1rlv7wUO9hA+wjduU0LnsGltaKb0JC7z/CVKyoSFO6k6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105261; c=relaxed/simple;
	bh=Y7Sgz/nq2ViACapjh7GV0aYqHtnpgNTDFxg/Xs8lRDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNv/FQG6zZ2FkGIGKzaHoJWyqz+k2vGk2fljzYhpGiPRSXd/sJsputi6+n7qglRCGvYt5VB+1RHwjkvtqTvXAiJ8Dtb1n7O6TOp/avJpB2nf2zYYdDrVgMZp4MAbLktsbOMwxCfuo9Ykg4VeOJXXBC+RUeY6WHovaiHNTNNrEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMiEfSIg; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMiEfSIg"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8585c51f1fso3230440a12.1
        for <sched-ext@lists.linux.dev>; Wed, 10 Jun 2026 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105260; x=1781710060; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KwLbbL/2J/oqKV1VGplian3GK8W402eH0sQ7ZlH2PE=;
        b=PMiEfSIgDAG/ZUmoyb0ZyN8dSQgTQJZR61wlLh5BgT8p1PpWlieFk6TXVxVSHLC0Og
         4bru24Inej2g+AXRVPHAEI0STBXLaVP9zrj8Sm3LI61OfOFa5SzazKefaUNWdzroMrpM
         KJUpKbvJuc7aQqMEqcF/im7gNmH2o1Y3xI/Z+RIjvcF3ggjMOjRq94FWI7Nt21IrVlE8
         y6jFoFIZD/uPRCjZyPnR04sOAJUynCyzBJ7StoVmV2J8C9CKJeB+IEf6TS9L8Lx2VS4l
         u890Y4poi50cU40BcfuMiBPC/LY5HLQXrPVkeSSsWQLcENT4AoR1T2zy2MloCZdZbITG
         VsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105260; x=1781710060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5KwLbbL/2J/oqKV1VGplian3GK8W402eH0sQ7ZlH2PE=;
        b=qFGtG2p5aGXL3CQxkJoxFf4z3+B7LClPWvevoZRh0LG704gbCX+mL1g2hWcvfUipRP
         P7Wm4sotQzdaYF0gTQqBPb3BCg1/aTwygOgii2rOQqomc+g0dsZBgOcyjn8biDr8ghNM
         zC8NGIwh6l8jXkc3AKSnzRHgcvk3PA/DiJTQdqiBqUbIR2lNquiCLAIEt/8J9Ajyh98y
         +xH2wWhejs/9PaU0mPwK9wvFR/tjLEWdIO4/LNyM/oLwBOShNvTeS2SQD0jgE9ha5Sq9
         VzpeFhiJQRXPJHp1hI5vj4sQhquzBmv314cdJOYIqbuzZgPzQqn5eOsQvlUNgrFPu484
         dakQ==
X-Gm-Message-State: AOJu0Yz4TKpynw5cDg4EIz40vXWrKNRgo9HRvQOa2ztgRQkY5YXxLAgZ
	Ax7GhkLJQHE3/28Zy4jbqyyrdCXKl4o3okHrlGFHH8/wa3kmY1hPyBfz5hD4Fw==
X-Gm-Gg: Acq92OFoWfa9AwxYSjeHWkmaFtxy1a35dgFHnbJHUZru02dj92QGkA0ReVkfaFB5JV6
	5dzyNQ0DJWY9rlSWf6agUIcDOLQnrGpVj58qmt7qbuaGStt8aiprlF0i8vmJv9TVqViO9lsUpML
	9lONeJeLwm+s8dVPHMHMdyiSAYp8YXTH90uKHQdBp08qgCts03+RaRBY2i4sc4OvztFChrhIj0I
	1EeI9sBPZ8zdCb5VsKTNedFLucC9V+lUi5tXtPlnoGqZKYQ/5xtOMJHugPcBYfGm1TtP/rtQGn+
	C5qed2z39NWEJbo1RqWRx4F99/YmIuAIQAqKBzwxMKl5GDohv+PN18+a01blXYQs9l/rBK8msV2
	kyjK7SW2SrpmYcsuKzIJfcuo8Acd78GYX26tTtpZJxvR1bcWMFVP3nhyy1I5PFxc+q5yJcHvdc2
	4vOAPnn+/6WFi78OBMbUCrouAybDVUrTTqCdbA7quenzbUjtlzrs6QQNb4vsCdL60iQw1JlABJ3
	0uVt7tijttRhHSWGpi9Mb4dZPk=
X-Received: by 2002:a17:903:1209:b0:2bc:e299:4b3f with SMTP id d9443c01a7336-2c1ec80a4eamr201655695ad.10.1781105259460;
        Wed, 10 Jun 2026 08:27:39 -0700 (PDT)
Received: from cchengyang.tail151456.ts.net (36-226-225-196.dynamic-ip.hinet.net. [36.226.225.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e573sm253335795ad.47.2026.06.10.08.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:27:39 -0700 (PDT)
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
	chengyang.chou@mediatek.com,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 1/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Date: Wed, 10 Jun 2026 23:26:55 +0800
Message-ID: <20260610152717.15905-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610152717.15905-1-yphbchou0911@gmail.com>
References: <20260610152717.15905-1-yphbchou0911@gmail.com>
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
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c          | 15 +++++++++------
 kernel/sched/ext_internal.h |  2 --
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8f82407330ae..161a7a2ca80f 100644
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
@@ -5267,11 +5268,13 @@ bool scx_rcu_cpu_stall(void)
  */
 void scx_softlockup(u32 dur_s)
 {
-	if (!handle_lockup("soft lockup - CPU %d stuck for %us", smp_processor_id(), dur_s))
+	int cpu = smp_processor_id();
+
+	if (!handle_lockup(cpu, "soft lockup - CPU %d stuck for %us", cpu, dur_s))
 		return;
 
 	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU %d stuck for %us, disabling BPF scheduler\n",
-			smp_processor_id(), dur_s);
+			cpu, dur_s);
 }
 
 /*
@@ -5286,7 +5289,7 @@ static void scx_hardlockup_irq_workfn(struct irq_work *work)
 {
 	int cpu = atomic_xchg(&scx_hardlockup_cpu, -1);
 
-	if (cpu >= 0 && handle_lockup("hard lockup - CPU %d", cpu))
+	if (cpu >= 0 && handle_lockup(cpu, "hard lockup - CPU %d", cpu))
 		printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
 				cpu);
 }
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b04701190b23..bddfa59f1b75 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1535,8 +1535,6 @@ __printf(5, 6) bool __scx_exit(struct scx_sched *sch, enum scx_exit_kind kind,
 	__scx_exit(sch, kind, exit_code, raw_smp_processor_id(), fmt, ##args)
 #define scx_error(sch, fmt, args...)						\
 	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
-#define scx_verror(sch, fmt, args)						\
-	scx_vexit((sch), SCX_EXIT_ERROR, 0, raw_smp_processor_id(), fmt, args)
 
 /*
  * Return the rq currently locked from an scx callback, or NULL if no rq is
-- 
2.43.0

