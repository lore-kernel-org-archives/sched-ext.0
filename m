Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614379;
	b=Fd438RZsvZak2+NI81UcPb7NeoHEJP7QK3ZOgNEa4BgDBpIaZWX3R+usL12tY81BrMFz
	 oDc7jWHEb2Utl9yDjG2m3Z93OpRisrJM/j3BP2T3uuC49iLMgxi1gsL+k0AFqpGQVCDjC
	 kDrm4Bbk1idQ893poeVUimHm24trcOhnxgrDzlGUQuLEoGZLFMCD2z9mUzKDnSt7A8E5j
	 ZeBYi9PI4paiX0MLEwBgoA7WJTqsfJ8HnZSWVGH3VrbOgGWRlp20rcI76Kc1dNN1IL6m1
	 8jHKxiXAA1kV/ln/JMBaJrrp6YbMyjB9Caa7QVMc5Pj/PGK/x1wfKPblYA1Li4T6pbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hkC7knUlQ5bvCCnLhIKdyMONWGi8riIRNrWMCj0qGvQ=;
	b=t4YbIAfodMj96PuHVyZCLO+5IyW0GXJtGdn/3uC81ExuxpQEd+55HQZ70MuxTxGmGwu7
	 n3SNQuS7JfMhYJfZdOQ7jqbKvz76bN1mj4Dol9t0HAd6j7iYPEERC2EAQW2nJaeD84vKG
	 x+Ln2Kjz9vKMP5dTfK0xjWlRi/Kpi9ZbbCEsDrkzGpVAeWlGBR5mKQpXS7ulCGrwnxt0z
	 /fA90Q4GakypbrGA0EkPvVvqaphZ7hIUeXw0hUY7DyfdbPf4jUuanPqNNJoe0qmUx27Yv
	 g8WtcLgAJDfmteJYgPJjTTFBm/CmBGtPJpeZDP3ZxiS4sEKYtvOqp5PSrM9emGRDN8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jo1s8UEE;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC80606A32D
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 13:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFC80606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jo1s8UEE
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb64c99bb8so47075545e9.1
        for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 05:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795614377; x=1796219177; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hkC7knUlQ5bvCCnLhIKdyMONWGi8riIRNrWMCj0qGvQ=;
        b=Jo1s8UEE3CbBJCIiiKMqj0sIxmA1b6SJlgvCLjoLH7awjt5CqY+UG2SEfqUKA6XJ+K
         LQq/tR25gEVAUpLvzhR9kjZ8kJASkLJTGjHY6Qqtn822g3E/HggvpKfqNPddHQUYOYCd
         bbL2RWXyUmB2+IyDY1kTKQPx0VxUa1wmkQOu1hoJ5aPM436Qy9fHE0QkVf4qbMD4DCvw
         pkm5zXE4VZ3cI12exFQ6Z4j1gi1YwiZJPTLADZZwVOo8n5MMX5JD/LAsdTvYUuMYD/TR
         +GDrqrlEHTLnulHwtnVlLLO7uafrLs95vNt27RyUsK/8X00n3Jtf2NHXnevfRLJ+s7eU
         NCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795614377; x=1796219177;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hkC7knUlQ5bvCCnLhIKdyMONWGi8riIRNrWMCj0qGvQ=;
        b=pT5krV2+DCItCO/bdhC8SPNSOzvXvuI+tyoDciqt/qonX3YTItTlybJmLKy0JoL03e
         N+9Inie/VrzqpBskb7uyQkC6PY4i7bWjml3F9wrIO9G3/bHjCLhAIOEM3swizNooqw8X
         0QzfGqYZqPW2dUUuZOk3vfC685sVy79itnRmOvu31gRzntDjNlDycMsKI2S1HQVhJz66
         +8witjOElJ+yMeK6Q12Eweyg7h+GE+l5pnfPPvRB+B5nDz56blcmzSbn2Mb58N5DaMMa
         Il1EGm4VL6rEAymokTh/t1tFdfiUE4JxHaVbmC0ccl0NOrq+hk48IL4W6MJHCpA6pCVQ
         yEVw==
X-Forwarded-Encrypted: i=1; AL+hErGOcP89m0x5t40sFmQhfr9rF7IWa1KH51xJVMIlERzFyJXeIhgIiRxWtab/7Jq8tVTIhkA6eDKwXhU=@lists.linux.dev
X-Gm-Message-State: APuU4Z8GE332OCuRT0ex9xGHj+MaMAEa5MzWaF3Hn6TEshPt8dplLfZO
	/wa4cLHqW7/2IVt9iFA9DJyfDo9k/5knZuN2g8BXHkOVD+TwgN50YxIVIhCo9cHaj7ISJ4dEh3G
	dR9IAVtqNa8HFqA==
X-Received: from wmcn22.prod.google.com ([2002:a05:600c:c0d6:b0:4a1:f1e1:c6d6])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5487:b0:4bb:5de1:e92c with SMTP id 5b1f17b1804b1-4bb88813157mr368724395e9.26.1795614376787;
 Wed, 25 Nov 2026 05:46:16 -0800 (PST)
Date: Wed, 25 Nov 2026 13:46:16 +0000
In-Reply-To: <2026112535-handcraft-glance-0edb@gregkh>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <2026112535-handcraft-glance-0edb@gregkh>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125134541.3432982-1-jpiecuch@google.com>
Subject: [PATCH 6.18.y] sched_ext: Read exit_kind before flushing in scx_flush_disable_work()
From: Kuba Piecuch <jpiecuch@google.com>
To: stable@vger.kernel.org
Cc: Kuba Piecuch <jpiecuch@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Sashiko <sashiko-bot@kernel.org>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
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
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit 3133107d98057595c0af39ff907c852134926912)
[ jpiecuch: applied kernel/sched/ext/ext.c hunk to kernel/sched/ext.c;
  kept error_irq_work instead of disable_irq_work. ]

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index af5828f09304..882e06a76a16 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4247,10 +4247,17 @@ static void scx_flush_disable_work(struct scx_sched *sch)
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
 		irq_work_sync(&sch->error_irq_work);
 		kthread_flush_work(&sch->disable_work);
-		kind = atomic_read(&sch->exit_kind);
 	} while (kind != SCX_EXIT_NONE && kind != SCX_EXIT_DONE);
 }
 

base-commit: 4700e3adf3b24b39dd4929e9c6d62811ba3ccea8
-- 
2.56.1.839.g22a8290db9-goog

