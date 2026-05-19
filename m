Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646853DB31C
	for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211092; cv=none; b=FaovS76prefuiyTNDpxk0+LV/Q7s31Kva1Ufs2ft1tQOmOA2m03et0bsCAKjxiFCML08bLH+Pz5f1k5AGAsM8Dh/eeAbMwJr5rvt9YYEqTseX/ZcSSF5ENBT+0Hgoiwm6AOzgIqiRhoURr9r12isjAV2z2aL33yBjsDE5FzwH+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211092; c=relaxed/simple;
	bh=gfn4n8kLvSvmBLrFa7nK9KJ0o4ezPxYyfGoVBhhjmmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1w17cM8QbOD7KG9xxFdxd2jMQpUfbb7caSPUNLD9PQIurW957VK09NhdAviuh7AbkTRG6pxM+5mkzfrTLCHa7u6sPdRdr5opVqpmIltH/qDkBK3KmyOhIMC/ilkKZNEcnfUUQMUj9cLcECUA8COCbZsNcxS4RSfTBuk1rfP2dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffDpNUwQ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffDpNUwQ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3664df30f53so2254070a91.1
        for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779211090; x=1779815890; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2yV5ygy34zIi+9sEwrpb4LJsBjHapnVySkb2gOudNI=;
        b=ffDpNUwQrWG36oXa7uvW74DbYkiCTCd388sSHZMsCAe/O32KEGsd176DFV2jlv5RNz
         u4YCKG60xuh/fw7bmnkiO4RrVUoEcqqPSdRnK01S15xr9Vt6U+lvoZ7ArODXmHSIpfDc
         ULRm4nG6PBMYRFmsrwUEMp5393XZL0UbPUQgfgYfx+JnhLphbMW5ltbfarUqFiJFR9Pr
         RpgB5bzWSUbwHF4g1N0vJLP9YKY9eUnD66AMjqGOlE8+WWVaLylYj1eyllBXv1zWbkCf
         PnSYuS6Q8JpjCF5fzbh6zgqOkWf7jpdmizFA/mjHdRibZvIbd4ukLNANrsdZqZjfH4Uc
         prSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779211090; x=1779815890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k2yV5ygy34zIi+9sEwrpb4LJsBjHapnVySkb2gOudNI=;
        b=VpuqzhDU69Y4/vfso7oW1IACPrnQWEeHhY5K186R46dpeKBO31LEhQ9wRc8wqrkqGf
         xh0xzYBN+kLAMqRnR7JNWCv8ySrOcuYkqmwtgJcBPX9fX3+fPwJENNu69A6aqSrTGOZR
         gOdyDMdz7Gejh1iKJ1ZoFs2XJBYmI0ytcH0VPsXx04x6WS3/VAIJ/C5MR8mOqOW/OXCq
         5g9g0J5NRYOIrqYlq0+ct2oZPhyHXIKKRJZWOHt1Uh2baLncMPiDr44nvAisxlXtYRbC
         ZaZFAPsSr87mRgeiQOIgolYifMcsqWHKxrFMQFoq9MvTHSFEaMAnD5Q+y8rCJlZVrBhk
         lOzg==
X-Gm-Message-State: AOJu0YwTuUCxYl+uMiMD/ZZUJG0hqo65ze00pYyjuTbSSsftnV5FSPlj
	6eggfSoztPPwOjWPFO02CFPd84H2Uo81Tdzi3AJIocuZRbAn2z09EkT4bemEcQ==
X-Gm-Gg: Acq92OEt4PgkmKEhtC9lvCtZBk6chZTFx6ZT2rklxdjs41gUSM79vQNEgFZ+Zsw9kN/
	GQd6Jfw41HOoe+TrEorIlD5AgHCJPMcadSPFtjbSJXdXjV7+rFEgastWGuV8qph434RdxlyJknD
	pQf0YwqhxfbJ/vZFd7MwGku9O12B6bY+AjqbMjjnwBeiIA1miYQsWdpgaR200KxdJVPk+4JSHYS
	e3SyDIbpGkNmB72rKLrVwSYp0Brv75R4fO0nimemuRaSYOPyfYYYPxMZo3pOuDbCI1A4yrsUasf
	iNt+ngJ3HgPcy6TLQdS705f2ByLFkrXcQPsSDHF5lPXKLeHEtmCcpef2I0JyiKBlOHvyLsMIuSb
	5GoRglUcDlK1tWXCCqfozTqPs3Xi4CmkbqGD4ihPx/3Q96GSV6pS3uUTLuLKfWrMzXM/KaRjVox
	Z6f2p5cUEs5eNpCKbPHjir6BsQt1P5E7nN3aS+qzzxnL/B0vKoEQ==
X-Received: by 2002:a17:90a:d446:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-369519af686mr16956900a91.1.1779211089467;
        Tue, 19 May 2026 10:18:09 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:46ec:2327:9655:89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369513fe6f2sm14370012a91.0.2026.05.19.10.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:18:09 -0700 (PDT)
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
Date: Wed, 20 May 2026 01:17:30 +0800
Message-ID: <20260519171745.1551340-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260519171745.1551340-1-yphbchou0911@gmail.com>
References: <20260519171745.1551340-1-yphbchou0911@gmail.com>
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

