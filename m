Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110139;
	b=WhXprOIUoNw4//C6Fr5Hy+RTgfqiDwW33c1VeyzZ5+ofDB93MoCgwr3HnQRtAipGqB06
	 puHqcdLaYnroASUicL2jbRFMBi2htxaSvMHwn1vAQDjHJOXMBwEkoJWjQMkjZVUcF3wb+
	 ueSGEz0xIwivpEHRjoV4sBTF9w8NbqtF4eT2SsxruVDK6PaJ65NpYO96zyY9jyBJ5v5pU
	 DDVc9vywv7U1yWqVD4csbYqmclna2qZWuofzXYZ2tWbtnJDNiW6OqNUJpPZ9kscGoxk73
	 qllkE0ugAvHfS/7l5jWZ03XTLbwUvlHAD5xYzrvzyNtbyETak02fmoMDlCT2G6bxEzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110139;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=pOeRrVFg/5bk+KzOQ8SoDhqjJ4b9UoNqcA84ZgR/UAM=;
	b=GK7WFiaPdtpKNmZHrbwq3SsRMjUNoHo3DEnPIRs23aa+oLtTst4ecL+DQz0ayYyGwVoi
	 6qYT45FSQmhCUDC6P+JBTwedE0zFtLJZvxJHEPOLAD0kIKydx87qxsXlF32zkqtEIzW/3
	 JC1ndH52UyU6jLmeeNpqzpsmGa4gSGm5vQNCRzR5+UW185nQVxPz2GnGAw6s6z8pbHUn7
	 IrmO/nGYzjrAPrzYdWk0r7bQZnHJ2qSWPOYTtbHE3ABUXf/3PbyhEycWa60cm7RmeYaXu
	 /AdSzwOhPW35NWpR43PSOg9NAfLzf5bsvW576BC2vODhQQ1Fg9Ml1X73bJy9ba/o8WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dM0z+EmR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F85360A3808;
	Tue, 27 Oct 2026 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dM0z+EmR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9C01F01346;
	Tue, 27 Oct 2026 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110138;
	bh=pOeRrVFg/5bk+KzOQ8SoDhqjJ4b9UoNqcA84ZgR/UAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dM0z+EmRVdV4BZ+D3nyP2OM6+jSFyl11BxMbWRxkCxLTpV4Jg7T8VrQFDs2zMLkNS
	 nT0z7YQBTM1f+h4OMwqqSvxNqKslcqdBuIgwjcBfmGUZ+vH6bEzhaciGYe0y0u8jiB
	 gaH6jA2YYtsN+Tz0sQRS+rKZCobqCjxyqet2wewcMHzKsUBg+KaH0pyg7h2rLQMsP4
	 TSjd3pKafb+etnc/RXJ0gtY8dpvn20q+taZQJzogl9oztYu29g21/Tpe0PczwLhm8P
	 O8peJq8iJfySTjrQ9flPd6a4/1EsdLJy/hTEyA47Gv8rpR8MwLUIkRPF5SRfUz2E4t
	 VoEN8J8FYmJRA==
Date: Tue, 27 Oct 2026 04:08:58 -1000
Message-ID: <bfffa63097f862fb222158942b897d66@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 08/18] sched_ext: Fix a cpu idling with a runnable rescuee
In-Reply-To: <sashiko-outbox-185952@kernel.org>
References: <20261027001749.1821379-1-tj@kernel.org> <20261027001749.1821379-9-tj@kernel.org> <sashiko-outbox-185952@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello,

On Tue, Oct 27, 2026 at 12:34:25AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Can calling scx_rescue_keep() inside dispatch_one() restore prev->scx.slice
> prematurely when the pick is subsequently retried or aborted?
...
> Should the slice restoration via scx_rescue_keep() be deferred to the
> verdict == SCX_DSP_PREV && !p->scx.slice block in do_pick_task_scx(), with
> dispatch_one() only checking whether the rescuee can be kept (for example,
> scx_rescue_slice_remaining(rq) > 0 && !scx_bypassing(prev_sch, cpu))?

Neither case is wrong. The scheduler zeroing the slice only guarantees a
pass through the dispatch path. That pass happened, the scheduler had
nothing, and the rescuee got its slice back afterwards.

If something puts a task on the local DSQ while the rq lock is dropped,
whether it runs before or after the rescuee doesn't matter. A task that
can't wait on the local DSQ should have IMMED set, and dispatch already
schedules the IMMED reenqueue when it keeps prev. Without IMMED, there's
no guarantee about position on the local DSQ anyway. Left as is.

Thanks.

--
tejun
