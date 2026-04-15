Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D72D8378;
	Wed, 15 Apr 2026 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276735; cv=none; b=pdABHPOKG2L4+Wq+CcQsMylPF5oXXFPUgCOwM/raA5xONAp4zp0cJwa8TaI7PHgeoKbiIPedWorK+QCR2Ck/XXly6cL8gY4oVF6FkXx9lDnZNloG96x31ZtMj6eHR4s4jT+9OpQZIVci+8CxkuarZUAjRHGRI9+5OGjBjN4mMhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276735; c=relaxed/simple;
	bh=mDtQkdm8c31EQJV4hz0mqn+WQYxg8i3St9r+hkFN/yI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jeKngooXU+Dmwg/9QO2KbuZoah3RtFJAfr7TDa1g64IT8p0k297REw/bWfwvT11e00AE4Vn1F7pZGadLcYgRDgtmVPFlROlXO+gb8WIog1Ch8rjArw+xKc+1n9jE5DSsYTkA3hPGcfXb57KwBS1ar7tm7dsvgbVGAxdqYemkLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcmxCndR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcmxCndR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52845C19424;
	Wed, 15 Apr 2026 18:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776276735;
	bh=mDtQkdm8c31EQJV4hz0mqn+WQYxg8i3St9r+hkFN/yI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VcmxCndRhqtj0Ttr3E2tOmg7xd1qh92gkXIbYyghlUlB+CY6RfAaC8zDdk/e4A4a6
	 cJPJ8prsNBxYU30wX7GS5eS0hP40RN0e8kabAo9uoOCjHAoKOaA/k+xsJvwBWY2yXt
	 6M7mDjLd1bC7fkzxTeefeM9Eitv32/A3kRUOGFeL289NziWAqkZn+bhd6HBAqHs8Py
	 6atXonkaC7yvmFIDoqQLQ57L77vtIUHFOqsh8VJsPMzT0WUytuqqo0Om+qCAgzAobG
	 Pgf1dN0wYRYs7pgUVyIVOlIGvkdmz+9DBkHFrmALYxX8cuTXgDeXh2Mey40d7L92y4
	 tPp2ByEMa0Elw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E57380A963;
	Wed, 15 Apr 2026 18:11:46 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext changes for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <d9b4c8a00c64192691e22954d09574d1@kernel.org>
References: <d9b4c8a00c64192691e22954d09574d1@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <d9b4c8a00c64192691e22954d09574d1@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1
X-PR-Tracked-Commit-Id: 7e311bafb9ad3a4711c08c00b09fb7839ada37f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bdb4078e1efba9650c03753616866192d680718
Message-Id: <177627670450.2372891.8773295576327920060.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 18:11:44 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 13 Apr 2026 08:27:32 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bdb4078e1efba9650c03753616866192d680718

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
