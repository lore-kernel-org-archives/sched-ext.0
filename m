Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E3323FC41;
	Thu, 27 Nov 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258496; cv=none; b=Jq9rRnxlryG3Cp8kOzrRHzcrAv144pO9DbehidYTYugjVha9j6CP70fgOL2+oKWi6zS91LwS4RExpfT8LOeL/X3oiTMdUTiC0f2cdNTrGgRrSs77Oqrhbna0uQF11vtAvcACQvui1Gnc54eZzaqGf0hpAaw2E/VWWZfGsDwG9u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258496; c=relaxed/simple;
	bh=IqyVfWu40ZLMUdC0ro/AyQRRI5FJiBLB0sei0TEvx64=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Uwffpe5iyoPbPE3/qsUNTqlJekODsH2VOAcDVn2Mv0YycuHVcWrf9KwGrgxu5QcSDO8pCtEpDRZCgFBNI2dcjYoEEYYCYUcUZamQn+1KddO1GLymkKJ8lwcm89tJxYLPQALiWOOl6ioz6rdmi+AksoJgZ7mUC8NUAZ1HNOf1F08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QIZ1DJGO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QIZ1DJGO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=dnCfp3L62pj9DutfreyucA8+0cAoopcZko6tHzka0nM=; b=QIZ1DJGOf4fdowOurudefi2LSh
	QyMSKJH95T4AGH4uR67wYLjJoN4Wp1EgT/nGj2zi0NTMLvnjZcZachbFXEiVDDe2hdbT+pl9vior4
	wgXLrTXjZVuB03pTUaWtJ/ShhBUHvUmQALGn1X5rwz5YiG1TsehrhWn31vvWgiG3+NSbyDq4UT/1q
	hcTCTVbIHI8w71V++tFeHgV38yxVWG28X2y5yuLVY0dx1soiNIac27XVNURQExLnCHAAxbi5r3jK6
	arTzleoX640v7dkHCeUEx7gBmuooWskah6G7Z5lglWigKLAQjxH7gHO78r7Ov3Pf143ZhJwxuklcQ
	Odx7H04Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOdMT-0000000AP1z-3KQd;
	Thu, 27 Nov 2025 14:52:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id B3AA7302FD7; Thu, 27 Nov 2025 16:48:06 +0100 (CET)
Message-ID: <20251127154725.771691954@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 27 Nov 2025 16:39:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 sched-ext@lists.linux.dev
Subject: [PATCH 4/5] sched: Add assertions to QUEUE_CLASS
References: <20251127153943.696191429@infradead.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Add some checks to the sched_change pattern to validate assumptions
around changing classes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   13 +++++++++++++
 kernel/sched/sched.h |    1 +
 2 files changed, 14 insertions(+)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10806,6 +10806,7 @@ struct sched_change_ctx *sched_change_be
 
 	*ctx = (struct sched_change_ctx){
 		.p = p,
+		.class = p->sched_class,
 		.flags = flags,
 		.queued = task_on_rq_queued(p),
 		.running = task_current_donor(rq, p),
@@ -10836,6 +10837,11 @@ void sched_change_end(struct sched_chang
 
 	lockdep_assert_rq_held(rq);
 
+	/*
+	 * Changing class without *QUEUE_CLASS is bad.
+	 */
+	WARN_ON_ONCE(p->sched_class != ctx->class && !(ctx->flags & ENQUEUE_CLASS));
+
 	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
 		p->sched_class->switching_to(rq, p);
 
@@ -10847,6 +10853,13 @@ void sched_change_end(struct sched_chang
 	if (ctx->flags & ENQUEUE_CLASS) {
 		if (p->sched_class->switched_to)
 			p->sched_class->switched_to(rq, p);
+
+		/*
+		 * If this was a degradation in class someone should have set
+		 * need_resched by now.
+		 */
+		WARN_ON_ONCE(sched_class_above(ctx->class, p->sched_class) &&
+			     !test_tsk_need_resched(p));
 	} else {
 		p->sched_class->prio_changed(rq, p, ctx->prio);
 	}
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -4027,6 +4027,7 @@ extern void balance_callbacks(struct rq
 struct sched_change_ctx {
 	u64			prio;
 	struct task_struct	*p;
+	const struct sched_class *class;
 	int			flags;
 	bool			queued;
 	bool			running;


