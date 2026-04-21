Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009803A4F58
	for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779931; cv=none; b=OJuZSgyQM973YwyhDs+hnQW33n/WfBB17fmthAOr85+0wjQYj/B8AX1pM5Yqkg230wq3rS/Svapw9gjghZn6BOZV4zmEzBsQqTPlXPA/m5iuqeiOSK+jJxne8IowLlDTgki2hW+adgAHGc7k+hQADBHSuEX13FP6lrUlV2W+MDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779931; c=relaxed/simple;
	bh=7QL0M/afkstC1WLO5CCQu3QoQtuZxcQgs08DY6L0R3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nABQYnbzQyK6k1b3kz7DdRnflMtksqTN6gYD5uqjWnuS52YoGgG9awO+lX1/bm/iFKLcgNvlkn5SlTeU7gle3cJAzV1opMeBYrqdEgU53PV8Zq32Q+eMSstxNwGnBk5T6+dF5+v4len5VJ4opNpEC7dZGcXkYiBgxOaQfQFfe1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdTBKbf6; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdTBKbf6"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so3841953a34.2
        for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779929; x=1777384729; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgiJMjujI98BM40mE6+tsm2WGektilIzOGQ1gkeRBtA=;
        b=QdTBKbf6LHPp0VMKK2z1UGPVfiRI6sta7NUGzwaOb7B40nWsIJS+mMCAcefMmuZ0Qg
         +a3xv/2G73QOupZ+KyBwV00TRgRY4c6fbjTxFlHcmUKj7zDq/a5dlxnyUQVrwp5qg6QZ
         LlpEIH73etBVP8mvJ0kYW7u+dgEAxOsnyXfWxhWB7TsO4N7AXaCIi1oCtbZWY9ChEwIj
         I02n4NxTTVPobXbVBXwmSclJE7zY/wJUK0mBEGdp1zKWg0Jiq+T0OfJq6KEPWmItIP57
         M16HhTMID12oiKJ9r8jfn3pZqWEWLH/JxxWMwrHNxfeOfiomhLO7U2xFNRhAGv9f/wKw
         TShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779929; x=1777384729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgiJMjujI98BM40mE6+tsm2WGektilIzOGQ1gkeRBtA=;
        b=SveD74YOrfZfdEP4/WYI4fRVEu+jG6OSocgtd9DQnnKrxmovqOL0zItQ/Aoi7IRWhL
         pzm5coEaJMM2K7ICcPrchO1sL4CB19EP48ci4pvznj8Y+cKihZ1s5avH/SWChXhjcAZa
         HI+uUv3JrWR72JZL7FhT41yJUJ12EebAg3lDORm7uYe7ck9Hj3GhX1b1YTxecnQk+yfB
         cngYDwfFHaoyZzRFwm+dpjmIrAeRWRZw4g+59VHISRrIvcxnEsqQD6j7YU5hG5ojqbCA
         fuUiWcJukjNq410+dr0p8G//DphZgog/JBKwssL6VcB2JFyx91oYPqDC6GKoluzSk93l
         /BFA==
X-Forwarded-Encrypted: i=1; AFNElJ/VExQKwN4n7TM2A1ocQoLEDN9UH18g8O8Xfyop+dUydfXPELCN+Ig4wqKgF7dD25lilA91nl2+K4o=@lists.linux.dev
X-Gm-Message-State: AOJu0YzM4Mm9y+wg+r/sKN4POUOgBHq/xT0NU2Z6MVtRwW5oZ84UzLHp
	KTe/LPc7dhpaOVcW8bo3sL2hytJ0K9NlMvyA+pACUJ3WXTtsOgED6+MI
X-Gm-Gg: AeBDiev3kVDW1j/MRaoU6l8bw7rzRZaonhxSperDuVwRcMxH8qIKroE2grxDjtdUB/8
	oVCS7jG+wKmtRpIVCIo7o0qgRiTVkSpOzYhsqYpMpKWzHH2aIWip46C/4LpyHNw2wuj4fxywzYr
	G1Zi9KPKPQ1u6xYTZ9P2h0BWIfKCP7fqsc6j0r0QYd92C6Phui8A2oxjoGj3O4paIUc5fx4iZSr
	+KlGi/HHa9bs4EPzYodei2bnfTrp9lpinRVqE3qtKoMOrfYWPi2Pih0NitK/2sS9wskzx/hqnAl
	/GGpKCNNK53v/W7t1Y7cmBC+5K9sY38pquBNumG8fCeG3SPNtsiprqwuG8XQy2Y5TuixFeu1fYK
	kzj2fASkFoCW5nVOPmxnWwdSexVKvmywqnn8XvIbUUFQs1yrDmzk3fEz+LAj5JD8HiJKjnztjf+
	yBFdLqElSlCy5J/WAZxDJgmsXk/EuI/KHA8z+A7lVNkt/E5mX8+cyZ5qg9/yfLLBejB4wjJGwYZ
	xSujmislcuGzibM
X-Received: by 2002:a05:6830:3487:b0:7dc:d679:3eb1 with SMTP id 46e09a7af769-7dcd6794275mr2378593a34.25.1776779928801;
        Tue, 21 Apr 2026 06:58:48 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-97-241.dynamic-ip.hinet.net. [36.225.97.241])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd9a0847esm1706308a34.17.2026.04.21.06.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:58:48 -0700 (PDT)
Date: Tue, 21 Apr 2026 21:58:43 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, emil@etsalapatis.com, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 04/16] sched_ext: Relocate cpu_acquire/cpu_release to end
 of struct sched_ext_ops
Message-ID: <20260421215030.G7d71@cchengyang.duckdns.org>
References: <20260421071945.3110084-1-tj@kernel.org>
 <20260421071945.3110084-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421071945.3110084-5-tj@kernel.org>

Hi Tejun,

On Mon, Apr 20, 2026 at 09:19:33PM -1000, Tejun Heo wrote:
> cpu_acquire and cpu_release are deprecated and slated for removal. Move
> their declarations to the end of struct sched_ext_ops so an upcoming
> cid-form struct (sched_ext_ops_cid) can omit them entirely without
> disturbing the offsets of the shared fields.
> 
> Switch the two SCX_HAS_OP() callers for these ops to direct field checks
> since the relocated ops sit outside the SCX_OPI_END range covered by the
> has_op bitmap.
> 
> scx_kf_allow_flags[] auto-sizes to the highest used SCX_OP_IDX, so
> SCX_OP_IDX(cpu_release) moving to a higher index just enlarges the
> sparse array; the lookup logic is unchanged.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good.

Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

> ---
>  kernel/sched/ext.c          |  4 +--
>  kernel/sched/ext_internal.h | 54 ++++++++++++++++++++++---------------
>  2 files changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 9e802d73f205..74e4271e44e9 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2813,7 +2813,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
>  		 * core. This callback complements ->cpu_release(), which is
>  		 * emitted in switch_class().
>  		 */
> -		if (SCX_HAS_OP(sch, cpu_acquire))
> +		if (sch->ops.cpu_acquire)
>  			SCX_CALL_OP(sch, cpu_acquire, rq, cpu, NULL);
>  		rq->scx.cpu_released = false;
>  	}
> @@ -2959,7 +2959,7 @@ static void switch_class(struct rq *rq, struct task_struct *next)
>  	 *  next time that balance_one() is invoked.
>  	 */
>  	if (!rq->scx.cpu_released) {
> -		if (SCX_HAS_OP(sch, cpu_release)) {
> +		if (sch->ops.cpu_release) {
>  			struct scx_cpu_release_args args = {
>  				.reason = preempt_reason_from_class(next_class),
>  				.task = next,
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 350b84876b2a..1d73fcc19aaf 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -555,28 +555,6 @@ struct sched_ext_ops {
>  	 */
>  	void (*update_idle)(s32 cpu, bool idle);
>  
> -	/**
> -	 * @cpu_acquire: A CPU is becoming available to the BPF scheduler
> -	 * @cpu: The CPU being acquired by the BPF scheduler.
> -	 * @args: Acquire arguments, see the struct definition.
> -	 *
> -	 * A CPU that was previously released from the BPF scheduler is now once
> -	 * again under its control.
> -	 */
> -	void (*cpu_acquire)(s32 cpu, struct scx_cpu_acquire_args *args);
> -
> -	/**
> -	 * @cpu_release: A CPU is taken away from the BPF scheduler
> -	 * @cpu: The CPU being released by the BPF scheduler.
> -	 * @args: Release arguments, see the struct definition.
> -	 *
> -	 * The specified CPU is no longer under the control of the BPF
> -	 * scheduler. This could be because it was preempted by a higher
> -	 * priority sched_class, though there may be other reasons as well. The
> -	 * caller should consult @args->reason to determine the cause.
> -	 */
> -	void (*cpu_release)(s32 cpu, struct scx_cpu_release_args *args);
> -
>  	/**
>  	 * @init_task: Initialize a task to run in a BPF scheduler
>  	 * @p: task to initialize for BPF scheduling
> @@ -867,6 +845,38 @@ struct sched_ext_ops {
>  
>  	/* internal use only, must be NULL */
>  	void __rcu *priv;
> +
> +	/*
> +	 * Deprecated callbacks. Kept at the end of the struct so the cid-form
> +	 * struct (sched_ext_ops_cid) can omit them without affecting the
> +	 * shared field offsets. Use SCX_ENQ_IMMED instead. Sitting past
> +	 * SCX_OPI_END means has_op doesn't cover them, so SCX_HAS_OP() cannot
> +	 * be used; callers must test sch->ops.cpu_acquire / cpu_release
> +	 * directly.
> +	 */
> +
> +	/**
> +	 * @cpu_acquire: A CPU is becoming available to the BPF scheduler
> +	 * @cpu: The CPU being acquired by the BPF scheduler.
> +	 * @args: Acquire arguments, see the struct definition.
> +	 *
> +	 * A CPU that was previously released from the BPF scheduler is now once
> +	 * again under its control. Deprecated; use SCX_ENQ_IMMED instead.
> +	 */
> +	void (*cpu_acquire)(s32 cpu, struct scx_cpu_acquire_args *args);
> +
> +	/**
> +	 * @cpu_release: A CPU is taken away from the BPF scheduler
> +	 * @cpu: The CPU being released by the BPF scheduler.
> +	 * @args: Release arguments, see the struct definition.
> +	 *
> +	 * The specified CPU is no longer under the control of the BPF
> +	 * scheduler. This could be because it was preempted by a higher
> +	 * priority sched_class, though there may be other reasons as well. The
> +	 * caller should consult @args->reason to determine the cause.
> +	 * Deprecated; use SCX_ENQ_IMMED instead.
> +	 */
> +	void (*cpu_release)(s32 cpu, struct scx_cpu_release_args *args);
>  };
>  
>  enum scx_opi {
> -- 
> 2.53.0
> 
> 

-- 
Cheers,
Cheng-Yang
