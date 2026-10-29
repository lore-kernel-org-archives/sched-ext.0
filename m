Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793298544;
	b=SwERRB9re+VzXb+L965VdDagUfGamFmH79wRWnVNjIQJN2K8rRq7Jzrsh1Z4tGY6yEDi
	 0QqWw9lt0wPV8INMr75y8Dj9Q6c4O8vMVp2tBOyseWqXE7FBW7Ea0C2qmZEVJTPo6f8tf
	 rrD5ltSy2tYSABFOWMGm2B1O9bg/K9U08FXWIw/dxDlTdyVIhAzuIQ9RJ13AN/p41ftmU
	 wUOM9nKnp1tZFcCJnwmjYzVMezfrtTXyG6zUSRFngTocrs67hmERfc7qg1dPqaSjWk7Da
	 +6PSQtKDHK0A6sLOGEHxsMzuQHBa2FcgQGUj+5IoiyIndYqQj0AasUhB3LcEZLH10uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298544;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=K6b5PQioullVdHuvXgl7lvwI5bkhDtemg6VFa6fJpkg=;
	b=ppPEAydh+CDHBFLBLG8vN7/2GFx7ngjRojI4mHNuizaev7DRMIjHbjxntBOoFq/nmaQC
	 hByTqj8XRERRAF+BHyqt+BS9iL3uOShEfGYywJKsJxrdbHNxZKYPZQpzwGeVjkA8LJqoT
	 +GME7+dq1TJ+5xSN1XzdIBm9Zar5UgzFRVkS9RxGjlY+VAt1MKIN4AFY5t2gwgttX4OIU
	 z3QcCI3R4hLlINdE/2g9Q3VyptkZEYydGtHFZ1srLF1OXcmrU4e+uQ60ARfWZb8UsywBy
	 slXfMxP4NT8GzhX6qs+IF9ujxnC7jrnENP3LzXePMS63fWbOnmSppiNfYpK5FTuSqfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YhEB8oHk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC07606A31A;
	Thu, 29 Oct 2026 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YhEB8oHk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F101F01816;
	Thu, 29 Oct 2026 18:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793298543;
	bh=K6b5PQioullVdHuvXgl7lvwI5bkhDtemg6VFa6fJpkg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=YhEB8oHkNsiF7xZPTHh3cFQLTWobn6uB+QmFJMncgmr/dofy+7LQTL/sOHfh6luPV
	 Ujap0OXKghdSX4hchN9zA5HCXgi00KXtvP1+A2q5QA+1+ioQMTybOUSjd0+b20s75h
	 8Z7QseTFGrLdG6A+B1KeLl3rpWTrxH1sC1zm8qMpZ0UO+c725L2XsM4Rv4+tvzngmz
	 CeSQrX66fr9ZvxV3vsEa/masLZCyOp9TTA0yuffsvo9YjBJZr76w5ttvUGxtE+duUJ
	 RWs6QicAjmDLV2ks3ouBQrNzmB81jqD1JpTFe2OIkUMUgEdCw4fbsb1WloE86X+42u
	 A/VfD/gOgYIWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 402443808228;
	Thu, 29 Oct 2026 18:29:03 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <e5758e0a056fcef3e669b4d1f285a787@kernel.org>
References: <e5758e0a056fcef3e669b4d1f285a787@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <e5758e0a056fcef3e669b4d1f285a787@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.4-fixes
X-PR-Tracked-Commit-Id: af4ed5682e62556beb399b76f2f1274ae1aad9e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 729beb5aa80ce4bcf40f9ff74ed845269393a6ae
Message-Id: <179329854172.621556.11467000048377793986.pr-tracker-bot@kernel.org>
Date: Thu, 29 Oct 2026 18:29:01 +0000
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

The pull request you sent on Tue, 27 Oct 2026 10:31:34 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/729beb5aa80ce4bcf40f9ff74ed845269393a6ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
