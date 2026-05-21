Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C137374E67
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380212; cv=none; b=dU7gxbN0fV8UhLaymyx/H5kgqv1dfdsuaYN7zgIH1PZIhg8dVqp/umyUyma5mcgB87PPIASS5KzB8oHQeP0FtVPOfZI09m/dK5Pgm4OUIFqFLUUtVBHXU78iaM+vkqvq6g1eE+QUS6svRBWJbFz4VJ489PN1ROz8d6uvPVMNkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380212; c=relaxed/simple;
	bh=gfn4n8kLvSvmBLrFa7nK9KJ0o4ezPxYyfGoVBhhjmmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAV4a2E8ODw3iMfYB1exZapuoCeT2/5MD90SxMdgJtkKC8+/YsnpFpq/Q2KbKBkvUIoT4jRMb9MmelFC3aM5hmpdvv+eziSTJPfNunetZ9L6IO8MyD/mseNAxjKX1SHYUXHzWT8b/fMMVH1QXDQM/0aHSwNSDS8BIbVDVmcrlio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNSwydTr; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNSwydTr"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-83ef1d17904so6375702b3a.1
        for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779380211; x=1779985011; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2yV5ygy34zIi+9sEwrpb4LJsBjHapnVySkb2gOudNI=;
        b=mNSwydTrUS6EfXFdGjEqynqfOsM19Cj+5+cb3HAyOSvF9Q1D+zUy3GoJvLpmoGWkyq
         BVa/DGzVYBotN4umBAaap+fhREBEV+SI6Bd4u6IGnbqQdeFwoN0n8YbrJUkfrQ0zRo6T
         eYYLoDVINFnLWQ+PRMq9gHiMEJuwFCDfTtKN8aWXojJQCSQusWgHlch8bDPP/XXoBm0y
         snz1W+Sbt6bNHSZLxkQjqysCOi5VrH1WZWmNtZdblcDGvqejKP1G8xfqdVjb5sA14SnC
         Giv2PGGSpyuBtwbBtzYujyvHOfIPD8+s9Apqca2vFNAjnZxlO6UAA8RkAtKY2Cf27rzb
         bi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779380211; x=1779985011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k2yV5ygy34zIi+9sEwrpb4LJsBjHapnVySkb2gOudNI=;
        b=ahnmMlKNsGO7dG5QNr21NOYii54y+qWEvJje/dHbmPr2TNOeG5bsCNInMjnU6yDTaZ
         7p2CQ/wpsxp0aDKizSWL6e0gVWj+fcd2J6nz37fdkDQUwEutqkf4VaUncPMTBRNO5w8q
         PrOLprg83kDMadBbxV+nQ4aR4TSel31ot/xGyExtlCVFhnCjsbYjKrvE57QEEngRi3oN
         uKrXGXBBKpRH+N8xXHF18O58GtR1jdnQHYs4VjdWYW9xput1jNblhSJsckR87vQAyZMW
         CoaJHPCCmql/sIO1ruksodsl7KRs91hWC90OHehHEA/1KMjYkv3eHXSFlxw9oeMUZgHT
         Pncw==
X-Gm-Message-State: AOJu0YxRinRen2AtPmpgSlSQQT0ZIeNqUkSl/3jbejGCFPCypvC286yY
	mgfwwojBk3thIsXpLRqgB3mgPSHDblXLfst31ZJ+gZ6JcLfvFU0tKi0Gc6ur3Q==
X-Gm-Gg: Acq92OEhlY0YQYeZkiFpiURvmdsIdVfbS4ot6o9JvDQbGqQaT/mnJzR5m3Pe4tlsrU3
	Z7ra9Prexjf/Q174TPFPSxY7c9EiHPzPfoEubhtyWG3DNeup0Eb6uJwfQ4LoL/cH77Lz2OPaMMs
	MuxIJxS/Wzh7NiNoK+ckDo0FpUewiZVeRbCES3pf5IF9etRlbGGv2+rYbmEBVJ7iVrwCR3Cc+jf
	FJ/skP/om+cz95gYy/vi8C0qJ7zLw+uLzr2Kzet3Z3n5Et5MWNPTIkh15ENKootIdXlfWqXU2ll
	yLneL9BRJKTWDXOI07DhJ8W4QQxF1rSIr5q+pAVaCKQYBd8KpJLdStx0R58mMZRfDDUnzdKk50B
	PEVc5l2bEK61AOZ7WAX+aVePpQoI0h8iWGZQA/DRR38kBvt8xBpttOtOpcBSom8UBTcT5UhvhYg
	fh9pe8dIFey5hXkO5g2rGRnBux+9CLH9rkRYN5vVsl0ZlCliqs3p/9
X-Received: by 2002:a05:6a00:430d:b0:82c:2555:b9b2 with SMTP id d2e1a72fcca58-8415f0e87ebmr18418b3a.10.1779380210713;
        Thu, 21 May 2026 09:16:50 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:431c:aecf:2272:9090])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841549c4806sm1729493b3a.6.2026.05.21.09.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:16:50 -0700 (PDT)
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
Date: Fri, 22 May 2026 00:16:09 +0800
Message-ID: <20260521161636.1893894-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260521161636.1893894-1-yphbchou0911@gmail.com>
References: <20260521161636.1893894-1-yphbchou0911@gmail.com>
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

