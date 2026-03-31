Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BC845348A;
	Tue, 31 Mar 2026 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992882; cv=none; b=pSwFqtlYFDf31Whr/uJQzUB+jHjMTW5RCivjIcmADWzAASGfeSKOSAkBFlW7tgM+Fs8R5czM+3LcwREfDuhZg8Q2ZI8wp2bqh87bELClzj1DJ+zVnm5a3fycDG4ee+oXX2ngIwQbt3BuZnxcjvO10JAMILn+CkQoKT1MrGP7S10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992882; c=relaxed/simple;
	bh=I/vWlhGQ04VLa3zgacR2kH3dGfx5NoanDH3VC/QYNxA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hH1sTithxuIK2HOLvgxEyLUfLt048ftmT2vTIjhvaR9uSl8RGeOOzJmGBuQK/S4jbzbnjMPoGiKM1Bk4Opdp2spojyhADloGwxTaE0ooD3tOPXX7jInNVGQ2756KpXCZM85DZKtdeMqfVFpyELfQp6ELlPajlKBjh9y+iKSfPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2J8vufX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2J8vufX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6CBC19423;
	Tue, 31 Mar 2026 21:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774992881;
	bh=I/vWlhGQ04VLa3zgacR2kH3dGfx5NoanDH3VC/QYNxA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t2J8vufXYrpSW8xyDtFh1T8V4wngOH/pdH7yIl1O1mg9PXsDRzaWJaesYFiN6LjxC
	 KANb0Pc+9Dr4ZmRdp3fptyct5oi0jbHN0ko3BJHBd78Wj9qAyKjdBM+NEIzKL3R/Y4
	 zPH1x0KUiFOtBrt3Iy/W4T6Px3q/ZY0tSTuLcW+e9MFgBOfD3lmcriIRMlo1a8uR+5
	 LV/Ix6Sh/VxxiQBJuMbehsWexP+mc3mQT6VQDdareuIo+iAnwBm3rnaPN5SD9jCg3S
	 U+8ea2DvMRzzC9FtjEjBswN3qAlmhV1fWLADtxJ2XLuCYAx19jfp1chTPXuVv+H3/D
	 7PAnLnYaocBQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE7A3808203;
	Tue, 31 Mar 2026 21:34:26 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <cee468347c00b1b5158d0c3e54fb9573@kernel.org>
References: <cee468347c00b1b5158d0c3e54fb9573@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cee468347c00b1b5158d0c3e54fb9573@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.0-rc6-fixes
X-PR-Tracked-Commit-Id: 090d34f0f0285124452373225bcc520a31e305e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9147566d801602c9e7fc7f85e989735735bf38ba
Message-Id: <177499286512.2954688.5009419414384744987.pr-tracker-bot@kernel.org>
Date: Tue, 31 Mar 2026 21:34:25 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 31 Mar 2026 09:43:32 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.0-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9147566d801602c9e7fc7f85e989735735bf38ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
