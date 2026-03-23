Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3BE390CA5
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269971; cv=none; b=fC76auY6cHx2d+5AcNdcza8n4chVE5fpCQUs96i+mmGYl7Iq5HgOjHBjw0RcobEBHGqolftz/1MyeVDsP64WZ7GoTMVx/43t3m1l80PdXe3naTOjsE5WgluZ/j19zsD0VFZAHOdHscQFauocY3jEihiUbV4/LGXu84z7g+Q6OkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269971; c=relaxed/simple;
	bh=N+ypMCjm7s8T4QZhxg7opdPFA27uFmz/IiG49aSKt1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpN/hNnG1KQTb7nzPMgNR5DtcDBNm0/Pwa6mAf5Vy0qnQb6M7k3oC4ggT8mewmBGjNo+D877Pohx0HAPuGpK17xtCcGiMDUrkMsGZAsoKHNUKrXFf5fdeuiHmGoVlwqQ2QGydhQE+OjqIkKEJOEfTSCH4+KCgjIaMNPPbZARou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrtZoVQq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrtZoVQq"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so1089151b3a.3
        for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 05:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269970; x=1774874770; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bOLUHUlwNVbwlPqt1T8nZLMEyPfyV5o5YQnecy4Tgrc=;
        b=CrtZoVQql8I+2ZxM+T/bcirmuVOtLLvt9I+8Z8oYio+Q3Fn8JxYL0dgA9J92fepguo
         xdZTItgtw0dOAUF+C3GSgI+A6D08faSorzTOkF/YNRAw9bli4dgQNR+cFhfHkRPuXyMK
         TwaTOKWz0KIerMGbJTs/BrfQNEOPCTQ7y5rvtHH93uGEBgCNE4csLNMTKILC9m5yUm5E
         h4aQmqwWuRNmS9xN59O1Rw8F/+/ll6cj7Uvv9FBn0yWgyu+BgBan9qdimXZcmzGim4uO
         6NTSpjN8c0lx8ZlkOlKaIMVTgotbGxUj4oet/i0MNCnGdu7BHztkWU+OGETvgELGAYq4
         tepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269970; x=1774874770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOLUHUlwNVbwlPqt1T8nZLMEyPfyV5o5YQnecy4Tgrc=;
        b=QsHmn3JO+Q8K5TYYWmQNPJi5yRvM5jl2DsSp5KduCDhfing/MRMsv2HwgM1z8ryw95
         RyzdM9Kjbne/28bPenDhunDiqFU8OqTWL2gNfe5+y/llpq6naCb68zTyuNvZ1Att7+M8
         4TgNCIZvV2rBIbSS+lO65X/oAzpTh5+pqbgoAIvpQ47DGg3uLHc+95g01zb/LUqlC1YY
         +wZY7Uo5373mmBAIEH1XDQcNbkPf4BVk2mf/iG8eIXPThrEJPMFBAZ+5JUaH0Ytj3pZu
         ojs56BM/dIEZU1yb4JLyRMfMJYZ0thJ4WHccHEQbcqQlSgIFc0ZIiPpy01j4diLEumpd
         L6HQ==
X-Gm-Message-State: AOJu0YwAb959cIMm45HyrWEHRJvNUw/1hWiss3WvLjalR0eiBGgg0UnH
	nB7cQQeeZ3zh+JoR8rFd5aCMl4vMmIgKtywxQt95kzb9maC1ZwnBdycd
X-Gm-Gg: ATEYQzyaVAbJDj+E/NgMb/ubV959OT0Zzn3RqEFOZZo2rhs+RFKQWvGdXQuP6OVaTQU
	RVxp8OCnQ5gBVFFzYGrrTXDFnf3vchJ04PAr8yrAu6tIB1IRuQo7tjKkiA6mJdkboRqoprI5LTh
	3fjPrY8gb8NH1Fgn5bbnY7xK/Fd+qN8Bncy3BeabnThCgdvWfUK4lsP6P9AIONYHQZTqsL3NreJ
	HDam0r6npOGhSNxlr40td2/bbADK8pJCe3cbP+8lopvd11+CLdvEqpMsDmzaFZbw1d8N/jLu4MJ
	L3fXS2gjdzsNDe7U5G/BVIAlbZENAMDIvbGzrGpg5UhjDOl5vl1OLKA2+PCgxntOYbcPIWFagZY
	wS+M0EXyOhlOpLXoczAwo3MIYN5NiC1K6GJ4jd2JcQZ+F1s+GyI2J/1sX9dwODtpdt4gxfV0OfG
	+LAgLb4Aa1iVcxPD7/ohDfjYurjoKP2uw+28bSuMT/loDJCXAQ6UvDTE9YUEhMvzB/n0hwWtw=
X-Received: by 2002:a05:6a00:2e97:b0:829:7a62:5f with SMTP id d2e1a72fcca58-82a8c219da5mr9527079b3a.9.1774269969800;
        Mon, 23 Mar 2026 05:46:09 -0700 (PDT)
Received: from eric-acer (36-225-109-46.dynamic-ip.hinet.net. [36.225.109.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409f409sm9306107b3a.31.2026.03.23.05.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:46:09 -0700 (PDT)
Date: Mon, 23 Mar 2026 20:46:05 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.1] tools/sched_ext: Add __COMPAT wrapper
 for scx_bpf_sub_dispatch()
Message-ID: <ibfxe4h3f2b377oviswom7cqjerij4d2rqjxl5utj4gsehkfrq@lwk2gwqsshap>
References: <20260322144433.1649092-1-yphbchou0911@gmail.com>
 <acDxAON9TXIZDems@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acDxAON9TXIZDems@gpd4>

On Mon, Mar 23, 2026 at 08:51:28AM +0100, Andrea Righi wrote:
> Hi Cheng-Yang,
> 
> On Sun, Mar 22, 2026 at 10:44:23PM +0800, Cheng-Yang Chou wrote:
> > Add __COMPAT_scx_bpf_sub_dispatch() to compat.bpf.h so that schedulers
> > using sub-sched dispatch can build and run on older kernels that lack the
> > kfunc. Guard the call with CONFIG_EXT_SUB_SCHED and bpf_ksym_exists(),
> > falling back to false when unavailable.
> > 
> > Update scx_qmap to use the new wrapper instead of calling
> > scx_bpf_sub_dispatch() directly.
> > 
> > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> > ---
> >  tools/sched_ext/include/scx/compat.bpf.h | 13 +++++++++++++
> >  tools/sched_ext/scx_qmap.bpf.c           |  2 +-
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> > index 83b3425e63b2..f24b9a1c75ad 100644
> > --- a/tools/sched_ext/include/scx/compat.bpf.h
> > +++ b/tools/sched_ext/include/scx/compat.bpf.h
> > @@ -108,6 +108,19 @@ static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id)
> >  	return p;
> >  }
> >  
> > +/*
> > + * v7.1: scx_bpf_sub_dispatch() for sub-sched dispatch. Preserve until we drop
> > + * the compat layer for older kernels that lack the kfunc.
> > + */
> > +static inline bool __COMPAT_scx_bpf_sub_dispatch(u64 cgroup_id)
> > +{
> > +#ifdef CONFIG_EXT_SUB_SCHED
> > +	if (bpf_ksym_exists(scx_bpf_sub_dispatch))
> > +		return scx_bpf_sub_dispatch(cgroup_id);
> > +#endif
> 
> Isn't bpf_ksym_exists() enough? The CONFIG_EXT_SUB_SCHED guard takes effect
> only when we build an scx scheduler using __COMPAT_scx_bpf_sub_dispatch(),
> instead we want to build the scheduler anywhere and then the BPF verifier
> should evaluate the availability of scx_bpf_sub_dispatch().
> 
> Then the symbol will be resolved by this (from include/scx/common.bpf.h):
> 
>  bool scx_bpf_sub_dispatch(u64 cgroup_id) __ksym __weak;
> 
> So, IIUC the #ifdef CONFIG_EXT_SUB_SCHED guard is not really needed here.

Indeed, this CONFIG_EXT_SUB_SCHED is redundant. 
Thanks for the explanation!

> 
> Thanks,
> -Andrea
> 
> > +	return false;
> > +}
> > +
> >  /**
> >   * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
> >   * in a compatible way. We will preserve this __COMPAT helper until v6.16.
> > diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
> > index f3587fb709c9..dd44d8db0341 100644
> > --- a/tools/sched_ext/scx_qmap.bpf.c
> > +++ b/tools/sched_ext/scx_qmap.bpf.c
> > @@ -490,7 +490,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
> >  
> >  	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
> >  		if (sub_sched_cgroup_ids[i] &&
> > -		    scx_bpf_sub_dispatch(sub_sched_cgroup_ids[i]))
> > +		    __COMPAT_scx_bpf_sub_dispatch(sub_sched_cgroup_ids[i]))
> >  			return;
> >  	}
> >  
> > -- 
> > 2.48.1
> > 

-- 
Thanks,
Cheng-Yang
