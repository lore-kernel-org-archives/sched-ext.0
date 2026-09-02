Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6A041D641;
	Wed,  2 Sep 2026 21:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385917; cv=none; b=QhSJI7YnOUEhpqTupMfna628aIieAJRXULFAGKLh+pfn6xeAoGBM+70CvZIer5Em0RrNWX+vlq17Hdl4gCTngHsCrvSC4kCnT10XCygqV3A9APGb7UhQVmrg46ViibSC24wCgzDtVAzvY97kb2kvH3n943nLKqjmdcBriFyBd3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385917; c=relaxed/simple;
	bh=BpUvdAQAWLwx2F1P1hN1OmYK0DudVAHX70QJRwmHzC0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Kj/Uyscd3VSnfbtWOCUDGMWWhNqh/f8sfCjFHIJf+7jakxFzVF7I9RGMKj/2b0prbwlnAh03W0EsRVuvONtuFw4fR56ao5Vwv58ytU9Pl8SnDYaVgkTdiFXY5erM+NYFNc0GHy3pld8kWIRaDwNo839o+BtwOOW++r3RR3EqJF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I60RpLU/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I60RpLU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7941F000E9;
	Wed,  2 Sep 2026 21:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788385911;
	bh=gMwWxSCSsHLA/FLNmWgqrHWxBQmknHVpMeD1Z0FRVCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I60RpLU/FxQK1cmF6UrVhe+XyB9WNfVljMUG/9cP4mCdRh+IDHBRc0G7fLVDukR4f
	 //rIhe7yYylTjKG/f173XRS/ahe5OJwK6kyDddPNY+5cuAau8GLZrc7BznGznhiwVf
	 a0IqmIkydvErJ16uHs+R7xA0x4IhuzaTTX9Kl8Bpx+fWTEN7vWZJ0m+wvjsWaJP/1c
	 Da0WPvoTMlYx5mNoVwlCsvF2gZf3CCOTBezb5G6un/0LYnIFVG4lFQEhC/wUPdCI9l
	 gfkcn+vedxC+RPp5+AYhyy6nFyCpOUOZCsCf1yv8sWvlbTV9oP6Ntb0eI2bFbY9ZJ2
	 8t4iCEVxjw1zQ==
Date: Wed, 02 Sep 2026 11:51:50 -1000
Message-ID: <d84b31727f04e1ed0d40042ba1c09e61@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: liwanwu <liwanwu@kylinos.cn>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Reject NMI calls to lock-taking kfuncs
In-Reply-To: <1d5f2636-a5e3-4b67-bbb9-12922fa0d804@kylinos.cn>
References: <3a9bfba228c46c69408fe1ef392e60f0@kernel.org>
 <20260902023124.1422942-1-liwanwu@kylinos.cn>
 <49faaba5039a29f38ab6f254da6fb8dc@kernel.org>
 <1d5f2636-a5e3-4b67-bbb9-12922fa0d804@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Wed, Sep 02, 2026 at 09:48:28PM +0800, liwanwu wrote:
> Three "any"-category kfuncs read scx_locked_rq() on their success path
> and treat a non-NULL return as "the rq lock is already held by me",
> which a false positive under NMI turns into either a data race or a
> wrong result:

Let's add the in_nmi() test to scx_locked_rq() so that it returns NULL from
NMI. That sends all three down their unlocked paths.

> pick_idle_cpu_from_online_nodes() (kernel/sched/ext/idle.c:151), which
> writes the per-CPU nodemask per_cpu_unvisited (idle.c:146) under only
> preempt_disable(). preempt_disable() does not mask NMIs, so an NMI that
> lands on a CPU whose interrupted context is mid-way through that loop
> clobbers the scratch nodemask the interrupted context is still
> iterating.

That probably needs to be irqsave'd. preempt_disable() doesn't mask IRQs
either and the idle kfuncs can be called from IRQ-enabled contexts. As for
NMI, if someone is calling pick_idle from NMI, they're asking for it. As
long as the machine doesn't crash, it doesn't matter.

Thanks.

-- 
tejun
