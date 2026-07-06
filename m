Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3E2236E0
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381248; cv=none; b=UlUlvR0DbZphrcvRO7vKizohh0bhWIwKwSzL2JIOD49kMoNiww/rUehPEzFY6sphbqK+oTrhGj0kN/96Msfs6heCkpLjV8LKsHYBZNhjWoKAbn8Xh5UnN7KUBiAIk2QkPb7Hc6z/L6hNwpepmNWcoC3KKYBf+rRFI6hk7goYKSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381248; c=relaxed/simple;
	bh=IOk3YcAYxbBvH5v/+WRtA++HJCUToiN0hUslSb/aPz0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=aqRvo0TEfZEbC4OgGUxa9ROh06ioznC727fq7geubtioUP4795oglYvIahFtVPKMUB35BMu+rH9TeFyEb0WRYLFNBqRiAQ8Zg7WLUk7YE1YfbiP174XrbHZu8VkRs3P7E6tVHK/99r3HpnsewQfCm7TKZSnMYak9wNbxmIbR1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H66McSEg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H66McSEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF641F00A3A;
	Mon,  6 Jul 2026 23:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381247;
	bh=IOk3YcAYxbBvH5v/+WRtA++HJCUToiN0hUslSb/aPz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H66McSEgHo4KxosQ9fdKZ8ObFLTUkraPqvEY7rD4LdvjkvWn92H21LMm+6nXICoV9
	 wuHCdMZS18Zbqm9M3sUokUjj1GSUFAl4yOx6l0LXklDvOR3Y4sJMt0U6ZQyQGhi9sX
	 krFKOXrGhxzpxShLw0D+UJVTe5oDN3PBcHMbv9tz68Bx86sE7w7mTzCn/q8FGi0kHW
	 SidVIc4pz1KjruKqD3hAWlwF0cYN0eJM1VSSh5JluK0QMVoYj+Hko3d9+N3slfl29p
	 6f5AY1ZYLxOhJbCA2KZWyxaa0pWdZQTXQxafzkzi8/jo/E2wAEdFQ+1UTTkfuLhlkx
	 fWIk/e9NrM30g==
Date: Mon, 06 Jul 2026 13:40:46 -1000
Message-ID: <cc60dfec4917a5368f5dc677322c262c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 22/36] sched_ext: Add sub_ecaps_updated() effective-cap change notifier
In-Reply-To: <20260706020925.422B21F00A3A@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-23-tj@kernel.org> <20260706020925.422B21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 02:09:23 +0000, sashiko-bot wrote:
> - [Critical] Use-After-Free of `pcpu` in `scx_process_sync_ecaps` due to `rq_lock` being dropped

False positive. pcpu is freed via call_rcu(), and the balance_one() reader
runs with preemption disabled, which defers the grace period past the write,
so pcpu stays valid. This is the call_rcu deferral, not the synchronize_rcu
drain - same rebuttal as on the v1 thread.
