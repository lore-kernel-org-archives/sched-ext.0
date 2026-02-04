Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98538945C;
	Wed,  4 Feb 2026 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770247521; cv=none; b=WP1rG3TVw0eaICQT/kcy1KsnEuw1NeMsbJs8KPNbcNREbVvcs7nMZ3DKE8Ok96troWapXqHdT1x/+zCdlwzVIR2J80RLevDnqrl0NlppTj52kfT0ykb0vhGMUfLW3VCiFI1q3/sMMUeIWSSPQFGsSjEyh3HwqTE0HJm6rx5kpkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770247521; c=relaxed/simple;
	bh=cqz4mX4LgMoWuEBGr4i93RE67OsItB5TE5WKo03QXUs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QmkOfuwTAQtXhE6HEC5/jkHNY1TWqTpoLh6e/KmIIZx4TodsiDLpLhSNr8j2o3SxmYP1PvO9j5B5gMBOjvjeE+y3XvNB/943wWC/pfodj3Mf0VG5R12nIeu61zl/IIwptAOlOpbmxZJPLn2UhHYgirGiZBiSKoSkMRomcMrGd2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgNzt4GW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgNzt4GW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02587C4CEF7;
	Wed,  4 Feb 2026 23:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770247521;
	bh=cqz4mX4LgMoWuEBGr4i93RE67OsItB5TE5WKo03QXUs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JgNzt4GWJziJgGkJNBfYhF41oIPEMH1dqGb9xR0rM59fhGQPPIVpU7J0jWo36Iy+8
	 A171yOie234WCDOzNPbDXQhrnyGNM/G3XeB8F4I00LQ9BwkMSejJ0JNWu1EXxwcej3
	 vGP0c+VqxGqgrrTJQzW24VMS3ga5LlGOFpQ+HetMzDb6C15Pouxe3EYYCh1S6EkrGJ
	 pN/rwuJmXVHbKqfRJ8TbyrbgE9e3HMH8kaDTC9NXrXeMRXESG///toXB6Yu7RvrL12
	 3EXKj9zQdnLsWqjJCkDPknwUcFqeSiwzu9HlAHTecX/j2NP6ZJYpMJQe48StvGg9+5
	 OekTK5XEapJHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4841C3808200;
	Wed,  4 Feb 2026 23:25:20 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fix for v6.19-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <403d62bc430249eb2904652103e4efa0@kernel.org>
References: <403d62bc430249eb2904652103e4efa0@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <403d62bc430249eb2904652103e4efa0@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.19-rc8-fixes
X-PR-Tracked-Commit-Id: 0eca95cba2b7bf7b7b4f2fa90734a85fcaa72782
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c7b4d1994f63d6fa3984d7d5ad06dbaad96f167
Message-Id: <177024751892.90305.4088842446822087897.pr-tracker-bot@kernel.org>
Date: Wed, 04 Feb 2026 23:25:18 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 04 Feb 2026 12:32:41 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.19-rc8-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c7b4d1994f63d6fa3984d7d5ad06dbaad96f167

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
