Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9C3CF05C;
	Tue, 28 Apr 2026 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777407001; cv=none; b=quEm3XBdipI2T4lQJ4j/L4JSI56uMMtDQa2awH5XvYIT0XTC7CXc8Uub0adfcPbL5ny9KJtAcR0L9DTtgnRpwj+fxcIj+unQCNpRzEJ0OWSVGuQ0P6lvIh0mSQ1e113+L/ws49drdxcXyItVIDG/FKghXlmblPuKsUnkxMTfNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777407001; c=relaxed/simple;
	bh=/MjyB3RrtLCTOoVqJsNlMm16oZBUJIIQpa5dEyn0CHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jR3VdvFThFT4dlq6a49rDNVTfuAehilhW91RVsgynXvKyfYt62PgVlRGH79qLxlrFEQ1V8D7uk+Rh6faPyBbUARky0D+waLW0JtxZcRMYCy06+Jq5g+kWu8MQGfu8EbuviRmsgfTEGypdNiMAiy99VQ+cwLLfpBd+OH3GhXe2aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clnodEJv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clnodEJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7C6C2BCAF;
	Tue, 28 Apr 2026 20:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777407000;
	bh=/MjyB3RrtLCTOoVqJsNlMm16oZBUJIIQpa5dEyn0CHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clnodEJvzQq2L5CtW6x9PL3kHA8KXDKgpfyor89JixFGMottYO734vESrrRW9K5fr
	 XAfyl5FI3aOA0bYoc1pwzzbQdJ75w6wE0/TWUG4w9H0/RxBNg6ODuzpLn/iW3F1tFY
	 6ol8CXc2Yz7dS0QSgQP3CrtTRCoHMA3w4+UJp640KRS/38vUl4Om7aUXd1lCtgzbs+
	 8MsGIeJCFJ+dmlLewTKx0vuCHG9M7UIOImrmK5loqj1Et9dztFOVmNLsFVk5UUYkYu
	 fZGdUgZoThOX8/mtAmG8f24zcX3orW+twhu767QLNwDnNrI9GiA1ke196EZmBj5t32
	 o2tihPPlhSVzA==
Date: Tue, 28 Apr 2026 10:09:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	emil@etsalapatis.com, linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomzhao@126.com>
Subject: Re: [PATCH 07/17] sched_ext: Add topological CPU IDs (cids)
Message-ID: <afEUFzbBUXjCMTGQ@slm.duckdns.org>
References: <20260424172721.3458520-1-tj@kernel.org>
 <20260424172721.3458520-8-tj@kernel.org>
 <DI4T25FH7PEY.1VCTSR0XNJW7M@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI4T25FH7PEY.1VCTSR0XNJW7M@google.com>

Hello, Kuba.

On Tue, Apr 28, 2026 at 01:00:22PM +0000, Kuba Piecuch wrote:
> Hi Tejun,
> 
> Relaying a minor finding from Sashiko's review:
> https://sashiko.dev/#/patchset/20260424172721.3458520-1-tj%40kernel.org
> 
> Might also be worth having a look at the findings for other patches in the
> series.

I submitted a PR to make it send review emails but that didn't seem to have
worked. If you look into how to make it send review emails, I'd appreciate
it.

> > @@ -6727,6 +6728,16 @@ static void scx_root_enable_workfn(struct kthread_work *work)
> >  	 */
> >  	cpus_read_lock();
> >  
> > +	/*
> > +	 * Build the cid mapping before publishing scx_root. The cid kfuncs
> > +	 * dereference the cid arrays unconditionally once scx_prog_sched()
> > +	 * returns non-NULL; the rcu_assign_pointer() below pairs with their
> > +	 * rcu_dereference() to make the populated arrays visible.
> > +	 */
> > +	ret = scx_cid_init(sch);
> > +	if (ret)
> > +		goto err_disable;
> > +
> 
> Are we missing cpus_read_unlock() on the error path here?

Yeah, fixed this and several other valid ones that sashiko found. Will post
the next round soon.

Thanks.

-- 
tejun
