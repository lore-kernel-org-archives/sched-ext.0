Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BBA3C5DB2
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286522; cv=none; b=MdBth3cjeuNGS0typrcFt2KV6aLthXDPihBDS5LR5zs/Q7lumvFkukGaBPUeSMXNIYtEVCACBZ5eSSorcHYUZXBK6nqY+7sMB6CieNtvI9mmZgwNLHnGTqO/FIE6iMD8dT/gGXE0fEVA3rxc3vgn1KXLU8J8dQJZvZuA4A9XUt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286522; c=relaxed/simple;
	bh=ZdPJIvrw1xsdBqGbOLgm/BmgcNTpX49zeRi6sWbA4aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o++1Hh7tmhZqTGE1ZHmbmkM7Lv6ZBfFCnGmRRFHSGInuGYshgUha2a8P3HkTIEkjDkxDWastkwIvWDIVpwcjDepvmKcXOlv7NOpV17m2SgwckG7mgUcvTXOpZko6VFCyoQ+xIY7zWABfnQe4AtpXP9TQlxcf3Xwjt6PkDDGiNoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBiJCc7R; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBiJCc7R"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ab46931cf1so45794505ad.0
        for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774286520; x=1774891320; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0rM+ui5GTiisROL0HxtrBc1ybnIFEl3H3HTV1YRb34=;
        b=tBiJCc7RS+SYAqGxXmyRS9NvAG6ZNmQ7nbLZBPMEXsL1y3cz7Pv9fry9vZfnGTesXu
         0PVXGwa5FJ8vcu0UmrhAeGLrHBnvYIlOPha56LM1BxWJSJtBnls/YLa72h1e83ynB67q
         MoY/BLxSfygI6n/2c1RvwflG3zElAhJUDz0lVTRHyheYqKYEJ+FoSIjBVWdzLMQT49ek
         XTCrLd718KRWPNtihusRcmG+k+t4EFxflNcVnoullLK4ee6UwI0yWLGKdtQS/bpTrkvM
         7v6GfV44hD95HwpTiecvS0dWczGZ9Ysha9C9yTtAJUJmBcmcKc28F2iCm8q4tZpP2PrT
         nCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774286520; x=1774891320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X0rM+ui5GTiisROL0HxtrBc1ybnIFEl3H3HTV1YRb34=;
        b=HjvKfD3no0HdSPmUIZh3btdALdgygr3fnNX6w/MepoNU8lnGYvmifYD5+0cmfjPOAv
         j64zLHM1ohCgRa+cyyB/t7gmWsBULYOmMQ1CmqwBGP+XEHET0+eNJ2Dd2xl9A6201NtF
         TIG6ssSFFZoqj3ejq0aPCkNWfUSvh9UmZCTH4BQpdUby/VpYpJOg0GndxqV9qvHfcF5p
         wd6onEjyYFIKzeSxpXDySa7xoBPASktOYeXtJ0LAqLGNj2hWfl8yigYijgWXc3E0M7wi
         JrMpqM+4vnBrgjPUdH6c4GpaQ5iqiHv6Kuk3zNENhXvBrCTV05Wa4rdxCWy+9h/xysik
         FNFg==
X-Gm-Message-State: AOJu0YxK+MKOUP5P/WnGaDTw44vsbyAW5kQQZZgZ5hwiGXhsma3SG/tX
	6fAqPhntOpuhRN05FW72zEgHC3zf5CMcR1HZ6AzCMWetUGOfbhpdsyFEHIsQUO7L
X-Gm-Gg: ATEYQzwNprJf3kGTX5vuKTJ8ohKIgy0N+yTINFb/x41mjwfNjh35/NN+b1fDtmtA5YH
	1cS08HkM1deRiYhSU6IKtOyWEzGRsQP8EtVk4smVFMC1f7kOwAFtFwoRabkCg0WLcukAsZF/+x2
	uZcqRGSVhk1xLf7K0l6nflg+hQE5OjXqmPDbYtaBqE5nfSFAo8BiZBTEVUUxYrlYFftIZCw3gn5
	ibEB1TzNGuhrrL/nw4uVl4Z0tWbG9UMWdACyhptf6A6PefL9y5pYVvYHIytmd7p0rJPHhUgF946
	QoATesjQCNLJowN8apGZOjAk5ZmaRlo673zz2fiHod3dBB35SfSDXCbOx5PVxwIwkhHkkXkjECp
	Wev1xJ2wG7lSDf1oxWXRe7o+oYYq0PDn/+vZG6eYxKOyt4+P0bdiB1vQrLJt1NcIRX6j5yW+JyQ
	2fhh69cTru1FPutQhKIwSPysFJsA47udyF3ZyVjBkvLSAFR2CHP0pt
X-Received: by 2002:a17:90b:3851:b0:35b:a44f:b80 with SMTP id 98e67ed59e1d1-35c007be937mr248068a91.1.1774286519973;
        Mon, 23 Mar 2026 10:21:59 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c95d:66f0:4661:427f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc610c1efsm13552672a91.14.2026.03.23.10.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 10:21:59 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH 2/3] tools/sched_ext: Update scx_qmap to drop __COMPAT prefix
Date: Tue, 24 Mar 2026 01:21:29 +0800
Message-ID: <20260323172145.25689-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260323172145.25689-1-yphbchou0911@gmail.com>
References: <20260323172145.25689-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace __COMPAT prefix calls with the new transparent function names:
- __COMPAT_has_generic_reenq() -> scx_bpf_has_generic_reenq()
- __COMPAT_is_enq_cpu_selected() -> scx_bpf_is_enq_cpu_selected()
- __COMPAT_scx_bpf_events() -> scx_bpf_events()

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index f3587fb709c9..3fca2e99775f 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -267,14 +267,14 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	}
 
 	/* see lowpri_timerfn() */
-	if (__COMPAT_has_generic_reenq() &&
+	if (scx_bpf_has_generic_reenq() &&
 	    p->scx.weight < 2 && !(p->flags & PF_KTHREAD) && !(enq_flags & SCX_ENQ_REENQ)) {
 		scx_bpf_dsq_insert(p, LOWPRI_DSQ, slice_ns, enq_flags);
 		return;
 	}
 
 	/* if select_cpu() wasn't called, try direct dispatch */
-	if (!__COMPAT_is_enq_cpu_selected(enq_flags) &&
+	if (!scx_bpf_is_enq_cpu_selected(enq_flags) &&
 	    (cpu = pick_direct_dispatch_cpu(p, scx_bpf_task_cpu(p))) >= 0) {
 		__sync_fetch_and_add(&nr_ddsp_from_enq, 1);
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu, slice_ns, enq_flags);
@@ -851,7 +851,7 @@ static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
 
 		dump_shared_dsq();
 
-		__COMPAT_scx_bpf_events(&events, sizeof(events));
+		scx_bpf_events(&events, sizeof(events));
 
 		bpf_printk("%35s: %lld", "SCX_EV_SELECT_CPU_FALLBACK",
 			   scx_read_event(&events, SCX_EV_SELECT_CPU_FALLBACK));
@@ -931,7 +931,7 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 	if (ret)
 		return ret;
 
-	if (__COMPAT_has_generic_reenq()) {
+	if (scx_bpf_has_generic_reenq()) {
 		/* see lowpri_timerfn() */
 		timer = bpf_map_lookup_elem(&lowpri_timer, &key);
 		if (!timer)
-- 
2.48.1

