Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A97C469838;
	Wed, 16 Sep 2026 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593579; cv=none; b=Eh/INFzI0SEinN+9AafJIbkGvGTGk9nZ7WwYqGy5fqeYFNdJ9fmZ6ndkSa+n3GwyDeI7uqgNT5mXbNO7d0X64Rnl3dJB8MhzPXFKulUTdfG9bfGqgfbfVTx/xEW6RP1aVUZqGfbQsXaQZyhS0amGxf6l4JX9f9VoKNmUA0loLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593579; c=relaxed/simple;
	bh=gg6NUaJbHlRIz107NnnQnMyRzFnyxBA0EmVADuWeOnA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSzQraV0EES3f2FgfUB/gHh0cneToWRGqx/gRyFc18HinkswG8ZK4cn1vBmQxNgJIdK48U+hKgpyI0eN+z7/r+NjP4kOSDouIqCfFIc2pGunxf5tn9uv2vkh1MOepmbtGtkMW2sm1nffO76aH2VoiGdThWeiSoWViTfLFf3Kvuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8cVEAaR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8cVEAaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863701F000FF;
	Wed, 16 Sep 2026 21:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789593541;
	bh=TYQp4TVbIdc3alj+SnG6vRCYmGaxdN6ohgm5zyM8/9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V8cVEAaReNNW3QWnzCHFozWPnzJaowMwgOLTyaIWVVR5VqR1BtDJrhXqIJuiqx+Pd
	 WPu1z/jqT+9+1VmcAv4Ym+R31q8Fw78kk9YcQ1vCaz1ZjRw1mgya6uwJIwkDlLP637
	 8oJrwrTWwY4J7OXACGXad7zndF9ZpKCx3r740wQYTVP+meHchM/Q7SJL/RQwJiMak/
	 vD3XQgPrqKOd87EQ3to75URVowYYISG7E+zvwzqDbCDq/O9xoag1txGQ5sDoRIbPkT
	 KsD0KSC5tnKReEUVFnYDaovPL/Ri42wW+Qdsi0YcAqK8PskgThl6IaPiW0/rwayCKP
	 wVQHvx04SKhMQ==
Message-ID: <bce097463a431a8fde2359539e4e5303@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <etsal@meta.com>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add lazy preemption support
Date: Wed, 16 Sep 2026 11:03:36 -1000
In-Reply-To: <20260915194611.2674127-2-arighi@nvidia.com>
References: <20260915194611.2674127-1-arighi@nvidia.com>
 <20260915194611.2674127-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Andrea.

This is an AI review. The series was built and the selftests pass under vng
here, and the kick and tick paths were traced and look correct. A few things
to fix up.

On Tue, Sep 15, 2026 at 09:45:12PM +0200, Andrea Righi wrote:
> +	 * modified afterwards with scx_bpf_task_set_slice_expiry().
> +	 */
> +	bool			slice_expires_lazy;

This adds 8 bytes to task_struct for a bool. Put it next to @disallow, there
are three bytes of padding after it.

> +	 * A task in user space still reschedules on the way back from the tick; a
> +	 * task in the kernel runs on to its next return to user space or to the
> +	 * next tick, which promotes the request. No effect on kernels without
> +	 * lazy preemption. Rescheduling while disabling stays immediate.

Lazy is a runtime mode under PREEMPT_DYNAMIC, so "kernels without lazy
preemption" isn't right. And what forces immediate rescheduling is bypassing,
not disabling.

> +static void scx_resched_curr_lazy(struct rq *rq)
> +{
> +	if (rq->scx.flags & SCX_RQ_CAN_STOP_TICK) {
> +		rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
> +		if (rq->clock_update_flags < RQCF_UPDATED)
> +			update_rq_clock(rq);
> +		update_other_load_avgs(rq);
> +		sched_update_tick_dependency(rq);
> +	}
> +
> +	resched_curr_lazy(rq);
> +}

Setting the TIF bit before restoring the tick dependency would let the tick
IPI's return to user space serve the reschedule instead of waiting for the
next tick. Not critical.

> -/* common to both forms: only scx.disallow is writable */
> +/* common to both forms: only the fields below are writable */

Nothing else became writable. Drop the hunk.

> -	raw_spin_rq_lock_irqsave(rq, flags);
> +	rq_lock_irqsave(rq, &rf);

Please explain this in the description. Pinning clears RQCF_UPDATED, which is
what makes the clock_update_flags test in scx_resched_curr_lazy() do anything
on this path.

> +	if (unlikely(flags & ~(SCX_KICK_IDLE | SCX_KICK_PREEMPT | SCX_KICK_WAIT |
> +			       SCX_KICK_PREEMPT_LAZY))) {
> +		scx_error(sch, "invalid kick flags 0x%llx", flags);
> +		return;
> +	}

Unknown flags were silently ignored before, so this is a behavior change and
the description should say so. The SCX_KICK_IDLE check already existed, it
just returns early now.

> + *            - SCX_ENQ_PREEMPT and SCX_ENQ_PREEMPT_LAZY inserts
> + *            - SCX_KICK_PREEMPT and SCX_KICK_PREEMPT_LAZY kicks

insert, kick.

> +/*
> + * v7.4: scx_bpf_task_set_slice_expiry() added to enforce sub-scheduler task
> + * ownership. Preserve until v7.7.
> + */

This is copied from the block above and doesn't apply. The kfunc is new with
the feature, there was no field write to replace.

> +#define HAVE_SCX_KICK_PREEMPT_LAZY
>  #define HAVE_SCX_KICK_WAIT

The autogen headers follow definition order, so SCX_KICK_PREEMPT_LAZY goes
after SCX_KICK_WAIT in all four. Please regenerate them instead of editing.

Thanks.

--
tejun
