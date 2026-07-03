Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341C13D3304
	for <sched-ext@lists.linux.dev>; Fri,  3 Jul 2026 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087292; cv=none; b=K37Ri7Hp6ONjCgJEGun7qkejQL6bOOi99ZLHrQqaI8Lb2s2wrbqgydGxLf2Y/KntVAPKd5txC47Buegnt0Tf4qrmTy+68L3JlzssvhCc0YtJOwFg7vxhzdMokJe5x7sqcYBhxQIhZKmpvBCDh42Kv7ZeiLNziTLuzmfLjafehPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087292; c=relaxed/simple;
	bh=TapXkzB6Otm3eH8qisbV0tOdh0sZdtJZD6EjuxNFOWM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D5hp7e4rK+k67bCWSqvZERI6P+L6572UwjpPnbJ2IPRxh7pG5lLSwlaOrzKqz0JCu4A1ks/QZbJc6wPKE8RAJaL52IpD8EZEVlVzqd94KGuCTKB2Dgia/9Bbg5NXnVDmTIBVIps+Jz/GeTaQ3ew8o0WEatkrRl7iDbwBJk2To6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRop9oIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRop9oIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75C11F00A3A;
	Fri,  3 Jul 2026 14:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783087290;
	bh=H9ptV1B63bBiZuErEEGzmf4oYGB2liEJTHsHFSmI7KQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dRop9oIl85cCzdLUy35a17cwYLJ3/Zbvzrdmj652wSk3ah3kPcFy2SIhuA5anHi03
	 ZHmsv/+lhNF27JvokVgX226OxzM29t36eLtdCfHH6nAks2JkVj1tIUwoTauZ9OBK/Z
	 Yq/zP+3ut69UVKGuzdCq2etaZElao/zK8io6n3rKN63srfJjXQjZkOBSbLleRdmP+R
	 2v+dBQdmWSpSUc2dNL4c+uuUqLTf78UOfx5gIQJOKqAhBj7e/ClsnNvMnBVel6oRCM
	 Z0OlyNzE2ljCsXySmmdEcTYXVMf/v4eqaApDVBdo8h6BG4cWo9HKXNHYVVLIDYUWKU
	 IK08uTC6btlDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH sched_ext/for-7.3 27/32] sched_ext: Gate kicks on
 SCX_CAP_BASE and preemption on SCX_CAP_PREEMPT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260703080159.2314350-28-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
 <20260703080159.2314350-28-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:01:30 +0000
Message-Id: <20260703140130.B75C11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Inconsistent capability enforcement when a sub-scheduler dispatche=
s a descendant's task to a local DSQ using SCX_ENQ_PREEMPT.
--

commit 35cbaaff89094ffe7ebdd01799138d2095bbc3dd
Author: Tejun Heo <tj@kernel.org>

sched_ext: Gate kicks on SCX_CAP_BASE and preemption on SCX_CAP_PREEMPT

A kick forces a scheduling event on the target cpu, and a preemption also
evicts the running task. Gate both on caps. Any kick requires baseline
access on the cid, and preempting a task the sub-sched does not own -
whether by a SCX_ENQ_PREEMPT insert or a SCX_KICK_PREEMPT kick - requires
the new SCX_CAP_PREEMPT.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 2f1e19db8e72c..67ba352828e05 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
[ ... ]
> @@ -222,7 +225,12 @@ struct scx_dispatch_q *scx_local_or_reject_dsq(struc=
t scx_sched *sch, struct rq
>  					       struct task_struct *p, u64 *enq_flags)
>  {
>  	s32 cid =3D __scx_cpu_to_cid(cpu_of(rq));
> -	u64 missing =3D scx_missing_caps(sch, cpu_of(rq), scx_caps_for_enq(*enq=
_flags));
> +	u64 needed =3D scx_caps_for_enq(*enq_flags);
> +	u64 missing;
> +
> +	if (*enq_flags & SCX_ENQ_PREEMPT)
> +		needed |=3D scx_caps_for_preempt(sch, rq);
> +	missing =3D scx_missing_caps(sch, cpu_of(rq), needed);

[Severity: High]
This isn't a bug introduced by this patch, but the newly added SCX_CAP_PREE=
MPT
check seems to expose a pre-existing context loss issue.

Can this lead to spurious preemption failures when a sub-scheduler dispatch=
es a
descendant's task remotely?

When a sub-scheduler (e.g., A) dispatches a descendant's task (e.g., owned =
by
B) to a remote CPU using SCX_ENQ_PREEMPT, dispatch_to_local_dsq() delegates=
 to
move_remote_task_to_local_dsq(), which doesn't pass the active scheduler
context (A).

Later, when the task is activated on the remote CPU:

enqueue_task_scx() {
    ...
    struct scx_sched *sch =3D scx_task_sched(p);
    ...
}

This reconstructs the scheduler context from the task itself, yielding B
instead of A.

When execution reaches scx_local_or_reject_dsq(), the needed capabilities a=
re
checked against B instead of A. Could this incorrectly reject the task, mov=
ing
it to the reject_dsq and creating an infinite scheduling loop that triggers=
 the
sched_ext watchdog?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703080159.2314=
350-1-tj@kernel.org?part=3D27
