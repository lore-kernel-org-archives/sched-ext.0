Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D392829B8FE;
	Mon, 17 Nov 2025 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401965; cv=none; b=dkPTQSFBZDBJfHt8bOT49L1HSl2wV/9VsZKt2EjEqUM5VFZbc/4npXceESD4U3M4aJYgn3ZCbtUm6+B7dB8aV38X3deloLyGScRNeCPUdSqRBuFvVStGXN78H/K6yaUMttvxrUJ9jpVyB04vmwx4cOMOufoqrRgBogUq/mKGDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401965; c=relaxed/simple;
	bh=6WOJvPDWoVJrAcSo1+IeEpQSqaG5pBXip2M+im7GbWM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=f5r4ydSHd2QRY9eEIJvaWRsdvdK/qpBI5EmKiskFGKBhfWm2zA85L9hosL1LcdI57tFrCoAtkKyxQBq9/n9a+p2vZM2TZzYFFSDuaqm5Rpn/wpR4/S2Kz6UeuA07fjAGAbcaPupUHVnfqRRwocMZPAqz6VgJxNrczUXWqRGhcsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFDRkV6o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFDRkV6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36D9C4CEF1;
	Mon, 17 Nov 2025 17:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763401965;
	bh=6WOJvPDWoVJrAcSo1+IeEpQSqaG5pBXip2M+im7GbWM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JFDRkV6o/sGJGUIOldssUyUD+ZcXvQSWtfNAfd4JLyxwCY3PIQJu7dBJsTLLGgvxn
	 s/Cp0MrTV3uWfI/Q/ku2MC5OQiOFsrDn6iCqbvllyZqmk0ogJsAJZtcSDAbWd6Ed2n
	 FHYKBw5U6Sx/YWJtktIJzr7akp67CXD+6rhGBZWGDiP1Oz9noAWxnTsa4Xrordzbsl
	 hQF4uQ6u4GA5L19IFxLSkd9s4dCrjdqGf+qeeIfw4ITbJ5OamkVjtKKmeX+klkUx2x
	 yEszhaAoS40RLfdNbZJYa9fTDw6ZuPjYAR8sNlIGB8qxPI/KMVsCK3DIlzQ+EQPTmF
	 rkzjHrwCZVbLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C263809A06;
	Mon, 17 Nov 2025 17:52:12 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext fixes for v6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <82773efeb786fdc3c392d9fbeedf336c@kernel.org>
References: <82773efeb786fdc3c392d9fbeedf336c@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <82773efeb786fdc3c392d9fbeedf336c@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.18-rc6-fixes
X-PR-Tracked-Commit-Id: 36c6f3c03d104faf1aa90922f2310549c175420f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 418592a04021baf5fcfbd0b7b7c5330bb135d10f
Message-Id: <176340193085.3421417.7042994867259904317.pr-tracker-bot@kernel.org>
Date: Mon, 17 Nov 2025 17:52:10 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 17 Nov 2025 05:32:37 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.18-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/418592a04021baf5fcfbd0b7b7c5330bb135d10f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
