Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDCC32B9A9
	for <sched-ext@lists.linux.dev>; Fri, 13 Mar 2026 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366595; cv=none; b=d2LgXDRlUwx7ImirIms4a1WL2jvoQvN2mkegla4+bwayNlPBdQZxRk9IWFAvgsSa40t7P+ZtN/bljI9SJfDm7R9vJuIQtvF2qrbRHKTnluWQ544Y5DssLGwpiMxHlHWbeRBP9t796CccqK/Frdlqw50MIhdGxipiLU7sCq+kmVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366595; c=relaxed/simple;
	bh=aqQP6bFc+dmDU1PKZcXDQO89MPchQtyYKRiMFBafx3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdZxMVEa244Z1IxhdvFFDwhq7rP78QrAha886qqXUp+7Bm+Utge/zfQglQLNNwCvxTnqf7X0GbmQmH6wMC/R+2FjzZsIIEf67JsTNG4I9/vJWyeDInfl3kvgyNB2Yj/o+yePpA/huYcPp/4qrG0voU/stqTCPu9zJuY+AC9so+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9Ij84uy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9Ij84uy"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82a124f3a5bso605016b3a.0
        for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 18:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773366593; x=1773971393; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rzrY4bTpycrfbExASg9fskAN0ReDYhkEzsx2U4hiEQ=;
        b=X9Ij84uyDjkDD2eoSwNK8z+p19WD6+mubzbEi88VVmYCwqcQ1R6s0BvXR6fCwO9CK0
         0T6+g1evhHZU5cQ/xNefS7+NgYsTn08SP8BH5bq/GkE6xnL2DRokSTx/atyIH5Dux0g/
         HhnOUMvqVLEi/Y3CkQXg+aVnBhVjmod1gHTB8gXb1ILNy1b00T2lF7d0H+K1YVPgfWzi
         WdgsdqIxWcqDJSUeLDkcRdVesQVkBlGQbvYQZtIrB+X57mQFLJpO8NLQJbryU9Vy8FR3
         kO2h58q4MclHXjMg/jXxTbx6HznaeeUiNndVeyBg/JMjzZnNnQ1+QT7xP5ZVDmcuMFXr
         zn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773366593; x=1773971393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5rzrY4bTpycrfbExASg9fskAN0ReDYhkEzsx2U4hiEQ=;
        b=Hv6/AiHpRBwe7WwPOhyUEgcalyAkKOjlrWbu2B3OS8xh3+H8efWJ19C35rFiQjXvAQ
         1Mr8nvLclVKhwQZbkx640DoU4HZol2WXmlz4t/Ni+I1M488eqmgSa3ym8qinUsUFOXyj
         XNIRXYEJTnxTBenjvyVDHXcOJ2nxIeBvb5vh2TMCt68/GXffkFGQ4ojyEV0vSU5+cXwj
         qr0lvQlOSSSeh0exDhmw5TkBtyjEvyRwFqL1YDKRvEkQZ/9rwXsNrwqgtZH+QAjMRmZj
         AguxYppQQqcgifgzbsxlHQJkMviKAHFjeoTN2f5tXRRvf4H4vvJxofg5Jo0+mbFhYQrA
         Gljw==
X-Gm-Message-State: AOJu0YzPdA/e8ZLvhsC+NzZKwwSrnlhokAwyWBTUIC7upye4zpDa4Er9
	+3Da2h2/P7YmJYSxm9XlNqqP3O7TUS7BnfnN72xHlkOQa4rNKcFgWkwT9EnfBi+B
X-Gm-Gg: ATEYQzzKiEq/34RqugQQxX8xGKvIJ3biorVH+DfHTbk/fk2oG66OIn1HgNmzdaaww7z
	zMd9gASpSp1r/jXblOo7ox3IVDcaR/xe6jykRRmq+Uaqki77C46MNN6hPa542WmhHJJOsCyrIP+
	80cwDkxQ1om4zGs5RRByrAXgvr36H3T5ixXf0Rzr2uz0uhHh2vwOib0Uu30EoLTBmQOGhpV7FeZ
	+4YuQAD6k+Q+03YQDa623J7psUu5giOw7NfxZSWxiKJAoJ/GHK3++PUMwwburrwADJpTJhlo8p4
	lib1IUtuRQ9VtYNjsWDTdpYuSb0NJhsSwrVbAhr+GWn60faaysiPCNuOcupNOHjxkKjmnvs8v8o
	BRhgpC82jsnUXGo3bCqBTZeRcPWRdEx3Ak7T+dtaJuzXPBZu0KmrpOt442W3vLC9RXXq5UhBKoL
	ib7As+uetvY1xruFdw4QjPZaKquZuDEKrkkVoMUR9E97i4y9JUQQ9O
X-Received: by 2002:a05:6a00:7702:b0:823:3079:7c7 with SMTP id d2e1a72fcca58-82a1986ca0cmr933163b3a.29.1773366593435;
        Thu, 12 Mar 2026 18:49:53 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d94d:d676:4576:a8c4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07365090sm4268676b3a.46.2026.03.12.18.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 18:49:53 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v3 1/2] sched_ext: Update demo schedulers and selftests to use scx_bpf_task_set_dsq_vtime()
Date: Fri, 13 Mar 2026 09:49:43 +0800
Message-ID: <20260313014944.1234667-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260313014944.1234667-1-yphbchou0911@gmail.com>
References: <20260313014944.1234667-1-yphbchou0911@gmail.com>
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
 tools/sched_ext/scx_flatcg.bpf.c                         | 9 +++++----
 tools/sched_ext/scx_simple.bpf.c                         | 6 ++++--
 tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c | 7 +++++--
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index a8a9234bb41e..c734ef616c7f 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -551,9 +551,10 @@ void BPF_STRUCT_OPS(fcg_stopping, struct task_struct *p, bool runnable)
 	 * too much, determine the execution time by taking explicit timestamps
 	 * instead of depending on @p->scx.slice.
 	 */
+	u64 delta = scale_by_task_weight_inverse(p, SCX_SLICE_DFL - p->scx.slice);
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
index b456bd7cae77..024c3ce29610 100644
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

