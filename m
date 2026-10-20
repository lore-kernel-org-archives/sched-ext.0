Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519062;
	b=RiotqQSUXNbbz+Gp9NkA027AfO5AD6yeaJZ6KZdFFYDuu1flO/8Z2zcMR0SBxJORI4dO
	 Cp+4tKTuufQF9MdMo6N5x/ty2r15cAOXF+InOP3FkeuhTRxtl3PN4cJxNliRsXp5DACMt
	 6eUp+yTQfBdfeRJqpUoBr+h1KXB16ySMP6SBP+yHfhmPM4jUDLvB6xlNFJ5ViSjD/pTeh
	 ZILT9ufgKqeoOHqQXrQV6QArEDQItsGzCEVSiTOG+K55OfqVWyxio6jcVJ75KExnXWvZR
	 m7Ce2eB43+QyNs/m97w/FDQFyZzggPOw49wz5hVUimljJdJG/HTnYXq4HF2oWcqFYyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519062;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IwRcxN7dEPpxHN2BvnbyAu/kgxSDCgwFr2QbOAAm33E=;
	b=RXAFqDZC/ZWN5qdlpZIhpjysG9PAUWjHa2SAsZfmSt/u+2RaAWWF+xu9G5ufP1PBapB/
	 kUv1oxFSTN8CS2qY1VUYT42Hl4yZzF0vnjHuuV9TbIgJdV44BkMPJqb4nYPg6oPzO8pfR
	 5eRiNV8I5cVJWj4rlcXw5hY+QN1QlfOPwDiRe+2rpbBoS0/QSbfUH6ZIG2lboDlwan3Lm
	 I66bQOar0dNyBc8Y0gMgf7oVMmDEnH6fpVSGb8upEMN+LaoUIjNtp5TqaBMitI2tsJSuL
	 N3x+0xljusL2JhdxYNvnUDgGwvWG7XBqLR2ituL/l+nYw+8N/MknKZrfQF1nehgR8Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6MVSwcr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0C606A31D;
	Tue, 20 Oct 2026 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6MVSwcr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133B21F000C9;
	Tue, 20 Oct 2026 17:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792519062;
	bh=IwRcxN7dEPpxHN2BvnbyAu/kgxSDCgwFr2QbOAAm33E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f6MVSwcrIjqLLTmrPAizy5bA4bTqYBQV57yFHQSw3YI+CYUXh4Phgib7ZcUgBOKU3
	 yqftHN/2SG5ilFd9osBtCYQylpFbcJ60DK/3EAXDGNVsxItUY679rxVDAbS9UtAd92
	 nDGoajyopa8ux8G50+u5unDEBUNhr4JYsnaBUF+fR86p9cwYfAZu1a5gYM14G6EPud
	 Z0RHa5B1lFYZ9ac4BI/jKViDg/Qi44+73QUq4cM6btPCSNUJXFkI6SjewowPbAVl/P
	 tDZPnvngeZHUzwSdRmaDk9zvFgnryNVRrHYXMm4Iy+X6aX9cvlfsqwD57eYpUj1lz3
	 onYzXI1mUPUJg==
Date: Tue, 20 Oct 2026 07:57:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/core: Avoid requeueing a singleton balance
 callback
Message-ID: <aterhhiPAi-Bib7Z@slm.duckdns.org>
References: <20261020084400.845842-1-arighi@nvidia.com>
 <20261020084400.845842-2-arighi@nvidia.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020084400.845842-2-arighi@nvidia.com>

On Tue, Oct 20, 2026 at 10:43:19AM +0200, Andrea Righi wrote:
> With proxy execution, __schedule() can call set_next_task_scx() with
> SNT_REPICK and then SNT_PICK for the same donor. Both calls queue the
> kick_sync balance callback while kick_sync_pending remains set.
> 
> When the callback is the only list entry, its next pointer is NULL, so
> the existing duplicate check misses it. Queueing it again links it to
> itself and causes the wait to run twice.
> 
> Also check whether the callback is already the head of the list to
> reject the second insertion.
> 
> Fixes: e2859566ffbc ("sched_ext: Queue the kick_sync wait from set_next_task_scx()")
> Reported-by: Tejun Heo <tj@kernel.org>
> Link: https://lore.kernel.org/r/08cac02c604dd73ef96fc92eb29d692b@kernel.org
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Can you resend this to Peter? Please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
