Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ACD1DDC3F
	for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773563114; cv=none; b=a94gAdtJs2ATEmJ8KH8bmhtjRhBA+vEXGkuGBw1rY8HlZUc60AWISAKv8+9pwtDQyBeD5F+ctiyY6r4bhERQij5jFuVzTvf1SYy32ibcEQKQM8cN3csNVBknQguhbYlDEuwjdB3HN1y6acFNozgjNiKmYz7OcRZq8u21CiMrwc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773563114; c=relaxed/simple;
	bh=eR6JsdCUrjj1SBC4byijPfhCkhD84LwhxaHaYFBJ20s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kX2epP9iS2uX2bQpCsOta4UL7XcoB6y2y/A2GU5tgHNJUUI65GKiV7oiNhh/sy/JsAjGTg16Br79hs1qA588VFJBiFR4ANZyDC0eTwa9xO2V1URqcjGwW0LXDamU6XMue5yS/obHw2nKkOa6qhCZCBdwY6T8OuWE9qdFcg5BF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJYn4Oz3; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJYn4Oz3"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35a1230c60eso1813436a91.3
        for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 01:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773563112; x=1774167912; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UK+xQieVZuatnkgqzUyesXNiZm0u5+o2ZZs7ipwG9FA=;
        b=LJYn4Oz3ARzldePO11asotZhB62Mt/QCZtCzN1hiIZKXYw4hk0uJ6dwvTkiHhQ6EQi
         uP58tL9mi6qlg9NUJFdK05rYUaK6SIjctmw/o7ArruWP174qNUd1IPZZvfUyE8e5XEuS
         Fu5raxDZy0QmJgH1nCgNbfVqph6Mw8YRNqs0XIEz4lJcaUKGpRCC5ziU4BURsAsHtd6x
         RLmFHNiv1Skhl8pOJLipGvdy173Di1Vx/8PGBhMq91X2dlmSs5xZwMHpTnTvBBJcdE82
         bZFZG5YgsGH7Uf9WaeCJCdJWQT96dwGgzo440riAKMzgrTeKc9Lxsn4GfUy8I083Hv3E
         K1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773563112; x=1774167912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UK+xQieVZuatnkgqzUyesXNiZm0u5+o2ZZs7ipwG9FA=;
        b=Jh21UXgUn7nrDW/c7pEJ9yejV7CPFpfuIJ6py/bmRp/FaZdfYcXBpZ6oFRVI01Ldcr
         vqlrTjkY7fXczIFKHgd7EDxu+ji51zy4A6ovS6piIBxzFdgXd7sdUg3k+FPtbaKTxj0N
         GTYWnlhu7sCdLRdGWnicQ90zMfiNUfPVCAwUaUUE+MYPyiR518A3e4RSkdFx93ILk2YE
         F1HzTMpOhas+n7WQB4LiRzFaXYfxhDNwKyuhyTdviaeuF+bcvvbhpGXZhCOJ6arXcMAj
         toarIkc03nOaSeQveqG0KXYgyUhUYHgR4PTW2cnGhjYCvhSfStCbfoJ+G66XNIhx7F76
         YI5A==
X-Gm-Message-State: AOJu0Yzal7rl2ocIKno0hQjt4jm9HUxskvTWrLalUuQKqmDY8qmlOJXE
	Pr8KjSbhbjckYhO6XPoLN2u41mjW6OSBZh6NINnIgPwI06GSv9ryU1JvA60jIKS9
X-Gm-Gg: ATEYQzx5ux6Y4h0Jb7FhyyTZtX20E+6rzAHpzbQRj96RvsXsZEB2PePMLZrU398h/pY
	Ic/GH9lUvjui6GLBDoh5BDtxLKqsYlhWEjuGLwzD4XOwsXhj6dDSMcWzBYVj4BJUYe0y/qaV3oE
	boT6daDecylvRxig3lnhMhAeqZnKk18Tp9IWOAbnB3qsrlY+p8GU42fq9tc/NxlyiQsgo6excGb
	82SQyeKaYbRHlsg8dvv4iPc0hLAGL0k0gynl6WYKAKmwWQATk2SGL532FTlBuMcoPE17Zw1eL/l
	gkiAQyajf3JzFDXWg+ekwljBAmRhoXTnqI8HkP8BaD7ZF0nNcqUIA0cQ9jM0OU+KKA5Zr7ALLSz
	Ar5lsC6FSd3O7MjnWL3F77LgiXrOoOdkTpyvHUVrCEP7/gfZPTbSnU6bUGuTXYywhCfXQ95Ut2W
	1z+qai/mpwfWZ4gA/DiPRBy1JTz35uL5KMdXrczeVWcxhUb+SrVe9o
X-Received: by 2002:a17:90a:e7d1:b0:340:b912:536 with SMTP id 98e67ed59e1d1-35a220555eamr8410747a91.31.1773563112034;
        Sun, 15 Mar 2026 01:25:12 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:53cd:7adc:9650:ee87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a1c34fa3esm9316523a91.4.2026.03.15.01.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 01:25:11 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v5 1/2] sched_ext: Update demo schedulers and selftests to use scx_bpf_task_set_dsq_vtime()
Date: Sun, 15 Mar 2026 16:24:40 +0800
Message-ID: <20260315082500.597204-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260315082500.597204-1-yphbchou0911@gmail.com>
References: <20260315082500.597204-1-yphbchou0911@gmail.com>
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
 .../selftests/sched_ext/select_cpu_vtime.bpf.c       |  6 ++++--
 3 files changed, 15 insertions(+), 9 deletions(-)

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
index bfcb96cd4954..aad8de51723e 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
@@ -66,12 +66,14 @@ void BPF_STRUCT_OPS(select_cpu_vtime_running, struct task_struct *p)
 void BPF_STRUCT_OPS(select_cpu_vtime_stopping, struct task_struct *p,
 		    bool runnable)
 {
-	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+	u64 delta = scale_by_task_weight_inverse(p, SCX_SLICE_DFL - p->scx.slice);
+
+	scx_bpf_task_set_dsq_vtime(p, p->scx.dsq_vtime + delta);
 }
 
 void BPF_STRUCT_OPS(select_cpu_vtime_enable, struct task_struct *p)
 {
-	p->scx.dsq_vtime = vtime_now;
+	scx_bpf_task_set_dsq_vtime(p, vtime_now);
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(select_cpu_vtime_init)
-- 
2.48.1

