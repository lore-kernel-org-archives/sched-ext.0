Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91F3FBA7;
	Mon, 22 Jun 2026 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149056; cv=none; b=eBV3PdaiceTPWvC4yaawIqKtjuUwdvbOn0Y/DpBcY4N/zjx8EQKULpryLVUm4IJgiUj9EL7Iv2/a70+tChkbhlhGGsryI8PMuH1yBcx6iroSqNZCd+Ay/VTOyhB/aoD8H4FSvX/Y1DJGEEHyi99xLwNSC0f97IZ/Bfm7kSTSKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149056; c=relaxed/simple;
	bh=BNGoY9SA7aF+4lYBSoDpvjrtXUUnblmnmUbMlxskjF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDwl5pGKYMsmr8CL0XLOPQ4KTNIcMwc06rpnXX23H/r53i6Br4AwjmvKA5WP2FoUu64rjyU0upmeGhHb6J5NZ3wP0jcdjPLeef6Ktthzr9vHI65d1f0cEuhqrGO4uaxPo6bg4C7EhpjaNxtDdPSoprdA4X/DtoQDocwxMwUnrLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWRFqGGl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWRFqGGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640691F000E9;
	Mon, 22 Jun 2026 17:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782149055;
	bh=dggcCq1q4f9IvnFD/8ykx5mtBGjHv63lBj4U8Tcq7ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JWRFqGGl8I2IDHSnXV0vBvJrejavU4IR0v6oRNM7bQ02Zqa6ggr1/t6lFwUYgueN9
	 D4lrd2G+aMIhGOBkal+yoah5uzIQDNUFQfyKwoBk6heKrr1stY2M3GFXNoMw4GGhSe
	 itSViq2C4uH584TP1jN9kRWR2fePQ50QR08nx3KceXM8Hx0gKUi92OvjulLUSSPHt3
	 PkWlQl6gW3qd88KbKHD4F2orCHtwIsra2k2rU/b+aSylb0Kc+YpYrPZdqQgnZHARw6
	 WsZkAx8C27TdqqJdVDcSedBbFW7sK287HvvICliOh38kXYW7/XbVdJTlpSj0xANsCe
	 x/h1Y9ervK15g==
Date: Mon, 22 Jun 2026 07:24:14 -1000
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.2] sched_ext: Move sources under
 kernel/sched/ext/
Message-ID: <ajlvvs0Uq5ZJC2EA@slm.duckdns.org>
References: <20260621163026.434856-1-tj@kernel.org>
 <20260621183444.485350-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621183444.485350-1-tj@kernel.org>

On Sun, Jun 21, 2026 at 08:34:44AM -1000, Tejun Heo wrote:
> The sched_ext sources had grown to ten ext* files directly under
> kernel/sched/. Move them into a new kernel/sched/ext/ subdirectory and drop
> the now-redundant ext_ prefix. ext.c/h keep their names.
> 
>   kernel/sched/ext.{c,h}       -> kernel/sched/ext/ext.{c,h}
>   kernel/sched/ext_internal.h  -> kernel/sched/ext/internal.h
>   kernel/sched/ext_types.h     -> kernel/sched/ext/types.h
>   kernel/sched/ext_idle.{c,h}  -> kernel/sched/ext/idle.{c,h}
>   kernel/sched/ext_cid.{c,h}   -> kernel/sched/ext/cid.{c,h}
>   kernel/sched/ext_arena.{c,h} -> kernel/sched/ext/arena.{c,h}
> 
> The include paths in build_policy.c and sched.h, the MAINTAINERS glob, and a
> few documentation and comment references are updated to match. No code or
> symbol changes.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Applied to sched_ext/for-7.2.

Thanks.

-- 
tejun
