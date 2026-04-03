Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729F3D7D66;
	Fri,  3 Apr 2026 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245979; cv=none; b=kA4nZIIWd0+TOWTYrngC4hT3u1VQT+IkltLfHCVqLJPZZDiDtCOTJqZDejnIEDWN8WIbJG6NLP61mnB2scwNn59hShQrPfCIfy42zmzvadKoL/yaH5C8jMJd87MJ43VZUJS7ufGbMphPlv0+CKExDdCPLchCazNoDYcG2oce9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245979; c=relaxed/simple;
	bh=WaaVX4VVcQcTxvm8Iz+pA9zC5s+nzNKlKeNrrlmxGRk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GoiY8j74zSn9r2kBdSUQaFhNuTL/o50bpLSS2k8pZEQXjRuG75TchfYFxANMVTgCDKq7xdR2sB8lcsQiapO606Pm+DvrRPcOPTLjQZ98fde6wXDo/3IaSTnE+wF1WZQ11JaaPHeU8jw2/k8ImSN8XijrI5SEtxJOJj34p7R4A74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2iJHpc6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2iJHpc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A14C4CEF7;
	Fri,  3 Apr 2026 19:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775245979;
	bh=WaaVX4VVcQcTxvm8Iz+pA9zC5s+nzNKlKeNrrlmxGRk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=b2iJHpc6a8dLVvTODOXpr9W0KOMCqFfjtX0ACZ5xkbYoEOogH5y/VEdMd6HfyI4m6
	 2q+qO2gIztwR5Wu9swOvcF9wFq7uYxg1BkksHZ4LWDpo3SYMD/wn3oPD6XSyGHGCJv
	 Xtt74fM22/Efccml6POmwd5XCcUrjizsS3LdrOZSBmHuOnmcA7sZKLm464RuihqfA8
	 6ZHpKAcqIHobeKtcKDw9yJLGkp9ugwCrypG5aBHZuxbGQ8BVydDyHHMKYUNhTrQPLB
	 mm5fnUTrEv4JhoZQ2/Hs3XqKTHq3MVNEmMBtK8Gs80fZIk7ZNmvluoyA3r5OwYLaoW
	 qseH6UNIGlxaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFC03809A14;
	Fri,  3 Apr 2026 19:52:42 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Another fix for v7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <185f1512633cf18018c9c93e891d7c67@kernel.org>
References: <185f1512633cf18018c9c93e891d7c67@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <185f1512633cf18018c9c93e891d7c67@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.0-rc6-fixes-2
X-PR-Tracked-Commit-Id: 7e0ffb72de8aa3b25989c2d980e81b829c577010
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 631919fb12fe7b1f0453fe1035e62ce704bc3923
Message-Id: <177524596113.1431632.4075914100115817783.pr-tracker-bot@kernel.org>
Date: Fri, 03 Apr 2026 19:52:41 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 03 Apr 2026 08:01:03 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.0-rc6-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/631919fb12fe7b1f0453fe1035e62ce704bc3923

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
