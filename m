Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8613A5E90
	for <sched-ext@lists.linux.dev>; Wed,  1 Jul 2026 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939315; cv=none; b=ayXALqWNH9B9u51sfEFtczpJWR6BvkMom6eUeOVPa6csNVg7TySWvJg4KBKHml6Dhi5ELxG+ZCRt++yrDmwbgGQIsCpDE3hNMgJREdFv0Oj26IhV/yVdFYf2mNdNusuPy+gorsGGl0f1SPD0c3sFiCXxluZ8OZDeUAs3IXb2yi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939315; c=relaxed/simple;
	bh=FHGWZgC1E6CqLLVzLDzpjaXW39LTTe92cIvhyaO9O1I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RiQh5GSzOyCiujS+Ttd62jza00sQflHBIUMPoJfMWs3ZVaVJL9b9VIveC6r69ZT/1slefM76wuAVlbBEKngSs4qdjmV7l9izaXVN23QYvVA7zvx0NZCW5RXuPu1un1G4Fsq6jJgzc7J90KlNzzRzMa4AcXeHw8Z3nCJQc+ILKTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPhyrVqE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPhyrVqE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9C41F000E9;
	Wed,  1 Jul 2026 20:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782939313;
	bh=VGNA8EAO1BUSPQtEXhYgYuO/JrDkjoxHXAgGZk/5Dvc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZPhyrVqE77fjCBRoYK6F6VVyAhtZt0DbBdsKKva0klQ4PCmBp3M8IqBhqj2ZQ8PnT
	 /jNUGMBABGT3Lag8wnJGO78a6c3izmO6SE1AZx8gUbdiaG5S5WEST+0VDdYAooAQC6
	 IjzFkthFoo0zcqB1DaKrzS0Uo2+Hq2ETqm4sxbND1dGF37+pNUfgj0UBoxID9XtAu/
	 t7hd1nly53JAHa6fHI06RUdHV9lpzUZ1yka0nhNw3MQ4VyH7gs4oFZWw46J36lOKXP
	 vJlLnwsDoXS/+kBT5/juuOiA/qNmZs9mZnD8e0hRqzy9xVTr/vnhGvzoYPk3K/sII+
	 35uIlltp5f3nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 4/4] sched_ext: Split sub-scheduler
 implementation into sub.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260701203438.2837392-5-tj@kernel.org>
References: <20260701203438.2837392-1-tj@kernel.org>
 <20260701203438.2837392-5-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:55:13 +0000
Message-Id: <20260701205513.6A9C41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `scx_sub_disable` violates RCU removal ordering, leading to Use-Af=
ter-Free of sub-schedulers.
- [High] NULL pointer dereference in `find_parent_sched` when attaching a s=
ub-scheduler to a newly created cgroup.
- [High] Missing `scx_error()` calls in `scx_sub_enable_workfn` error paths=
 cause the sub-scheduler to leak and remain bypassed indefinitely.
--

commit 3673367fbf0f16668d479297e4d6ace4a6a2dbef
Author: Tejun Heo <tj@kernel.org>
Subject: sched_ext: Split sub-scheduler implementation into sub.c

This commit moves the sub-scheduler implementation from ext.c into a new
kernel/sched/ext/sub.c file. It also creates sub.h to hold prototypes and
inline functions like scx_dispatch_sched() for better modularity.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> new file mode 100644
> index 0000000000000..0504204272732
> --- /dev/null
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> +void scx_sub_disable(struct scx_sched *sch)
> +{

[ ... ]

> +	/*
> +	 * All tasks are moved off of @sch but there may still be on-going
> +	 * operations (e.g. ops.select_cpu()). Drain them by flushing RCU. Use
> +	 * the expedited version as ancestors may be waiting in bypass mode.
> +	 * Also, tell the parent that there is no need to keep running bypass
> +	 * DSQs for us.
> +	 */
> +	synchronize_rcu_expedited();
> +	scx_disable_bypass_dsp(sch);
> +
> +	scx_unlink_sched(sch);

[Severity: High]
This is a pre-existing issue, but does this violate RCU removal ordering?

The sub-scheduler is removed from the scx_sched_hash via scx_unlink_sched()
after the RCU grace period completes. Because it remains in the hash during
and after the grace period, couldn't a concurrent BPF program on the parent
scheduler call scx_bpf_sub_dispatch() and find the sub-scheduler?

Should scx_unlink_sched() be called before synchronize_rcu_expedited() to
ensure new RCU readers cannot look it up?

[ ... ]

> +/* verify that a scheduler can be attached to @cgrp and return the paren=
t */
> +static struct scx_sched *find_parent_sched(struct cgroup *cgrp)
> +{
> +	struct scx_sched *parent =3D cgrp->scx_sched;
> +	struct scx_sched *pos;
> +
> +	lockdep_assert_held(&scx_sched_lock);
> +
> +	/* can't attach twice to the same cgroup */
> +	if (parent->cgrp =3D=3D cgrp)

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for parent
to be NULL here?

If a BPF program attaches a sub-scheduler to a newly created cgroup that
hasn't completed its ONLINE phase yet, cgrp->scx_sched might be NULL. The
code dereferences it immediately.=20

The explicit check for CSS_ONLINE happens later in scx_sub_enable_workfn().
Should we verify parent is not NULL before dereferencing it?

[ ... ]

> +void scx_sub_enable_workfn(struct kthread_work *work)
> +{

[ ... ]

> +	ret =3D scx_link_sched(sch);
> +	if (ret)
> +		goto err_disable;
> +
> +	if (sch->level >=3D SCX_SUB_MAX_DEPTH) {
> +		scx_error(sch, "max nesting depth %d violated",
> +			  SCX_SUB_MAX_DEPTH);
> +		goto err_disable;
> +	}
> +
> +	if (sch->ops.init) {
> +		ret =3D SCX_CALL_OP_RET(sch, init, NULL);
> +		if (ret) {
> +			ret =3D scx_ops_sanitize_err(sch, "init", ret);
> +			scx_error(sch, "ops.init() failed (%d)", ret);
> +			goto err_disable;
> +		}
> +		sch->exit_info->flags |=3D SCX_EFLAG_INITIALIZED;
> +	}
> +
> +	ret =3D scx_arena_pool_init(sch);
> +	if (ret)
> +		goto err_disable;
> +
> +	ret =3D scx_set_cmask_scratch_alloc(sch);
> +	if (ret)
> +		goto err_disable;
> +
> +	if (scx_validate_ops(sch, ops))
> +		goto err_disable;

[Severity: High]
This is a pre-existing issue, but do we need to call scx_error() in these
failure paths?

If scx_link_sched(), scx_arena_pool_init(), scx_set_cmask_scratch_alloc(),
or scx_validate_ops() fail, the code jumps to err_disable without calling
scx_error().

Without scx_error(), sch->exit_kind remains SCX_EXIT_NONE. When
scx_flush_disable_work(sch) is executed at err_disable, it will immediately
return, leaving the sub-scheduler partially initialized and permanently
bypassed, while returning 0 (success) to userspace.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701203438.2837=
392-1-tj@kernel.org?part=3D4
