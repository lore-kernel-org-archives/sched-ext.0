Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD9634321F;
	Wed, 11 Feb 2026 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770853480; cv=none; b=Zpij9LQpWMriq9W7bJIKTU707QfD1KIro52FwM1fVtQebESKyMH+rn+LPRbfkZfi3sH5xpIC2tx2FFb9AVQWgZQ/OTzwbHaa7r86nEr/pwruWkb3vkaHyHJfC39LlcqVTpIXZZb3ba1N0Gl08XRQTDmM8tl1awED5zPqwOMnf+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770853480; c=relaxed/simple;
	bh=Za15YxAd4c1YucHpMUCUVy6RN9tdDbtfMVWrO9SjfUQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aZnIMFXLgzhbB2yhLhmIh1RhHsOJnt6rOcoKmF7xRYrbgSC5wx1suK+zD9FFJi6UBovwdGNOU4fIjolEo5V9LN7ojNAJAPobrdDaUC7uRTPqx2S+41ruaeM/8ffbDNyUiR0LmWbpI5Q9wo7qQes070ZpHD/EK4sC9vTWNy+QDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZbzwx67; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZbzwx67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F9AC4CEF7;
	Wed, 11 Feb 2026 23:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770853480;
	bh=Za15YxAd4c1YucHpMUCUVy6RN9tdDbtfMVWrO9SjfUQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iZbzwx67gTbV/4SVOBdSUNyd8rYm1PFNTZ9wK9z8BL23DLmThJccQSkCB78VAngNA
	 Mi/81gB+ngJfZULAwl/CjMegcKlgMmzO0lIvLxwZKRK/3UnB2qYmWoi9+MxVtBUyX2
	 57TBAsiv+k3FzlHc/TQEYMQqwJiUY/4M0kGfFD9YMqTrVu4W2uhc+C/eY79c0fbP68
	 fMFfM/KGTtgNOg79rdAt5DJubU+a6iKAYFAcj6xk3tKZHkUggMPdVdtK4X3SPPS4Zn
	 x5VTfCMtrZ8zYN3wB1oFCET1bhpAiQJannNeOkaWId4Xh013FkmZxBXQ6zMGVwGDME
	 0fZ+VoSnkm2Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8507539EF966;
	Wed, 11 Feb 2026 23:44:36 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Changes for v6.20
From: pr-tracker-bot@kernel.org
In-Reply-To: <b9f4cf5db168c619bbb67f05d3c61109@kernel.org>
References: <b9f4cf5db168c619bbb67f05d3c61109@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b9f4cf5db168c619bbb67f05d3c61109@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.20
X-PR-Tracked-Commit-Id: 4544e9c4ec9a5955a37fdd8204a3d98106f97ab7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38ef046544aad88de3b520f38fa3eed2c44dc0a8
Message-Id: <177085347505.796778.7093164499955375653.pr-tracker-bot@kernel.org>
Date: Wed, 11 Feb 2026 23:44:35 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 09 Feb 2026 09:32:56 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-6.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38ef046544aad88de3b520f38fa3eed2c44dc0a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
