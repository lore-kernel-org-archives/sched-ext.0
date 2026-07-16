Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D0842F70D
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212760; cv=none; b=PGIji/GDUIvje7PmMnUvNohFm0CQsiVTTc+7ZQBJdyyo5yEtmp58xJU36DpoRAGPY0sof0XzpqYDHctqfmSYyZPh1bVQqzKAisINKqRo+8b5mm/OS0FfI9av9V0Lvzge7EExN8glpAy+4gwPDSMMp/LdK9RWwkNZzB5Emltc44c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212760; c=relaxed/simple;
	bh=Ixv11eYppLrU6o5NgQfI66gATGaqEdEI0+qH33kBCtk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NT9+Q/PkTOuq2aIRUvAteB3OY3s3p0q9RE5I8tfu8YmEHMVROAMlUXW92QDMlPPA1kygQBuivXIWVfl1yQCEhE0ksMFHwfizS+skTaOVvFwWtgx7POTvu3RPilVoblzfCU88NToxpsLK2bfUzCi4hhYe1ZzrwVz4T4FufOTL3SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bdgmsjvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bdgmsjvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02AC1F000E9;
	Thu, 16 Jul 2026 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784212759;
	bh=VZUKUEyF35zXKHrm/TsZHoiCmdJIRsVNpulmz0HfcYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BdgmsjvbRiunf06obZij+I4WVtkv1fgJBUMUhHPYrG4bHrA3Q9E3DRddQOeaOeyBi
	 e2YCxeNN+d9rp1GZhB1jmKllm3aKGOHwC5r/Wi37+GfBB3pEc0DwJ9L1qTJfuR1BhI
	 /9w5njTEF3mtx7pZod6GF1fpKhbzQhiDPGnNtRnYa1Bd1aGlAD1g4aDlX71Fk4Iw4a
	 /S8GwY9d9qo66XOUW/5wfl34NmfLM9G+++Fp3TyjqPadvxOH6YOjoAjSt0lDfA2YQk
	 se/w/e30v8lZxOP8CeHoQozQEfM3WI4MCeRJHk3hHeUEZHwtaXkfZRsgt9Vbkbh7qQ
	 5TautVOk0FVWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] sched_ext: Fix TOCTOU race in
 consume_remote_task()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260716132229.61603-6-arighi@nvidia.com>
References: <20260716132229.61603-1-arighi@nvidia.com>
 <20260716132229.61603-6-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 14:39:18 +0000
Message-Id: <20260716143918.D02AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Infinite livelock loop in scx_consume_dispatch_q() when falling ba=
ck to the global DSQ.
--

--- Patch [5]: [PATCH 05/11] sched_ext: Fix TOCTOU race in consume_remote_t=
ask() ---
commit bf5934bbeaad49172aa99cf40eef02a6a7ea4bd6
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Fix TOCTOU race in consume_remote_task()

This commit attempts to fix a TOCTOU race in consume_remote_task() when
pulling a task from a non-local DSQ by deferring the validation until the
task's source rq is locked. It splits the check into lockless and locked
variants, and falls back to enqueueing the task to the global DSQ if the
locked check fails.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 04fc34a7ded65..6699144b36e5e 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -2480,6 +2496,28 @@ static bool consume_remote_task(struct scx_sched *=
sch, struct rq *this_rq,
>  				struct scx_dispatch_q *dsq, struct rq *src_rq)
>  {
>  	if (unlink_dsq_and_switch_rq_lock(p, dsq, this_rq, src_rq)) {
> +		/*
> +		 * Whether @p may be migrated to @this_rq may have changed while
> +		 * switching rq locks. This is a kernel-side race, not an invalid BPF
> +		 * placement request, so don't abort the scheduler on failure. Fall
> +		 * back to the global DSQ, where normal consumption filters can select
> +		 * a valid destination without forcing the task onto the source local
> +		 * DSQ.
> +		 */
> +		if (unlikely(!task_can_move_from_locked_rq(sch, p, this_rq, false))) {
> +			p->scx.dsq =3D NULL;
> +			p->scx.holding_cpu =3D -1;
> +			scx_dispatch_enqueue(sch, src_rq,
> +					     find_global_dsq(sch, task_cpu(p)), p,
> +					     enq_flags | SCX_ENQ_CLEAR_OPSS |
> +					     SCX_ENQ_GDSQ_FALLBACK);
> +			if (sched_class_above(p->sched_class,
> +					      src_rq->donor->sched_class))
> +				resched_curr(src_rq);
> +			switch_rq_lock(src_rq, this_rq);
> +			return false;

[Severity: High]
Can this fallback path cause an infinite livelock if the DSQ being scanned
is already the global DSQ?

When scx_consume_dispatch_q() locklessly picks a task that is executing on a
remote CPU, task_can_move_from_locked_rq() correctly fails.

Because consume_remote_task() enqueues the task back to find_global_dsq()
and returns false, scx_consume_dispatch_q() will react to the false return
value by jumping to its retry label.

If scx_consume_dispatch_q() was scanning the global DSQ:

kernel/sched/ext/ext.c:scx_consume_dispatch_q() {
retry:
    ...
    nldsq_for_each_task(p, dsq) {
        ...
        if (task_can_run_on_remote_rq(sch, p, rq, false)) {
            if (likely(consume_remote_task(sch, rq, p, enq_flags,
                                           dsq, task_rq)))
                return true;
            goto retry;
        }
    }
    ...
}

Does this cause the scanner to jump back to retry, rescan the global DSQ,
find the exact same task again, fail the locked check again, and repeat
the sequence indefinitely while holding runqueue locks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716132229.6160=
3-1-arighi@nvidia.com?part=3D5
