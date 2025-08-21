Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9716921C167;
	Thu, 21 Aug 2025 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807980; cv=none; b=ft/t40Hl8/RvPwVdY/X7TnjoUG5ZEXwX1Z9WBAPkqbYppMEGY7K+Prp+G4m8ZaXcB27fBimxwzP+XPZvG6ErJZ+4g+Y9WxhsU5MCL52SjUabifTLFiiviK0yWrc9rbwRspLGfQEo65xAgC98jpqf6iTtpgdCcMcwe2aovwYcebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807980; c=relaxed/simple;
	bh=RKoYlWNCxaVS8dYfd9yesGBZY3ipakicPCugx2GJ+6Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ns7eqLsTFW3sQMa+6RD4KyUTglXRcy1oKfGcb1U3ThkKA7qUh6JT4SF+y77jmMZg3VPZZENxWH0l+3Asx736v2IGNalmhUYcyLmmO4xIvKX/PEWSerlf+lF72CEcDcjOPqZsBOoJ16qTu70VrD6g2Xu5RL69Al7tlcm1FWjepX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2rcFPSo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2rcFPSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070BDC4CEEB;
	Thu, 21 Aug 2025 20:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755807980;
	bh=RKoYlWNCxaVS8dYfd9yesGBZY3ipakicPCugx2GJ+6Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L2rcFPSoG7OiJSJZefIlZfPBxz5rMoJFzWXur0VSnWGNpmc7ww8VM1SZR40DOvH08
	 VfBFJDzImKUDlx98xSQtQERcbyoBCwb3RAC69gv1QBfR+jXFUvyxTCL1LQiiYU95As
	 6/R1Paq4GLPWzP7ce+RTBRBthTgGqYdMgwFc+zPQfmkmm8ierchwqsQix08C+0x1SU
	 EkCoi7CyjTZ1W1CEzaY2JeHZ2KRJX7xsaZHBfCyq1kfqqPwfdKt5HW6vCHuMjQkgEt
	 gOWTYzI/eLURmLBf/m35gwNBLCfGmJj/OF+0O0p2abK+muhDxW/uclOUwhX/9wZHIL
	 KWuuFkD41LQrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71277383BF5B;
	Thu, 21 Aug 2025 20:26:30 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aKdXB6r48hme9su1@slm.duckdns.org>
References: <aKdXB6r48hme9su1@slm.duckdns.org>
X-PR-Tracked-List-Id: <sched-ext.lists.linux.dev>
X-PR-Tracked-Message-Id: <aKdXB6r48hme9su1@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.17-rc2-fixes
X-PR-Tracked-Commit-Id: e69980bd16f264581c3f606bae987e54f0ba8c4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d72052ac09ceba6e49230ea9d7e37675d5bab789
Message-Id: <175580798895.1187953.3236608519208462669.pr-tracker-bot@kernel.org>
Date: Thu, 21 Aug 2025 20:26:28 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Thu, 21 Aug 2025 07:27:35 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.17-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d72052ac09ceba6e49230ea9d7e37675d5bab789

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
