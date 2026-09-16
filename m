Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0332931C7
	for <sched-ext@lists.linux.dev>; Wed, 16 Sep 2026 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585639; cv=none; b=nLTJPhC5QZmgH/nRFnmtrV7By8zAYVkw6JOkyIIbzj3SezW2r69+UmqXAKob9cidFcXZhyYazuaoEAjRy9dtto9ANK6x0osjGwtUMxr+xxyPlG27FFOeK0LZSuMhsz20uid2EbFJrNjRXe5wb3nmwippT+F07IK6OgIvAKWFsVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585639; c=relaxed/simple;
	bh=6vepIx7Wn3Cy0YUG+bfeq8eP/V5gOOxJlhrvIIkclK8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KPNVcxkSG/VWqaKUOwRUID/iYG2AWBfgIMWMRGaMoab07l0zK0AsvYCq8y4jEdESMvBedG/Gv3KsQXjARUSb6xwtLfZD0UJnSyhC1M9MHDsYjqCnejAaQduZoQ1cLOS+j5aTCgeDYJYUbulofaa+/MGjNX+JXRlWzogYLrTH5TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=H3jbGfV3; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="H3jbGfV3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1789584116;
	bh=6vepIx7Wn3Cy0YUG+bfeq8eP/V5gOOxJlhrvIIkclK8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=H3jbGfV3tN4x0QDxLPIgV/e1HAMGiMyuGYKZgYIgfefZkJAZSjp+dQ4zlmPOK6VLH
	 I4GBKLBQHAFepdrGnHd04Nci30ho0rPQOu+SKAV9Xwq7JW/N99/+Cu3uX5C5eLO7xk
	 FPAUH6AKw1TOgI2zh03xiD6ce+uSxv9qLLgQLK00=
Received: by gentwo.org (Postfix, from userid 1007)
	id 0D2F7401C8; Wed, 16 Sep 2026 11:41:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 090184010E;
	Wed, 16 Sep 2026 11:41:56 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:41:55 -0700 (PDT)
From: Shubhang <sh@gentwo.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, Ingo Molnar <mingo@redhat.com>, 
    Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
    Vincent Guittot <vincent.guittot@linaro.org>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, 
    Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
    Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
    K Prateek Nayak <kprateek.nayak@amd.com>, 
    Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
    Christoph Lameter <cl@gentwo.org>, Tejun Heo <tj@kernel.org>, 
    David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
    Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
    sched-ext@lists.linux.dev
Subject: Re: [PATCH v3] sched: Restart fair hrtick after same-task repicks
In-Reply-To: <20260916032150.487242-1-zhanxusheng@xiaomi.com>
Message-ID: <53a32262-4391-ffa0-3391-3772505739b2@gentwo.org>
References: <20260915-sched-fair-hrtick-restart-v3-1-7517f388f0c8@gentwo.org> <20260916032150.487242-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Zhan,

Thanks for the review and testing. Yes, skipping 
put_prev_task_*() does not distinguish fair from DL.

For fair class, pick_task_fair() calls update_curr_eevdf() before 
selecting the current task again. This refreshes the task entity used 
by hrtick_start_fair(), including with group scheduling. When that update
observes an expired slice, it advances the entity's virtual deadline 
before hrtick_start_fair() computes the next expiry.

pick_task_dl() has no corresponding picker-side runtime update, so
p->dl.runtime can be stale on SNT_REPICK.

I will clarify this in the changelog, add a comment on the fair repick 
path, and document the SNT_NORMAL and SNT_PICK meanings.

I also rebuilt with CONFIG_SCHED_CLASS_EXT=y and it compiled
cleanly on my side.

Thanks,
Shubhang Kaushik

On Wed, 16 Sep 2026, Zhan Xusheng wrote:

> On Tue, Sep 15, 2026 at 06:13:18PM -0700, Shubhang Kaushik (Ampere) wrote:
>> Do not restart the DL hrtick for SNT_REPICK. put_prev_task_dl() is
>> skipped for next == prev, so dl_se->runtime may be stale.
>
> put_prev_task_fair() is skipped for next == prev too, so as written this
> reason applies to fair as well.
>
> What separates them is that rq->cfs.curr holds the task entity rather
> than the root-level one, so pick_task_fair()'s update_curr_eevdf()
> refreshes exactly the entity hrtick_start_fair() reads, group scheduling
> or not.  pick_task_dl() has no counterpart.  update_deadline() then exits
> with deadline > vruntime, which is what keeps the repick out of
>
> 	if ((s64)vdelta < 0) {
> 		if (task_current_donor(rq, p))
> 			resched_curr(rq);
> 		return;
> 	}
>
> That branch arms nothing, and __schedule() clears TIF_NEED_RESCHED just
> after pick_next_task(), so a repick reaching it would come out with no
> preemption point at all, which is the state you are fixing.  Two lines in
> the changelog, or a comment at the repick label, would stop that
> invariant from being broken silently from three functions away.
>
>> +enum snt_e {
>> + SNT_NORMAL,
>> + SNT_PICK,
>> + SNT_REPICK,
>> +};
>
> Three values, six classes reading them, no comment.  SNT_REPICK explains
> itself; NORMAL versus PICK does not.  At the call sites they mean
> "through set_next_task()" and "the running task changed".
>
> I checked the conversion with the compiler rather than by grepping:
> reverting any one class to bool fails on the incompatible function
> pointer, and rt, stop, fair, idle and deadline build W=1 clean.
> ext/ext.c I could not compile, SCHED_CLASS_EXT wants DEBUG_INFO_BTF and
> pahole is broken here.  first is unused in set_next_task_scx()'s body so
> the rename is safe, but someone with BTF should build it.
>
> Booted 4 CPUs, HRTICK on, four spinners under panic_on_warn=1: clean.  I
> did not reproduce the latency numbers.
>
> Reviewed-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
>
