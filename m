Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732907;
	b=m81HIDy2yL29gysuG7tpcwTYlBHy9Ma166BRD9UpA8/TmGCoT943W5b7K/onSnGbXFYw
	 fG97Y3ihwmfK5VPPUK1ZXkhA8jzSTMfwz9XU779EwL9oVr/GQd4R+HUMA+6Qpre5BrPwx
	 MFiCJqAeTmRHdFi5j2N/vgCheOUZGqJXIhwZL7nLrwwauAwYB97MIlCG9/qus/tiYlwuL
	 xqrfJ+r4NWrZ/lbkYNAvFiZEFOwfHbTbVl8zdRGwTGJrN924OZR5ZBpos/tiP9NIatkIN
	 GmrnRk1jEGDDanjjWei2nRsX1/OvXtuBkRtjnpTtu9/nriQ4Qn46rAfgMQJ+2iRYt/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732907;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=p83s1UZrudYzqyiix38FzmFWnzl/cng77PjrgFldiOE=;
	b=xMPSodvRE3lfnxI2XxXow2ePsbdawUWnA0sqAc7L8B511Gn9S03rXQEPNBnH0gl4E5FX
	 +66Gv3GUTIWo0szhfbuTL3/6UgXXp0g+6jlSbze6K51kzMu39UXK/NPozJB/aHuxjW6B2
	 8BaVapolYuDR0rL369OaWV2++0YEbI0bHUdNUBnHrKaAGMy32nTcu+l6+kLCg9DB3gYbK
	 g+CYOB+PddCRXGXMQa2dOlj3Q1s+IogkBnCbs/dNOCDdw00PZ7ikkQbtyDbLop/8777Gs
	 +xqb43L4/iHhVshcqyw/WJnaWu3ev7sLLReORf4IQAsf1Fa/yhCWBrbM4YDzU856+ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="p0EMilE/";
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283EC606A32D
	for <sched-ext@lists.linux.dev>; Tue,  3 Nov 2026 19:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 283EC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p0EMilE/
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48df730c035so3171606f8f.0
        for <sched-ext@lists.linux.dev>; Tue, 03 Nov 2026 11:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793732905; x=1794337705; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p83s1UZrudYzqyiix38FzmFWnzl/cng77PjrgFldiOE=;
        b=p0EMilE//uYHYmmEG6gdfF1dYdwDCfnEklWVqLJCnq3nT9ZSmjjfS7n6D7jvz/+MPz
         VtCGgf9fTrPqIPIwHz5UKG+EcghbnRCmItXVB9yr09+zNxyzrVnaievBCDw8qnP3N4up
         ntPUQtX4UdamClaPsk3NgBWzzgLZWu+O2iOlGL55p9SNlyC4hj7bcBrFohDQM+KppvBY
         7o3qSorAxYLe2enh0rEmx+G6tDLzqPhuq4ykSR8TfaKxxiCvXmmi8xKAwfSnXlqrMmlg
         qS1/Nht7P+pzm+bxaBxZsJ8MHo8SWzxRi+za1o/hXk75KBRNGb/VBa19S1Us/cQ46c2D
         BCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732905; x=1794337705;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p83s1UZrudYzqyiix38FzmFWnzl/cng77PjrgFldiOE=;
        b=B9+luhXUlXKI0YJomZo4P4p+8W8PL+PiQDl7R3NuzwjAqVyeaMzKILRj8hJK6c5uXE
         mmzPuCBjT1ficF+IZs51KDBc7Jbl1sGjE/SeFoap+MZERw000g1jI+FrT40/uHaR2KFU
         sjffgs8L9ofJoQQ034IdozVRIffFYBpHgginnHvhRfGnnOK4DyQsIxswEIFX2gg55cTm
         bB/AuW1nCSxth50XnzW//0rKNZfS3ZU3ZHGXlQUb3JbCTOz27JOvfv3IL+GpdNgrq1MX
         VDOazGkTrDNBiqG+mUHym7F/D7mzT60fz/BvdJVthZ0cVelKBfmWBOy4pQH6/NJvStpg
         m42w==
X-Forwarded-Encrypted: i=1; AKwUvBxRge9nsgbqrWQAV9XHawFAwvaDhv7Npjfz0pBd+8kZ3moOgVGq6Cq0NW7wXCnQ0k50jl6AF0SHDF4=@lists.linux.dev
X-Gm-Message-State: APuU4Z/g0GjaAFAd7mp51UFRfM8BoLHzaePegywSNCU1uZQLyE22ECGc
	IZXdtSw9JYA/piZZM894MBMYomvvbmV1SuzdD7F0FmEaU2msqpv/BKin5RqNoQS51cpxabfg+P9
	X0/yR6XvzUQ7ZaA==
X-Received: from wrsq11.prod.google.com ([2002:adf:fecb:0:b0:48d:ee1f:7396])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:f24b:0:b0:48d:dc6f:219a with SMTP id ffacd0b85a97d-48e6e2ff6f2mr25928011f8f.27.1793732905092;
 Tue, 03 Nov 2026 11:08:25 -0800 (PST)
Date: Tue,  3 Nov 2026 19:07:49 +0000
In-Reply-To: <20261103190805.3487350-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261103190805.3487350-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261103190805.3487350-3-jpiecuch@google.com>
Subject: [PATCH 6.18.y 2/2] sched_ext: Fix scx_flush_disable_work() UAF race
From: Kuba Piecuch <jpiecuch@google.com>
To: stable@vger.kernel.org
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Andrea Righi <arighi@nvidia.com>, Richard Cheng <icheng@nvidia.com>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Cheng-Yang Chou <yphbchou0911@gmail.com>

[ Upstream commit d99f7a32f09dccbe396187370ec1a74a31b73d7e ]

scx_flush_disable_work() calls irq_work_sync() followed by
kthread_flush_work() to ensure that the disable kthread work has
fully completed before bpf_scx_unreg() frees the SCX scheduler.

However, a concurrent scx_vexit() (e.g., triggered by a watchdog stall)
creates a race window between scx_claim_exit() and irq_work_queue():

  CPU A (scx_vexit (watchdog))        CPU B (bpf_scx_unreg)
  ----                                ----
  scx_claim_exit()
    atomic_try_cmpxchg(NONE->kind)
  stack_trace_save()
  vscnprintf()
                                      scx_disable()
                                        scx_claim_exit() -> FAIL
                                      scx_flush_disable_work()
                                        irq_work_sync()      // no-op: not queued yet
                                        kthread_flush_work() // no-op: not queued yet
                                      kobject_put(&sch->kobj) -> free %sch
  irq_work_queue() -> UAF on %sch
  scx_disable_irq_workfn()
    kthread_queue_work() -> UAF

The root cause is that CPU B's scx_flush_disable_work() returns after
syncing an irq_work that has not yet been queued, while CPU A is still
executing the code between scx_claim_exit() and irq_work_queue().

Loop until exit_kind reaches SCX_EXIT_DONE or SCX_EXIT_NONE, draining
disable_irq_work and disable_work in each pass. This ensures that any
work queued after the previous check is caught, while also correctly
handling cases where no disable was triggered (e.g., the
scx_sub_enable_workfn() abort path).

Fixes: 510a27055446 ("sched_ext: sync disable_irq_work in bpf_scx_unreg()")
Reported-by: https://sashiko.dev/#/patchset/20260424100221.32407-1-icheng%40nvidia.com
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[ Sync error_irq_work instead of disable_irq_work. ]
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d2460a88fba3..78f15ddc0aa5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4217,8 +4217,13 @@ static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
  */
 static void scx_flush_disable_work(struct scx_sched *sch)
 {
-	irq_work_sync(&sch->error_irq_work);
-	kthread_flush_work(&sch->disable_work);
+	int kind;
+
+	do {
+		irq_work_sync(&sch->error_irq_work);
+		kthread_flush_work(&sch->disable_work);
+		kind = atomic_read(&sch->exit_kind);
+	} while (kind != SCX_EXIT_NONE && kind != SCX_EXIT_DONE);
 }
 
 static void dump_newline(struct seq_buf *s)
-- 
2.56.0.385.gac671c819a-goog

