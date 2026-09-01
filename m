Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510083CC33F;
	Tue,  1 Sep 2026 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788297362; cv=none; b=ezt1EGiiG11TuPZdyEZ3gmkXlmtTApiC+BOkvN4kkqGrPjuP81/JHmKo3tH8uVGMCOpo4QjeQZGv0u9rsqLMJCexgbGXarHJLZbVk3nEZ7ofYgG2/IxIH86UVvvr6h9VTpEsaQo9Yog3+HkHAtt3yEgcNe4UOuK3DLJHUpH2D68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788297362; c=relaxed/simple;
	bh=lSbW7CMHA99QRbu3y5Y9AjtPDZpbpMhYHDxluFMtvdY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Tcvc3U0u10uxWbNayxZUzKMwaMuViAzLHBsODi8g0tuiS4FQaHXkDCuODEfTz9LLSgS+Ry8OI4jJs0R3lCK/yJaVFEFPmaTdCHK8LKy+/2+lnwcho9xW6Ou5kSHMIFN3QDKgu4wQ24IXM9Ynj5zBnPnKq0QHwzcKZJP/v1d1BYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpJhdWrk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpJhdWrk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59731F00A3A;
	Tue,  1 Sep 2026 21:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788297361;
	bh=ocZClOGhtCYdBb65IaLJAaGGci+QkprlGO5cDfZ+OSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NpJhdWrkQCK7Lg9p+UURJ1MhOGaEGlFU2SKboI4ufZqzjNIdZMbUS9B3XL+a6xcEz
	 jbbH4Nhp0jRawXrjrzsSKKYFUrdmH7hlvUwC8xoaRzHx0kiMbgoz+pqrkRxikvkgzf
	 pYG5jfkii/ntlVO3Tf1giydyxTEtwS9op+pPjR1perGCdcP+dXVHNKiG5RAge+B9B0
	 3CNSYenYNVz34y78bnMbWXxuojcZub3BlIIAqhhgxFMoDKEYJddRepOx8tMDiLiCx0
	 AAFwmF/r3X9GU+ZxGur0OSINwfzH6lAhvr7he8HCnp5KnP8SFZTm7Zcm9gL2z49Xej
	 /BM6Giit/9Rfg==
Date: Tue, 01 Sep 2026 11:16:00 -1000
Message-ID: <3a9bfba228c46c69408fe1ef392e60f0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Wanwu Li <liwanwu@kylinos.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Reject NMI calls to lock-taking kfuncs
In-Reply-To: <20260901095652.1009104-1-liwanwu@kylinos.cn>
References: <20260901095652.1009104-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Tue, Sep 01, 2026 at 05:56:52PM +0800, Wanwu Li wrote:
> +	if (!scx_kfunc_nmi_safe(__func__, sch))
> +		return -EBUSY;

The return value doesn't matter much as the scheduler is being terminated.
Whatever it is, use the same one everywhere. -EBUSY suggests retrying would
help. Let's use -EDEADLK which is what's being avoided.

> +/*
> + * sched_ext kfuncs that take scheduler locks are not NMI-safe: a
> + * BPF_PROG_TYPE_TRACING program can be attached to a function that runs in
> + * NMI, and scx_kfunc_context_filter() lets such a program call every kfunc in
> + * the any/cid/idle sets. Acquiring the rq, dsq or pshard raw spinlocks - or
> + * touching the irq-masking-only kick list - from NMI while the interrupted
> + * context on the same CPU already holds them deadlocks (or corrupts) it.
> + * scx_bpf_kick_cpu() was the first guard; route all of them through here.
> + *
> + * Returns true when the caller may proceed, false when running from NMI and
> + * the kfunc must bail without touching locks. scx_error() is NMI-safe (see the
> + * lock-free ->aborting claim).
> + */

Too long. Something like:

  /*
   * Tracing progs can call kfuncs from NMI. Kfuncs that take scheduler locks or
   * touch the kick lists, which are only protected by irq masking, can't run
   * there, so abort the scheduler instead. scx_error() is NMI-safe.
   */

> +static inline bool scx_kfunc_nmi_safe(const char *who, struct scx_sched *sch)

scx_kfunc_nmi_safe() reads as if it's testing a property of the kfunc. Let's
call it scx_kf_allowed_ctx() to match scx_kf_allowed(). Also, instead of
passing @who from each call site, make it a macro wrapper which passes
__func__ to the inline function.

Thanks.

-- 
tejun
