Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60517392C50
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323328; cv=none; b=kiFN0YanYkU7qTozAXC20iuYIDrADbDRVnIrAoN2li58DOuqG9+a/F/CGvD2RzlbQF/l+fZZ2NrWCVlfuCPdG2nsXGWBDs8+U7ctEJBjkH/r6s1CGV/tA95BIB1rjX7sY61/+XUzOq9MUyDv/ieCLMAiFeX3uXKVNNC+U5abmew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323328; c=relaxed/simple;
	bh=6xYJf2/N5cMN6moP8qPPMzZQyVBXwzRHQTTQbTtCv0s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sXCiS8KTcgOpHm8B9W18xqL+6flFu4XJZ4QLOsQGStA/DB++MY7bsYk8Zt2fhqmQaM55DCeMYVQo3hWQM8qjVGv+otQjeTmPRS/suoPFahcemVQLWMSmrICh4avrQ6tjCiuoHg/FSPJltvLXYYDw69AcJHH+0o3KqmcZpftSr9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7QWDoXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7QWDoXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF2D1F000E9;
	Mon,  6 Jul 2026 07:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783323316;
	bh=NMUZc3g8m49aZfgoHs5h0ZyygH8gAcs2eaF9xf/lRxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h7QWDoXd98wh65c0mAdrrHSrkrgcpF5cGhXMYQIwNgzRlHfBqPSXmddCSKgaDhl88
	 iTOPRdVkANlZx5cr4eCIBBlWEkNYwVoIJtsfErvP+jNyxncaZ0VTdzWeipgIwvq7/g
	 gEFsc5jpIEpEAGfonLtG2Hz/y000KVUCFhBA4a7Iqpz7cKpwJqe4FSTFdTkevYZmIT
	 E1aOlUjzPsLcgdXB9Pe3Lr/UUIHMWadcBD3ZPIFl8nHrc0op786BpO1zd5e7BsUleb
	 hU1VZSWd7ZeIaEwVbZrGcGtLIYcdfxPAVJRJno0kQmD6c+a0xtKiAu5Wa4bruj3vtq
	 mtDCE9UASR+7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] sched_ext: Split curr|donor references properly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706070410.282826-3-arighi@nvidia.com>
References: <20260706070410.282826-1-arighi@nvidia.com>
 <20260706070410.282826-3-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 07:35:15 +0000
Message-Id: <20260706073516.1DF2D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] update_curr_scx() unconditionally consumes delta_exec for non-EXT =
donor tasks when an EXT owner task goes to sleep, improperly charging the E=
XT DL server and breaking CPU time accounting for the donor task.
- [Medium] The detailed task state dump in `scx_dump_cpu()` incorrectly ass=
umes `rq->curr` is the only active task to dump, causing the actual BPF-sch=
eduled EXT task (`rq->donor`) to be omitted when proxy execution is active =
and the contexts differ.

Pre-existing issues:
- [High] scx_can_stop_tick() evaluates the tick dependency of the outgoing =
task rather than the incoming task during set_next_task_scx(), leaving the =
tick improperly stopped on NOHZ_FULL CPUs.
--

commit 176c10999ef611ede6c4d2387d4c2485699560c2
Author: John Stultz <jstultz@google.com>

sched_ext: Split curr|donor references properly

This patch modifies sched_ext to use rq->donor instead of rq->curr for slice
accounting, preemption, task picking, tick handling, and CPU kicks. This
separation prepares the scheduler for proxy execution, where the task
supplying the scheduling context (donor) can differ from the physically
executing task.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 1a0ec985da77d..242f6ffbba350 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -1145,17 +1145,17 @@ static void touch_core_sched_dispatch(struct rq *=
rq, struct task_struct *p)
> =20
>  static void update_curr_scx(struct rq *rq)
>  {
> -	struct task_struct *curr =3D rq->curr;
> +	struct task_struct *donor =3D rq->donor;
>  	s64 delta_exec;
> =20
>  	delta_exec =3D update_curr_common(rq);
>  	if (unlikely(delta_exec <=3D 0))
>  		return;
> =20
> -	if (curr->scx.slice !=3D SCX_SLICE_INF) {
> -		curr->scx.slice -=3D min_t(u64, curr->scx.slice, delta_exec);
> -		if (!curr->scx.slice)
> -			touch_core_sched(rq, curr);
> +	if (donor->scx.slice !=3D SCX_SLICE_INF) {
> +		donor->scx.slice -=3D min_t(u64, donor->scx.slice, delta_exec);

[Severity: High]
Does this code apply EXT-specific accounting to a non-EXT donor task when t=
he
owner task goes to sleep?

If proxy execution is active, where the donor is a FAIR task and the owner
(currently executing) is an EXT task, update_curr_scx() will be called
because the executing task belongs to the EXT class.

Without a check ensuring the donor is actually in the EXT class
(e.g., if (donor->sched_class !=3D &ext_sched_class) return;), could the EXT
DL server be erroneously charged for the FAIR task's time?

[ ... ]

> @@ -4029,7 +4030,7 @@ static void run_deferred(struct rq *rq)
>  #ifdef CONFIG_NO_HZ_FULL
>  bool scx_can_stop_tick(struct rq *rq)
>  {
> -	struct task_struct *p =3D rq->curr;
> +	struct task_struct *p =3D rq->donor;
>  	struct scx_sched *sch =3D scx_task_sched(p);
> =20
>  	if (p->sched_class !=3D &ext_sched_class)

[Severity: High]
This is a pre-existing issue, but does scx_can_stop_tick() evaluate the tick
dependency of the outgoing task rather than the incoming task?

When switching to an EXT task on a NOHZ_FULL CPU, set_next_task_scx()
triggers a check:

set_next_task_scx()
  sched_update_tick_dependency()
    scx_can_stop_tick()

At this point, rq->donor (and previously rq->curr) has not yet been updated
to the newly selected task, which happens later in __schedule().

If the previous task was not an EXT task (e.g., idle), won't
scx_can_stop_tick() return true and wrongly bypass the BPF scheduler's
request for ticks?

[ ... ]

> @@ -6007,6 +6008,9 @@ static void scx_dump_cpu(struct scx_sched *sch, str=
uct seq_buf *s,
>  	dump_line(&ns, "          curr=3D%s[%d] class=3D%ps",
>  		  rq->curr->comm, rq->curr->pid,
>  		  rq->curr->sched_class);
> +	dump_line(&ns, "          donor=3D%s[%d] class=3D%ps",
> +		  rq->donor->comm, rq->donor->pid,
> +		  rq->donor->sched_class);
>  	if (!cpumask_empty(rq->scx.cpus_to_kick))
>  		dump_line(&ns, "  cpus_to_kick   : %*pb",
>  			  cpumask_pr_args(rq->scx.cpus_to_kick));

[Severity: Medium]
Will this miss dumping the detailed state of the EXT donor task if rq->donor
and rq->curr differ?

Later in scx_dump_cpu(), the detailed task dump only checks rq->curr:

	if (rq->curr->sched_class =3D=3D &ext_sched_class &&
	    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
		scx_dump_task(sch, s, dctx, rq, rq->curr, '*');

If proxy execution is active and rq->donor is an EXT task but rq->curr is a
FAIR task, the actual BPF-scheduled EXT task (the donor) would be completely
omitted from the detailed dump during a crash or sysrq.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706070410.2828=
26-1-arighi@nvidia.com?part=3D2
