Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802C128B3FA;
	Thu, 31 Jul 2025 23:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005616; cv=none; b=X/erYDoHHJ6nVAiSOehEhpUP966UekrBVHrblj5ne6v0ZRIO2snMxLlvCp1mDU0B7toFN6GY6NPK6vrNxi0msbR0Ln/+R3d2/cpUmk9KKlcZF5RLzUf4ALUY+GYP7rUKMiyORezOGMd58FFF1LSdQpsp2+w0y9qhMOA8jzNvYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005616; c=relaxed/simple;
	bh=Kwm7atv08NvmgVjJHdfepm+k8MNRq/ApIGJGn+Tqb2E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ReOFUoRbdUQoEandoUsI7qsAaBQRJDhdxlr0D1ie5m29nzfdpZeO+0qvKrvVg7xTu5sqtgS6lCeCgLiaCbMiabc+96XOxWld18uvpXyED7YVJH0PW6Obm2IP+ANmC4X1UBIMb6VHAvz932ou9rz+8gmn8rlYMuBKn7miXs6VJsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCLnqdRm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCLnqdRm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617EFC4CEF8;
	Thu, 31 Jul 2025 23:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754005616;
	bh=Kwm7atv08NvmgVjJHdfepm+k8MNRq/ApIGJGn+Tqb2E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qCLnqdRmr+Lbku4UggVKez8kN2BAFbEVy05n7rleY2JX9z1qNf66l1MiOrVryxMWU
	 Eq3Wp4aou7jzyBzgBCsKy7Vts8mFC9VJsVVoe0/1UhniOn4c9F08Ic5VZuxIKmtAOR
	 c36AKCY8/XhQKsRHVBgh5zid4KLNuNk1QdkCzvnoE7x6F8NmO1SWuCGqOhkOLtCSQ7
	 tjY6Q9oyZLdSN4F4IkaDoBdVIdYYQDnsrx+vwYuNzccc2PgJNQzC+1MkUSwMXziHT5
	 ERd1Y7HOnQxfp/3j+wawAbL3r/YEYlcU5kMCDAN+1wyRYRZnE1G8xOQ9gmEWD2yVXh
	 Rx7ESOF5rfN/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B35383BF51;
	Thu, 31 Jul 2025 23:47:13 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Changes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIqoCzHb5yRoQsER@slm.duckdns.org>
References: <aIqoCzHb5yRoQsER@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIqoCzHb5yRoQsER@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.17
X-PR-Tracked-Commit-Id: ae96bba1ca0000ebb3f3ced64c9367e2a223d69e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a68cec16b647791d448102376a7eec2820e874f
Message-Id: <175400563182.3358753.2931771576087351689.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 23:47:11 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 30 Jul 2025 13:17:31 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a68cec16b647791d448102376a7eec2820e874f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
