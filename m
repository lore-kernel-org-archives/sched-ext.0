Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B8322577C;
	Mon, 23 Jun 2025 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716668; cv=none; b=lW/59aDk3RlyHkOokFsZs5L7OLcwO9pPjj5oq5Ioze7YbKlxgqNBeHezERxWWqNObLNaSfdAOEZCyLyPi3/t/5FGQjgM6C/48DP8eeaDVlN/LYVGUsCl/5FIOo3uzQh4782fL0ji0o5GKBH6MfdugvXUby65o3CYUlIeCFymdRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716668; c=relaxed/simple;
	bh=jg97oCJgKWw4G6fFl+eTqGW97MfSzVXs69TgiS2OkNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YA+xUykpRyZ0XqqOzhQ5kk7352OpF+CLAbBTlLz361xcMuJ/FEtLzjkQDXMUH58+2W79qiWX8wED0zVCiL+MmFn7hfKsS/hhmFWt2MD/Czme4qcwarevi6acsPn8sy8ykcPq9AjmXPD05ah3TFOLsgBELaruxKIKXBjy2vcYczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZGCfpC3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZGCfpC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AB0C4CEEA;
	Mon, 23 Jun 2025 22:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750716668;
	bh=jg97oCJgKWw4G6fFl+eTqGW97MfSzVXs69TgiS2OkNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZGCfpC3dzw0k497nv4tJ7NUCQ7LKarF4QH8a0Uckvtsu4aimXKHf/LitzMg7K9CK
	 3snTB2StPQUZtDjzRGvZlf2quCDRZIfPep9f9VPOhlIHNMfB84VeeQqp/kbiJnXLur
	 QLHPNF0wrsa78ttzPB6V7VaNfLMBTW6Y7x5U0RO3yAWo1PMAaUFRhDjrGzV4YZxvgc
	 oYBhMxraIsZCEgMRK6atPlAbRah3ipTI512O2KMoaS/ZK4BYwFMVq2TUYhYBb9SttQ
	 7uN/DgaNtze5XwUvr4fAe4IuwAo+uYH1/g68SNrIimBnnKF2OQLzXzZDqyil8YVMou
	 D45jtCFwKNLwQ==
Date: Mon, 23 Jun 2025 12:11:07 -1000
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
Message-ID: <aFnQ-3L6ixL7nSz0@slm.duckdns.org>
References: <20250620203234.3349930-1-joelagnelf@nvidia.com>
 <20250620203234.3349930-9-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620203234.3349930-9-joelagnelf@nvidia.com>

On Fri, Jun 20, 2025 at 04:32:23PM -0400, Joel Fernandes wrote:
> +static struct task_struct *ext_server_pick_task(struct sched_dl_entity *dl_se,
> +						void *flags)
> +{
> +	struct rq_flags *rf = flags;
> +
> +	balance_scx(dl_se->rq, dl_se->rq->curr, rf);
> +	return pick_task_scx(dl_se->rq, rf);
> +}
...
> +void ext_server_init(struct rq *rq)
> +{
> +	struct sched_dl_entity *dl_se = &rq->ext_server;
> +
> +	init_dl_entity(dl_se);
> +
> +	dl_server_init(dl_se, rq, ext_server_has_tasks, ext_server_pick_task);
> +}

Needing to pass in @rf to ext_server_pick_task() makes sense as SCX always
needs to balance first. However, I still don't understand why that
necessitates adding @rf to sched_class->pick_task(). The existing assumption
is that ->pick_task() cannot release and regrab the rq lock and that's why
->balance() exists in the first place. Breaking this can lead to other
misbehaviors - e.g. if a higher priority class ->pick_task() releases the rq
lock, a lower one may end up losing a task that its ->balance() saw. This
can lead to lower priority class's ->pick_task() being called without its
->balance() being called which can lead to stalls.

One thing that confuses me is that all that the patchset needs to do seems
to be adding @rf to dl_server_pick_f and that seems fine to me. Why is it
necessary to add @rf to sched_class->pick_task()?

Thanks.

-- 
tejun
