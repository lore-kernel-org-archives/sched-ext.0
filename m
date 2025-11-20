Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722825B1DA;
	Thu, 20 Nov 2025 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665567; cv=none; b=upOhxtpiVdjULo4o7wjZVrx9uFtimvSRBmwHU1Tu/20/8U/P26Uw68dUXFL8kE7o8ped+XhiRvMitEbE82JGs4Q/UNo23vkoR6OfXivuG3lcyzULFfy9QgqdQDG36Lzzh+82wFoNEhfaBCcjKxO4HK+vtpkYAlv/PXHQfLUbktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665567; c=relaxed/simple;
	bh=TW2Oas01dwhXtUVYhe2Z8/dYpCaJZ5JujrrtKUbTMUQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K5DYzlQPOBDGTPbfI1ba3z0g4QrkKOD6EbMtkdLzZjFC3BxNFAZnWcY74tOBGj2S+8tKNTC3j5yxMzl1BzLT9NPHPdXWxJ4CAayMnTcHi9Nxf/pLSXAU6kV13bRXWJLyJThwypT6RJlcRN9GDwV4bYPkaHUbIVsrRcYGS9lP/F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLlExaK3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLlExaK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5888C4CEF1;
	Thu, 20 Nov 2025 19:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763665566;
	bh=TW2Oas01dwhXtUVYhe2Z8/dYpCaJZ5JujrrtKUbTMUQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aLlExaK32WDi5G0h1PCxpsHKtKphgtm+mb7l4cvKZkDkXBLVA4stWgDS7DoogAgft
	 w0lL0Am8+QJewkPCF+WCOxNF4Ezp4z+EUP9hm/pfJQEq7uS5U6sdGp+g9Cx2/v14GR
	 04mhZ9EhOc4wq/pzKU/U54DRyPD2waZD8nEqOJ+wgiDgODx7HzV2Ik7rzVIbA0xi12
	 Vfzm3Yqgnddk31lSdS2S651ItIgHbM1NihISfNVHNIuHF5T81J8oviysHREUFkSo1t
	 PClgkpQAKzjTOlRzShBroCO2Q9/QuwH9vqgzZIBymk2hTUiPD6am3U6Mbl8YBTuHrB
	 cIDCtuKvbc/gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 349953A40FE6;
	Thu, 20 Nov 2025 19:05:33 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Another fix for v6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <6f7a101d95d9bc9ff02662c35f45911c@kernel.org>
References: <6f7a101d95d9bc9ff02662c35f45911c@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6f7a101d95d9bc9ff02662c35f45911c@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.18-rc6-fixes-2
X-PR-Tracked-Commit-Id: 7b6216baae751369195fa3c83d434d23bcda406a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd95357fd8c6778ac7dea6c57a19b8b182b6e91f
Message-Id: <176366553187.1754573.9690612429799630921.pr-tracker-bot@kernel.org>
Date: Thu, 20 Nov 2025 19:05:31 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 20 Nov 2025 09:01:32 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.18-rc6-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd95357fd8c6778ac7dea6c57a19b8b182b6e91f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
