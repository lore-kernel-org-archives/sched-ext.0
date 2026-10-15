Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987603B8D75;
	Thu, 15 Oct 2026 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077404; cv=none; b=IhdMp7PaSB04GO8w2khpCcuUlAEJqJ+vAuJ1MIUy5Fy6QHqF9QLkl4R3nvaAyTnxyUDbO41Rf+LWCtnmqKs3BpexB8xnutzO+bCAJiZmur3wkbNiyp5krDEj/lY1u/SevitMoVrNNf8OeBQttf38ax+701/KSVIinyyoQcZUHxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077404; c=relaxed/simple;
	bh=Y3w17E2j02ViAn14mfeLSsbvXE5SOKi+tr/gp9Evi+I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qkvodKHjW5F7ai6/Hv283h/ySzOZ0K3nzGKbT9SyuRBwxLe4AoSYSMm8AGYvH7q43gY60d5+JHAne8ba9leiviuFK58NHeEekHksKslwwZSAzlSstuwDnmmCfzJnPERaw6pgxiANNVF52RJl8fyGAqv426WvQBo+aj0cQiXYSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkSBvzXr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkSBvzXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800121F000C5;
	Thu, 15 Oct 2026 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077403;
	bh=yJ6UeAPgIg8aBgdmQ/r24D06S15o4WOyakYIafAENUg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=JkSBvzXrhnBif8S0LDSuY/xGt/+V0FCaD8eCZ2wn1Mo9fFmCUhep1Jv4BEnoNurhS
	 RMmDDQull8VV+3tmoA+hHgLgF74iuamRpzX++dKhcm07BPoWAw+kx9uGLQM1F+l8Z4
	 0HijjGJ8FwHtHpY3OyMxCVIJlemodhgmxNZ+limnb3kdZaL1795ZKgBTOVV2/zbYTG
	 EqN/kxWzovsPkyCYbZkY1CTbufsXJR4sLcsRs5W4rCSH3uLp3l6YelXKypKjdFhcsx
	 +1+HRI8Guq1p6qln8T8UCMTWe30WRfCUj3pXiKBfWdtc1+2olSnxWE6fRD8Fi1Rktr
	 eu52yH4puEl9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77664392EB21;
	Thu, 15 Oct 2026 15:16:43 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <3d82bc8d063a217f2d6583d285feca4b@kernel.org>
References: <3d82bc8d063a217f2d6583d285feca4b@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <3d82bc8d063a217f2d6583d285feca4b@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc7-fixes
X-PR-Tracked-Commit-Id: 2935062be77113c1c4565ca9d0c72180449aafee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db7afcbf9eef65aa8bfe6edb5ff4b4a92d1a4792
Message-Id: <179207740215.3496071.9985947087057023494.pr-tracker-bot@kernel.org>
Date: Thu, 15 Oct 2026 15:16:42 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 14 Oct 2026 12:33:13 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db7afcbf9eef65aa8bfe6edb5ff4b4a92d1a4792

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
