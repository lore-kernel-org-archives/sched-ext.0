Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015076;
	b=jTrvqWfJOVVOUOebtmixINavUVq3ekq3UXmzeZjNYx29CrvKN3O+ohHiqrHvmAe2De1W
	 N+EyFPvwvtr+rQTyRMIB8f1Fjx9yZwH19mq+b3F3D8ww2j/HhAVRy9S2BvzLL2igH2Hg5
	 sDSerx3jqXzvvbzN16DBMNSeMMTr0JjofWOmeq7/WK7/L53ZnDqDVws8UOueLHWumYS7l
	 Gf+QaZ4yYYJ08vxI+CqX3CU0qpl5X9jfwXM36va6VCcrFM3lsjZELZH1AxD1U1QsUXNRq
	 4wV7aw+KdRePArvpEhKGbThxyn9I3M4DoLMtpFJCM1y/3KAEUoh7qkkUhGLIfNHnDjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MCxLFVekHshLR9plLQafQMYGaOoafpn9N5VeIA++ViM=;
	b=Zt7ZrMSql/EjhbgaRPfVTrTj5r+KtMfpAHA6Bh97t/81hoINYwS5tQ1SLrHxGOct7S2b
	 N5RYoTr/C4q9ObJSws1jI//k6kQh7iePp4cnNSxHfvgl/z788eHC9tNhw3xvDO7bN5Bd5
	 jJrtQqZc0/y/0NH+EcpWgjJvS6o8a17lzn48W5nRA9DjddU5HC/ExerFum7U2lIMHmWG7
	 x3trj8ZZt6qxvtS3381UMePQfK5GiuWVRXE1sCfq6JdNf368NgPmrP37p0L0ds5qqQxAV
	 iSRlknFBxKq3PtABx7egp1w8GRBYbWFwJFP+kWRGFPMRVDjHbQvxKfBkUw5Ai86YW6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qSoqyFD0;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370D606A324
	for <sched-ext@lists.linux.dev>; Mon, 26 Oct 2026 11:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B370D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qSoqyFD0
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c415561aaso1896735f8f.1
        for <sched-ext@lists.linux.dev>; Mon, 26 Oct 2026 04:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793015074; x=1793619874; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCxLFVekHshLR9plLQafQMYGaOoafpn9N5VeIA++ViM=;
        b=qSoqyFD0dV+BwfGNIP1dlkGiKYOOHkxroZFZX328K/YQKORpjQeMwnCsaAEer9P8YY
         04Rfelcxd5na5WB7dlGUMxDGibl1RIhuCQmuJHE/N9ME5DYoxi0RJVhB8do10FDfoYSg
         H+LSB20tk6JHf6tJPwxeoPExzmmm6P6vFBok0riAxOOErjMkmUtK4wSbu2rgVkfFNUyl
         NZ7Gn4SoC3Zs9hM8CzxCMtCQ/e2irdZZH6hhXHlJyXD6qaaH6vSa4XcLF7b8lbTpzR5N
         PsHwI1vgs/S/I1Ukt4772IlzZQTwJ4DpbNJNeRyTnv+0wjMoNygfX7xo0Z4l4uiWGpyQ
         j90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015074; x=1793619874;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCxLFVekHshLR9plLQafQMYGaOoafpn9N5VeIA++ViM=;
        b=q2Nlb92JX6G5IaUF3zSYmqtlAalpBD4Pn8TW8dgEN39OWKUm5sPSXCvqA0hTinkKGf
         2Sj3LCii1gIJya0kgrRj7/nfy6upmW87bYNELTIj26GvnctyfftomBv1ruqhfLb5mIF+
         X9+iQu8f/7UydIP0zMgGhY+ywIHcJZ53faN9Ye0RIHysCUbUqfHmFG6qOuSLHyMO4/Di
         rlSI8TQQQ8A6Ds0oBFsSqv2CkuJsPXgmfmYik+R4+eIM8GV0J525AK5NP7PYIwIQeEi3
         V2hRh0CmCmY3ggGoqylQp59bjOfElag/XezNSfB3DEb7/OvPp/aTcI5+ycV1YFrQ2Nat
         nCIA==
X-Forwarded-Encrypted: i=1; AKwUvBxvGayuxep0/m3p8zOFtuBQPGimOnKm7s9MtaEw2auWMXpvDlukGAl8fAJA1orI9YcA/T+HNSUx5cY=@lists.linux.dev
X-Gm-Message-State: AFq9FYKcUviqqJ/fWD0c+kFKj7arUNc9EgWpQlhlH3YEN6KLYPI8QlqL
	mGbPwqFwN4EKpz5ZevqMKXgn2evShhzWI6cjZVgHKoi+KYwf+vcZKXdzxM++R74mECYig64Y7wA
	o/0pdlj7J2Dl5sw==
X-Received: from wmix10-n2.prod.google.com ([2002:a05:600c:e54a:20b0:4a1:d741:8413])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:608c:b0:4a7:7f3f:6f8e with SMTP id 5b1f17b1804b1-4a77f3f7008mr3105905e9.0.1793015072677;
 Mon, 26 Oct 2026 04:44:32 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:44:23 +0000
In-Reply-To: <20261026114429.209588-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261026114429.209588-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261026114429.209588-2-jpiecuch@google.com>
Subject: [PATCH v2 1/2] sched/core: Preserve WF_RQ_SELECTED across queued wakeups
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>
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
index 12a7e094a3e6..9dabffea1c54 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1006,7 +1006,7 @@ struct task_struct {
 	/* Unserialized, strictly 'current' */
 
 	/*
-	 * This field must not be in the scheduler word above due to wakelist
+	 * These fields must not be in the scheduler word above due to wakelist
 	 * queueing no longer being serialized by p->on_cpu. However:
 	 *
 	 * p->XXX = X;			ttwu()
@@ -1016,9 +1016,11 @@ struct task_struct {
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
index 0ab15f03cb94..d8495735166d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3975,13 +3975,20 @@ void sched_ttwu_pending(void *arg)
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
@@ -4025,6 +4032,7 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 	struct rq *rq = cpu_rq(cpu);
 
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
+	p->sched_rq_selected = !!(wake_flags & WF_RQ_SELECTED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
 #ifdef CONFIG_SMP
-- 
2.56.0.257.gf7497c7d27-goog

