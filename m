Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23DF254B18;
	Sun, 10 May 2026 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778442098; cv=none; b=oKoF2gmQWpjz1jl9+zgpxCc9ofQHXQ3lHHT7l2NNsY3M+v6V6BXtTa6v7LU6hrQvipayO+SufoHPZDONQTQ1uaQ5prPzYHEskgkUPVZ9NtS5SSTSpbEUJDwQAbyzm/nabCt/+YsawZ4lZJcStHhzshlZfltkwCtFARDiKRJdKGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778442098; c=relaxed/simple;
	bh=tZbKd1Rhw4wF0lBNpJRa8Fko9Hp+UVutJQSGa1Z7vPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfSUjfOJ3BNacOJwtLsrdaCZUvcofGLWjQtgPkIhnFORxhO++IBYUzEKmJSM9+P8yjIdvl/qF8bKBanL8ZeeSi38pGYKwNIQBMVspfi85DOFh7eI4Osh7tys7LGwvoLEbRuit+REagHxyr6VIdmMa6CBEQ9ad56wSgfri7YWRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yyb45iIv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yyb45iIv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB7BC2BCB8;
	Sun, 10 May 2026 19:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778442098;
	bh=tZbKd1Rhw4wF0lBNpJRa8Fko9Hp+UVutJQSGa1Z7vPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yyb45iIvG8aXRhdD8nyBMZ6Y4VusliF7Hp3vK3Tp2XuMowp77gzrFg+yVOBaro0z7
	 pa+NV6khI/a7QwBw7MSXMwedjIkx3R2RV6ntf6N4bX3Yc2vRMlQ0geFtoZVXS86Jtv
	 Lp+MkIna+uC8FA8zrBIrEaQQU//hTkF4TQTnCDyGPySgnq3ixHjyfDbd1x+081LmaS
	 cLQyPgTFKrHUXImU82IznZNEaFYo37wLl1nzEKpJIAJzAlxPyQNSP9reFhcCmxSgQ6
	 XVASnW6R3j9GXpbPopXoY3ZtNNMiiSKA6bIVtkCqGHLCtno7JDn5bvpTG5TO9dVYgV
	 dnnE07fNEn/FA==
Date: Sun, 10 May 2026 09:41:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: void@manifault.com, changwoo@igalia.com, jstultz@google.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	christian.loehle@arm.com, kobak@nvidia.com, joelagnelf@nvidia.com,
	emil@etsalapatis.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH sched_ext/for-7.2 0/10] sched: Make proxy execution
 compatible with sched_ext
Message-ID: <agDfcbbe3-Za15CB@slm.duckdns.org>
References: <20260506174639.535232-1-arighi@nvidia.com>
 <20260509010059.345908-1-tj@kernel.org>
 <agCfAY9zqrQiKAJ4@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agCfAY9zqrQiKAJ4@gpd4>

Hello,

I'll think more on enabling proxy execution as-is for sched_ext. Reponse on
scx_bpf_dsq_move():

On Sun, May 10, 2026 at 05:06:41PM +0200, Andrea Righi wrote:
...
> Let's say we expose blocked_on (and a kfunc returning the mutex owner) via
> tagged ops.quiescent/runnable(). The BPF scheduler now wants to boost the owner.
> What's the actual way to do so? Some mechanisms that we have right now:
>  - slice extension: scx_bpf_task_set_slice() works in place, but it affects
>    only a running owner,
>  - dsq_vtime: scx_bpf_task_set_dsq_vtime() updates the value, but for a task
>    already enqueued in a PRIQ DSQ the position in the rbtree doesn't move, so
>    this doesn't actually boost an already-queued owner.
>  - DSQ move: scx_bpf_dsq_move() requires an iterator and the task to have been
>    queued before iteration started. We don't have a kfunc today that takes a
>    task pointer and atomically yanks it from wherever it is to a higher-priority
>    DSQ. We also have no API exposing which DSQ a task is currently sitting in.

Assuming ->blocked_on() is triggered without rq lock held (if not, we just
need to tell scx_bpf_dsq_move() that it can do lock dancing in this context
too), we should already be able to move the task directly:

p->scx.dsq->id should already be accessible through BPF_CORE_READ(). Maybe
we can make it a bit nicer.

scx_bpf_dsq_move() doesn't actually need the task to come from iteration.
It's a bit odd but we're overloading the iterator for two purposes -
iteration and transaction scope definition. If a task is dequeued and
reenqueued after iteration is opened, scx_bpf_dsq_move() ignores the move as
the visit is considered stale. scx_bpf_dsq_move() only depends on this part.
The following is an excerpt from the function comment:

 * For the transfer to be successful, @p must still be on the DSQ and have been
 * queued before the DSQ iteration started. This function doesn't care whether
 * @p was obtained from the DSQ iteration. @p just has to be on the DSQ and have
 * been queued before the iteration started.

So, for an example, ->blocked_on() can do:

  void my_sched_blocked_on(struct task_struct *p, struct task_struct *blocker)
  {
          u64 dsq_id = BPF_CORE_READ(p, scx.dsq, id);
          struct bpf_iter_scx_dsq it;

          if (!bpf_iter_scx_dsq_new(&it, dsq_id, 0)) {
                  scx_bpf_dsq_move(&it, p, SCX_DSQ_LOCAL_ON | WHATEVER_CPU_WE_PICK,
                                   SCX_ENQ_PREEMPT);
                  bpf_iter_scx_dsq_destroy(&it);
          }
  }

This is not the prettiest but the above should do all that's needed and
nothing else. It just looks up the dsq and remembers the insert sequence. No
actual iteration happens. Again, it'd be trivial to add BPF helpers or extra
kfuncs to make this nicer.

Thanks.

-- 
tejun
