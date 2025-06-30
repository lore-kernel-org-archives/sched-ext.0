Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EBC28DF44;
	Mon, 30 Jun 2025 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297884; cv=none; b=HQiBtMZLUCMYw8dX/ziEl7ocMRtBi6HnlhN7STGkCOT3e5eaP5Au0vOOMH+SITqoJMx9bQbnhPug/L8wqNGCk2rFuuJS+Q6NfOyZmesrNV6gCYovMlC7jZLSGtnQCR4R2LIpTxvo6v2oSBzN1ScYJVFrGi9/5wflLzor2Jbj4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297884; c=relaxed/simple;
	bh=HMcmWlT09oJe5l7dwNINAh+dpSD8QP6upCQz1eI/SFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei+54C2gwV/vVZiD7uOVdAerZrIg7V1o2Os4GKML0krXasBW9PMC+Vmozl9mDg19b+OqVMpPp32cC1/rtloivpuYagG+yAAJVK99jgC33M/Pv0Uvy6+EVMofDw1ZC1GInZyhHQzg/sjFqsuxyvoGCx4Dr6IjYISKk/gaSLazYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8SRLKb5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8SRLKb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44764C4CEE3;
	Mon, 30 Jun 2025 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751297884;
	bh=HMcmWlT09oJe5l7dwNINAh+dpSD8QP6upCQz1eI/SFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8SRLKb5XkyYdjhjjjX6Kp6jzBqOsuz4jQh9n5vmyZAb5kE14IDwOc8bwBWN49ULa
	 pkCqPZAMIZ/zsNLmkkpx/43DfQxWf5vT/2/nfTRk0gY4UbZV1WqrTjzWR0Xr6f4efl
	 eb7uDCkJvSTzGAgNDXWjWNeY9f1ORSt7JvpV8TbQeuZCczcWTPzkGiTMRdQf5SgNXp
	 NqixN9qnmYk1KmrTk4r00VtTRTUhSQgpBGbNHFQx16cwVjYfd/Z0lahblPRPBXGYrV
	 Ste9T9C/ajKCc4vtmP/Ja+OfiVQCtZWc92766TPXfYGqPvmVF8h5GYDXF0d5TclBW7
	 /tNayUI/L/Ggg==
Date: Mon, 30 Jun 2025 05:38:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH v5 08/14] sched/ext: Add a DL server for sched_ext tasks
Message-ID: <aGKvW08eOgK-RyQ3@slm.duckdns.org>
References: <20250620203234.3349930-1-joelagnelf@nvidia.com>
 <20250620203234.3349930-9-joelagnelf@nvidia.com>
 <aFnQ-3L6ixL7nSz0@slm.duckdns.org>
 <20250630151252.GA2443566@joelnvbox>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630151252.GA2443566@joelnvbox>

Hello, Joel.

On Mon, Jun 30, 2025 at 11:12:52AM -0400, Joel Fernandes wrote:
...
> > One thing that confuses me is that all that the patchset needs to do seems
> > to be adding @rf to dl_server_pick_f and that seems fine to me. Why is it
> > necessary to add @rf to sched_class->pick_task()?
> 
> Because ext_server_pick_task is called via DL's pick_task?
> 
> In deadline.c, pick_task_dl -> _pick_task_dl -> ext_server_pick_task

Ah, right, sorry about being so dense.

> This changes the signature of the pick_task_dl function, which in turn
> changes the signature of class->pick_task.
> 
> How about I pass NULL to pick_task_scx() from ext_server_pick_task(), and
> also annotate all functions where rf is unused, by naming the argument as
> rf_unused (except for DL), would that make it more clear that the rq lock
> should not be arbitrarily dropped just because rf was passed? And perhaps
> sprinkling some more code comments.

I think what bothers me is that this erases the distinction between
->balance() and ->pick_task(). However, I'm not sure the distinction means
anything anymore especially given the removal of !CONFIG_SMP paths. Looking
at the balance callsites, I think we can just fold each ->balance() into the
head of the corresponding ->pick_task(). Peter, what do you think?

Thanks.

-- 
tejun
