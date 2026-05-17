Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8D43C5DC5;
	Sun, 17 May 2026 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779038711; cv=none; b=N3e2iG98ObjOKzfutjIXh67l93B+AIt6zGMum1Jo1TenIFHA9KiXjasHMDf1dO6hNEL4QcG1fnClVBGRy7aYcl7vdSlrTVqSPry2FFh2o3HbjK9mKfsi2cNl2hjSEbIpaC/7V7ttfpHExLCF1d/GiSEo4lH81ZoWqo2OtQ6lqKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779038711; c=relaxed/simple;
	bh=wmRhPsvM40pQmez/jzTcSNQQcCuObXKNrXdgDSxAz+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/BUhxDZaaUEXK2TUaYCMjwjIcEnM2Zx5sVvhbcBzQjazvDBAOwmF6/06h80CwpXiSKTj+xMMvubuEZz2Pe0EGm2oKaUQSZyZxewommkxrxFV5Ssh+E10sm930Lk5tz2FFqQEFomgPqmNgM6rYNnX9E/iajRucojR2HBMlBk3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDHD2/fo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDHD2/fo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B0AC2BCC6;
	Sun, 17 May 2026 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779038710;
	bh=wmRhPsvM40pQmez/jzTcSNQQcCuObXKNrXdgDSxAz+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDHD2/foubjITxNss1csSU8ynxktSTND31zrHAWaci4p4bkX9O9IJVTF4F+f91ib6
	 +JFAh9pdp+WTMQa2TObc95D4I49VNnTaAyqNqlZXe1ryWIHBEpci51+twwsIwKBPjn
	 NEVyvgPOsaYqOBWAhEGapAqJ6pV2i4d55B0H894iiVvRIbrslNmxt0rwjHQwc4ztuN
	 mz1oMPh6QnHUcJclcNeOiFENVC3eHMRvHb4sxZyDnLmn5jnuSXM0dtLjnSMStzCYGm
	 UMs+KObUkRlbOpXKGApnIRfONcS0awsFda6/P1DvCJC7Ve3IRpiZcVJw7tKqdqBtow
	 l3rRpiCmhNU6A==
Date: Sun, 17 May 2026 07:25:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Fix deadlock between
 scx_root_disable() and concurrent forks
Message-ID: <agn59c826ofPPA5g@slm.duckdns.org>
References: <39ab37b4e79c6e5361a907c06ab27e72@kernel.org>
 <agme4i4w5K6Ab9cM@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agme4i4w5K6Ab9cM@gpd4>

Hello,

On Sun, May 17, 2026 at 12:56:34PM +0200, Andrea Righi wrote:
> > +	 * Must come after scx_switching_all test. While both are set, we must
> > +	 * return true via the branch above: [__]scx_switching_all are cleared
> > +	 * together under scx_enable_mutex, and a fork routed to fair while
> > +	 * __scx_switched_all is still on would stall because
> > +	 * next_active_class() skips fair.
> 
> Just being extra picky: [__]scx_switching_all are cleared together sequentially,
> but not atomically (in fact the order is what matters). To make it more clear,
> how about rephrasing the comment block above like this:
> 
>   * Must come after the scx_switching_all test. scx_root_disable()
>   * clears __scx_switched_all before scx_switching_all (both under
>   * scx_enable_mutex), so while scx_switching_all is observed as true,
>   * __scx_switched_all may still be on. A fork routed to fair in that
>   * window would stall because next_active_class() skips fair.

Hmm... I don't think the ordering between scx_switching_all and
__scx_switching_all matters here. The stall is caused by the gap between the
earlier DISABLING transition and __scx_switching_all being turned off which
here is tested through scx_switching_all and at this point as the mutex is
already held, even if you swapped scx_switching_all's position with
__scx_switching_all, it wouldn't matter. It's just kinda confusing because
what's actually involved in the stall and deadlock is __scx_switching_all
but we're testing it via scx_switching_all. I'll update the comment so that
it just mentions __scx_switching_all. I'm not even sure we actually need
scx_switching_all.

Thanks.

-- 
tejun
