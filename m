Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E076431496
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950520; cv=none; b=I7HwSJgPJttXm0g4TM10UJc1lZREFoDX4QRv0WgjJOkByHrvCznndXq189Q0Lq8ahwybRsbx4lCEcsDIo7q617fkgYOwzFE+oHmM45CidSRkV98yN5d0vTJcECsey48PTtU5Tkx0B0n3s7NBwV2mC81YQsJEYs47Xkow8/5Fz8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950520; c=relaxed/simple;
	bh=TZ3tsMwiJUiaaTsevwJ4o+L1EGJMO6hFNrbfM3qjrPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAzdkzFPznCwrxJEZbgen7/uA+h3ogOXBfqIES/dowciTr8xRlYuW+7r+ANut/9TIN+WOVyAZ2Byy2FP7g1h7etnbSxbKKhvgMdwMfw2snO1zxZTPozyGwKuRFiKM5Nw2I6fkuuAd6161Qh77u8CUumh9F+7CdV0ZRE+pBIyN34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=uSYrtick; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="uSYrtick"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso2924346a12.0
        for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783950517; x=1784555317; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C6DMbuqOtH23SHLzkFv4+Shmk8usPkwua39wHbFqGJE=;
        b=uSYrtickZQ6QhoyvL9k+SD2GyDBsWxLde2VpVTIiFBbwd89G8dECf1zs1IDYPgBS7Q
         0g9mly4BouUL4S+dgFS4P+Tcia4x0+3D6MwuMTYgqJRb2WZZOTrJrj74+7Hv+R47CpGv
         XuAELVHPtmSMzCGS8VODLTiOSnQ2i9zHDX85wEL7501satzZUanN7cp403sG200o34TA
         FsVwfkj9H19FnR/xtTxj+C4EivfgOOGD0EbAuuAb8Yw/i+kXwbCuKAJwy9vZy4CKqema
         xnR9oax8rlW6hjjPd+r/xVgHXgPvps+Z/7NRIcisGwABmOycSeeRsV52HXoZVjCLqB2e
         Z6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783950517; x=1784555317;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6DMbuqOtH23SHLzkFv4+Shmk8usPkwua39wHbFqGJE=;
        b=cWaVOX0vkh/XWjuA91Uod1boSmUAFDMphZKe5EYKAQvVi4nDZrC09pm1kwMviPpZPG
         ExKyFjbEfIMAl7TNym6gZOxYRQdo9j+S9mvSq8rdFA8JSCy2gFPTPvvow4azG8v86a9C
         YJPsd55yHOJsxfniNXugC/kx7311hcxmGHfuwiFsoouWDZr/ZmmkgitWss15Z8BYJfR7
         PYZzAHl61K8z2Vc0/vkgQWgrdHALgWQpGtdSzAtcBjuK+3Vj587VntgYHDFFl3rPMOUC
         lLRqj+7gEq9VZwYr9ITL8GqKZ6tWKF6Jb40FNWg7MvSFM9pAWfs6yWrp9NLryS6dNair
         2kwA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9cm8OeuhGm+ktUrxW6LF6J0/mS9r1+RXOANhTkU67CyTNsUPvmAJZb+m5zdVlZxiKsM/COyYDmi4=@lists.linux.dev
X-Gm-Message-State: AOJu0YzUK9ucgnUW2wJrcj6HZJfxjHOySGwzsN5HGrvIY6vHpAu+dWi2
	8vgMberjmfEDA6q5hfoJnFA06IjNuIDJ6euX5eix7DXMxiKnwPv6lua+QRrF7Rx33bs=
X-Gm-Gg: AfdE7clrR2aedTjMDFjCzdexZCBc1XxfvwcVEt9b8Vg25L3p3zly+lylGqlWJdq1oyL
	AnNKtK/YyLxVsjHyxk1RY5EHeISeNt3I/QOjTQ2OuY/S0Qv+86+0UPIJyHTPMRVQsDsT2kM1UZ5
	9ACe+/BxSGd4AqvNxJOiDH5moItjbu/80mFSv1fI9T0HkAkgvqukdx6iTUVdydSkCbd1qimXFe1
	ZukrsbVnz9m9qyZ5TrKhDhbSzpkywTtxVFYNxYBBP1p6Xo191+MnvGUnuOdsfB6xrMoCnkfa8eh
	SnpOnm4LNIywpckt7L9trJkhAVO8jCBdKd9/Bx4hYwEuSzgO1ShEX0ORYv/7hwO4l+ZkYx0N3lP
	z72aI7JgFpGv/If45MGX0Fr1AuZ9EKyaiYkpEXayX3y2CratVl+l16r0ejzWeNk78KYVUj0R7LU
	fO
X-Received: by 2002:a05:6402:3585:b0:698:62b7:a4cc with SMTP id 4fb4d7f45d1cf-69c5ef82f71mr4143024a12.5.1783950516676;
        Mon, 13 Jul 2026 06:48:36 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:1f19::319:116])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69aa6dba523sm9753669a12.0.2026.07.13.06.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:48:36 -0700 (PDT)
Date: Mon, 13 Jul 2026 14:48:35 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Edward Adam Davis <eadavis@qq.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>, "ziwei . dai" <ziwei.dai@unisoc.com>, 
	"ke . wang" <ke.wang@unisoc.com>, Matt Fleming <mfleming@cloudflare.com>, 
	sched-ext@lists.linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 1/2] sched/psi: Create the psimon kthread outside of
 cgroup_mutex
Message-ID: <alTsERFTlUKCLw4C@matt-Precision-5490>
References: <20260712174619.3553231-1-tj@kernel.org>
 <20260712174619.3553231-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712174619.3553231-2-tj@kernel.org>

On Sun, Jul 12, 2026 at 07:46:18AM -1000, Tejun Heo wrote:
> a5b98009f16d ("sched/psi: fix race between file release and pressure write")
> made pressure_write() hold cgroup_mutex across psi_trigger_create(), which
> forks the psimon kthread for the first rtpoll trigger. As kthread creation
> depends on the whole fork path, the commit inadvertently created a lot of
> unwanted locking dependencies from cgroup_mutex.
> 
> sched_ext got hit by one: its enable path blocks forks and then grabs
> cgroup_mutex, so a pressure write racing a scheduler enable deadlocks, with
> every other fork piling up behind.
> 
> Fix it by splitting trigger creation so that the worker is forked with
> cgroup_mutex dropped and the kernfs active reference left broken. The latter
> matters because rmdir and cgroup.pressure writes drain active references
> under cgroup_mutex. Publishing the trigger last keeps error reporting
> synchronous and preserves the of->priv lifetime rules.
> 
> The trigger registered in the first stage pins the group's rtpoll machinery
> across the unlocked window, leaving only creation races to resolve. The
> catch-up poll on installation covers scheduling attempts dropped while there
> was no worker.
> 
> v2: Retagged sched/psi (was cgroup).
> 
> Fixes: a5b98009f16d ("sched/psi: fix race between file release and pressure write")
> Cc: stable@vger.kernel.org
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Edward Adam Davis <eadavis@qq.com>
> Cc: Chen Ridong <chenridong@huaweicloud.com>
> Reported-by: Matt Fleming <mfleming@cloudflare.com>
> Closes: https://lore.kernel.org/all/20260710100441.2653477-1-matt@readmodwrite.com/
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/psi.h    |  4 ++-
>  kernel/cgroup/cgroup.c | 23 +++++++++++++-
>  kernel/sched/psi.c     | 69 ++++++++++++++++++++++++++++++++----------
>  3 files changed, 78 insertions(+), 18 deletions(-)

Tested-by: Matt Fleming <mfleming@cloudflare.com>
