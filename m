Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792713815;
	b=ceB89FvRoGzBqKFa4XIJB7qEhTSWNpzT2yn5cf6wui/tdeFIhaiCkuBlJPgqTn1ktc3O
	 VBH/7wXC6Ka1+vUV4S2Djlmu7KqvrfVc22uNZeHv5tlxHUHJnO5kbSYN57nLDAfz4rOFP
	 6RP1Rf++PKZMVXr+AkGOsF0ZWJuTgHz2mvaWxFoXwxOz0juBQDdLSF9/a340QT+yETd8A
	 F6h6lOqLZRZO0wAQkpBiJH05Pfzu7gTn2OwqTIQ5fWTPC6QAoCKn/MfDjWzyfDv+dU5lt
	 N5dvS5bwiMjeiKPbGU7yi9Gqy0GW9wwPr/Y5P8brmOLu+GOdP6lw0zMqGioDyNLvxfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792713815;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=eotwNy/48Fx+F4lHsLBTBYOhX22WsMLeFBjdBsBjsW8=;
	b=GEJ57UBqd2KIweRV94kgpJnkZArbVTm2aXuCdVOus70oT9fBd8DTgRJ8r+Rd1lZONCI2
	 iRjJhu+39LIwE1I3Xh83b7dvLTpnrg083CkDou9PzXlJ3i23MhFCBscTNoE5e2uQRWotV
	 iVxxmq/qF97Le7nwdTn39ZHqJHpkPRya8HLwtJ3UzQ6ir3xjDmcEvx+En4606tzWWbglU
	 T6yPjzF2Gw2sbS4iR5i5m6X+Jf4B4McB7EZH0FVEIpE18PK3ND26PlRUo2JX2R/wP9nQ8
	 PDe9oU7xHKr85b31+YBJBIPiycp23dcr5GdcjSUgvjXMp5/1BXA4RMvT4YbOkPxywxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9M4YQpS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585E606A319;
	Fri, 23 Oct 2026 00:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9M4YQpS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DB21F01825;
	Fri, 23 Oct 2026 00:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792713815;
	bh=eotwNy/48Fx+F4lHsLBTBYOhX22WsMLeFBjdBsBjsW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T9M4YQpSeT/BhbTD+CUS06VLFW58kANkOr/LJVMuQevBID9/fY1tfNHEULnPdnzCf
	 1PEl6CddkpKWpOm6QKSHf9F81hY4YhgstBv2Fs94A3nqi7C4jYP+j9nHPu97RqwkM1
	 vdj4sB6ACq8DkgiCvzjKJIhXXqx/o7lWZ3Er+ypfL1L/RuXTE3x+tsrf6zukMLFX38
	 Rgp0ocDfRHTGat3eTIyjoe9tx5G1/dA9qYH4KSG1ThNF9dvXJQ6r9nmy7rt8u+2h6j
	 AYsDJZzG4deYSRgNLJ90dTNPFIfPor3ywx0JfE1Gg33ffozgRHrqEG6iM7ixUwTiwz
	 gEAKicb+1bHBQ==
Date: Thu, 22 Oct 2026 14:03:34 -1000
Message-ID: <9c649b0fa1c5d1593305e18b8bf8f23f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 14/14] sched_ext: Fix queued bypassed tasks stalling when the host loses SCX_CAP_BASE
In-Reply-To: <sashiko-outbox-182094@kernel.org>
References: <20261022213836.2259069-1-tj@kernel.org> <20261022213836.2259069-15-tj@kernel.org> <sashiko-outbox-182094@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello,

On Thu, Oct 22, 2026 at 10:04:04PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Can passing SCX_ENQ_REENQ from bypass_lb_reenq_home() to
> scx_do_enqueue_task() strand p off all DSQs when p->scx.reenq_cnt exceeds
> SCX_REENQ_MAX_REPEAT?

Same as on patch 3, this is intended. Going past the reenqueue limit
means that the scheduler malfunctioned, so it is aborted and its exit
path picks up the stranded task, as the comment above the check says.

Thanks.

--
tejun
