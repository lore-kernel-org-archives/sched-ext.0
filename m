Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85ED28506B
	for <sched-ext@lists.linux.dev>; Fri, 27 Mar 2026 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774589761; cv=none; b=nsTwr7wd864U56l+xWYt91uVN09f8BUeUbFIoud0GlHOodNiCJcSRe1YTGikWfHJYoI0hozPYevu/3krxRZz/L0L/WjTg9NU0SmtvzS2cC9vJIavAx6tMW1nsCq+Ydy3cYQtq0E3JIXDf+0CyxcTnWe//aYddY06ViE87K6FG4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774589761; c=relaxed/simple;
	bh=5xeI+UBtHbQiHG4eazoKGqLCdJsJQ/PduQuogAxxWrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InH7d1/kZIdgmbX6XsjzrP1NrW/tqd4YCiyoEFyPDnFBk0wdua++YU8mBrIWc4gIdPXW1qKdEWNPxcOJjEv58OxnyGYJoJARl1jFeT1BCWm7XIH0ATb1K953VKhCQWtBmznInBlQ069eQnkt8J13mSGo4rVlXVYFaUh1+O9PP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOB6fuz9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOB6fuz9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaf43014d0so11840895ad.2
        for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 22:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774589760; x=1775194560; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=57zbslpdW+qQC0v6K2x2MyCaG2fO5ph99ZSLbrSIvxE=;
        b=BOB6fuz9BrY7JaeNJiEgqQCNFTi4g5ryC5cdLff75YeXhc63mE432e7lwbBwq4imhd
         0ftjDc9QjyiP3owWvPazgq/4xJy8dnM2NjVrnZfUgQbLje4LT0SRWCIam3eOOc0Dh0td
         LiV8vgeixGPBoUmOaAmkr19pyfEY6vHIVFE0rhNmRLLKA8a1OWQZWP/i5c0WQoZmOj7q
         pGb/7z3XMoNlSwgKTz49T64atLFYUvHAZaOy+hLkBI6sYg3R6teOW9aYYqShmkH7s5v2
         ijQFEwouFruEpYXnRCXQXzssbtBRKobCMoaf1BaJkGJvYf9uToiZxs4wAZqgD1ehtbdL
         lCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774589760; x=1775194560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57zbslpdW+qQC0v6K2x2MyCaG2fO5ph99ZSLbrSIvxE=;
        b=akPzRatRal+Muea5/6WAexVIqYLpNCouKRZLXNmtGlmB7SUFxlXzdkL6jLmlqxQi1g
         omKRgwOT1sZjuEa7JUWjWiQPKrRJMNQ8oyOYnIpjnslqPeSj8oiBL/i0VZCrthTIk0nU
         0REzNjGRSSpNWzsWbW5VgSDBuudjIJziyIw/2Af8IVzzbtKKhgSmuizmV95UVAvuhuU+
         LogbRewIL7EalGFidLlGCcgFSHL1YkjRLEwqB/rGHRk+fwBr+UdQ1z1e0SjK1MR8Bzq1
         QZuYxXAAtaPIiBIFv94YxjI2pLOTd+XKZECkipHRnRXtN3bpR8tG87n8rN0nGhueGaPq
         2AfA==
X-Gm-Message-State: AOJu0YzXpGxqhEE8twIITjlLbiWu5Xss77EqdYbt3/QqdWzH0rUnmfx1
	onGlsFf60avc6/O4LbnkfVuN39NtOQE526dsCSPk+Xvj+rAjSKgKVcLLIWDK3GC6
X-Gm-Gg: ATEYQzyB5BWpy1VWBBuPTL2umXe4uesOuSgyGyVoqT+OHGnpj5RL+7pTbJEJZLcTMQO
	/+lY5GIxqjGp7WGrRvJdaOuCzvuRmG8crgK+5c1bEZHFVwOEjW0tK6QZApUyVbW50HVk6kfvqpW
	Bait1CFDODh3kzYyHRLAgYxcPce4+TWA59EZn40sUYFkYF1W9RiFbepfQnpogdiJQKjPI3d+di+
	fEfenHwFyaFaucG0PrKtm6V7N5uFHjCGZILYHLMVzJXwJCQZ1FLHPwSabf1+pms9sxPXcIVn3F3
	kopBN5SYYc/Eb7rMEFkTkD/4/JiqZ7Ir6dMCqtK4h9OoJdyXNW2YisLT4qTvKLLndGa6j/SX9s5
	2iOWS9lcUFoEqat1RD4rbK/iHJDXuoBUQb2AUrphLr1ByfYa+VS6qjUZFdyz1qERDS6ZLZhfw5Y
	Eg5SVIsmW7DHVtFfY3a4D+slWiRdFAyweB9ONYrPk=
X-Received: by 2002:a17:902:fd44:b0:2b0:c106:a402 with SMTP id d9443c01a7336-2b0cdc041cfmr9740755ad.3.1774589759675;
        Thu, 26 Mar 2026 22:35:59 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:af69:9e67:ef33:2eb2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc773472sm48281805ad.7.2026.03.26.22.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 22:35:59 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:35:53 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sched_ext: Fix print_scx_info() build error on
 !CONFIG_EXT_SUB_SCHED kernels
Message-ID: <tmzdbaqgbe3vypfbm6gdih6svfs6pyrdpnklgmmwc47brnika6@vtcswuax5dxq>
References: <20260326081021.687711-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326081021.687711-1-yphbchou0911@gmail.com>

Hi Tejun,

On Thu, Mar 26, 2026 at 04:09:15PM +0800, Cheng-Yang Chou wrote:
> scx_task_sched_rcu() is only available when CONFIG_EXT_SUB_SCHED is
> enabled. Wrap the call with #ifdef CONFIG_EXT_SUB_SCHED and fall back
> to rcu_dereference(scx_root) for the non-sub-sched case, which is
> semantically equivalent.
> 
> Fixes: 60d4b17e886a ("sched_ext: Choose the right sch->ops.name to output in the print_scx_info()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603261453.8kiJImYo-lkp@intel.com/
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  kernel/sched/ext.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 551bfb99157d..a40edd4d7cd9 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7689,7 +7689,11 @@ void print_scx_info(const char *log_lvl, struct task_struct *p)
>  
>  	guard(rcu)();
>  
> +#ifdef CONFIG_EXT_SUB_SCHED
>  	sch = scx_task_sched_rcu(p);
> +#else
> +	sch = rcu_dereference(scx_root);
> +#endif
>  
>  	if (!sch)
>  		return;
> -- 
> 2.48.1
> 

Gentle ping!

-- 
Thanks,
Cheng-Yang
