Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E42B42EEB7;
	Thu, 24 Sep 2026 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287606; cv=none; b=FK9+sdDWpeniozOrukkwbdJpINbvaMsD99kwKYKrB3bHKxo6RGtM9TduieiOoQM7NndbKTfrp56bnn0VYVIkE2NLRy4ErzDYAthwRzkPPs2WnFlQX6lg0xpCRRpugVExnKQkxAQHi79rTt1/8/nt8oBEDCwL0oPkMa6B/8p2UDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287606; c=relaxed/simple;
	bh=EPhgRaqsDV4gSss/ss2CBzNEgnKdVbHfnQGMLYLlwYM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ujWl0FGvJ6NZHmN1ZsA+4mSuqiTr0co6tG4NeefqjLI+D06VitrNL5NBJK7JkMat7XYTC871m2wmu5ku8Sqh6//wSPeOagfYxaaQQsUrxswd7MpHkAY6MdihuUa9HVhLdKlY/OEJBlR4+WgdOplcPsHmTgTql3ktey+9C5LNEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3EcUuu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3EcUuu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241B11F000FF;
	Thu, 24 Sep 2026 22:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790287605;
	bh=D0l+4+6ld0nO34yGsd0N/tzBReHLnipv40+gppaW03g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=m3EcUuu0s2iNR4KH51fsqFbZ1B8/AqdRR9J1hHy66XyzZnVL1ZfKaw46rU+7lcgij
	 rlyQ6JfpPXcqztnGbqXbQWKM6AVcDgGsHL8xaM0JZzQ5ntkIHcJkXSA5jlSJB0g8/Y
	 vZGe1KDDZekUgYY8ZC/ariQBq14mRXR3X0NChOgiNTGMBaYVXCJqYCPcW5Xrczf2Gi
	 M5eznuRdZsLGW1fzyKsOrtp4ZmhksE9iXCC3g19S4lLTJuXRVHE682A8CFHAujz36D
	 u74K3B/ON11JtEEW9i+7YEHPOQWFtnfLAN97Amrt48Lg5X9oJf6cBfo5CVcflhuIHX
	 GLFcYV8dSh2dA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199EF3A566ED;
	Thu, 24 Sep 2026 22:05:35 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.3-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <be7ef09b8be82e9f0c5fb2bf197d7a44@kernel.org>
References: <be7ef09b8be82e9f0c5fb2bf197d7a44@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <be7ef09b8be82e9f0c5fb2bf197d7a44@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc4-fixes
X-PR-Tracked-Commit-Id: 4409a85735cdca5c4c400c0dad1feee091872eee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee9c669f9bf5fd2c24206746ded9382fe810df89
Message-Id: <179028753357.2222164.10658990911294213165.pr-tracker-bot@kernel.org>
Date: Thu, 24 Sep 2026 22:05:33 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 24 Sep 2026 11:19:47 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee9c669f9bf5fd2c24206746ded9382fe810df89

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
