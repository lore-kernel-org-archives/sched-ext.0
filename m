Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705AF332919;
	Wed, 29 Apr 2026 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471263; cv=none; b=BOj2cw7xGGLfqlHCX/8hS488frHtC/6+njYvG+MJZUcjY9rDLtXjaBUbXs/ZOEWc7bjkRvbE3yj689+mSBokk7qsZl1NysnpObWfZC0gIEFxiGJlGRTjC9YOmH/scrhBA5OYqjydtFhJj7p40gQWM/N2GnAsnPP5CTUSaOAQYY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471263; c=relaxed/simple;
	bh=oaDYJA5e4DtyWxwkN9vQ8wqXdRFVjDXY34cLbQvinVk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=el/7PDD0Co3Kkf1x7Js2cgILdjB+vXERvcCe5te6TGVvV3aZwEKQmVTsatMrF/S/RjhAJYsgqn/u9CXWM2Xcq7zqaOEl5nh4MWYSdR23WoRElSeEDPGdEmYaCmnWgxq6m29eErQmTE+EsmMJiB4ymRoP+U+Sn3d+g4Y97J2JjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8hVi04G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8hVi04G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499E6C2BCC6;
	Wed, 29 Apr 2026 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777471263;
	bh=oaDYJA5e4DtyWxwkN9vQ8wqXdRFVjDXY34cLbQvinVk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q8hVi04GS3rTSIQghNYjF3munpcMSLsZ/Lc+abG+aXPFEnH3fwSNZVZ2GRabOCFTT
	 eUT3SZX0iYdrLqe1ewjpp3tekf6HGKOG0iCNjApKt1mHnPEot+k/61y8G3XkDYGQMw
	 +uFApkNFyAe0m2TftPRON/maT+g82HW9p2rjjoBrugiq0L8R9R6W4+/302PBh5GwlG
	 nN8Uw6pYifxJu0nfJ2v5tSKJQoReFu54gNg6YiR7xCcoA5Jd9+/pckMchOE5EmXNvr
	 CZ1z2g8HmwAdtP1uSHWmNQj385cbru4N0BQL5TmdQVYp6e6clbmmXCeYQ1xuM/lVSo
	 P2MeKVmg9OAXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4006839307A1;
	Wed, 29 Apr 2026 14:00:20 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <bb1b25a09c382529d9b9d9024b4721fa@kernel.org>
References: <bb1b25a09c382529d9b9d9024b4721fa@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bb1b25a09c382529d9b9d9024b4721fa@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1-rc1-fixes
X-PR-Tracked-Commit-Id: d99f7a32f09dccbe396187370ec1a74a31b73d7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 664f0f6be37ce4ef80992cf2ed74761cd5bbe207
Message-Id: <177747121918.1980932.5617721851760888575.pr-tracker-bot@kernel.org>
Date: Wed, 29 Apr 2026 14:00:19 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 28 Apr 2026 09:55:15 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/664f0f6be37ce4ef80992cf2ed74761cd5bbe207

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
