Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB073F1ABD;
	Tue, 14 Jul 2026 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016492; cv=none; b=XAtz8UsS56meyFHLOH+sKPq/EMcyIMaSFESf7X7CNTjFRlla5Oucb0ZK/Nfr/W18uDDnRlghWRtw+f1dGsg7H9ealHm1UaNgiV2hy/7EiHMEmzDMnD4yFy8Oz4SVsBPBMCi62gqPlPmzvokvlp+RAK3LzrWTkFmtiCwfgghadTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016492; c=relaxed/simple;
	bh=mHDh0GnyQIdNot8LznGvaUdV6obqTWq8j3Cw3Y+mxv8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=AAH8rQcCty7MNr2YFY8wAuF72yp2NxRVXOvGpySMvRJkykwLRneF98qW3ktWdXm2uQw07hJAQLACyaPW1+sHBs57I4PU6KeiJ1W+zXVIlTzNUdbAkKtu9ocBADz3VrXAxiJHRtMMXjOizHwCfwHR6Zn8CYVmcIqQVZH48lCjvw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQtx6gBd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQtx6gBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C811F000E9;
	Tue, 14 Jul 2026 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784016491;
	bh=L7w7aaKI3KehmvKi5swepEnNdbiXBBEuNWbpoVpH9LA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MQtx6gBdR3HM9dh9ZSYyxZwJbM3nlPpVjcU436SduBYiu+PHwa4rHCJwvh9B8sC3r
	 ESpuQ3s4HXlmZAuqzQLXjN3ySAcupbmfg2/kSlv8zjjetzTjhFqbGBQ1bm4cHPdTYF
	 fr4UXFbbz2I1DMiBUPzkKoBMvySEI2D9Ny0A8Kx9YAj8NEx925cTN+DpDfkcebbxhz
	 x7rFWEtl54/HYzcj03CEHwSTC3J/iAO/6sOS6ETCmCX3PFwbDF4nsg2N3F7sofS98k
	 zm5n623yUddUlRnbrimwbIkZHcBgdvkPva8QL/bOCU9qWA8XvXzmzUuHwkqckbodAz
	 XuYCyCB2KyC1w==
Date: Mon, 13 Jul 2026 22:08:10 -1000
Message-ID: <241c12f5ce1fa4b60ac3f08a3518d4dc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 sched_ext/for-7.3 18/33] sched_ext: Add reject DSQ for cap-rejected dispatches
In-Reply-To: <alXcDVSLNErhxcHg@gpd4>
References: <20260709225041.1695495-1-tj@kernel.org> <20260709225041.1695495-19-tj@kernel.org> <alXcDVSLNErhxcHg@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Tue, Jul 14, 2026 at 08:49:49AM +0200, Andrea Righi wrote:
> With CONFIG_EXT_SUB_SCHED=y, this calls scx_local_or_reject_dsq() for every
> local DSQ insertion even when there are no sub-schedulers attached. It shouldn't
> be too bad, but the hot path still pays for the out-of-line call and the
> CID/capability bookkeeping.
>
> Maybe the same static key that I suggested for the ops.update_idle() case
> (PATCH 28/33) can be used here as well and we could do something like:
>
>     if (!static_branch_unlikely(&scx_has_sub_scheds))
>         return &rq->scx.local_dsq;

Yeah, this and the other sub-sched hot paths will be gated behind the
static key in follow-up patches.

Thanks.

--
tejun
