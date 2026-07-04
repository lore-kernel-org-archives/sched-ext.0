Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791192CCC5
	for <sched-ext@lists.linux.dev>; Sat,  4 Jul 2026 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126475; cv=none; b=MwwYkXY2n4FEgR/JFW9SlRXToK3yTuMc8+GDZQPZIShSPSyIsmVgR4/6xLaDW+Y1KtNMTrFgJVYiZU1pbym/v2zFZ9ObyhRixs6a9LPpYOdUG3qm1a4svlm9mhQpwgMMjE3Uu3erghYPtBi05zskizNZGCJ4KrSsNE6mJlx57/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126475; c=relaxed/simple;
	bh=20xMBJu1uT6YuHRV7F+CaNPQRc2qM5aWFprV+XzH/3E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=GNBVX6FwwThb1Nytz0IyA475uX6aZi0x/crNC2Ln8q7pL9ondjQcbRXEUZHCsOZNVbEKxrqPozteHNY2aj3kwXypmq0lv2JWlyKqVj8CTBs6tWIyLEeYrqAhp1QnzDYjk9zp4WI2Z3saIUiArwiVNKam9kdM3MWKEbpJ9EwLqm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GO/s1ODm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GO/s1ODm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BFB1F00A3A;
	Sat,  4 Jul 2026 00:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126474;
	bh=20xMBJu1uT6YuHRV7F+CaNPQRc2qM5aWFprV+XzH/3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GO/s1ODmF/3Il4nodbbWvAl0z943znYTvVqxUwCISZ11zOc+OgUYu+S16bV7QXwRT
	 C59W6SA0FypHDY8kLkr5lNWRaeN1jCaPjgiLcoWUyb6NGQbdMwXHTrOOi+LNMrfKcZ
	 zejGXrHoypDPnSP8oNYkD9UtoCt1ZNTk6QWjHWHAZ9acLNMIx5D2opwhjAN6eM4WX+
	 xdxLGsilc0bpv0NDn5yICLhi27uBlyHQg8e4xKoebkDODtIEaEgcI2FJLPDaNL4dHl
	 hsxjRO4+AFHHQtpMsfLssNiPfrKuKGFJ+Cu3kpAcmVRaH3zHq8N4lKGvXox0uEj/Uw
	 PSKSAUt1P14Bg==
Date: Fri, 03 Jul 2026 14:54:33 -1000
Message-ID: <a4e4bc3a3da89d7661b8051b9a9aec32@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3 27/32] sched_ext: Gate kicks on SCX_CAP_BASE and preemption on SCX_CAP_PREEMPT
In-Reply-To: <20260703140130.B75C11F00A3A@smtp.kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org> <20260703080159.2314350-28-tj@kernel.org> <20260703140130.B75C11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> [High] Inconsistent capability enforcement when a sub-scheduler
> dispatches a descendant's task to a local DSQ using SCX_ENQ_PREEMPT.

The consume path already authorizes against the scheduling sched, but
you're right the remote re-activation (move_remote_task_to_local_dsq()
-> enqueue_task_scx()) reconstructs the task owner and loses the
placer. v2 will carry the scheduling sched across the activate_task()
boundary (a per-rq stash alongside extra_enq_flags) and authorize the
insert against it.

Thanks.
