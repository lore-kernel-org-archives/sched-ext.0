Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBAB7262F
	for <sched-ext@lists.linux.dev>; Tue,  3 Mar 2026 06:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518205; cv=none; b=C4KtU+SZ/SemQ9YsbxB3lAaT86aZtcF/IGyQ6X3ZOSsXIJK2YxONk/HeEEpeTcB7Pg0wBIWarhvTX+aj9oMrM0h7wtNASmkKjJbzy0YXDOCCRIyi8Rzax61i7U5u944XdGLhvEkBptQf3k+EQkULcDQlxz88mOlbVDfuHC9x9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518205; c=relaxed/simple;
	bh=bv2Jz4U2DpMjAUfifYxKw27bsTlEORVTMJigqU5sadg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGPe69ZvuC62zxn2mABUV8yLt90xwn8R+PIvc6FTB87HwBih0/DDqmva5Zb/CsXjPgManshTXmM1bUHW1yBnh4KQ5msszFiLElui0+XSKVcFzLdAsOTVFLILRaduqfoFuJyMJy+u7FMeto+8iB2cm2CTzR8QoxVxGGCTicPIJ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Inb4xdKW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Inb4xdKW"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824b05d2786so4289667b3a.2
        for <sched-ext@lists.linux.dev>; Mon, 02 Mar 2026 22:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772518203; x=1773123003; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P6esbafM8AfMQhSMQFEvnisdVNGuHu/hvV9/NaeusRQ=;
        b=Inb4xdKWtdU5GM64gCxmacabBItK6OdXYWgGSLZSbHzOorUXXHD3FVv5sKLWXPTqvZ
         SiXTByg4TnD/zHoA9Nlw2Y3ITCYDzts1JhFHBvAipXZPDpSSPQZMHaqRE1b/ozs4GMlQ
         f5yAtjAEUulePdZdOauhnw4pgPcqZEZOPl57ArfVq3Pc8vOK+/XjnLaIdMYkGr54B1N2
         YbP8u3ahACK9gCvW5Y/L0Jht2MBGt4wA/+Wd6VvZeYzUckYDirf2upgR6SdP001UXffp
         XpsZQDNmxSPqOeX5EiPp6YlMElyVNgsKnIxYRqHyb/UjVtO7h1TBhrCaZP9Fmx0XvVgj
         /pdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772518203; x=1773123003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6esbafM8AfMQhSMQFEvnisdVNGuHu/hvV9/NaeusRQ=;
        b=lsUyPyzXCgx2jI5QtFaFxKYGnGVqBV/C2bZikukuzrD2QX7xBrE+v2ZSlXrYdsWK2O
         qFVCNINj+r0HztWd5jD/ByRRV8vqSNLr+99RmChsV4uqCN3B0di8SyBGA5JuG412o0ru
         XjP1Pn6d96MDKVTPlob2oLKVZMmwQt9mhK8jgE5T1y5QsNYHVKm0ZbrU1x1MadHcAd9r
         kNSlePmip08zelXP9EeK+iGiPVyjk0bjRPSHX8O2Uibs+wM8PHLj8c8dS7hAECjLBo8F
         7Yw18iHmyUZWu4GawpQRvg7g/oQoyO5uprBTjyXjjbgex04GNWAHMv3cMTrWd6xfzpJM
         nYqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnN9uHApl8d4XmrVIXSLmbXe4caDMhmbLPiEL3JMkeib9oZvDdrJStNzJP0ThUWa+ptpg5UXd3dME=@lists.linux.dev
X-Gm-Message-State: AOJu0YwmYayOjgS95Ga5JanZz5plE/RHcl0ZfNvaYsiBNFhWfmuMdX82
	3/C+4Y3T/9BfmwYMvs+/KuJU4nrZvM8D9zpWMFbHZ7vlFidKmfxk2F+w
X-Gm-Gg: ATEYQzw9zAot5EbQkarNxXB/8d/SQTqrUN//9078zi7JuZocS2AewVs5b3O98eXjmNm
	mdFuGomWYlaEm6TB3rogmS7GGE6o1JAj2p4Hg+rrQvjha9y2Rl8f7iHCiTt98GaW12RHXSuYrXc
	AWODVuYtqvKsP5Qv1o4sU2XdMRPdombm3HA8dqRn1AQ2lDE8mbpNYE08Ui3lutgoxpbnL9Ejv9V
	uxSkdhL0bNnDno3WD68NS8MT6yUvOPUEuvVtiRpWacotr2S+kMp2TbAzBpPMeJDFa4Wryr/yLRP
	nYpX1n7O040rbl333cIxM3AcunKydS3/zdG1gHtZoxAyteZxd88wJWnP4lkAS4EI972AKjwypHV
	IjTky5GVhp7x7FgOr4tGMHJmYyYh1tPJSiVRGSEUdKV2LmoDMpa8210p2LQdwg9VnSoF0bZ1WFM
	GmNjOBW04ln44io9FnDq3lz0+RVg6YU4rXmPOozcyZl07uVL464k7tDATBfc5iCvB/d1bfiKygx
	pA=
X-Received: by 2002:a05:6a00:4fc5:b0:81f:eb35:69ef with SMTP id d2e1a72fcca58-8274d9f43c9mr15590469b3a.40.1772518203462;
        Mon, 02 Mar 2026 22:10:03 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff350asm14116621b3a.35.2026.03.02.22.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 22:10:03 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] sched_ext: Use READ_ONCE() for plain reads of scx_watchdog_timeout
Date: Tue,  3 Mar 2026 14:09:58 +0800
Message-ID: <20260303060958.120517-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_watchdog_timeout is written with WRITE_ONCE() in scx_enable():

    WRITE_ONCE(scx_watchdog_timeout, timeout);

However, three read-side accesses use plain reads without the matching
READ_ONCE():

    /* check_rq_for_timeouts() - L2824 */
    last_runnable + scx_watchdog_timeout

    /* scx_watchdog_workfn() - L2852 */
    scx_watchdog_timeout / 2

    /* scx_enable() - L5179 */
    scx_watchdog_timeout / 2

The KCSAN documentation requires that if one accessor uses WRITE_ONCE()
to annotate lock-free access, all other accesses must also use the
appropriate accessor. Plain reads alongside WRITE_ONCE() leave the pair
incomplete and can trigger KCSAN warnings.

Note that scx_tick() already uses the correct READ_ONCE() annotation:

    last_check + READ_ONCE(scx_watchdog_timeout)

Fix the three remaining plain reads to match, making all accesses to
scx_watchdog_timeout consistently annotated and KCSAN-clean.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 147b31a7b3cf..b9247c9f0430 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2821,7 +2821,7 @@ static bool check_rq_for_timeouts(struct rq *rq)
 		unsigned long last_runnable = p->scx.runnable_at;
 
 		if (unlikely(time_after(jiffies,
-					last_runnable + scx_watchdog_timeout))) {
+					last_runnable + READ_ONCE(scx_watchdog_timeout)))) {
 			u32 dur_ms = jiffies_to_msecs(jiffies - last_runnable);
 
 			scx_exit(sch, SCX_EXIT_ERROR_STALL, 0,
@@ -2849,7 +2849,7 @@ static void scx_watchdog_workfn(struct work_struct *work)
 		cond_resched();
 	}
 	queue_delayed_work(system_unbound_wq, to_delayed_work(work),
-			   scx_watchdog_timeout / 2);
+			   READ_ONCE(scx_watchdog_timeout) / 2);
 }
 
 void scx_tick(struct rq *rq)
@@ -5176,7 +5176,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	WRITE_ONCE(scx_watchdog_timeout, timeout);
 	WRITE_ONCE(scx_watchdog_timestamp, jiffies);
 	queue_delayed_work(system_unbound_wq, &scx_watchdog_work,
-			   scx_watchdog_timeout / 2);
+			   READ_ONCE(scx_watchdog_timeout) / 2);
 
 	/*
 	 * Once __scx_enabled is set, %current can be switched to SCX anytime.
-- 
2.43.0

