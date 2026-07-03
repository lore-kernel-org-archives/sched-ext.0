Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8843D9DBC
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085662; cv=none; b=EqXb90ynSrkydpeM3hQ+OoVyUzL6KhDYey1cllUNAPEw+ksSX9Xorcr8UjVlnfy1+SH1zBufzlUq49zwMpIZ4RfHVDw1pn9XgAgxwXfDYgCmrl7hxhk0t0keeF6D+Oh3zyvFwJlKcwq5qiGUjr7c9EY1SW4lWKLmafz/yUBeECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085662; c=relaxed/simple;
	bh=erTeWqtSTzyZ8VpJwSbc4EUD3Mw17xj0+v8UdbpCEbw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sL9orzOdz3/t+ORtK3maSM0wtrc0X03pzrvliN408VlzaSH4XxB5aodk3CLMMbB355RVGftp5r/VxrHXV6qrIiGWM1t+vkSBZjrjQk/u8RT4D9XRAsJLukLAxqvRXCPfFLkfCtj51Me5/w9rytAFhMI3Pt/EJ+f0e11QlNwTBDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTTYL9d4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTTYL9d4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16B11F000E9;
	Fri,  3 Jul 2026 13:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783085661;
	bh=UpdKKchC3b7sPLPV+iy3LB7VrhMq/VnA6b95kp2HDXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PTTYL9d4bkhWOVoZLBv2TDBRn0rf2VFqXXmR2Cb7FGD9/6k4Dhh1Z2thALezFIhLT
	 wFuvjr5kp9OUVyf4pk0KiKbtQIljMt2VJymunUnJVZsJ1M0AB6/mRGFVUrDma1qL0V
	 qHhb99tFb4LehHOpU370JGrGubb8O6kWw3jTkPSd9FLSL08SWmf3KWh2vLD+OWRjkV
	 VCpFaHsYexNK5HFmV29zxvqw4d/CuwIVil3HhGwnO+H8pUWMMzSGE4nVmAUbA0Bqvr
	 i0bzzahSepWb0uLESkgu3wIEWOvm4gOsAoVUuJHHHtvzReSoCf+LVYC8bb0ZYcSJwv
	 cgRxeYFHBBgNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3 25/32] sched_ext: Tie cpu occupancy to
 SCX_CAP_BASE through the task slice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260703080159.2314350-26-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
 <20260703080159.2314350-26-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 13:34:19 +0000
Message-Id: <20260703133420.C16B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] scx_bpf_task_set_slice() assumes holding task_rq(p) implies exclus=
ive access, but blocked tasks can migrate locklessly, allowing capability b=
ypass and data races.
--

commit d3cb4ee9fc08ad3b3488c4dd100374ef3a61801c
Author: Tejun Heo <tj@kernel.org>

sched_ext: Tie cpu occupancy to SCX_CAP_BASE through the task slice

This commit ties CPU occupancy to the SCX_CAP_BASE capability, ensuring
that a task's slice can only be extended if its scheduler holds baseline
CPU access. It updates scx_bpf_task_set_slice() to apply the slice
synchronously when the rq lock is held, or out-of-band otherwise.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -8626,20 +8761,45 @@ __bpf_kfunc_start_defs();
>  __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
>  					const struct bpf_prog_aux *aux)
>  {
>  	struct scx_sched *sch;
> +	struct rq *rq =3D task_rq(p);
> =20
>  	guard(rcu)();
>  	sch =3D scx_prog_sched(aux);
>  	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
>  		return false;
> =20
> -	set_task_slice(p, slice);
> +	/*
> +	 * Out of band: stash and apply under the rq lock at the next drain,
> +	 * where it is re-validated against @p's current owner.
> +	 */
> +	if (scx_locked_rq() !=3D rq) {
> +		set_task_slice_oob(sch, p, slice);
> +		return true;
> +	}
> +
> +	/* under the rq lock: apply now, extensions gated on baseline access */
> +	if (slice > p->scx.slice &&
> +	    unlikely(scx_missing_caps(sch, cpu_of(rq), SCX_CAP_BASE)))

[Severity: High]
Does this direct write path allow a capability bypass and a data race for
blocked tasks?

If a BPF program on CPU A holds the rq_A lock and calls
scx_bpf_task_set_slice() on a blocked task 'p' that last ran on CPU A,
task_rq(p) will return rq_A. This matches scx_locked_rq(), allowing the code
to skip the out-of-band path.

Could try_to_wake_up() concurrently migrate 'p' to CPU B in this scenario?
Since try_to_wake_up() only needs to hold pi_lock (not the rq_A lock) while
changing p->cpu, the BPF program might directly write to p->scx.slice at the
same time update_curr_scx() is running on CPU B.

Additionally, since the capability check above uses the old CPU (rq_A) rath=
er
than the new CPU the task is migrating to, would this allow a sub-scheduler
to bypass the SCX_CAP_BASE revocation check for the new CPU?

> +		__scx_add_event(sch, SCX_EV_SLICE_DENIED, 1);
> +	else
> +		set_task_slice(p, slice);
> +
>  	return true;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703080159.2314=
350-1-tj@kernel.org?part=3D25
