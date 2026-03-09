Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E4031AAAA
	for <sched-ext@lists.linux.dev>; Mon,  9 Mar 2026 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073835; cv=none; b=JpEn0s6h5cY5buCj0EtSn6xEmbL58tRa+JI9bw6hKUZ4EoLGKW23QUGa4gXw6YX/NsTULstT5coEUIZ0SD+IXmYqqXUUmwbgr0D8UVakyqmF+P/epMuTSt/ewjoOMr023lsYV20Wz4v1vYTD3UqMtirMgeoWibANbpQherX0oJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073835; c=relaxed/simple;
	bh=JBMfbqfb9mbr2qN/P2lkOqGIqIG4u2uBTCl/KURP8gU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpDtTZ28Z8XhOYRGDKmsQ8pqpe7XwEoM0vsQ6OIZsVl/vmVyq3o2yaCzXtxrrqcHaeenv9oUaMQtQJwZ5yjUcoACV2FR0mJYYd+r8fBsddbmOmgf6PnEVmmfynjTR0SKUifW6CL7xDru3fwuFhMQxGBCypkVLNULWgKgeH6F4d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8l/DZI/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8l/DZI/"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso6366582a91.3
        for <sched-ext@lists.linux.dev>; Mon, 09 Mar 2026 09:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773073833; x=1773678633; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Hjnlxz2Fxt22dgcBmoaRn6imBW1myOKpzokbHjOj94=;
        b=B8l/DZI/P2tJ1zpEVsG6IXaopF3BMxeFKIIgCbq5CqJamPLmUMFrOaidqfaYgiuqny
         Ige9fdZ5RniIWKsS00shrM0LaGIUnJaogyn6wUiZyNI+Qh6dmNfUtRRWlZ27tPH5qiWS
         L7357SGB/KY7rSQVenEbr6FQVQHARc0RgMaE8WGahhSzDst0W9dDCvk1PPTQ6drpkwm5
         27eVm1t7OilkxF5LM4eWiFOaodnJi9p0wKZebVJuMdTYjI80wSzpQAXA4zzVPKh46xmd
         BiHZVfVHqdjxs78QF3Xd4A2XCW2COtqDhSiR9krxxzu/VZcNrx+c3FhjOf4gOr7MW4cY
         8xLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073833; x=1773678633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Hjnlxz2Fxt22dgcBmoaRn6imBW1myOKpzokbHjOj94=;
        b=FRwPdst4jQPXB3j524/mLfEyxKEOXJbBCAFxl5hoJutwYiaeAw9UKDwHG6xDpwmRaq
         8gHONn948/eQzDQn/hgbkfohqg/A50EmR8bxNhy5RMP6P1T3+khfUNwksFyGTlOYf4gk
         OazEuNPwOZwg4P6f3RZOl4Q9PTUj+VQyIMHE8sZzqaD2JFhUsNg6v8C+rM2gz6JM5lml
         IfiLapdqj5uN/6qpOSNDz6w5MInzj0MrihgAqlUjswjRChsZI/DUm6+1sZUwW0pgBzM1
         o2ECYdVo4fmwKGDLDF8RhsVln6yQEKxzraXF5DPultt0AB9bBL+1TXFpYOmI+NyVwqVL
         yLTA==
X-Gm-Message-State: AOJu0YxvKTioi69W7z0GnpV5FAzI4j5c44ycBjRLnGbJzdhBnLrOYENG
	yoBtbu/8pCIpq6OK4cfLwf+q8suMBz4aPqofj/E3SDQ3SBzX69Pd7KetOUN3FaiT
X-Gm-Gg: ATEYQzzMs9b4MG9xRd5tsH10ZVTSCH79T9LVOAZFoM34BCwHSYivckTLPw83B+veXEY
	9Vx/f/jj+XrItYDDnX0eDX1/gB4bURBr9fmroNPrM4SB6Z8UCbW4J60w8Z7Pmpt8vC/BnmkHHpU
	uOb4F6V+5dwGoaGyk6hjAo72BiOrLavJahzChUgdQY6Df1q+QOacCR9qstf3iPdQLE1afSCuNn+
	4+aiHmpx1fxKjbWoALrQ+NQgPeGz8p4hbMD9G2A2p4g0DWKNvgufBUVUXxBJ+9lV5lyGA6/xE+b
	Bh9DwlKewAichzngyMx2JRWHaQSXo7luCy8Rgn2f3nz/K6QPxAxN2+adYVLWAQPDUhpbJKMQrpA
	HN2NdCAUneOWtraMVofbRwZcMB5toCwU2tG4nSmKj522xpunBGIyHVq6FsBRt46LJnkeUexpHIB
	APf2Pg7zZp7gnoZuXDFclg49g4uNnIij7vO7ViNQKJgdYeoJTWOwo/
X-Received: by 2002:a17:90b:2f8f:b0:358:dc04:a595 with SMTP id 98e67ed59e1d1-359be32bba5mr11163328a91.21.1773073832805;
        Mon, 09 Mar 2026 09:30:32 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3cea:adff:13a5:9a2c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bc9d4392sm5687519a91.4.2026.03.09.09.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:30:32 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 0/1] sched_ext: Fix deadlock in scx_claim_exit() by deferring descendant propagation
Date: Tue, 10 Mar 2026 00:30:24 +0800
Message-ID: <20260309163025.2240221-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While testing scx_rustland under vng, the locking dependency checker
reported a circular locking dependency:

[   31.801757] ======================================================
[   31.801786] WARNING: possible circular locking dependency detected
[   31.801812] 7.0.0-rc2+ #31 Tainted: G            E
[   31.801835] ------------------------------------------------------
[   31.801860] swapper/7/0 is trying to acquire lock:
[   31.801884] ffffffffa4ac1638 (scx_sched_lock){-...}-{2:2}, at: scx_claim_exit+0x7a/0x180
[   31.801923]
[   31.801923] but task is already holding lock:
[   31.801951] ffff8ce0bcbc5ca0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x28/0xc0
[   31.801990]
[   31.801990] which lock already depends on the new lock.
[   31.801990]
[   31.802021]
[   31.802021] the existing dependency chain (in reverse order) is:
[   31.802050]
[   31.802050] -> #1 (&rq->__lock){-.-.}-{2:2}:
[   31.802079]        _raw_spin_lock_nested+0x2d/0x50
[   31.802103]        raw_spin_rq_lock_nested+0x28/0xc0
[   31.802128]        scx_bypass+0x14e/0x4e0
[   31.802147]        scx_root_enable_workfn+0x2ce/0xa10
[   31.802171]        kthread_worker_fn+0xbf/0x3c0
[   31.802199]        kthread+0x109/0x140
[   31.802218]        ret_from_fork+0x3fd/0x490
[   31.802242]        ret_from_fork_asm+0x1a/0x30
[   31.802267]
[   31.802267] -> #0 (scx_sched_lock){-...}-{2:2}:
[   31.802296]        __lock_acquire+0x172e/0x2830
[   31.802320]        lock_acquire+0xd5/0x330
[   31.802339]        _raw_spin_lock_irqsave+0x49/0x80
[   31.802363]        scx_claim_exit+0x7a/0x180
[   31.802387]        scx_vexit+0x3a/0xd0
[   31.802406]        scx_exit+0x50/0x80
[   31.802425]        scx_tick+0x114/0x120
[   31.802445]        sched_tick+0x12e/0x3a0
[   31.802464]        update_process_times+0x90/0xf0
[   31.802488]        tick_nohz_handler+0x97/0x1b0
[   31.802512]        __hrtimer_run_queues+0xac/0x3a0
[   31.802539]        hrtimer_interrupt+0x116/0x280
[   31.802564]        __sysvec_apic_timer_interrupt+0x6b/0x1e0
[   31.802589]        sysvec_apic_timer_interrupt+0x9b/0xc0
[   31.802613]        asm_sysvec_apic_timer_interrupt+0x1b/0x20
[   31.802642]        pv_native_safe_halt+0xb/0x10
[   31.802669]        arch_cpu_idle+0x9/0x10
[   31.802687]        default_idle_call+0x7c/0x220
[   31.802713]        do_idle+0x211/0x260
[   31.802732]        cpu_startup_entry+0x29/0x30
[   31.802756]        start_secondary+0x12d/0x170
[   31.802780]        common_startup_64+0x13e/0x141
[   31.802804]
[   31.802804] other info that might help us debug this:
[   31.802804]
[   31.802834]  Possible unsafe locking scenario:
[   31.802834]
[   31.802859]        CPU0                    CPU1
[   31.802879]        ----                    ----
[   31.802899]   lock(&rq->__lock);
[   31.802918]                                lock(scx_sched_lock);
[   31.802949]                                lock(&rq->__lock);
[   31.802978]   lock(scx_sched_lock);
[   31.802997]
[   31.802997]  *** DEADLOCK ***

Link to full log:
        https://gist.github.com/EricccTaiwan/bc7d8eac7a9a31af36a2e9f0a295da7c

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (1):
  sched_ext: Fix deadlock in scx_claim_exit() by deferring descendant
    propagation

 kernel/sched/ext.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

-- 
2.48.1

