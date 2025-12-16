Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE434AAF9;
	Tue, 16 Dec 2025 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872418; cv=none; b=g9R2KyvOnFU8Yv84y8YvEdSFApkaReVgM4BAzL9q9YBPjZGIwk8D/EyP1+NGWeq8GlpcLE/izWnQbuZacLPdUn8yOVxHZT8LNjWeYcgOorjrfe7NXYc9vtCBZHbcjFgQkQCgcmJiBypmmdfVoynjZmYRBMR2aj+7CshRnpUSnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872418; c=relaxed/simple;
	bh=BF1PFPUAAj01uRpbsDIspQz8n7Vnj7WPyZK5Jp1Jj9g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BOrY0PhwF0+aHFK1TalUCqbixCk+2KKcgg3TuxNzvM8YpI3xznELhKxHfwHG1QwLvStMNLT8HUGHPrOXF0j8FzDq7zBtYw6jX9ffIdpFZB/R36RvNE5bxqQeJJ5r9lSUgq4z18uchLdQ7MK8dHvOvGAP0VWGbxw7puMAPxIO5K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBz+d5Xq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBz+d5Xq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCACC19424;
	Tue, 16 Dec 2025 08:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872418;
	bh=BF1PFPUAAj01uRpbsDIspQz8n7Vnj7WPyZK5Jp1Jj9g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nBz+d5XqIvUj438HyDzV2QByz//XHisoeNxiBrEXFbQSJsXHvXUvUEHGNxYB3Y1Tb
	 EuUmgKjza19ZzAhMsrFjU/dVDURxlpk23G4KH2JA8VGzyPk6j+Y0je+ctp0m53fi9L
	 BGXSs4J35MJPqZBWDHn5N23FkkyB5ndJDDTi9+sFmuoVeNJt75xHAsBwNGza7cx87a
	 Boq6ORj7m786MJGSBeH+oyfWvapIAmwEErdKUBn/LSmOnRURjqtNFwTwNsEINJf0tY
	 crsylP+qyHsv+QBRorTSYnd+GeGOOUBginwUbb8TZgtxhcWb49OH8RvCMoDvOZspK1
	 c/KeGnyuQ9NVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B853380CECA;
	Tue, 16 Dec 2025 08:03:50 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <4f9a656c7143b04e974d447e1b3660cf@kernel.org>
References: <4f9a656c7143b04e974d447e1b3660cf@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <4f9a656c7143b04e974d447e1b3660cf@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.19-rc1-fixes
X-PR-Tracked-Commit-Id: bb27226f0d00588ac53be8825e021ae80aa43371
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dbf89321bf1eb0cd3115662c4fbd569abf92ef9c
Message-Id: <176587222887.917451.610373157902930272.pr-tracker-bot@kernel.org>
Date: Tue, 16 Dec 2025 08:03:48 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 15 Dec 2025 06:56:50 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.19-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dbf89321bf1eb0cd3115662c4fbd569abf92ef9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
