Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E247F3195FB;
	Mon, 22 Sep 2025 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758568304; cv=none; b=sxfxKfdVCxajmQS988kQQu1sE3D8lnmW2A4N4E4CnXht2KYA09fI2W6dS13qKWWWNCnDk3eoK1vMDw6WeKaP4MJDdDvMcuHXEwtf71pFu4hfiOM1jEW0I0EX5hH5be+cH0KKjxdBpQ/9D//zkYmrVoe7fNzpJf6lzGrDezLAm8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758568304; c=relaxed/simple;
	bh=aRgAyc29KKpOlgRAB0KQvtRJwFmjh9zsnOE4jPM+Wa4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=V7vRK0TQwjz9H3ocdKJf5nGqsGcu3Rf6McrhODZrXOIbMG1FmJyKHyBJ/6lcnjsixB2m1vXTUZh4jnAth/4isDVb05Sk43fPTMAwNJL3qMJHMYe+brYNQXHmyKbOg4m1xnLBJEbefMN4QUI5w+7+w0EkmmXdDmFQ0UXPmLsG3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJC1DdoR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJC1DdoR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63729C4CEF0;
	Mon, 22 Sep 2025 19:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758568303;
	bh=aRgAyc29KKpOlgRAB0KQvtRJwFmjh9zsnOE4jPM+Wa4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gJC1DdoRaMljejnn592sCGoThdmjWrDyH40LPUzhl+hwIMFt0yR/5THlEbKAzjtKk
	 xjEefy9Q18qz7JGCVGHZDEORJwpsa2NeMZE3HEg+FNeo+ScX93BUDZlMEJSQ9F1fb4
	 hTLsZWuWG35JGq3FiP6q/UZsRBcJRz+HoAqXOSeVdcpI8HsOc/obqNb7aUAYWM0Utz
	 xZ/mdzFAcyaV99R1zAigKmSEkz8fF5laQM46MSEtZ9/+OEn7jN/n9zE22HtGei6dEy
	 FIPeioJy9J2tokpRayFr+YvNnKMCApBffi2GGWVciT0GGCEQ8qru+GF0lDsiyZ1Y9d
	 7gDZEzPzmD9Mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342B139D0C20;
	Mon, 22 Sep 2025 19:11:42 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <aNF-Mqjnu_phEgvP@slm.duckdns.org>
References: <aNF-Mqjnu_phEgvP@slm.duckdns.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <aNF-Mqjnu_phEgvP@slm.duckdns.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.17-rc7-fixes
X-PR-Tracked-Commit-Id: 55ed11b181c43d81ce03b50209e4e7c4a14ba099
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
Message-Id: <175856830093.1126778.2288432170377233486.pr-tracker-bot@kernel.org>
Date: Mon, 22 Sep 2025 19:11:40 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 22 Sep 2025 06:49:54 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.17-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cec1e6e5d1ab33403b809f79cd20d6aff124ccfe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
