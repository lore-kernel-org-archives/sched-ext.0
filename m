Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E264B3FE652;
	Wed, 14 Oct 2026 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792006425; cv=none; b=d1NqRAf0gfZqUw1I5u3Z5gg4tPERyy9+vdOIxKcj44AEEITD2FlX1noE+EmSCPKfvPxaUVyMahq0LYPbA3JzjpYbm4pwMrHyyL9QBd4nDrt+RrthuoLwcJvzErDX0xZiW8Hz7oyHpvbvY/+E2VpRzg3OPp/jR+RZLaxKx6inHp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792006425; c=relaxed/simple;
	bh=XmjpIftOllQP+4b6YQ88bUqmAgQQv5SQuAmp1RtZ8H0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=AW1NlATHUjzIvgWYbUgxzFnzbgpnmwsZ/MQYM0aYLY/SfNL17bB8WjtwSEkrYz3gmVV2SqFS1Ea6aFLFlWXZtjt7htRY03HQgXdk52vxHkPNJcOBM3n1dix2hXQbgPDpKOnBaD9wXU50s+uwG/c9fgh75jB4Vd5a7vJZ5x3S16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM0rdc1C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM0rdc1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3341F000C4;
	Wed, 14 Oct 2026 19:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792006424;
	bh=CLF1Hin70DsNxYT74h0UKVlH8ywwZoBooSZuHQnY+pE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EM0rdc1CX3s4KCsbb+RNZaCij4asx9v69QZWBEqudwd+JCdRNkHiBuC5n6ijzbhk1
	 /3Hmkr8FCFuQ8a+RVtr14nL2uZvap3DDMaBRmT/YHGI6CWkwRJ9HIRwbd1wmqF/7Dc
	 U4xX3PY+9xvWVAJkGi7rsvWfJ08RjDT+af4lPvnArgaQzHDSyqQdy1C4jmXHYfhjcD
	 bTPIOR7Sn4ATffdlAFvDuQ5KHcgO7Uo9v1hNjnSQZO6K43U74UycxlCi7bdKhRM5L+
	 IxzELsVuz2qgFoAqYOIH72xcBOJZNz/ZIaZX//b1UX9tfq65KwqjvUNCfHzm21mRmi
	 2QDWJ8NqO0vhg==
Date: Wed, 14 Oct 2026 09:33:43 -1000
Message-ID: <2fab939d8ebe56a64bbd0061715b227e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Don't leave balance callbacks queued across a pick retry
In-Reply-To: <20261010095208.276806-1-arighi@nvidia.com>
References: <20261010095208.276806-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Sat, Oct 10, 2026 at 11:52:08AM +0200, Andrea Righi wrote:
> @@ -3311,18 +3311,6 @@ static enum scx_dsp_verdict dispatch_pick(struct rq *rq, struct rq_flags *rf,
>  	rq_unpin_lock(rq, rf);
>  	verdict = dispatch_one(rq, prev);
>  	rq_repin_lock(rq, rf);
> -	maybe_queue_balance_callback(rq);

The comment above dispatch_pick() still says it queues the follow-up work.
Can you update it?

> @@ -3349,16 +3337,8 @@ static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_flags *r
> ...
>-	if (cpu_of(rq) == smp_processor_id()) {
> -		maybe_queue_balance_callback(rq);
> ...
>-	} else if (unlikely(rq->scx.flags & SCX_RQ_BAL_CB_PENDING)) {
> +	if (cpu_of(rq) != smp_processor_id() &&
> +	    unlikely(rq->scx.flags & SCX_RQ_BAL_CB_PENDING)) {

This isn't new, but under core scheduling, a local pick that returns a task
isn't final either. If the task has a cookie or the core needs a sync,
pick_next_task() goes on to pick the siblings. A sibling's dispatch can then
drop the core lock with the local rq's callbacks queued, and any CPU pinning
the local rq in that window hits the same warning. A sibling's RETRY also
restarts the selection with the callbacks still queued.

This can be a separate patch. Maybe something like:

1. Always punt the deferred work to irq_work for core picks, local and
   remote. The remote branch here runs run_deferred() in place, which can
   drop the lock and force a restart by itself.

2. The kick_sync wait can't go to irq_work. However, every lock drop during
   a core selection comes from an scx dispatch and already forces a restart
   through lock_drop_seq. dispatch_core_pick() can unlink this CPU's
   kick_sync_bal_cb before dispatch_one() and set kick_sync_pending again.
   If the lock wasn't dropped, the callback goes back right away. If it was,
   the restarted local pick queues it again. This needs a small helper next
   to queue_balance_callback() to unlink an entry.

> +static void pick_queue_balance_callbacks(struct rq *rq, bool final)
> +{
> +	lockdep_assert_rq_held(rq);
> +
> +	if (cpu_of(rq) != smp_processor_id())
> +		return;
> +
> +	if (!final) {
> +		if (rq->scx.flags & SCX_RQ_BAL_CB_PENDING) {
> +			rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
> +			schedule_deferred(rq);
> +		}
> +		return;
> +	}
> +
> +	maybe_queue_balance_callback(rq);
> ...
>+static struct task_struct *
> +do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
> +{
> +	struct task_struct *p = __do_pick_task_scx(rq, rf, force_scx);
> +
> +	/* after a NULL pick from the dl_server the lower classes still pick */
> +	pick_queue_balance_callbacks(rq, p != RETRY_TASK && (p || !force_scx));
> +
> +	return p;
> +}

Can we fold pick_queue_balance_callbacks() into do_pick_task_scx() with a
single exit, instead of splitting out __do_pick_task_scx()? The tail can
then be an if/else. Something like:

	if (verdict == SCX_DSP_RETRY) {
		p = RETRY_TASK;
		goto out;
	}
	...
out:
	if (cpu_of(rq) != smp_processor_id())
		return p;

	if (p != RETRY_TASK && (p || !force_scx)) {
		maybe_queue_balance_callback(rq);
		...
	} else if (rq->scx.flags & SCX_RQ_BAL_CB_PENDING) {
		rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
		schedule_deferred(rq);
	}
	return p;

Thanks.

-- 
tejun
