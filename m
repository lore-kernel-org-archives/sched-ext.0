Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340EE1F5851;
	Mon, 11 Aug 2025 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754955483; cv=none; b=Pf0EhL8p7kEYBlEjZcn+PaaZ9OUnDiZtj59S/FI6NiMjLdYvW9Dl8u6v4JzVBm6FPlG8fYBeVdG98zV81shwzsQ1To3eLjpmbd5vn6WKD/tpaBVpWypeWcv3e2q+fB+6VDp/snFLmUtuyLDNvD2FAbnCHM4ckJKeURZlC007GbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754955483; c=relaxed/simple;
	bh=SxDlQfGsd3imWA1ARLcNW5g7GuWBnoHOF7Cpo0RjYKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8oGpcyfPajdlfv+jO5fwRK2Wre9O5yiGEaC2sG2FZ09f/ph9evO0Vu+WjUPscZ73zHJYhxi7cyJtsaPlz1u+xEKrjdGC8ehU0/zBoK98MF05hUH7h7J5vOFuJaHaf20s3iQ+doEmbM89D46zPxOWBCt90V0ILpN3oBl6zSpR0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suC+9cgn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suC+9cgn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962ACC4CEED;
	Mon, 11 Aug 2025 23:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754955482;
	bh=SxDlQfGsd3imWA1ARLcNW5g7GuWBnoHOF7Cpo0RjYKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=suC+9cgn2Ybvhp54EWLeNHFg4FDS6P/e3wMzOi4pErV6xYC7AXFBsX2QLT07qzZJW
	 2xAkkPC89dqtHkJQrS0wd8aER12fLhXA+g379dI9xmN/lQYXk2Ej4clENRnBIEaF2B
	 ma3wA0VD9E8Vh+bQoA0adW0gCJLK2WEXHfURS1IWcR79GSsXd4VzyP3oLCHGaqIYTW
	 EkwbHFHIvn7FUUhYRhwPL3VpoEKWPHGpHnQUU4UPEgSMa+80/LgXH6hR3RmI6hrtNz
	 Kfhg4sHL4IUa77a6Oe2nWDnB+nKtzlbhCAUqf6nrbC+52xIVz4zR6QVJJPv20K+oKg
	 Y9tmMyi9cAaGA==
Date: Mon, 11 Aug 2025 13:38:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: arighi@nvidia.com, void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org, jake@hillion.co.uk
Subject: Re: [PATCH v4 1/3] sched_ext: Introduce scx_bpf_cpu_rq_locked()
Message-ID: <aJp-2TPbNKO3k_lq@slm.duckdns.org>
References: <20250811212150.85759-1-christian.loehle@arm.com>
 <20250811212150.85759-2-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811212150.85759-2-christian.loehle@arm.com>

Hello,

On Mon, Aug 11, 2025 at 10:21:48PM +0100, Christian Loehle wrote:
> +/**
> + * scx_bpf_cpu_rq_locked - Fetch the locked rq of a CPU
> + * @cpu: CPU of the rq
> + */
> +__bpf_kfunc struct rq *scx_bpf_cpu_rq_locked(s32 cpu)
> +{
> +	struct rq *rq;
> +
> +	if (!kf_cpu_valid(cpu, NULL))
> +		return NULL;
> +
> +	preempt_disable();
> +	rq = cpu_rq(cpu);
> +	if (rq != scx_locked_rq()) {
> +		scx_kf_error("Accessing not locked rq %d", cpu);
> +		rq = NULL;
> +	}
> +	preempt_enable();
> +	return rq;
> +}

Do we need @cpu? What do you think about making the function not take any
arguments and just return the locked rq?

Thanks.

-- 
tejun
