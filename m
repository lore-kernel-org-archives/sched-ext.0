Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B114F98;
	Sat,  9 Aug 2025 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754766228; cv=none; b=eIFRtu0dddM5pDO48euKqjrb4QYPzqsMUXYS0mXcGMzAhINpea9muhC+nyG/CLwMQuAbibWzmWTv7u93NfjOf0jt5dxeZnTi7q/vBhlrN1J0vu2xQIQMe2z6/pTT5PdpgUHqwjmbnTRBWswm9XDt65+4s9GE/a34zmgsJRA8Og0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754766228; c=relaxed/simple;
	bh=ySMQAEA+dv3QrFUKZl5okzZ326WUM2YnxAg2gIYbIq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpGUkgAS5tH09YpH5sI59xBP1qsMlJHRaXHea3WwyQzyruqYD2Cg9QWCJNHF5Btpj8Yqld0sC0Mht08dcw/E/nsibprCo0RjqGhjjCFnrsX8nUkkv2z46mw7qTnKI/hODGiTMUWfU7d2Nr8R/anldGezK7AS2/Kn/qMKdB22tKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2a9V0Xc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2a9V0Xc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED02C4CEE7;
	Sat,  9 Aug 2025 19:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754766227;
	bh=ySMQAEA+dv3QrFUKZl5okzZ326WUM2YnxAg2gIYbIq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2a9V0Xc752WeflhOrDJDNuuJCQzshxgB97aHUIWPRoYIdyu67TJDUzzeLvlKN6bi
	 2zXAN4NQGnSWXCLzg9TYBhiOuvYDpxKlRsqaCpaQezh9E26D0GwZn9dcP7/izRCaZn
	 MDug255hOVVlinNxi6W/CFw3Hm6Q+9X2KakWoK21jVQj9MJOsIOxWu18WhhCXXOl77
	 vInZgO8j8EOeFYJLZwjjggNkzA5DaTA/aUMQqo6jbnWhfpCAQ36kV9efaxHp1+tJIz
	 Je1jOZnIU/Is6NupshDU3fPNQ5J4IWdZHYq3oDgVgRxiSIsmJPw3qeBI6m/HDhPaVS
	 vxwq0KxeGVvfg==
Date: Sat, 9 Aug 2025 09:03:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: arighi@nvidia.com, void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v3 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
Message-ID: <aJebkj-neVJNKEJ4@slm.duckdns.org>
References: <20250805111036.130121-1-christian.loehle@arm.com>
 <20250805111036.130121-4-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805111036.130121-4-christian.loehle@arm.com>

Hello,

On Tue, Aug 05, 2025 at 12:10:36PM +0100, Christian Loehle wrote:
> @@ -7420,10 +7420,20 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
>   */
>  __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>  {
> +	struct rq *rq;
> +
>  	if (!kf_cpu_valid(cpu, NULL))
>  		return NULL;
>  
> -	return cpu_rq(cpu);
> +	preempt_disable();
> +	rq = cpu_rq(cpu);
> +	if (rq != scx_locked_rq()) {
> +		scx_kf_error("Accessing not locked rq %d", cpu);
> +		rq = NULL;
> +	}
> +	preempt_enable();

So, this will break the existing scheduler binaries immediately, which I
don't think is a good way to go about it. Can you add a pr_warn_once() to
print deprecation warning and add e.g. scx_bpf_locked_cpu_rq() instead?

Thanks.

-- 
tejun
