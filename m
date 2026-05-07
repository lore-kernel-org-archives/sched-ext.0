Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A5348463;
	Thu,  7 May 2026 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191889; cv=none; b=I9FdKrJV5D2JESfYYX/XVz9fPkhLLoBscJxPbnOAaE7LDQdeRtGMkcpvjtuj2VIUq5HGjhmpLib53kGiUne1/eW3zajCI/T5cxZVkA50Ei4ospwLKJxsMIYOuA4Mu7zo5RRWoX9oC/bDlBD4wwi/D33/c/CYEKbLN81LO2dDSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191889; c=relaxed/simple;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=blMoy6tY212RXHmPT8Fjkazbpr0HweJOyO4pPN7UvMJWCCPj2y9wCwcQ81sDLNiePmbtdE1fSJY3cIVzCXLva50x/1C4Ay5feeoDvUKX8SxA4ARCyi7pRKDVY7po18uMldBKj24q185dgKNcxVRz/8wonNj3QQiwjr4OefVvTMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzLmi3k+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzLmi3k+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE6BC2BCB2;
	Thu,  7 May 2026 22:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778191889;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FzLmi3k+vpM8ma5gpHAt2iCRjmThcQo7FWwQ6NR30PYPlZDjM2CdrfTQ15Hx4g4WH
	 esymcZVfGxgMnWwm62/SHD+wfzxvrnboMkY7A6/xwvLy7NTBJ7Kf7MckGtNXrAQQ+C
	 EdczivCbnP78WublvhW+z+VaKhOQyT9kkpJ8CCQ9XGnfvnliDhK9VLyqWGQ1YaTZIp
	 EdUaoM0AAjt5v+a3TevJOtmibHvzv8NIUWsNj8tzlmiucucNDvttJdZL/lh1MYx6KL
	 qg40AZH2A73n6jizoiaJhkkXfJ+k8GIFfN6Jrg0cII4n5EjMRRi/0NtRGM8o7wx0JK
	 o2kzoaORMt8uQ==
Date: Thu, 07 May 2026 12:11:28 -1000
Message-ID: <ad9f6467175c1a6f8c1122e011b89074@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Drop unused scx_find_sub_sched() stub
In-Reply-To: <20260507220235.3312282-1-tj@kernel.org>
References: <20260507220235.3312282-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1-fixes.

Thanks.

--
tejun
