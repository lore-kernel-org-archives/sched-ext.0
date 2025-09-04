Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24363277C8A;
	Thu,  4 Sep 2025 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968187; cv=none; b=XFhfWxtuySZZTAXqdGwGry9tFsdypMuZ6u87Gf95jPLpNAeo74Uq736StGYGEIq+7yCahrMdMeXFB+xkoBwlKbeaHassENQIanF51LeHnksDwrAGA+xW+ogQveNTeE9ZZYPiBOcl2H/yhx9saDHy1cNhFErwerFZku9YYUW+pA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968187; c=relaxed/simple;
	bh=JjX/DaxIPyFZLeRiVhOQFQI6wnaPNWiScl0XGTAvYt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGX3fbvtJlHYkZP+sbx6VPJr9O6NZ/RhCC24bt6k3Q4p2kcGYBGm7hT9RM776lSLNJJEkpBkHLbrtbZ2KGf+L+PdE8M+1lvwn/blWh+x8OIgdWHvorpl4vJbsYhFcnMTl9hTT+IKaejKM9qsMEH4C+Fzh0AmpZF74LXknzZ1xXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqi182LC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqi182LC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCFAC4CEF0;
	Thu,  4 Sep 2025 06:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756968186;
	bh=JjX/DaxIPyFZLeRiVhOQFQI6wnaPNWiScl0XGTAvYt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqi182LCVwyHyEGQkgnAyliOLBxSny43EMNZWg+L25dezkFNKZvaFheLBrQ2TqHRg
	 vBFN8LVJG9PqKNoZFXUwDh9QWuyTvnOOWxqBqK67DrwdGwViZffWXxoHr9sryjXP2A
	 olv7jnTtHm5hnC/pAk9MwQPCp2IexOsBwqTTqboGWBJDS4XTnb+DI3T9HwFGohbhvQ
	 j30fx8d45Z1hRdTXyukSBhS+hNTiX/50vdUqo00onrVqI9saKTnKFD27pocJ7PzkPf
	 xpc2Va0lvVWltEUUDo6lokQQrQersrjL3Lqlqu4m7X0H0Vek447qlp9F2iOd9iFxu4
	 Paxun8OCPmwXQ==
Date: Wed, 3 Sep 2025 20:43:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Jake Hillion <jakehillion@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] tools/sched_ext: Add compat helper
 for scx_bpf_cpu_curr()
Message-ID: <aLk0-SlHR1aBOYin@slm.duckdns.org>
References: <20250904053100.47652-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904053100.47652-1-arighi@nvidia.com>

On Thu, Sep 04, 2025 at 07:31:00AM +0200, Andrea Righi wrote:
> Introduce a compatibility helper that allows BPF schedulers to use
> scx_bpf_cpu_curr() on older kernels.
> 
> Fixes: 20b158094a1ad ("sched_ext: Introduce scx_bpf_cpu_curr()")
> Cc: Christian Loehle <christian.loehle@arm.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.18.

Thanks.

-- 
tejun
