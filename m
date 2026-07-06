Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BEB371049
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303692; cv=none; b=S8apm1MJGRPrt/aeTx7VgaHNFU8qWZ2ZJWFhZLB1ikEoYjzmaBnSzMqCgMXrzaD+KH2lizFmBy8ooIDJLcAFZHRtJ8gN/C3l+GT6yYmEducP/UTrdN+Bt63itYrZwu1/1f9/xL0hbNQUUXRYLSNLfpuuGtgU1NnZWnB4VfwdUYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303692; c=relaxed/simple;
	bh=QYx6vUh1ApOxinU1V39blb36kRq2IJS5Fe4g3vBxuz8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aElPcT7VowkxsBurynfzIbHYlRQdPiLXeBQRfXE6gJAhDgoQ97KUz1YkJ0izZ/EieJ8etDwe/gf3sypuiiuKfCwpd2igMDRBJ3v3AaCWZo6eoZIqxlCYV+qtM3X/DaiwMvzE7ruVKZ+7f9DE2YeM4hexyT4fPzf1s/+ata6Pl6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM50MsFY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM50MsFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8621F000E9;
	Mon,  6 Jul 2026 02:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783303691;
	bh=E6g3Zt9vU1wtruF0XshMdffRyEaM+BuoEv+f3OI/AjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PM50MsFYTm8gSdrhcjVG/ivdOstyLBwO6aAf5SkTckIQiM1uryH4suy6cgYfj2AhD
	 wW6eBu8rnJE8HcpRhgnBODHf4La5gga1ZZxkKT/elAWHWgGTE6ULHW8a67D8KQFqrw
	 RFbowRAmfWpivWzu2C7RWQzbjVK3SWedpDTC4DrHS/Fm4do8BgBq4BeXRb/9QUirFf
	 EGYd3cGWqi22vgSQjD+SakeHS3Dg7qgAhm8xM3AnC3OZV0x3uGSd64EORdzuxqPAvu
	 DajLyfASTt1v7zzARO55PxLwKkiCTfZKGlKR2p8s35IIHXZMcph/PM5pgi0W9ICbpM
	 jfeXvHtO0kr+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.3 17/36] sched_ext: RCU-protect the
 sub-sched tree's children/sibling lists
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706014058.439853-18-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
 <20260706014058.439853-18-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:08:10 +0000
Message-Id: <20260706020810.BA8621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incomplete inheritance of bypass state in scx_link_sched() leaves =
the new sub-scheduler in a broken bypass mode.
- [High] RCU-001: Remove Before Reclaim Ordering Violation in scheduler dis=
able paths.
--

commit 9e5c6a7b8888aaf2f3dcc167530999a7492f82cf
Author: Tejun Heo <tj@kernel.org>

sched_ext: RCU-protect the sub-sched tree's children/sibling lists

This commit switches the children and sibling list operations to RCU and
expands the descendant walker to accept rcu_read_lock. It also adds logic
to inherit the bypass state when linking a new sub-scheduler under a
bypassing ancestor.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 8ee980f822aac..9231ccc775e01 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -5487,7 +5488,10 @@ s32 scx_link_sched(struct scx_sched *sch)
>  				break;
>  			}
> =20
> -			list_add_tail(&sch->sibling, &parent->children);
> +			/* inherit the ancestor bypass state */
> +			WRITE_ONCE(sch->bypass_depth, READ_ONCE(parent->bypass_depth));
> +
> +			list_add_tail_rcu(&sch->sibling, &parent->children);
>  		}
>  #endif	/* CONFIG_EXT_SUB_SCHED */
> =20

[Severity: High]
Does inheriting the bypass_depth here without setting the per-CPU fast-path
flags leave the new sub-scheduler in a broken bypass mode?

If sch->bypass_depth is inherited as 1, and scx_bypass(sch, true) is
later called in scx_sub_enable_workfn(), inc_bypass_depth() checks
if (sch->bypass_depth !=3D 1). It will return false and jump to the unlock
label, skipping the SCX_SCHED_PCPU_BYPASSING flag initialization across
all CPUs.

Could this lead to BPF operations being invoked when they should be bypassed
and cause potential hangs or deadlocks?

[ ... ]

> @@ -5514,7 +5518,7 @@ void scx_unlink_sched(struct scx_sched *sch)
>  		if (scx_parent(sch)) {
>  			rhashtable_remove_fast(&scx_sched_hash, &sch->hash_node,
>  					       scx_sched_hash_params);
> -			list_del_init(&sch->sibling);
> +			list_del_rcu(&sch->sibling);
>  		}
>  #endif	/* CONFIG_EXT_SUB_SCHED */
>  		list_del_rcu(&sch->all);

[Severity: High]
Does the teardown path violate the remove-before-reclaim RCU invariant now
that this list is RCU-protected?

In both scx_sub_disable() and scx_disable(), the grace period functions
(synchronize_rcu_expedited() or synchronize_rcu()) are called before
scx_unlink_sched(sch):

scx_sub_disable() {
    synchronize_rcu_expedited();
    scx_disable_bypass_dsp(sch);

    scx_unlink_sched(sch);
}

Because the scheduler remains linked in parent->children and scx_sched_all
during and after the grace period, lockless RCU readers using
scx_for_each_descendant_pre() can discover the dying scheduler after the
grace period has finished but before it is unlinked.

Could this result in readers accessing an exited BPF scheduler context?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706014058.4398=
53-1-tj@kernel.org?part=3D17
