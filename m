Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31C32ABFD;
	Mon, 10 Nov 2025 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800666; cv=none; b=CDt1nxAiBMSTgQIV1RyfKot2CpW+ieTegkWmlJrLNLPQQvasuXRFFUqM8jILFSuREln79RuFh9/I1F9Te9Ndu5GbtGzaVxdGVovUNulWv47af9ipkOnIq61vFcB0leo/Z26lSQ7tcwolwcrhFMXaWxbd7e4VyFUsqGMCiaPt2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800666; c=relaxed/simple;
	bh=G/mILMyLYfBe7cwdcVgiUtGHN73Mj0IzIbmDfLkB33U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqV76d0bLkh5RhOF4YF/cefW7WkCSirN6TOkvksKu8B6jHnrClF56BYzgr6mKldFF6FjPNID1C6tvQHaYmW7rdMxdFJb6FDIrY3NsYuknKbo4yeXseGglFQ4L3V8BuEm/SwxyL3HaWUrMbX4JcPs3TyAWu2ZANME0zuSJgsskyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxPr7SFP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxPr7SFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2016C113D0;
	Mon, 10 Nov 2025 18:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762800665;
	bh=G/mILMyLYfBe7cwdcVgiUtGHN73Mj0IzIbmDfLkB33U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxPr7SFPOLSRiO1wz+RuKg4Bjz8SXcfB5G1JDav2202oWqC8k+afIHlMIn5uHyJPM
	 fPQAOPAUXf3OMbOrDH/8+hVPSsCdbv1+NlBUa5nqRMTxSt87K3mf74soyVwnwHwpvx
	 yvr+rcF/rpBfzYt1LdQ/nYHQK4U0PfAKpKpT51CO1EYv1DqgZD0fmZQJ7WbxLmNWve
	 /aHdIOgQIPA5GvAB1gZgOVCwgYnRRlkouGhYS7AzOXV/Y0eGfUKpw4XnFOQRy81397
	 SrsQP8fXPzQQqZqDi+OQO3KddqYGqMm4TQy736F0dyS9Q/b9ir35otaIfaLbW3jchN
	 B4L4F7pcBuaqA==
Date: Mon, 10 Nov 2025 08:51:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] sched_ext: Exit dispatch and move operations
 immediately when aborting
Message-ID: <aRI0GOp-gQmBTV3Q@slm.duckdns.org>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-7-tj@kernel.org>
 <aRGgP4UQwgOdhgwj@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRGgP4UQwgOdhgwj@gpd4>

On Mon, Nov 10, 2025 at 09:20:15AM +0100, Andrea Righi wrote:
> > @@ -5635,6 +5609,13 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
> >  	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
> >  		return false;
> >  
> > +	/*
> > +	 * If the BPF scheduler keeps calling this function repeatedly, it can
> > +	 * cause similar live-lock conditions as consume_dispatch_q().
> > +	 */
> > +	if (unlikely(scx_aborting))
> 
> READ_ONCE(scx_aborting)?

Updated.

Thanks.

-- 
tejun
