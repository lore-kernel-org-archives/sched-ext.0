Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4656D284690
	for <sched-ext@lists.linux.dev>; Wed,  1 Jul 2026 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930866; cv=none; b=vDLqwwd3ZGj2FHbGgjYYNmXYG9uBGO2t4be3VVihn0Wf3Gl2GUkIs5QPfHw/41gBH00dbi7xjZNa1JSR5HH4XZvGsMU458e9D/C87ThJu7MhVxmjYIS9khvx/KLrvYmwgV2fQDtFjIhFGdpssjJcW/UYNWJbCaUE0RhVmC3Thtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930866; c=relaxed/simple;
	bh=FU8VyZGzXc5sjyITIVitKK02oZTlvdxDVlsjXyls4go=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gsVLl15vB0FKyYiu6NOebGhjUruRGjJPCXTy1Nw+cXtSdJu/ixE7SeWWSaYm3mOoNgkGBtc1VP6G4gtyZHaKuFi9Tk7bfU2sd64NkEjF+G8bJGcMcBKOQlTicvT+jLnwURA5kJ0ZhC0B6JvMMKp9ymMeDZ1VqC0UogQGKaCjRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4k4q4NN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4k4q4NN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF9A1F00A3A;
	Wed,  1 Jul 2026 18:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782930864;
	bh=wHAao5xOal3kTMW105IW0HNCl34V84wFPiGF+yYpvHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g4k4q4NNJIhyDXjiKcHEi+I+b3AP8iNVI6jbx8JXnNcV/tUufrCl0zKMj+f+NKO4G
	 GDXPzf/C6GvBUEwKgj4VIWA+AKCwXBVjv8p1tbbbEmDjLGWw2IIr6AKSAFaeoCeRG0
	 W3vXDadKEpU++GkDTybg2huj72XlXXy5ZQVYx7JMH5pb8cZx38R0Bc6NGgxq0jNb1K
	 KgWsYjZGV49e5jgpSqAZKh2chIGdTGJKjEpcxB8a4jFUxJBtAmRpIfHzWAEQPcZRcR
	 r8JJ5J+WA7fk5blPaXHUJHbPwF8kJXKkgCtvA1wy+XV644mAufmfXbWseh5hMG97if
	 dh3wA/q3NtZmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 4/4] sched_ext: Split sub-scheduler
 implementation into sub.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260701181046.2490390-5-tj@kernel.org>
References: <20260701181046.2490390-1-tj@kernel.org>
 <20260701181046.2490390-5-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 18:34:24 +0000
Message-Id: <20260701183424.BAF9A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Compilation failure due to implicit function declarations in `sub.h=
`.

Pre-existing issues:
- [High] The `scx_bpf_sub_dispatch` kfunc breaks runqueue lock atomicity fo=
r the parent BPF program.
- [High] Missing `scx_error()` calls in `scx_sub_enable_workfn()` lead to s=
ilent sub-scheduler initialization failures and zombie states.
--

commit c73a80aa8b4b758cfebb3ce05e858b8b1302f361
Author: Tejun Heo <tj@kernel.org>
Subject: sched_ext: Split sub-scheduler implementation into sub.c

This commit moves the sub-scheduler implementation from ext.c into a new
sub.c file. It also moves shared prototypes to sub.h and makes
scx_dispatch_sched() an inline function in sub.h.

> diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
> new file mode 100644
> index 0000000000000..460a9fd196dc6
> --- /dev/null
> +++ b/kernel/sched/ext/sub.h

[ ... ]

> +static __always_inline bool
> +scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
> +		   struct task_struct *prev, bool nested)
> +{
> +	struct scx_dsp_ctx *dspc =3D &this_cpu_ptr(sch->pcpu)->dsp_ctx;
> +	int nr_loops =3D SCX_DSP_MAX_LOOPS;
> +	s32 cpu =3D cpu_of(rq);
> +	bool prev_on_sch =3D (prev->sched_class =3D=3D &ext_sched_class) &&
> +		scx_task_on_sched(sch, prev);
> +
> +	if (scx_consume_global_dsq(sch, rq))
> +		return true;

[ ... ]

> +	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
> +		return false;

[Severity: Low]
Does this cause a compilation failure due to implicit function declarations?

In kernel/sched/build_policy.c, ext/sub.h is included before ext/ext.c. When
the compiler parses this scx_dispatch_sched() inline function in sub.h,
functions like scx_rq_online(), scx_flush_dispatch_buf(), and scx_kick_cpu()
have not been declared yet because they are defined later as static functio=
ns
in ext.c. This will result in an implicit function declaration error.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> new file mode 100644
> index 0000000000000..0504204272732
> --- /dev/null
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> +void scx_sub_enable_workfn(struct kthread_work *work)
> +{
> +	struct scx_enable_cmd *cmd =3D container_of(work, struct scx_enable_cmd=
, work);
> +	struct sched_ext_ops *ops =3D cmd->ops;
> +	struct cgroup *cgrp;

[ ... ]

> +err_disable:
> +	mutex_unlock(&scx_enable_mutex);
> +	scx_flush_disable_work(sch);
> +	cmd->ret =3D 0;
> +}

[Severity: High]
This is a pre-existing issue, but do missing scx_error() calls lead to sile=
nt
sub-scheduler initialization failures?

If initialization fails (for example, inside scx_arena_pool_init()), the co=
de
jumps to the err_disable label. Unlike scx_root_enable_workfn() which
explicitly calls scx_error() to transition the scheduler to a disabled state
and queue cleanup work, scx_sub_enable_workfn() omits this call.

Consequently, scx_flush_disable_work() does nothing because the exit state
remains SCX_EXIT_NONE, and the function returns success to userspace by
setting cmd->ret =3D 0, leaving the sub-scheduler permanently half-initiali=
zed.

[ ... ]

> +__bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_pr=
og_aux *aux)
> +{
> +	struct rq *this_rq =3D this_rq();
> +	struct scx_sched *parent, *child;
> +
> +	guard(rcu)();
> +	parent =3D scx_prog_sched(aux);
> +	if (unlikely(!parent))
> +		return false;
> +
> +	child =3D scx_find_sub_sched(cgroup_id);
> +
> +	if (unlikely(!child))
> +		return false;
> +
> +	if (unlikely(scx_parent(child) !=3D parent)) {
> +		scx_error(parent, "trying to dispatch a distant sub-sched on cgroup %l=
lu",
> +			  cgroup_id);
> +		return false;
> +	}
> +
> +	return scx_dispatch_sched(child, this_rq, this_rq->scx.sub_dispatch_pre=
v,
> +				  true);
> +}

[Severity: High]
This isn't a bug introduced by this patch, but does the scx_bpf_sub_dispatc=
h()
kfunc break runqueue lock atomicity for the parent BPF program?

The BPF verifier and scheduler core assume that a non-sleepable ops.dispatch
BPF program executes atomically while continuously holding the rq lock.
However, when the parent BPF scheduler calls this kfunc, it evaluates the
child scheduler's dispatch logic which calls scx_flush_dispatch_buf().

Flushing the buffer can invoke dispatch_to_local_dsq(), which drops and
re-acquires the rq lock. Dropping the lock underneath the still-executing
parent BPF program violates the atomicity assumption, which can allow
concurrent CPUs to modify the runqueue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701181046.2490=
390-1-tj@kernel.org?part=3D4
