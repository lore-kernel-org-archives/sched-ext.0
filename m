Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639CE390204;
	Thu, 20 Aug 2026 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250878; cv=none; b=I5LagfxQbntik8AmedZ7Mt07rKZ+CJsbpZ+ML+zER7CbBtqE99jYudQHPWAMksU+8VKnLcdvBvgZrNBKzkD59a0azO0LuSoQyKcmtNMkOg0socM63SgIsqKbDaO7MY7Kxf7iuYT7u45Vx5fX2qiMLoCxhhkKzlTUZfNQnc9HzVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250878; c=relaxed/simple;
	bh=pOBbskGIVjW0XcqcMia0eoTejHGSMld1zXd7emc8U2k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WxLtfnwYKXUtHzalAem/SC2zwzQ8w0v/KJBWdBaCIjdNc+Ih08wwroxpJ6yK9sTjVmvFh6OgwJLAOLCooEm4HSbA+JSl8HAjpOpskd8HcFrNTe+Au8sSmVO8EO+zoTAJh3uvzmYvfovpFusAyc8oANVEItEzRuNUB38sJff6G/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv/Wy3Tw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv/Wy3Tw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7111F000E9;
	Thu, 20 Aug 2026 18:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787250866;
	bh=sIbKoxD/ivodolUdNr9HzLBze2ZMTbn2n85W7AFZYcc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Tv/Wy3TwX5RBW4BME+TIJhHwwQb/rNv6UKmcVEr3+s2H7AoisyheVadxVXfdRl/kA
	 QiWG9fBrOIt42K5qx/Hp+y+v8RVehC4ql6R1f/SkXo8IjMRRa+b7JHAvxanEea2Jpd
	 53mtLx58SqLtn2skW9Q7F/pVWqvs8wWZU9ImSdtCkop3ZMXSVA10LmoAohKq8Q0p/3
	 xUriZDfSipImizRhyLyz7kfyONILUqpeYhKmFxSSxy7rV528kqw5DUbZyTQklYD4Z8
	 nJIil2C67a9s67tWjaQnnMh+FUAGY7WlYX9GRtlCJhHRINJ7/6ad2biAL3ckVvnA6Y
	 ZVk7yLNwZ7/mQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199643822D60;
	Thu, 20 Aug 2026 18:33:38 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Changes for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <29c6986172b4eb9ba292643ab4ad9583@kernel.org>
References: <29c6986172b4eb9ba292643ab4ad9583@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <29c6986172b4eb9ba292643ab4ad9583@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3
X-PR-Tracked-Commit-Id: fab183d632628381b466a41479489541ac0e29a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11260c335ec6071af5543aef73000b28f041c124
Message-Id: <178725081673.422553.17918065705276211307.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2026 18:33:36 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 17 Aug 2026 11:50:02 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11260c335ec6071af5543aef73000b28f041c124

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
