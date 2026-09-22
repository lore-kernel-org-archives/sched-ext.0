Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB50654DAD1;
	Tue, 22 Sep 2026 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092611; cv=none; b=MwjjL4Zsvice/rohR29CNCHua8oZl1iKKTvYjvyU4Up7lAmQBvKBvOy11xn1aNtc9hOKs0yLoJwdFsZ8D2pfIMJRgcbAAu0lihqB/Sn+vUUNeVXYDpGXfap5TP/oWVyFrp7wUJvN8RjxFtj1mmveLNzz0aumfhTtPYYlyMPLOzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092611; c=relaxed/simple;
	bh=h/wxxKkF507vwz/qvZRNWjR9FaH6wTAPm1MD4BVxWcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exKW/vvGAoMLOIpAmUEMHXuRajxyy6XJRlOGiD62aAyFtqyiGPTrGDHuSDuNPSK86fvK+HH8wBJgZSUklfTiX4wD1iMYmWgX75GpK3YR2Eu0YDDN+DZHHoOHg1Qt2NVjhUTqGl7Or+NgGbg0Pljpsgln7Tzckb3b8jgJ9fYGAaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOhCoD9A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOhCoD9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682A81F00893;
	Tue, 22 Sep 2026 15:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092610;
	bh=lSJlVhRX1QkdHAHd/Bek1gGAYVpKimqI7Q+LfxvvZzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gOhCoD9AyGxNCeJ84UP2D6REmDLjVLfVImTyIbVstTRjzVmganH8n13Ria1uh1JL5
	 CjwYIK+qAhwqmwlHqoneYTQk3QCBD4UbsGn0RGSp4/Kmm4zrHpyeAYZzZsiINorF48
	 1O7kE5HYIk6sD9qKXAhJqXk5z9ZpVEPbh18y98Q/6IU5NosKLAEsWHAFDWwRbGLScr
	 SyBm4PvhxVH7XSFc1kVHwCjy2w+WQe/VXruz6cJgpmyIn/uSPlyVQThZkBsyKdAUFm
	 hXtgnFEHShtDnFDktJX5ITHi7TeRmkPkeCgzSLFvmLOSRK5Ag1oCAuomVjq2Hf6qPA
	 acmNE0Sw1bDWg==
Date: Tue, 22 Sep 2026 05:56:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/sched_ext: Add SCX_OPS_OPEN_OPTS for schedulers
 using open opts
Message-ID: <arKlQTkhFAOxaPGS@slm.duckdns.org>
References: <20260922031618.2858-1-zhaofuyu@vivo.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922031618.2858-1-zhaofuyu@vivo.com>

Hello,

On Tue, Sep 22, 2026 at 11:16:18AM +0800, Fuyu Zhao wrote:
> +#define SCX_OPS_OPEN_OPTS(__ops_name, __scx_name, __opts)			\
> +	__SCX_OPS_OPEN(__ops_name, __scx_name,					\
> +		       __scx_name##__open_opts(__opts))

Can SCX_OPS_OPEN() just call SCX_OPS_OPEN_OPTS() with 0 as opts?

Thanks.

-- 
tejun
