Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1199392825
	for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971542; cv=none; b=VGY+VEMIgK3vtxpPz6s5OL+XPmXXGT/wFE5vpEg9E5SHJe8yIm+/jo6xnrTcqUdK8RsQ4jg3YFhDziyKOP+jg7Fh5nwT4GhP0QGxkabD4Rt68mVKGZflrmoE9F47y0gdN49q8epqbRk5oREHCrPtGX6bKZDPw831SoLJn7MOBN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971542; c=relaxed/simple;
	bh=Ynuarxho7dbXEjFCU4Qbo+DBCHiq0RRfaHAXB2lk+P0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BvADN1/Nv4ue77MKgJXx5g4DuE2HTEUdgWZZ1sXw9Gp1AUZPBxS8B6YI+bZrWf4eaY9ldZN6bVdGkRbSuejGTSCya4Dsp3njWDdBI8mniz1yR4DMOR4WopucyYoAFf5UoDekQs5CLoAVo6/TC8WuTlWnA8xKVLUKgowMjiT0b5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=saqPi3RO; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="saqPi3RO"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488f973ddfeso53527085e9.3
        for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776971539; x=1777576339; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aVua60xrwR/dQ0PGs66L9Kb497eWff2wlz8NKw9/BJY=;
        b=saqPi3ROsW1ucMye8cpqWz/HakWfQwUyeEdAGCaVkzM5uT2AABUKHkjtiJs3n7vTio
         R7QRt+IqEt8nvPHRL8oA+7ZrtwQcfN1g5scc8TuLPsmgKL9ntZ2/c9/kB6sCw7reBwCB
         YnY/BSt8HaLc9GR4Y9nXCEHeDLiZ3+tOy5CaAyzjahavShdVDsAllyJH7PvkkDUSoD85
         kHozLAWgVyr+HDRJTNAYwC0hwibszsNsdgZLFYW69Yhu+szAtw/VUv0rk6mAo3ed5R/9
         hkuWeiLPVYlfy4xgaXi6zH5p0aQkWCf1OkQ3gWCbnblc4uDZPtan2g1zTrBOWcj5uuLs
         Ozcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776971539; x=1777576339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVua60xrwR/dQ0PGs66L9Kb497eWff2wlz8NKw9/BJY=;
        b=BGnUEQ75zKn9d9rHw3iHmPOCGX7ndRbJygiGpUxITaSbGoBS7iubxambsj3ZtVw8Cg
         j7O8ft8sIMAZ9OuG7IFvJ9AzGWQlb0IMlKpViUNcWTdFFfFnE5FIY3ja5X75ioGZD0h9
         7Hjo490+7hOeROdBB93hvwJk64n5M7QD3geSSiSItaw1j+x2+cldiaW1EFJlFamK3Zar
         UeIj0zKeFNmKEthfUl89qyU6OmDAsTZGNAT6bkf3V7Xx+hO+XNKq729YWaUQBP8rW7rB
         ne2Pv8Uatg4DcVbupE5RGVJK1BcDSXsqPMegoYVNL6fUjjnNxu7SNxsJKunnLAqTGGRW
         FBBg==
X-Forwarded-Encrypted: i=1; AFNElJ/rZmKW91+N/hCMn1qI3nooeWZbre+aW3GjR9q9mQN6vBtIKhqxlSZifw5XsLZfqlaaplGsRurTnbk=@lists.linux.dev
X-Gm-Message-State: AOJu0YyYX2gY4eV0mDRHa8bD92dRWfXoSR7GldsQhR7HshzVdfcNzdne
	+XexkgJKVz8KDelmFkNUe/li5vo8Jm7DOKujxVhwMISNVRDk29ebE2yBQX69mz5STP4yvq2nm4Z
	ULYm6XX3ppRt6tQ==
X-Received: from wrpy7.prod.google.com ([2002:adf:f6c7:0:b0:441:2008:76f1])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2284:b0:43d:7377:8772 with SMTP id ffacd0b85a97d-43fe3e25982mr44778383f8f.46.1776971539255;
 Thu, 23 Apr 2026 12:12:19 -0700 (PDT)
Date: Thu, 23 Apr 2026 19:12:18 +0000
In-Reply-To: <ad24a49fd02d7b397976975a13767bb4@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <DHZPHUFXB4N3.2RY28MUEWBNYK@google.com> <aej8cmhZVhsqogr4@slm.duckdns.org>
 <DI0FTX13UW17.1IZJ9TMG9EFRA@google.com> <ad24a49fd02d7b397976975a13767bb4@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DI0RERGK9HKZ.Y3HZ3N7J3RJY@google.com>
Subject: Re: SCX_ENQ_IMMED potentially leaving dispatched tasks lingering on
 local DSQs
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>, <linux-kernel@vger.kernel.org>, 
	<sched-ext@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu Apr 23, 2026 at 4:53 PM UTC, Tejun Heo wrote:
> Hello,
>
> On Thu, Apr 23, 2026 at 09:48:11AM +0000, Kuba Piecuch wrote:
>> I'm not sure if we should limit ourselves to just remote tasks.
>> If we call wakeup_preempt(rq, p, flags) when adding @p to @rq's local DSQ
>> regardless of whether @p/@rq is remote, then I think that should cover all
>> cases and the patch above wouldn't be needed.
>
> Sorry, I wasn't clear. I meant adding wakeup_preempt() in
> move_remote_task_to_local_dsq() *in addition to* your nr_immed/RETRY_TASK
> patch. That combination covers both cases:
>
> - Local (your stepwise scenario): the task stays on the dispatching CPU, no
>   migration happens, so there's no insertion-side hook to arm. Your nr_immed
>   check in do_pick_task_scx() catches it on the RETRY_TASK path.
>
> - Remote: move_remote_task_to_local_dsq() is SCX's analog of
>   move_queued_task() and is missing the wakeup_preempt() call that
>   move_queued_task() does after activate_task(). Once added,
>   dst_rq->next_class is bumped to &ext_sched_class, and any subsequent
>   higher-class wakeup on dst_rq routes through wakeup_preempt_scx() which
>   already has the nr_immed reenqueue.

There's another case we need to handle: dispatching to a remote CPU's
local DSQ, but without migrating the task. In dispatch_to_local_dsq()
this corresponds to rq != src_rq && src_rq == dst_rq. The check for the local
case on the remote CPU doesn't cover it because an RT task can swoop in and
prevent pick_task_scx() from running (the assumption is that the remote CPU
is idle).
The check for the remote case doesn't cover it either because we do
dispatch_enqueue() directly from dispatch_to_local_dsq().

Then there's the same case, but instead of dispatching we're moving the task
from a user DSQ. If my understanding of the code is correct, the path is:

  scx_dsq_move(p, dsq_id);
    raw_spin_rq_unlock(this_rq);
    raw_spin_lock(src_rq);
    dst_dsq = find_dsq_for_dispatch(dsq_id);
    move_task_between_dsqs(p, src_dsq, dst_dsq);
      dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
      task_unlink_from_dsq(p, src_dsq);
      move_local_task_to_local_dsq(p, src_dsq, dst_rq);

I think these two cases show that we don't necessarily have to migrate a task
for wakeup_preempt() to be warranted.

So to cover all cases (that I'm aware of), we need four checks:

* wakeup_preempt() in dispatch_to_local_dsq() in the case of rq != src_rq &&
  src_rq == dst_rq

* wakeup_preempt() at the end of move_remote_task_to_local_dsq()

* wakeup_preempt() somewhere on the scx_dsq_move() path, but only if we're
  moving the task to the local DSQ of a remote CPU (?)

* nr_immed check before returning RETRY_TASK

>
> Adding wakeup_preempt() to local_dsq_post_enq() for every insertion would
> work too, but I'd rather keep it in sync with how core sched handles
> move_queued_task() and only add it where it's actually needed.

Does having four separate cases to handle, not all of which involve task
migration, change that calculus somewhat?
I believe all of these cases will be handled if we add wakeup_preempt()
to local_dsq_post_enq().

Thanks,
Kuba
