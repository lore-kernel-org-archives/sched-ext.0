Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACA6A55;
	Sat, 21 Jun 2025 03:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750475067; cv=none; b=BmSLQpOrm9RUhNd6FyMkRBcWbFX7xzYyTNWTr9VVWXHQfm0K1X3jjNo3kMP/vTTXz/71Y/UizwMc6VgSTZydD1bDSXELMK12cDexmnjfnRIyEG0KLlv/yYhMv04HiQf3RZkRCd2Mh1MkLp41WcuRWdpnziybcO2ZuYKMrXnvP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750475067; c=relaxed/simple;
	bh=ItYQRnn18DVF/+A5vlinuRr995gUrdzYKBUjpLZaImU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmgvTZEJDzj+aWQ/Fp4zd+KkQAXLsu+ZY9aGerupJvPfcmJWPP5Jm4ZM/pJRWQ8Z5b3YntzkxjpTIp18bSaan/94ABEfr+8zjrfUcY3Bb5YKov4mKInW6GnPED0EsOh0bfGdfx1xi85vWUfe+GnkoY0wqL3NmBKmcuZhGRZoVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YucsenBc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YucsenBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38333C4CEE3;
	Sat, 21 Jun 2025 03:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750475067;
	bh=ItYQRnn18DVF/+A5vlinuRr995gUrdzYKBUjpLZaImU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YucsenBc7J8gOe8annyxZIPaRka0YccNP+Ytuvjaa10eF0VHvH8SLoLI8avH/TsPh
	 jt2BI4anv4PWkQAHKI5dCVrzNHKmE7nwJiTutGzOclgPphBXFVYynD7Zgn1zSH6NCM
	 0/ms261YCOIvm5yTBPdPAA0jXpZ9SJav2xzxhQjctB9+nPY+sB/GFc2eopJjHXUWxL
	 wl6uX0GZJyUwbmPYSOEE57QFcWVEzYTMNpgPrvDQLF3GS7QDcLRnL49A8D5qPgSVNw
	 9+Q15Er/PVoVYSAGO3W/AqPyVquN7UhwBStlT8zVP+i4m+33XXziPRlnFlhRkwMiRb
	 DObYCywcDJG9Q==
Date: Fri, 20 Jun 2025 17:04:26 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH sched_ext/for-6.17 2/2] sched_ext: Add support for cgroup
 bandwidth control interface
Message-ID: <aFYhOpvAOC-Fc6Rc@slm.duckdns.org>
References: <aEzRVj5ha38RAEr5@slm.duckdns.org>
 <aEzRnjYmqxbOU-3z@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEzRnjYmqxbOU-3z@slm.duckdns.org>

On Fri, Jun 13, 2025 at 03:34:22PM -1000, Tejun Heo wrote:
> From 077814f57f8acce13f91dc34bbd2b7e4911fbf25 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Fri, 13 Jun 2025 15:06:47 -1000
> 
> - Add CONFIG_GROUP_SCHED_BANDWIDTH which is selected by both
>   CONFIG_CFS_BANDWIDTH and EXT_GROUP_SCHED.
> 
> - Put bandwidth control interface files for both cgroup v1 and v2 under
>   CONFIG_GROUP_SCHED_BANDWIDTH.
> 
> - Update tg_bandwidth() to fetch configuration parameters from fair if
>   CONFIG_CFS_BANDWIDTH, SCX otherwise.
> 
> - Update tg_set_bandwidth() to update the parameters for both fair and SCX.
> 
> - Add bandwidth control parameters to struct scx_cgroup_init_args.
> 
> - Add sched_ext_ops.cgroup_set_bandwidth() which is invoked on bandwidth
>   control parameter updates.
> 
> - Update scx_qmap and maximal selftest to test the new feature.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Applied 1-2 to sched_ext/for-6.17.

Thanks.

-- 
tejun
