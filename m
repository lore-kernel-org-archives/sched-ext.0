Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B903A6EE5
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557774; cv=none; b=SJxPgNPgi+oadbDY1ZxCyhh8qWFW/nCDsbD1y4qv4KPcIgxVuLWJWdaHDzJUw1tjpV0uDxP1u6h7wwEJ8UjsyD+t6gLQQ6WwjaS2OXRMPeCiJVHJaId/cTVYd2BFxoNpZhgWh1aT82DoeHDMTMml98Q6OIUvuLPZ+h0wJQir5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557774; c=relaxed/simple;
	bh=Q65uh6cjjBWAZ3c12PK6mxOEKiuylXPXPaMvVDeeBbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVZGP2v+PlFsDL+a37laEaSRYgK6T+GDcz/vqnEbSkgGUfdUbVMLFzJlWoebmPF7GkYdv6Shg+7o5CoesxNkxEMNtSRTOJWWSI2pVJ7LtTtXexW8H0fEhKULgeJxNbNXR9yWUxdy5Vig6v8sU0/bUrb/a+5SmlxSoyoNLllqMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrIeIg49; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrIeIg49"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so884763a91.0
        for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 13:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774557771; x=1775162571; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEZyVDr5e3OviCxoRt/q1KOLbWsrmmGkIE7t73Pzwgc=;
        b=DrIeIg494FHZF5FObj10Xm5q/3OW4DFatAyarfUtnvhuZ5rQx+K5vC5HVKVxBmbp8x
         9gTD1YQKZ5Hnu4wlpMYaT76Mr2BtkGQOO6GqJW6nEY3rJptwMetP8wVN/PSBW6/JP40z
         5P23owMEIcev/i4FbO/yiSNoASlPkj2kKl90uutRXYr5YFEiGk13s4LFEGPQt5ENey03
         9v35EUEIWGT65J1LViRicUcAcK6S/n9yoEHcyFZBf6FkPgVyV1ldOFiYP9b8HxSYUEpJ
         RBKqzPujaIj1XiUh2bjwrqm9jduqgPLwdnir4QvKw69/Qe1JFnz6knfTilXQx3K68gJJ
         mQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557771; x=1775162571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mEZyVDr5e3OviCxoRt/q1KOLbWsrmmGkIE7t73Pzwgc=;
        b=HDJl9SeuTxLfOK8HjmxscwP+7AfMZFFQ4luP7NlkwenMlFHTEzRzExuWQ15PTXRrlp
         1U4OEGkB0iHQxIkHTuwMeMXzVeAGdLk9Kr5nMlyGExJ7lg05XRGVBhDe6kA4dNHRkmvt
         3yi3ESc3BazJLCoQCNhOkFQIJGERKQ6dpHn9BeZYLXcQ9Jv7u7w0BFzf9tsv8T09U4kf
         2jqZPY4Hwd6XCpBFI9wgOJztkoczCx/5gSYBYZUIupZ5nX53vqMlmWugz0BHpjs5TaA+
         WC/btzKYom1rcIDHvW6ilf8hUDjh/69yTNrSX5jnCbJzamVORg9tnvU1hQOIjBE51HLH
         OunA==
X-Gm-Message-State: AOJu0Yz/azf/7crQwrlHQY9I47icF1mUQ1ZIytADzB8rMBT+b+QQNnon
	00NKeTCLv1JBQA4obBqitA2sKcOxWbkO9WFi3+uT2BVXlw3aAJMk5HTFyooDSQ==
X-Gm-Gg: ATEYQzx5a5a9gd7i3R4RMdNRnb+UdjeObAp1d/OuFFKvbkHh/vph8nN//KfdORgXDfF
	PoIeuAoxmDmLxEMNvmGBLeoYp3URGE8Lcv0r+4PRK0dL8+37wfa5zBHdX5JrMWYagYc/wCGy8c8
	ogj2MzpzcQpOqvk92rRkKM5N8ffIkoBAWd6SqplQQwFw+TmToc2am+Yt6mwjsj3Bno8Z7smc9pG
	Z0ZCitFYdnWjTnx4ctCQtwPBNAhRN67mqfGFjU5ywrr0JWf79d/RVF16j/Dg9SBgYQYscAjVl7f
	DPOp4z0EYlOcPCL1G8mAbAvK5hH+9ZZYy0EAk4G2Ld3Sk8FA6AWYXkSYBz37M6xyWCRJgiYGxv8
	/bgjISCeOMBM3nO2Q8PJvPpE25HhqGz/QJLANR2epnCQPZNC4yQtYDvVPtDLpDvIYh6wPZgCKfe
	x5vBW8W3s5Q3SLxiBk67RQizP01FuwISVcSLrL4AwYr3fgVDgy68qJJ1QjY3w5JE9czN0lgAZaw
	Qo=
X-Received: by 2002:a17:902:d487:b0:2ae:6457:3099 with SMTP id d9443c01a7336-2b0cdc9e5b5mr185225ad.26.1774557771457;
        Thu, 26 Mar 2026 13:42:51 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0cbfd17d9sm4004905ad.25.2026.03.26.13.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:42:51 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH 2/4] selftests/sched_ext: enq_immed: fix IMMED reenqueue livelock
Date: Fri, 27 Mar 2026 04:42:36 +0800
Message-ID: <20260326204238.3755737-3-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326204238.3755737-1-suzhidao@xiaomi.com>
References: <20260326204238.3755737-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the IMMED slow path fires, ops.enqueue() is called with SCX_ENQ_REENQ
and SCX_TASK_REENQ_IMMED set.  The original code fell through to the
normal enqueue path, which re-inserted the task into SCX_DSQ_LOCAL_ON|0
(CPU 0's local DSQ) with SCX_ENQ_IMMED still present.

This immediately re-triggered the slow path, which called ops.enqueue()
again, creating an infinite cycle.  After SCX_REENQ_LOCAL_MAX_REPEAT (256)
iterations the kernel aborts with BUG_ON.

Additionally, the dispatch handler consumed from SCX_DSQ_GLOBAL even
though no tasks were ever placed there, so it was a no-op.

Fix by redirecting reenqueued tasks to SCX_DSQ_GLOBAL so they escape
the CPU 0 local DSQ orbit, breaking the cycle.  Remove the now-pointless
scx_bpf_dsq_move_to_local(SCX_DSQ_GLOBAL) call from dispatch.

Fixes: c50dcf533149 ("selftests/sched_ext: Add tests for SCX_ENQ_IMMED and scx_bpf_dsq_reenq()")
Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 tools/testing/selftests/sched_ext/enq_immed.bpf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/enq_immed.bpf.c b/tools/testing/selftests/sched_ext/enq_immed.bpf.c
index 805dd0256218..a006f07334ef 100644
--- a/tools/testing/selftests/sched_ext/enq_immed.bpf.c
+++ b/tools/testing/selftests/sched_ext/enq_immed.bpf.c
@@ -35,6 +35,15 @@ void BPF_STRUCT_OPS(enq_immed_enqueue, struct task_struct *p, u64 enq_flags)
 
 		if (reason == SCX_TASK_REENQ_IMMED)
 			__sync_fetch_and_add(&nr_immed_reenq, 1);
+
+		/*
+		 * The slow path re-enqueues IMMED tasks that couldn't run
+		 * immediately.  Avoid re-pinning them to CPU 0's local DSQ,
+		 * which would trigger another slow-path cycle (livelock).
+		 * Send them to the global DSQ instead.
+		 */
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+		return;
 	}
 
 	if (p->tgid == (pid_t)test_tgid)
@@ -47,7 +56,6 @@ void BPF_STRUCT_OPS(enq_immed_enqueue, struct task_struct *p, u64 enq_flags)
 
 void BPF_STRUCT_OPS(enq_immed_dispatch, s32 cpu, struct task_struct *prev)
 {
-	scx_bpf_dsq_move_to_local(SCX_DSQ_GLOBAL, 0);
 }
 
 void BPF_STRUCT_OPS(enq_immed_exit, struct scx_exit_info *ei)
-- 
2.43.0

