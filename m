Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1CD3932FB
	for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 04:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773289212; cv=none; b=rPiKu6vqkbPNejBAjUhBlxMSa17y+Wwd0Za23c016emd0MbXHX23apZtnN6hhzphM45taErv8HCreLrXlAwkA42wx/lta7pbyZf9aia8whJIvbWTy2d24Yc+QUgwCAWyEihFML65bYKvZeX9et9CVhuqcUh1RvaH1P7yMFcEE0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773289212; c=relaxed/simple;
	bh=Ey7CNMV89i3zeLdsbueWsMPuhcN+sO0pjkyTUqUvEZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAqn3fZK/Xlke0pG6RO0pxCsrqTda1qVgzekI892ooCXdvRpsKMr5S5+fngSLNRg/RB2MzwPYeJNfruxIPvZ8SNdq4bcUj3Os/xfxLtoWjnpKdGN0+UtoVzCwOlKJUE9cvwbG5sWgLZEXSUkjqHmIwXI8AJpgqQck+iV7SEaGUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFu3oYVS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFu3oYVS"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae4988e039so11804485ad.1
        for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 21:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773289210; x=1773894010; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfZ0lGuhTnlEp/D/A7GJZVx3JXTVlze29cyFSwWvR8w=;
        b=QFu3oYVSvliu6pF6CnCPN1Z9/FaPiJv1/uFH9JhQACx09f+bAf7hvIvQWWGiGh1ZAa
         W6bh+Zch+VBlufaijEF+8iC+QYSYR1KVzQvWnhI1MNOQojTzDNHDaaGc5Ul0al4dIJ2k
         cGTDTwauLKuKr/FMMe2EM2pBs03jpbRRiQPbA11wOFoHIzkM7jUaPPi7ykp7tC8WnSrg
         5ECd59fX1zFk91snqGsmuyFU1iZlt+Aav8PUhWK1A7iLuUDcJ5+Gm7wuiqgY3mf1m6z1
         UZfyF2rAMCBV4oiYHWTq9rfG7Kr0qKlhgXAl4hWH87DQRXsmLiaEWLqUnOick7Z9sTQC
         6Zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773289210; x=1773894010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sfZ0lGuhTnlEp/D/A7GJZVx3JXTVlze29cyFSwWvR8w=;
        b=pKEmwTENUx03UwzVP05KBNhxFwOcvxUkosXInj/DnoqxOhSdcTdGAhtksWzUIL8rwk
         QGEg2PCfogvmijaOPIebB6WPxO9x+fb5PEAYUWUXy3lNLNvxDluwp8LD1zJaVkVBIbzk
         rNC2bPxR0GwJzjLlBMy0E+X8albw4lG1a8b+UAOTQ7kye3ivEI1Qwx8S/TCBY6o5mmsu
         /mjK5zdXn1S/q5QhgXV7oxhkMEIQa3/CV6++IdVXIc/bx5//BHhWNlswNcqaCpen1HUS
         y2HbZzEWfonkEFoxctyB8ZdPAu8epGoEmIEUMIl0pHn5Cm47rbhcbCWVfBSAvYK+eiIs
         plIg==
X-Gm-Message-State: AOJu0YyC78PvdS05s5hMP52QjSHRbYV1GxM6lirVda8MO94d+HUHqD8s
	F0wcAkG2ZTS4/EOHQBN8iP0XS2LQSTrzBRizGzx+7YadSUJ6pci/cAYgtzX0ZJZx
X-Gm-Gg: ATEYQzw0f8k3rZIGSar9PkPF7nxPX377SC8mHDJWPT/Fbe+B3BU2HZ1U/c6BF8TWrGI
	hxD5KYsep+93kARvGe8NmXC6JlKpjoNRr29c29mUVORRZOjRvqmTBQXVN3txhZX7Ujcm0GVfyTT
	m48aCuHoO+IyuVDXTX7KDnkd11TKFSgyQYZCLggLFcgLVXPcOBBcyIrZj3b/fTcBx4jeBULjd2D
	/yaoquw++QtOBiIo6J9Mpnni3I4NKO/Pw33Z+moWuKM2oMsVAMTAZ68ASDjqfxkjbHt2tRTopJt
	tSUHFf5qcChhF76riEgMeJ8PN+7N1fIf/FSfPMfluwhrIJvGt8RXDetVi16sSSUKdML2B1FiHxs
	yrB67fysfKjSkwbJczYSixgwyKCOFCNXdrYT4s8oJ3AwEnv1GxxwPlPpKjQpslWfgm6wL/aXHsm
	N8MP7Go+lANxRD2kj87OB+o5qHf3XCCSiJ/3zDs/yx3LAgSUbVolNH
X-Received: by 2002:a17:902:d60f:b0:2ae:4908:253 with SMTP id d9443c01a7336-2aeba4ea62dmr18822555ad.16.1773289210052;
        Wed, 11 Mar 2026 21:20:10 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c33f:dccb:5456:7509])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aebf1dd261sm6265375ad.90.2026.03.11.21.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 21:20:09 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 1/2] sched_ext: Update demo schedulers and selftests to use scx_bpf_task_set_dsq_vtime()
Date: Thu, 12 Mar 2026 12:20:00 +0800
Message-ID: <20260312042001.955675-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260312042001.955675-1-yphbchou0911@gmail.com>
References: <20260312042001.955675-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Direct writes to p->scx.dsq_vtime are deprecated in favor of
scx_bpf_task_set_dsq_vtime(). Update scx_simple, scx_flatcg, and
select_cpu_vtime selftest to use the new kfunc.

Use bpf_ksym_exists() to fall back to direct assignment on older kernels
that don't have the new kfunc, preserving backwards compatibility.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_flatcg.bpf.c              | 21 ++++++++++++++-----
 tools/sched_ext/scx_simple.bpf.c              | 12 +++++++++--
 .../sched_ext/select_cpu_vtime.bpf.c          | 13 ++++++++++--
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index a8a9234bb41e..27d99bb1e60f 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -551,9 +551,14 @@ void BPF_STRUCT_OPS(fcg_stopping, struct task_struct *p, bool runnable)
 	 * too much, determine the execution time by taking explicit timestamps
 	 * instead of depending on @p->scx.slice.
 	 */
-	if (!fifo_sched)
-		p->scx.dsq_vtime +=
-			(SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+	u64 delta = (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+
+	if (!fifo_sched) {
+		if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
+			scx_bpf_task_set_dsq_vtime___new(p, p->scx.dsq_vtime + delta);
+		else
+			p->scx.dsq_vtime += delta;
+	}
 
 	taskc = bpf_task_storage_get(&task_ctx, p, 0, 0);
 	if (!taskc) {
@@ -822,7 +827,10 @@ s32 BPF_STRUCT_OPS(fcg_init_task, struct task_struct *p,
 	if (!(cgc = find_cgrp_ctx(args->cgroup)))
 		return -ENOENT;
 
-	p->scx.dsq_vtime = cgc->tvtime_now;
+	if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
+		scx_bpf_task_set_dsq_vtime___new(p, cgc->tvtime_now);
+	else
+		p->scx.dsq_vtime = cgc->tvtime_now;
 
 	return 0;
 }
@@ -924,7 +932,10 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
 		return;
 
 	delta = time_delta(p->scx.dsq_vtime, from_cgc->tvtime_now);
-	p->scx.dsq_vtime = to_cgc->tvtime_now + delta;
+	if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
+		scx_bpf_task_set_dsq_vtime___new(p, to_cgc->tvtime_now + delta);
+	else
+		p->scx.dsq_vtime = to_cgc->tvtime_now + delta;
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(fcg_init)
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index b456bd7cae77..61d3bcf54ce7 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -121,12 +121,20 @@ void BPF_STRUCT_OPS(simple_stopping, struct task_struct *p, bool runnable)
 	 * too much, determine the execution time by taking explicit timestamps
 	 * instead of depending on @p->scx.slice.
 	 */
-	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+	u64 delta = (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+
+	if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
+		scx_bpf_task_set_dsq_vtime___new(p, p->scx.dsq_vtime + delta);
+	else
+		p->scx.dsq_vtime += delta;
 }
 
 void BPF_STRUCT_OPS(simple_enable, struct task_struct *p)
 {
-	p->scx.dsq_vtime = vtime_now;
+	if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
+		scx_bpf_task_set_dsq_vtime___new(p, vtime_now);
+	else
+		p->scx.dsq_vtime = vtime_now;
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(simple_init)
diff --git a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
index bfcb96cd4954..17ed515c3e25 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
@@ -66,12 +66,21 @@ void BPF_STRUCT_OPS(select_cpu_vtime_running, struct task_struct *p)
 void BPF_STRUCT_OPS(select_cpu_vtime_stopping, struct task_struct *p,
 		    bool runnable)
 {
-	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+	u64 delta = (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+
+	if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
+		scx_bpf_task_set_dsq_vtime___new(p, p->scx.dsq_vtime + delta);
+	else
+		p->scx.dsq_vtime += delta;
+
 }
 
 void BPF_STRUCT_OPS(select_cpu_vtime_enable, struct task_struct *p)
 {
-	p->scx.dsq_vtime = vtime_now;
+	if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
+		scx_bpf_task_set_dsq_vtime___new(p, vtime_now);
+	else
+		p->scx.dsq_vtime = vtime_now;
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(select_cpu_vtime_init)
-- 
2.48.1

