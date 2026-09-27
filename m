Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786F288C96;
	Sun, 27 Sep 2026 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790538542; cv=none; b=blW0kaS9SysQJHNK4imANwW0gF30h+TyvdtC5EHccEu+s5e4IOR9yKwGBF83DO2gmNCqxxDALkRvlG0FW/oB4LEd1eP0zk7ch39di5ewV/bBOwYzvEAwyEhu8DHw+debKAcjEwLfAKLB3M1ge8YdMIxSpvQhq3ndmY8g58sdrg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790538542; c=relaxed/simple;
	bh=/7j6/t+l4BF+OYx4QUSLVJKHgm+X/LpKmWq1w9m6+aE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N6D9GEvpxLww6t1TRVJ+ZzhhCyzbV8fCk5qAkhMGdOn9WHvgeJbVD9dSbQPBmILcwNkZrFOgOgggpQZsmR+FJGBJl+yT5KgP68D5r7ycZMsnh/dl+plcdxrLI/n2wAYapLP/ZPc7eQwIXp3nABmr17NTZ55eqlMMSG8VSI6Dr6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyaQzIqN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyaQzIqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395F61F000FF;
	Sun, 27 Sep 2026 19:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790538541;
	bh=61a8Y/x1iR+qGvemNcw1M2UJ3Jo2RRLG5LaLOdsIlzQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=oyaQzIqNjSRxVj4mA+UC3OPell1rgVN8e/5JKSMFmNMnQtoCeeNimm1pNjgQMOk9m
	 Pf/Kpw5wENt7vXpfKhI5Wz5g6006hNfdUUnjWIJGCPTfDFaC/cWYw+70CSZz/MflSs
	 CmA7rd0bTNba4LStU0WDF1FUbd1isqrkv/CJ2HZycO6j9RKlzoK9r9HCXCMRXKOrXe
	 lbTFamEG9xuUopClouhuIBWr9/VUPMBhlEV3x8iTpojRdINnnUXp9CBgIa/gWIhC6W
	 T9oe4HwCH4IaqWo9FgTubrzcZJoCKF+vW+BixPzGrkpUY9646oT55HHPMh4azJn8ab
	 tMVQwBY7lmFiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A41380AA5F;
	Sun, 27 Sep 2026 19:47:48 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Another fix for v7.3-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <b633964a6f8f06d64bee4227394d6218@kernel.org>
References: <b633964a6f8f06d64bee4227394d6218@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <b633964a6f8f06d64bee4227394d6218@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc4-fixes-2
X-PR-Tracked-Commit-Id: 94480606a677deb68d5622cf0ded88626514b3f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cdf91542e1ed03aa8f5ab029702b3abde5be6d5
Message-Id: <179053846673.2777566.11072542826703058189.pr-tracker-bot@kernel.org>
Date: Sun, 27 Sep 2026 19:47:46 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 26 Sep 2026 22:49:04 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc4-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cdf91542e1ed03aa8f5ab029702b3abde5be6d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
