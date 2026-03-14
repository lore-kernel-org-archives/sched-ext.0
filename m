Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4922580D7
	for <sched-ext@lists.linux.dev>; Sat, 14 Mar 2026 03:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773459446; cv=none; b=ije1SxWOhZcINqG/+5rves60gN8ILp6IS4olqL2rBE0nRrAX+rc8IejlLWHFMEoWQODk7TsBhRo0zYQIcwP8gW+qe9oGcAPRSeY1f7swTHBFmVJR5cbnVYl4f9SYgMj0O3Qw74ttMtS8jJJxBSAXatXVU5wNxqMkewtoQ9V5vrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773459446; c=relaxed/simple;
	bh=w3irt/RQCFtHrbwYQANUdRUNExQII+n7wjgGprH8q4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icZwM+U5ZEJclOsXQaxl5I8xBGHUApjiQGnWbouidcR6S01RTC4r9ucKQbSwwH48xryzjFc1eoojP3syXe07EfymoH3xb9hj1x/JshsKLDxI0krWgI8zXjsJHDsvsgF6zvF9hSgVr9bAn7XDX+Bf11VliooA+1USVBFElR/AZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLvIjj2W; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLvIjj2W"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-827270d50d4so2699453b3a.3
        for <sched-ext@lists.linux.dev>; Fri, 13 Mar 2026 20:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773459444; x=1774064244; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02N8y8PJsDsTPzfwgzznRSLEeTr3hDIwi8ndoYe9FwI=;
        b=OLvIjj2WzHyoFhUop1zYbfoBdtEc/2NqtVvF7pAig7iCsd1CCD6RSjRvEc5M0PMmUh
         tS54GWSbMAPGBN9p1zySSIpsmgUOjQueGL8VUs69xej87d8NNb0sMVsh73ED++21M6i1
         V9CUrrobOJrMUlVg+8CHLeU38/ODs3tBU8UnWgP2xKqSpllVekZsOu7NwHBuOhw/J0V0
         U1+31hrOyW5OEEeDEyNjOAtlheGXtmP9dg2dwDGpwFQrGC4mteOcgsQBXkSFm6tj4b3H
         AI16viiCbgtYQOZ+B62PSWP7OkxNK9vNBaCnctrIikwL7I25ypCU7Ity1Cf4gGmddss3
         MW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773459444; x=1774064244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=02N8y8PJsDsTPzfwgzznRSLEeTr3hDIwi8ndoYe9FwI=;
        b=iygUAIXvsL3q2l8V8UJO19hf8ILnLTaBIMjx5oHAdxz2Vd66DNucGtvNa9KJUuv7l/
         zjgBvoQGBm4Xn/yhnJV0QhrXnm3vvw4LU+a2Dpz2rcB8RqxbGKPu2uL7160a5jAaLwz7
         pw/vJt0oN892a8TO3jGF3D8H3HsnVCubGKqT7ZcJgjXm/HvnK7qgx8jQuZaN5xuq4gF5
         FH++FHdflg/q4ETwl4Du2ZgiFuvyY63wszkTu7DyHdi3eybkHJxPdhvTYKV8T36E6O7g
         Qd+Obe4WdDAxENFGLcorC+h8RZArxd+hYtY7Tw7h3DzCp1a/Msi4VYBDQEQt9wOiMIO6
         wZHA==
X-Gm-Message-State: AOJu0Yz1F63Xq9k4JPvTqXUakDqUDBlN0f1wv7r/2Fwi6sCTYhJZwo2G
	R6Na9H2k5xALOQgeXhTBU+5Wbv0RaJzrnhXZr5mklbXyGq+OYSpE4da70N+nty67
X-Gm-Gg: ATEYQzyMo7gIqBygO6qGvFZjET7HmVqOOzOU7UPIRbNd+T0tS7vUH6tOr2A7x+LdVx4
	Z0XW2qiNKvFRrowWd247iH/xQ0iesIEvZuZtTkCOv4kCkpidvpe18NIbm3H9PW1v0QmxyOxGkZr
	adzxYbyhsXsdEs4mhY4dPlUdLmTSU+A89swPdJjj/XEH2npb07fyqsC/zhbjUAc6GeLqZnzV1Z7
	lQD/Cf7ZN3JLKLRZFVRFYEF7LnK9uiPyPVhwOksIm32vjDqnlTwzqqxqyCFm1e5ezLOqexI1ZOA
	W8rnKKUOyCY1HKjfd+KaQHKM7syrD2B94mHdnnGFApHomWPSMjLRT1nX+bsGHaGXa1fCfxQ24es
	cEZQMHi7hhHKwJWj1FQsWXniPzIhBaj2EWHht4KD8snJYRrPr0rQuO2cZWaJ9HPS9sxOH7LRe7O
	0PlOKOtsgxHEnYGPzDujhTTdqy070k/itJoaro1mVwy0M7xWkE+Wg=
X-Received: by 2002:a05:6a00:2d99:b0:81e:12f1:d8a with SMTP id d2e1a72fcca58-82a198d7062mr5152085b3a.34.1773459444040;
        Fri, 13 Mar 2026 20:37:24 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:812:f4b6:2aba:4bed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a073ad15asm7045304b3a.64.2026.03.13.20.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 20:37:23 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v4 1/2] sched_ext: Update demo schedulers and selftests to use scx_bpf_task_set_dsq_vtime()
Date: Sat, 14 Mar 2026 11:36:44 +0800
Message-ID: <20260314033708.26483-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260314033708.26483-1-yphbchou0911@gmail.com>
References: <20260314033708.26483-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Direct writes to p->scx.dsq_vtime are deprecated in favor of
scx_bpf_task_set_dsq_vtime(). Update scx_simple, scx_flatcg, and
select_cpu_vtime selftest to use the new kfunc with
scale_by_task_weight_inverse().

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_flatcg.bpf.c                     | 12 +++++++-----
 tools/sched_ext/scx_simple.bpf.c                     |  6 ++++--
 .../selftests/sched_ext/select_cpu_vtime.bpf.c       |  7 +++++--
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 1351377f64d5..6d3a028d7b59 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -551,9 +551,11 @@ void BPF_STRUCT_OPS(fcg_stopping, struct task_struct *p, bool runnable)
 	 * too much, determine the execution time by taking explicit timestamps
 	 * instead of depending on @p->scx.slice.
 	 */
-	if (!fifo_sched)
-		p->scx.dsq_vtime +=
-			(SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+	if (!fifo_sched) {
+		u64 delta = scale_by_task_weight_inverse(p, SCX_SLICE_DFL - p->scx.slice);
+
+		scx_bpf_task_set_dsq_vtime(p, p->scx.dsq_vtime + delta);
+	}
 
 	taskc = bpf_task_storage_get(&task_ctx, p, 0, 0);
 	if (!taskc) {
@@ -822,7 +824,7 @@ s32 BPF_STRUCT_OPS(fcg_init_task, struct task_struct *p,
 	if (!(cgc = find_cgrp_ctx(args->cgroup)))
 		return -ENOENT;
 
-	p->scx.dsq_vtime = cgc->tvtime_now;
+	scx_bpf_task_set_dsq_vtime(p, cgc->tvtime_now);
 
 	return 0;
 }
@@ -924,7 +926,7 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
 		return;
 
 	delta = time_delta(p->scx.dsq_vtime, from_cgc->tvtime_now);
-	p->scx.dsq_vtime = to_cgc->tvtime_now + delta;
+	scx_bpf_task_set_dsq_vtime(p, to_cgc->tvtime_now + delta);
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(fcg_init)
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index 9ad6f0949987..cc40552b2b5f 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -121,12 +121,14 @@ void BPF_STRUCT_OPS(simple_stopping, struct task_struct *p, bool runnable)
 	 * too much, determine the execution time by taking explicit timestamps
 	 * instead of depending on @p->scx.slice.
 	 */
-	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+	u64 delta = scale_by_task_weight_inverse(p, SCX_SLICE_DFL - p->scx.slice);
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
index bfcb96cd4954..a2c6be98b81b 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
@@ -66,12 +66,15 @@ void BPF_STRUCT_OPS(select_cpu_vtime_running, struct task_struct *p)
 void BPF_STRUCT_OPS(select_cpu_vtime_stopping, struct task_struct *p,
 		    bool runnable)
 {
-	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+	u64 delta = scale_by_task_weight_inverse(p, SCX_SLICE_DFL - p->scx.slice);
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

