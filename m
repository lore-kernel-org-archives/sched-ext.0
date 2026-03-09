Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13863ACF17
	for <sched-ext@lists.linux.dev>; Mon,  9 Mar 2026 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073837; cv=none; b=CKSwmJlmSOJrrQUyiH06P9gfWEP6Qm1sjgIkSDXjr5hm/BCFgFr8rJQRgDllm/ZFAuve5cWxU1w7PVcklFznw+x816P7kEoPn/HDxc4JGORh20b9QRR3hdWZPVp1sTcTVGjnJ0zoAVpeO9kEVoJgEC4AYP2zs5+ef/Z4Cn+BXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073837; c=relaxed/simple;
	bh=/BXqgCld1VyUC8INKIAvMzDOfJP89M7Nn1x++PU6tFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/eLB7fVg7pc6tyxCmCcIggfDRFWLN7Su7ks0moFaKX1qVgrX+LdWFwnyJQXFXY+3G/K8kGo1r495Xjn399Rf0HW9sumi/xQX+mrX+t3FkacL0usBoikvwH7ocgta5TcgXLz+Uu+Km2Pmykct9U2bO3XiqomTSvLMw2e9WkbpHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFp6Bdeg; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFp6Bdeg"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3598581ed7bso3453257a91.2
        for <sched-ext@lists.linux.dev>; Mon, 09 Mar 2026 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773073835; x=1773678635; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5vJQcn0GO08lSTSFZhY/Rldy8APAUg24SlNrmtjbPc=;
        b=BFp6BdegWhMV12M8tG6U2tc686C80BG3P3zjBOfu8UbIC57Hj32HcgQlWdDIg13sSg
         ODkemNrqyTH8qFvx9Clw/Ne+64ptJFN+lzrEdH//6I7TowHNSaL13IyKDQilceF2yZdM
         mXz1DZ20sTDt5NafMCpEmgaQS3y1B4woX665crGh4M/X7SapTUEXOwag/q3IfLeVNr9L
         aIYzoP5LtCkwpABhGEErHvH0Z9HAaa/p15WMbWHXTK3xdbiEp9EzdvnJ4dzUyzH4VZml
         LhIN6v0+xpHBRTdAwCLBt618xtxqXeoDB7eoNoOBKsSlE/EBDzFER7eo/EVwk92gVWjX
         OcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073835; x=1773678635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U5vJQcn0GO08lSTSFZhY/Rldy8APAUg24SlNrmtjbPc=;
        b=gefpGadIuAaI+1maAwWUuNHtSUyqSbhpa7rrjzO7VLstIe/Zi5pFmbq21RsDEunnkX
         iMv4NCICmrZVjFyGHEWjUQ0qwjScP4boBzC7041m4uFrPzAMHMB2hMdRBAVvasYzAbq3
         4adtqATQQ0gILqVTuy3+ujr60z27mZ5SnLNgCo5PT7Up0GkRzHePoBsQkShvnZqIakLO
         OZ1Z4YLGOG+YpYxq2Yjd0OaCajuWVLmNQ/mkTTqtBHN1aN83PIn2PyzlghHg8CwXtmA+
         TosaRDg6dtrVenh7/7n/mY4BdYkIT++T5hPvBVJ7tHg/i7ekv/VbfOrNL8bwnuTO7gRo
         0ZcA==
X-Gm-Message-State: AOJu0Yyri5RxRDKr9T2mlpWTxLP3fdBAtcPpodBUEO7dkqa767s55oGm
	dfpJ3YH4FQJQ2UZE7mNcx6ncG0/JtQhm+zddee4cEptPL3TZZKlCfhUvlKx4Gbji
X-Gm-Gg: ATEYQzwVQfQXkMdv2iMsjEVhz34UIPHlbM9JBGdy8v3OUQfcCOh3hK+cEuVevsxrDmW
	zR9QGq5+7Gm3/47VXq3TPpj2vEcB214sYTWbul26aYeoBaIhVdWUp/CM2LTvlP7GRb8Ibs8oYHK
	qCxMKlEwlV/RDKFj2g+3+lMJQyNF9e3Yp9VGI9aYPkzOIB6FcAJRtKCa/2mc1bj0Pt7cMm8Ktgd
	r5Vn53toSX/RGdP3XJNzosR4nksKVnaNjORajMMgJiKWE6WauBjjPkJwJAu7yPULf+p58rI3Aii
	Z6JWAL4k6coQIA30+auHvkNnLKWCpBUoMmtdQnuAfMDFGdUITB/An4xOVI42O5Tku371AlEJUyK
	7ETzdHAs4XA5HfsGfUasD/qXNTYKSpan7PdQ2L4P41HqvYEq7Je2sdXCNXVxv6wRnGPGZBJR64A
	ll3GB68VTAnV4yD7vwT3cNk/gtBhPmonGr6HlJqOfMZKcO6+IOAR3djWG5scG7c5w=
X-Received: by 2002:a17:90b:3b50:b0:359:8db3:b08e with SMTP id 98e67ed59e1d1-359be31d6c3mr9277906a91.20.1773073834470;
        Mon, 09 Mar 2026 09:30:34 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3cea:adff:13a5:9a2c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bc9d4392sm5687519a91.4.2026.03.09.09.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:30:34 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 1/1] sched_ext: Fix deadlock in scx_claim_exit() by deferring descendant propagation
Date: Tue, 10 Mar 2026 00:30:25 +0800
Message-ID: <20260309163025.2240221-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260309163025.2240221-1-yphbchou0911@gmail.com>
References: <20260309163025.2240221-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_claim_exit() acquired scx_sched_lock to propagate exits to
descendant schedulers, but it can be reached from the timer tick path
with the rq lock already held:

	scx_tick() -> scx_exit() -> scx_vexit() -> scx_claim_exit()

scx_bypass() establishes scx_sched_lock -> rq lock ordering, creating a
circular dependency:

        CPU0                    CPU1
        ----                    ----
   lock(&rq->__lock);
                                lock(scx_sched_lock);
                                lock(&rq->__lock);
   lock(scx_sched_lock);

Fix this by moving descendant propagation to scx_disable_workfn(), which
runs in kthread context without any rq lock held. Forward progress is
guaranteed by sch->aborting being set in scx_claim_exit() before
returning. No recursion is introduced since SCX_EXIT_PARENT exits skip
propagation.

Additionally, switch from raw_spinlock_irqsave to raw_spinlock_irq in
the workfn as IRQ flags need not be saved in kthread context.

Finally, add a blank line to avoid checkpatch failures.

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d6d807337013..e767b45a8ab5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5616,23 +5616,6 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 	 */
 	WRITE_ONCE(sch->aborting, true);
 
-	/*
-	 * Propagate exits to descendants immediately. Each has a dedicated
-	 * helper kthread and can run in parallel. While most of disabling is
-	 * serialized, running them in separate threads allows parallelizing
-	 * ops.exit(), which can take arbitrarily long prolonging bypass mode.
-	 *
-	 * This doesn't cause recursions as propagation only takes place for
-	 * non-propagation exits.
-	 */
-	if (kind != SCX_EXIT_PARENT) {
-		scoped_guard (raw_spinlock_irqsave, &scx_sched_lock) {
-			struct scx_sched *pos;
-			scx_for_each_descendant_pre(pos, sch)
-				scx_disable(pos, SCX_EXIT_PARENT);
-		}
-	}
-
 	return true;
 }
 
@@ -5650,6 +5633,32 @@ static void scx_disable_workfn(struct kthread_work *work)
 		if (atomic_try_cmpxchg(&sch->exit_kind, &kind, SCX_EXIT_DONE))
 			break;
 	}
+
+	/*
+	 * Propagate exits to descendants. Each has a dedicated helper kthread
+	 * and can run in parallel. While most of disabling is serialized,
+	 * running them in separate threads allows parallelizing ops.exit(),
+	 * which can take arbitrarily long prolonging bypass mode.
+	 *
+	 * This is done here rather than in scx_claim_exit() to avoid taking
+	 * scx_sched_lock while an rq lock may be held: scx_claim_exit() can
+	 * be reached from the timer tick path with the rq lock already held,
+	 * but scx_bypass() establishes scx_sched_lock -> rq lock ordering,
+	 * which would create a circular dependency. This workfn runs in
+	 * kthread context without any rq lock held, so it is safe here.
+	 *
+	 * This doesn't cause recursion as scx_disable(pos, SCX_EXIT_PARENT)
+	 * calls scx_claim_exit(pos, SCX_EXIT_PARENT), which skips this block.
+	 */
+	if (kind != SCX_EXIT_PARENT) {
+		scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
+			struct scx_sched *pos;
+
+			scx_for_each_descendant_pre(pos, sch)
+				scx_disable(pos, SCX_EXIT_PARENT);
+		}
+	}
+
 	ei->kind = kind;
 	ei->reason = scx_exit_reason(ei->kind);
 
-- 
2.48.1

