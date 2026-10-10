Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B943CEB9A;
	Sat, 10 Oct 2026 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621540; cv=none; b=iMG4JQWJuJn5lPDe6LYWXvCPEHBhV2fm5ID5Lj2myEjdQY5AS0Ymi0w5ThZEDiXn9ky1xc9071Li1E1DbsCJaquQKPJCbpSs1wCAlQ1ied2aEgXCRewIhQU3CiltGFV4qVoWCD9FatVGnnYkN8mT2s3f+W3nf3qDCyzGw+VOksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621540; c=relaxed/simple;
	bh=muAaidZYzTJQzLOqW4/VgJ4O8Y3F3LDpnjAN/aZlFcU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=KHZNSb/O9QaUrFmpxRqTTOvfbAtqEMog/+8v1iVh5VuSifIdZQrXUJshD8QjoQV3H5TQsHizuYRwAqpdGt0xhoSZ7WBwVw/+MJUxmCHlLagliV6HfoUWcnQq/O/vAYVT4YA8BrCfUsqaMZFIqi4a8BSecUXfLgclOhaYOvqVFaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctn4keR6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctn4keR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13041F000FF;
	Sat, 10 Oct 2026 08:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791621534;
	bh=eIXLJgzfIYX8XUWKaz3A2FENlI/hoolFv6onHRMcQeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ctn4keR6X5a2HwgDWJrg9NoYyXTCbPytb6CZ94Ijx8yYtYTVNKPqqWEPYMmI4jbk/
	 oJJwcLx0t81yTmgwoqZ/gc6rFTJT3qPYJ9WC8sTGoto2lleTP2ORb+QyOgdLIUOfXW
	 9r2qxwx+cbZH5z1Gq3Y5vEV8Yhus5AEZNNGH08BCnCDj94vZ4yqHfsoADUK7sZPcKR
	 Y8zjwsL2lzgCbRFJXlajmvXdFPsYlMjhgtD1A7yyrA3kx9O7umrAKXgSULvta3v/37
	 hCAGhXhADf/auIphfBWKovVnRs5keYm2Go/I6sT29paoGqQur8xt8LQn/lVSU6ioZw
	 HLhikKJmqVfmQ==
Date: Fri, 09 Oct 2026 22:38:54 -1000
Message-ID: <6100f6f22f41f99811b8c1433685e9be@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Hui Su <sh_def@163.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sashiko-bot@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Fix use-after-free of
 a destroyed user DSQ by a deferred reenqueue
In-Reply-To: <20261009220001.196762128-1-tj@kernel.org>
References: <20261009220001.196762128-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes with the following tag updated:

    Reported-and-tested-by: Hui Su <sh_def@163.com>

Thanks.

--
tejun
