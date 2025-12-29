Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7326D10F1;
	Mon, 29 Dec 2025 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766966782; cv=none; b=XxgCvzygonyZwvcAfBiF4+0phUK0wykKfN47A1p0Dt2W61jvUw3UujuDXxeM9emdNAHIhTx883HkfPDLwOUIMXNEZ6/3ichs0RPuxANE+thYPBkDV8dg7YLTcTjwR1CvXU5NZnaL+ju5+o2BrDxYtaOgS5FVDoTweYXXKQL/2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766966782; c=relaxed/simple;
	bh=yB4T9TgPBvHSFJzKwDHARSGtAZDwmIwXnMDVi1mxyvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3MClvalkNWqX2QySeKr3firgtsjCFotXJCFOL36q8FwFbPbMkhOcDN/mgiJso4nicHpgJCHpYOwAcpvPyMNh2mj6nzqoFSJTwewlRueR/vMnJa5wE828BPxshY3G6YUeEkMZDZO5ixdQlYuSVPGpsaJeLXy7OXhcwwjjkFLzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K696OGOK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K696OGOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF63C4CEFB;
	Mon, 29 Dec 2025 00:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766966781;
	bh=yB4T9TgPBvHSFJzKwDHARSGtAZDwmIwXnMDVi1mxyvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K696OGOK/esCSI5ghFinQ2q5pK+mWOrgAlLtDn8ZSQ4YConhsEhYjiAcUMbVNEntN
	 nb75Fr8vYYxeTrKua4/5FX3AgdiGidvQkcCiTtUIRax1hTvSDv38y9cU3eca0ffl2W
	 gfAch4LdW06k4Bc9qbp/AZ92fptvvXXW++7yvoGQVoAIYJBu39hYwmiANm1GVrdusM
	 BHTN8On5rkfqXljV07dqla2IO0UjHHRq1dV1Ot+0FTQ2r9eNWandsmJHQiLQgkDqrQ
	 wtHZX9Mm8dkVShbiCsyiwxOZiQEsYeb7CjMdM4GwfRFrboPefreWb2dTlYd7c9mEwq
	 V62kQ96MqhAXA==
Date: Sun, 28 Dec 2025 14:06:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aVHF-72-6yRcFZ8x@slm.duckdns.org>
References: <20251219224450.2537941-1-arighi@nvidia.com>
 <20251219224450.2537941-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219224450.2537941-2-arighi@nvidia.com>

Sorry about the million replies. Pretty squirrel brained right now.

On Fri, Dec 19, 2025 at 11:43:14PM +0100, Andrea Righi wrote:
> @@ -1390,6 +1390,9 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
>  	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
>  
> +	/* Mark that ops.enqueue() is being called for this task */
> +	p->scx.flags |= SCX_TASK_OPS_ENQUEUED;

Is this guaranteed to be cleared after dispatch? ops_dequeue() is called
from dequeue_task_scx() and set_next_task_scx(). It looks like the call from
set_next_task_scx() may end up calling ops.dequeue() when the task starts
running, this seems mostly accidental.

- The BPF sched probably expects ops.dequeue() call immediately after
  dispatch rather than on the running transition. e.g. imagine a scenario
  where a BPF sched dispatches multiple tasks to a local DSQ. Wouldn't the
  expectation be that ops.dequeue() is called as soon as a task is
  dispatched into a local DSQ?

- If this depends on the ops_dequeue() call from set_next_task_scx(), it'd
  also be using the wrong DEQ flag - SCX_DEQ_CORE_SCHED_EXEC - for regular
  ops.dequeue() following a dispatch. That call there is that way only
  because ops_dequeue() didn't do anything when OPSS_NONE.

Thanks.

-- 
tejun
