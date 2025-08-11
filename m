Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [46.235.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835E92459EA
	for <sched-ext@lists.linux.dev>; Mon, 11 Aug 2025 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923333; cv=none; b=UsGr8vdAKTa+NUn+gmE0KsEUskYfGl089RNVh0kmt8DJ79vgQBiXIM3eLxF1UslXDFWYS1YYTl8fAZFjk83hh+gA4bMGaCauJ+q+NBbVV8eC89AsEiXLQnQDMVxUgNvyCGRYTvLucbvqqBdTxIX2ywUykIk8XeKpV17mSlMN9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923333; c=relaxed/simple;
	bh=U9o2H+Q0J4k2x52U2kiwTJMstpnIkm8GJPdkKyQaViw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MO+qR+bJtoAdpfxFzdsJ3a5IalhdWjLSXvthjNmdBKaWidtUnCj4oupLmynrdlEx1hXjqDbdZPjzTGqciAUizVYJRHMkpGkeOj7v4Hk/HcwF7GKyJQzQzpNZTFzSDkFHLD7ZVLbd0OgKeecYntWdftSG5+eFjODDXA8iqsba0Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillion.co.uk; spf=pass smtp.mailfrom=hillion.co.uk; dkim=pass (2048-bit key) header.d=hillion.co.uk header.i=@hillion.co.uk header.b=J5KoFZEO; arc=none smtp.client-ip=46.235.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillion.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hillion.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hillion.co.uk header.i=@hillion.co.uk header.b="J5KoFZEO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=hillion.co.uk; s=mythic-beasts-k1; h=Subject:To:From:Date;
	bh=U9o2H+Q0J4k2x52U2kiwTJMstpnIkm8GJPdkKyQaViw=; b=J5KoFZEOs5dzJdwzFEJpsKMAVm
	NeOYuGLdS/4pGTnLVvdLk3Ofo9FfTJxEvNosp6luCyjUuBO51v6G7SSVAieN7PjcncYiozkZg0zRZ
	xt51/RMVUCQVmoHwKMC4/cjbOGblRyAaKVUYxm/cmTSd7w3E/el3vzvGKi5y8urfhGjM/lUbh/9eY
	4w7LOBPOQs7yM5LKQ4ETx5MA4SNInASQT3ccrfnGen50iLFlLudgaWpUeP58lNUoDb8y5quqw3pRu
	0oznmi42UwGpSWVSP34vK04SYtJEohbPY47D4Yf9nB3bZn9r3Xx8PYw1uAS8UKQywTDL0e35rDHS8
	oUhwo9Vg==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jake@hillion.co.uk>)
	id 1ulTcn-004NC3-3B;
	Mon, 11 Aug 2025 15:35:46 +0100
Date: Mon, 11 Aug 2025 15:35:05 +0100
From: Jake Hillion <jake@hillion.co.uk>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	void@manifault.com, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	changwoo@igalia.com, hodgesd@meta.com, mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v3 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
Message-ID: <y23etey3foin5nrxgj6e4g373b3ap6oxqa5rrvuvwyus3umw5s@bgh3d6uuga5t>
References: <20250805111036.130121-1-christian.loehle@arm.com>
 <20250805111036.130121-4-christian.loehle@arm.com>
 <aJebkj-neVJNKEJ4@slm.duckdns.org>
 <aJh6BWX7rYCNrzGu@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJh6BWX7rYCNrzGu@gpd4>
X-BlackCat-Spam-Score: 4

On Sun, Aug 10, 2025 at 12:52:53PM +0200, Andrea Righi wrote:
> Yeah, this is not nice, but they would be still broken though, in PATCH 1/3
> we force schedulers to check for NULL and, if they don't, the verifier
> won't be happy, so this already breaks existing binaries.

I ran some testing on the sched_ext for-next branch, and scx_cosmos is
breaking in cosmos_init including the latest changes. I believe it kicks
off a timer in init, which indirectly calls
`scx_bpf_cpu_rq(cpu)->curr->flags & PF_IDLE`. This should be NULL
checked, but old binaries breaking is pretty inconvenient for new users.

As Andrea says, this is the already merged patch triggering this.

Thanks,
Jake.
