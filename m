Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4573D812B
	for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781534; cv=none; b=O/UilQJxP/JB7MDmlDrG/NSO4rMNCmcl0W45hgRikDKdwY9utWeL0HE+UfEtzbPG3bgHgW63N7nqlKUzsTvdd6PHdcT/Nyx9NXW7DNbKuokShyga4dyUwF3aYY1P/F/Fvzs4xkBvp7ah8xrefFIVRT7OKM9o/yXT2CUtuzjpVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781534; c=relaxed/simple;
	bh=e6hs8ACNVyUtI7/nDi4FX9ZgPABWYl4OK4jEuPQtyrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rr4oPNtIbqSnrX7s/VhSXWDLsDzji9MmxC+2JAqvEN0U2yubKyyDR/CV9eyaKAOZtz/EjCu5a44X7uSWwlsEYgHB4QCvM5uRV/sYqIRUnBr27A/Bm2ohbgzuu1CLLTZcgoLTEIpqRi5ik2PDkB1gOBqvqc6rVVJO4yU+uC5BW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qWxy1F5r; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWxy1F5r"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so2065208a91.1
        for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776781533; x=1777386333; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXCqV0MG2zI7VVBu5Z+aY85rUWOej8zTmr41NYYBhvg=;
        b=qWxy1F5r79lD26ZmZc7MtO/i8xNPpJhw12rL38w9TrpaDEen6eT/UpQwEMjlscEXvj
         4qpLNN0Q2yM0E4pPAgDXKGPtWTcl93+6iplPCerEQkn95Jc/k99O2eIKB7vzbP3xpnB5
         OYgUy8o0SyTvpkYagVtMfo7ZFKPJiu9cUecyntn1Kk6FqvtnkzwcjJoP4F2/tAjrwmPE
         zvqPwJlGCuGDiD0+qDmRKIeDcpYQRIIvOnugGdpvoGiB9/b7cbgE+VLoHmnLk/gkBAfJ
         +2Qoit5zUKxjfS7NNrVuyASlYq5SxdQ4Q0yqtviVCDzvpPLRfKJF9A6ZY1czcBFr27o5
         kkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776781533; x=1777386333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXCqV0MG2zI7VVBu5Z+aY85rUWOej8zTmr41NYYBhvg=;
        b=f8hvv7YP9C0Ob4M0kpsUg2cvE2R8kI6PCZFd75SgZ0o6PQZNzYaymdvUwVJ4GdQI9y
         tKDZ/fZT5SQIF2iIpbPiMX+2k6mq/mAtbfFI6AaYFHU7N39MU08A1DfAl4T/CU4EpDFf
         M1Hmm8Hwn/bCG3/TlHzN1enkPNadSGw1yspuLMwqoOoId5LRWv1nT9YcqTlePO/c/vOp
         cvtnYaeHoxN47SW+yT2lOpsM0gwgcQTaChXtw4waeCRrxTxDUo/8dJkGd9cA6wzjK8/l
         XBXzNmxnGjTACGmTn0Jnhi7lyE5OU8YTNEsKDTtWGeilWNnnderurvlPauG110hjSzfd
         o8fQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cetzmEQu4QKLUtkJ0/MmO6jd7rSZhMLYACLtNrZtuJqNYiMdbmwnBmWtOIPzyjDKeKcYgeo84Y8M=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1iSzaEg7MPiHrgPGCyOS3KiceN0Oaz6pnN0OlJWA2yRpm52mA
	lQvC+J39PWTiQ3UuxXMORvEP1VKZA4sULOdCeNFqwosQn4zIjYClKKV4
X-Gm-Gg: AeBDievw4PPZTMHSCqcP/7/6zen8jn+dRTkMKTcsdwwo8EcKRCrcw8fu2mzOnea6d/T
	RZ9uAVoOgjiGS8nrec6KshV+ZBBttrzHrxnW2zrToPFz6b6wkfslZEj/qNZhwTSnN+FipOGO+pf
	HdAZO7VKHtZxvbacGh8mwwDKr6/n/d4Yqor5K6vNa1xHbvAh3d5EKHlo25KH8ClDo2vPz5NjMnr
	TUy9n0RtZL3ouItqanPNkigQLok95qFOCu0LCePNp/esnVGfur4FKw/lYBXWg9FIeKyJZxxRb+U
	yZtbETgebHNt9AkaoVB7E9eBFkvIWk9E8PID6UTfYT7UxOi2G1BOy/dfS1+z9dw0DOQvVKP0usT
	+PSMJdAHUJD8wMweLw/jVDSD1/zqCujCY0dxEWxyau7wmkpcnY+/YI/DZkzWkDkkxltCUToXQxn
	5JSEYqJQ+p1kYZNbl5oLTEeXQ7OYhJ0ZB3PNRSZKgsWcrwCNoeTAn9W7+8G9o0fQkCXMtdgROmI
	fthul7PlxJNJ0HxOHdio+GIrSM=
X-Received: by 2002:a17:90b:38c5:b0:35a:2ed:9b6f with SMTP id 98e67ed59e1d1-3613feea4edmr16697610a91.0.1776781532609;
        Tue, 21 Apr 2026 07:25:32 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-97-241.dynamic-ip.hinet.net. [36.225.97.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm14170953a91.3.2026.04.21.07.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 07:25:32 -0700 (PDT)
Date: Tue, 21 Apr 2026 22:25:28 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, emil@etsalapatis.com, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 05/16] sched_ext: Make scx_enable() take scx_enable_cmd
Message-ID: <20260421215905.G1ac3@cchengyang.duckdns.org>
References: <20260421071945.3110084-1-tj@kernel.org>
 <20260421071945.3110084-6-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421071945.3110084-6-tj@kernel.org>

Hi Tejun,

On Mon, Apr 20, 2026 at 09:19:34PM -1000, Tejun Heo wrote:
> Pass struct scx_enable_cmd to scx_enable() rather than unpacking @ops
> at every call site and re-packing into a fresh cmd inside. bpf_scx_reg()
> now builds the cmd on its stack and hands it in; scx_enable() just
> wires up the kthread work and waits.

Verified stack lifetime.

Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

> 
> Relocate struct scx_enable_cmd above scx_alloc_and_add_sched() so
> upcoming patches that also want the cmd can see it.
> 
> No behavior change.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 74e4271e44e9..62aab432dbf4 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6424,6 +6424,19 @@ static struct scx_sched_pnode *alloc_pnode(struct scx_sched *sch, int node)
>  	return pnode;
>  }
>  
> +/*
> + * scx_enable() is offloaded to a dedicated system-wide RT kthread to avoid
> + * starvation. During the READY -> ENABLED task switching loop, the calling
> + * thread's sched_class gets switched from fair to ext. As fair has higher
> + * priority than ext, the calling thread can be indefinitely starved under
> + * fair-class saturation, leading to a system hang.
> + */
> +struct scx_enable_cmd {
> +	struct kthread_work	work;
> +	struct sched_ext_ops	*ops;
> +	int			ret;
> +};
> +
>  /*
>   * Allocate and initialize a new scx_sched. @cgrp's reference is always
>   * consumed whether the function succeeds or fails.
> @@ -6655,19 +6668,6 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
>  	return 0;
>  }
>  
> -/*
> - * scx_enable() is offloaded to a dedicated system-wide RT kthread to avoid
> - * starvation. During the READY -> ENABLED task switching loop, the calling
> - * thread's sched_class gets switched from fair to ext. As fair has higher
> - * priority than ext, the calling thread can be indefinitely starved under
> - * fair-class saturation, leading to a system hang.
> - */
> -struct scx_enable_cmd {
> -	struct kthread_work	work;
> -	struct sched_ext_ops	*ops;
> -	int			ret;
> -};
> -
>  static void scx_root_enable_workfn(struct kthread_work *work)
>  {
>  	struct scx_enable_cmd *cmd = container_of(work, struct scx_enable_cmd, work);
> @@ -7243,11 +7243,10 @@ static s32 __init scx_cgroup_lifetime_notifier_init(void)
>  core_initcall(scx_cgroup_lifetime_notifier_init);
>  #endif	/* CONFIG_EXT_SUB_SCHED */
>  
> -static s32 scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
> +static s32 scx_enable(struct scx_enable_cmd *cmd, struct bpf_link *link)
>  {
>  	static struct kthread_worker *helper;
>  	static DEFINE_MUTEX(helper_mutex);
> -	struct scx_enable_cmd cmd;
>  
>  	if (!cpumask_equal(housekeeping_cpumask(HK_TYPE_DOMAIN),
>  			   cpu_possible_mask)) {
> @@ -7271,16 +7270,15 @@ static s32 scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	}
>  
>  #ifdef CONFIG_EXT_SUB_SCHED
> -	if (ops->sub_cgroup_id > 1)
> -		kthread_init_work(&cmd.work, scx_sub_enable_workfn);
> +	if (cmd->ops->sub_cgroup_id > 1)
> +		kthread_init_work(&cmd->work, scx_sub_enable_workfn);
>  	else
>  #endif	/* CONFIG_EXT_SUB_SCHED */
> -		kthread_init_work(&cmd.work, scx_root_enable_workfn);
> -	cmd.ops = ops;
> +		kthread_init_work(&cmd->work, scx_root_enable_workfn);
>  
> -	kthread_queue_work(READ_ONCE(helper), &cmd.work);
> -	kthread_flush_work(&cmd.work);
> -	return cmd.ret;
> +	kthread_queue_work(READ_ONCE(helper), &cmd->work);
> +	kthread_flush_work(&cmd->work);
> +	return cmd->ret;
>  }
>  
>  
> @@ -7452,7 +7450,9 @@ static int bpf_scx_check_member(const struct btf_type *t,
>  
>  static int bpf_scx_reg(void *kdata, struct bpf_link *link)
>  {
> -	return scx_enable(kdata, link);
> +	struct scx_enable_cmd cmd = { .ops = kdata };
> +
> +	return scx_enable(&cmd, link);
>  }
>  
>  static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
> -- 
> 2.53.0
> 
> 

-- 
Cheers,
Cheng-Yang
