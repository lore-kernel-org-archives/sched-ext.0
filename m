Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128265;
	b=b17x+X6x+D6OHWyJI6h+3oICrvjd3QfhjMU6h2oaD6vGpMbhKTKcPPD+gOb8+xdkacm4
	 9/nXfG9lRGSbAQ4dw5QYwQtmlsnLakdTUOy1FBoFHo8Mldf2yvcoRgDblGX95QwxZMvPO
	 B4pbT+3VfTSbHqyBoIL1Rk+wmUteVZq6nJq/868ECQ6b1Za7Ll6gyTAfGWV//RAbnKRM4
	 CVoghOmX4uoSkn6qbuYhprQgb8OTZHVXyHXHsfB97L6LT7MIe9Mr4XKsU9BKef2LjDJ2C
	 RSQ8c2SHOFLSYJWvcpo4q803D2WTv7Rxv9Lm8MU4sesOlX/m4UtUVcr+jliIvue1VqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128265;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=Cfw4lyW0LwTD4wWWe0MpUwUKGHF+RZvass3mdfbxY5I=;
	b=tGU1zm8MUPXjRawHhGYAX0JmxAbyYkvsfMxiJwYdWcoz1Ix2dXOesziaFEabDFdHl6zB
	 EvwNr851p1OBi5VUpzZYLtSwpz5ElzVOd5ES6+ARsYmMzvaDrFSnBGHob2iDXlBJ97afW
	 cfDWucfg1J6N8fgtFhsg6st3mvSoRqCnHKfCTAOob0+4d84dr9zrHYgbkNcYsgkvCURA4
	 ybWX3h7s9Bc9JSAi7uU8Da20eaboQmqz2Ua5eF1odDVOod+PCpHaE5SX+0+2phBplrp15
	 ktpJFT0/FkedhxhaU/+K/TGWYdfUSMhe8ywVZ3zT/XEBuD0cghUM4gxBh1abukUyN2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sba7QTpP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952D606A324;
	Tue, 27 Oct 2026 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sba7QTpP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4191F031E0;
	Tue, 27 Oct 2026 19:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793128264;
	bh=Cfw4lyW0LwTD4wWWe0MpUwUKGHF+RZvass3mdfbxY5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Sba7QTpPcIptW9oG+ZOrUw3UK7guOJtVgbivYJzXpiku1I4sYwiUxDCvcK0CBHEHD
	 DIpvxkokbkiqgbOTAjkKw1l1hyQvydwDqwbP3WoymQKCERT/fT+4a9PoQQ6dKKwg0T
	 SrEvWyd/PiHEKYgauGoLQ9svNlXmcAkX4MyhDHWqAfi+s8X3tqqrEGwdbzaxcxjLZG
	 1t90nc3e9bPMaTtN8XGfYMy9YLM0pGNNHiF5myo+G7Spr8iEmdVfVVn91y7Xw+3FZ5
	 /BVBPTiqDR4DYJhNEqSxZLEKpIhBYbz+SaZ0fhhKmWI+GdbfYaT4MurI+x5sK5Xk3l
	 4nSXCPJBlmAxg==
Date: Tue, 27 Oct 2026 09:11:03 -1000
Message-ID: <9a0e9d3a07dd7661052a167309a42e8a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org, sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCHSET v4 sched_ext/for-7.4-fixes] sched_ext: Fix bypassed sub-scheduler tasks stalling when the host lacks caps
In-Reply-To: <20261027001749.1821379-1-tj@kernel.org>
References: <20261027001749.1821379-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

>  0001 sched_ext: Pack scx_ent_flags' multi-bit fields at the top
>  0002 sched_ext: Clear holding_cpu where the claim is confirmed
>  0003 sched_ext: Fix bypassed tasks stranded by the reenqueue limit
>  0004 sched_ext: Fix bypassed tasks looping on a host without SCX_CAP_ENQ
>  0005 sched_ext: Move refill_task_slice_dfl() below apply_slice_vtime()
>  0006 sched_ext: Fix rescue served time disagreeing with the slice under proxy execution
>  0007 sched_ext: Restore a rescuee's slice after ops.stopping()
>  0008 sched_ext: Fix a cpu idling with a runnable rescuee
>  0009 sched_ext: Mark the rescue grant as a kernel slice with SCX_TASK_KERNEL_SLICE
>  0010 sched_ext: Refuse extending a kernel slice
>  0011 sched_ext: Fix a cpu idling after put_prev_task_scx() queues its task on the local DSQ
>  0012 sched_ext: Expire prev's slice in dispatch_one() under bypass
>  0013 sched_ext: Fix bypassed tasks stalling when the host lacks SCX_CAP_BASE
>  0014 sched_ext: Fix the bypass load balancer stranding tasks on cpus where the host lacks SCX_CAP_BASE
>  0015 sched_ext: Factor out bypass_lb_move() and insert with the donor DSQ unlocked
>  0016 sched_ext: Let the bypass load balancer move tasks homed on other cpus
>  0017 sched_ext: Fix queued bypassed tasks stalling when the host loses SCX_CAP_BASE
>  0018 sched_ext: Fix a lone IMMED task waiting behind a kept prev

Applied 1-18, 19/18 and 20/18 to sched_ext/for-7.4-fixes.

Thanks.

--
tejun
