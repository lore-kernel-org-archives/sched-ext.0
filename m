Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FCD3BBA0B
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961390; cv=none; b=YSTQ67kMmhJDQQfdBNUiwhhD68XCfuWdk5Ypos3xYZe84VhdgEpPIFlKjtxLId0k6ua+QM0byzpWXM29JKMmqwjruplO1Q+Jb27TBiyvl8CQEbYzpVKDNNlrDNv6/rObli4JsE8qkpvjriFJngztsXeE100RwuVJHDTNCCqqH6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961390; c=relaxed/simple;
	bh=nlyChN7qaJ6aoH8zDaeYl+p7vFlmP+iW4oU06D49Ies=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tdmgl60mWZmMCdXRuywwEPiDbK4iW16Y7MbHHyuAIVm59nSHlLnJjC1P12M3LOg2AVFi/YMolb06BAxFVDL7y1/9wKTFFVUC6z6/4XcN+T8W0RptE0jNkisvyHErSX367HCm9Sjfzu6a64P9sf1cBMRpJxJJDITfU7LjhU9dcDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9kv+rsT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9kv+rsT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C02E1F000E9;
	Mon, 13 Jul 2026 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783961388;
	bh=ssOR5qUsyw8oaVJzM6TTfeggfwOSLe5Qs1M7XUAAaao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I9kv+rsTiNGVf0SllIZlSrWL/kNnOo0qwIOC8+jaKxMmgxbh/dW1daZqLWtXAAAgw
	 jc7Tp+TdIwTDE7BevPX0KAxrd7AsDPxderyxwunz6XyMGJwXsf6FrcEyaP5/KDmAUm
	 g1fopMNA3Xk61F8pUVRRHrhVftXR2bg2OBDZbtYoI6kNfkz4Rv1HWtRcx3OEr0qB1T
	 5XeTfbvPZIAzntudIOsgGxmA2eTVJqp0K1keXD87WH72zeYHfMVSiYJmVk5gshXZyr
	 0Wj3pkf+KTxXtrTUrcXnjW9JRaWy9Nt3s/p/fdK80mCfnFTXd1OYR89Z4YLrvfjyuJ
	 fnjpCWluX4mGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] sched: Allow enabling proxy exec with sched_ext
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260713162112.26785-11-arighi@nvidia.com>
References: <20260713162112.26785-1-arighi@nvidia.com>
 <20260713162112.26785-11-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:49:47 +0000
Message-Id: <20260713164948.4C02E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Normal task wakeups are misidentified as blocked proxy donors in s=
ched_ext operations (`scx_do_enqueue_task` and `wakeup_preempt_scx`), causi=
ng incorrect `SCX_ENQ_BLOCKED` flags and unconditional reschedules.
--

--- Patch [10]: [PATCH 10/10] sched: Allow enabling proxy exec with sched_e=
xt ---
commit 3a82f8102afed9269cf69799a73d94ed44769f33
Author: Andrea Righi <arighi@nvidia.com>

sched: Allow enabling proxy exec with sched_ext
   =20
Now that sched_ext can handle proxy donors and BPF schedulers can opt in
to blocked-donor enqueueing with SCX_OPS_ENQ_BLOCKED, remove the
!SCHED_CLASS_EXT dependency from SCHED_PROXY_EXEC and allow both options
to be enabled together.

> diff --git a/init/Kconfig b/init/Kconfig
> index 9ee6447dd454d..52376c44f60a6 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -937,8 +937,6 @@ config SCHED_PROXY_EXEC
>  	bool "Proxy Execution"
>  	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
>  	depends on !PREEMPT_RT
> -	# Need to investigate how to inform sched_ext of split contexts
> -	depends on !SCHED_CLASS_EXT

[Severity: High]
Does enabling proxy exec with sched_ext here expose an issue where normal
task wakeups are misidentified as blocked proxy donors?

When tasks go to sleep without pending signals, try_to_block_task() sets
p->is_blocked =3D 1. When these tasks wake up, ttwu_do_activate() processes
them in this order:

kernel/sched/core.c:ttwu_do_activate() {
        ...
        activate_task(rq, p, en_flags);
        wakeup_preempt(rq, p, wake_flags);
       =20
        ttwu_do_wakeup(p);
        ...
}

Because activate_task() and wakeup_preempt() are called before
ttwu_do_wakeup() clears the p->is_blocked flag, p->is_blocked remains 1
during the sched_ext callbacks:

kernel/sched/ext/ext.c:scx_do_enqueue_task() {
        ...
        enq_blocked =3D (sch->ops.flags & SCX_OPS_ENQ_BLOCKED) &&
                      p->is_blocked;
        if (enq_blocked)
                enq_flags |=3D SCX_ENQ_BLOCKED;
        ...
}

And also in the wakeup path:

kernel/sched/ext/ext.c:wakeup_preempt_scx() {
        ...
        if (p->is_blocked) {
                struct scx_sched *sch =3D scx_task_sched(p);
               =20
                if (sch && (sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
                        resched_curr(rq);
        }
        return;
}

If a BPF scheduler opts into SCX_OPS_ENQ_BLOCKED, will this force an
unconditional reschedule on every wakeup and skip intended preemption logic,
since it incorrectly sees all normal waking tasks as SCX_ENQ_BLOCKED?

Would it be safer for sched_ext to use task_is_blocked(p) (which evaluates
!!p->blocked_on) rather than p->is_blocked to correctly identify actual
blocked proxy donors?

>  	# Not particularly useful until we get to multi-rq proxying
>  	depends on EXPERT
>  	help

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713162112.2678=
5-1-arighi@nvidia.com?part=3D10
