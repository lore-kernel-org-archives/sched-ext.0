Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37D75477E
	for <sched-ext@lists.linux.dev>; Thu,  5 Mar 2026 04:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772683600; cv=none; b=M14ciQigN1i7nGbg7FA0lofE2XBWRO1kM9tQIr3pd1soxgzA7Pe5Yb69iKuNIDGuyso/i1CDvK5oS/5RtAaLWIZ5Z2d2uackZvxK5ydbqarzrWSBjrnHhxwKTmvq6Af8TOfwqwNVeVkSUuS+/0zm3SckmBy3jHe0VqkE+tLD30A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772683600; c=relaxed/simple;
	bh=K3I1WO/XZ12LOjA7uCESl0KE5zvtyoQ+YxgsfnqqN+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMFkKwXm+UtIf8FM4TugdRQoHWRkLlgv9gtgqMUI1AE1iY9PtrWfSNI036GkCZjvVuxJJO8mlZ1cB2mSxZzFdD9ayPcrbePjDRe8JRvAG2RBzOLCz+x+Thp97ml1K5w9QjUlhyC7+LuEEcdmhBFFa35xGOpM8chiuRTaaemeIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zm/lrfV6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm/lrfV6"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c737d3a51bdso498698a12.3
        for <sched-ext@lists.linux.dev>; Wed, 04 Mar 2026 20:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772683599; x=1773288399; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8OQSjVBPYaZXq4l1ZMR/y6g/ReN7WoQx6dDK07M5fRA=;
        b=Zm/lrfV6G84hDLJv37ItZAQG6dWNvOQnlbQ95MjFOEYzZSfYi4GF9s/B+ackFZ11BC
         m7Bltc1jSUINyqOc2kv5dsmq/OZhwChEVy8anavVvjzW8GguBNecJnX30PL5gL/Z3Fn8
         GCZbb0l225rjPyj/ZZFS4ZWb7tsPaaIkW0HIV3Asa6djzO4JHADFdEByP2OOKGjN5rDy
         kb0+IdnJ9Va5W6TAXGJHWHk9cPI5pn2ygJFialNNDWuYEv56PJQ862POkJ5UDz/bhjYe
         RS4M2IHLiLnaWneZKO6aV0kKRvq1KSAFb62KA8BHfJ91R8p+EeyDOMXpU6bZDVtsYByn
         AQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772683599; x=1773288399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OQSjVBPYaZXq4l1ZMR/y6g/ReN7WoQx6dDK07M5fRA=;
        b=DLMiddjGMu21Uel+/ByI+rMVj67sO32BTitIm8/NeAS6ufGUj8wVBAw4CQklGA+1qJ
         AgpNKRPladQmjYH13Rx6rcaArfDnALy3tSRgfVm8fQmxx7czyVZnbNQVEQf750AAwcy5
         f7B63zgIj6cx3alRPtUBOgQ5LJym8j0/iLCJFNMAN0UAsVZGM6B1DSOCZSLCJMUsauyC
         iVCdwRWCBMUK5GKOORvHmMTzZOIo7uglyMRbfvLsR29Zhq78FTg4gvZS+zxQbf7RvRz0
         6ED3HcMdxfaJn/ulgeK1RVLre3NIG198AB6SMjPl0Kh2t/7DF+kpR7KiSERhEBEYNj24
         g8Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWJP/+1uL3BBSJqeHMh6ldGCpiu6plvXEzrJQXElTYyUSCsLTE+mibPCm9M4lWBqkvE8vhLJG21aV8=@lists.linux.dev
X-Gm-Message-State: AOJu0YwWBXuCJqIBbeq4w08RWLhojC8ZSAPqEp6weU+eNY4HQUKlal6m
	pC/EI2D8ea56XjBpRa3LXM2hBxBWiqFWMH55JPIOkU5KeHC9snAYFzr7
X-Gm-Gg: ATEYQzzGzu1QbpW1juXtAgZFDMjVtJnfCZyASGnsFE+aC/VGNAlK1N7eiu6H+gXhj1K
	7SYoekWmwOxjxb0+bIUyBj4/wcE0mi+4sNwWGYORhj81vtvJWsXFdbf4wwTQARA/fLy4ladU0Ly
	/getpZiINQMDoGBpMu4G+vtU95X+ADuu9ItKoRj6Kcrj6DKFs19TRKidVboM486JwRjQYmTTO6y
	ZDW4CF68wSZ41t/WtevM1kYS206TrAInscBTRxOLSIAUvsbuPxaBobrLXU4LyWzHOnbw8nUV6o+
	CflGEZxthclYEMeK33XmAMd9djzoizJv4dciaQpAeQSXg8hHuzZNkmFj7bXfxGT1iJP08xJVJIZ
	cb2NTQzQS4hdgQ9YTwiBmPPCGYlr1NqfqtuF4UMHi746UhfraXIKjcw4xOnp8HMJSYB7ZGtFZtn
	OQonOk+IcAe3WtbbbrUiGXrPYir9Qt1O/zguEc4iIGG0xwhF04plr2pnKGTyoRMFSJl8PU+gIty
	7c=
X-Received: by 2002:a17:903:b83:b0:2ae:62c8:7738 with SMTP id d9443c01a7336-2ae6aa0e414mr41503165ad.22.1772683599049;
        Wed, 04 Mar 2026 20:06:39 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4cd40e4dsm113204455ad.92.2026.03.04.20.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 20:06:38 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] sched_ext: Use READ_ONCE() for lock-free reads of module param variables
Date: Thu,  5 Mar 2026 12:06:33 +0800
Message-ID: <20260305040633.1274357-1-suzhidao@xiaomi.com>
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
and scx_bypass() for its other lock-free read sites, leaving bypass_lb_cpu()
inconsistent. scx_slice_bypass_us has the same lock-free access pattern in
the same function.

Fix both plain reads by using READ_ONCE() to complete the concurrent
access annotation and make the code KCSAN-clean:

    min_delta_us = READ_ONCE(scx_bypass_lb_intv_us) / SCX_BYPASS_LB_MIN_DELTA_DIV;

    if (delta < DIV_ROUND_UP(min_delta_us, READ_ONCE(scx_slice_bypass_us)))

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

