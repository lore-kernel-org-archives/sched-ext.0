Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4080946B5
	for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776855080; cv=none; b=uSxDODWL1HdbyDpOx/Jcuv33man6HQFuEctBB8s19v3o1e1nwgwwVB80+7rem4psUorx/Fkf4pQtEV8fBO+rcMtsppIzsEu8SjUXjIBUxlrw2oiDLb5/WGZjAB1GJbZUzgbd7tJnwAYlJeQY7NI2FcIpn+sGXbHnFIAvRA6lZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776855080; c=relaxed/simple;
	bh=7HOTuwDeCLZJO7sqFzIrCwQPvn4VX9ZUJ1cQpYQFI5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xr9bBSG3ZAA45pHlEeAxVlRPoQ/5QbywpbsehlM2QjzTvgwzqmMQFz0LZHLCPfxsq21oOAP+FkcpaEcP9c10iai4AmyDId1uJELXKA89c/T0ijhaD354oYAP/u2IPfbyXvxQsH7nJ9AgjjQnksM/wHy/tVmrHvbhqBU4i+pwMxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/LVmwx/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/LVmwx/"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3614826eca4so4827110a91.1
        for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 03:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776855079; x=1777459879; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BrfPZZNqJZIU1swqWsCZeR23pBvS4pwR9vbdDEDGcn0=;
        b=q/LVmwx/JpZUmr28+0yPV7upplMeMM6TWMLJOsQB7LeGCEL08kDOelvkGi2Pca6KfI
         8G5i9XpksHRrE+kcf/fsl/AN9/0uPuXh/7Kee2It42qMjesgY0JakWi+7KZA7k5cbC2p
         bD9Os59cN5Qn+eisK98BZFJhLgk256RX5zK1xrhBGgG9MC10akh/sMTuId0sIHWp0GZ4
         MyB+rDyaJ+LMPw/gElqZaZKfn5TilOLWHcykynQK0UDeWaeZ0pMzs9jI+kfSe2XB6GlC
         42Gj0HcgYhpgTQf/+sEZpPQN6S7GDKl4S4oEHCgrcm4rWdkbWvw3zW7vC5OxaZtxLUBI
         OSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776855079; x=1777459879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrfPZZNqJZIU1swqWsCZeR23pBvS4pwR9vbdDEDGcn0=;
        b=H7n1RKe+SW2TRDzFbDtTzzVu57VpIebj8zgSDDTV+fDOkFi0Zh823V1EsHKKrzxrFT
         tRk09gbubfXunMSi8JlWOduEbYmhvCN0SpiDAhZfgv03bVHz5FGpTyamgQDQ2dwqRqTg
         Be55MtXP6hD62VGaWIAcKhX/0eoE25kb1kZV/UqbCnOy+A1rKUE0wIV3kHC1EMBaeQhS
         BjdXtPo2D2Jwnq3hv299LCRuCmOeZhqoRFR1AChySjO3YXcqrmfRcH0alumd171P5Ngj
         1dloED0zu/EJtUjBiFuke7KoPM4hvyl7LV2SSvBxm5mwDz4T2l4Mq64WYiOn/DJjQ2Sd
         E6eA==
X-Forwarded-Encrypted: i=1; AFNElJ/1WcYhJ9rRSUn6M/nmC8ULs6IpOGjEgLjX14D2EMFrWN6fjAgX67qhtL6Fq0MGsA6ldlWjKCVi48A=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3AdzcF0m56QQ9ljutGRVxpkDpIxneCI0o5FLcMuhRBdWsg/SZ
	7lHSsX61h38TjQ2jiX/p70fALJHd8UJzXiN2HgdsZheJI2ujUs40BWh/
X-Gm-Gg: AeBDievEPfTP3GXMFdm806XorCHMYydzdUSpm53Ptric7kWXpO6qvOmoMGobohs42Um
	i7fiXQemfMg/0yw0LFjmhD58M6mKtxw0f/+gndwZSDQzUDE8X2EZSSgoo1C6sImGSg+AiQ2BwZQ
	dKL7WCMUGkLodl7srTTXQllZynKxKalcbNqLLH2FFH50OYYagymlO/wp7yiZwrSIAnvYf4wu4XF
	i4rzAguTZhD05PTWtFw+ScQ7xtBc8KVSFT8+wY3NOIoS1i8gvF8JSAzQhf7TWtRzz5vsWQh2byY
	rj7ieGkW0SzObemRk27mgIT9q9+lKfW+H8ZPKrqZuakbyMYU6Q0lDQR+3Pz+btdrCOkkwnRgZnU
	dbGAlZA93ZT+sIPNNJkRrGv/S/WWMG1YUomZ4l6stkfNKCuKXhKE3z8EtxSTpem6bESdennStH6
	4gX0YjBcelUHRVdMo0ZtBs7CfQOsAv+7DoIiZrGr8usrwkILjY4qaMYWzD8Ia+RtWFF1QLjjQUE
	qK0nOqof9GjZfGE
X-Received: by 2002:a17:90b:2892:b0:35f:b5df:456 with SMTP id 98e67ed59e1d1-36140463bb0mr22110329a91.18.1776855078447;
        Wed, 22 Apr 2026 03:51:18 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-97-241.dynamic-ip.hinet.net. [36.225.97.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36145fe05f4sm7218289a91.0.2026.04.22.03.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:51:18 -0700 (PDT)
Date: Wed, 22 Apr 2026 18:51:13 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Richard Cheng <icheng@nvidia.com>
Cc: arighi@nvidia.com, mingo@redhat.com, peterz@infradead.org, 
	tj@kernel.org, void@manifault.com, changwoo@igalia.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, 
	kobak@nvidia.com, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] sched_ext: sync disable_irq_work in bpf_scx_unreg()
Message-ID: <20260422183307.Gf0f8@cchengyang.duckdns.org>
References: <20260422100938.35781-1-icheng@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422100938.35781-1-icheng@nvidia.com>

Hi Richard,

On Wed, Apr 22, 2026 at 06:09:38PM +0800, Richard Cheng wrote:
> When unregistered my self-written scx scheduler, the following panic
> occurs [1].

Nit: you've placed the panic log [1] below the --- separator. Content
below this line will not be preserved in the comment msg.
Could you please move it into the commit msg body and send a v2 patch?

> 
> The root cause is that the JIT page backing ops->quiescent() is freed
> before all callers of that function have stopped.
> 
> The expected ordering during teardown is:
>     bitmap_zero(sch->has_op) + synchronize_rcu()
>         -> guarantees no CPU will ever call sch->ops.* again
>     -> only THEN free the BPF struct_ops JIT page
> 
> bpf_scx_unreg() is supposed to enforce the order, but after
> commit f4a6c506d118 ("sched_ext: Always bounce scx_disable() through
> irq_work"), disable_work is no longer queued directly, causing
> kthread_flush_work() to be a noop. Thus, the caller drops the struct_ops
> map too early and poisoned with AARCH64_BREAK_FAULT before
> disable_workfn ever execute.
> 
> So the subsequent dequeue_task() still sees SCX_HAS_OP(sch, quiescent)
> as true and calls ops.quiescent, which hit on the poisoned page and BRK
> panic.
> 
> Fix it by syncing disable_irq_work first, so disable_work is guaranteed
> to be queued before waiting for it.
> 
> Fixes: f4a6c506d118 ("sched_ext: Always bounce scx_disable() through irq_work")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Thanks for the fix, and the logic looks correct to me.

Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Also, scx_root_enable_workfn() has the same pattern in its error path:

	scx_error(sch, "scx_root_enable() failed (%d)", ret);
	kthread_flush_work(&sch->disable_work);

The comment above indicates that this flush is meant to "ensure that
error is reported before init completion". However, because scx_error()
goes through scx_vexit() -> irq_work_queue(), the flush can be a no-op
here as well. The same applies to the sub-scheduler enable error path.

Should those be fixed in the same patch? Tejun, Andrea, wdyt? Thanks

[...]
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 012ca8bd70fb..065660382a0c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7349,6 +7349,12 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
>  	struct scx_sched *sch = rcu_dereference_protected(ops->priv, true);
>  
>  	scx_disable(sch, SCX_EXIT_UNREG);
> +	/*
> +	 * sch->disable_work might still not queued, causing kthread_flush_work()
> +	 * as a noop. Syncing the irq_work first is required to guarantee the

Perhaps s/noop/no-op/? Though it's just a matter of taste. ^_^

> +	 * kthread work has been queued before waiting for it.
> +	 */
> +	irq_work_sync(&sch->disable_irq_work);
>  	kthread_flush_work(&sch->disable_work);
>  	RCU_INIT_POINTER(ops->priv, NULL);
>  	kobject_put(&sch->kobj);
> -- 
> 2.43.0
> 
> 

-- 
Cheers,
Cheng-Yang
