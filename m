Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412087;
	b=xDoR5UQ19Y7g9FF3Dk4TWePBllHe1uhkPOrt8gLKZC1zWLbOrQI0tLtLs2IIiw33iFjP
	 WC37kIuNLIsTvmYIe3AKoqPXgYNClfPeEbEDTKEkUThL34ZyW61nJu/zITo6jDFpatJvG
	 OC2dtam4yPGvKTsNf5EvtbTWIA0wLtiUjlfOcXtJpGQCcFS4YY4nFkLWoaXb2lJnGDySI
	 evQNUUObaACr0ERtwn8NGJEAg9pFJu+Q1Y53e2CEyctiSEE22wGrjpjEy3qEK3v+xf9kQ
	 YOWlp+hLbmDlRN5vM2gcoQjr4fesfDy+z7cZcgeLz9DY7jUbREQjl+pjwTMr2uOMXfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412087;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=em7DGCYkO12JE9R0yr0/s0ivPemk6VrLk7QpWMg0SAQ=;
	b=0Wn3XGSdkpzjarHGgsKSIOGnzUG4/r9VEZ2RSOxfthmvWoavPfa+Ar5eHyI5F33BBHfT
	 FV7bpFWa0b3oSe2fsmk6jvWCF1uAqVGRhaNULKJoR2ArfBwjactUpkCZuD7NsGsM0Ta0l
	 t+OTkY3M7yey6ZudMalGPWyVf7nm/LGJqlZPAbpMAicRaceKTc+ixvpv+9Xcyl4cpiYOy
	 UmWtR/ShrgerpJ0U8lTv507wfOLJRpVuO8HDPQvfTaxX2i0e5xWEKXpWII0cOGAyujDxl
	 yHUWZLXeTiWk4W7XpEfb07v7TlqTwIvCel4LkWuRxm8w0biwzLoC0LpUYnVkCLvyTwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yz7AH1UG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FE606A31A;
	Sat, 31 Oct 2026 02:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yz7AH1UG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F88B1F000C1;
	Sat, 31 Oct 2026 02:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793412086;
	bh=em7DGCYkO12JE9R0yr0/s0ivPemk6VrLk7QpWMg0SAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yz7AH1UGktp4C9D1MALcIK0RMX3uBxMWxysbsD5n5h1FT4mG51tKj5mezJA/lG6ZU
	 FIg4cmvcJvPUzk8R1DErfdPbZtasrbOBatYEpwtytI0hJPHCrMNyZ9KWWiR9aR1VpJ
	 suBWyYGOkwage0LvfoAjHSmC6PD1ko0eO/l3hbWySm6auRqjdik+qdzCdSnXtSsIGK
	 9LC6UfZKZcIIc34cxd1sR9qRDysPqGB2/HxZF+4MOqum5AB3kJfIrnnzuVG7cV/YZY
	 nEMul68CqOu6xATn6e5IMWuU0JwD01KQbXSP3oU5iXcBPBNjmRhouW2hdC8miiEDIz
	 b1wtFKBFhjGlw==
Date: Fri, 30 Oct 2026 16:01:25 -1000
Message-ID: <4b5da2afa4e6c55c4cd809c1b4cef4c1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, sched-ext@lists.linux.dev, Andrea Righi <arighi@nvidia.com>
Subject: Re: [PATCH v2 sched_ext/for-7.4-fixes] sched_ext: Fix stale pick when a wakeup resets the donor during dispatch
In-Reply-To: <sashiko-outbox-191676@kernel.org>
References: <20261030235728.4098872-1-tj@kernel.org> <sashiko-outbox-191676@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

On Sat, Oct 31, 2026 at 12:29:44AM +0000, sashiko-bot@kernel.org wrote:
> - [High] sched_ext: unguarded keep-prev check in scx_dispatch_sched()

Fixed in v3, which also tests for a stale @prev there:

  https://lore.kernel.org/r/20261031015414.219280-1-tj@kernel.org

> - [Medium] sched_ext: premature cpu_acquire() before stale donor check in dispatch_one()

ops.cpu_acquire() is deprecated, so this doesn't matter.

> - [Medium] sched: stale rq->dl_server across RETRY_TASK in __pick_next_task()

That's a core sched bug independent of this patch. Reported separately:

  https://lore.kernel.org/r/6db076ee2562b5fb84d70ed59abe670e@kernel.org

Thanks.

--
tejun
