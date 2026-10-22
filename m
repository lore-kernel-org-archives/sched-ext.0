Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702222;
	b=al1NaRjCbYJja09OMRuQLVJRTqq7ZI8TmRoAJ9NULcod5snp8lJz1LpCPh7I5qY0dtLp
	 5e/zA49o2h5N5Nvp+MCuPKAPRuPVJjhHkGd6jQGQBqiBAljD2S5uZaSnqZe8hMA+c/Y40
	 b1MLyTF3LEBL5De7SSszdfzl2XNw711hGvmRb8VvOgOovlbQH5UnAAVOGEcR6qHXLGe5Y
	 jKVdX5aF42seHQtthr338WYzWsIww8Jz5fQvaG4DtRxEZWsab9GnQc2v5smXOZVYwh+Ob
	 lWBU4hyfxFLqL21GUFZzKmAJ9RSVYqBl8c1z8Vcy3shhKvKgFdxnk0n01qpycZ3rhbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702222;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=gl/pjhBvd6koaePeaTN6OVvZBZPYnAUcq7vCMRJFcqE=;
	b=fyDZvPbKUV7dVkw881r4zt9xcqYnXr4LGG3mT+BYreEOz+9MQsMxp3WH53c263Qb4sX0
	 gyd3Uub/Sq+SLWGU18j3gpCqdHnL0Fu3fDk6EehPP5dWlTReoUL+HGaPkqPktIyne/k1q
	 z3wVLXpyZxL0lAKa+hM/wJgh3EDl8AQHDsJ85BGq6+5p2zSwNXIG9BtP2RLsdHrJDhCGN
	 KaUy5BA84hSj1cHJyL47motvOgaYuVqlVAw01ciWRWpdCAoihMJO6o5DGaoWbRxd7RIxE
	 V1ITTgg9JvTcBUBf3SuVvH+uIhV1KMIVsuho8d8YAGMuvD1LEbG8Mr5GLUJ2wmostVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fV/AKVvC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01260A2610;
	Thu, 22 Oct 2026 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fV/AKVvC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C508F1F031E6;
	Thu, 22 Oct 2026 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792702221;
	bh=gl/pjhBvd6koaePeaTN6OVvZBZPYnAUcq7vCMRJFcqE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=fV/AKVvCfjYyDJF5GQOZTi7UYjm4SHXBtJ0tvoWt/oNumgRwsRKlU72C8NkPz78RP
	 SXG9l+e7LJBlQLX3FOtSAwaDaCuM/e7c9DRUCeudnhI4TmeMFGOmOasrR67IMBKMij
	 YQNE+sJYjsQdDoHDfZ44AVNekKyiNGERebry+Sisj+vy6sqIYBWbBHaTQPwdQddsOa
	 JB5mp9ADvvmDq3MiAquP10eNmixfelWO7bQ99nzVD233E8xyDhlsMk0pEnuXLlnf+5
	 Gj3iwlwkzFligCWBGTjKV258Rkc3zC3NtcPv648jVsRlqsODxgsebf4ZS86o3GsvgG
	 eQv2Dkvo/ACNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5765380822E;
	Thu, 22 Oct 2026 20:50:21 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Changes for v7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <d66695d960cabf99877acde0c533c03e@kernel.org>
References: <d66695d960cabf99877acde0c533c03e@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d66695d960cabf99877acde0c533c03e@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.4
X-PR-Tracked-Commit-Id: 1f5dde349ac2fca1f119ae8de3f0d2f1c2a8d338
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98aec86f8c6bf2e1091fefb99eaba8b910e8eef1
Message-Id: <179270222039.170280.6235702575882879557.pr-tracker-bot@kernel.org>
Date: Thu, 22 Oct 2026 20:50:20 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

The pull request you sent on Mon, 19 Oct 2026 06:47:06 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98aec86f8c6bf2e1091fefb99eaba8b910e8eef1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
