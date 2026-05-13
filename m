Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C683815EC;
	Wed, 13 May 2026 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778703989; cv=none; b=ldHM0L8WonTKk4W9f9eX6Wv11c2oPsmqBQqoQGFcfagVjGyEdzleoKJp3QojeTybSzibzqZCmlfDToUbqdzijgzq8nyeYr1SfH/gL6Ae+d4QOS+4qd92z9ErYzCzhX72i0luWWzFzxar6oaGnQHMsQ6n9cDGpvswjP13oBhYx90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778703989; c=relaxed/simple;
	bh=nU03f9zzpKKyWTp/DNCHJVM/Lkx7S1ip2+AWA7czTOg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ESpnIx/n0ezXn5k7BLKEzzy8XBJIV7Q2Ds88YnceJLyP/LScak03XwULnALXxv6Kc0aAEGb5BgT2fRsHIb+UQb10Wju0lqTFaL0lTDiaRdBaG4tKMgQkHsD14HY51xIXBCbwXwVHdQEDPf+0ra+4XxLwh8nspvDj7lbLJPMqD4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbKEKlct; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbKEKlct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94928C19425;
	Wed, 13 May 2026 20:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778703988;
	bh=nU03f9zzpKKyWTp/DNCHJVM/Lkx7S1ip2+AWA7czTOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SbKEKlctMFXS3sQrIK6OtAhDRDPWshIHRSVSsyWIjsC+TwG4e+7bAsDRkyDypGIPU
	 xPrwiIEWstOTX4US2uUH/28JGotMeWx0Kptgo1dbfWZh+byzh4eebObKjGiuSkz8+l
	 DEY71kE0RmCW+BVCrlAyyMcJZ4uwpNdWH1XIoe2sZ+gRUOFZBXp0Rfg72t8WAHVK7K
	 XVVdcfyAvDhbMVoLC9n5+Ug3nuxQMBW7PpGmCIqoJWKHOdHRGumBzLSiO3gR2MP8pO
	 /zVZcCwWpYduddhsI0oyqMRi+HrfsLdL7fV/yuJldwR6AFB+osZv5gBN5oLSuYR1oH
	 eCwljGIJMR05w==
Date: Wed, 13 May 2026 10:26:27 -1000
Message-ID: <5e906f0d6ed1d8a744579cadcd7d22a1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Use HK_TYPE_DOMAIN_BOOT to detect isolcpus= domain isolation
In-Reply-To: <20260513112438.642055-1-arighi@nvidia.com>
References: <20260513112438.642055-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Wed, May 13, 2026 at 01:24:38PM +0200, Andrea Righi wrote:
> sched_ext: Use HK_TYPE_DOMAIN_BOOT to detect isolcpus= domain isolation

Applied to sched_ext/for-7.1-fixes.

Thanks.

--
tejun
