Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6D3085CC;
	Wed, 18 Jun 2025 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282304; cv=none; b=YRRpVhUzNB/59n08wnd/4+9qEE/vGAkLcpRoZ8ae4e0bez5WiiGLNrzFNcXmQtb2fJDLnRPR0HXVTFxRoBGeCqfWDgRjZ4pLsAYy1V8+Cn3xQ7RChEOLc1xG97Ya3m2qXWONcSTMcAeStItsGY+kWsfKx/aIrrso5z/22pqmLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282304; c=relaxed/simple;
	bh=XqLhxZFrqRlTWBCzHPi0YMtbDLLzxhvLi9pTnryX3TA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PJlEYUDOj7+OsGO8LVbUa1k/aq5b8AoMrNBk0VnXt6GYds4BRnMPlvOvMTgUNK0Gof11siQSFFcGtcvGFJyn+9V3R30UWsqFAFNtAidDHl2pjOCzJTo7tfIjNTm3/pTRyvP7zFwRZGg50ZdchD9EeaajYccg8ui5Ncplil0JVA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9aTnG11; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9aTnG11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1A2C4CEE7;
	Wed, 18 Jun 2025 21:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750282304;
	bh=XqLhxZFrqRlTWBCzHPi0YMtbDLLzxhvLi9pTnryX3TA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i9aTnG11//C1k6cEvyDs0Sj5TzyoPEYUAEWP4w9IMza7ui5cALMfb32UDCUcZFtQV
	 3PYgTFsnqOFC8IMg29F0pGVz+5c+HBR5yV2hYSuq1X1yKQ6yyyxX6PuTiW2Hy32RPg
	 qRcWnM2Pxm9Y+D8wdbvVV2Bhul4cBE3TRnRJbQ9avwr0tmotASmhvEqEbZHJeEeIfi
	 KujLXByIRGK4LsIQDUd+09Wrh+LwN/qBM53vcwQkBR9uvBVGqxX+lXETeSHmnBX58r
	 jy77TPS5cQIUmSVth/e8wPTK7DVj7jCkyd7FAe9yj6oWJB2Fzjv6MjyEOUCWn3yBP5
	 qEgojQ3gQEIwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2553806649;
	Wed, 18 Jun 2025 21:32:13 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.16-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aFMeWOF5bCp2D3s9@slm.duckdns.org>
References: <aFMeWOF5bCp2D3s9@slm.duckdns.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <aFMeWOF5bCp2D3s9@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.16-rc2-fixes
X-PR-Tracked-Commit-Id: 33796b91871ad4010c8188372dd1faf97cf0f1c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f24bfcc398eb77aa41fe1bb1621d8c2cca5368d
Message-Id: <175028233216.264355.2050505514849310884.pr-tracker-bot@kernel.org>
Date: Wed, 18 Jun 2025 21:32:12 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 18 Jun 2025 10:15:20 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.16-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f24bfcc398eb77aa41fe1bb1621d8c2cca5368d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
