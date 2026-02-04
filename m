Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E332860C;
	Wed,  4 Feb 2026 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770235741; cv=none; b=m6qmwa1iim5i0l8X9h7b0mJlIv0eyl+jTPzmW3rkJ08Bz3pHw9f3iK4vK6FujrOn10KZSx2BwKtiLw6iCielCHDc85LTciZNxchfHUoJZ/s8Ug7OuBf2f/nolya1Tab5O5ntGhrQ372UPyTyeGlEuwFWlJboA1B4JTIAOljfEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770235741; c=relaxed/simple;
	bh=ZhALBC5cEvfIYW+PyEWdmiKuK15teYMz9joi3prVWQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDr84cwBjVASor8Q8DP/0EY3gU5aqmzT5iFhpzCzdE5lep4Q23k75XTMMgt+biz1qRJ2EvQFYOg6uKwNEZgHP89x69GYDQLrwr0EtKsUNJVAV3ttAE7YwBFjYp0rYSg11kIeUaYgDu0i4BCX5QPldBVzdAfCjLMWLMbv2Bz4+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgSS1/LL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgSS1/LL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F3EC4CEF7;
	Wed,  4 Feb 2026 20:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770235740;
	bh=ZhALBC5cEvfIYW+PyEWdmiKuK15teYMz9joi3prVWQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VgSS1/LLO0srN0pyioUWsfG5ay1fmeHQMTw8Y2KbW1T9WrUJE92W7noCviZU0rc2z
	 ImqmqVWMIIxJAhD9qUmWQf+YspBgW8IeklLhH56M5zHVgyCsmygRkYz9VR2BOzVod6
	 r+dMA50gVBSIfeziCbSGGirVtVsTV9tK4fD2czHOpe7Z+W4UMhgKnxlYhmXbPVW6XV
	 fgkmds2netZwy0L9PbRrTnt3KPqbz58JdTWLfuQzcQskuUiFoLuYTOjoDDD37kZM7r
	 iDSwSVz9Z4Hy6NPVhoRikQyW/JD5AwGaUCyIRFWrG9wXUix5D3AP3J6cHfmTFEI5xi
	 coqESD512Sdvg==
Date: Wed, 4 Feb 2026 10:08:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix NULL pointer deref and warnings during
 scx teardown
Message-ID: <aYOnW5z72oduefZx@slm.duckdns.org>
References: <20260202151341.796959-1-arighi@nvidia.com>
 <aYDaao9Xb_Bkv0NH@slm.duckdns.org>
 <aYDy-tCqsH990lW9@gpd4>
 <aYEOdPEkgA2eUcTE@slm.duckdns.org>
 <aYEqGSGzxrYU5PZt@gpd4>
 <aYH_urViwKNiamo0@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYH_urViwKNiamo0@gpd4>

On Tue, Feb 03, 2026 at 03:01:30PM +0100, Andrea Righi wrote:
> > Nope, I can still trigger this (with the same modified scx_simple +
> > stress-ng --race-sched 0:
> 
> A quick reproducer:
> https://github.com/sched-ext/scx/tree/scx-bug
> 
>  $ make
>  $ vng -vr -- "stress-ng --race-sched 0 & ./build/scheds/c/scx_bug"
>  ...
>  [    3.375119] BUG: kernel NULL pointer dereference, address: 00000000000001c0
>  [    3.375836] RIP: 0010:set_cpus_allowed_scx+0x1a/0xa0
> 
> It happens almost immediately.

This should fix it:

  http://lkml.kernel.org/r/fc034891cef55029c16122f4279e4057@kernel.org

Thanks.

-- 
tejun
