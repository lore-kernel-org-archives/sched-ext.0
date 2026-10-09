Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9604DA9D2;
	Fri,  9 Oct 2026 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576259; cv=none; b=SNiLLpDK7uSV6JO5LM8E7W+Ed4/gEhusAFg2eOOR+EccW0d7yQbQQeRwSvdzeXSqvwdUeSjS0fX+0GGby/XPNARIFwEQafvSULU8XXheeKBe7LwhJS5WI1d9TqfY3kKwuYng+YPJ+Nyj87Ryshd49btuidhh/FTd1V1q8bxHkJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576259; c=relaxed/simple;
	bh=II/cYXBrd1tc9mShal35Jc7GR3Hw6MwRsjzVPg3mHjU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=LuTxf8rVEZo50+e6gY3I7Q67LwlEOEaT9HKqHVOukfaUbcHwMaSQJ3J77w0g2MnvGWIY5OluZ7NkvZh+VLUjE18xJRSyWyiQFOpyoFTBX7BasxZ6FC7COK9E3zDEtV7Y+VwnpUdM2RT9Qoge0Vlbgecz8oZ02fmxkSLru7GWvZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KK47qF2o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KK47qF2o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997EB1F000FF;
	Fri,  9 Oct 2026 20:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791576256;
	bh=II/cYXBrd1tc9mShal35Jc7GR3Hw6MwRsjzVPg3mHjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KK47qF2oj6nm5KJdvhdI50V8kecXiEzGT6zAaxlho2MtIihiYg+Q29znPCum8huSp
	 yOvMXSloVVPfoBZYjbUAOxIM7kXPGoTgfll9namb/bfMhjh3otNV0cyNQM86XGy+Yf
	 azcMXhm4ci9lOf7RVIyysT5iOWFszQ+Biv5ZsRRKqR5mL7MzSFJXUhlCvCOxpP4Zab
	 A0SZncftFb/Jobdgp5tpLV9x5XwjGtoL4WpSDY3oITtJWgjwyqGNKdGxvk2V8JZQ8k
	 8Wu93UeUi5eRmghBIWBUfXP5KfGsyPzZ1uNQZRmsbgjIjcf04acTIg15HKs0/9ja+9
	 iRn3iS8WfQ7LA==
Date: Fri, 09 Oct 2026 10:04:16 -1000
Message-ID: <871113fbf23f16c8b291bbb06e9d6f36@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: scx_qmap: Reset a child's cpuperf targets
 once its PERF revoke takes effect
In-Reply-To: <asjNo3JmkmeTK8dr@gpd4>
References: <20261008093228.2015427-1-tj@kernel.org>
 <20261008093228.2015427-3-tj@kernel.org>
 <asjNo3JmkmeTK8dr@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Fri, Oct 09, 2026 at 01:18:59PM +0200, Andrea Righi wrote:
> qa.rr_cids covers the entire shared pool, regardless of its current holder,
> right? If child A detaches during child B's turn, this resets the pool's cpuperf
> target even if B still holds PERF and has written its own target.
>
> Should we avoid resetting the current holder's target here?

Right. It's transient, the detach's repartition revokes the pool from B and
the handler resets it again when that lands, but B's targets get clobbered
in between. Will skip the pool when another child holds it in the next
version.

Thanks.

--
tejun
