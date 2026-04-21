Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E783D6682
	for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779359; cv=none; b=mjCYlxRZ45IbIfzSF7JrvcF06uzo9IMmwuTrUZ36VJ7PnOVNhVCZ+EwCOcmjncci30wJC8rWV282tLGSRMBA0EISxbMS7aDjw7eAGTuJmdf65cGdTsAcZk/zuGl3uRpcSDvtdGTCDy0YW6LIma84g16q+bs8FQm4NKYIL0jFHcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779359; c=relaxed/simple;
	bh=8qoKHip35Qup572hgSONgzw73wNAyS4n+Pr/zPph5vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U563NqcwQvhgtsMzAmPjnX4oIRx6Ct6RzVXI0bzoTlD4iCfW2QdxnOavew85Nt8pQrKiY6S0aWB2XqtUh2LsXBylEn+/uWl8dzaoGfidoIHdazJc0M4OUK+ZWcFCiLL/H6ptwFAVtd+ds+lWBhVnQQEfRwQbLtvbFl9P+LZPO+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/MfS64l; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/MfS64l"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso2568169a91.0
        for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 06:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779357; x=1777384157; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=601dI1rtyQ8HGaSALw//901AUs8H8pC7ANBb+DfeRpU=;
        b=o/MfS64lRWr56CSWFdchYwIYtJIGkxZWwRgwY+y0XK0+57I50YQIbfpGpEwZ3Ur0wz
         f0QiSejKnQJAUEw1pnERLheBem7ybCYYZQSEFSQjCKhFq80WnS7uf81WT7+oZTaoAzbH
         l4bw0qWhuwulpbMID0HAGad4dHWSlhcMfkKZLDlmhGqUjfHuKpVyIKhCEg57vpKLOt4H
         2c8XdZ2vbGXfWLnvRuUMwzIp4ACByiCwt6uORd/zbKP6tOK+EoroMrMFLg+Zjsd8WPYP
         RuZDL5f+EiaBSkxoeMswPP73YnVfE5vVKVho36y5ySN4hqTHEpZ4PhIIUOSKL3Br3VHk
         T4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779357; x=1777384157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=601dI1rtyQ8HGaSALw//901AUs8H8pC7ANBb+DfeRpU=;
        b=FndmHAE4zV8v+aokKjG1lLwMPPdgkICDUSC3y4GssvKsU6FK9Fcq0ej80ByiVgsjH3
         B3KP2lp+lPu2mcBj+l29C9Nj9PEuYzxhAlDpPh4FXsJxOuHjhKK0UAqG6bxVy5Dp6i0c
         2eMGPvNYEhA9ayaeecJtiZjOmPCpiirli8KkGzoMIOfmanYqEYpVFhtabolOsVSIVs27
         VOzgVWoSK12ZB99izw6ESsMU92ApzRWKgU7KtqlEVuYfRyCbK5C/ubXbvlAEOdVJrw5p
         PD2Wl876l+4QPSUMppWoSHWWGugiDefRVwW22TZqvhXF/98e2gxpSGHMgE2KKr0NQ2az
         f0CA==
X-Forwarded-Encrypted: i=1; AFNElJ8R7Vh6W+7ge58L7DIeGTVTGv6cX0yzxnVV+Ea7Un5thU8h8EmZn9YlsA3som8hYWq/y1anCY3Hbm8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4ac3+pHctwcNtILq/XTQcNrT7Re3URtVdP3T03/JLrdN2AGUz
	QQ82inl0SUaWsOpcBoq+HYgclbQ808yrjJ0BJFsj2/GrHwhjUWZKunSq
X-Gm-Gg: AeBDietuVJ3JbzQ6YLt9aE6NlWOL+dxepBi8ipMywwouKsrai8rVPTFHIoEIqctjc55
	shzV5GE0Hg7Jt1Aa5fZsOw9uB/mZF1LCn0xlovXYvHYcJqeKB3KvLGWv7QD0sL2fI7UuJHM5+NY
	JksIPXFFpWNDwitVNTj/wb7kdNTT/fnr2gkYqmr6kexEk6DiXB/aVBWd5iZfRhZqOtpswzlIJ1p
	jWaQL5aOxCdLkeSmU72XnM9rT3o0PuStCq+N5CDjWvgeKNJ3vz8js1Ip9oJK7I2KOcHdYw+lsjU
	vYql5nWyysWImWwCYMDCH2aT+1bF0ajkSMgByoWmtmSofJCK2eEuxHNdsghDhU/cfFcV/um9eRI
	fDk1xc6uU2bicUOZPc4XztjrbV6eDOw03nU1q24geEnWky/6n+bgzxv53GRpCyXC44yryseBuLh
	hWNQsJDHk23FCczM3Yd4g+qs0VSyKBdKevY6HpTPuhyPDQLwWXH8rzYciXiaH8vcxq9Kxvll5bB
	vucuQISR26JcPtn
X-Received: by 2002:a17:90a:e7ca:b0:35d:8fdb:4f36 with SMTP id 98e67ed59e1d1-3614048a21bmr18676301a91.18.1776779357290;
        Tue, 21 Apr 2026 06:49:17 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-97-241.dynamic-ip.hinet.net. [36.225.97.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361419739dfsm14549188a91.13.2026.04.21.06.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:16 -0700 (PDT)
Date: Tue, 21 Apr 2026 21:49:12 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, emil@etsalapatis.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] sched_ext: Shift scx_kick_cpu() validity check to
 scx_bpf_kick_cpu()
Message-ID: <20260421213729.Gb2f6@cchengyang.duckdns.org>
References: <20260421071945.3110084-1-tj@kernel.org>
 <20260421071945.3110084-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421071945.3110084-4-tj@kernel.org>

Hi Tejun,

On Mon, Apr 20, 2026 at 09:19:32PM -1000, Tejun Heo wrote:
> Callers that already know the cpu is valid shouldn't have to pay for a
> redundant check. scx_kick_cpu() is called from the in-kernel balance loop
> break-out path with the current cpu (trivially valid) and from
> scx_bpf_kick_cpu() with a BPF-supplied cpu that does need validation. Move
> the check out of scx_kick_cpu() into scx_bpf_kick_cpu() so the backend is
> reusable by callers that have already validated.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5571f5995dd8..9e802d73f205 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -8673,9 +8673,6 @@ static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
>  	struct rq *this_rq;
>  	unsigned long irq_flags;
>  
> -	if (!scx_cpu_valid(sch, cpu, NULL))
> -		return;
> -
>  	local_irq_save(irq_flags);

I initially think of removing the guard here would left a gap, but patch
10's scx_bpf_kick_cid covers it, so

Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

>  
>  	this_rq = this_rq();
> @@ -8738,7 +8735,7 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
>  
>  	guard(rcu)();
>  	sch = scx_prog_sched(aux);
> -	if (likely(sch))
> +	if (likely(sch) && scx_cpu_valid(sch, cpu, NULL))
>  		scx_kick_cpu(sch, cpu, flags);
>  }
>  
> -- 
> 2.53.0
> 
> 

-- 
Cheers,
Cheng-Yang
