Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E8D3E8341;
	Thu,  9 Jul 2026 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636122; cv=none; b=Pk+1+ZI7PLBWbmI3XHENDswqlC0/NQW0gCCZCvq4HSFr/q7nPQI0wk7G3da0z+QUv+2uk0rFi/1980HxyLDrWk5vbGQXE0Is11EafveA0YVff7iT0UNXQHcFUsxEuheyV7ayifP5qd1HLQu5Oe/7qwkbVxQ8jFxOwCa+2ziBTK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636122; c=relaxed/simple;
	bh=sICTue4JLDU2nxteJCgi3KpHmwsd/d3GdrmCA9EHWY8=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=DMQag9Ao0rOU332QAESIPE/aBBEX/7KOb69jn00lk8RgIDmb4xopFfE6UOHi5G6FgweNKQ5qRfZoHRcXYHkLNa1JcmMhIbSwvyftOGwWmblvwvy7FYRBFYGxU3NgvCfNQItavnEH/dy/JfMqZfxuatMYFrkxKTLQTcvyECetGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkXXUtJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkXXUtJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108761F00A3A;
	Thu,  9 Jul 2026 22:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636121;
	bh=CjHfnbUGe6l0TlqT8Ut7OKqJmnDCIe1oBdcS0zKSgZA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=kkXXUtJZpGrVgilURGEeP1pRG3/MiNU3Z6XYfvuiHJ1X7mUp2slIUA9uJRBayTm5x
	 D8HZhWQkVCdHFaVILfZC5CNjktnrB+3FDwXwqAOVZ4I/Mo5i0MOIjPb2sc2JJLty13
	 m6Z6pQvmjnvy9FbKGrTYmaAU5CirxomuyHuDbpmz9BXi+If2OBAj4YXNqJn2gcm6RB
	 oHFXSFonw9ZA6OtkuI+gtHjaEOGqaE7KEnFqiOJ3UFAvxgSeOubu8RzaMROOB/vZYe
	 hdykjdjRiNU+6Y2n2fOp1EB8/2vI5Hj0Ex1FLVo8Y186eZOVZAdBsPdQ+LKJF/tWK0
	 lHlqMRAx+gBaA==
Date: Thu, 09 Jul 2026 12:28:40 -1000
Message-ID: <608e1bf18fd49be9ba4b6ca7e38d0992@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708220327.7BA8B1F000E9@smtp.kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org> <20260708212429.3405787-24-tj@kernel.org> <20260708220327.7BA8B1F000E9@smtp.kernel.org>
Subject: Re: [PATCH v4 sched_ext/for-7.3 23/40] sched_ext: Maintain per-cpu effective cap copies for single-read checks
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, 08 Jul 2026 22:03:27 +0000, sashiko-bot@kernel.org wrote:
> - [High] Unconditional evaluation of `__scx_cpu_to_cid(cpu_of(rq))` and
> `scx_cid_to_shard[cid]` in `scx_process_sync_ecaps()` causes a kernel
> crash (NULL pointer dereference) during initialization failures.

The llist_empty() check is the first statement in the function - the cid
and shard evaluations sit behind it, and the teardown/discard path
doesn't call scx_process_sync_ecaps() at all. Same as the earlier
rounds:

  https://lore.kernel.org/r/56d90cebab023f01f11c54cb16acfae9@kernel.org

> - [High] Naked and unchecked use of the global `scx_root` pointer in
> `queue_sync_ecaps()` causes a NULL pointer dereference if the root
> scheduler is concurrently disabled.

The sub-cap kfuncs run under a function-wide guard(irqsave), which is an
RCU read section. Root disable runs drain_descendants() and then sets
dead + synchronize_rcu() before clearing scx_root, so an in-flight kfunc
can't observe the NULL and a later one bails at scx_prog_sched(). Passing
@sch instead would be wrong the other way - the kick drives the
root-owned balance_one() and wants root's bypass state.

Thanks.

-- 
tejun
