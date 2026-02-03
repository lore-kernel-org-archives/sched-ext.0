Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBBB17A309
	for <sched-ext@lists.linux.dev>; Tue,  3 Feb 2026 03:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770088853; cv=none; b=tDd7eYAWpiOaOMS6hkpk8ggPg/uxp3ZS1bvhq8aGAKV+2K/rnvG22Rh6pA0HKQ6saPoP8h30dbCNDAhJjE9AFnns+xnSug4TBbX/M93cVelzO3tyBtxuHMTXjroyhao5RRiHnHUGC09mMSjMpyVpb9x3IsRo0vCVBKTUhaO1WnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770088853; c=relaxed/simple;
	bh=JXk8IyqhrHpFxXsAl8dGtNFL2Lakm80UhdvwCm2rA4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FIV8VuWZ86YEEpkfhgnniALZflVTbJMXp2ELJmrWBrMc6cD4pIa3ejZZi4htaB4+1n2QYZPyAbUyTPEzgs0IWxFqZH5n08qG8//IS8gD2+QFYP+hjGFGXcS9rITIPIdY9cU9hKgRYsoULZRgwzjbYyDc7y4vd2RfY3MouD08+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSZIT9Z3; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSZIT9Z3"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c61343f82d7so2036756a12.1
        for <sched-ext@lists.linux.dev>; Mon, 02 Feb 2026 19:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770088851; x=1770693651; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fba9wK0ddQLmfW7kwqc71u405B8id7PXxdc3NF0N80Q=;
        b=VSZIT9Z3L+/YbSvt36RoeVGW+Px5TvMegZGbiwTJW4SYlcKPMyI3ru73E0BVtdLjK7
         m6uYYw3574hwCajNZTon7/kgryP5yMWuo89zrY7PLHAVXhgW1Vty7SYL9iQnQE7nEY47
         bh5JpoDc2MlmT1GGIMt5e2a65Ut/SbMNOUnuwyhKD1ju7xzj0m4miKXf4pzcnr6JrI1d
         no9Jl6qZ/eQz89sWM++UO5+mpx/SHscV0Qfyi5JRfWzzNbobQIJnDNScZtOmUvdiV/dX
         KicLeNauYPOiuwSlNPa40JDjpnUYhxdYVNr4QwDYWPVx5Tt25BGH2jzkPnXI8lOeoTPn
         lH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770088851; x=1770693651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fba9wK0ddQLmfW7kwqc71u405B8id7PXxdc3NF0N80Q=;
        b=NvxaNUVh6fTViDrOmLXr7FUFSuxKKls0iz3H3+gSMkDhotV0fzMJ09LuEJBv1inErS
         sAo1YnXGbUvceUPr5mWIYU6G7jn2NNh5v7/kJE7PwGgLZ46LhHyz1tzEzy++gjwbkHPC
         DBR5EeWU/h9IdJBjy21kbRzJyMrA5FZZsOiSll/giRuJCPhPpiRyTW6YqaWcmPe9o79T
         6YmpOEoSCupugcr8QU72Uu7I8VPlXnOw/cRxAInUh84nbgBgJ8Vo/H2SbOfyaMDKGVD9
         ceE/YdYKfpWW+CryJfnFPAO7SLsSbP0vPV/L66Mfrs5JhsrS+2lTh7ZyzeLoZ4IOS5mM
         Okjw==
X-Gm-Message-State: AOJu0YwKnVx6Jmlwx365AHOUJl/6Vl3CelKqVq+nTDzxz3kEowGH5j4e
	8yvT0agSsRunpfLg4z685cuvV2WDq7jCKOW/ojfQ6hBvWpG7foKdclYa
X-Gm-Gg: AZuq6aIvpF51e/GvArFd+DtsPBrUw2Eg3tHLMo4jRZRk/qagxFRFHd6doBTZOPhv1tX
	S5mOAQ9QYkqKKVu1Ec0qoVaKUN+5z/QSvWzy/0BxgRJ7ujXLhEOHeZz8I6AWtdOnNg8ipAUP/5B
	JoacfB45BIU4PHClsTfu0VMSA5g1YLGaCPU4GTito//F8sIsI02qiILrPvXJD1ZS32jwAP/oyLU
	rXrksJEZ+oizg0A+qDA2/roThBB3+HJUgw5PFvgwUPeUuKZ4PWQvSsblwRf9aLnB89mramKYSHz
	ICxvcQvAxanewYdQ+yltGtO7VNYZl/PZMXgG9bM8k0KZl60NWF8ax+prCQwg07NQeyx3qARruhj
	nTwtlbgKLN9je5RtoCErVN6B8m+Mu6tyhC8q1QN9SqjSbApEksctEP3jH5coxWVg0bVBcuzN6dC
	SpAyU1k1pLkrLfD+2aizKfPadYnoj9SsT2diA36zb7KXE/PqfPY1DQB6C6OxqdVg==
X-Received: by 2002:a17:902:c952:b0:295:9cb5:ae07 with SMTP id d9443c01a7336-2a8d8038ea5mr137502935ad.38.1770088851078;
        Mon, 02 Feb 2026 19:20:51 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e4189sm153967435ad.83.2026.02.02.19.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 19:20:50 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	suzhidao@xiaomi.com
Subject: [PATCH] tools/sched_ext: Improve BPF verifier arena detection workaround
Date: Tue,  3 Feb 2026 11:19:54 +0800
Message-ID: <20260203031954.915681-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the BPF verifier workaround in scx_sdt scheduler with a more
elegant solution that:

1. Uses volatile cast instead of bpf_printk to generate LD.IMM instruction
   without producing unnecessary output
2. Adds conditional compilation based on __BPF_FEATURE_ADDR_SPACE_CAST
   to eliminate the workaround entirely on modern toolchains
3. Updates documentation to reflect broader compatibility concerns

This eliminates the side effects of the previous hack while maintaining
compatibility across different kernel/BPF toolchain versions.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 tools/sched_ext/scx_sdt.bpf.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/sched_ext/scx_sdt.bpf.c b/tools/sched_ext/scx_sdt.bpf.c
index 31b09958e8d5..88ac3043a643 100644
--- a/tools/sched_ext/scx_sdt.bpf.c
+++ b/tools/sched_ext/scx_sdt.bpf.c
@@ -64,15 +64,15 @@ DEFINE_SDT_STAT(select_busy_cpu);
 static __u64 zero = 0;
 
 /*
- * XXX Hack to get the verifier to find the arena for sdt_exit_task.
- * As of 6.12-rc5, The verifier associates arenas with programs by
- * checking LD.IMM instruction operands for an arena and populating
- * the program state with the first instance it finds. This requires
- * accessing our global arena variable, but scx methods do not necessarily
- * do so while still using pointers from that arena. Insert a bpf_printk
- * statement that triggers at most once to generate an LD.IMM instruction
- * to access the arena and help the verifier.
+ * Helper to ensure BPF verifier can track arena usage.
+ * On older toolchains, the verifier may not automatically detect arena usage
+ * through indirect references, so we provide an explicit reference.
  */
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+/* Modern toolchains don't need the workaround */
+#define scx_arena_subprog_init() do { } while (0)
+#else
+/* Older toolchains need explicit arena reference for verifier */
 static volatile bool scx_arena_verify_once;
 
 __hidden void scx_arena_subprog_init(void)
@@ -80,9 +80,15 @@ __hidden void scx_arena_subprog_init(void)
 	if (scx_arena_verify_once)
 		return;
 
-	bpf_printk("%s: arena pointer %p", __func__, &arena);
+	/*
+	 * Generate LD.IMM instruction to help BPF verifier track arena usage.
+	 * The volatile cast ensures the compiler doesn't optimize away the reference.
+	 */
+	(void)*(volatile void **)&arena;
+
 	scx_arena_verify_once = true;
 }
+#endif
 
 
 private(LOCK) struct bpf_spin_lock alloc_lock;
-- 
2.43.0

