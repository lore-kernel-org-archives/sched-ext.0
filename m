Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEA5340A57;
	Sat, 15 Aug 2026 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786788206; cv=none; b=AmkS8hj1cvIEt6M+phsaA3xKHD5cQYRYL+6BzUU08xKwZiYoQpe2GBUGw5Avjr7BUEyz7LpQrhqN0tO/QSTkigOetil99wZ/1z/LxAC16hs8m8ttyUkmKTgBTjxntPp3y9qozra+sbPluT64vrqVY0yAK9UClvcm7FDgNQBwg7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786788206; c=relaxed/simple;
	bh=Gt8YUFMUoftYCnZcgvkKLEsU8EbjCAEMAbVoBRGzQJg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SSPI98r6YQHNFZ94Lv2Xc76qz4VQq+fG3TOsKaodu4iuUHZj5ao+GTMIlX/rGMXPXOfYpV7DOVDMPzWdTvoMC7tTv291K7zd62YMCIvBUnOtMLGsmIWNOzRvmXkAG2DIemWYOnXr/8UTTxZ8rikTe2ImH1piajbIUM3lQrZbEBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWvl3iKj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWvl3iKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8461F000E9;
	Sat, 15 Aug 2026 10:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786788205;
	bh=7Q1Lj9D4WLozKSge2rbCenX+BRmL88i+T+DzMeV7ZxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fWvl3iKjLoLx/4Iq48TGkiGXw2LRWGY1nD68hCac0I0Ie/hI9/lgUm/hnWk6mjZ1e
	 dUi1bm0N0IK8sSC5vdzkcekcujN+b5tRZnJWjJdgmcYNi2uijWaehh3qAvFOYxoqfC
	 KJGrlgmEmTOmMRY9PNODsHh88+dg6sCsQ7kdo6yjArveGKJ1Y5K0vTfe6P1xNRGw7w
	 e0S3B8/4KGbY4r9JQjnnn7YSi3GlxsZ366DzVKrMPflReAY4NrB2OuQpz8yj+fTSw0
	 Po9z6j1TYigHjDWQPFeWPberVah7/bTl+6p85sHp8Los1vuMWjNmlxE5TiTm+69Ipp
	 jzmtnlpTebLWA==
Date: Sat, 15 Aug 2026 00:03:24 -1000
Message-ID: <2553a685cfa254f339bf04e995e2a9c7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCHSET sched_ext/for-7.3] sched_ext: Misc fixes
In-Reply-To: <20260815055107.115671-1-tj@kernel.org>
References: <20260815055107.115671-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3 with the v2 description for the first patch.

Thanks.

-- 
tejun
