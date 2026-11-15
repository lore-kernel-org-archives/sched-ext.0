Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794781776;
	b=meUi2LGpvjkQh6AHA0hTeWw0vNuOMQZrNcasT0SRdD8Nbf23AcE+azCg8vsseyD6+G19
	 ccuEAo0CNqPbNvVTjfnulfcurYPTZByLFshs6ZwiYZ4ItATS2XP5uLmIDGDVOEOyiSelz
	 evKPvgsKyOk0jwHsivrrdCSqHqJNkQMx8Y2Nv9u/fS3dgReyQKJQi54DaDTS+4yUjKMy2
	 NaYBkgf/U3hvpVwucDUkR7qw6NJFiSY+0WizF7bQxYKTei9PK5gDSRcv5mKg3xcJb+uMN
	 cTtRzJCZwaKz/KF9Qw0P23/VBOeleF8l6/wwaclxuXmj2GgiYAO65wUCzlBTxfpC/4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794781776;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=4STuKhboQjKCcypecXg8HTKSkBi01+7jPO7avP0YGiA=;
	b=S8UrG5CG51aWT13PVChPFSS63hHgHQhoyD9aWTf5IkjzFAO0MtEmX4yjX6t1xQbn74Rq
	 0J0zHUpnbckdN6FedeYmAF+OvwHBnHAS3I4zXGqsQcwbHvExtU/Ly6drY8RlgLqfG5oXD
	 3Ird9vh1r+0e3toPUD14NWxI+VaehUK71Tiw7Ec6+D3hfvMPGrpc3KT+MBk5I06HpCAfa
	 fbox8n+115FhlT1bRaQJCiU1BuCEZ6LIMeUXHU3jtw/yz84bYOsImi8fSed066mKPD5CL
	 OqmIGicB61dDr1BPmMuCU7BiXQ6hdp/n1cd69kcIqcq8/MwNC39X5H7JO9NrUF+DiYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghCWo0Y7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA98606A329;
	Sun, 15 Nov 2026 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghCWo0Y7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D391F000C5;
	Sun, 15 Nov 2026 22:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794781776;
	bh=4STuKhboQjKCcypecXg8HTKSkBi01+7jPO7avP0YGiA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ghCWo0Y7FCqM6Q6IdKltzxTcqdWL3yENwyY+BnUVN11a6s/A1mh5bPLdHLhP5KSqS
	 OYC6LQps+lFxEE/gF8V+qLRB34CYxZ+3dMpb2RfRVfdNUJWG6yypnV5B+HFy4zRDko
	 orKwzvs1RzPxLGE6pneZcaOLbpoQsg5rcIPLDo7OH5709wvWn9xVXPcsmYsgqPTeZe
	 GM37zvLnON8I7W2pJ0GKialOqz14jTJ7iKIfcz1zXsXHCyVJEmAVYY/YTVAjGoH4Rp
	 at7xLuQ/LR5iXNosBz3wutU2kOBgu8U91+W5bg6NVITLtSZYk27+80rp1OX44CmN20
	 HjVq70BmW7v+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A276380823F;
	Sun, 15 Nov 2026 22:29:36 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.4-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ac8a34b2fcba5a00d2f779a0bcf71592@kernel.org>
References: <ac8a34b2fcba5a00d2f779a0bcf71592@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ac8a34b2fcba5a00d2f779a0bcf71592@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.4-rc2-fixes
X-PR-Tracked-Commit-Id: 700a332c3fe33014bbd5ae852d71ba679fc29e0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9daf327f3ff90625204876981f88cfe2b6f6fff
Message-Id: <179478177479.2784423.4617383340755581980.pr-tracker-bot@kernel.org>
Date: Sun, 15 Nov 2026 22:29:34 +0000
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

The pull request you sent on Sun, 15 Nov 2026 10:50:56 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.4-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9daf327f3ff90625204876981f88cfe2b6f6fff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
