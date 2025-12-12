Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7302BCF5;
	Fri, 12 Dec 2025 01:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765503246; cv=none; b=UG1r8YjoKjb7E0xQ4Wt1ri3F+5X5xkCwGy8B8H0aykwCJ/5NnQIUO4lA8wvm1kEj371LRKxjtc1z61W416C8fh372ObmME9JuCIQn/DjeRqkDRlY0MGUW+Kejz7O1pnhQjPvkvo07huK24BOpclmOC1zus+f3sycER0R1FboNGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765503246; c=relaxed/simple;
	bh=CK/1Q8HMdsbQp32kTF4C+p1ivYADrNGxq9HZZZbgT3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2XXZsEEvfaGigE6MFNfJiVGVW+jLh7ZYZm8MALBgDkcyhFf585gkO/MsGB6t13coflN84ivtykiMVhNKtRUJsEk/s6FIKuCdJzX2rjrYP3m1xPwSkQ4nNbjN2NlJwqAZ0Oavf+bWDwPmJp6Hy0BXBqYGE4Cex/n6tc3irm5yPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asCPHV2A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asCPHV2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888CFC113D0;
	Fri, 12 Dec 2025 01:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765503245;
	bh=CK/1Q8HMdsbQp32kTF4C+p1ivYADrNGxq9HZZZbgT3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asCPHV2Amjdr6+Sc+eeMrHpwD8SitwGNVaTSHtml9tuueb+qpDij4peUW8sE6djI1
	 ukUPMIwBTStUTyHMbBmbuHjpENh7oJe1ZmCk2ooPIoU8FmJFqNRbtDl9/pDOY1u9Nt
	 MXMBICncAOlP+jUqt/a2GJcXiX6IjNnYCNKBsYbL5Pn5njsR8dgVUB5m/wIrU3RaE2
	 cfGGdCP8jpdU2EgnPnsWFAEt8EVB/NagMsYJU9pVVItYJFxgRk46dLkVXt70SPpgzv
	 17vk8pGK8skuf11d5LKQXgjgqjsXO4lEgFmtV+s4ewYr1hiMk+KaoES0h3oOUF/tVo
	 GMFzT5ZVBO/MA==
Date: Thu, 11 Dec 2025 15:34:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 2/2] sched_ext: Fix missing post-enqueue handling in
 move_local_task_to_local_dsq()
Message-ID: <aTtxDOZ2nehjFwbL@slm.duckdns.org>
References: <20251211224809.3383633-1-tj@kernel.org>
 <20251211224809.3383633-3-tj@kernel.org>
 <b53f8ef6-9cac-4b95-8ebb-0f498d02f4ac@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b53f8ef6-9cac-4b95-8ebb-0f498d02f4ac@arm.com>

On Thu, Dec 11, 2025 at 11:35:17PM +0000, Christian Loehle wrote:
> On 12/11/25 22:48, Tejun Heo wrote:
> > move_local_task_to_local_dsq() is used when moving a task from a non-local
> > DSQ to a local DSQ on the same CPU. It directly manipulates the local DSQ
> > without going through dispatch_enqueue() and was missing the post-enqueue
> > handling that triggers preemption when SCX_ENQ_PREEMPT is set or the
> > enqueued task should preempt a lower priority task.
> > 
> > This was fine when the function was only used from consume_dispatch_q()
> > where the CPU is already vacant and looking for the next task. However, the
> > function is now also used by move_task_between_dsqs() which backs
> > scx_bpf_dsq_move() which may be called while the CPU is busy.
> 
> When was this changed? I couldn't find the commit when looking briefly :/

4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()")
which was v6.12, so upstream history-wise, the above paragraph isn't
accurate. It was broken from get-go. Will update the commit message. I'm
split on whether I should tag stable for it given that the usage pattern
isn't very common and there's some risk in the behavior change. Hmm... might
as well.

Thanks.

-- 
tejun
