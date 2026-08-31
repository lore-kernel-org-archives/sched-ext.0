Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4246930F924;
	Mon, 31 Aug 2026 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210389; cv=none; b=rZy+Y2fMKk9RxmmizVvs4b9wGs/mZoNVtYQt6wDzMFKYmFQsoXDSo1MS2c32pvpgTgYSOV7cYZZeGDfUlbCPLYsbgU/zNt+h8NX+zQVKpzHTuWAdkYr8i8J5wtx7TxGa1KpI42qldSnWuvrLDkqkc5LI5AdrHW4BfR27PxH+fQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210389; c=relaxed/simple;
	bh=on9W0iZdjE0CONYEBQDzRLxVCXvTBfYkz3qO8R4fyzk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bGAH7VCgKWBpA6LCAoNrAw8Jomdq3wItxyhfOu1pgxkBykqLzI6AbxVqc3aoa8rIRJ/tTDi2TOmHLDbucIAPwg04TfilhuDAcnqr6NF9Z2neJq2YDxrbXERKWNzMByK41/mVFMYFi2lzkVij03esEb1v7EgUIWWu9WnzvG8wDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neZ8YcSe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neZ8YcSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D227E1F00A3D;
	Mon, 31 Aug 2026 21:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210387;
	bh=BLInu6RvvZGHywwNg4lsOHG+7URIGo5mulh0ZFWtrO4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=neZ8YcSeBYgnRcEzMKlpEmQG+AyUDszo6GQeBLpOL1o/+lnRKlPwM41UEc5QduBHx
	 WSydGpBQrWaYrjkBAg9yYX7kUQ82TFEzrHTacP3VOCAgnXUWL09VlKWDgV1d4jbUSp
	 oM2UCD8np7qDSFrY5AzqOteEoKEbK9mVMEsdQAdOwPB7MlNw+fmEGwQERJ3da1rEoO
	 E4Dd491sjeE9CpOwa62ZHB+ce/lljaYQsjkyaxSXV9QettIhIdaMPquK+t2ynHBFRt
	 MRUUCFekjQbenCubR+I1Hhf6ij4K07jU9EGw85QxzdUfMt9TAX68z9yBoTp4NpkDci
	 KBv90LSOZosJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A763924469;
	Mon, 31 Aug 2026 21:05:32 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <0f59915200a4239f27a624250c58dd6c@kernel.org>
References: <0f59915200a4239f27a624250c58dd6c@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0f59915200a4239f27a624250c58dd6c@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc1-fixes
X-PR-Tracked-Commit-Id: 068e5a0bc57e57d24cbf38def29cc5fb4db9a0df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf1079577a116f0685e7025b9ee2547345ee1c63
Message-Id: <178821033071.773084.18341134789285724214.pr-tracker-bot@kernel.org>
Date: Mon, 31 Aug 2026 21:05:30 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 31 Aug 2026 10:03:50 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf1079577a116f0685e7025b9ee2547345ee1c63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
