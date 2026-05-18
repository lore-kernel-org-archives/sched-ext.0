Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D124501D;
	Mon, 18 May 2026 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779144788; cv=none; b=iiGVpsnJBUeCOYygQPV49+hWvMZTXm7RESJWd3OjbFbcaURAFAzF8hXmAc5nvUWo1UnD6ZqsvPvtqFzZy7igSDdqsKXOCqta5VpAJk2x7JTJt395ccN1C/I1QgRQQ00tIPuM+/d9fq68TZc3oqNUlfyY5sfLoFUGWVyKTD3KvtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779144788; c=relaxed/simple;
	bh=aQus28rsogAOx7/VF1Od9Fkxz4//mKuS+udBVoEqEL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZUznEXKzqCOrvgs4+O1gNLHM0OlK3oPsrIqCgu6+U8NAJ96s2SuSPsjumx/I0Cx/TwQnJu5oOrpNYHL7wUAa/aix3esR3MQQuH5/WPg//ePPJ8SorfSCS4uIY9VPCxiPhvaP+U0Bhs4AslSjVtZoFg54nHgQN6CI2Ip9Mz/uWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4Vdsvnw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4Vdsvnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C235C2BCB7;
	Mon, 18 May 2026 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779144787;
	bh=aQus28rsogAOx7/VF1Od9Fkxz4//mKuS+udBVoEqEL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4VdsvnwFKkINyqXwm4g+FQ0aUNhUPsXaMHS1jf/ZKXsD+4BafljTa+FpJK+PQg2u
	 jEs6Rcxtqvf+FnyuVwIgbuS0N3HmV8I240cbpq7sByeccsz2Ck0sUtg4HcllxdGLwM
	 H3OUjYRA36G8ExT8f8WDA9CN+82ISLuaCNz1cVIrRwfxjUv1kiYEvrSZ1PkNeRxiHm
	 PVBVqXCA+5AqHFn7DQsKr7EEEx2+WsZOITrI1WOWfKQ6DagCFw6vzazHgyqraNDw6f
	 tLu8OsIXcvrSeKmH9awOzXSW2RG5mvPjpwDa6/1++dmyyoJG0KHzvug/DYVRz/TmQB
	 J3/zBCEGMp8xA==
Date: Mon, 18 May 2026 12:53:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] sched_ext: Track bits[] storage size in struct
 scx_cmask
Message-ID: <aguYUvewD7bkNXbn@slm.duckdns.org>
References: <20260517183614.1191534-3-tj@kernel.org>
 <20260517192930.1368685-1-tj@kernel.org>
 <aguOlyk581-y_Ru4@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aguOlyk581-y_Ru4@gpd4>

On Tue, May 19, 2026 at 12:11:35AM +0200, Andrea Righi wrote:
> > +/**
> > + * scx_cmask_reframe - Reshape @m's active range without resizing storage
> > + * @m: cmask to reframe
> > + * @base: new active range base
> > + * @nr_cids: new active range length, must fit within @m->alloc_words
> > + *
> > + * Body bits within the new range become garbage - only the head and tail
> > + * words are zeroed to keep the padding invariant.
> > + */
> > +static inline void scx_cmask_reframe(struct scx_cmask *m, u32 base, u32 nr_cids)
> > +{
> > +	if (WARN_ON_ONCE(SCX_CMASK_NR_WORDS(nr_cids) > m->alloc_words))
> > +		return;
> 
> Considering that:
> 
>  #define SCX_CMASK_NR_WORDS(nr_cids)    (((nr_cids) + 63) / 64 + 1)
> 
> If we pass nr_cids == UINT_MAX here, we have:
> 
>  CMASK_NR_WORDS(UINT_MAX) = (UINT_MAX + 63)/64 + 1 = 62/64 + 1 = 1 (wraps)
> 
> Should we simply reject if it's greater than a certain reasonable upper bound?

I'm not sure what we do matters. No matter what, this would be a clear bug
and an unlikely one at that. As long as the backtrace is dumped, I think
anything is fine.

Thanks.

-- 
tejun
