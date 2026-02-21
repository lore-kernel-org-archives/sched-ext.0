Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C67263B;
	Sat, 21 Feb 2026 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771698702; cv=none; b=QeNnrALtpCM7/UNm1J9VRAeAcrtchFUTFomSTj3PEh8DufvKYpwBZkFFmDegFhjAFm3Vp/2zW1y5R/61Ll68edAYQ91mcsAli2AiCZspcVIpvp/gxFSUKuLTuDlViOipGib6zv62VaU/RjQZf9XYeZ56rHCzbQb6B7DN/pQwBno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771698702; c=relaxed/simple;
	bh=0MI99ZncowtlkE9yqsE3dGFQ+49cCZrXKgdZPUGtmVg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jsWKafYTdLEgaJ7+MGP9eX285SnKMYJNoP1TXm1scXnVyS3Ftyo/qKA7xNzb556/5S9oORRtjh1VTWeXlMWwiN8B8CZGt7XE6oUQ979pKr9wR9ZckyqR7g2Cs7IIVNMdm+t/rrFOrANHsslH4CPOcry64O2tNj7Xgjga14Lk+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coz1SQiU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coz1SQiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99995C4CEF7;
	Sat, 21 Feb 2026 18:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771698701;
	bh=0MI99ZncowtlkE9yqsE3dGFQ+49cCZrXKgdZPUGtmVg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=coz1SQiUVBXT+1uWIftiYRRO+xkV7TvR8fxbblVdYihqRnSmM/jubzMznE4RbnZN4
	 06dLmJdrWI1hfPP1ALaPB2Z8BXg72qUDrx4HzUmgh5zyMtIawmK12zWbmlWXCNluc3
	 fd4ieG2zeoQzIhvYHh2A9y+Pcz+2h4TkfRZ13ukV5LmjQf8RTHV4VcM6nS1QMTSB/J
	 Yz1ArKw4JwGXFX+848k/6ZTGWQFSWlmpuSrbW5F/KY02MF18Rq15DaGwns7Vj3qAHu
	 LzyFBd4qF54N3EMUo+0VWvqvkwsebv2B4et3gKK0WUBdvZpLfIgK4wifwL9586UQ2N
	 r24kQ1sRRJB2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEAF3808200;
	Sat, 21 Feb 2026 18:31:50 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <bac5659887fbca95e7159ffb94ec2e43@kernel.org>
References: <bac5659887fbca95e7159ffb94ec2e43@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bac5659887fbca95e7159ffb94ec2e43@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.0-fixes
X-PR-Tracked-Commit-Id: 640c9dc72f21f325700a4b0f839ad568ff21c697
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cf44657887b4c41374981d0afb2ca302b189e15
Message-Id: <177169870885.1180555.16329822958692857228.pr-tracker-bot@kernel.org>
Date: Sat, 21 Feb 2026 18:31:48 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 20 Feb 2026 17:41:47 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.0-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cf44657887b4c41374981d0afb2ca302b189e15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
