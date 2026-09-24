Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07175437130;
	Thu, 24 Sep 2026 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236374; cv=none; b=ET80ykJq7gaGg++UWUI+JEfaniuqNaaplaQMF4zq+Fj65K4FkcCekTgAZL/BOtFYpfCyOEQ/n7v+8Vc7M15hNr8T/mYRd1+U1fapQ1/x7+JxtDvOSVYuQdjmTUHpyk598ylmtLemkXvHF+vqqbS40DeNe2Up79hwV/UDQQSh+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236374; c=relaxed/simple;
	bh=uA9YliptjuclDhdJHUkiYlNkK3kJltVu1MDMilMVRBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvG05b286jCB5ewx6DHL8fH+hVt7Lf9yDqD6XLHO68y0PBy6W3V20viM5JgRCs+mP75n/8+A5Td64fAD9cEwSkMAiWehdHtHmEqfCxUcB7flHgZFO3D5czZ+KJAhbC84tL/PQDTPXJOB9RtVojYCMv2HCxCv/oiq8Q6HJce2owI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nXh/a7VC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nXh/a7VC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6fenWS0XseMAhPrAntYD0qGrjw8WNZXrFxavgL7H8BE=; b=nXh/a7VCVbqFR68gAYjtDQnjcj
	LB2YZaWvNB5Qbaign0LtJ+3yw1Iow5rXpQpzZt4Hp0Ae04gVdDriuNIQuOX3d9n0RQEhDMGjSh0LS
	5NpLNaJ62oYkisjEsdFQ4zfJ08NWNkuE8q4yoY/vO6kIihGFcSiZB/8QzxN+e/1s9ZFZTgJpjLS3X
	54WqtM98ypMaMlneon65vOZjJqOYYVPfmYbolUTDEA1sSkK1ctMdmlm91nf0YLmkmklHzhFRjh/GU
	8Bwap2OcRDMy6+EeXr+eOmkG761jg1B1lNbFEBsD0OccreyaSzAff5PmwP4a7vM578kJ1TqkG1SUV
	VtkRMr5A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9eFz-0000000FqCT-0Lb2;
	Thu, 24 Sep 2026 07:52:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 01723300756; Thu, 24 Sep 2026 09:52:38 +0200 (CEST)
Date: Thu, 24 Sep 2026 09:52:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v14 sched_ext/for-7.4] sched: Make proxy execution
 compatible with sched_ext
Message-ID: <20260924075237.GH2009045@noisy.programming.kicks-ass.net>
References: <20260922165445.943315-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922165445.943315-1-arighi@nvidia.com>

On Tue, Sep 22, 2026 at 06:51:39PM +0200, Andrea Righi wrote:

> Andrea Righi (16):
>       sched/core: Drop mutex locks before proxy rescheduling
>       sched/core: Dequeue waking proxy donors before reset
>       sched/core: Mark wakeups completed through ttwu_runnable()
>       sched: Add helper to block retained proxy donors
>       sched: Add sched_ext hooks for proxy execution

Right, so these add:

WF_TTWU_RQ:

  Used like ENQUEUE_DELAYED; could be fixed by generalizing that to cover all
  of p->is_blocked.

scx_allow_proxy_exec():

  Hook to kill proxy exec for scx

scx_proxy_reenqueue_retry():

  Like put_prev_task(), but for current. Ensures current gets put back on a DSQ
  once its done running.

scx_proxy_donor_start():

  Delayed set_next_task(), confirms donor will be used.

sched_proxy_block_task():

  Almost like switching_to_scx(), except it needs to change ctx->queued in case
  of p->is_blocked. Hence a new callback ran before sched_change_begin().



Now, I have:

  https://patch.msgid.link/20260917-sched-fair-hrtick-restart-v4-1-4dd1414da81a@gentwo.org,

pending, would something like the below on top of both this work?

(although I'm not convinced SC_CONFIRM is actually making it better)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1876,7 +1876,7 @@ static inline void uclamp_rq_inc(struct
 	if (!uclamp_is_used())
 		return;
 
-	if (unlikely(!p->sched_class->uclamp_enabled))
+	if (unlikely(!(p->sched_class->flags & SC_UCLAMP)))
 		return;
 
 	/* Only inc the delayed task which being woken up. */
@@ -1904,7 +1904,7 @@ static inline void uclamp_rq_dec(struct
 	if (!uclamp_is_used())
 		return;
 
-	if (unlikely(!p->sched_class->uclamp_enabled))
+	if (unlikely(!(p->sched_class->flags & SC_UCLAMP)))
 		return;
 
 	if (p->se.sched_delayed)
@@ -7268,9 +7268,10 @@ static void __sched notrace __schedule(i
 	rq->next_class = next->sched_class;
 	if (sched_proxy_exec()) {
 		struct task_struct *prev_donor = rq->donor;
+		struct task_struct *donor = next;
 
-		rq_set_donor(rq, next);
-		next->blocked_donor = NULL;
+		rq_set_donor(rq, donor);
+		donor->blocked_donor = NULL;
 		if (unlikely(next->is_blocked)) {
 			next = find_proxy_task(rq, next, &rf);
 			if (!next) {
@@ -7283,8 +7284,7 @@ static void __sched notrace __schedule(i
 				goto keep_resched;
 			}
 		}
-		if (rq->donor == prev_donor && prev != next) {
-			struct task_struct *donor = rq->donor;
+		if (donor == prev_donor && prev != next) {
 			/*
 			 * When transitioning like:
 			 *
@@ -7298,9 +7298,10 @@ static void __sched notrace __schedule(i
 			 * on_cpu.
 			 */
 			donor->sched_class->put_prev_task(rq, donor, donor);
-			donor->sched_class->set_next_task(rq, donor, true);
+			donor->sched_class->set_next_task(rq, donor, SNT_PICK);
 		}
-		scx_proxy_donor_start(rq);
+		if (donor->sched_class->flags & SC_CONFIRM)
+			donor->sched_class->set_next_task(rq, donor, SNT_CONFIRM);
 		scx_proxy_reenqueue_retry(rq, next);
 	} else {
 		rq_set_donor(rq, next);
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5069,8 +5069,12 @@ DEFINE_SCHED_CLASS(ext) = {
 
 	.update_curr		= update_curr_scx,
 
+	.flags			= 0
 #ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 1,
+				| SC_UCLAMP
+#endif
+#ifdef CONFIG_SCHED_PROXY_EXEC
+				| SC_CONFIRM
 #endif
 };
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15887,7 +15887,7 @@ DEFINE_SCHED_CLASS(fair) = {
 #endif
 
 #ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 1,
+	.flags			= SC_UCLAMP,
 #endif
 };
 
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2636,7 +2636,7 @@ DEFINE_SCHED_CLASS(rt) = {
 #endif
 
 #ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 1,
+	.flags			= SC_UCLAMP,
 #endif
 };
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2641,13 +2641,17 @@ enum snt_e {
 	SNT_NORMAL,	/* set_next_task() */
 	SNT_PICK,	/* put_prev_set_next_task(): prev != next */
 	SNT_REPICK,	/* put_prev_set_next_task(): prev == next */
+	SNT_CONFIRM,	/* confirm pick */
+};
+
+enum {
+	SC_UCLAMP	= 1<<0,
+	SC_CONFIRM	= 1<<1,
 };
 
 struct sched_class {
 
-#ifdef CONFIG_UCLAMP_TASK
-	int uclamp_enabled;
-#endif
+	unsigned int flags;
 
 	/*
 	 * move_queued_task/activate_task/enqueue_task: rq->lock
