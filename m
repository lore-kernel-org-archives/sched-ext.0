Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F41372EE6;
	Fri, 22 May 2026 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779493536; cv=none; b=Ax6u14ohmAtaX5GGuVE/IDsAyhytb7vUgqVCL+awJJpMEMRA/EsTKhfYdloMy0P9NN9EPZpRS9hnDulmZKOpsUj1DXSWRNmKeQUli7/ERapmo5vpri2J3IOj+G4kRy24K/jUeo9LigaA4PIFquLF0Jy+93GJXHyWPRPTdYOchEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779493536; c=relaxed/simple;
	bh=YgnXHdzE/7x4dggJ2fkgt4w4BX6PXHwOYK5dUXHfYQg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=miVmhDmUxgJ8vpOy5VpyETVNLewzVjgAQXmR47Z73m27kTfddPFF40QNHemKEYILC8t0VBA/GdqCY/8PzaKVjgTRZHdsqkMFDyLmsT3I13CLxmUxRxMNjMU4wHlDGZ/3Q4SDbBMG07TlsP5NHLZuI9xaamQ1yggCxlrCNDnAIRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqpGSTtv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqpGSTtv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9381F000E9;
	Fri, 22 May 2026 23:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779493535;
	bh=2Eifs6oov6snnh5QNFtBxIHS1736rkLGsAPgiNIBh0A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=PqpGSTtvhVK9qljsTFUPTg58D+KxO876LwZeHLjAiOkdQZEmTXZtm8ODmyDeZfZUK
	 kSksVGxQ+uVwHyql1/b+0whEkBHykVyuDl+GznW5/dRh8Ri2iQ77av6dB0AINBWuGq
	 0JcJAx6u1ttE/m2Yt8LtLJvKYR/JVM7F7z5tauNaGUnQkC0TPTicNeBin/bsqBSCzX
	 5iBW24cRsje/RW2P0yhpL6uk2MXqCLHi4L7O9NZ0F00gMBLMwEnqt5DSBsOYYO+OaE
	 hC6ZrN81E4U/MXehOlcrh51ESY0JPCZuIxMfH+mNvd7IcURzY+mAItgX4Y7lM/Bij3
	 kASdK8Yj4eqHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19982393100F;
	Fri, 22 May 2026 23:45:45 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.1-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <154badc0cdc979593d4321a2cdb9ef61@kernel.org>
References: <154badc0cdc979593d4321a2cdb9ef61@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <154badc0cdc979593d4321a2cdb9ef61@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1-rc4-fixes
X-PR-Tracked-Commit-Id: 0c1a9dce208b4dc265925898e5da98934f7f9266
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79bd2dded182b1d458b18e62684b7f82ffc682e5
Message-Id: <177949354363.1410141.11427898439050583470.pr-tracker-bot@kernel.org>
Date: Fri, 22 May 2026 23:45:43 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 22 May 2026 06:48:26 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79bd2dded182b1d458b18e62684b7f82ffc682e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
