Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DD640DFD8
	for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774161824; cv=none; b=Elzn9CSfMM1vOLgsRuyoWmXAsuouj/xFrtuBg4RGH4RE9MvySe5xWb/g/sBrBWixaWrFKm15Rh1F0DagIga3HPsC6zZFSWe+GX9ffGG07VTkVi2bc2mnP0Z8AZ1TA+gos5v77CrDtcJjR68UkZJl45zLhWu+b7fTmbmUvzGE3kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774161824; c=relaxed/simple;
	bh=AlQOOsU3trck99y+WXTgIMyu2zY0YpjrzATN2KTv3e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJzqL6ag9aoOIYcOuRkW8UPsBqMwvdt38YlBDjeUKE1z92gNrZe7H5dRE+LDuBnhDVXNi4Vo8GYfR80gLjeY6VyjuXBVuODv/wy6rl1YQenz+M9z/PJJgUAcU5CoEce6g/vsenKNGSRLkuTe/DfaCkYOab6quHMH1ciNh13Tm64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOPnE6xM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOPnE6xM"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82a646c96bdso2484251b3a.2
        for <sched-ext@lists.linux.dev>; Sat, 21 Mar 2026 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774161823; x=1774766623; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Unw1cBi8DuxlUUwtUXs9vnhnayEAr+oY5pq6t8f47I0=;
        b=OOPnE6xMXZFJ6/y0jFopgBJtr2+POT2QOOA5sB7gS/mRbq+g6cbkusfS8GNR5teNM7
         XpnWzTf7W1QwdzMkxzEfZSnUZYrDvlL+VJZD45u5HFs/cwtNVuTE5r6GVdGv1M6KnPKX
         /cXLGEEV6PhtQOYax8Piq0g1iuNw7n6wX86BxW1kWxiJVZAt+xKVOGaOwvDt4uRtgIsM
         XBUTTnJ/K+3zsh7hz9Sd8QkkufNlN8PqoEMVWdNs9ifYe9RamXslIo6mjVM0eSE4b60q
         T5/vHODOe4cLZAUkR0rkccFk+BRomvysYr2+pjmtmtAzTRhpSdhmdOIz1RBjnaj9fnFA
         1K/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774161823; x=1774766623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Unw1cBi8DuxlUUwtUXs9vnhnayEAr+oY5pq6t8f47I0=;
        b=hrVzBiCaUXB0cNFJduZyUzm8kataYbQlOt1ceSI4JJVfpC/cYL3aetqhePXLvZ2I58
         sriNyI00XLY3IV3M5IHrOSG7e+agoM/tJHwk8YHDupGaivtqvZ2q/+nzrs25VZLHMyU3
         7XmBGEFd3d4qc18JauH0WILTnZKrgbMqHIfDStEcFZ3D5zYNYSaekg0vfvAuvyW+Zan0
         vN8OnaaCpJ6vrK8shMx6lnBUiZhvMu7qtf0e87XyR5fvAh834GNmZgeCdp7heBvJFVrs
         MmoWKfPgC/2fv+RVF/+v8ZiG8E1FA3SDWNM8n7WdROSAU45T51W7h2OajzVYDmmOqClI
         6t8A==
X-Forwarded-Encrypted: i=1; AJvYcCVtryOInJUQ9XBinqalZFA93l2EEwtCIxZIUzzxIUi4xzxrFATwJYCulbNKQcUeW7DMtZX7fv4hSBM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxA5aT9OA4dV1Xg1e7nZvn+sJ0hYQNre6/p2bCx+M9cG2r/ktOy
	0MuKTzs+VlH4xvl4Ww+vLvN7GTj6qCifGBZzx/3T5g7Mr3420iXZj9u8
X-Gm-Gg: ATEYQzyQ4eFGnZN5n6ukTVjesucjLmNr2ltFyYCNuI6HVrtjFHKYBK4DMpJCAFfmpAo
	FZDdp/5HDMebIbzASuRixEBRXVrE1+3lB6opOnI5DVpjyKOhT9m6eGIGS2Q1+purH6Pu45xj1rh
	5MB6aYdnVCWQpQgbsvuFk9vmLWYgyy43PJ0tEBOPQfikqm9gAouzCqbGfrX2vG6j+MThRbItrf/
	xKDmxZ+/Hwxb2VteP/nEtA1mNKVKeeO3Kd99IWz851u0AUmEI5phIha2oK3+udZg9m8QTafEeFb
	HRZwSpOQxk33jcQn7CHm0STOBlxj/GX6y05DvebZd7k5X7CmEScd4PUOk6+IzLPX5DiUGismCWx
	x7Osm0uQyeheBM6/Ls7gfOmUZQxcwm2X6wlUlywCkSuht7L7Hv2oGOZXyEtNWbGIRi2TOquGGHe
	PkRCBsGFY4+g2biNlVreMUI3+Ao7AMn8VvQyANv8Q=
X-Received: by 2002:a05:6a00:4f82:b0:823:d58:c4ab with SMTP id d2e1a72fcca58-82a8c209bbbmr6634325b3a.2.1774161823042;
        Sat, 21 Mar 2026 23:43:43 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:e49f:fa98:a4ba:8111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c0f1sm6459876b3a.38.2026.03.21.23.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 23:43:42 -0700 (PDT)
Date: Sun, 22 Mar 2026 14:43:37 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, sched-ext@lists.linux.dev, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, 
	kernel test robot <lkp@intel.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix build errors and unused label warning in
 non-cgroup configs
Message-ID: <ufzoowbj4ccdsmffpf6voxosbgobnm26piyiqwykiqwyedxlee@fgbhbeexzmws>
References: <20260321070605.691776-1-yphbchou0911@gmail.com>
 <ab6sqIW4p8QKYQXA@gpd4>
 <49aeada41a0e78e9673f053806321df3@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49aeada41a0e78e9673f053806321df3@kernel.org>

Hi Tejun,

On Sat, Mar 21, 2026 at 09:10:03AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sat, Mar 21, 2026 at 03:35:20PM +0100, Andrea Righi wrote:
> > This looks like a false positive, the kernel test robot likely tested
> > with a manually crafted config, so I think we shouldn't apply this
> > patch.
> 
> It's not a false positive. CONFIG_SCHED_CLASS_EXT doesn't depend on
> CONFIG_CGROUPS in Kconfig, so SCHED_CLASS_EXT=y with CGROUPS=n is a
> valid config. I reproduced the build failure using the bot's config.
> 
> The issue is that CONFIG_EXT_SUB_SCHED is def_bool y depending only on
> SCHED_CLASS_EXT, so it's always on. But EXT_SUB_SCHED fundamentally
> needs cgroups (cgroup_path, cgroup_get, cgroup_put, cgroup_id, etc.),
> so the missing dependency is there.
> 
> Cheng-Yang, can you send a v2 with the following approach?
> 
> 1. Add CGROUPS dependency to EXT_SUB_SCHED in init/Kconfig:
> 
>     config EXT_SUB_SCHED
>             def_bool y
>    -        depends on SCHED_CLASS_EXT
>    +        depends on SCHED_CLASS_EXT && CGROUPS
> 
> 2. Guard err_stop_helper with #ifdef CONFIG_EXT_SUB_SCHED (only
>    jumped to from within CONFIG_EXT_SUB_SCHED code):
> 
>    +#ifdef CONFIG_EXT_SUB_SCHED
>     err_stop_helper:
>             kthread_destroy_worker(sch->helper);
>    +#endif
>     err_free_pcpu:
> 
> 3. Guard cgroup_get/cgroup_put in common paths with the existing
>    CONFIG_EXT_GROUP_SCHED || CONFIG_EXT_SUB_SCHED pattern (matching
>    the root_cgroup() / sch_cgroup() stubs):
> 
>     err_put_cgrp:
>    +#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
>             cgroup_put(cgrp);
>    +#endif
> 
>    and:
> 
>    +#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
>             cgroup_get(cgrp);
>    +#endif
>             sch = scx_alloc_and_add_sched(ops, cgrp, NULL);
> 
> I verified this builds clean with both CGROUPS=y and CGROUPS=n.
> 
> Thanks.
> 
> --
> tejun

I have sent a v2 patch.
Thanks for explaining the dependency issue!

Link to v2:
https://lore.kernel.org/r/20260322063955.951848-1-yphbchou0911@gmail.com/

-- 
Thanks,
Cheng-Yang
