Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790892;
	b=06bP6MX1/ekRzTTjIH32px2PAnJxVSAjwN6unwF6AnH0asZJtp2bZ0oZOFw/PiNPIETN
	 nBZlMrRWaqM2Rc4x05cSlccobPmnnpIvbzvYm0aPkLY91tfY1vq6LtKOKRUM6q7JrblTn
	 msDXKC68moDKX9ZXGTNIrLFHqav7GK0IuNFVtSd4BEitWqHrhPvemC3fnoTzyIMFj5O2t
	 tY5Lv/f90twejycOXBztYYis1ejI4tedu63KfPzYzsYQqeFvlItnvCXsGJVkMfx0v0KXl
	 4nMjEc/oSlcLA2mlB5/sk7xJzhoxiNJqSScz/xBkwi0d405pfEELddmYhbvcM828m+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=xDxDhqJVjBKwoBSqZ4/8zTufBKgQ9/aX3QhT60mdvuE=;
	b=XZfN+FafsKrvN54co/+3xccjRXaIO1wF4KcYcl7HEb1KyFxutcLww5R+WIxKYasQAty2
	 5uXNVDOlhoCiZlbLLEPYelJETFuKTy0sJSMA6RGo+luG+WOXbOJ9tD4uOdbuLucNvPC8o
	 rh+1vUXxhZejTbGbUhmsrRc5AmHV/AXgQFLU4UnQ8x34gIsltA4BuLnJ7Ow6klby86lCc
	 An878pJKqtBeAwS94eYn/zDGIexEGCYZ04SZOYzFdvU6QyZDtZCmY6oNHkvBlNOcYMgI6
	 mYsn5SSOh7EWwm2uTjvH+cg5vT/4mkIipU2wAU/JaWIKwqgzykgdCSsQkhCqUW8zxEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CJ1obGAk;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF61606A31B
	for <sched-ext@lists.linux.dev>; Wed,  4 Nov 2026 11:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DF61606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CJ1obGAk
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso5124625e9.0
        for <sched-ext@lists.linux.dev>; Wed, 04 Nov 2026 03:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793790890; x=1794395690; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xDxDhqJVjBKwoBSqZ4/8zTufBKgQ9/aX3QhT60mdvuE=;
        b=CJ1obGAkXj8uuyS6u6E8YnqLKh7Tz0ILZnlM+hz1yKalkqWGE3+P4qicepToMk/U3p
         ATtIUXleXQWaqbzw34P7klY9vVy5G4BmSjxIEKdxUPHVpWjIIjTM1mXpbaJT29S0fcOG
         Dw2h/ln2EkABkqr8VqU1ljbOY4c8v/geLcLi/cM4LddPsUfk42TLppdXdAOV2gx3/stz
         fYZ6fs0GPNIuq9ULOauWr4+f1EoWlumROm/DTOoewMBet2Q1QagipkImnNt0DE30/5HQ
         Lp3FQxFGynMAUeznYu++2WWU8YcUb0o/izs1TKwxDSAlroYJWjVE4tcgW7wnXMO2OUXN
         AAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793790890; x=1794395690;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDxDhqJVjBKwoBSqZ4/8zTufBKgQ9/aX3QhT60mdvuE=;
        b=IcxPKYy7Ar+8nVzuaa+TkQEE0vADeFNjEb5jYF3F4/286ehFCkEiOr1QGKHHV799kv
         kldOHJYI6M2C9JApZCv4KCRT8ohIZyFPnf4ttZnyVNioyn4tlP6dcq2bTWs1tHsqL7J8
         LeDhHcQ0zJRAeYpZIyILkO8SVy1/2WJr9reKFoEESw2M3+c1vLgSxqPAx97cP7l4Qf3Z
         xXs12BiGtgG0dSpn/OmQ+AhJewDeqmPDp+/Ja7UeWnm3Ps5Lpdoz7Ze+MIk7L8t2g/ZM
         RmDOS3J3Wz8ril3StjsfYFXLlzIf6CWmHGTpGIX/CnU+wiOgAa7om4jIoXmQ8rTKcCgi
         Hfvg==
X-Forwarded-Encrypted: i=1; AKwUvBxDzxx2mQjZ3jCONpBu6+L3j8f38oY8/Jf2bz7Ykyo4ZyEznMCUdJQ+B6+YJzj2B6wFxQcPEtcLdeI=@lists.linux.dev
X-Gm-Message-State: APuU4Z/aZ9POLTOwjpquSYDhfUEgzRkbPR7VcP+aCDgCTxSNqVK9RMTz
	gZEo4vSh5ODS6zhWkCm913fxpRqvUUWqCiAOinXYet/MJ8YDr26S09xq/lOUM6+YKTVgNfufPiU
	1xYHqQuu8/pTUEw==
X-Received: from wmbjp21.prod.google.com ([2002:a05:600c:5595:b0:4a1:dfb3:2e66])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:a:b0:4ac:aae6:6400 with SMTP id 5b1f17b1804b1-4acaae665a6mr272975095e9.13.1793790890378;
 Wed, 04 Nov 2026 03:14:50 -0800 (PST)
Date: Wed,  4 Nov 2026 11:14:39 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261104111449.3984318-1-jpiecuch@google.com>
Subject: [PATCH sched_ext/for-7.4-fixes] sched_ext: Read exit_kind before
 flushing in scx_flush_disable_work()
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Cheng-Yang Chou <yphbchou0911@gmail.com>, 
	Richard Cheng <icheng@nvidia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

scx_disable_workfn() sets exit_kind to SCX_EXIT_DONE before it tears the
scheduler down. scx_flush_disable_work() reads exit_kind after syncing
disable_irq_work and flushing disable_work, so it can observe DONE from
a disable_work that was queued after its flush and return while the
teardown is still running:

  CPU A                          CPU B
  -----                          -----
  scx_vexit()
    scx_claim_exit() -> true
                                 bpf_struct_ops_map_link_detach()
                                   bpf_scx_unreg()
                                     scx_disable()
                                       scx_claim_exit() -> false
                                     scx_flush_disable_work()
                                       irq_work_sync()      // not queued
                                       kthread_flush_work() // not queued
    irq_work_queue()
  scx_disable_irq_workfn()
    kthread_queue_work()
  scx_disable_workfn()
    exit_kind = SCX_EXIT_DONE
    scx_root_disable()
                                       atomic_read() -> SCX_EXIT_DONE
                                   bpf_map_put()

Once bpf_scx_unreg() returns, its caller drops the struct_ops map
reference, and the struct_ops trampolines can be freed while
scx_root_disable() is still running and can still call into the BPF
scheduler, e.g. ops.exit().

Read exit_kind before syncing and flushing, with acquire ordering paired
with the atomic_try_cmpxchg() in scx_disable_workfn(). DONE is only set
from disable_work, so once it is observed, the following
kthread_flush_work() sees the queued work and waits for the teardown to
finish.

This patch was created with the help of an AI coding assistant.

Fixes: d99f7a32f09d ("sched_ext: Fix scx_flush_disable_work() UAF race")
Cc: stable@vger.kernel.org # v7.1+
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-195908@kernel.org/
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 6c593d3dee3c..949143bf4752 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7810,10 +7810,17 @@ void scx_flush_disable_work(struct scx_sched *sch)
 {
 	int kind;
 
+	/*
+	 * scx_disable_workfn() sets SCX_EXIT_DONE before tearing down. Read
+	 * exit_kind with acquire ordering (paired with atomic_try_cmpxchg() in
+	 * scx_disable_workfn()) before syncing and flushing so that, once DONE
+	 * is seen, the following flush observes the queued work and waits for
+	 * the teardown to finish.
+	 */
 	do {
+		kind = atomic_read_acquire(&sch->exit_kind);
 		irq_work_sync(&sch->disable_irq_work);
 		kthread_flush_work(&sch->disable_work);
-		kind = atomic_read(&sch->exit_kind);
 	} while (kind != SCX_EXIT_NONE && kind != SCX_EXIT_DONE);
 }
 
-- 
2.56.0.398.g882cbad275-goog

