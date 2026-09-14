Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92C3FF1CB
	for <sched-ext@lists.linux.dev>; Mon, 14 Sep 2026 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397765; cv=none; b=nJDtywdI0+Ztk1yw3MT3Izr6bsEtLgSiCaPi7xX6cV7ewqFEBtqtHsOhZpFRhZKQLy9e8IaPSp5wpa4X1i9WtkYwHwCKx5BT14DoU8lBjg9+Wkdt/RLwNYpgAbPpnLN6Ug2jmZYjkbM70RmI8tHcU6neAD99oHWOBEeWEq9adA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397765; c=relaxed/simple;
	bh=3ovd325btL5vmESfv/dro48ZvUDYxcKcBGU5gE6h0fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvwBgF68v8S3uV2K+Wg7VEdUH2pLL3La+wZ9overeZF4o4NiJ0piCugazXFNM633WUWs8wZaSRqRiEwplrgcVyUr6DsHY8Zh3I/hgLxX8GbOOA62sV0ZuEloabh9MpzViztL82Ncr52pJ7GTu44hDeXVh9QakYiNG/hFD8OaFYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ro3nKHak; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro3nKHak"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso35889285ad.3
        for <sched-ext@lists.linux.dev>; Mon, 14 Sep 2026 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789397762; x=1790002562; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f9UGDeYUwW5o89QNBV92EL1KQUC5ezZOIPmykoNE46U=;
        b=Ro3nKHakK9pSE3MxkUA/VJjZHYc5KlQf3hRiRxfiT2/+2lgBTkd0XRvhd/GYrOEytx
         Zo59khvv3Wkep5Khzu4al5rMmYOgdDNE9pWjD8pjurTLPCmPvwRCaFF/GlnFG+BCPnJc
         ZVIAYJCVKTq3NRE6XTmYjZdami3wj3H4Y0xd0O8NTy0fGhSCK4NOG6OZ9rn2yo/nqAG3
         L7ueQ29HVHbBeXiCGxT/RihU1dWOoKl1XMM9fWRQXrI+FEEfMcQWrWlAU9cEZ+hoennC
         bLeE3zv6BSLfkY0BNzuhT/wklTG54LAtkGnql4Qk+PFDfDsIqP7JfYtSRyzfoCYQZkBm
         Lf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789397762; x=1790002562;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9UGDeYUwW5o89QNBV92EL1KQUC5ezZOIPmykoNE46U=;
        b=cuIgFONyi129N1ErVbWrCbA+6c9gyxYOWJFojZbZBo6Syi/xz35agmymRxB3/V8ysK
         H0L2UWcfJhSBtmItcIs7BdLxDhe4fs8H1hy5tCLWu/jEpsu0uP3jwAVaQDfzvi8ePakN
         CxUjSnPbZaxZhGw2fCpfnqIoK+MGAje0o0b5zpSsfyuD7omrkH/OElPJpXq6y7NVFPI8
         k2TNfHlO39CL0zBOMhL0IM1u4E+JFLZQrVkkFdvcWqxMzo+p5XTjC82TpcE1YXcYiXKL
         ADeQK+vZ2SvQrUhN1g/EWKofoHa8j5ZUVxaniIlkeuR+JCFKpedFTZa7hVAJVMBA9yhN
         c91Q==
X-Forwarded-Encrypted: i=1; AKwUvByS34XAUlu7fNrDRj6IoPnc1gy1Yf5TCF0EHueuIbaUM4B34odDhP8oNue2jxceSYwA0w2mIg9w3Z0=@lists.linux.dev
X-Gm-Message-State: AFuF++k2RVFT2Tn1hOLQQU4ExHOHF6Jd+qrwtC+kmQ5c+Q0jP24VDeky
	zIjHgjq1PIyHoE3YOB82KUriPyM8tUOkDxrEVQZ4j+u5k5+eDlOq2wrc1lYaVg==
X-Gm-Gg: AYBFou3wDfBw1H4C+qlCyAXsCux91pdKwvLYLg/GaJEgjapjX3aW6DrNBYrKpFB7oBZ
	dqCwn1U0xF/f/W9/c4X5+T2Me81PFRAygxQRCKIEAWOzXJplWHzQOnljgS6K2pI/KbVpylyIAZV
	mKR5lXuTdvS8VjU5Cw6sf47oM1KNY9wxTbPgzvCkeJZ3R21iNS48ih6fqTL4g+PerpI54GW/xbZ
	+xokBY0PsvfRBFGLWdv01dDN8HhAJH3rj8ECpp5Xz4gLv93ImTFHAToqZo8AXyqAlcKQS9tlZql
	r+5+AAJOfbs8o64DRoNZTdsNJYtDqs1KlcMcSWCGNKAvyBSge3APIc41+pEi2MfB1sjJtwp8qmI
	os1lx2V9/eJGYD+vcMLGRQBp3XMaObFd+oF8oEm3REhF1nQ4C/nzGW4pAGYHff9EVyPCf/+GsHp
	bG5SWm4LKI1oS/njkvV1bQe1EueTiW5fAAVychI1uYKdK0O0E251KFnqG32K9miCfUh5W74mCXo
	ZnYhJT/Wl5zuPlOOcn9XvcLcgEikfeRo4JC4OdVbBF9+mPXhyj+ja8W3Ez0i1/kne4xQLT/spt2
	ttKoavXbO7Q/WjQ/+IU=
X-Received: by 2002:a17:903:46c3:b0:2dd:753a:4d4a with SMTP id d9443c01a7336-2dd753a52d8mr10481015ad.16.1789397762008;
        Mon, 14 Sep 2026 07:56:02 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-226-250-24.dynamic-ip.hinet.net. [36.226.250.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfce707sm51421485ad.55.2026.09.14.07.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:56:01 -0700 (PDT)
Date: Mon, 14 Sep 2026 22:55:56 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add lazy preemption tests
Message-ID: <20260914225115.Gb03c@cchengyang.duckdns.org>
References: <20260914084955.1798562-1-arighi@nvidia.com>
 <20260914084955.1798562-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914084955.1798562-3-arighi@nvidia.com>

Hi Andrea,

On Mon, Sep 14, 2026 at 10:47:46AM +0200, Andrea Righi wrote:
> Add trace-based coverage for immediate and lazy preemption. An fexit
> probe on __resched_curr() records the requested TIF and the current task
> slice, while the stopping callback verifies that the task reaches a
> scheduling boundary.
> 
> Exercise kick requests individually, in both orders and combined in one
> call. Verify that immediate preemption and WAIT take precedence over
> lazy preemption, and that combining immediate and lazy enqueue
> preemption follows the same rule. Also test overriding the expiry
> default in both directions through scx_bpf_task_set_slice_expiry().
> 
> Extend the NO_HZ_FULL test with infinite-slice victims. Verify that lazy
> enqueue and kick requests restart a stopped tick and make forward
> progress. Keep invalid kick flag coverage and skip modes not exposed by
> the running kernel.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

[...]

Didn't have time to go through the whole series, but I applied it on
for-next and built with PREEMPT_LAZY=y and PREEMPT_DYNAMIC=n:

	INFO: preemption mode unavailable; lazy TIF was 5, immediate TIF was 4
	ok 2 kick_lazy #
	INFO: preemption mode unavailable; lazy TIF was 5, immediate TIF was 4
	ok 4 kick_tick #
	PASSED:  6

> +static int active_lazy_mode(void)
> +{
> +	char buf[128];
> +	FILE *file;
> +
> +	file = fopen("/sys/kernel/debug/sched/preempt", "r");
> +	if (!file)
> +		return -1;

sched_init_debug() only creates that file under CONFIG_PREEMPT_DYNAMIC,
and PREEMPT_LAZY can be built without it ("select PREEMPT_BUILD if
!PREEMPT_DYNAMIC"), so the two tests pass without comparing the TIFs.

Would something like this work?

	if (!file) {
#if defined(CONFIG_PREEMPT_LAZY) && !defined(CONFIG_PREEMPT_DYNAMIC)
		return 1;
#else
		return -1;
#endif
	}

Thanks.

> +	if (!fgets(buf, sizeof(buf), file)) {
> +		fclose(file);
> +		return -1;
> +	}
> +	fclose(file);
> +
> +	if (strstr(buf, "(lazy)"))
> +		return 1;
> +	if (strstr(buf, "(full)"))
> +		return 0;
> +	return -1;
> +}
> +

-- 
Cheers,
Cheng-Yang
