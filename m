Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B2396D26;
	Fri,  6 Mar 2026 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814866; cv=none; b=GttygDmWQw9vJ6KA0+l9PPPLsJKGGqVCq3XH/hsIb0KZlwaMMSAACJUVpyQL0ftrU9B8SEpDGNpEJJ8I6hUU/gJg38B7YouYhbiRUazh7gK580o95QV8Nsmk+zrnA732xaJE3k38BHnLYTLN3W+N0XihyHXE6uMGy+SepK5eTeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814866; c=relaxed/simple;
	bh=qmCDi5h3p/Ae8uJhI5CSMqiuOlNCK/AXUL2ZLuW+8EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRTyqWK+1xUcTAlkvDht19TMZPiNmOflk/zRNjevU4To8ZURkDxDEDGjWxqZ76utTqUPZIXGe7UnhXj5tyJjfPEzkZxG/3D8GuBcxnsqxF9I874TLnd67qTvdJ1eAtOShFihmjkP4fTyWRU4HUFwmr5R+Gtum0sdaL0rrXsQU0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kid8S3NM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kid8S3NM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B7BC4CEF7;
	Fri,  6 Mar 2026 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772814865;
	bh=qmCDi5h3p/Ae8uJhI5CSMqiuOlNCK/AXUL2ZLuW+8EE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kid8S3NMHCjN6IvA6IqKNqiRgGf7GpRnCk3zx7bk5QwVMir3mI8IDjPVn9yaKJ5Y/
	 0dsBlWlP2FFb5NMEUUYMlePupA9SC4q1pcndH96Am16JgifzuYENYwYEI45wzbQiBH
	 FzrgNCXXGTHq+ejitMdsKnr/oB1IiJci3WJNeA51221NiKtnCMcE+Zq7/lt4PYiZtF
	 tGFpWF+0z07qa87kOwgqwkbBScQpUFVwdfEyx2419qS/u2+tJpNxW4cJ9Rui2xozTr
	 kKfV0QkIIQaF2sNxaYd9tWDcDJm5t+IeLizZgAkvfeMoUiVjwZhUSWhOjDc5BMYYJI
	 AbfLC1WQeYatw==
Date: Fri, 6 Mar 2026 06:34:24 -1000
From: Tejun Heo <tj@kernel.org>
To: zhidao su <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	peterz@infradead.org, mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: Re: [PATCH v2] sched_ext: Use WRITE_ONCE() for the write side of
 scx_enable helper pointer
Message-ID: <aasCEDc1Hi184it9@slm.duckdns.org>
References: <20260306105901.2543743-1-suzhidao@xiaomi.com>
 <20260306141718.2721073-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306141718.2721073-1-suzhidao@xiaomi.com>

On Fri, Mar 06, 2026 at 10:17:18PM +0800, zhidao su wrote:
> scx_enable() uses double-checked locking to lazily initialize a static
> kthread_worker pointer:
> 
>     if (!READ_ONCE(helper)) {
>         mutex_lock(&helper_mutex);
>         if (!helper) {
>             helper = kthread_run_worker(0, "scx_enable_helper");
>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                      plain write -- KCSAN data race
> 
> The outer READ_ONCE() annotates the lockless fast-path read, but the
> write side uses a plain assignment without the matching WRITE_ONCE().
> The KCSAN documentation requires that if one accessor uses READ_ONCE()
> or WRITE_ONCE() on a variable to annotate lock-free access, all other
> accesses must also use the appropriate accessor. A plain write leaves
> the pair incomplete and will trigger KCSAN warnings.
> 
> The error path also has the same issue:
> 
>             helper = NULL;
>             ^^^^^^^^^^
>             plain write -- KCSAN data race
> 
> Fix both plain writes by using WRITE_ONCE() to complete the concurrent
> access annotation and make the code KCSAN-clean.
> 
> Fixes: b06ccbabe250 ("sched_ext: Fix starvation of scx_enable() under fair-class saturation")
> Signed-off-by: zhidao su <suzhidao@xiaomi.com>
> ---
> v2: Add missing Fixes: tag (Andrea Righi)
> ---
>  kernel/sched/ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 9a1471ad5ae7..c4ccd685259f 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5355,9 +5355,9 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	if (!READ_ONCE(helper)) {
>  		mutex_lock(&helper_mutex);
>  		if (!helper) {
> -			helper = kthread_run_worker(0, "scx_enable_helper");
> +			WRITE_ONCE(helper, kthread_run_worker(0, "scx_enable_helper"));
>  			if (IS_ERR_OR_NULL(helper)) {
> -				helper = NULL;
> +				WRITE_ONCE(helper, NULL);

I think this is racy. Another enable instance can race and read an ERR value
and try to use it as a pointer. Can you add a temporary variable to hold the
returned kworker pointer so that it only writes to helper iff it's valid.

Thanks.

-- 
tejun
