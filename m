Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03D40DFD8
	for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774161606; cv=none; b=EH7YNsAr/+wom252y3MrQiYmONuLe+EOZpbq259SNQktbMLavoSxVECfqNJhSVp3hV3fXS6upGMKHIhxejJV8dE+OkMCEQVpAOdfGSde6y0N1WmrkEgZ+QT+2KoiTtVrDSvNtRymjJ4zHqI8TR37iU1Tw2D67n00DjLO+I3V6pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774161606; c=relaxed/simple;
	bh=1ZiFwAw1r14kWmasOYjmkvqDfaKI+OJKE2csX56kufI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CBcK0sa1rRBM0xfw7fVdkMV+s050nVezGNz8BXXd8ivIsnv+yKqZrw3DL58C+CJBhJixtKDop4Vq/aaUYlkk1jgMVKniqtrucqeXacjQqB6SrKz7HtWRuQ49RPuTyHzjivNK9yqlzZRRPR0B0ybdBQF8Z4F47bI1zRgqBwmGwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exdTShU5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exdTShU5"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b061b6cf36so13955145ad.3
        for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 23:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774161604; x=1774766404; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yeh7ADHQlXMFfOgh7EjdyHzLelcmLXhYoi6swcDcaig=;
        b=exdTShU5K6BhcYh2kxCSqFzQZXQ7hr1kMnKSaqtU3qUkn0OmnJ30hBs5uimL6fMNEI
         8j9n/aqoH6mKQCAGI1F0AGr5kD11kmTKRNPfqkA9H3SP36Jgdp8HXzUEZ/IAmtTrtzhl
         9Mu6o6M1mjVt4jcBs7EJhnHNqgzFk3Ir+hcz1y372JMo5HHpmlKZ+BSLMN7Be/LTbQBa
         emxfzX7kEtup2yaDjRmcV8HQkrue89xWAagLNV884/QTEzV9zsMN2SYGc2APoDD43jPF
         SDUGJxMyRRNlmZpjokT/bKGAd8xYz3BirHlexG6bocy81dpmL7YslBQsFQ+5Li5A7r6m
         bAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774161604; x=1774766404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeh7ADHQlXMFfOgh7EjdyHzLelcmLXhYoi6swcDcaig=;
        b=RzNux+d6E5nUTgU50qqifCFJPjaA15TNax7HYqfPqCPB7s+2jaC8RDhzA3Vo7n1LmX
         ajlHrrVddH72skBOG3arJXJWp7ayWJ+TcAdH14CiUMzJLxWWYM5fJsBF2YbMmshUVyHF
         lq4IiThkPI6XKGRvNo82miFQpxMMhXEsgrZN2POeV6uCGiQUiEbyd6svfdhK0aWdT3b6
         iLBWaxDrp2hElrdMJa5P3Z52S4uQONu+k7MpKynUwcEHIloxZ0iCLB4ehtSo6G5h1WcL
         KeJYv00DKfyO5yGKcMvHpoC5vRzdTAAY8ynancM75kbiG2CLMCMQAT9nC5kAkV6Df0UF
         GD4A==
X-Gm-Message-State: AOJu0YwwZugaT0hNid39WyCXRiLMWBI8MP+9dbmJGGTM0IhaKPXNhHj9
	xfLw7qIxlr11X8kxXdPAqea+hAjIJbgxBgfR2nAkW8fcda4mSor1hD3LOqN83RPE
X-Gm-Gg: ATEYQzxQTzmlULBuOj9LiGKAxbATwlvmoTX1iSL13PXJLNH0A61iqAYmIq8Dw8UMKGX
	JYYxDsYuer2UvUxhF2bCzFMFSjm10PoPQG87WmqYqdXduqL4i2buhal1HNHVMe3gITc6SISh5ll
	fG52CQJ9jFUM0RUr9KJcUHcGYQDQhYK6cYalLoChvLncas+VYNxfbs9LVZs5qKW8yiT8f8ELBE9
	hrVfsdjTqsEBG6Ghscy4fc1gVsu5jTJB8mVqIZ8QwmCkYCf1bdLSBwxhCdBSlOyPnuHU3x4wfad
	q/mWBrOg1PjIA/xoQ+2Vu8dMUiGnXzw/v5DXfshFgavt6LqZgynpjtpg+rLJccC2tOxO8/8S+Hk
	xsXZve7De6qsXsHdaEQynuwf5+F9TYaf3JKEya1du6QOASxbm+baAcPcExXoFy4NHxzQxX2w9dB
	NO8ji5W2C9H7NVFGNhr9Cx0eZn2CFCpSgDApfDz6oCQis7vHUMKKc6
X-Received: by 2002:a17:903:244f:b0:2b0:5e10:9dbd with SMTP id d9443c01a7336-2b0826c84cdmr82196855ad.3.1774161604158;
        Sat, 21 Mar 2026 23:40:04 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:e49f:fa98:a4ba:8111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836b97fesm68737465ad.84.2026.03.21.23.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 23:40:03 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 sched_ext/for-7.1] sched_ext: Fix build errors and unused label warning in non-cgroup configs
Date: Sun, 22 Mar 2026 14:39:50 +0800
Message-ID: <20260322063955.951848-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building with SCHED_CLASS_EXT=y but CGROUPS=n, clang reports errors
for undeclared cgroup_put() and cgroup_get() calls, and a warning for the
unused err_stop_helper label.

EXT_SUB_SCHED is def_bool y depending only on SCHED_CLASS_EXT, but it
fundamentally requires cgroups (cgroup_path, cgroup_get, cgroup_put,
cgroup_id, etc.). Add the missing CGROUPS dependency to EXT_SUB_SCHED in
init/Kconfig.

Guard cgroup_put() and cgroup_get() in the common paths with:
  #if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)

Guard the err_stop_helper label with #ifdef CONFIG_EXT_SUB_SCHED since
all gotos targeting it are inside that same ifdef block.

Tested with both CGROUPS enabled and disabled.

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603210903.IrKhPd6k-lkp@intel.com/
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 init/Kconfig       | 2 +-
 kernel/sched/ext.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 06abd8e272cb..487a93e34be9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1178,7 +1178,7 @@ endif #CGROUP_SCHED
 
 config EXT_SUB_SCHED
         def_bool y
-        depends on SCHED_CLASS_EXT
+        depends on SCHED_CLASS_EXT && CGROUPS
 
 config SCHED_MM_CID
 	def_bool y
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 94548ee9ad85..2e7a1259bd7c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6494,8 +6494,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 #endif	/* CONFIG_EXT_SUB_SCHED */
 	return sch;
 
+#ifdef CONFIG_EXT_SUB_SCHED
 err_stop_helper:
 	kthread_destroy_worker(sch->helper);
+#endif
 err_free_pcpu:
 	for_each_possible_cpu(cpu) {
 		if (cpu == bypass_fail_cpu)
@@ -6514,7 +6516,9 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 err_free_sch:
 	kfree(sch);
 err_put_cgrp:
+#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
 	cgroup_put(cgrp);
+#endif
 	return ERR_PTR(ret);
 }
 
@@ -6603,7 +6607,9 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	if (ret)
 		goto err_unlock;
 
+#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
 	cgroup_get(cgrp);
+#endif
 	sch = scx_alloc_and_add_sched(ops, cgrp, NULL);
 	if (IS_ERR(sch)) {
 		ret = PTR_ERR(sch);
-- 
2.48.1

