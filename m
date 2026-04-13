Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684CD26CE32;
	Mon, 13 Apr 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097313; cv=none; b=nw2Re9Y3YZbMPiCpmJy30qTSWcAsaGoQIo2FISs1UQQvJ+jVzH8PD4Ldxrgxi9zvozle5lJV7hVAyI50HMTbVPMiE3Va8t+y546Y1NeUpfZ9qTs/53E+L46IOjP/hDR4Z8CVJ2YDgyHqTgvSgaN3LO4BqWdBjFBP4hikeiR50oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097313; c=relaxed/simple;
	bh=gH+U4+OdEm65gSbUDK7A2a+DkAveiosu8QV2nLLlbjw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=pCp1lwe8OI8IK/w+zgREu4ZpyMcwVGE8rOEe7bKT+CLdXav36oEtaX7ZXcHENYRAKm6lX/IDXdg6oM/iPCuvPFOrRytyAYTYuoOoQscDYWUbn6LASY+1yc/9dB6OOmVwq6C9l1g6x5WMTB09PZkv1zWcIhhRo9vJkErMGpBsPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL0Ew27Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL0Ew27Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB38C2BCAF;
	Mon, 13 Apr 2026 16:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776097313;
	bh=gH+U4+OdEm65gSbUDK7A2a+DkAveiosu8QV2nLLlbjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PL0Ew27ZytWl4lvae/Up6j0185AGRaaonHXY9uJ2iya5MTWb3BGhxH/nuhseXxFaD
	 pkwpuV9C2Oxeobyv3y8caTeqwvObSCjEhNAmtWM93O2DpDrWr46GkFRcsSqw6N4w7A
	 JWSWifk0vkN2f5aSXKI/5Md8IEr59sE39zXWg4zqPgXHirf9yRXrbycfwbotq5zT2n
	 PBFIOCziC6i5FUq61tbeH4OD4Sv5n1PXjdm3YGJ2stwT9YAtwSkI6Wm/xPf46JqaZR
	 gVUNcXzfeVngLTj85r+r4jyFD92G0soqGD6iqGixIJCJGdVaRBv9DLspf32COCkgt5
	 7p3bHctgvCrXw==
Date: Mon, 13 Apr 2026 06:21:52 -1000
Message-ID: <6f41af987becd940b7828c5e3068dede@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Make string params of
 __ENUM_set() const
In-Reply-To: <20260413124902.843578-1-jpiecuch@google.com>
References: <20260413124902.843578-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Kuba Piecuch (1): sched_ext: Make string params of __ENUM_set() const

Applied to sched_ext/for-7.1.

Thanks.
--
tejun
