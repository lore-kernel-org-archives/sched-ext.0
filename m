Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4429740DFA1
	for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338138; cv=none; b=FTO86Bhtnqb9xeKbSvVeSzB7Zl7o9jc+RZuF37IlNa7aqEGQcuAeBLDXm0tw7/zQClJhbsSw8JbjciZioeKaSpq6PKAX2yu1vLo/H8McvHLW1QQlWc+FcJ9pdpjQNsqt6P+jgGG09ds3/To2CJfSrFyar4dXmrtqTE2v3+tTD6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338138; c=relaxed/simple;
	bh=4bglTImz9Sp2rODHW2D9z8ZP0GDmfEyIdQnrUA26yhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciQUeHxDVFsuvtHn8WCHSlwSHiFoEC3/s3Z9xdMDVf14HvrRBlHqhJ+F1kaxaxkpGhkbI/ENXRGxvW0km/wPmEW1uBUqq5i3P2ORF/T+2dDeil/XeP1iOZrkJFrnbQemJOOjpm0noD0J89Gi7zgTbD/WhqOvdJgo5IhCW06bo68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekR56DrJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekR56DrJ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3599126be32so776487a91.1
        for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773338136; x=1773942936; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2f0Kw4MzuOVEMIhInO7UjHI/HT9q8K92lDL5/DcczPQ=;
        b=ekR56DrJp8fkk4G0//U7pk/m3DdKwQBdaMobLqiZUf1DIAJZwEP/1pjv6IO3UCZ64S
         SJPTOGwv5Wfnm4nitny2BA+Dku67RoRE8Qj7LDWPxIG049tA8nCVwYBGM6flqNS43TV8
         pL4eMOrcCJj8kt+v4ORe1Bq3LfZSO5r3XB7KnQl/WV593Oq44XAPCnLvRpwjQYh3PrGS
         94N0gFWv47fTFNdQ5go1dxkEk9tiaxxnXkzhTEobfUJM8XQy6Az0VpdI6ohxWO9NvkSs
         V9OsXxrcaDTJL+91C+XwG7Y++B37AERBz7MJ5eMcvmpT1dO5Hsb7AHcOXltoVWlK6yq4
         jsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773338136; x=1773942936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2f0Kw4MzuOVEMIhInO7UjHI/HT9q8K92lDL5/DcczPQ=;
        b=YUZJcJEHfys81k+ONpsfmcZK3k/s7AxSZvhLD9TxokWDKUA+6XPZ+M1RknJ+kk3UJ8
         Db1vAdcE7K2PfAm6YYSSF4N5h5D+8BViOJAhNtFKiHUEOpz0lqAG5cxBeMDT+6XjIO4x
         A//SN9eXsLlZFrP6nRWUvWibMSBxdfx1gxois5x/WxtskcSXKKxvecJR2wjtZofLodHJ
         jFnYI/mMNC/taskGbYQCQYiB/sgKvBM/enZ7ODy9E/qNN9AQTsCeZxvfYst3GoAbwFzh
         CzR6SMWz8vUnvfL6q9pTPTzUzuxuu02ZJrTzl3l/U4XFZ2JFiWvfAZjcs5BQVkXCMqVW
         l1lQ==
X-Gm-Message-State: AOJu0Yw1VNgjG/Hwwdtue2yNb344v43tQTbrFvYLYgxH8oNyfOM3+L/2
	ppzu76nmiZTaeemW2x7smygGkJj4evpVrtXI6YofOcmF8AwT1kNyRTW1blTekx84
X-Gm-Gg: ATEYQzwJV8dbBxDhm+gliQ7aa01H0zZuyaI+el6HMBvuapgiW9dzcD8YEVdsp3lAKGU
	B+alhF7UjDNjtVi6iQE9TOzRcwmSnah5fD2Uq57MHOkbT8p/oBXvWtiu3xlQp5boQN4EntZwgye
	pNvHfpsfjY9VXch/DjaBcmZVZhLlrn3YVXXXioxtNgsvgEDA4my32bYatxv3yWH8zFiSBKX/ohQ
	HyrcbY3wqBJ16EqAT/AfoFWVuG3xMdNMVCAaKvji7/t8FsOQFFfnRdmfBTSHujz+RRLBeYpp3B8
	KzNkY65b7OCLjiXc1gYVYoN09vL4DNL3GU+MAxwh+wPYOIH8q6bqvPIiAdQjD8YI/VrrEeR6I7z
	an0LhYfuRGDR7zT4Y5vdNy7YueD2mPX0JXEO/2n3c+eHfS8zIGMizS/I14W4DbOhSAd3+lj0+SA
	zdfvAV4Aq49gYiEmsMFdj89na/FPFYyE3P+uKCU5svOxJPBAkLCugf8dA4J7YsL6w=
X-Received: by 2002:a17:90b:57cd:b0:359:f3b1:6811 with SMTP id 98e67ed59e1d1-35a21e30c1emr467084a91.1.1773338136257;
        Thu, 12 Mar 2026 10:55:36 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d94d:d676:4576:a8c4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf24c5csm6027353a12.12.2026.03.12.10.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:55:36 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2 1/2] sched_ext: Update demo schedulers and selftests to use scx_bpf_task_set_dsq_vtime()
Date: Fri, 13 Mar 2026 01:55:26 +0800
Message-ID: <20260312175527.1220540-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260312175527.1220540-1-yphbchou0911@gmail.com>
References: <20260312175527.1220540-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Direct writes to p->scx.dsq_vtime are deprecated in favor of
scx_bpf_task_set_dsq_vtime(). Update scx_simple, scx_flatcg, and
select_cpu_vtime selftest to use the new kfunc with scale_by_task_weight.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_flatcg.bpf.c                         | 9 +++++----
 tools/sched_ext/scx_simple.bpf.c                         | 6 ++++--
 tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c | 7 +++++--
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index a8a9234bb41e..5cb92b4f1635 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -551,9 +551,10 @@ void BPF_STRUCT_OPS(fcg_stopping, struct task_struct *p, bool runnable)
 	 * too much, determine the execution time by taking explicit timestamps
 	 * instead of depending on @p->scx.slice.
 	 */
+	u64 delta = scale_by_task_weight(p, SCX_SLICE_DFL - p->scx.slice);
+
 	if (!fifo_sched)
-		p->scx.dsq_vtime +=
-			(SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+		scx_bpf_task_set_dsq_vtime(p, p->scx.dsq_vtime + delta);
 
 	taskc = bpf_task_storage_get(&task_ctx, p, 0, 0);
 	if (!taskc) {
@@ -822,7 +823,7 @@ s32 BPF_STRUCT_OPS(fcg_init_task, struct task_struct *p,
 	if (!(cgc = find_cgrp_ctx(args->cgroup)))
 		return -ENOENT;
 
-	p->scx.dsq_vtime = cgc->tvtime_now;
+	scx_bpf_task_set_dsq_vtime(p, cgc->tvtime_now);
 
 	return 0;
 }
@@ -924,7 +925,7 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
 		return;
 
 	delta = time_delta(p->scx.dsq_vtime, from_cgc->tvtime_now);
-	p->scx.dsq_vtime = to_cgc->tvtime_now + delta;
+	scx_bpf_task_set_dsq_vtime(p, to_cgc->tvtime_now + delta);
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(fcg_init)
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index b456bd7cae77..a61a7df81e49 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -121,12 +121,14 @@ void BPF_STRUCT_OPS(simple_stopping, struct task_struct *p, bool runnable)
 	 * too much, determine the execution time by taking explicit timestamps
 	 * instead of depending on @p->scx.slice.
 	 */
-	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+	u64 delta = scale_by_task_weight(p, SCX_SLICE_DFL - p->scx.slice);
+
+	scx_bpf_task_set_dsq_vtime(p, p->scx.dsq_vtime + delta);
 }
 
 void BPF_STRUCT_OPS(simple_enable, struct task_struct *p)
 {
-	p->scx.dsq_vtime = vtime_now;
+	scx_bpf_task_set_dsq_vtime(p, vtime_now);
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(simple_init)
diff --git a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
index bfcb96cd4954..63e03fe5d983 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
@@ -66,12 +66,15 @@ void BPF_STRUCT_OPS(select_cpu_vtime_running, struct task_struct *p)
 void BPF_STRUCT_OPS(select_cpu_vtime_stopping, struct task_struct *p,
 		    bool runnable)
 {
-	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+	u64 delta = scale_by_task_weight(p, SCX_SLICE_DFL - p->scx.slice);
+
+	scx_bpf_task_set_dsq_vtime(p, p->scx.dsq_vtime + delta);
+
 }
 
 void BPF_STRUCT_OPS(select_cpu_vtime_enable, struct task_struct *p)
 {
-	p->scx.dsq_vtime = vtime_now;
+	scx_bpf_task_set_dsq_vtime(p, vtime_now);
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(select_cpu_vtime_init)
-- 
2.48.1

