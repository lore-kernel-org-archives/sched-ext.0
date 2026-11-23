Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454286;
	b=bV7BYE+p3jPxdIw/q1JxORNK31Gq7j97Cueryn1l3zC+AZha53VySm/gvbCS9ySiwSPf
	 a1euxEMbZyu91I4dJlxMUwiZ3MLZSIfVybH13DYA9qtQcmTiyWqhPNKlK1t8sl9oOTmmH
	 eKbCwPN+Wpi2KkVa/l+pzg5rVsPi8h2SqK01b/S5FasRwV86R+GoSgvEeO2m8C49yE+Gt
	 YXTPWPqTTnOHMQU7N8Q80g4roJHovRQpKjmhonLA0sfxPMVmLbTRi/KzXEHosQnlXL/oa
	 /x4p90cBc27qqBcCU+Aui+OjkwdnpqeASkbxGsKaUldVzZ/VU03LS0cj5lkLe2R46lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=DhavAmcGgx7rmczz3jLQXngN/KVyd2Bv9UK1AdUvPrs=;
	b=okGvjwANCzUdk6foyuUPaEy9OtSndc4zfya1EN3uVYC3pzXPAm6rQLnmlyD47efZ7Bmt
	 BPzggyuL24mz5jg42mAayfK7Wu7Q/Syg+1SuSQOcL6NRBCkXScYfrlLHi1B90Qg4d+9dm
	 gkZBz7oUZ6JWQv05AUaZT2HJeWH3lvvxNwLWmJLwzbtmH8K1pVYPkpztyLR7cecWTJVP3
	 /xQraIJ0rGbV7VAkzWTzmWCQsTh4NthoZcaFRoMjFtoc+4gDpQesQwuYKTMhmI5Qrj4pn
	 Yu5qnXB8BnrqERUV78PyhQSKc/2xvDojlq5j5r2AdrES2TTIYDJOCEGpkRFl4oAn1yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RBssgFXi;
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F45A606A32C
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 17:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F45A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RBssgFXi
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c514c051a65so329891166b.2
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 09:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795454285; x=1796059085; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DhavAmcGgx7rmczz3jLQXngN/KVyd2Bv9UK1AdUvPrs=;
        b=RBssgFXiCln9PxZH3lpNzAl7xm89ZPA/c4jInyvqVMomruMP1saBfXJB6pyLriag1N
         96gMnUGLfxrVuBAimD/PeFfCrUskyVeo2qnphf9KOQf74vJpEowX1J/Wrld4tONDNZgN
         sn9UIMopPXnnVPPqW+N0MPEQiN1lpNjSBl8KDxJIec4JpMYq2LoW7L4jEy8WTsF/cKo5
         b4s7gNovnh38IdO82Xu2DVYMgf8xiIr7OmtJuqGayXW85lfMtZ1ER+jYnpBeb3YXeHV1
         6B6/quCYVf5W/ZahIA0SrHwWOlGRbuqLpIbr76QJMLVW4SREIksVyjLzjxrIkGhPmZXS
         8jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795454285; x=1796059085;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DhavAmcGgx7rmczz3jLQXngN/KVyd2Bv9UK1AdUvPrs=;
        b=zY42uDVm+FRI7F/BcWSq9QsVriixw+T5QRSR+vmuJ5+r9Q/RRN9chE7CwC4sRQ/515
         88y08UyRmsfulP2Gzmwu3Tor0r2i+d9bXUxU4IAhKa96jeG0gXX0yuQlWzI+WiDc7g0C
         rS5bz7bNkrPjnYUa4NlbXqnWsamXNhHfe29A2I67owtlRRO2Mh3K2+xxYHPoP3sIeExX
         8CoRJjykPzTOyG5WnlU24Cf91PDfSZjzHkTkAW+TT+oBNtX/7NSO/aZ20inozgU8+FmU
         5heKQEV1y7K+xuMy5DT52kLGVLVp1YSvWXPjw8V1x8n2hKrcOMvbSS/+ULh4Lqroj3+B
         bYqg==
X-Forwarded-Encrypted: i=1; AL+hErGkbF5BXRqlrEDX1iBZY1PjCYgEADIZ6nsgkxpcuDYuT2EaBYSn+mMyzpdNGbaPONfMsf5mmP+Rywg=@lists.linux.dev
X-Gm-Message-State: APuU4Z9L5f7LCCin46xvRBX/fwgOon24PFiT33OdnN2Gm+jC1Jse0Xo/
	s0tG2W12xi2N/XOtErRTwwGwfcUh0YyzUG28fNqG+SbllFStNQe0vN2/jSSgrEYV33akFuCKUxk
	WbDLy8q4DeP4wMQ==
X-Received: from ejcmy38.prod.google.com ([2002:a17:906:5a66:b0:c51:1899:3ad0])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:d01:b0:c51:8d3d:eef with SMTP id a640c23a62f3a-c518d3d16a1mr53924366b.12.1795454284661;
 Mon, 23 Nov 2026 09:18:04 -0800 (PST)
Date: Mon, 23 Nov 2026 17:18:01 +0000
In-Reply-To: <20261123171637.3859594-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123171637.3859594-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123171637.3859594-2-jpiecuch@google.com>
Subject: [PATCH RESEND v2 1/2] sched/core: Preserve WF_RQ_SELECTED across
 queued wakeups
From: Kuba Piecuch <jpiecuch@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ENQUEUE_RQ_SELECTED tells a sched_class that ->select_task_rq() was
called for a task wakeup. sched_ext exposes this flag to BPF schedulers
as SCX_ENQ_CPU_SELECTED.

When a BPF scheduler sets SCX_OPS_ALLOW_QUEUED_WAKEUP, a wakeup can be
delivered through the ttwu wakelist in two ways:

 1) from the p->on_cpu path, before ->select_task_rq() is called. In this
    case WF_RQ_SELECTED is not set and SCX_ENQ_CPU_SELECTED is correctly
    clear;

 2) from ttwu_queue(), after ->select_task_rq() has been called. In this
    case WF_RQ_SELECTED is set in wake_flags, but sched_ttwu_pending()
    only carries WF_MIGRATED across the wakelist, so the flag is dropped
    and ops.enqueue() is wrongly told that ops.select_cpu() was skipped.
    This also results in undercounting SCX_EV_SELECT_CPU_FALLBACK events.

Fix case 2 by preserving WF_RQ_SELECTED across the wakelist in the same
way WF_MIGRATED is, so that ttwu_do_activate() passes
ENQUEUE_RQ_SELECTED to activate_task(). Case 1 is unaffected.

Fixes: 3539c6411a7c ("sched_ext: Implement SCX_OPS_ALLOW_QUEUED_WAKEUP")
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 include/linux/sched.h |  6 ++++--
 kernel/sched/core.c   | 10 +++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e4f6323d7855..34dbcb81f2fd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1008,7 +1008,7 @@ struct task_struct {
 	/* Unserialized, strictly 'current' */
 
 	/*
-	 * This field must not be in the scheduler word above due to wakelist
+	 * These fields must not be in the scheduler word above due to wakelist
 	 * queueing no longer being serialized by p->on_cpu. However:
 	 *
 	 * p->XXX = X;			ttwu()
@@ -1018,9 +1018,11 @@ struct task_struct {
 	 *     p->on_rq = 0;			p->sched_remote_wakeup = Y;
 	 *
 	 * guarantees all stores of 'current' are visible before
-	 * ->sched_remote_wakeup gets used, so it can be in this word.
+	 * ->sched_remote_wakeup and ->sched_rq_selected get used, so they can
+	 * be in this word.
 	 */
 	unsigned			sched_remote_wakeup:1;
+	unsigned			sched_rq_selected:1;
 #ifdef CONFIG_RT_MUTEXES
 	unsigned			sched_rt_mutex:1;
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c9890ed35df7..a36c5e951aae 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4000,13 +4000,20 @@ void sched_ttwu_pending(void *arg)
 	update_rq_clock(rq);
 
 	llist_for_each_entry_safe(p, t, llist, wake_entry.llist) {
+		int wake_flags = 0;
+
 		if (WARN_ON_ONCE(p->on_cpu))
 			smp_cond_load_acquire(&p->on_cpu, !VAL);
 
 		if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
 			set_task_cpu(p, cpu_of(rq));
 
-		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
+		if (p->sched_remote_wakeup)
+			wake_flags |= WF_MIGRATED;
+		if (p->sched_rq_selected)
+			wake_flags |= WF_RQ_SELECTED;
+
+		ttwu_do_activate(rq, p, wake_flags, &rf);
 	}
 
 	/*
@@ -4050,6 +4057,7 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 	struct rq *rq = cpu_rq(cpu);
 
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
+	p->sched_rq_selected = !!(wake_flags & WF_RQ_SELECTED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
 #ifdef CONFIG_SMP
-- 
2.56.1.750.gf70dc682cf-goog

