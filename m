Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181C2227BB5;
	Mon, 29 Dec 2025 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766989126; cv=none; b=EDd+ZufAlbj6cXaxxBnn/adXXFsQ2FJLN5WkRgB7HyYphjc1MNHhKgl6NoVYcIrojsmWgEy04dk4f2hiTlBShH89U90QffGLeXN1FH9PY21Dci0861Z5qD3OweHJq6Wio76/oFmY2erIj1gpzB4QgwyCZ38RcJsRDimGs7Cq9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766989126; c=relaxed/simple;
	bh=g6WPgva2VOAtSGWbbS9lM5CEIvIBADTpRK3FmnVUdpA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EYfIKGwpzXXfv3tiar4f9EshMVglW99XzjhxX19DItLIj5rC0ml7t1WrvLGMg4ma7e3vMKHUhy2Jr02ViVSoyYxOdIY94FYeWkzvscXFuOm6J+66kxYoMEEcMyUtWVpq8BfVj4A98WZuIx+ips3RdeTuAdX6zUzqJOiWuA74In8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPuOsi63; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPuOsi63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3F8C4CEF7;
	Mon, 29 Dec 2025 06:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766989125;
	bh=g6WPgva2VOAtSGWbbS9lM5CEIvIBADTpRK3FmnVUdpA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UPuOsi636c0flgw+KpxR5S3BSH8uVvvJKM/xDZrG6mpX0qUXwnS59FLCZxsR29aE9
	 BNFSEXJOR0oE5d4+3a8zn/NZ6q/2MSUNDcz1eWHNrp1xC9RdkkoLxzAGltHKOlQfk8
	 KCZ8USQaDaUc2lYn9Mbz7/KtqzHErCw1wqefSwRZY/1+BfdDrTIABJ1VCiP8I68n60
	 4GwrWcbs7+wkSoPlramaBkLPhXQek6R/OV7nADxJKtAJLmiwLlk+7fDf2inJhOH5Hw
	 PJYg9RqStQmyzDhGGBg+jpAe/sBxxCwfQC16zq2Fj4kipcWVtmKjFlJG1HVzSvxbk/
	 xWKYCi8ykS2Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F288B3808200;
	Mon, 29 Dec 2025 06:15:29 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.19-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <311f420a9bebc537ef84f66b0de04129@kernel.org>
References: <311f420a9bebc537ef84f66b0de04129@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <311f420a9bebc537ef84f66b0de04129@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.19-rc3-fixes
X-PR-Tracked-Commit-Id: c9894e6f0160414b57e895332c580cf5c8da6780
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7839932417dd53bb09eb5a585a7a92781dfd7cb2
Message-Id: <176698892860.2860963.12874877848587685147.pr-tracker-bot@kernel.org>
Date: Mon, 29 Dec 2025 06:15:28 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Sun, 28 Dec 2025 14:51:12 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.19-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7839932417dd53bb09eb5a585a7a92781dfd7cb2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
