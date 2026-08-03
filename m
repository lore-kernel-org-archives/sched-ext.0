Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3220D4334A6;
	Mon,  3 Aug 2026 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782613; cv=none; b=XwMHNAswrlEZYMLGhri0jejXqhO9hd3pgSSjM/NAFA3fgThVJQCWfrYNITs1yb56FsQGauh9U758HfVH8RXWjUnN5AuSiSLwMzlgcnbJbxcx2oKxp45KyuX6TaKY2CsM0Mz+Ryo+rtQsYw1vJgSIAuuJ3AUsQZag7IGp+rHoC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782613; c=relaxed/simple;
	bh=qU5SxcuHBW8ZuYtGrCs5535YibT5CLGOKOpMnHnJUlk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LYWZEB2B+eErxGVFrAEk6rJFl5ZSZMUbR3/1wf8Eo2i/HjM5E2FPWDBowAwf9crwhuz/XGm3jzJ22BHtO5j9cfqgEAoHpdGLbdbDIB+ouAR7MVHRlPz+uqEInv1YXdgDniYaLm2tG4Nd3DIJWwY2mpRYt5AegoYgneJ/2dalgPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1JoEfNb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1JoEfNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103B61F000E9;
	Mon,  3 Aug 2026 18:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785782612;
	bh=whUyqVYvQGI8kbEG79q8nONoJEcJD6qBgRNjiOlluTk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=j1JoEfNb5SzMfBG/wU7y5AY7cPZBl2THihyHt8klxvF2+Qe9UZ7dhKwxR5YgiUzEj
	 P48rkRrZ2koolur0H9K5y+rSWgolk0NZMEqHSFH9Sm6p7ITTcWrT/bpjdmC6+PnJPT
	 F5UKbSxSQkdw82D2lMZahPrlGx44IRem9NjDgAcDhha+TlDiybjj9cangTrfBZATFn
	 wgiUUV2ru3O4BV9to2XuJ4t+E0gUiC0qNmEPFwhrCQ4CQAn+RcaDmih2LAa4J5yvr7
	 QtuLsJQh4y/H2imC3jHPqbx0luZABZKUYtP3E6fX4yISVefab94h5TnnyaxeQUxUj9
	 oOCW6fSaxEAZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569B03924441;
	Mon,  3 Aug 2026 18:42:54 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.2-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <73f632a36560eddd78a0b82db78e4b8d@kernel.org>
References: <73f632a36560eddd78a0b82db78e4b8d@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <73f632a36560eddd78a0b82db78e4b8d@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.2-rc6-fixes
X-PR-Tracked-Commit-Id: d4a00d61a5c2c24973175ace5368d1f6acf9bb0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be76b516e681e5a620877bd3d0e1251b2ab38366
Message-Id: <178578257290.2780879.7865900681859315974.pr-tracker-bot@kernel.org>
Date: Mon, 03 Aug 2026 18:42:52 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Sun, 02 Aug 2026 15:13:26 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.2-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be76b516e681e5a620877bd3d0e1251b2ab38366

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
