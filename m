Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8491AF4D5
	for <sched-ext@lists.linux.dev>; Fri,  3 Apr 2026 04:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775189364; cv=none; b=rX0ruzeX958HZzme+kgbolDrGugr+8WD7Yqht1jm1CiDziEhE9Zx/ctNU+zJRMLkmy2HA8ZjqEDZ64ckNGWcapEte9lf0jA382dvNAfs6Y+8N8GlpYsP6xvCQfSMtiKfxUoIVmvHyYo5/9kNh6NNIW6q639RwHpbIeXy/xQQaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775189364; c=relaxed/simple;
	bh=OE7PtMT4bGlCIr+KYNkFo213ghLb1E5IK9no3K/7Woc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9iSHvIPKOe626qxYkWKT9wpc9ybjcK5PkfO2yJkOA21iqGrQyiMWLaJQeBrZ4vaU0fNH2gzFZEKze5Fkm0pyaD3fSatlvfd0lXTZQVDWVFGZ2UTv0FaRu1f0ei0YFel3QtxyuWtEC1TClw51feDr+WCs97cVp0B2lxTeeUccUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoP3IHfR; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoP3IHfR"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35c1d101355so621669a91.1
        for <sched-ext@lists.linux.dev>; Thu, 02 Apr 2026 21:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775189363; x=1775794163; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Etj0mwZtpUXhx6zzBLMJTsvKjtSQRtCM9z70q1Bz94s=;
        b=RoP3IHfRTLSrJ6hlojFYeRLJ9TyHHyEtlzO5nJgHMIHUe2Za1pKsXZBntaU0lRiQJw
         TS/M1cDZo0i0+1LNvcJjOxEpTiyk1TMUBAgyAEv/R8FWpcBrFwSrnddqEcVgBlFTLFia
         zwIPIk8cLJXHEjwsGcQ6FdBHc1uG7UcC7M8AOIsyT2A03Pvq1ge94yZ9IdGhxyxQneTE
         1/ioOvzT7iXyC9JdEIyH06H1Pug/2ay3lomR09STMIIfjy192CxeN/Ca1YqYKBtDNVMp
         n6GKwL46+Wa0Nq3sRDRtYJTqriGBjU5ABvisyb+2nTZ2x7b/8WIeNSqpZ8x8eTBNuw1x
         Bohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775189363; x=1775794163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Etj0mwZtpUXhx6zzBLMJTsvKjtSQRtCM9z70q1Bz94s=;
        b=q2dcdvbfLC5zAnObTwPvixIMI3GqnaINq+C6fH/1/2pYuWkYGFL8YVQ5rZGvVnVnqf
         LEBeriA29VVkZUvoHDDQoi6SWmo5GTKRBayYndt6tSX7TKvb77a5JFsRsF3hyv8yfrgg
         1I08ePsx6U0Jypk6dzA6u8dQ5V7rSPteeGbFQNKvwbyL872wAfnWioPCI7Y0V19ddjkO
         aNuyme3h0ZQESXWjT5eoQMxO4aec2y9EA86VAIvglf4w6rSkGrSUPgEFLIpJExHdwq1T
         wktLYf8RaLdkyO1qo68nTemwkAmlXf9fxQtvYc0MS7wx4xDQCGs5Md5rxzMbD7FfZeiC
         BLkA==
X-Gm-Message-State: AOJu0YyyNW2KckAVUEGck2DAIHYs3idapdvKbvLjj0Q+Dq1OIlo2VJKd
	KROPhen8YMegLWEPY+hfqc7WTyECNC48kXLMZ0KgcIS0a782UQ8w2aeUXEwY5g==
X-Gm-Gg: AeBDietNElcVvQ/ltwmlaDScTMEEvWHur1Ic12FZ5+liEqn9NOlcnYZAdGP9v3mimMQ
	cOI9tzkg9PbpEcaGo5H15bdInlnvHHmN0tpBrp/WKALrNUk3kh7nV/l5dmAH/Epm3It1qY5QGmM
	VT6mV7UlZlo2WPyFxqE7Vt0LZFKylUbTr8+KdTQxVAgCNwcLA5Ws17LxElvw/yfGSPkfI2f/MBg
	jjKBJWNDL+uG+7NvRwph65O9+oE7FXT5awbYUIF3V9PbS6sVRg+7A/dzwz+Z9E6/ATtnWhyPtt0
	rFvUGh4dUSSAjotzHhGPVcWjkRCN/deKGK082pMtj6aeUt5JAkYUY+NfDCytQcoe54saRh5YLSU
	3y7sx00/5oH/xGXvQkv/p5G7oKNflXVXNA5qR411zgDqfVRPuoKSCMbv7A4tzLYQYJx+k0Uv2SI
	0+N3biet/raxYebEo0RS4Kd2z1b5P8vrVG9gF671NvqQj4iTgbSw71
X-Received: by 2002:a17:903:fb0:b0:2b2:4d08:9e02 with SMTP id d9443c01a7336-2b28184aa83mr17156355ad.21.1775189362947;
        Thu, 02 Apr 2026 21:09:22 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:566e:8ca1:fcf3:4f49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd85sm42055915ad.74.2026.04.02.21.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 21:09:22 -0700 (PDT)
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
Subject: [PATCH] sched_ext: Fix print_scx_info() build error on !CONFIG_EXT_SUB_SCHED kernels
Date: Fri,  3 Apr 2026 12:09:03 +0800
Message-ID: <20260403040913.610756-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260403040913.610756-1-yphbchou0911@gmail.com>
References: <20260403040913.610756-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_task_sched_rcu() is only available when CONFIG_EXT_SUB_SCHED is
enabled. Wrap the call with #ifdef CONFIG_EXT_SUB_SCHED and fall back
to rcu_dereference(scx_root) for the non-sub-sched case, which is
semantically equivalent.

Fixes: 60d4b17e886a ("sched_ext: Choose the right sch->ops.name to output in the print_scx_info()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603261453.8kiJImYo-lkp@intel.com/
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 551bfb99157d..a40edd4d7cd9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7689,7 +7689,11 @@ void print_scx_info(const char *log_lvl, struct task_struct *p)
 
 	guard(rcu)();
 
+#ifdef CONFIG_EXT_SUB_SCHED
 	sch = scx_task_sched_rcu(p);
+#else
+	sch = rcu_dereference(scx_root);
+#endif
 
 	if (!sch)
 		return;
-- 
2.48.1

