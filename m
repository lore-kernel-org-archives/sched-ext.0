Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649517;
	b=3xkcvh2usaBKL8HcKYL04l3VhqH7+gQDyzpVyVIJcGdY+oLtWYIYNa6arMe3RQnZ/EDv
	 V34CfR9qdWTOZyzbdudeugZumhpS+lInbsW2TVRvFhi3wgOWqfAzNL3yLl+J9Xg0wmg2w
	 Ma09wMzt6SwImGXKSun65a1CYag7nG+J9h3+XTGrO8/lfIEls30O/5QDn7atzQh7W8JUO
	 jo0S01jBDOyTdNVf8Wrt956DwEm3+NWZlXGgenr7HQa15soGTRPDFJoP9pi4LumGte7lz
	 /j4gfjiLz81n0w8bugfwqGMOt72GBIGic7UBd8lC8hgRLMwNV4sslWfm4TNWuEzVxCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649517;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=lbLulWd2YFQjYonrpLoUkwb89dPZXV414rmkt0fSzjk=;
	b=hC7DE02CtF6MR3Cejofrx3y5rHN98pmGQeTAruizbJIxiLTxyAXcWiF+DJwGEzkO4b44
	 I+1l3dqiWdg5Jiiu0J5mKH6PGhg3m+8NdsZ5CmN0FKI3L4hkWwq5mxD9JUeWbkkzEAoVO
	 vmACxij+u0memokwcgNL0SeT5VNzkvp2lirSGCpsrV1cqXtHgp5nddsnczTrANS9xQ/+U
	 fSDIz+awT+6kfWvu3Wtdr9azVOm7f+XYjzX76Sydu3OExnHf+0otmghpGJEdeeVixyy+a
	 9JeRGvipildmg4E8QQUe31wWqyp424+vBoT8IrsDfV+p1yxkJHuY3D/OuoyuujJwyKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pjvn+cuw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AE1606A6BA;
	Wed, 25 Nov 2026 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pjvn+cuw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BF51F0156E;
	Wed, 25 Nov 2026 23:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795649516;
	bh=lbLulWd2YFQjYonrpLoUkwb89dPZXV414rmkt0fSzjk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Pjvn+cuwlbJ65i/QwWkHYtfca3GRu77fc/PP9iCQ9ZmH2fGFTdAldL8xMyFnTo0zC
	 V7KnrBjJTK6S8nnFujBA1fNxHDPZ5xSb4mb6SNln6+HLx+Mk7tOMpX30Qjv4x5zLbD
	 QdKnfDqRxfierRGGampMcpz+39lI4xDTHej/Z25eg/vYV+QT97IuqH+5PM8AOZ0ssX
	 5qEb/scUdppUvzsaa2KVCDRakoIn99vhZAXts9sN3muV0LwaIcqLSEry+Lf0geio0l
	 ZMOCybJOJeeqFVfJSgo68UjYcZV9gbpjYhBIX9pZ89W2cg/gokTSYcRu25zjbhMUQO
	 LMCBv6WT2oIrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C49413809A24;
	Wed, 25 Nov 2026 23:31:56 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <64abac4b00009285ade1874468a34990@kernel.org>
References: <64abac4b00009285ade1874468a34990@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <64abac4b00009285ade1874468a34990@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.4-rc4-fixes
X-PR-Tracked-Commit-Id: 97e1c7d467d07734f8f5c8c64730e1f7c415bd46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f441d24349a3fb7f0b0f8f76f05686e448fd0b10
Message-Id: <179564951559.1391833.17447441742356594698.pr-tracker-bot@kernel.org>
Date: Wed, 25 Nov 2026 23:31:55 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

The pull request you sent on Tue, 24 Nov 2026 23:40:42 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.4-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f441d24349a3fb7f0b0f8f76f05686e448fd0b10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
