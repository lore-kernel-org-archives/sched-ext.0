Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7F220687;
	Tue, 28 Oct 2025 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649324; cv=none; b=VWB90+Y+MtBaDTWSKf670KOpAtrOlMVgSmGouq0DP6AxZv3M3sOUNPS+0k+mcZcu0IukIEoks0meKwjxCH9DyUqpfoy+km+czuTprZP+1puZWwCOxv6Dy4ExJFC3OoZoHf2f0tnjSun56/8bsWnF0nKGOuB94Ud+DBHgjYw5TxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649324; c=relaxed/simple;
	bh=cCy7XfJQQ6tmEWKrz8y/ZGaRRcmwc7CUhVpp/ftQ01E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZAxr9Ymu1dJDJM+svSkfddd/bHBaYcQOhIq5T1dNbX1hpWhP1cB28BvbIWXrsysgw9Pu7SGxCWnb98HQFVuNUt4C+ZcZEHB7aU3DYi5QPoxBkjPqip1v8C11SoMsHaQVJCIHwg8b7lktBSS9KsYQXfhfrNZ3EcNp4qkgcldFJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nauEeugs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nauEeugs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BKyHZS2EZCHEG5HvTJgD6zBUF5GxKhRVP4H8eLNSKjM=; b=nauEeugsTVqeocAIeaAK6vw9wp
	S+kz22OoJMAA6gEOdXCP9JHtlp3/tWukoqjiDmBy/qRWHhy7639BM3PkMWVlC1SXoIxwOlk5monSk
	5CkbNM/tNw+Q8nTgJAuV1e96GKBV7X5AjR2TmP/wxLjuuAMzI4HMocDvvJ11P5mwansMLPFiZGjbk
	GuWrnpHczU+VGAtykBhFNKcv9WLFADBrzQr8mJ0iElQyb340D4ijFwmsB4A1INOjSs5tgNJueMY0c
	SvZ/SxcZhb5YhgUvRwWXYzy+Aj48EiEBiT4MpBbjMzTnA2Uv634b0PKiqiWE6H0vjvq/DjBLQLB+L
	dZXrqAHA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDgat-00000004ChB-42b7;
	Tue, 28 Oct 2025 10:06:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CE07D300323; Tue, 28 Oct 2025 12:01:53 +0100 (CET)
Date: Tue, 28 Oct 2025 12:01:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <20251028110153.GZ4067720@noisy.programming.kicks-ass.net>
References: <20251025001849.1915635-1-tj@kernel.org>
 <20251025001849.1915635-4-tj@kernel.org>
 <20251027091822.GH3245006@noisy.programming.kicks-ass.net>
 <aP-XAGrWQY1d6Bq9@slm.duckdns.org>
 <20251027181028.GB988547@noisy.programming.kicks-ass.net>
 <aP-3QsygWJRn6Z2u@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-3QsygWJRn6Z2u@slm.duckdns.org>

On Mon, Oct 27, 2025 at 08:17:38AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Oct 27, 2025 at 07:10:28PM +0100, Peter Zijlstra wrote:
> ...
> > Just for my elucidation and such.. This is when ttwu() happens and the
> > CPU is idle and you dispatch directly to it, expecting it to then go run
> > that task. After which another wakeup/balance movement happens which
> > places/moves a task from a higher priority class to that CPU, such that
> > your initial (ext) task doesn't get to run after all. Right?
> 
> Yes, that's the scenario that I was thinking.

So I've been pondering this a bit, and came up with the below. I'm not
quite happy with it, I meant to share that new queue_mask variable, but
this came out.


---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2175,10 +2175,14 @@ void wakeup_preempt(struct rq *rq, struc
 {
 	struct task_struct *donor = rq->donor;
 
-	if (p->sched_class == donor->sched_class)
-		donor->sched_class->wakeup_preempt(rq, p, flags);
-	else if (sched_class_above(p->sched_class, donor->sched_class))
+	if (p->sched_class == rq->next_class) {
+		rq->next_class->wakeup_preempt(rq, p, flags);
+
+	} else if (sched_class_above(p->sched_class, rq->next_class)) {
+		rq->next_class->wakeup_preempt(rq, p, flags);
 		resched_curr(rq);
+		rq->next_class = p->sched_class;
+	}
 
 	/*
 	 * A queue event has occurred, and we're going to schedule.  In
@@ -6814,6 +6818,7 @@ static void __sched notrace __schedule(i
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 keep_resched:
+	rq->next_class = next->sched_class;
 	rq->last_seen_need_resched_ns = 0;
 
 	is_switch = prev != next;
@@ -8653,6 +8658,8 @@ void __init sched_init(void)
 		rq->rt.rt_runtime = global_rt_runtime();
 		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
 #endif
+		rq->next_class = &idle_sched_class;
+
 		rq->sd = NULL;
 		rq->rd = NULL;
 		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2289,9 +2289,16 @@ static int balance_dl(struct rq *rq, str
  * Only called when both the current and waking task are -deadline
  * tasks.
  */
-static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
-				  int flags)
+static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p, int flags)
 {
+	/*
+	 * Can only get preempted by stop-class, and those should be
+	 * few and short lived, doesn't really make sense to push
+	 * anything away for that.
+	 */
+	if (p->sched_class != &dl_sched_class)
+		return;
+
 	if (dl_entity_preempt(&p->dl, &rq->donor->dl)) {
 		resched_curr(rq);
 		return;
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2966,7 +2966,12 @@ static void switched_from_scx(struct rq
 	scx_disable_task(p);
 }
 
-static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
+static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_flags)
+{
+	if (p->sched_class != &ext_sched_class)
+		switch_class(rq, p);
+}
+
 static void switched_to_scx(struct rq *rq, struct task_struct *p) {}
 
 int scx_check_setscheduler(struct task_struct *p, int policy)
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8729,7 +8729,7 @@ static void set_next_buddy(struct sched_
 /*
  * Preempt the current task with a newly woken task if needed:
  */
-static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int wake_flags)
+static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wake_flags)
 {
 	struct task_struct *donor = rq->donor;
 	struct sched_entity *se = &donor->se, *pse = &p->se;
@@ -8737,6 +8737,12 @@ static void check_preempt_wakeup_fair(st
 	int cse_is_idle, pse_is_idle;
 	bool do_preempt_short = false;
 
+	/*
+	 * XXX Getting preempted by higher class, try and find idle CPU?
+	 */
+	if (p->sched_class != &fair_sched_class)
+		return;
+
 	if (unlikely(se == pse))
 		return;
 
@@ -13640,7 +13646,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.yield_task		= yield_task_fair,
 	.yield_to_task		= yield_to_task_fair,
 
-	.wakeup_preempt		= check_preempt_wakeup_fair,
+	.wakeup_preempt		= wakeup_preempt_fair,
 
 	.pick_task		= pick_task_fair,
 	.pick_next_task		= pick_next_task_fair,
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1615,6 +1615,12 @@ static void wakeup_preempt_rt(struct rq
 {
 	struct task_struct *donor = rq->donor;
 
+	/*
+	 * XXX If we're preempted by DL, queue a push?
+	 */
+	if (p->sched_class != &rt_sched_class)
+		return;
+
 	if (p->prio < donor->prio) {
 		resched_curr(rq);
 		return;
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1179,6 +1179,7 @@ struct rq {
 	struct sched_dl_entity	*dl_server;
 	struct task_struct	*idle;
 	struct task_struct	*stop;
+	const struct sched_class *next_class;
 	unsigned long		next_balance;
 	struct mm_struct	*prev_mm;
 
