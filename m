Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8234BA33;
	Wed, 17 Sep 2025 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141175; cv=none; b=Chu2yHC4p49WBfrD2UyESIdx2anrCm0XVC0jJG2WOh6wGvs4g45Jmz6umffwBmSDoHvIpiZa2rFBHhvbFJRQYmxlyo3N3tKdeMNUDGqY0AN3tQbd9QH1crGffdjfNTQR08VB3WY/sBqEqcNTlfUZyLzd25u3aJdywPU0SdTFNEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141175; c=relaxed/simple;
	bh=7dkQ0MXvrehDY8SyWwsj+uuEY5sOcrIXtvipFIaBpRs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qW73kvw2OAqqn/fh0z93/3bWf7sV7nWIJ+RC/BQ88opQFvWZR2Gmpl3kg9eBKkfXqdyq7bdpzcT/bgXBMzn6V4rpjth2H4wsO4tjL+9btSIjrSjKvpqqJWNukhiemPSasp2n+2khE6Sb6e1CH6zRUC2SoXab9z9GHkBMoyMVfxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJVVsJDM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJVVsJDM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9734C4CEE7;
	Wed, 17 Sep 2025 20:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758141174;
	bh=7dkQ0MXvrehDY8SyWwsj+uuEY5sOcrIXtvipFIaBpRs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MJVVsJDM3tsh8qKJyvL5JsA3KCBIxHPPKbJcwAbQ9px9/9oOdp00fsNHBDt3QrdLx
	 buQDLVdv88/Vv+j5ny7gtC67/WiwlGJuMSrH4ux4D5ZalON33QYOa9PMH1jZRUr04y
	 J1FqDt8DYiAPkjHGgnKHRgQG0qPjit8zfNZHgSDrEIuzlDWf93YkQtjVz5bSoJcYiy
	 DrEzBLOdKGnPW5eLQMbK+W3T/a6ojJwV7DaZsKhLsAnxS1BUlIkmc8y3e+bnO+SH5d
	 nKqDrJsybvSBsjYHY6y7cyw0CEu5jWLZe8tz/0ulvT5R7uxXXrkq9DfiFhKJ0Aj1B0
	 NGe2V9kKxToXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC9039D0C20;
	Wed, 17 Sep 2025 20:32:56 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aMsOe0f9m4YN4Mes@slm.duckdns.org>
References: <aMsOe0f9m4YN4Mes@slm.duckdns.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <aMsOe0f9m4YN4Mes@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.17-rc6-fixes
X-PR-Tracked-Commit-Id: a1eab4d813f7b6e606ed21381b8cfda5c59a87e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37889ceadde0329621a1a1f253febb2019dfdec2
Message-Id: <175814117546.2137494.8536516515947754010.pr-tracker-bot@kernel.org>
Date: Wed, 17 Sep 2025 20:32:55 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 17 Sep 2025 09:39:39 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.17-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37889ceadde0329621a1a1f253febb2019dfdec2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
