Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F36A1946DA;
	Thu,  9 Apr 2026 01:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775697574; cv=none; b=RftBrajbQi+kEFH+VVJZAENKtOIxg0BcFOUEWenXZb8GHZYcA1dcdYDOd7qbLCODfp05bqh1Crk4piqkWfq+BETX3Fiw6saltJ4GHusVCuAkTehnMm/mntWkBTjouzA5BikAWQeQRryr382mRJBteT/f+SO+YF23MUu2rh20dFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775697574; c=relaxed/simple;
	bh=rUiMcq6WsTa+7oohVWjhNr8PzpKxEhP0DZBwv0rfTbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cx4XtHElultiHYxpblZDVBBO4s1RBoFSZdOPpdp3Szb/9okFyCIqmdCTzforQrPnQP0fqMfe2VGXVFoogUm28+aJrV72SmPac56OfURHUF+4yKoKoao74BbXN1zShKOHvDn/6gvI0GwvyJUtU8MxVJHupOuwrBiOaivx87L2Xmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gemEGW0V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gemEGW0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8BBC19421;
	Thu,  9 Apr 2026 01:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775697574;
	bh=rUiMcq6WsTa+7oohVWjhNr8PzpKxEhP0DZBwv0rfTbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gemEGW0VaxCyh0LPQWuqMXbV4xercr98FEmA4TUMdz1DTcOclNZKT68PpGtAN2Uwk
	 6+/1Qm390BnMR7l82HxWZi2G4HplLh93OO95sSuZ7fKGjH6E4y1RF4FabHoxix4TzL
	 TOYWq/QBgyGI1rCSZxVkcFQ7K4eG88hyQUaKMWVHPjSEkbSqpAC8r23ntaUpgKUZIq
	 L7fI0SUCssQ15ruKdr57p5RR3Jewjmf7vu5nJ2GqbwStn+2kcvuZo2cPXqlB1t+hP2
	 uA5gOqBT6vgYK5Y+hCsKg58Xjk+cQgUqW6e6pRy0JH3YPF4vbwPlmqCrUA/MZh+pQ5
	 ImqyDOxnJLoHA==
Date: Wed, 8 Apr 2026 15:19:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: void@manifault.com, arighi@nvidia.com, kernel-dev@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Dump the stall CPU first in watchdog exit
Message-ID: <adb-pduIY6oZxLYh@slm.duckdns.org>
References: <20260408031113.76005-1-changwoo@igalia.com>
 <20260408031113.76005-3-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408031113.76005-3-changwoo@igalia.com>

On Wed, Apr 08, 2026 at 12:11:13PM +0900, Changwoo Min wrote:
> When a watchdog timeout fires, the CPU where the stalled task was
> running is the most relevant piece of information for diagnosing the
> hang. However, if there are many CPUs, the dump can get truncated and
> the stall CPU's information may not appear in the output.
> 
> Add a stall_cpu field to scx_exit_info, thread it through scx_vexit()
> and __scx_exit(), and populate it from cpu_of(rq) in
> check_rq_for_timeouts(). In scx_dump_state(), dump the stall CPU
> before iterating the rest so it always appears at the top of the output.
> 
> Introduce a scx_exit() macro that wraps __scx_exit() with stall_cpu=0
> for all non-stall exit paths, keeping call sites unchanged.

Would it make sense to generalize this so that the exit record the CPU the
exit is triggered on and always dump that CPU first? That should include
stall case, is likely useful for different cases too and we don't have to
add @stall_cpu to the exit functions.

Thanks.

-- 
tejun
