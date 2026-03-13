Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3A38644E;
	Fri, 13 Mar 2026 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440119; cv=none; b=Fmf6iojOs7lSD9fG9DVVUchWUFsF3UBjJPftenn2nHNdMGhSqtOYHy9XnoBDOIulwScu68+Jcs6KKtnpxnfQi/LV4W6LdpUtw9H6s0VRiSnYOwoWD/aUXoWVk1xPW2QPiwRbwYHnR7DGEPIeYyi/2HdP9O67FeNkfjNjxrKnzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440119; c=relaxed/simple;
	bh=FUml2dYt3mHJuR4iLNEQ7n3ENfytM4UsIEObrP1qvMg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AQjJUMawawYGTPVRKgumrlphUxvBYhrzliNDglQF0sAV9ttGeA3BxJn1MTAauRUmtSteanndUw+oku+MjQ18vBYViWLEcY3zXnfi4k/gfFhgLcPizWClfQPcHRo+vccLeiiOdZPilF6uJo8WHfGe/LTn7v9H+5/AbpgN6GvvNXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhHNVGIV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhHNVGIV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174CBC19421;
	Fri, 13 Mar 2026 22:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773440119;
	bh=FUml2dYt3mHJuR4iLNEQ7n3ENfytM4UsIEObrP1qvMg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dhHNVGIVRXLk8x2xyLKV0a1HXlGsGiQs2mDK1B+kM7yjlIMshtf7Uv0A36RVNvhO6
	 GjhbhP2rcBykvR0moUcpjnW6idqCZjZ3GSPOtocEEYAxg8tkojadozA+vg1obznSOv
	 pt2uBUMDng0mDTBvRjZMtSuMfJqwJpjQwS8hTWOToaI20H57/pflTfO8cFmDm/hQI8
	 Cw2ixhiwv6pprP8Et9daAAyziI7wpr8t69QPssU5RH58N1UMcEFrHSJbzq6OQo2r3k
	 tM6Ua0ukEjywe9av85dnqhi4TcyV1xorHS3/3Hing5RoY9UBrlBC60ULzA4BX49Z3W
	 WmUkCXPp2rlEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02FE83808200;
	Fri, 13 Mar 2026 22:15:15 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.0-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <00374b06f5f22a6c7af1edd5652bcc60@kernel.org>
References: <00374b06f5f22a6c7af1edd5652bcc60@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <00374b06f5f22a6c7af1edd5652bcc60@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.0-rc3-fixes
X-PR-Tracked-Commit-Id: 2fcfe5951eb2e8440fc5e1dd6ea977336ff83a1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8369b2e97d806537dcdba1d6b3bb46fb1407dab0
Message-Id: <177344011348.1522840.11413840088812152262.pr-tracker-bot@kernel.org>
Date: Fri, 13 Mar 2026 22:15:13 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 13 Mar 2026 10:28:37 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.0-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8369b2e97d806537dcdba1d6b3bb46fb1407dab0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
