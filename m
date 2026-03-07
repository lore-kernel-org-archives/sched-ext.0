Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C433375AE
	for <sched-ext@lists.linux.dev>; Sat,  7 Mar 2026 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772911389; cv=none; b=NBAgKU0O2AHBK1Fsn8hENplyrq+hRqt+ff+5OcTKFgNAzUy/wVDtIZgDYXqyjMrOQtu1/gnCSIAbONHim0HzolMwWGZijb9t+/9f2NlzwHKeEzj/BHUJtFGOaJ7fOtK9bSqHrPxIm1blWLd1fuxaNYM+mmqAy6skvZzjWU8r+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772911389; c=relaxed/simple;
	bh=1Yqa0snGpnB72LU/pibM4VuaE4O1TVpXnAFHOBdgX/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN87h5HuwVst3oxRoiyvJv3ECJ4C7JNE7epDEE7yorBpDHlxTQgf7KlToURIdGP6Cdofza4rC1JgClWMMxSF+COSNhnQ0HpDAkYs8ksgRppb44i+Z/CNTQ95XLHBTa/PJeCPdGGjgYAF+XSve6jAn3O1XoEa8iQ+8azPHtF6W1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyQM49kw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyQM49kw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5862FC19422;
	Sat,  7 Mar 2026 19:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772911389;
	bh=1Yqa0snGpnB72LU/pibM4VuaE4O1TVpXnAFHOBdgX/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lyQM49kwwEKpHcLJeXMuNpM3NbAWoTb1hxE9s4Ou3PsMRFGoN0Td8wGbUqEbsRlSA
	 s8qH6tWK90W79anMW1AjeK/YbQ0ITILXo7lVDmCGBnuFC3fSCDSfEPp18mhgLzdj4L
	 tF7a8y7+u/JEk5DJRBqgaVCN68dTVLsaOFbu4LQ09rcinb3mIFwD2T8v14fBXF33sH
	 GoSqHdFOQhPXxQp5a2SdWu+WYBQQF3E3IrsYkNjROCAqaLmcE4ILLgCs3kSfALH1a5
	 cP6ZMbMtWGrHeFWv1Fgz98nGGqUXKDeG9aDOoG508BgOM1GVo65tadIUngOZIHSmRA
	 C/rh3NzK9dhHw==
Date: Sat, 7 Mar 2026 09:23:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] sched_ext: Use READ_ONCE() for plain reads of deferred
 reenq flags
Message-ID: <aax7HHGdkh6I2CK0@slm.duckdns.org>
References: <20260307190843.4117532-1-yphbchou0911@gmail.com>
 <aax4btmx6JIQLBc2@slm.duckdns.org>
 <aax6zKn9Y4maBz6d@eric-wcnlab>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aax6zKn9Y4maBz6d@eric-wcnlab>

On Sun, Mar 08, 2026 at 03:21:48AM +0800, Cheng-Yang Chou wrote:
> This was a preemptive fix from code reading, not based on an actual
> triggered report. I'll hold off for now and ensure I provide KCSAN logs
> and verification for such cases in the future.

Yes, please stop doing this. Verify before sending patches. This just
increases workload and potentially introduces unnecessary and confusing
changes into the code base. This doesn't help. This harms.

Thanks.

-- 
tejun
