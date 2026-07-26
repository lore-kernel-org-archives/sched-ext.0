Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5BB350A18;
	Sun, 26 Jul 2026 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785095379; cv=none; b=FTWo47QYZ91KVU2p+pPjbwsuinls6HPqnlHDz9itLJ4jjzS+E5qyiD/W61C0C9uk/g/ADPCvOR6Vo9sA7UEN2eKaPWw8rOifTYfrMlcMcJyazOn4P6k4nOg7iy1o/clEP8ncQd7o5sssPkzH5u09wuTA2Zkn8y+CZ//PNTqdDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785095379; c=relaxed/simple;
	bh=QV2fluJ5GaMwnJrygeTfgGCWJmrYBOLFLeC9uz1WbBA=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=tHdZS4uQLuSu58CVWUWlgI2+Z1iFFQB7M/OoztenmGYPV5f6it8gdX1HFGviQuzrar27deGQ+P9nxK/wFv43YAPdyPB//D7LsFYgeZUCxG9Rf+dDJg/wbdl6d1KpQpRtdFGmhVllA6yVgu9Tykzohq80WUuCAsYepcArkLt2n9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVWIJK7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVWIJK7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEBD1F000E9;
	Sun, 26 Jul 2026 19:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785095378;
	bh=YpH0i1AO4qSPE9JUfKot00Bx8aEPcFOvLE3ErKxtKnU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=mVWIJK7rAS+h6FLl93DGFjxP0YgenYndkneEWqKS+H83j8FqMB4S1n5fETv20rdta
	 s+/Eo1X2DqqqUdvkzs/zQWLVcQLt+Ka60WaRnHOv5prdPCZm7AXOTGQyJAVYylTQLG
	 NeEdtWAQtrK09OiDGHAfVcVUgs44dqFgnnUhvN7rbltUT4qSRcAqn6YmApf+1XygLh
	 LCipT+DuwcgcfKaiBvgDeyDf3hyBi/xFtHo0h8p8NkkUT/q0vFV/c2YWrINcM4Kgs5
	 PkrW3zvckW0+Ehvn9eaYrsFe70Jvoxms6lRZN0hhCvMDc1RW5CAqLL6VzdlLYQwjSS
	 RBNDJMEQPUDVg==
Date: Sun, 26 Jul 2026 09:49:37 -1000
Message-ID: <d70a8f20c1773e0ade93b02272d96ab4@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
    Changwoo Min <changwoo@igalia.com>,
    sched-ext@lists.linux.dev,
    Emil Tsalapatis <emil@etsalapatis.com>,
    linux-kernel@vger.kernel.org
In-Reply-To: <amW3rqVgsXHBvj6u@gpd4>
References: <7f80005b54904a9a037822c2df5bcbc2@kernel.org>
    <2f7e89d4ee0ce10c24782ad35279a1bd@kernel.org>
    <amW3rqVgsXHBvj6u@gpd4>
Subject: Re: [PATCH v2 sched_ext/for-7.3] sched_ext: Bound per-task reenqueues and eject the owning scheduler
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Sun, Jul 26, 2026 at 09:30:54AM +0200, Andrea Righi wrote:
> > +	if (enq_flags & SCX_ENQ_REENQ) {
> > +		if (++p->scx.reenq_cnt > 1)
> > +			__scx_add_event(sch, SCX_EV_REENQ_REPEAT, 1);
>
> Should we consider only consecutive kernel-driven retry reenqueues here, rather
> than every reenqueue? IIUC, the paths we need to limit are SCX_TASK_REENQ_IMMED
> and SCX_TASK_REENQ_CAP.

I think triggering it on all reenqueues is fine. No matter what, if a task
is getting reenqueued hundreds of times without running, something is going
wrong.

> Should reenq_cnt also be cleared in scx_disable_task(), together with the other
> SCX-managed fields?
>
> Otherwise, the count can survive switching the task to another scheduling class,
> replacing the BPF scheduler, or rehoming it to another sub-scheduler and the
> next owner could then be ejected based on the reenqueues from to the previous
> owner.

Yeah, that makes sense. Updated in v3.

> Documentation/scheduler/sched-ext.rst still uses SCX_EV_REENQ_LOCAL_REPEAT in
> both the sample events output and the counter description.
>
> The description also says that the event is specific to local DSQ reenqueues,
> while SCX_EV_REENQ_REPEAT now covers reenqueues from all sources. Can you update
> those two references as well?

Updated in v3.

Thanks.

--
tejun
