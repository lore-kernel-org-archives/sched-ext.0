Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F53D32549D;
	Tue, 11 Nov 2025 19:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888750; cv=none; b=uaE2v559tBA52hKl8jKU0lJiBYDguAmXWRhUu3WAt25DzVlRDY/re0IAKHMhtv5hh5NKyGbAGPBC5WkIGS1k9aJ9cGUrkFbpN1WxOYGKm2vRNU/q+wpLkVPJH1LEpjKZB3JH9n8GyOGcXbjDjzHxBz0F6K6GU+J2TCkpIqF9FPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888750; c=relaxed/simple;
	bh=pLq7w2KhajZZoL7NspZCptHnMezjNusE/ZrUiXcg5Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVDnBy0YZBKsiD7QajSk5Y/hWkXJ4sGEPTIbk2SoKFC955qZDura+6KQ7LEXFJpKiE4+652z3O7ESOr+MU1jYtyCS2TbaZQF/4R1xG0Dx4x1blSw3wQS2DL6MWjp6XF/hu3bL4XjmpfRlsnzQOZNQS/nRvbbUS5Vhjq5FG8LBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWiwEZ4g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWiwEZ4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032DEC4CEF5;
	Tue, 11 Nov 2025 19:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888750;
	bh=pLq7w2KhajZZoL7NspZCptHnMezjNusE/ZrUiXcg5Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWiwEZ4gHdLOMBxN/NHlsQ28UhJXXDcPK/LOxxX3usNppi55MukkQPYS9NlFyhzER
	 jpq9vQH2sljX+ySg2H6uP1YkwXRdt5oo+BABMpGn92dMdQyXSpVwfA0mJyoCYBVWjl
	 tXyy7l5QaTTbD5Qoce5+AkOicjKjgqA0XEgb5tAZid8ssJrVzWx2QA9h6e3m7N4x4M
	 08+V7o2o1lZQFWNVv9v/v+iXZYfpnpxn9tBeQ512+lDgxWp6/t2ETU3N1tqsBzsKe8
	 XI9W3cV1IOecoXggkOzVbJVOioyG3XphDVQczTBuCpaWs6Mlj8Zhv7pVAKdE27uZft
	 cxLbb7JjT5KfA==
Date: Tue, 11 Nov 2025 09:19:09 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: Re: [PATCH 09/13] sched_ext: Hook up hardlockup detector
Message-ID: <aROMLU44ztTxc8rh@slm.duckdns.org>
References: <20251111191816.862797-1-tj@kernel.org>
 <20251111191816.862797-10-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111191816.862797-10-tj@kernel.org>

On Tue, Nov 11, 2025 at 09:18:12AM -1000, Tejun Heo wrote:
> A poorly behaving BPF scheduler can trigger hard lockup. For example, on a
> large system with many tasks pinned to different subsets of CPUs, if the BPF
> scheduler puts all tasks in a single DSQ and lets all CPUs at it, the DSQ lock
> can be contended to the point where hardlockup triggers. Unfortunately,
> hardlockup can be the first signal out of such situations, thus requiring
> hardlockup handling.
> 
> Hook scx_hardlockup() into the hardlockup detector to try kicking out the
> current scheduler in an attempt to recover the system to a good state. The
> handling strategy can delay watchdog taking its own action by one polling
> period; however, given that the only remediation for hardlockup is crash, this
> is likely an acceptable trade-off.
> 
> v2: Add missing dummy scx_hardlockup() definition for
>     !CONFIG_SCHED_CLASS_EXT (kernel test bot).
> 
> Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>

I'll likely apply this patchset soon. Please holler if there are any
objections.

Thanks.

-- 
tejun
