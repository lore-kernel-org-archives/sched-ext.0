Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F2830CD89;
	Thu,  9 Apr 2026 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775716099; cv=none; b=sm5aVJNG5nca3la40EzJ6S7aJq5/KBCS9lIFaqN8J2fF1lP9VwyvBa6DKFsVv/kGWcIVdIQ+qdB1WMHutjW9yhKdc3Czjoz2qF9C+ArliTs7zfg9gEVcx3GnTdB/4/L+HQFhPnLary3hiASj4sP15wnfNgx+aGzACUwG+yNNRJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775716099; c=relaxed/simple;
	bh=X1uFgQEy185bcE4KxSlx0GuKRSvt24zPDN+7s7XVTaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXpoSarV+sINNM/UYFLzFQOvd8t4oEDy8Z0t/zIkEsezqrthRgDZQIPKhZFFtBnYF0WGJmwvSghTG9BUP1f2RBoQdZZ64xk+cPg6CB+iORUOdjN6Oap99nAA+anlgw5h8gJHRfDLrSeLByAj/9WMlRRZhv6dYYgtgMkjGxDv1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuVZM/jO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuVZM/jO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D49C4CEF7;
	Thu,  9 Apr 2026 06:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775716098;
	bh=X1uFgQEy185bcE4KxSlx0GuKRSvt24zPDN+7s7XVTaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iuVZM/jONJLcoYxaQQ9dtUCtUhEWwugcn5Az/QSV9Y12avBjYWr5S4/x5ufTHfCRf
	 OLgzva0Iiehi7SLYTpM3BO0YHCdINT0Pmbm9XPc44FmP5u12xCy/qtxwkidnDdwxki
	 5xVDYB9B4vz0OK67EhtQnJOScGPwld2ysV2qW0Kem+vNAC6+b4r8bvZNvuP/nwWp9o
	 ix6p8dcTgCubMJ90fXlwjeyTKmv7/B1hape0uu2KJLu6gmD11en2biEI2+Nf+Azg6y
	 UPBV6DjpVnGsfLXJ/meXe8E8C1REbKpbGRVqS+HRFpsA9wpnIGGY6UWcn6naTh6Vcz
	 pXl2wSB7xC4AA==
Date: Wed, 8 Apr 2026 20:28:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Changwoo Min <changwoo@igalia.com>, void@manifault.com,
	kernel-dev@igalia.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Dump the stall CPU first in watchdog exit
Message-ID: <addHAYU_iKIC15nY@slm.duckdns.org>
References: <20260408031113.76005-1-changwoo@igalia.com>
 <20260408031113.76005-3-changwoo@igalia.com>
 <adb-pduIY6oZxLYh@slm.duckdns.org>
 <adc-l_7ZNWLkyPFL@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc-l_7ZNWLkyPFL@gpd4>

Hello,

On Thu, Apr 09, 2026 at 07:52:23AM +0200, Andrea Righi wrote:
> > Would it make sense to generalize this so that the exit record the CPU the
> > exit is triggered on and always dump that CPU first? That should include
> > stall case, is likely useful for different cases too and we don't have to
> > add @stall_cpu to the exit functions.
> 
> But if we record the current CPU the exit is triggered on, in
> check_rq_for_timeouts() we would prioritize the watchdog worker's CPU instead of
> the stalled one, right?

Ah, right. Can we at least generalize it to culprit or offending CPU? For
regular scx_error() triggers, we'd want to see what that particular CPU was
doing too.

Thanks.

-- 
tejun
