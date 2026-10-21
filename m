Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583165;
	b=ui2AuHHOQAAVSERVLK0AVG8mOAgkylVDVRVQAPN6wkhILsSjPivHaGb7hvMgSvAXdjWk
	 G8qKAnZPx/V2NEB2QZR6CG4Mr6O3Ha4Q1mVzQmIiFKaqdmb1PYTDhdDc0mhnCw0+TSqN6
	 A7h7aLklEmeVdEGGJMJ+u95igdbM1WZ368nNO98zvAAqA51kZG97ZXdrII1e5pZqvJEez
	 YirapcTJvaR/iiH+lf02V7g1Z2gzIkyRpdO14DWPzKmf5KcFoydZnSz2RghQBffsDaI2x
	 uuFZDz8LiBay7RECRshpeCIgybTKGzTUv+nUkBYWOVl+DJUUcMjoNZjmUQZkZmm3vew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583165;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ib4iPMT0LfTUqO3ZpMyOOc62M3QyvCmIbpClXTDBHYw=;
	b=1pK9+U4nnrqNd5JtpDQivGSCq6azHGvI8Ev8xYiqtz83wUhiETXfX+Pz1gcqMSXMy/NH
	 LO84a1Hol3cnH+dx2QGcFT8z+hiGCpLrZDPpLgS676L7hvuRQEZ3RXbnUoDWoTTj2CfEy
	 uAcI1gAZIlpcDQH1tW+nyhVXntC+heogOWQKbIYr/oXqs/YBpHxDIc+hQ/LQRudnNYIVA
	 pqR1jjNLIJxKKj6udiRNxzJcmNAk4dbYnWp8el7Drs1mQtu8XcqLE0XECF+ykWLar7Exh
	 VH0LXXA+GV0SmrJwzJngmT3NhxQBpjfBc1IzJ2HqcOO9Mm4+7vH+RMwTszZcmCoaKRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b="MOwqda/G";
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C2C606A31D;
	Wed, 21 Oct 2026 11:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3C2C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=MOwqda/G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ib4iPMT0LfTUqO3ZpMyOOc62M3QyvCmIbpClXTDBHYw=; b=MOwqda/G27MPDue2uFBuEgIYJF
	8aV0ECXHBaOSr8XI4H1ah62+SE6yffqHZZkGbsDUfzQSq4YbZJF5WBCIsV6fNG0qZtQUVcVDDZJ4h
	RJL6Ly58RNAHMAEl57AScH07KcaPmebn1X3tI1S2K7e6iDEcMAdWMzxSW2ic8ZyVy01RocDpZ5ZZG
	EqkrikLy5MXqhV+MMb6Dux+mPgqO36vwv0qCVDSN2NrSdL3P28uAv44HiNuzDE0zVQbLBEVaOGyfb
	aMufLNHOgL2zLuJWSprOgbTWtmbcLY8TRlCrI8vWOILXPzd8AYYlZ8YI78A4YMlQAk+1iAexFaAQ8
	82nHKrOw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xJUlZ-00000005l1Q-28vo;
	Wed, 21 Oct 2026 11:45:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D2D66300720; Wed, 21 Oct 2026 13:45:55 +0200 (CEST)
Date: Wed, 21 Oct 2026 13:45:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	John Stultz <jstultz@google.com>, Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched/core: Avoid requeueing a
 singleton balance callback
Message-ID: <20261021114555.GF2823843@noisy.programming.kicks-ass.net>
References: <20261021070535.1256337-1-arighi@nvidia.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021070535.1256337-1-arighi@nvidia.com>

On Wed, Oct 21, 2026 at 09:05:35AM +0200, Andrea Righi wrote:
> With proxy execution, __schedule() can call set_next_task_scx() with
> SNT_REPICK and then SNT_PICK for the same donor. Both calls queue the
> kick_sync balance callback while kick_sync_pending remains set.
> 
> When the callback is the only list entry, its next pointer is NULL, so
> the existing duplicate check misses it. Queueing it again links it to
> itself and causes the wait to run twice.
> 
> Also check whether the callback is already the head of the list to
> reject the second insertion.
> 
> This covers the kick_sync callback because nothing else is queued
> between SNT_REPICK and SNT_PICK. Requeueing the tail of a longer list
> remains possible and is outside the scope of this fix.

Cute.

> Fixes: e2859566ffbc ("sched_ext: Queue the kick_sync wait from set_next_task_scx()")
> Reported-by: Tejun Heo <tj@kernel.org>
> Link: https://lore.kernel.org/r/08cac02c604dd73ef96fc92eb29d692b@kernel.org
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
> Resending including Peter, this touches kernel/sched/sched.h.
> 
> Original post:
> https://lore.kernel.org/r/20261020084400.845842-2-arighi@nvidia.com
> 
> The triggering commit e2859566ffbc is only available in sched_ext/for-7.4-fixes,
> so this fix is intended for the 7.4 cycle:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git for-7.4-fixes

OK, probably best if TJ routes it then? in which case:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

>  kernel/sched/sched.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 499a5649582e7..2584d1a7f6d21 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2158,7 +2158,8 @@ queue_balance_callback(struct rq *rq,
>  	 * balance_push() is active, see the comment with
>  	 * balance_push_callback.
>  	 */
> -	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
> +	if (unlikely(head->next || rq->balance_callback == head ||
> +		     rq->balance_callback == &balance_push_callback))
>  		return;
>  
>  	head->func = func;
> -- 
> 2.56.0
> 
