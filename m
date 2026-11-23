Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446042;
	b=Ms00j+a+5rnfddCuTYsuqHmlinMOoNIy35hAVduLIsN4OOuzZQbNc236yRMS5NYeDMj+
	 RneTomh7LYERJYmgxVlvvQxqFmW6VVG++UVX9ri7pnlgZVEgXIEWy8P2u9cFBdFp/LykJ
	 UnOY3A8RApLppOOXHTXbn5f9Ht4adDVJNM1Sw9Q++GL7SFGQf6HvhdcH8pnIK7y2Ml5xK
	 SLMSOVlUCmWfTFpJpBK70gTDd7Q1aVld0g+TSLlf+2+126UldTWu6DRWph6mg4a2bZOjI
	 HNLsi8BBreDbT2WFBUjN+PpW9npV1xQcYPGKoWQGhSv4KbHdqghGeTTfOqH5Pvkfg0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=wYsSj+F+ggyOBUh2k7k7pI4pn0YJNbWaH8Y6XcKAqGY=;
	b=botZYuifHhUd/6cH8k38jfQWrZ4nUYy4NBarGyfzMMLX10dRk10FJtRgkJJaZxW4d55v
	 v+48kzilqqjSKbvPrk0OC9km++sFPsbDsz9QHlw0bgb/13ZOlxYfzOktAoe1QYMBa+NFd
	 1tHyZtb8diIX7nsipN5VDrfMvOP8jguDSLaXGTUlghZuQeGDfkf12obvPrPeyZXtVldpk
	 uT9KrQU99b44j36oT0O7KIu7eQbDFc42Xi1bqga0rsTG2eayd9+N0fe0o9XPSleMREwkt
	 +VqLBE97mFzGpysZ0JoF26XjD8nlD1Y4Fz+ivbd//EFK4HhYlcczTvkKrH1SKyvDJGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=deVbQPHH;
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4552F606A336
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 15:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4552F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=deVbQPHH
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6babdfe377cso815626a12.0
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 07:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795446041; x=1796050841; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wYsSj+F+ggyOBUh2k7k7pI4pn0YJNbWaH8Y6XcKAqGY=;
        b=deVbQPHHlZ1hCACf7k2N5zlQ0SRo/lX0FmLJT1G0He1PMV/yYsY9MagCa4mZ6LXtTY
         uBAUXrdbRengOuGqhnKzIhc/LHqEnlOVrloPn7zkrvTmnshUnlcUJUSo9aSykjg1H/QU
         HxALYeMOLfz4MZfA288hVpxpslI6uxuqJa/QgGHyUbrEKc8IRo4Zj5H+OW2dnmy+yF/u
         51YIc7Nt+BIkw1n/IcVI10XzMXCe5TaO5GiTZu7UoB9cvbpWjiDHNRutbN8FMSCzclrA
         UYniW/pyrfg6Gy3hjg/Ngcy2HatdW/K9uEVVwBiLWYibbzGSXMFVxrrM18Uevn6xSRpA
         qRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446041; x=1796050841;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wYsSj+F+ggyOBUh2k7k7pI4pn0YJNbWaH8Y6XcKAqGY=;
        b=jHDhrIYS1V3UXu2stfHO2/+0UYcpJB6EWskw2tcVEWQWrCkNAtfN+p+eeMHTQzvtvj
         v+HzxqHOpz2BxhsyHjJNhHEhN+jKQLATetWevyv7mZnRIEyzZcFcck62PBkLgbd6IlQR
         6nlwkwEOZuwVJJ7K3zUEea4HVTM7ak6WZ9DtBeXR+6USGvgsdYmAGyntavkeI91WsrMW
         D4Tx/2nHoaRzYnrRjiuSLw5n36pRXBvRaUGIOnh1PUDw3kvFXtP+xzs+wh+nskCEGb7P
         hHxful2D3Wk4GSyspU2c5lNo3/HIQ2s8yyLdC0c08eu0Lm7UaZZAgU+fFf7E1w/foQKL
         qzUg==
X-Forwarded-Encrypted: i=1; AL+hErHxLTBa80yF/G0U97PoJckwHrD2WdaFInciOIzf6jVpAHKISbGuV+yHe8HXlltBTrR70DwIMU1GBzY=@lists.linux.dev
X-Gm-Message-State: APuU4Z8h9pa4J2v5hYSbpHi38hihqBUGFqePidIj5/rjCWNqM7sgRcd1
	NSvHa7DicotMOgPWkanYYzoolql9APQgop2h6bGsTbptyM0xU8Nuxy7ErWuK1JF3OS/XNVwCrfM
	ckd0D6d2yP2nSdw==
X-Received: from edgd8-n1.prod.google.com ([2002:a05:6402:a508:10b0:6b8:96de:7abc])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:274d:b0:6ba:92c3:ff04 with SMTP id 4fb4d7f45d1cf-6ba92c40932mr3334073a12.26.1795446040104;
 Mon, 23 Nov 2026 07:00:40 -0800 (PST)
Date: Mon, 23 Nov 2026 15:00:37 +0000
In-Reply-To: <20261123145927.577162-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123145927.577162-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123145927.577162-2-jpiecuch@google.com>
Subject: [PATCH 1/2] sched_ext: Fix suspicious RCU usage in KF_RCU_PROTECTED kfuncs
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Ryan Newton <newton@meta.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

scx_bpf_dsq_peek() and scx_bpf_tid_to_task() call rcu_dereference()
without taking rcu_read_lock() and rely on KF_RCU_PROTECTED instead.
However, the verifier treats every non-sleepable program as being in an
RCU read-side section, including bpf_timer callbacks. bpf_timer_cb()
runs those from hrtimer softirq without rcu_read_lock(), so calling
either kfunc from a bpf_timer callback triggers:

  WARNING: suspicious RCU usage
  kernel/sched/ext/ext.c:11170 suspicious rcu_dereference_check() usage!
  ...
   scx_bpf_dsq_peek+0x7d/0xd0
   bpf_timer_cb+0xf9/0x130

The same happens from a sleepable program inside bpf_preempt_disable().
Both contexts are RCU readers, so this is a lockdep false positive, not
a use-after-free.

Take guard(rcu)() as scx_bpf_cpu_curr() and scx_bpf_cid_curr() already
do.

Fixes: 44f5c8ec5b9a ("sched_ext: Add lockless peek operation for DSQs")
Fixes: 41e3312861ea ("sched_ext: add p->scx.tid and SCX_OPS_TID_TO_TASK lookup")
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e8c30a21e03e..2b9324c31de9 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -11152,6 +11152,8 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id,
 	struct scx_sched *sch;
 	struct scx_dispatch_q *dsq;
 
+	guard(rcu)();
+
 	sch = scx_prog_sched(aux);
 	if (unlikely(!sch))
 		return NULL;
@@ -11957,6 +11959,8 @@ __bpf_kfunc struct task_struct *scx_bpf_tid_to_task(u64 tid)
 {
 	struct sched_ext_entity *scx;
 
+	guard(rcu)();
+
 	if (!scx_tid_to_task_enabled()) {
 		struct scx_sched *sch = rcu_dereference(scx_root);
 
-- 
2.56.1.750.gf70dc682cf-goog

