Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC12289E02;
	Sat, 19 Jul 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949744; cv=none; b=cnTxKG+JuFmkTBDqwxXwry+qI6pP9DN/QUpV579F+nj0wVtIYnv4NkIPMTRR9HMYFUu6dlEiE5O0IbUinXuAqHkO1GJpLvIB8Ec+P3y+XwZEJk1KaSsFVoBAnbfXTjJCSaMkb00xC2aL5XNpzfdmacyYL/6YTurCHUHqDGF9GD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949744; c=relaxed/simple;
	bh=1OfZ8plrvX9b/UBqsDkNEkiiL5EF+SuorAfBigFZhlE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Sc3NxUhuZWmFzWW3BteYt7uexSQs8C/tgm0CQtfTE15WDCVcoeJeTwLneXkKtEyQ9hWcVjRCn4we5gdwG1rpGJ/t9fjKSTd7i2ZQhPvSznJNtjGeBr/hpB7vYtcc+3Tzd1vQaueX7lNGAUMUegzUzaK8kC3XvZ3bY9fLVglH/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulqTl5nF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulqTl5nF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34053C4CEF4;
	Sat, 19 Jul 2025 18:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752949743;
	bh=1OfZ8plrvX9b/UBqsDkNEkiiL5EF+SuorAfBigFZhlE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ulqTl5nFqbayNSwCxKDUS3jP9n4WSJUDMncyUvssaY8qAiYUAYVdqNELZAvg8AqpQ
	 cMidxiVbQ/Wtif2S/yavo7dC3xLGJTWAV3EAWFUwm2XfzREHPTTB1SM+S53P/UJgEW
	 sGtD025rqre/Nm1+l4nwtAfsggCCFvNy3zsycOyAfuP6gBQBVU50tLRLyzEYJltN0e
	 PUPZE2vmJsspUOHxUh+hNKkuBkl5HaR0V8CE2mJTOBPP4YE24dokHuC432MVEkcla5
	 goRL6YTKLCjvJXzhrtXHfWq0U8/taoveBI1tNpFC3gnvkhY0ryIPd84jaLSIZspAhp
	 bNpQwkWZltGMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD11383BAC1;
	Sat, 19 Jul 2025 18:29:23 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aHvPvsnPScZVpVAM@slm.duckdns.org>
References: <aHvPvsnPScZVpVAM@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aHvPvsnPScZVpVAM@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.16-rc6-fixes
X-PR-Tracked-Commit-Id: 06efc9fe0b8deeb83b47fd7c5451fe1a60c8a761
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf61759db409ce21a8f2a5bb442b7c35905a713d
Message-Id: <175294976236.3026904.13662774877694299885.pr-tracker-bot@kernel.org>
Date: Sat, 19 Jul 2025 18:29:22 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 19 Jul 2025 07:02:54 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.16-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf61759db409ce21a8f2a5bb442b7c35905a713d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
