Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C334DCE0;
	Thu,  7 May 2026 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191381; cv=none; b=dyTGACGpHeM6vUK4RJh3JQiuQNQIKY02d+uh4KwR1HXBjXVEQaz10kLbAKvDaJfpUBuSdKXSUkEElPKZSZYHoyppopw99I9Ux0hF08PK5NkV9UbuwYa+vc0mGkr5GwQ90PthO65MOnQYMDhuSqBzKyswQSz3VdwLyEODORYFdhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191381; c=relaxed/simple;
	bh=OlIylZ3PFkT6PKw21RrpSyJL2XV3B1/g7fU+cAHqgZw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=DShh84iRSBFLG9gNGD90k5OCaavTX7EM1tqaRkgSDWj+qe+NOQ7wzhqqugi5SMpVaMpQxt9A8Ct1PP6xG0ZLclhTMB1s9SgHrltfVvF5piJeDLmoBzHVVGP4KDhJJWyc0NglfCPu2IsZc6dmulubPqNyYAxGug52TCfDWzG+ejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5ajY7M7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5ajY7M7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5635C2BCB2;
	Thu,  7 May 2026 22:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778191380;
	bh=OlIylZ3PFkT6PKw21RrpSyJL2XV3B1/g7fU+cAHqgZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I5ajY7M7cDRy9wfOUdVNPmAw1/7q9kRtvAplUvGfhu5rZnnRLbTfu9wUO+Lxnoxj2
	 Z+iWbd86RoKloLdLhIi001mDXn3ZKziusDV/inswguM/x2efYDphfQoSAKNIvy9w8r
	 7yllifiMFjqWCykiXvKpdj9iUmS4NTyLcKHIMCxcnOoBLYJAnprvQlIpR4x67huZDW
	 CtxZQiTTNfDbL9GYWYEwd6JXP0UeXSbd15kCjayH1z4yIj7GH2Re0faasVXuuSMiYt
	 hkRr49p2EeFV7Yvg/yy5aO3fk0IEdH5ERgH+v91an9DcyVqt7dM31zr2Zq+XJuJugU
	 c30rT3cTo74cw==
Date: Thu, 07 May 2026 12:02:59 -1000
Message-ID: <8d1c14c1e178cc57c439869b986cdf24@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Wen Jobs <wenxiaolong123@gmail.com>,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Subject: Re: [PATCH] sched: Fix typos in comments
In-Reply-To: <20260507024940.2739-1-wenxiaolong123@gmail.com>
References: <20260507024940.2739-1-wenxiaolong123@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

For the kernel/sched/ext.c bits:

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

--
tejun
