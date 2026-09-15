Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB14D0A05;
	Tue, 15 Sep 2026 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499938; cv=none; b=GKlM1dv000fBrXQMl5GIfwNjoOhE7YK0DCWASFIwlaO1kqwCrPPQwByNdcfPNvHmr0YysZW73nVBYggqFEf1iRfgKrNtJarRJYyVWFVtqFrmeLq9BawZ4iPjF8qZoTMo1o0ANWmc0fVWN4Uj0E5SCFMOrlzYzfPML+YMjDtP6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499938; c=relaxed/simple;
	bh=Yq8EgJtWznu0GVHHIf+c1IP1SVgNl2N6THEt4vYoPM4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JhxS0JER++yRhz+PcXCBCa0gGpfTVGsviakFhLXVvUP18yUBAaQRaJMnRbBQz7/TuSjiP8cuZ5TFJN19T9BAuw0ihWYlQf+fYTrwtBGpBCUzpdd6nqHztG3PPQWJmYuY+87b0bYXXMcMbvDkEeYArhcK+cp2BxMop16JYC5ON4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDXu9Pve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDXu9Pve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9F91F000FF;
	Tue, 15 Sep 2026 19:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789499937;
	bh=t3zKTofBfik+swmHsqdQlF9VIoHqDB0Uq9AToT0B3D0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=YDXu9PveKtT2mvYcW02oFVVQEyCMdt3KHzkzqXEx5+FJSeIlSUz0mi8HEsdxOCdfi
	 Abaz+u6hfKQbZOhXANC5IC2f82io0BYqK1EBDHu1wFqm5pFzWLQ0Em+hZ20BqkIbKK
	 nWz4CGjfsCXYn2ql6obaW9QHYrjfyffNr4lDbzv7yTaDEWw9DINGlFxqW+TYbr+U7h
	 wnn5nd6OGiRyKyvz1IH6keMPpyjD4nwjtm/DoXZdnnrapEouke1Z1WDXuV7H1Ad9Tz
	 cl5VYR4PkEsfot0BJvmTDFSB19lQb4uynBRtWYhQUuYHEhbR1Tr3JlP93UJ4y2o/5e
	 1oeHWitF21C+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09663927050;
	Tue, 15 Sep 2026 19:17:52 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <77a248741e07bbe690582f3c31442b7f@kernel.org>
References: <77a248741e07bbe690582f3c31442b7f@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <77a248741e07bbe690582f3c31442b7f@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc3-fixes
X-PR-Tracked-Commit-Id: a9e3760b0838299649c0d57cca44daaf40ba3c33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b87fdc9af2fbfcdb5c24a64139685ef80f6573f
Message-Id: <178949987149.2238025.2488857518081041204.pr-tracker-bot@kernel.org>
Date: Tue, 15 Sep 2026 19:17:51 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 15 Sep 2026 08:40:15 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b87fdc9af2fbfcdb5c24a64139685ef80f6573f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
