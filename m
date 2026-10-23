Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792713813;
	b=eVue9Hp0WBjuU3IMvWe8NZeFnsrhWkxPamZtd5DV/CQ6qPWugHUhI6GKrarWneFRgnAN
	 366yU98mlz+KDc2iYkpaXQdvooDxHab+Q72ne3pLW/BVPEV8DvT5ef9K5iMMyxjbdGBBV
	 fvATAyU1h4KYn6KQ4dTBorAhR0GSywgO8JTfEYcCSGTGqauk+an0H/WGdORlR37hpIbY7
	 YvIzTcu0wQ+jykY/IqzkYGTFSfTDcJ1AcoGEpfIAGKOpQMZFmCuSzObNgAZ66fic8hSIE
	 Nmte0OppnH1S1K1VKcWBOgOBIIgkI8+CASQOxwVXj2DJjVrWvjjsx8PXVrDesqJWjyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792713813;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=aPRjem8YjBwr4ZE6+eDk5JZGbq0V9A9/6F858J8yDSE=;
	b=2qQb3Ko1mKMOtApxQ97klMHz18bpIkG3Y5HlCBVSSPN5wdXgQ8PlpyhSC/aPFNxuWe4l
	 DmtaTk2lHQoEomlg5m36Dhv2oJl+OLRLGPwl74+zoBB20IPZ4JSxfDEkrVuw1TRfIOiQ7
	 AWyDsl8QbB0KHZJejSjajttNDtDF3/cgRwOhXXnI6xA9oVlPZ46c1RPe3CPnb3u8FoH3D
	 OQ+JazbdvHNK9/NnSCnfumgnvyZ/zZCBTezZRe/tnHvNHelZMRfJE994kKYLG7AwXGacz
	 DL7fOoF1K/lTO/x7+XkoitorykTGzzyjkTh5qobyHEem0dX5tLAjAtuxyaykPzn8AaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFHlb1Sc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B9606A319;
	Fri, 23 Oct 2026 00:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFHlb1Sc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B791F01825;
	Fri, 23 Oct 2026 00:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792713812;
	bh=aPRjem8YjBwr4ZE6+eDk5JZGbq0V9A9/6F858J8yDSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fFHlb1Sc9z0+E2j84iuomW6Wk9HFLN+w0PqBsOTu4zZAlwacbT/d9awL+5EL57UYj
	 F4Tsm7jc9vN1kGhHv3+kH4clPGoS3yBVV/TV+jMEDHSASNDH6U0oXyxPIYT2+H8JkJ
	 493owNVgC2c2dGEOdhugsHBIZYGnDXgv8OkokC2py+c7W3c6ivB6AmtZHndI6bMWtD
	 ldIvI1qhxatnXIscknV1R8hQyaS0OGFUxgvE0O7ErZd3rM2v6jeIaitXyn5zJVrprl
	 XKflYvurWnik3q/ITfPdABkvloETFaRTpjXZbUb3QSxBX5+Z/fR/pPhBMZ+Gwfwu/7
	 cZh4cLuDs2Ahw==
Date: Thu, 22 Oct 2026 14:03:30 -1000
Message-ID: <0175dddf51ce08b935d923931f811e5e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 03/14] sched_ext: Fix bypassed tasks looping on a host without SCX_CAP_ENQ
In-Reply-To: <sashiko-outbox-182095@kernel.org>
References: <20261022213836.2259069-1-tj@kernel.org> <20261022213836.2259069-4-tj@kernel.org> <sashiko-outbox-182095@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello,

On Thu, Oct 22, 2026 at 10:04:10PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Can consuming bypassed tasks with SCX_ENQ_IMMED here cause a bypassed task to
> be stranded off all dispatch queues in scx_do_enqueue_task() when it gets
> reenqueued from the local DSQ?

That's intended. A task going past SCX_REENQ_MAX_REPEAT means that the
scheduler malfunctioned, so it is aborted and the task is stranded until
the abort's exit path picks it up, as the comment above the check says.
The exit path re-enqueues every task of the aborted scheduler and
scx_disable_task() resets reenq_cnt on the way out.

> [Severity: Medium]
> What happens if a child host holding only SCX_CAP_ENQ_IMMED consumes a single
> bypassed task with SCX_ENQ_IMMED during scx_bpf_sub_dispatch() while
> rq->scx.local_dsq is empty, and the parent scheduler's ops.dispatch() also
> extends prev->scx.slice?

A parent which asks a child to dispatch and then extends prev is
misbehaving. That said, there is a way to get there without the parent
extending anything. dispatch_one() declines a bypassing prev but the
test in scx_dispatch_sched() after ops.dispatch() keeps it on the same
slice. The next version expires a bypassing prev's slice in
dispatch_one(), which closes that path.

Thanks.

--
tejun
