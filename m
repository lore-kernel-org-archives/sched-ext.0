Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AECA230264
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 03:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776657417; cv=none; b=hAN10Ec9Z5HQn+RtRVxnrMHqBK5MEVD+FvWQSNWGrvLDEY3CRHc/T8FdYxs5HP8M7mc3JwMV4nb1YETEeINJvIOBO8ntK+4pPTm4XRzd/zdmhzlKoKQQyqmMdWv24FGg1SKB74Hkjz45rUNc+XMIb4hyTMLn3AFN4n29/gIncHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776657417; c=relaxed/simple;
	bh=CPL9C3DOrCuBOfPZ1meRAqIwv+6lKuQTMnf5xulDzd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BDwRik9ZbqOIsuifDIAGyOiW/9frN7Exz+bdpulkiUUTFfTGL7B446U8+ijeOYQwYH0eAn+OAw34AJ7Y0Nxv/Ie9vw8AehP045nD1yueFWTxMjoKu0ax1G2yxKD2Z3a6Ghc9E/7LApIFfLF+ktl99hnu+28PCvYUaMfpygUDl/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym0VMVpo; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym0VMVpo"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82748257f5fso1891593b3a.1
        for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 20:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776657414; x=1777262214; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WTfxrUjUGYbPZHY/a+J5CZ0Xndiokl52ZuC/OYTjXsQ=;
        b=Ym0VMVpoPALcevd8+f7fFuubjHrxnUpfbAKwYtqmCg6axUNZ+SENqjIO7I8ezl7LDn
         COgvzPpEOQW72kkzkxO4pH/SKhOQXMNw1z/4+4QdVfynBx3/HiqS5HLp1Xfc2SGjyNE3
         KYEOwiLJIrZqmIrS4OeHn/06+F6Gzc2N/AkrBPFJaXb2Eu7F5QTEyp+GmAoXEvTxQdwc
         +iFXsUqOLodtJKEjg4ASnpT4+6cyY29CZo3IJmpaEoSpGUlsaVuTnbAZyUUuga+bUEjl
         1V75LsvjNMx68OtMCl4/HmyudvpPLwD40lGvcVMhXIbbRNjxQDxbW3xCcHALARH1RwI9
         s+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776657414; x=1777262214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTfxrUjUGYbPZHY/a+J5CZ0Xndiokl52ZuC/OYTjXsQ=;
        b=ducu0hUIgtNGBviY39d5Z7nPTCWUTxgySnJmx8WQ5C7wGe8cONk2j+hJIv5u1Rymtd
         iGiLeEmU+P/YACgePQ9BCgiaBFiOyQEDdq8PEGuVMQVtrzzG9Qp8+AMa/Ic/y3GNbAgW
         4tY1MNDs33I9f0Za709R94kNpBsjTgRk6bKmC9tNf3GRehE3FleKUhGermqyfZ1JMUx9
         n4MogGbaH/Sq2B2zOoQKzo4ec+wpJERStXYToYCeDJQiNNJZ6ORgNZkvN6KjS2eJgwNK
         gEM7SdK64g4aG83r44Z/BOvKAOFOwYVAFPhWRi62GB0qHw2Y/YEjShcKNNUaaqVAJWIJ
         YQtg==
X-Forwarded-Encrypted: i=1; AFNElJ9qrxn4OLpuHcy++TMQnIM4lHB1yyZmcz4gDtsqu5KRBGAZkIEVu3iCig/GsV/XFuvCbD9d0+6/Wvw=@lists.linux.dev
X-Gm-Message-State: AOJu0YzSsK72PPL+dWlMk35LiruwO7GsKQSLKYh5HG0l5ESI2WuKaiYk
	J0JXcV7EluL5KOdvTrsN/NBZVRMEiXBID05QRz5WJ3weqJ6l/35jUKHW
X-Gm-Gg: AeBDiesQZ3uLmr602REyb6l+JkVKCuRYuE86voFcyOm7915lZ7tdiFz798ZeaNCqcQM
	c0FV2QmTagwiDeMLnbxlNavZAyIsmIPK3TWpsJUmRvbVJy0huvmRg+X8KpLXHJUEkaFQ/FuckAI
	/0iwizDS0WGaCvrw8R0nQivGqriDoO6VacFgRvrj0UmQdUIHdYrzU/pwsFl/yyGoNAeCRtORWDo
	TwrR0pfEqZeKbFtaguWYuR1qVS4tNGnZFyT1sDt6ao9PYPfRkWzuk94zh9vpJee6HJZZ5ABl1gh
	ku/GbnaUaqidCQrEtz5CiXDrs8un3AVM/2INTHuQmGz/UOrpVkUjfq8f1J7PA67uwKiof7qimNa
	MF/aq9iKSfAgOeLj/hQV38l+D0V6M7FMVApjVtO9EHYGSHVmRYgcgm9yGM1yoYPBdps1Qw/51XV
	WZTHdOUrxqwEXItbyfIsb42QD17Kpeb3HafEIsBMYNRBu+XvjodrdDHCruBKRuTy8++ymF0z4Zy
	ARqEwJ03oSYBA==
X-Received: by 2002:a05:6a20:3c89:b0:3a2:cbd1:11f with SMTP id adf61e73a8af0-3a2cbd1126dmr1600834637.5.1776657413704;
        Sun, 19 Apr 2026 20:56:53 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797704c332sm6534019a12.30.2026.04.19.20.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 20:56:53 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH v2] sched_ext: Honor SCX_OPS_ALWAYS_ENQ_IMMED on framework-internal goto-local paths
Date: Mon, 20 Apr 2026 11:56:46 +0800
Message-ID: <20260420035646.1715762-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

SCX_OPS_ALWAYS_ENQ_IMMED promises that SCX_ENQ_IMMED is set on all local
DSQ enqueues. scx_vet_enq_flags() enforces this for BPF kfunc callers
(scx_bpf_dsq_insert, scx_bpf_dsq_move_*), but the framework-internal
goto-local paths in do_enqueue_task() — PF_EXITING, migration-disabled,
and !scx_rq_online fallbacks — bypass scx_vet_enq_flags() entirely.

When a scheduler sets SCX_OPS_ALWAYS_ENQ_IMMED, tasks hitting these
goto-local paths arrive at dispatch_enqueue() without SCX_ENQ_IMMED in
enq_flags, violating the flag's documented semantics.

This can be observed with trace_printk instrumentation at the enqueue:
label while running a multi-threaded fork-exit workload under a scheduler
with SCX_OPS_ALWAYS_ENQ_IMMED:

  Before (scx_simple + ALWAYS_ENQ_IMMED, 2 CPUs, mmap-contention exit):
    95 PF_EXITING local enqueues, 95/95 IMMED=0 ALW=1   <-- bug

  After:
    1030 PF_EXITING local enqueues, 1030/1030 IMMED=1 ALW=1  <-- fixed

Fix by checking SCX_OPS_ALWAYS_ENQ_IMMED at the enqueue: label and
setting SCX_ENQ_IMMED when dispatching to a local DSQ. This mirrors
what scx_vet_enq_flags() does for BPF callers.

Fixes: 3229ac4a5ef5 ("sched_ext: Add SCX_OPS_ALWAYS_ENQ_IMMED ops flag")
Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
v2: Resend to correct a submission error in v1 where unrelated files
    were accidentally included in the patch. The code change is
    identical; only kernel/sched/ext.c is modified. Apologies for
    the noise.
---
 kernel/sched/ext.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9628c64e5592..0758f5e5a8f0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1859,7 +1859,9 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 * Clear persistent TASK_IMMED for fresh enqueues, see dsq_inc_nr().
 	 * Note that exiting and migration-disabled tasks that skip
 	 * ops.enqueue() below will lose IMMED protection unless
-	 * %SCX_OPS_ENQ_EXITING / %SCX_OPS_ENQ_MIGRATION_DISABLED are set.
+	 * %SCX_OPS_ENQ_EXITING / %SCX_OPS_ENQ_MIGRATION_DISABLED are set,
+	 * or %SCX_OPS_ALWAYS_ENQ_IMMED is enabled (which re-applies IMMED
+	 * at the enqueue: label below).
 	 */
 	p->scx.flags &= ~SCX_TASK_IMMED;
 
@@ -1949,6 +1951,17 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	touch_core_sched(rq, p);
 	refill_task_slice_dfl(sch, p);
+
+	/*
+	 * Honor %SCX_OPS_ALWAYS_ENQ_IMMED for framework-internal local DSQ
+	 * enqueues (PF_EXITING, migration-disabled, !online fallbacks).
+	 * scx_vet_enq_flags() already handles this for BPF kfunc callers,
+	 * but the goto-local paths above bypass it.
+	 */
+	if ((sch->ops.flags & SCX_OPS_ALWAYS_ENQ_IMMED) &&
+	    dsq == &rq->scx.local_dsq)
+		enq_flags |= SCX_ENQ_IMMED;
+
 	dispatch_enqueue(sch, rq, dsq, p, enq_flags);
 }
 
-- 
2.43.0

