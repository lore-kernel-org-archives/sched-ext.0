Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15403264C2;
	Tue,  5 May 2026 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025407; cv=none; b=Y+84zvnUzjpwf8lD+lBYxTaBJJycrtj0OC3+27sGcUc67DiPsl+gRdXndwLbjJpj49CZXkAHAiLwY68ytXbX7cYAboZmR1mCW6nUHLZxe6Ei4vedG4TasLm+spjUQ4wSLX20aR8jAwZa9TF44O/a8D2oJt9n6moGUObEbCcF8EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025407; c=relaxed/simple;
	bh=gkK6Xg4BmiUIW3jdq3vhFZC+PEAFpLXH5wxQvlsqTTU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d+Reu980NHocharWewWGIHF4vRjHnxxDdlzAVvghM47JxM7bvlRsoFz116RAnDhdbw3dFK/wVgNNA782dHtOsXTpCnru9Ewg+9GXX+JmJjj4nRRjXItYoom7nEasKaImyp2FpYu5LuzNVmggC62WSfn3E8tnMo4NXLwKXGayLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYQ08YyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYQ08YyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCC4C2BCB9;
	Tue,  5 May 2026 23:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778025407;
	bh=gkK6Xg4BmiUIW3jdq3vhFZC+PEAFpLXH5wxQvlsqTTU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aYQ08YyPLLsL1WzO0S4n5qoJePzotd8m3bXKSHD8qgVStEN3ayCpXtJ+tC2yPxCxw
	 cPhOpNoxRCIVz2f94ZqHfE6NJ6fmMcensX4yb0yHW+KAOnz6BuUBOGDGdi39o5U22N
	 +PNNt1MKKKRm4JviRPRnEYKg1GOlzaY1cGTdacwoXtgxD4g+lT5FPU4IN7s3UlNZrY
	 A3Ls0wICmc9H8VTrMN1nkxhrOP8m7yvoI/+RvdV/IBJOwuxQi9GtBGliWkwFGYdxpE
	 1LTJOHKzG06yZEqeITQGEJePGDb+I2FY1d3rypooqxGQ8K7vRjN2vM1TGbts6AVj98
	 WFmysIXacZM7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E9C39302FF;
	Tue,  5 May 2026 23:55:59 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.1-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <0b691f25de6be993a3496962f91fa212@kernel.org>
References: <0b691f25de6be993a3496962f91fa212@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <0b691f25de6be993a3496962f91fa212@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1-rc2-fixes
X-PR-Tracked-Commit-Id: b34c82777a2c0648ee053595f4b290fd5249b093
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de95ad90fb19e4b7778a0c27115a4639c7c8b186
Message-Id: <177802535742.2314843.5374052555430255320.pr-tracker-bot@kernel.org>
Date: Tue, 05 May 2026 23:55:57 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 05 May 2026 12:05:36 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de95ad90fb19e4b7778a0c27115a4639c7c8b186

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
