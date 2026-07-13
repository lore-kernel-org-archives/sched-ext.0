Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D549C3D3304;
	Mon, 13 Jul 2026 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783984607; cv=none; b=o3nC1XFrtYZbzzhcN81+q9Pp3uBmw/vC5fB+VNO6tze5Z6sH3HTGufgCUO/51V81KqH18oAlpEMHus1gq6qmhhgwiFceUVdERI+BXdDom6zrHWL49Zm6XrRrqbKsK75bIuP1UalqnBi6uZnhf5JfdbBE++MNkFmMbOavsswp4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783984607; c=relaxed/simple;
	bh=8tHuk1Kwx9gyWdtqKPuFeDMwhWzjGoBmQNc8v9kJqsE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BiLLfAFRo3I0UtLGmcQpvO9Nz3Ud/dpc5AnLVgTvLsEM4aM17Mu/2ZsqUgwaAsrueX+9eBpvVB9xBXQYIh74/WCBgxcP64PIsCtdCLn4qxob8pdUqLu7vYKmyRSmt7+OBAFfBdxd61WHIFAK+bnSPHNFc117VfYEXzSy7MU+CPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KovDikER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KovDikER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BA91F000E9;
	Mon, 13 Jul 2026 23:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783984600;
	bh=VHFDmWFWYk+A6dlCWEz6qWbzVTZbqrq9J1f38ZHdzOo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=KovDikER6q6yj77PHYuf82sGy12rslWxxHvhyJ7IdhyIX/gW+MQ6Vwje/K5pIAsr1
	 y28B8KV0abad3w8RCvntJbUNBT5Ar6VQi4JhqSo/xVcZMqAJ2TUdj8FqrcEcT1WsH7
	 G8gQHHiO8TkKjFfvIUTDgzK2UKR2KbpjirstKlDYZW3ZCsZa7TZrChVuLT9GEphTpY
	 9S6AZeyAgmWPZ19RrGhAh6GHZJg6fNz50DiVQA5kvVAMgNX3XPjRFSzhTboXZJcl6H
	 r6nZ4JzbxJnxLEEvRXM1XJtPald6n6XE5XOiTMvRRbmOraVRwiaHUElAVXCIUrduom
	 tkhyarNV+9tUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B563924FA3;
	Mon, 13 Jul 2026 23:16:16 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.2-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <876d09cb8d47617d382a7e2af7a7fd6b@kernel.org>
References: <876d09cb8d47617d382a7e2af7a7fd6b@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <876d09cb8d47617d382a7e2af7a7fd6b@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.2-rc3-fixes
X-PR-Tracked-Commit-Id: 0e2f4ab68a89fad42e0f5a9ff4b740738e7aa1d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7574d3f906a963d7b70f01beff731ee0351d5c5
Message-Id: <178398457483.2881721.17658018427084030493.pr-tracker-bot@kernel.org>
Date: Mon, 13 Jul 2026 23:16:14 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 13 Jul 2026 11:29:05 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.2-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7574d3f906a963d7b70f01beff731ee0351d5c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
