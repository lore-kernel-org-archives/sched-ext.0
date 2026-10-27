Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097807;
	b=NqHHf6SlUgjogD9sIZk66VWuom45o8lai8PBhZ/MX7CIGQtuCqCVJrlBnMoj8yZO+05x
	 +sqZHMgJftziaRgsZWtLpwPj7Tqh5dRC6vmU0GPxgreFzu1P4U665Ced1Cnec7zmygGgw
	 tZaosU5woz06w/pJgKnLlE+lUvR+0212zvUt4X49FfIuHCwxNIM0U42+x/yO0EvcZcp8v
	 DelIkHLIx97D7vHtSLW5VObd34W0VuRMp/IuOz+355C9P5xDtrW515m2h19gK4i0aedjz
	 WCusN0FWBK8yulzTDQzhV+ynG/WR58rYetuEWnJfccpm/moEikH9ZLLrvl7H4eNAz2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097807;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=5cuAyfQfZRwB/ZRJJCQmT1gKO7dZWqo7d1NTD/DA/Ek=;
	b=lgHYNq4XZPfFCyPKqmDlIliC8uc1992g8z8NMntvgC8JVwBwCFeKwrrz1Qf68DcuEW/3
	 Wkpg1yIH9JOP38k0ncDQJjna3viTabx04eY2j+1Kx3q+ghVskI50BdiEi93Ji7OPH06af
	 FnuObgPQ+is46It9DdSmW0fC+cevhnZntGhbjyyRFd/NRrwADXH+CnSLmRVzOBsfB1Xiq
	 Qy6Om22+OnC5RakZAz1NOJT4UC9swrqwRv7gQVP0lbJrtnrK1hlRWat740Xfn2TiPdJ2F
	 e1c6L3uKm3fUeR+xHs0OzArPOHlotQ1lk21NImiixDWe4xqWCvIpuwlL+p75+D5WGyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Jxq1qDP2;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52BE606A31A;
	Tue, 27 Oct 2026 10:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B52BE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Jxq1qDP2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5cuAyfQfZRwB/ZRJJCQmT1gKO7dZWqo7d1NTD/DA/Ek=; b=Jxq1qDP2LqmT2dk2E71+04IfH6
	s8/tZnh6kO0Ple/+vAqGDY8PAlYR/CX2Jjm/GM+/IbegXgCKhJRA4k6r4z3tr0OHYiCELXH03GPYr
	GZEnsc2Gr0/5uupz+BqNxnEwE3dcjLsS4IS+oW9i+I7Z/HzMyTjQYJlN9nWFmR2nQeQC9ezkW9GGb
	Qe/tQ200d0Icwo5IPMxXRhSbNFy69YKAGmOByaqIKEGZfBAkE0zBZRbxUD7UZkU29a1855XpGowS8
	osphTmrOBaOJCbKNyNd8XNL9LQN28UGUqsTQgjjHGbcynL0fkYLfk3WWAcv/SyC4larUBukCO8Vej
	qPJ865LQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLeeE-0000000EjsU-2yWT;
	Tue, 27 Oct 2026 10:43:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1C60B300DB9; Tue, 27 Oct 2026 11:43:17 +0100 (CET)
Date: Tue, 27 Oct 2026 11:43:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>, David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>, Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] sched/numa: Leave the placement of a BPF-scheduled
 task to its scheduler
Message-ID: <20261027104317.GC2668564@noisy.programming.kicks-ass.net>
References: <20261027041536.3317971-1-arighi@nvidia.com>
 <20261027041536.3317971-3-arighi@nvidia.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027041536.3317971-3-arighi@nvidia.com>

On Tue, Oct 27, 2026 at 05:13:31AM +0100, Andrea Righi wrote:
> A task under a BPF scheduler can take NUMA hinting faults via
> task_numa_fault() and then reach numa_migrate_preferred(), which may
> migrate the task to its preferred node through task_numa_migrate().
> 
> The migration of such a task should always be driven by its BPF
> scheduler, which owns the placement of its tasks.
> 
> Keep collecting the statistics, which is what makes
> p->numa_preferred_nid worth reading, but skip the migration for a task
> owned by a BPF scheduler. The scheduler can read the preferred node and
> decide for itself whether moving the task is worth the cost.
> 
> For the same reason, never pick a task owned by a BPF scheduler as the
> swap partner of another task that NUMA balancing migrates, e.g., a fair
> task when the BPF scheduler runs in partial mode. Such a task is
> treated like a kthread on the destination CPU: the migrating task can
> still move there alone, but the BPF-scheduled task is left in place.
> 
> Reported-by: Vladimir Vdovin <deliran@verdict.gg>
> Link: https://lore.kernel.org/r/20261002124559.10367-1-deliran@verdict.gg
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/fair.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 36df9a4dde534..5064c7b707f4d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3267,8 +3267,13 @@ static bool task_numa_compare(struct task_numa_env *env,
>  
>  	rcu_read_lock();
>  	cur = rcu_dereference_all(dst_rq->curr);
> +	/*
> +	 * Never pick a task under a BPF scheduler as the swap partner: its
> +	 * placement is left to that scheduler, see numa_migrate_preferred().
> +	 * Moving the faulting task alone to the destination is still allowed.
> +	 */
>  	if (cur && ((cur->flags & (PF_EXITING | PF_KTHREAD)) ||
> -		    !cur->mm))
> +		    !cur->mm || task_on_scx(cur)))
>  		cur = NULL;

Rather than check task_on_scx(); your argument with Prateek seems to
highlight that the actual check you're looking for should be something
like: cur->class != &fair_sched_class or somesuch, right?

>  	/*
> @@ -3645,6 +3650,14 @@ static void numa_migrate_preferred(struct task_struct *p)
>  	if (task_node(p) == p->numa_preferred_nid)
>  		return;
>  
> +	/*
> +	 * A task under a BPF scheduler is placed by that scheduler. Keep the
> +	 * statistics coming, which is what makes p->numa_preferred_nid worth
> +	 * reading, but leave the placement alone.
> +	 */
> +	if (task_on_scx(p))
> +		return;
> +
>  	/* Otherwise, try migrate to a CPU on the preferred node */
>  	task_numa_migrate(p);
>  }

I am somewhat confused on all this still, probably because I've not
looked at it for more than a couple of minutes at this point :-)

But rather than putting a callback in sched_setnuma() should you not put
a class call here?

That is; have this be:

	p->class->task_numa_migrate(p);

and have fair set task_numa_migrate_fair(), which is the current
function, and then ext can implement the BPF thing.

Anyway, if you want to do this task_on_scx() thing like you did, its in
the wrong spot, that condition right above it is irrelevant if you're
not going to be calling task_numa_migrate(). 

