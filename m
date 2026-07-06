Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347E3C455F
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381247; cv=none; b=SU+9lywE1/AU0+na0UdQnSPfQPD65RD2QzEL3aAHfHC+D/atZZXJlYGdNltDBYNjRqoGEdOwZHOQjssQ4rMGjMOxj0YfckjUD9CScyLs+8yKHmd29Y79Wqp2y7NdF0MXoYT1yiZjWRj8xYNQqVdmWyJpid2XbEmw+uPsBNjp0Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381247; c=relaxed/simple;
	bh=dSWJjOhtqbm/+atXQtTfCA6m55tAUZITjPx9llwEBBs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=iguBxGN0LMO3WXftDkSvg1kM5yW3lbDMqp2JnzvSlkRDV5b54/7AwWFg+eO18nJ82FWiifAWBF48pSQRcfXZaAUgIaTZe0AgDVxland0H6QiqNWrwyhlRuDkPn6VnUNlo/ietSgB6qrZbkbLKfXQs91Ub7fr5yoUoVBxOETs6tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgDR46mw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgDR46mw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63621F000E9;
	Mon,  6 Jul 2026 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381246;
	bh=dSWJjOhtqbm/+atXQtTfCA6m55tAUZITjPx9llwEBBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TgDR46mw2DH0BoI+iFEO0nUxRUpdbs06zs2xvDo3k2PYTfl4lE4Z6UlukzVJHDqDW
	 9r/Q7asIcWXCWGFDuy7gDnT6tBqn9LikIrP/AdsphbdGh9g/JgcY5mWcJ9rgYBT5AA
	 FhdvY+nq4sV5Y8Tmdw15SvAap0f9r6z8VY5fS40yE9AVEJBUg3RQSHsXivq5vfw2pV
	 ksmf3cOETEBG4pHOx7BSBA0a31JQMggkVD6d2xz5Z1JsTyTI3DhkBWSu2D1OXfUR0F
	 FhQkbULplTcG8idTc8ZRz8te3o4ki5Jal/LlQ5AadFwJeSzRwL6jBBi8pP3KA439hD
	 5tbuSG62sABxA==
Date: Mon, 06 Jul 2026 13:40:45 -1000
Message-ID: <24f272c542021d564cdc6ebd063765bd@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 21/36] sched_ext: Maintain per-cpu effective cap copies for single-read checks
In-Reply-To: <20260706020759.4A2101F000E9@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-22-tj@kernel.org> <20260706020759.4A2101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 02:07:58 +0000, sashiko-bot wrote:
> - [High] Asynchronous processing of `ecaps_to_sync` races with a new scheduler's `scx_cid_init()`, causing slab out-of-bounds reads in `scx_process_sync_ecaps()`.
> - [High] `queue_sync_ecaps()` causes a NULL pointer dereference by passing the global `scx_root` pointer to `scx_kick_cpu()` during scheduler teardown.

Both false positives. 21-1: the cid read is gated by an llist_empty()
check and the sync is pre-drained under cpus_read_lock, so cid == -1 can't
index the array. 21-2: scx_root is cleared only after drain + cid-type disable
+ synchronize_rcu(), and these kfuncs run under guard(irqsave), so scx_root is
non-NULL when they run.
