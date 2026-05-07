Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2CB238159
	for <sched-ext@lists.linux.dev>; Thu,  7 May 2026 02:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778121158; cv=none; b=ae3RIkG3HR8X4Gc5vVxpi7k8BeN3jznVb/Wpxq8wJH6dnMb3Mu7ija8vzQ15uzzAEvwDHXCZ2FFUBptCJnsuCo9csGjgifimru5P2hr/h4kse0R38LWKUa+BUBX3uLnNOgnG+OC1h1LJdUwlUDB8tURIXtdPBrixv4RYcBOJ0XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778121158; c=relaxed/simple;
	bh=XIVMCDjzPlTxfHhRJyKt7NkoOHhmpdRK+H1evR8Gqbk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=c9x/Pr73N1hHOESVNOTxElDpCq6QaDETjATgvINron3tuvxwpaV8LU0iWuq6ff2vSQkHQZTRG4ZxRGa1WpfUH6fxHvvwEdramFvdl1geHThENajEdqAt/7Xcj8TrmxTLYfeS6miQDgTHAP7ZDHjA2juQ8tORY53y6AWlBL/y6Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L42krAtK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L42krAtK"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b9ea536877so2141295ad.1
        for <sched-ext@lists.linux.dev>; Wed, 06 May 2026 19:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778121156; x=1778725956; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4vgs0xscu3MsVhFPXf5qWcASYOxg1W9AcmmIG28clo=;
        b=L42krAtK/qUF4ztltX6UnutUukNcle4gFTXUGF9rmPapNZ9xr1Q8GZlT12nY2sG1gY
         65kzzKmTY+5Ruicf//M6VtXBQVsNQ5diWUS3gOzi41wSGwCJo/p7Ind07AiF3aXkqPdP
         yv8x3GmFgB0BTbVNAoXZb/2FvncHTSdGF9yg6wHkUHJgOxWuZ1VV611IucB5iEN26VbU
         rAU9CQU6fBK+6Tp1jh+qKEAo93VCC576t2ptmz9I4f1zIJ92lCa2BIQg6tVM8KR9kIMN
         4O8XBBFytiAhggBBYTwJPWSvpVeYa9zRJeDvbl1ZlI1e59wY6y44t3dQ0t6ebMSXVBBY
         bZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778121156; x=1778725956;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4vgs0xscu3MsVhFPXf5qWcASYOxg1W9AcmmIG28clo=;
        b=TjVKXs6Cz8166o3zdmuvjIMr36YzbW5LKs/j7KPZqoBOs0wCSIVoTzvu0QbCXyaI4F
         OWGrBPEII+7kC2rsVY6GPJwBA86eTyKjYDP4euP4Tz3k7I4HE4WPsh8RWtdvm2v9pxbC
         Kr3P7xJFyadOQ4ciLc5bl1IDbfFzXfl+LDbT6MZ5X49ctHPcDMcqBLsRVfEJKY6dRNmn
         VPMsUp/MeID/r4yZ9qRS95xa2MCL6qs2yfPHh6lOxA7royjf+mSwM0wClqOe7w7VyJU7
         1+NQ9q6zNtmUoY0verPPyfyrqhp9xbVhCpk9XHBtqGiWa6j9//0MBcNamDAIi/cLyzj3
         ET+w==
X-Gm-Message-State: AOJu0YxjvNM6QL63sr5Nhax2C1Yelkf7KFhEwCVm6k3kwYq48teTOZqr
	pvxU4XRdMare+K/qXPTcRFyGjDl0GrFs/8Od4/7kJ6rnQFtNHAt8X5RU
X-Gm-Gg: AeBDiet7hRS3Q9hIKCXsPW+Z2cCMIyZqFHHHoqUdMDARbzkIfb4x1tVVZG0yZ9fqQ6x
	27XXeyIIBeIw58CJ+qXccYQ6R57Z7GPgfT+i96JzF5YGJCcFk75GRgzkK4wRiT7o8Gicopo9NNH
	nbn62teHlw4HfcJBQoc/FOBgMnRgadRBMtA9lII+pSLfaassnHSBu0Y8Cg1Vutks0aOM3LA3r+2
	CXEqbF8qZEXFjGweqaJSPeodkkn9z06d62JqR422XhPnNgC2yXjEqZswxShD9kPxZ50+bKmOw7f
	bsoYdo7J67c7azgOb8d6TQ2LOrsooJMCt4pcxz0JjcCT2/5240D+LKATi9w/Gv9eDKPF7Uj9Qto
	Vj92qTNYN0m4it7MOdWvX48IrZobagHtlB0qy6hIMjHBn1XTpisJHvEW+TRa8jTjGxW2GjEE2Xv
	EKoexYBtNEoHYxpvw/Fsg3JXe+YcNj5qnsgwZutqUtFG3Qu2rFJsmz842R
X-Received: by 2002:a17:903:2f46:b0:2b2:3eec:c75b with SMTP id d9443c01a7336-2babc64a10dmr9337385ad.2.1778121155927;
        Wed, 06 May 2026 19:32:35 -0700 (PDT)
Received: from smtpclient.apple ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babadd2304sm6031105ad.42.2026.05.06.19.32.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2026 19:32:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2] sched_ext: Fix sched_ext_dead() race with
 scx_root_enable_workfn()
From: zhidao su <soolaugust@gmail.com>
In-Reply-To: <20260506061633.73070C2BCB8@smtp.kernel.org>
Date: Thu, 7 May 2026 10:32:21 +0800
Cc: sched-ext@lists.linux.dev,
 Tejun Heo <tj@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5636DBB8-B5F3-4F88-AA54-B388DB3A80F1@gmail.com>
References: <20260506054001.1105522-1-suzhidao@xiaomi.com>
 <20260506061633.73070C2BCB8@smtp.kernel.org>
To: sashiko@lists.linux.dev
X-Mailer: Apple Mail (2.3864.500.181)

On Wed, May 06 2026, sashiko-bot@kernel.org wrote:

> - [High] Calling `scx_set_task_state(p, SCX_TASK_READY)` without =
holding
>  `task_rq_lock(p)` introduces a Time-Of-Check to Time-Of-Use (TOCTOU)
>  data race against `sched_ext_dead()`.
> [...]
> Can this cause a Time-Of-Check to Time-Of-Use (TOCTOU) data race =
against
> sched_ext_dead()?

When p_dead is true the code does `continue`, so scx_set_task_state(p,
SCX_TASK_READY) is never reached for dead tasks. The TOCTOU window
doesn't exist.

> - [High] A memory ordering vulnerability defeats the bug 1 fix on =
weakly
>  ordered architectures, allowing the NULL pointer dereference to still =
occur.
> [...]
> Does this require a full write memory barrier (e.g., smp_wmb()) =
between
> setting the scheduler pointer and transitioning the state?

I'm not confident whether the store ordering between =
scx_set_task_sched()
and the state transition needs an explicit barrier here.

Tejun, what's the intended model for scx flags access in this path?

> - [Medium] Missing `SCX_TASK_OFF_TASKS` flag on the =
scx_root_enable_workfn()
>  cleanup path exposes dead tasks to cgroup iterators.
> [...]
> Is this cleanup path missing the SCX_TASK_OFF_TASKS flag?

Not needed here. scx_task_iter_next_locked() checks SCX_TASK_OFF_TASKS
only for cgroup-scoped iteration, which is only reachable from
scx_sub_enable_workfn(). That function requires scx_enabled() at entry;
scx_root_enable_workfn() has not called scx_ops_enable() yet at this
point, so no sub-sched enable can be running concurrently.


> 2026=E5=B9=B45=E6=9C=886=E6=97=A5 14:16=EF=BC=8Csashiko-bot@kernel.org =
=E5=86=99=E9=81=93=EF=BC=9A
>=20
> Thank you for your contribution! Sashiko AI review found 3 potential =
issue(s) to consider:
> - [High] Calling `scx_set_task_state(p, SCX_TASK_READY)` without =
holding `task_rq_lock(p)` introduces a Time-Of-Check to Time-Of-Use =
(TOCTOU) data race against `sched_ext_dead()`.
> - [High] A memory ordering vulnerability defeats the bug 1 fix on =
weakly ordered architectures, allowing the NULL pointer dereference to =
still occur.
> - [Medium] Missing `SCX_TASK_OFF_TASKS` flag on the =
`scx_root_enable_workfn()` cleanup path exposes dead tasks to cgroup =
iterators, causing sub-scheduler enables to abort.
> --
>=20
> commit 1d291365affa3415c03f2031e9198ebe7208a245
> Author: zhidao su <soolaugust@gmail.com>
>=20
> sched_ext: Fix sched_ext_dead() race with scx_root_enable_workfn()
>=20
> In CONFIG_EXT_SUB_SCHED, scx_task_sched(p) returns p->scx.sched =
instead
> of scx_root. scx_root_enable_workfn() iterates all tasks and for each
> releases scx_tasks_lock via scx_task_iter_unlock() before calling
> scx_init_task().
>=20
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 5600618dcef8e..98505577d56ca 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -3690,7 +3690,15 @@ static int scx_init_task(struct scx_sched =
*sch, struct task_struct *p, bool fork
>> /*
>> * While @p's rq is not locked. @p is not visible to the rest of
>> * SCX yet and it's safe to update the flags and state.
>> + *
>> + * Install p->scx.sched before transitioning state off NONE so
>> + * that the invariant state!=3DNONE =3D> p->scx.sched!=3DNULL holds =
as
>> + * soon as state becomes observable.  A concurrent sched_ext_dead()
>> + * that races the INIT window will then always find a valid
>> + * scheduler pointer and can call scx_disable_and_exit_task()
>> + * to release resources allocated by ops.init_task().
>> */
>> + scx_set_task_sched(p, sch);
>> p->scx.flags |=3D SCX_TASK_RESET_RUNNABLE_AT;
>> scx_set_task_state(p, SCX_TASK_INIT);
>> }
>=20
> Can this result in a memory ordering vulnerability on weakly ordered
> architectures?
>=20
> In scx_init_task(), scx_set_task_sched() uses rcu_assign_pointer(), =
which
> relies on smp_store_release(). While smp_store_release() guarantees =
prior
> operations are visible, it does not prevent subsequent memory =
operations
> from being reordered before the release.
>=20
> Could the CPU commit the store updating p->scx.flags to SCX_TASK_INIT
> before the store to p->scx.sched is completed? If a concurrent
> sched_ext_dead() observes state =3D=3D SCX_TASK_INIT, branches into =
the cleanup
> path, and reads a NULL scheduler pointer, it would pass it to
> scx_disable_and_exit_task() which crashes in SCX_HAS_OP().
>=20
> Does this require a full write memory barrier (e.g., smp_wmb()) =
between
> setting the scheduler pointer and transitioning the state?
>=20
> [ ... ]
>=20
>> @@ -7130,7 +7133,49 @@ static void scx_root_enable_workfn(struct =
kthread_work *work)
>> goto err_disable_unlock_all;
>> }
>>=20
>> - scx_set_task_sched(p, sch);
>> + /*
>> + * sched_ext_dead() may have raced while locks were dropped in
>> + * scx_task_iter_unlock().  Two cases:
>> + *
>> + * (a) sched_ext_dead() ran after scx_init_task() set state=3DINIT:
>> + *     it called scx_disable_and_exit_task() (cancelled=3Dtrue) and
>> + *     reset state to NONE.  ops.exit_task() already ran; skip.
>> + *
>> + * (b) sched_ext_dead() ran before scx_init_task() (state=3DNONE at
>> + *     the time): it skipped scx_disable_and_exit_task() because
>> + *     state was NONE.  scx_init_task() subsequently called
>> + *     ops.init_task() and set state=3DINIT, leaving allocated
>> + *     resources with no owner.  We must call
>> + *     scx_disable_and_exit_task() here to release them.
>> + *
>> + * Distinguish case (a) from (b) by reading state: (a) leaves
>> + * state=3DNONE (reset by scx_disable_and_exit_task); (b) leaves
>> + * state=3DINIT (set by scx_init_task, never reset).
>> + */
>> + {
>> + bool p_dead =3D false, need_exit =3D false;
>> +
>> + scoped_guard(raw_spinlock_irq, &scx_tasks_lock) {
>> + if (list_empty(&p->scx.tasks_node)) {
>> + p_dead =3D true;
>> + need_exit =3D scx_get_task_state(p) !=3D SCX_TASK_NONE;
>> + }
>> + }
>> +
>> + if (p_dead) {
>> + if (need_exit) {
>> + struct rq_flags rf;
>> + struct rq *rq;
>> +
>> + rq =3D task_rq_lock(p, &rf);
>> + scx_disable_and_exit_task(sch, p);
>> + task_rq_unlock(rq, p, &rf);
>=20
> Is this cleanup path missing the SCX_TASK_OFF_TASKS flag?
>=20
> If sched_ext_dead() runs before scx_init_task() completes, it sees =
state
> NONE and skips setting SCX_TASK_OFF_TASKS. When this cleanup path =
calls
> scx_disable_and_exit_task() under task_rq_lock(), the =
SCX_TASK_OFF_TASKS
> flag is not set before the runqueue is unlocked.
>=20
> Because the flag is missing, if a cgroup iterator traverses the cgroup
> before cgroup_task_dead() removes the task, could the iterator =
erroneously
> yield the dead task with state NONE, hit =
assert_task_ready_or_enabled(p),
> and abort the sub-scheduler enable?
>=20
>> + }
>> + put_task_struct(p);
>> + continue;
>> + }
>> + }
>> +
>> scx_set_task_state(p, SCX_TASK_READY);
>=20
> Can this cause a Time-Of-Check to Time-Of-Use (TOCTOU) data race =
against
> sched_ext_dead()?
>=20
> The code checks list_empty(&p->scx.tasks_node) under scx_tasks_lock to
> determine if a concurrent sched_ext_dead() has started processing.
>=20
> However, once scx_tasks_lock is dropped, sched_ext_dead() can acquire =
it,
> remove the task, and proceed to exit the task, eventually doing
> p->scx.flags |=3D SCX_TASK_OFF_TASKS under task_rq_lock(p).
>=20
> Meanwhile, scx_root_enable_workfn() continues past the lock and
> unconditionally calls scx_set_task_state(p, SCX_TASK_READY) without =
holding
> task_rq_lock(p). Because scx_set_task_state() performs a non-atomic
> read-modify-write on p->scx.flags, could this overwrite and =
permanently
> lose the SCX_TASK_OFF_TASKS flag?
>=20
> Also, could this incorrectly transition a dead task to SCX_TASK_READY =
after
> its scheduler resources were torn down, triggering a warning?
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/20260506054001.1105522-1-suzhidao@xiaomi.co=
m?part=3D1

