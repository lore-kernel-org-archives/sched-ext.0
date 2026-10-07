Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539E2820AC;
	Wed,  7 Oct 2026 00:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791333920; cv=none; b=gr2LuzfQPpOpP75otKJlodRXKAhqdA5waLVPnkWFpdtKPoBDbNRFkaoV/fydtHqSosZgapCP2rRv587wtJ1opzalK2hbyKB03t18OIXnuwpemloHMsy0CLD9hhrwaU7LmHH+lut5bV5LTmNcj8jO5dMqdw56c2cm9TEvqFxGieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791333920; c=relaxed/simple;
	bh=scfZFZznoRWdtCblr35Ytx1stq1iTEHE+R21DXFeqC4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HcguX3uxFgnkLFrGF2e5HVFvyTvCKGsq7uFb1wzw3LQb7id6hngxlf7vwQxKkTq+k/TAhf3PCYZYvLkaCqU/uRIV2l8zgpd7A8+yAoqfBxeBLvsLR6DvApZpmhH3KYBRkpX1cKeN7SAhM7q8WRpMYO4YfMV4flaPKrUoa7fNaB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcSMq9Sv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcSMq9Sv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D129C1F0089B;
	Wed,  7 Oct 2026 00:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791333918;
	bh=tCCrqeICFJnRt/QtW+rz1U0qOvlMVhbNKCr2oJDIVwo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=OcSMq9SvO+BqM/cQYEZ5tkBr3agu6yh2g3KHf0R4K9zSmQ6z0uJYL917vcD2jbhjL
	 jqa3XMKBrIQFyFMzLRpIGn6CJJqkVujItfHh81pECqNKNlp2kqyaV6aS2PSU8k+C6S
	 O8qAmnXvDSFsEQMQ0nUP6MZmzZNb1ZyD1Ck4j8YriORXqLbs8QJAKnQQmLstATMRm8
	 wyv+GY27kblVRDvZ7Q6XXpRfw+RtB9w0UJbQHQ/SIFDBBiG52GGc5qcnewSpkVS2kZ
	 RyQ2TtJf66LUE5iS8vPzQen8K0qW6VTOnLnVQV4osxbMRO0xlo4nA5tfl4t6i6gOi4
	 xHO/lo0SjKuXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B49753806541;
	Wed,  7 Oct 2026 00:45:18 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.3-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <afa1dcf110d0a6c081e1232c6ae2c989@kernel.org>
References: <afa1dcf110d0a6c081e1232c6ae2c989@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <afa1dcf110d0a6c081e1232c6ae2c989@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc6-fixes
X-PR-Tracked-Commit-Id: e6ac89b8b1c12e9104df45a14a26e2dfa96ded06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 762122d75e50e4919ef77afc2dffdc4931c5be87
Message-Id: <179133391720.2846339.7131187262623409143.pr-tracker-bot@kernel.org>
Date: Wed, 07 Oct 2026 00:45:17 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 06 Oct 2026 07:35:47 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/762122d75e50e4919ef77afc2dffdc4931c5be87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
