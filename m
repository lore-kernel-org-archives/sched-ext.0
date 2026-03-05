Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839E0288B8
	for <sched-ext@lists.linux.dev>; Thu,  5 Mar 2026 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691544; cv=none; b=oK9SVOQIM48swYSPskw+r0CLR1P0iTh/FXDIT7qUN9a3FzD5oyeg5chn+Dr0UOa7reD/aL875knvLsfh02i+P4XTrOlZbXRCkVHG+0wa5QAL/OHRfCwWDgFUH15V6X/26C15r7B2m1/mEq9FngeJovSnRm3jzfLVhDmqlNNs6TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691544; c=relaxed/simple;
	bh=1ydMNjvWWWNJ8MmZbnh9xxYkl1ttV69Z8xgx9T/SRww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3PFAEHV4hFfXkk1aY2CPOUi2qkK1cOO6rU33UMAiuDNYqIViLqBWB5NXaeWZwIfbICD2LwaqxTaOCwYigkkzl/uBL1he/j80yDRP8KHEgeCPq64yEMFwqbHcPMU9OvFD7xIeBV84qAF9GqDUipiu+Ij5l2uyzWQ1mXfC+dxDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Agdk38S+; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Agdk38S+"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c7377119453so672452a12.1
        for <sched-ext@lists.linux.dev>; Wed, 04 Mar 2026 22:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772691543; x=1773296343; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=84DLa/5oWrs/xRCG5zCff7/tNADEE4rSWCOZvtWEwC8=;
        b=Agdk38S+aVGkjQiDeM8YoiRJVz/CLTcj6Cgd+0HgifvTvW2Kg4hU0jmCZ/2LHq280P
         x37kuATXMHvwH/s/8XvoXnVHTR3dZvKSa9Z6R1uiYGJoo/82CflwwgoPBzhIBTImbboJ
         0vrvZSWhAEMfNtYZgP51k2tZRg3KRss3964t+qRLQsLrtlra9SbRXzquwZ/Tpzf0m3tJ
         Ham+yRhGoINdLqFsD9bhcGcoBjh0rZMX9JlIBMG12XG3kCPmyLCFS3qM/+AC7zx4TU8/
         GT8CNstCa7eKsXISx2y5DRpssRnCvbyJ7SGmc7OgOeYRpcba2n3JxIeQLLF22AzXYlh/
         Sqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772691543; x=1773296343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84DLa/5oWrs/xRCG5zCff7/tNADEE4rSWCOZvtWEwC8=;
        b=YuRdRpo61ZJnDrmGbPa7MPBEjb/Njs0OrqHxOr31rt+cnLunV/JUcUhH4yKu9YDiPn
         0rSIpw9VeqDAS4JNQnEwsMnOtDQxx9716i5pSti6NZCPTS5P9PMU4HcFAZ1jlB/HJIDP
         7gzXgzTr2kEkXr6t4fD8krddQqNXNLgS7141y8z2jm+k5jt7D/uPZewKCJoZMTDgE2Gn
         KUYm3NY02G9vijdd0q6uIOtPecCRzzYKa+763HfcLsnl9meXgT/XE1PbZxe20pMQuBGt
         knTN68E37sslpfvKOk73/alN1sICnHM3g1sOiYn2xPuP4YKPjctW2t2Gr6/mEOkcyv5U
         S9BQ==
X-Gm-Message-State: AOJu0Yx0uppqbSi3T2p+wsR4wGkihSsJPw/5GTxGvknW19iqhozhMqXx
	5FN0cqN/w2Lzi8B8NsCJHwbpx5ozmkGo0IbiWdMM/dnEmMtKeeXCMhdz56rpac2T
X-Gm-Gg: ATEYQzxkTX/vZX9ooJ6e+eLqHauqBP0N2LfsaoCPXZoeZ57i4hthmTrFnSrmwhEUO2j
	9yHTKHsPmtLSI/NS24qCNCbAPaH3PwsTutPdDNre9omwAm3jL0NkmwimDpLVotwmz03VpSlSmK4
	QdnoUZirTcpKAzIldM8kwcgEDiM7xwflDuRMKrFfsFLuam6RqOcbw9ixKfqdts4R5JSrde/1Uvz
	z7Pzrw0yIRlIKqPEjiLkg6YBPhwEWSNiahDJ1nD24soGCkn8vTIAGEQx7bsUk5n3JYdv6IMslO2
	MhLUagXGeX9Gdug5K+DGyRj8Hq3Fv0AXj2CnHKjomUP4LTVk2Lg2vx2LN12bkBUhqLuKGSgltIa
	cWtT11n3OPbrm1As45unWcYTA32583mvc69wrBPDZtMd+VbH5NCViGPdnoN78N3CNzIp0mY2e+I
	+SAT5uioFkopSMEn46kVeJw3EQClyBVyAiZ40qndXqDj0U5ubBAczEQaM8sirSc+HYnVapXd7Wp
	yY=
X-Received: by 2002:a17:90a:d605:b0:343:6108:1712 with SMTP id 98e67ed59e1d1-359a6a21479mr4257139a91.18.1772691542586;
        Wed, 04 Mar 2026 22:19:02 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359aa21e862sm1438145a91.4.2026.03.04.22.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:19:02 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] sched_ext: Use READ_ONCE() for lock-free reads of module param variables
Date: Thu,  5 Mar 2026 14:18:56 +0800
Message-ID: <20260305061856.1796545-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bypass_lb_cpu() reads scx_bypass_lb_intv_us and scx_slice_bypass_us
without holding any lock, in timer callback context where module
parameter writes via sysfs can happen concurrently:

    min_delta_us = scx_bypass_lb_intv_us / SCX_BYPASS_LB_MIN_DELTA_DIV;
                   ^^^^^^^^^^^^^^^^^^^^
                   plain read -- KCSAN data race

    if (delta < DIV_ROUND_UP(min_delta_us, scx_slice_bypass_us))
                                           ^^^^^^^^^^^^^^^^^
                                           plain read -- KCSAN data race

scx_bypass_lb_intv_us already uses READ_ONCE() in scx_bypass_lb_timerfn()
and scx_bypass() for its other lock-free read sites, leaving
bypass_lb_cpu() inconsistent. scx_slice_bypass_us has the same
lock-free access pattern in the same function.

Fix both plain reads by using READ_ONCE() to complete the concurrent
access annotation and make the code KCSAN-clean.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1c3170846c84..9a1471ad5ae7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4004,8 +4004,8 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 	 * consider offloading iff the total queued duration is over the
 	 * threshold.
 	 */
-	min_delta_us = scx_bypass_lb_intv_us / SCX_BYPASS_LB_MIN_DELTA_DIV;
-	if (delta < DIV_ROUND_UP(min_delta_us, scx_slice_bypass_us))
+	min_delta_us = READ_ONCE(scx_bypass_lb_intv_us) / SCX_BYPASS_LB_MIN_DELTA_DIV;
+	if (delta < DIV_ROUND_UP(min_delta_us, READ_ONCE(scx_slice_bypass_us)))
 		return 0;
 
 	raw_spin_rq_lock_irq(rq);
-- 
2.43.0

