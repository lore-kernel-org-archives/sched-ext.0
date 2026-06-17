Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30AF2E6CB8;
	Wed, 17 Jun 2026 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695508; cv=none; b=qJ4eU42lR770wMzRegy8ARwaVwYULuWk9TwKTgkCs3cpP/WHC125HvX7PR6Lg8yAkqTrlaKSDGkhHhH/nIo/VCtJgy+RjrZ6/QIr48TcWWVIIE2+9vQ1pN1P7A0Yvrlhptf9FGN3uxoPkUSShP/PFuBA8QO2lgYYjc63djcorkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695508; c=relaxed/simple;
	bh=zCCuUEZZ1+Z2NKXXs3kk7fsl8CEgw13nkIxaEFXjRT4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TQnsSUX7w0SKZ2i64X4QdvZBPPxwpvCoC3wcLehJf6h5mJdDPa+C+UqqIKqA4t6XRf5ecym4G/8h/O+auxoREZVt6F/xlFTuw5LvFZISLOf9QNS3p3P56KGF4NZyL8EbB9QgHeXmlxBfXewEQr25mJOH8iy4LThXk7dl1KxaRw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH8Uduty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH8Uduty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A0F1F000E9;
	Wed, 17 Jun 2026 11:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781695507;
	bh=q0ZM3KIkroUOK8b2HMp4bsEXnSVsqz1KuqRNwAL5cwg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=bH8UdutyWLEp5VQtDRkf90fFLJS/rt1xbVb7j/K3BA25+TiRsWPY9fp3WsOGWhLtH
	 j50+qY0pRIv86olig+AMl3b9qP8Lf/nEX/HrcFtbk0NIiD+02mgPPAg7CftDmTlEwN
	 OrgYCENuxd/5kYoNKwUxg76q/SEF17xBjmnteBgLoV/KeiBs3vUXEj9xVcHgFKM1FK
	 yc7E5Ti5erXeyW49hA1RBbDH24FpH1Q5X7GxelSszrAPdTaF8+3Y+hPDGvkSnIWcjZ
	 Pb8skiGY4hEwsT7QblpHFODOMRCrCa+AX6IjMgmOOIAnx9qTv4v6jzwia2wLU7ZdAn
	 MHObeJv/1UgkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A323930E03;
	Wed, 17 Jun 2026 11:25:03 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext changes for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <6a0da8f90fd3890f734555f1632a3a0f@kernel.org>
References: <6a0da8f90fd3890f734555f1632a3a0f@kernel.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <6a0da8f90fd3890f734555f1632a3a0f@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.2
X-PR-Tracked-Commit-Id: 2e05f2fd0dd72aa8aa56cf355e1e39a3f565b4ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b33fc6492a7b7a62359157db0f92f5b6e9af690
Message-Id: <178169550170.1566750.11525125251340256401.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 11:25:01 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Mon, 15 Jun 2026 12:56:30 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b33fc6492a7b7a62359157db0f92f5b6e9af690

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
