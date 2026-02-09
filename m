Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140D638884A;
	Mon,  9 Feb 2026 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770657810; cv=none; b=qHLGtdXjZCbqw0LtIB70iePyBbAUs23mEuE3XHwj6cpHH5JYBMuI1U9r63M6ubyE2tTRywXfI9IUqa72g2pnGxHrXlPrDM47mRll/B/8T9YgoCNbt7wrzpXsVphPFwl9ck5QFiY0cS06wv9IgjVRqKRsWSSAzaX8iPPTyTGX1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770657810; c=relaxed/simple;
	bh=DccDVQmCDmi/GXwQ/U0xEE+66o6D0VpgjrF35zMMgZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDF5zGDgAunOd41++jAuOZnJC8ESWh82Axn+HYnQHjtYuJPVRp1bbbYrCVxiBMcluayDHvxdnTeBOC+cA25g3Jmqf2BGl1ebEpEzDJCbKJYsrXLOP1L1i5XQpmSzYLbC3OgxDM3UnEEFe5OZCgU7PNgtoPMIOGmTvsbthKK5GeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flhBQKdO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flhBQKdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958E3C116C6;
	Mon,  9 Feb 2026 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770657809;
	bh=DccDVQmCDmi/GXwQ/U0xEE+66o6D0VpgjrF35zMMgZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flhBQKdOjiEOkL6rMPZ+SNJn3ystjzB3D2CIiKPbwKMMl38Nt6joVQ5PIgM6Oz4d6
	 Dx1D5pOHl8PUy3E4zZHtbvisDFeAyyvblxXCWk95TTHymiY4HTbOjWqR7fFR4UTtMt
	 MfGpfJarOKl/uq9r22PyZIqiJseq4kId0Y5zZw72Xgp4fa9187KAg3vIfOLkejizh6
	 lWJxgxqhPU0amB81omWCtJFIdizNF8yl8hA0KJoI6UQzDZSahhXehQDLfxSeFmERqw
	 n/9jLUR0uwg8MBFhyiWc8Ts4r5H42aHhacjEo1cvf6A+xECdUTE8jv9XNWdF8T96OO
	 WK1X2ZT5ls8Yg==
Date: Mon, 9 Feb 2026 07:23:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
Message-ID: <aYoYECCY_k1IrGqp@slm.duckdns.org>
References: <aYcC_aKj_tO62rXZ@gpd4>
 <DG9BLVVE2TJQ.381PKRLX41AM2@etsalapatis.com>
 <aYhRKbkHf-or9lNO@gpd4>
 <aYhkv2K99aqiuwr5@gpd4>
 <aYiVv998mfMGVMCq@gpd4>
 <DG9RY7Y4VMWB.2IL8Y6Z4P5IA8@etsalapatis.com>
 <aYjtOQP0tmGIqoOM@gpd4>
 <aYm00oHl3BRWNFFA@gpd4>
 <DGAIRREHTBTV.E8XTJPHQUAN8@etsalapatis.com>
 <aYoAmES8tKNZJkdx@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYoAmES8tKNZJkdx@gpd4>

Hello,

On Mon, Feb 09, 2026 at 04:43:20PM +0100, Andrea Righi wrote:
> > I agree with going with option 1. 

I think this is the only way. The only reason this is a bit murky is because
we allow direct dispatching from ops.select_cpu() but if you look at how
that's implemented it doesn't really bypass enqueue path. The task still has
to enter the enqueue path (as that's when the rq lock is grabbed and task
state can be updated) while already knowing what to do in the enqueue path.
I don't think it make sense to consider a task to be in the BPF sched's
custody before it has passed through enqueue. Note that you can't even set
the flag - the flag field is protected by the task's rq lock.

> > For the select_cpu() edge case, how about introducing an explicit 
> > kfunc scx_place_in_bpf_custody() later? Placing a task in BPF custody 
> > during select_cpu() is already pretty niche, so we can assume the 
> > scheduler writer knows what they're doing. In that case, let's let 
> > _them_ decide when in select_cpu() the task is considered "in BPF". 
> > They can also do their own locking to avoid races with locking on 
> > the task context. This keeps the state machine clean for the average
> > scheduler while still handling the edge case. DYT that would work?
> 
> Yeah, I was also considering introducing dedicated kfuncs so that the BPF
> scheduler can explicitly manage the "in BPF custody" state, decoupling the
> notion of BPF custody from ops.enqueue(). With such interface, a scheduler
> could do something like:
> 
> ops.select_cpu()
> {
>         s32 pid = p->pid;
> 
>         scx_bpf_enter_custody(p);
>         if (!bpf_map_push_elem(&bpf_queue, &pid, 0)) {
>                 set_task_state(TASK_ENQUEUED);
>         } else {
>                 scx_bpf_exit_custody(p);
>                 set_task_state(TASK_NONE);
>         }
> 
>         return prev_cpu;
> }
> 
> On the implementation side, entering / leaving BPF custody is essentially
> setting / clearing SCX_TASK_IN_BPF, with the scheduler taking full
> responsibility for ensuring the flag is managed consistently: you set the
> flag => ops.dequeue() is called when the task leaves custody, you clear the
> flag => fallback to the default custody behavior.
> 
> But I think this is something to explore in the future, for now I'd go with
> the easier way first. :)

We should just not do it.

Thanks.

-- 
tejun
