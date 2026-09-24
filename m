Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F343E069;
	Thu, 24 Sep 2026 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236777; cv=none; b=k0qDXdgN5C0HWd5IJ8lbjb4DKJ1fTlVHIL4AonwifWfxK7GJSlEqOFC1KwptUJNSbyV1uk8BkcoaxZGKvrcfDOTf2g915YOKAzhfwS+EehKPYdvsbSLvvSrtUKZ0MJ1nqF3amT3S6msvfO4+OmRVNolcEDF0EGph/YkE2FJ8Rs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236777; c=relaxed/simple;
	bh=jxC8F7qLnoV0gDyWlqUxIXfYSuGaTM1jGGGSbqjvo64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tb5KZuDx6T3Yp6zEbnV3PawR+apQSvUPO+kvP2zwuEdjgUojrUxNHphzKH+BRUIqLt9baqTA/QKMolZUqOsqIEcUbvVMN1C3hj1U0CKEG8jSdG0upoZqsrYtKlfs+vizMAVcsVmoFLbmWt8jWX3dlC61Q9u+kCpNw/KZbAaQkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rRMOOliD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rRMOOliD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i+/etC7M1IjFvTKUh4gdm/5zLybkbwVOhuiX8fNtSbg=; b=rRMOOliDkugK3lcsosGiOaFRcY
	J2E9C/eydIELhlps+8nqVMwBWPNkLd9MdoIZjsh+Tgv+n/hX1mpXlem2VcQH4i2f6z6PpcRF4zRR/
	YCHk9wfUPbSlupkjkJO936kjHq9IZ9NbXdkVectR68GeYM1YksI4kFVZ9YsnoWsSe8GUciJ/mWNLv
	FQ6o7zn2sv3wW0ZNZ8l+KYMMh1t+9HxRTeNGZL/No2JKnctDFSxpiP+RiOxIhbqJz0l4YYPCmbBmp
	Nu4LbzKhR23ToJ71vy5LszlCO8Ef5lNuiAReM+ifN12SVdE7AJyHUChgDAqS95Ye7pTx5h2mltG4l
	09Akckmw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9eMY-0000000Fh03-0l2Q;
	Thu, 24 Sep 2026 07:59:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 31B79300756; Thu, 24 Sep 2026 09:59:25 +0200 (CEST)
Date: Thu, 24 Sep 2026 09:59:25 +0200
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
Message-ID: <20260924075925.GE4121620@noisy.programming.kicks-ass.net>
References: <20260922165445.943315-1-arighi@nvidia.com>
 <20260924075237.GH2009045@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924075237.GH2009045@noisy.programming.kicks-ass.net>

On Thu, Sep 24, 2026 at 09:52:38AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 22, 2026 at 06:51:39PM +0200, Andrea Righi wrote:
> 
> > Andrea Righi (16):
> >       sched/core: Drop mutex locks before proxy rescheduling
> >       sched/core: Dequeue waking proxy donors before reset
> >       sched/core: Mark wakeups completed through ttwu_runnable()
> >       sched: Add helper to block retained proxy donors
> >       sched: Add sched_ext hooks for proxy execution
> 
> Right, so these add:
> 
> WF_TTWU_RQ:
> 
>   Used like ENQUEUE_DELAYED; could be fixed by generalizing that to cover all
>   of p->is_blocked.
> 
> scx_allow_proxy_exec():
> 
>   Hook to kill proxy exec for scx
> 
> scx_proxy_reenqueue_retry():
> 
>   Like put_prev_task(), but for current. Ensures current gets put back on a DSQ
>   once its done running.
> 
> scx_proxy_donor_start():
> 
>   Delayed set_next_task(), confirms donor will be used.
> 
> sched_proxy_block_task():
> 
>   Almost like switching_to_scx(), except it needs to change ctx->queued in case
>   of p->is_blocked. Hence a new callback ran before sched_change_begin().

And I wonder, would something like so work?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index adcc9264c0c6..3e7691d24930 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11215,8 +11215,13 @@ void sched_change_end(struct sched_change_ctx *ctx)
 	 */
 	WARN_ON_ONCE(p->sched_class != ctx->class && !(ctx->flags & ENQUEUE_CLASS));
 
-	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
-		p->sched_class->switching_to(rq, p);
+	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to) {
+		bool block = p->sched_class->switching_to(rq, p);
+		if (block && p->is_blocked) {
+			block_task(rq, p, READ_ONCE(p->__state));
+			ctx->queued = false;
+		}
+	}
 
 	if (ctx->queued)
 		enqueue_task(rq, p, ctx->flags);
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9c1f10cf3c24..e706fb899834 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4288,12 +4288,12 @@ static void prio_changed_scx(struct rq *rq, struct task_struct *p, u64 oldprio)
 {
 }
 
-static void switching_to_scx(struct rq *rq, struct task_struct *p)
+static bool switching_to_scx(struct rq *rq, struct task_struct *p)
 {
 	struct scx_sched *sch = scx_task_sched(p);
 
 	if (task_dead_and_done(p))
-		return;
+		return false;
 
 	scx_enable_task(sch, p);
 
@@ -4303,6 +4303,8 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 	 */
 	if (SCX_HAS_OP(sch, set_cpumask))
 		scx_call_op_set_cpumask(sch, rq, p, (struct cpumask *)p->cpus_ptr);
+
+	return !scx_allow_proxy_exec(p);
 }
 
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 76f3c84ca684..23217b91db03 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -543,7 +543,7 @@ static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
 	update_curr_idle(rq);
 }
 
-static void switching_to_idle(struct rq *rq, struct task_struct *p)
+static bool switching_to_idle(struct rq *rq, struct task_struct *p)
 {
 	BUG();
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e06b34984e48..ba4c55d0a601 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2759,7 +2759,7 @@ struct sched_class {
 	 */
 	void (*switching_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_from) (struct rq *this_rq, struct task_struct *task);
-	void (*switching_to)  (struct rq *this_rq, struct task_struct *task);
+	bool (*switching_to)  (struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)   (struct rq *this_rq, struct task_struct *task);
 	u64  (*get_prio)     (struct rq *this_rq, struct task_struct *task);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 1e0109ec36b3..b7541bb7b593 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -78,7 +78,7 @@ static void task_tick_stop(struct rq *rq, struct task_struct *curr, int queued)
 {
 }
 
-static void switching_to_stop(struct rq *rq, struct task_struct *p)
+static bool switching_to_stop(struct rq *rq, struct task_struct *p)
 {
 	BUG(); /* its impossible to change to this class */
 }
