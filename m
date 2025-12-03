Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C90322A15;
	Wed,  3 Dec 2025 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798796; cv=none; b=J6qreBo2/lSbZvpSi62B99QP63KO8AxJPNrhKj0N9AgZWMApQ8wzaC0k/l/dsG9CmEzo5r7RtmCYdaxesE5cfVoKxMOlXu2FVzriA6mKmafTEjThsJdq/6zB8kmKyI09UH/UWgc8jSAtxeoNDOXS8OnJpvujVDjxMHSrI4qynao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798796; c=relaxed/simple;
	bh=8e8S27K5PFGsx69nKV/PM5gbRwleIj7avQUf1X7JUv0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=e1+IBXXRArX3hIx/c36K/403S9HTbT51PjWIGel8GVUBt4KEzIwpDn+LQtY6NfEHJ/f6GARZ5/G7F813gqxp0RX53PnOkx++aU2/0mmUVOgM00oR8zNBBA114Fls3STZmdO7tLTn2hbB0e6B84i/wzBAt/3bjaq3BzdjYnSrJLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyQv+bm7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyQv+bm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39688C116B1;
	Wed,  3 Dec 2025 21:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764798796;
	bh=8e8S27K5PFGsx69nKV/PM5gbRwleIj7avQUf1X7JUv0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HyQv+bm7RXMa3JIMwoO9SzgYmxgFRJ+HVektEBh4FztScwtDdY5Pj1WFMHQF3H+Oc
	 /Dh2BmYx65FCDCwNYNFjluWFZLI8YevM9cK+uKomI6A8eQcrsrK5Kt3i5x+cmjWbuq
	 0n6GIto5YRvSHaIXmBTL+caJ85B9lLsUis8Rpk3t6fouNOyxgQ34+JOnEuNsJFtMfk
	 zpn66wq/USo28sL1Rsp5KWzcGoLcqXH18t6lJJo5PCggqTgqX1wnzhKdE5Vt4Im6Bn
	 /CblEMcJ4zpRdyvYiCK3mfaNJN+jJrX58B3p4W0nCoBCuuXxB+B+2GiOpcQr/R5UPk
	 wAO3Ps6SgB/Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B9CE3AA9A81;
	Wed,  3 Dec 2025 21:50:16 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Changes for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <ca8ceefd49d27fa71aed4859c0037b2f@kernel.org>
References: <ca8ceefd49d27fa71aed4859c0037b2f@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ca8ceefd49d27fa71aed4859c0037b2f@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.19
X-PR-Tracked-Commit-Id: 1dd6c84f1c544e552848a8968599220bd464e338
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02baaa67d9afc2e56c6e1ac6a1fb1f1dd2be366f
Message-Id: <176479861511.93177.8818252305163012789.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 21:50:15 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <multics69@gmail.com>, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 01 Dec 2025 13:48:47 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02baaa67d9afc2e56c6e1ac6a1fb1f1dd2be366f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
