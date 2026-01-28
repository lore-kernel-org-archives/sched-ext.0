Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C618027;
	Wed, 28 Jan 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609974; cv=none; b=YPufa+tjOBolhVfa5suJa5bFfTslhvFhmEKM5gWhwHkHMA5H1y2mzNjsap9jh/TEAC8ex8Hw33gTvEFSQjRvjgG8JTsNgvU7Uyi22sLkbl9X2lAtDqJ978TkmHqpagNvLY8oG3F00q9rRvXka8+L0t1s5r6PpTXa0R6rCB3a5qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609974; c=relaxed/simple;
	bh=puOqCe2WUieCczjraaPMAlsv+0nDcLD9SLGlgfsBrqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvx+pvTkByX+8FDh8cJITQJ7u2PPZwyc6Zgmm07e3APhZ/hQZ5JEFcrpAQpz4BgImelgDG99KGE0VO6jlRhW65zUb4dHD07wrRVCwCxMh0VvxkyfZ2tqDkFgm3gPCEK6/z10vjsebb3ARrbG/hTDhUapO/gaLyfzTcx9EKEn8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yl3JFNBi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yl3JFNBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633D9C2BC86;
	Wed, 28 Jan 2026 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769609973;
	bh=puOqCe2WUieCczjraaPMAlsv+0nDcLD9SLGlgfsBrqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yl3JFNBiL3Ev7//2JGqs1r/TSa5y/0mgW/ehu/EGAyy1D1mtADF3y5ZKJEUddqHT4
	 MW6VjDN+VX7/MIJLYHudz57Ny+5ObrRHiUqGG8Yph099IXqQJA/6XFW/WxQNSC1W2H
	 a8L3tMvRLkroIMRGop3p86iXGh0w6Z/mkzDHQ7/Q=
Date: Wed, 28 Jan 2026 15:18:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: stable@vger.kernel.org, tj@kernel.org, arighi@nvidia.com,
	void@manifault.com, sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/2] sched_ext: Don't kick CPUs running higher classes
Message-ID: <2026012842-bubbling-busily-65bd@gregkh>
References: <20260124092043.349976-1-christian.loehle@arm.com>
 <20260124092043.349976-2-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124092043.349976-2-christian.loehle@arm.com>

On Sat, Jan 24, 2026 at 09:20:42AM +0000, Christian Loehle wrote:
> From: Tejun Heo <tj@kernel.org>
> 
> commit a9c1fbbd6dadbaa38c157a07d5d11005460b86b9 upstream.
> 
> When a sched_ext scheduler tries to kick a CPU, the CPU may be running a
> higher class task. sched_ext has no control over such CPUs. A sched_ext
> scheduler couldn't have expected to get access to the CPU after kicking it
> anyway. Skip kicking when the target CPU is running a higher class.
> 
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

You did not sign off on these patches that you are forwarding on for us
to apply :(


