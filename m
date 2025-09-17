Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1EE331AD3;
	Wed, 17 Sep 2025 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100166; cv=none; b=KnDh2fp1m+Vkqhzv4qbay8xioprr+UHgD4sHlWsMRKU38urS/AbNo4mPidQk1s9lA0d7ZCWNHhCubvc7ZRchfHVj54SoVlqHmwMTpVaeTOkk6lwZLDep/7lRLio3Mj1nZmLQ04iado06qS0Sl+075+PdCBzgMoCx/OrkWwolRZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100166; c=relaxed/simple;
	bh=3XnjNmf7GdANoajdgapnxlf3eClthNYOnZ/Gie6fwTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JL5OrWgJN7zLOEfj55J3H3SL5ZqpMeG4Xnt9fDVR9/5F259Dp3C/DsVzOs4g6ySFW99VHdhCgL9xtH8odC2ge3KtRuZF4ecXKbchBaYznkuZVCYPzN1hesEuAdnHl8iW77nKlUUXJ7as8RlSKHTjsCUJEQwK5KxpF0ZR+Xrd6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPXlvUtm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPXlvUtm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D5CC4CEF5;
	Wed, 17 Sep 2025 09:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758100166;
	bh=3XnjNmf7GdANoajdgapnxlf3eClthNYOnZ/Gie6fwTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPXlvUtmo2rLwA6DOTWAJl1kRn69iY62tcqhiWIGh6nmoelqEHRjxFFx7tlLIgkn7
	 0reH9QGWBRCJ/oqQz7wgCfUCkhPgl+h0+2SMCGLWJV9XPcnMf8T3cBCi4i49r0CfeD
	 kyACnivQjSv5efp+gHi00aXlUYu3OFvtbHFkRwdb/95jQpR1q48BIP6G5RKBBxnSjS
	 WttaPVhW5oRhd38Y/f9jQ/J2ypR/PpHGw6jDS0fJ3iSJS+OYeZ/HMT/EwZMu3Q94zB
	 XrApfC1yN3cwm3JuLohQwoBecu+t6otleCnU+nx8TH9DVsB+E4WBUfaupsjGjP0TXW
	 ddj35W0VhOy5Q==
Date: Tue, 16 Sep 2025 23:09:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-6.17-fixes] sched_ext, sched/core: Fix
 build failure when !FAIR_GROUP_SCHED && EXT_GROUP_SCHED
Message-ID: <aMp6xLmp_h_Xa1ly@slm.duckdns.org>
References: <aMnRYuUvbYsc9S2L@slm.duckdns.org>
 <aMpRDcIhrnx2ZaIr@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMpRDcIhrnx2ZaIr@gpd4>

On Wed, Sep 17, 2025 at 08:11:25AM +0200, Andrea Righi wrote:
> On Tue, Sep 16, 2025 at 11:06:42AM -1000, Tejun Heo wrote:
> > While collecting SCX related fields in struct task_group into struct
> > scx_task_group, 6e6558a6bc41 ("sched_ext, sched/core: Factor out struct
> > scx_task_group") forgot update tg->scx_weight usage in tg_weight(), which
> > leads to build failure when CONFIG_FAIR_GROUP_SCHED is disabled but
> > CONFIG_EXT_GROUP_SCHED is enabled. Fix it.
> > 
> > Fixes: 6e6558a6bc41 ("sched_ext, sched/core: Factor out struct scx_task_group")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202509170230.MwZsJSWa-lkp@intel.com/
> 
> Missing SoB line? Apart than that LGTM.

Oops, yeah.

> Tested-by: Andrea Righi <arighi@nvidia.com>

Applied with the tags added.

Thanks.

-- 
tejun
