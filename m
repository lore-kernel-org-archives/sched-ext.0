Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1FC2EC0B0;
	Mon, 17 Aug 2026 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987046; cv=none; b=GzPm0wHvEtVNsYF89xhfgRECPhQSEe/pQ3MAsWLH2LW3pv1cupoqKVww3iN7lxbliV9PF9+hX/oylyQg1udwmt3A6OqlhjqtWfSgcjNCHe6t7krHsFoXmHxrEmCzTKNfZ8xUeqYkcZhQ3ol1hcMwgtybUk2IhoV0SGYotmMVtGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987046; c=relaxed/simple;
	bh=UcYbJd4LXmIHJQw7CqNpwOu83Cs/su9edC6nYFeMMEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klQVVmgKT8gcwSe+EasDdowiyfiqk37Q0MK5TUmQQ+jba3/AkDvPeimPQMDf0mg34DEjtO30Q+viJwfyfdlM4kwdAKrxs1FQgwv4ZpGcX9LwltL2orgubOkY28W/JsL2slgfEZWLjkh9nBDzF9PqEklxBifov81564VkzRsdflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vk/frS+b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vk/frS+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619F51F000E9;
	Mon, 17 Aug 2026 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786987044;
	bh=mymbQLXdVRVl3EdK2zZha/SVJSzKrSpEaXZmxRwThLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vk/frS+bFz4rrCfwxw73WoULfMb4vlYlOimZJzu3xzm9eodhlHsKhhmwTB9V9yn5b
	 49nPN4A+Ji9fTV1UMo2bUh7Xi6jK+u9FeoNab22eEIbSPS68Ln/03wLZwCU6dNVD41
	 yMbU5fz6aMRYr5yKYYgHUf4X6Fvsx1h1G0G9xLDqZWZdrJZ0Vkxk1uT4FBoW0E8IGY
	 B4roiH4zwgK4TThUjgudOACvIhzcPmnJRMaMgASlsL15KQLsGEvQAty4Cotj/dvntj
	 ARvIVkVKiEYX+NLdFX2JORKr2yrFOiOVSfejxJkc8IXTqNk7sGNwJGApb4M/sHzmaC
	 0GRU7oGVNrTmg==
Date: Mon, 17 Aug 2026 07:17:23 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/17] sched_ext: Handle proxy-exec races in remote DSQ
 transfers
Message-ID: <aoNCIwlkVXKNgM5l@slm.duckdns.org>
References: <20260816173732.17162-1-arighi@nvidia.com>
 <20260816173732.17162-13-arighi@nvidia.com>
 <aoJNrhYq_MjO1bDb@slm.duckdns.org>
 <aoK1Ck67oyhysjQD@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoK1Ck67oyhysjQD@gpd4>

Hello,

On Mon, Aug 17, 2026 at 09:15:22AM +0200, Andrea Righi wrote:
> > > @@ -1530,12 +1539,17 @@ static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
> > >  	call_task_dequeue(sch, rq, p, 0);
> > >  
> > >  	/*
> > > -	 * Only local inserts get the wakeup treatment below. Rejects kick the
> > > -	 * deferred reenq and rescue parks are paced by the rescue timer.
> > > +	 * Only local inserts get the wakeup treatment below. Proxy-active tasks
> > > +	 * and rescuees remain parked until their respective resolution paths.
> > > +	 * Other rejects can be reenqueued immediately.
> > >  	 */
> > >  	if (unlikely(dsq->id != SCX_DSQ_LOCAL)) {
> > > -		if (dsq->id == SCX_DSQ_REJECT)
> > > +		if (dsq->id == SCX_DSQ_REJECT) {
> > > +			if ((p->scx.flags & SCX_TASK_REENQ_REASON_MASK) ==
> > > +			    SCX_TASK_REENQ_PROXY)
> > > +				rq->scx.flags |= SCX_RQ_PROXY_REENQ;
> > 
> > and if my reading above is correct, this wouldn't be necessary, right?
> 
> The flag isn't needed to provide the post-switch ordering, but it is needed to
> record that reject_dsq still needs another drain.

But wouldn't it be able to use the same schedule_deferred_locked() call like
SCX_DSQ_REJECT case so that the PROXY_REENQ flag is only used for retry
cases (and maybe renamed accordingly)?

...
> It also preserves the outstanding drain if proxy re-pick calls
> zap_balance_callbacks() before the initially queued callback runs. In
> that case, the task is already parked on reject_dsq, but the flag lets
> scx_proxy_resolved() queue replacement deferred work.

I think this is a generic problem with core scheduling. SCX assumes that
deferred scheduilng always runs but core-sched can zap them. We probably
need to address this directly using a similar but generic deferred work
pending flag.

> > > +{
> > > +	lockdep_assert_rq_held(rq);
> > > +	WARN_ON_ONCE((p->scx.flags & SCX_TASK_REENQ_REASON_MASK) &&
> > > +		     !(enq_flags & SCX_ENQ_REENQ));
> > 
> > In the previous patch, is it possible to clear reason before reenqueueing
> > it and get rid of overwrite cases or does that quite not work out?
> 
> Yes, I think we can get rid of the overwrite cases. There is one constraint,
> though: the reason must remain set while ops.enqueue() runs, because BPF reads
> it from p->scx.flags.
> 
> I'll move the clearing into scx_do_enqueue_task() so that it happens immediately
> after ops.enqueue() returns and before resolving any direct dispatch requested
> by the callback. A rejection caused by that new placement will then see a clear
> reason field and can set its own reason without overwriting the previous one.

I haven't really thought through it so please do whatever that makes the
code least ugly.

> > > @@ -2633,6 +2719,19 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
> > >  
> > >  	if (dst_dsq->id == SCX_DSQ_LOCAL) {
> > >  		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
> > > +		/*
> > > +		 * Unlike the rq-lock handoff paths, @src_rq has been locked
> > > +		 * throughout this operation. Only active proxy state can race the
> > > +		 * move here; let the enforcing check below diagnose an ordinary
> > > +		 * migration-disabled task.
> > > +		 */
> > > +		proxy_raced = src_rq != dst_rq && task_proxy_move_active(p);
> > > +		if (unlikely(proxy_raced)) {
> > 
> > I don't know what bouncing through the local var buys. Out of curiosity, if
> > task_move_proxy_raced() is used here, does something break or is it just to
> > avoid unnecessary tests?
> 
> Yeah, the local variable doesn't buy anything, I'll remove it.
> 
> Using task_move_proxy_raced() (aka task_proxy_unsafe_to_move() after the rename)
> would change the behavior for an ordinary migration-disabled task. This path
> holds src_rq, so that state isn't a lock-handoff race and should still reach
> task_can_run_on_remote_rq(..., true), which diagnoses the invalid BPF-directed
> migration. Treating it as a proxy rejection instead could hide that error and
> cause repeated reenqueues.

That sounds like something which is worth noting in the comment. It's subtle
that this site needs a different set of conditions.

Thanks.

-- 
tejun
