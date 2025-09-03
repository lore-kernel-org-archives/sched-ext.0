Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D582ECE8A;
	Wed,  3 Sep 2025 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936374; cv=none; b=KLf2BYnWsZ/dQL33plHDQ0nfv/ZioGXEwkXvamg5AzkQwgfNOa/5uHJBhhoPA4Z+P3IKOCIoS5eKsVifd8kfIOhbbctY4nQsn0vdzywqggOLvYyYsZLt70Cd38bBokQKeUw2KgqhmSzagC/gusFRIRY95dSMtZBbrm97pbFutXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936374; c=relaxed/simple;
	bh=/wn81mqtmLBAJqlog+Yyi1c/VENujPA4G3jxRsDqA8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEFxWUDjRww5OgYin2bK2PLLFWgkgLSShV4O0jH11QVQJQNVFKazUS7kwozMbyBn0XoRwF5wJ7fr5Qfnr007gYqyfk1NN5lQjSUZW62/cFKcfGl17u44fWW5wH5oB6vWDYOgU/dZe+5sds4bfeCZUXYipnSaFlc1eDx/qFyUUsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcdsHlb4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcdsHlb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62542C4CEF4;
	Wed,  3 Sep 2025 21:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756936374;
	bh=/wn81mqtmLBAJqlog+Yyi1c/VENujPA4G3jxRsDqA8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lcdsHlb4e8dDy4Xme/ZazoHxlJpj4zWu/9zPSTYGax78J6WN5gxLu7TfvtKvRyQta
	 fxZZ7KTcUP17nyeHrLUZqt/egrOT0dt3OQoECrCNXjMmC4CoY3AyXWi/lcgSXx9o+E
	 OtDoNbSAIV+x37VVxbd+xUmaeYSzAQoCq3kAPBYywQMwTDlloIzLDMpuEqqSDj259I
	 7xHNSTOt/+XyO5+ImDRq7mCqk5Bp6qpdpMiYikjKyl32uXq1O1kGjrlsXnBcbLQPhI
	 WwP5HS3lxiCxJ/Vpg3qQqWhOApY+LAIP9p0p02iZ2myfZ0/mvEP1H1BmP/0Dkffilb
	 Hh03inIpFP6dA==
Date: Wed, 3 Sep 2025 11:52:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: arighi@nvidia.com, void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org, jake@hillion.co.uk
Subject: Re: [PATCH v7 0/3] sched_ext: Harden scx_bpf_cpu_rq()
Message-ID: <aLi4tSqsdF-CpF2R@slm.duckdns.org>
References: <20250903212311.369697-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903212311.369697-1-christian.loehle@arm.com>

On Wed, Sep 03, 2025 at 10:23:08PM +0100, Christian Loehle wrote:
> scx_bpf_cpu_rq() currently allows accessing struct rq fields without
> holding the associated rq.
> It is being used by scx_cosmos, scx_flash, scx_lavd, scx_layered, and
> scx_tickless. Fortunately it is only ever used to fetch rq->curr.
> So provide an alternative scx_bpf_cpu_curr() that doesn't expose struct rq
> and provide a hardened scx_bpf_locked_rq() by ensuring we hold the rq lock.
> Add a deprecation warning to scx_bpf_cpu_rq() that mentions the two alternatives.
> 
> This also simplifies scx code from:
> 
> rq = scx_bpf_cpu_rq(cpu);
> if (!rq)
> 	return;
> p = rq->curr
> /* ... Do something with p */
> 
> into:
> 
> p = scx_bpf_cpu_curr(cpu);
> /* ... Do something with p */

Applied 1-3 to sched_ext/for-6.18 (the last patch needed a bit of update to
account for struct scx_sched defintion being moved to ext_internal.h).

Thanks.

-- 
tejun
