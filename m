Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBE28725A;
	Fri, 10 Apr 2026 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775852024; cv=none; b=dAT0lqUnopU3LWqDvK3wU2mCTzoVxXgUgqYPS1p6UIcHyn37OVes6yT+j+wroOIMVTTImpFOWW6blpmZarJUCLYFzoSw21tXz24gO3Zo3ZJ/SD5hab8c772drzczyiR5OIrrw1pwctkt+at8vmucVXCtk3ZMFjg1KvEHf+upCnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775852024; c=relaxed/simple;
	bh=7M2xte1k/+sRAKglrTZkf5AIqNzf6aGbbtFFR0SWXTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq6UFMHcedq7CHa/QWx0GSrAqsEKoFb2Zq09tCsq6h9a7Db9G70OTrYZXeIk8cNu6xgK6F6Yy3exPoTQ6N60NTTxGiw2H31S+xgVdr1D221H/FR7F/ESyGBAy5OzVoYMPouHkf/br5uNke1FgXO2doL9/VBNo820AEfxl2JADSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcRguaG8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcRguaG8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722B2C19421;
	Fri, 10 Apr 2026 20:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775852023;
	bh=7M2xte1k/+sRAKglrTZkf5AIqNzf6aGbbtFFR0SWXTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcRguaG8KLsk3wv2PzWyphyKkJGq27wwlYypKXDq8cIQn5Y1ZGNFqpiQ2oAxKx1wi
	 LJTNC6ry/Q+NsosC26Q8SaBnCOP/5TVl6bFTd/vhY+WNUGujSuqYKx1Nfye08U2+hz
	 GUEPbplX40VR4EkTFUjtgYAwWpewVqWwpSC3fJIErAm3udEKd0QBVymSvNyjuB0Ta6
	 EYL6ohHl8RZnUez9YyfBdizbSNj5LZDownlCxkhNXOVdUpw0wCkQPO2FeEPmzsLTrt
	 iwHPA2T6AHNIshTsCZSg6KBkSsPJl55Bos3+2YSqiXKMFjWEe7G24YoaoI351Z5JEY
	 RlmEPX3lOtGNQ==
Date: Fri, 10 Apr 2026 10:13:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhaomengmeng@kylinos.cn
Subject: Re: [PATCH 1/3] sched_ext: Prevent CPU kicks from exiting schedulers
Message-ID: <adlZ9nHVKfcwly_H@slm.duckdns.org>
References: <20260409032126.114812-1-zhaomzhao@126.com>
 <20260409032126.114812-2-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409032126.114812-2-zhaomzhao@126.com>

On Thu, Apr 09, 2026 at 11:21:24AM +0800, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> On PC with 8 core, when running scx_central with stress-ng -c 2 --io 8,
> if enable/disable scx_central frequently, dmesg will pop an message:
> 
>     [   38.214510] sched_ext: BPF scheduler "central" enabled
>     [   47.809167] hrtimer: interrupt took 11287895 ns
>     [   48.233813] sched_ext: BPF scheduler "central" disabled (unregistered from user space)
>     [   48.248460] kick_cpus_irq_workfn() called with NULL scx_kick_syncs <---- here

So, this is not really a problem. I think all we need to do it switching
that to a debug message.

Thanks.

-- 
tejun
