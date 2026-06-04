Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694A233B96B;
	Thu,  4 Jun 2026 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601501; cv=none; b=dYHWN7vnLpl5GTvLx0f0HFojvqfOu00fOGl0ZnkfzAKaMUfUXeXzhu3Ybi/cw9m9VPT2U6bUevPqwueOvuc/qIMoTtv7ypvP5UxG2fUmgbN9sCzfIJHfUpKsFjtsa7/cGD65dvn68s79ayUqtEdFYv76ZYpHFb1oOSkT7pp9hgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601501; c=relaxed/simple;
	bh=gihuBS3BE2EofVukxwEQ2Xs79rd2iIJ9vNyxXH2fSTg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M8H+ruLrap/DNT7EujcRdi5lM6mky+T5DMyE8fG3ceX77PtVSl/FIvwm7A0OA/nkdIJQx0UeRo84xsVolcDH4PQy8L7Jsv8W0U1Bh/YS/hMFQOTiG1YQ+Wtt4VEnB7Y+9cppIDANcJh71o6RflTXXxeR64gERbx9cW7euJSV5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdWAYqpN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdWAYqpN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5F51F00893;
	Thu,  4 Jun 2026 19:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780601500;
	bh=bhT37UGkBEkCVeJogep8xES0Xv9XO3GvoAnOoBM0ZRE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=UdWAYqpNS7pzv/pPJGEKRllHHJQTKskzq4AroVQb/xGeA3hfwLbFcn83XqbKRxfng
	 YpD0CjBhSXDM5l5R3MS6xwNMHpbX4DdraLaoyzaJ17A6Fkw7xD8MPQnXrL/8cCY5X5
	 AUtO869KS6OfiWO8GVw0wq5GGbrxMOC5rJWXON8oXnYWsmafTVCbrZDvTnldo4bux5
	 /UjH2Jip2lSSgfFpkC0RktUvoVQcBf2A5KGUngiW0oKokx6xscplRSDWAKOFyQOOlR
	 s6b6YQB7I7UPJPaNe/pwQ/rCSP72Cf8Ld+R9PO5c9Cv9ke41qHSHUtZK9TBuhpOj7j
	 O4q4wl1XGg6hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B623930A18;
	Thu,  4 Jun 2026 19:31:42 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v7.1-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <eaed7efc3d9465b3986fd1ce89d7257a@kernel.org>
References: <eaed7efc3d9465b3986fd1ce89d7257a@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <eaed7efc3d9465b3986fd1ce89d7257a@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1-rc6-fixes
X-PR-Tracked-Commit-Id: 02e545c4297a26dbbc41df81b831e7f605bcd306
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac5c3716c699f7eb6f84fc7931fdf74f0b4ceaee
Message-Id: <178060150092.2990765.3929300213866715493.pr-tracker-bot@kernel.org>
Date: Thu, 04 Jun 2026 19:31:40 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The pull request you sent on Tue, 02 Jun 2026 12:47:38 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git tags/sched_ext-for-7.1-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac5c3716c699f7eb6f84fc7931fdf74f0b4ceaee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
