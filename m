Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782503;
	b=KLKCeIJrqgEuBe7HdzQjjwjxSN/x9aPq1kMSvyV85GhToMGDB0Z2oFtrdKFBAr4jVZ52
	 ruHIuEYVWyrxefbCqsVrtDdbNGJmlhLGun5WEL50aMmrUfXrCVOpqDXguiEjNwfhvCBdV
	 +1sArNJurJHccoy+H0tsK2TvQHsDza2Z+pswQW5RjgJTvSPhlcTp/o6Kxtl7sLRkF063m
	 A/4aL1XsOKKDt0Be3MJVHzU5jzaA+RNg+ACAIFJh3RgBdaBrxLQfEOyKgD3VVeoGF9PfQ
	 +DodixohiiL4vzOVDA8bB6JN+MVmt8QlUl0PecekGLrjdzMg1yK9Eg9c+rARvuiM+cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782503;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=R1XDwPK3N6z98u0rI3lwvWfhQAjAT5zkSIvMagPum8Y=;
	b=d2jtH9XiVgBy8Xk0V/zAR22XR6i5ynEzPMF1yih20/m7KAJfEKUSPdCH0t9ZPfVC0BY+
	 WEnz7hVzFwS5Bipxhi0y0XXhoOZ3puS4YL0qB4KxRrtQh2YiREZeWOBDHUA9X5ZeuW/Zr
	 DLtQLR3G9fNS6XWZmYarSyMPJ6NEqBF+gaSLK40gzYpLBPvnYQ9+FSloumS1v1SqMIAcd
	 l2axW3M3diJHxAQYcBo4Q3Io9I85KaCqh3NdiVzvdPIqSQs0VL1Oj/peappyX+jfRHWy7
	 zP3FySMU6Cp9Zer1YfKjQREN4N95dCgyHS6UAmdHT2E11WaX6GeeYeCFqZeg62oceIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKGdaolC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9241606A31A;
	Fri, 23 Oct 2026 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKGdaolC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235A71F01825;
	Fri, 23 Oct 2026 19:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792782502;
	bh=R1XDwPK3N6z98u0rI3lwvWfhQAjAT5zkSIvMagPum8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NKGdaolCI6kxHVHFqUjYNuEZj3L+ZMY5YG+DtLZ2oVAg6IUfwS2JucQ1C2aaY0juM
	 uC1daI0zm27yT/f3cok3UoxtoGFJvGypIqt7qYFE3aIqIZ8MmTiUvRvys0lDwkEpGj
	 v5uuqlR1hX1IPRtYlbtmuVzGH5/NdpgBfnGBUftQZ5Q78OY3ZmhCEao1U7IyRncKK1
	 PwXDXlv8fLjoZBf5x4/2UGdKxy83mvL2nDLBrA3FGtladVKIHQfHQQlMUud7UjELzO
	 7fZnXNCXf8xv0TckPMLbgzZYl3j8wSN7YYjvTEd/gftI7sZ1n1lSHniz+pIAxtBzjj
	 HcDoKloC8TmMw==
Date: Fri, 23 Oct 2026 09:08:21 -1000
Message-ID: <6f2d7109b2e68b12157f94841f929249@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 04/17] sched_ext: Fix bypassed tasks looping on a host without SCX_CAP_ENQ
In-Reply-To: <sashiko-outbox-183085@kernel.org>
References: <20261023175608.4120910-1-tj@kernel.org> <20261023175608.4120910-5-tj@kernel.org> <sashiko-outbox-183085@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello,

On Fri, Oct 23, 2026 at 06:50:45PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Can a bypassed task consumed with SCX_ENQ_IMMED get left waiting on
> rq->scx.local_dsq without being reenqueued when dispatch_one() finishes with
> SCX_DSP_PREV?
...
> Should the check at has_tasks in dispatch_one() also trigger
> scx_schedule_reenq_local() when verdict == SCX_DSP_PREV and rq->scx.nr_immed
> is non-zero, such as checking (rq->scx.local_dsq.nr > 1 || verdict ==
> SCX_DSP_PREV) && rq->scx.nr_immed?

The only way to get there is the parent keeping prev after dispatching its
children. The suggested change looks harmless though. I'll follow up with
it as a separate patch.

Thanks.

--
tejun
