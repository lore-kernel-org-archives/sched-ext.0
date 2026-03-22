Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83E435958;
	Sun, 22 Mar 2026 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774209990; cv=none; b=nzEVlq0Ga2sLkAYmP/F0+Ry0l28wdmeGv3moi7qYj/VLE9CbTW1zxRVpTUjfrQFo6jaPSlhz+IeDg0AZeqPwUm1d1pR1U31gDJtQKMnXVdfNQFjWlV9vCZF6prxql+zaB7RYB7U72G1rVaq+fAx/hTy/28a134B9m0pLjr5C0cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774209990; c=relaxed/simple;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=rGamOrZMXFiX2sSBABo1KET2DVfUEk+rOdg1HFW2NNn213Pr3xXXAiyVuGtEg9ljLR7xST1F0Jco82wIW+M5q3jz6cD8by7/xknbHl4hC0MdLSAxyUck1IdyEsxP1ygPLgUYi4yM1t4EZk/Bg6nOqPPzntzqKNmSAoyB5HurkQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7dTlVRz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7dTlVRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB62C2BCB1;
	Sun, 22 Mar 2026 20:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774209990;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B7dTlVRza64dhcq3BwCRR7qy/AG/RSrjmYmFUTCWd7jbTAmh2RSHUNE2bUWPVOk6V
	 pKSS1g8dosvQXn0IOqXarbbz9+Z3SetLG0BDpAg7MQ2X23dDCRDBJc2xDIUNQLgvCm
	 XjDVpU40oKKzh+1fjbE8+8XnNBmZZaXj1ni8v7DoXg9gFUpaEJvXsJngc8L5gzzMhE
	 Es9VDnjRax1q0h0LnB//DdJ5186Elxt4l/Gf5bvFy3AFj2yUcHp/yb064VNvAI6zs0
	 hLA6iM5SR5uY9M0u0Wwe+oHT59VNWpEiZ49Eq1lkhcCZvOtfzyyf/1psGlieLMUchS
	 tidYL9DMbTpJA==
Date: Sun, 22 Mar 2026 10:06:29 -1000
Message-ID: <45be08b930f17e6ed0ae37ece9a8e1c8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>,
 sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 kernel test robot <lkp@intel.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Guard cpu_smt_mask() with
 CONFIG_SCHED_SMT
In-Reply-To: <20260322065146.339038-1-arighi@nvidia.com>
References: <20260322065146.339038-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
