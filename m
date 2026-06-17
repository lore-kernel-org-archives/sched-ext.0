Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7A530DEB5;
	Wed, 17 Jun 2026 03:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781666697; cv=none; b=Y7M2fthw3qqO7A7vcQViFqwHuHvQsDiRjXgI686VA8/6oh22OgWOWZxsBOtkITDe8GdTsF9yM9/omXx0RsMxery6DoiFGuoi1mur2BA4w9eTMl+7N+xdHvGiuex5RdKDPr7gwiLqjdksvgesKfRaX3+Kxuqs0fEJpDhlcnzGEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781666697; c=relaxed/simple;
	bh=PhQtVTugvJgOpOvwkkJRV019Jkl0cc8hcbaUwDN99Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWUsb3v4CbME5gdbAXpRxarN97fie7PMBNp6eNJYvihCgT62KM+kTOiW0A1lZpkYUB9jw2T49Jmso3+TX51l3LmNT7ZryhWKBebq/kxoU+vCwYu3BuudfG2Yx4z4C0SLOzk5rvjEmt4ITV0yxuQGiNj1x4BAicQlW1aWqgzxtLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap21GvqQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap21GvqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14991F000E9;
	Wed, 17 Jun 2026 03:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781666695;
	bh=S7XLPItq41+fyRMiy+YilbTowXoFASrVVGWE7I23hwU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ap21GvqQi2/DBRnOPvqg7tdMKoTG8rj5Vh95b1iA9wgfspuH3OAUg8yBIpzH9M1Gg
	 Q/ZFMiDFAwnzjK7DD37KOHXAlAYRcbZ4ioVrdq1zdx+XWLtui33GbCHJel9odneHHi
	 0F0QBRzIHgf/CgA0zAQ+uEHEcQlqKyJdi8rREKBo2SKLlPifI+0lL6IyNWSdGnrGur
	 Kjska5C+/wbVvNHuczpJQ7nJXS6oZ16IVk+kU6pTBGGYy/9v8VqEAcaUCppTpcYgDc
	 FQCVAMKfXBb0qe4y7fWZHxrXlcG2ZoqVFd/MeG/Gsfy4nnoOajVZ2+KV5Z+/Gw/9fT
	 FImNBJx+ysCcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 96082CE03CE; Tue, 16 Jun 2026 20:24:55 -0700 (PDT)
Date: Tue, 16 Jun 2026 20:24:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: sched_ext/lavd hard lockup in old call_rcu_tasks_generic
 needadjust path
Message-ID: <35337ded-add4-4689-8f61-73f583a69b36@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260609104733.1184001-1-mfleming@cloudflare.com>
 <2179fc11-3bd5-4d2e-9ad8-609e3356ec09@paulmck-laptop>
 <aiqxpzgl2YVVSARw@matt-Precision-5490>
 <1ad83f53-7897-40bc-a503-5a71031aa27f@paulmck-laptop>
 <aivaGbCzC4oaD05n@matt-Precision-5490>
 <3bbd4298-eb01-4784-bee5-caab3d3647b9@paulmck-laptop>
 <ajErr_GEejCD7n47@matt-Precision-5490>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajErr_GEejCD7n47@matt-Precision-5490>

On Tue, Jun 16, 2026 at 11:56:19AM +0100, Matt Fleming wrote:
> On Fri, Jun 12, 2026 at 07:00:31AM -0700, Paul E. McKenney wrote:
> > 
> > Huh.  Looks like I did not implement RCU Tasks Trace in terms of SRCU
> > any time too soon.  But there is also RCU Tasks and RCU Tasks Rude.
> > 
> > If we don't backport the SRCU patches, then the obvious alternative is
> > for call_rcu_tasks*() to defer to IRQ work when invoked with interrupts
> > disabled.  Or is there a better way?
> 
> What about something like this?

Not bad, actually.

But we are going to have to similarly bypass call_rcu_tasks_generic()
soon enough, though only when interrupts are disabled at the time
of the call.  One complication is that it would need to interact
with rcu_barrier_tasks_generic(), which would need to remove any
pending callbacks from bypassed call_rcu_tasks_generic() invocations,
as in llist_del_all() and enqueue the callbacks.  A well-placed
raw_spin_trylock_rcu_node(rtpcp) should suffice for the serialization.
The trick is that rcu_barrier_tasks_generic() is not obligated to
wait on later calls to call_rcu_tasks_generic().

Is this something that you would be interested in digging into?

						Thanx, Paul

> ----8<----
> 
> >From 6b2dc5002f3413f4f89eb1735259d065b7003a52 Mon Sep 17 00:00:00 2001
> From: Matt Fleming <mfleming@cloudflare.com>
> Date: Mon, 15 Jun 2026 11:19:43 +0100
> Subject: [PATCH] rcu-tasks: Defer callback queue adjustment to irq_work
> 
> call_rcu_tasks_generic() can run from BPF task-storage teardown while
> sched_ext still holds rq->lock. The RCU Tasks kthread can concurrently
> hold cbs_gbl_lock while printing under it, then wake a task on the same
> rq while the caller waits for cbs_gbl_lock.
> 
> Queue the adjustment through irq_work instead. This keeps callback
> enqueueing synchronous while moving cbs_gbl_lock acquisition out of the
> caller context.
> 
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
> ---
>  kernel/rcu/tasks.h | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 2dc044fd126e..92aead9fc200 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -104,6 +104,7 @@ struct rcu_tasks {
>  	unsigned long n_ipis;
>  	unsigned long n_ipis_fails;
>  	struct task_struct *kthread_ptr;
> +	struct irq_work cbs_adjust_irq_work;
>  	unsigned long lazy_jiffies;
>  	rcu_tasks_gp_func_t gp_func;
>  	pregp_func_t pregp_func;
> @@ -129,6 +130,7 @@ struct rcu_tasks {
>  };
>  
>  static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
> +static void call_rcu_tasks_iw_adjust(struct irq_work *iwp);
>  
>  #define DEFINE_RCU_TASKS(rt_name, gp, call, n)						\
>  static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
> @@ -144,6 +146,7 @@ static struct rcu_tasks rt_name =							\
>  	.call_func = call,								\
>  	.wait_state = TASK_UNINTERRUPTIBLE,						\
>  	.rtpcpu = &rt_name ## __percpu,							\
> +	.cbs_adjust_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_adjust),	\
>  	.lazy_jiffies = DIV_ROUND_UP(HZ, 4),						\
>  	.name = n,									\
>  	.percpu_enqueue_shift = order_base_2(CONFIG_NR_CPUS),				\
> @@ -342,6 +345,24 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
>  	rcuwait_wake_up(&rtp->cbs_wait);
>  }
>  
> +static void call_rcu_tasks_iw_adjust(struct irq_work *iwp)
> +{
> +	unsigned long flags;
> +	bool expanded = false;
> +	struct rcu_tasks *rtp = container_of(iwp, struct rcu_tasks, cbs_adjust_irq_work);
> +
> +	raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
> +	if (rtp->percpu_enqueue_lim != rcu_task_cpu_ids) {
> +		WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
> +		WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
> +		smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
> +		expanded = true;
> +	}
> +	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> +	if (expanded)
> +		pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
> +}
> +
>  // Enqueue a callback for the specified flavor of Tasks RCU.
>  static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  				   struct rcu_tasks *rtp)
> @@ -389,16 +410,8 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  		rtpcp->urgent_gp = 3;
>  	rcu_segcblist_enqueue(&rtpcp->cblist, rhp);
>  	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> -	if (unlikely(needadjust)) {
> -		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
> -		if (rtp->percpu_enqueue_lim != rcu_task_cpu_ids) {
> -			WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
> -			WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
> -			smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
> -			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
> -		}
> -		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> -	}
> +	if (unlikely(needadjust))
> +		irq_work_queue(&rtp->cbs_adjust_irq_work);
>  	rcu_read_unlock();
>  	/* We can't create the thread unless interrupts are enabled. */
>  	if (needwake && READ_ONCE(rtp->kthread_ptr))
> -- 
> 2.43.0
> 
