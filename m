Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443878;
	b=O3MGdE1OuByOkVwKpq1azpNkXvZWUITrKzO4XaCont6NxtupC7QE1qgBb2UOFU+hS10b
	 dydos4QNdimenvuR89nAR2TDUgCL1EwdV81ao1ZmNB4Ljlbkv4aT8CRAwbiKiUrHveqc6
	 M74baczKPVDpeKwDCwylhw2qlMmKjxwXLcXgFtTtIAHG/3qQf8KOPkdw8i8HeI0p+/C63
	 1DKwQ6fFt+QI5aZXmOuWIi49Yt9NYQ08/+3IndoF/sSriLwAbxLqAkRNPufIhcTc7NagX
	 1C6NnS9U6hEwAfySpUhlZqbKNqdau1Iy44Is6UhjaUewb3CXN80I3pylPI/iCfiQgdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443878;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=+0TSO0U7P40tdhEysF5XpTbrHUaLKqtMkInQxc1Q3IA=;
	b=mIzi7iwCaXw5SLevknxnRqNobUpxzmO7t9wWa2qWoXqWDcm3o2znlL+laFvIHvJPAexx
	 mKcSYTHUbiH50XM1UMb7H6UYlufINV8ieT5LbwiDMOgcOBiLNcvMA7okFpN2jzpsScDbb
	 qruMwKSWZsX4Top8u14XYGNt/x105fZ7rHNGTvT3Y/A8CFwlTOYsPxrfSBkeQUf/o3TgT
	 9bNgif213kmwfSznN5TkisLMriHSS1rKopJJrtY2zolNqQmzfr/+5/NAm33Sb5SANzrmo
	 pXopOXhqXzc1F3cOrIunH/Dznfzy9OI1Jx9fdpM66va6yPBDhfdvoi3mb1S+TVNQFUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIlNJ8DB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB33606A319;
	Mon, 19 Oct 2026 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIlNJ8DB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131FE1F000C4;
	Mon, 19 Oct 2026 21:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443877;
	bh=+0TSO0U7P40tdhEysF5XpTbrHUaLKqtMkInQxc1Q3IA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VIlNJ8DBWTc5eUxdvHvFNhOnjt2Ome2ZkTqpT5OxYdr6FW+GLDuyW7l/GegrBPk+w
	 ivHQldM7nEJuJlc0FoTzFk1pDWbHeAnoA9qcgJXoW4iTcYFuWwbmFt1cj26rbndJla
	 3y49l41bZV9A38kMGJZB6sjQQqs/HwBLMXhid6eQH5CcGtK4aNsDkSoCk+lOMwtV5N
	 HvC4SY9jbhC3SlnE0XDFejDKdE9MpzGPe7MSbeet+DT4KgvJxwY6OB27hQRJOzthpd
	 tTs02CSZWG3DSgLSEkBR0XAEtCn9LZCjeV42tL44FwCsSIvOrpLZeMgRUZjiEhulKs
	 jVo/6f2uZNc7Q==
Date: Mon, 19 Oct 2026 11:04:36 -1000
Message-ID: <ff1b8bf830af30639173e949e8c1be74@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v3 sched_ext/for-7.4] sched_ext: Report a sub-scheduler's ecaps on attach, detach and cpu hotplug
In-Reply-To: <20261018015952.1499528-1-tj@kernel.org>
References: <20261018015952.1499528-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

>  0001 sched_ext: Factor out cid_pshard()
>  0002 sched_ext: Free a sub-scheduler a grace period after discarding its ecaps syncs
>  0003 sched_ext: Report a sub-scheduler's ecaps on attach and detach
>  0004 sched_ext: Deliver ecaps only while the root has the cpu online
>  0005 sched_ext: Report the ecaps loss when a cpu goes offline
>  0006 sched_ext: Leave suspend and hibernation out of the ecaps reports

Applied 1-6 to sched_ext/for-7.4-fixes with the following changes:

- 5 is the update posted as a reply to the original.
- Added to all:

  Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
