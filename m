Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F0933F361;
	Tue, 23 Jun 2026 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782255638; cv=none; b=jpJY750UaozIO+AQRpWz451AawcagnSeGK2nMHIxSJptTdtldxUTNDRZyYmdf1cZmAlNm43XEodVB7lo7MuuKtDQ4k9SFFLVt6YaXDjjAgA/jkWygc4/adbLLkmJ5RX4OkB3ItSQ23l7djK0126pAn8c/8/+wcWGuSLpYjCdtbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782255638; c=relaxed/simple;
	bh=LstOdwD+RV/1OigRzKXHAcrnGfyiHV3P3RROdlt4RBk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HMfcos4xX5LWo5EYTKHCEhVVXv8HuQeUhXPYHc6u5XIz1lm+/v+yj/CgRk+V7YHI61SMaaxG1N77pAPEhN9RYlTEqxi7ixVPnvlQ72+M0T0bl+n/ACyL6b8y/rinR0nk0e7aKeBa2Zl2DGY+dprPGsnqszbX1XCFk7bM3K9Be98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDyns7bK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDyns7bK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4612B1F000E9;
	Tue, 23 Jun 2026 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782255637;
	bh=hl+jJ15giJ5dDhBQANGmA+71L5gTMQVOmUmt+O8Gg0g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RDyns7bKeBOzIjwQl6P22XUC2Ux6s0GXVBnC6TFkCnWGOhEAwpwwI3j796Z1szIhN
	 DDGJNMNNCycQ1y3vD393SNwYm+FTrkHzih3BV+P9JQt8g1pdj7hp4jFvVlu6P72sV1
	 MHU9cauyjqyl508hGBh5gK/ZLqxvD7fPCQJd+3JtDYZ66FkLQAuEvERaSZFfHU73nV
	 esAXSfw/Af8Mwgyar3GHPIgx4OZJ1F2SyW5s53sqoxk+j6VL1tSCWPivVaJELqHvlR
	 j6tLvCVa1cs5RCssI6owSCQUX+uPZzrY1oCVpPqThFWvrqv5HCwoX9hYj6ufR0zVeL
	 VZ6jx95hQzolQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A8C393101D;
	Tue, 23 Jun 2026 23:00:27 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Source tree reorganization for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <e10b2679e4d0882e6d690c55c3efaa74@kernel.org>
References: <e10b2679e4d0882e6d690c55c3efaa74@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <e10b2679e4d0882e6d690c55c3efaa74@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.2-1
X-PR-Tracked-Commit-Id: 4437ad129cf5b37c00a5bc9fa5989d1da4d64d07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7603d8e78023e5883e075b4625fbdf059c6384f7
Message-Id: <178225562639.2458641.11162450186242210908.pr-tracker-bot@kernel.org>
Date: Tue, 23 Jun 2026 23:00:26 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 22 Jun 2026 11:32:20 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7603d8e78023e5883e075b4625fbdf059c6384f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
