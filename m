Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2B336EE9;
	Thu, 14 May 2026 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776870; cv=none; b=E58NnwWYkWOzIggjbAzGV0etKzsJz0aiDVdKeSQlAEGDyQL9QKmZXRfCqlb8SceINS3D8FB9CkRU/1ekevwOS690kzWANFMjvmcgVpBGQtaDx6HvNrZUS5eXCbQvE2x3pxeDKr4yHAtoJR1NnW2x8aRQJr8+XpPC7/0RAM8QOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776870; c=relaxed/simple;
	bh=841mQrEuxYwhTkLZaigH7cWWurothqrNK/sCnVkMIsM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Mz02zhOtwmG4OofdWA/Fix1INH/W5KqmH+0Ihk+chBojHL6IrB9iUZ0AlZFsyf5LfkqsPpfFwVNRgwKVYr2iXrui6hV95Hz/6nul920v+6RUocfh0tzKkM6rlPIcMRK2ZGTzflrYBJnNFL79WnlpXmj+mKtfMU8+gZYrk35V1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAKnZub8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAKnZub8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34585C2BCB3;
	Thu, 14 May 2026 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778776870;
	bh=841mQrEuxYwhTkLZaigH7cWWurothqrNK/sCnVkMIsM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nAKnZub8JtFLzNDslc3A9yhbQBmLMY+9Fr2JEigIqN0FndpTTeTYYN6fnoce3TUPz
	 pdxP3WjhqNHq1ydcgyZZ+J57lDuXzYvvinXYO9kc3OVneLfvdXuz63ogvdOiG1w4m8
	 unTyi+zOvU78gahZgA/NscEqF6Zqfpyrn3e9qWoSJAllPDX2Jo03N8J7076ZuCoAXs
	 5zjEnISy4jYUw3LQnkWYQeDRsiXbbjxAvmvjrutOZZkCUXyULv1imWFF+NphR8owUe
	 jmcO7m++G/YHTpfwE+RkmGkyV06sbtPZc5SU6AzD9oH1ukHOWEAH1J/G/fe71D9RnE
	 bV+oe2g++uqhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2F16639D6578;
	Thu, 14 May 2026 16:40:16 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.1-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <4acd9d173508e386568e333a474d606e@kernel.org>
References: <4acd9d173508e386568e333a474d606e@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <4acd9d173508e386568e333a474d606e@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1-rc3-fixes
X-PR-Tracked-Commit-Id: 6ae315d37924435516d697ea7dde0b799a5928e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59a62ea4583e0f740bb3576ec210b23f39754327
Message-Id: <177877681490.7753.1051566017562267672.pr-tracker-bot@kernel.org>
Date: Thu, 14 May 2026 16:40:14 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Wed, 13 May 2026 10:59:54 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59a62ea4583e0f740bb3576ec210b23f39754327

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
