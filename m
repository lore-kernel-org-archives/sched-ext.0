Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0DA2FC03C
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763414; cv=none; b=ZkwlPgdHGtCH4neFuaHUxRmHsf6g7zUDz3HCnCqZYilqFN79ku7ZUA4T9A6nXA5f4fsGknCBek6cHLGH9W0SUf01nzjHah/QRwkHOfpwtIhRszYUqgGpbFynuyUL/7WxpRXrdGZUd1KMbCB42VaUt+cyraBkhjhU8hNuNE1avVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763414; c=relaxed/simple;
	bh=ND28dtJOsES5XuobflpYBzeBDfecK0Z6MQsRDFRzIV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tf+vvXNY3QX2XU3vM2JZAqpk2WuCwrrhwiI7mrymLT1imAQYQAPoyx+sNoXZbBiqpOWAvoOlPG9E5bFRUWzraqk7cuwvSjUZvP2D2iMr16ON3SfCOKejtJxSvN5+/HhaksK5zOdr9GcgdQf6rnyO85gs5iN7bcy1YadyoRv1Rs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X32hUG8Z; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X32hUG8Z"
Date: Mon, 10 Nov 2025 09:29:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762763400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zq54ZpUTeLpQv2UpzCWGpEFEV7z02gjTzdSmIMnN5F0=;
	b=X32hUG8ZsZyZIdEaNoSRpSGj6dj/h2BCDs8OheHaMTjGEmjyNLEU49XXzwTDn95uA/P5FO
	6Z1fPRP8lpIqMqOyJ95Q0Ys6plQ9dPtDII0LX/8uRFJs9BUJ9cz8TXlMYaMUfYWiU+kVJ8
	mEOESdTlyJ/2XV5Aco4thu1LXtVa2Wg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] sched_ext: Make handle_lockup() propagate
 scx_verror() result
Message-ID: <aRGigc4YQFsyK7Hd@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-10-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-10-tj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Nov 09, 2025 at 08:31:08AM -1000, Tejun Heo wrote:
> handle_lockup() currently calls scx_verror() but ignores its return value,
> always returning true when the scheduler is enabled. Make it capture and return
> the result from scx_verror(). This prepares for hardlockup handling.
> 
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5c75b0125dfe..4507bc4f0b5c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3658,6 +3658,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
>  {
>  	struct scx_sched *sch;
>  	va_list args;
> +	bool ret;
>  
>  	guard(rcu)();
>  
> @@ -3669,9 +3670,9 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
>  	case SCX_ENABLING:
>  	case SCX_ENABLED:
>  		va_start(args, fmt);
> -		scx_verror(sch, fmt, args);
> +		ret = scx_verror(sch, fmt, args);
>  		va_end(args);
> -		return true;
> +		return ret;
>  	default:
>  		return false;
>  	}
> -- 
> 2.51.1
> 
