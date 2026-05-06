Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CB635893
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778048194; cv=none; b=SR8W2jkY7hrID8NlnjBSmIigYRr8zMd9YbOHC8WaJ64flc+7dJK+jxqn1NWPTMw5FPyxvISdMr6QsKxg5O2AcBAL4/ykWXMzwL4NnRcDtUq9Gyg8UP7eOh+mlq5DfHhvjVxvulo5r/WyJxRivUpXVFWqw2gNCSIu/lpSGPS+bGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778048194; c=relaxed/simple;
	bh=YafaXHe9xW8qAvONGlbzR//saBWHJoBvegAJEAdEgSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b2LwfBtkBdOq7RhrDDPmAL33OVcCCTO+bKcTgA+MfDN9BZY5QON0WrkbGqzeQVu8ueEATeFijnSgyDTWE8+4IZ0Fc0DuK5ud91RXwwTjRXtkCgAZIvZvmlNGW/lziPsaKcQWIXy9G23HvbyyGlF+TQ6vjWvRhlTB69HvLFNfIYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiBshIFL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiBshIFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73070C2BCB8;
	Wed,  6 May 2026 06:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778048193;
	bh=YafaXHe9xW8qAvONGlbzR//saBWHJoBvegAJEAdEgSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oiBshIFLJHGMef1MAYAYCOL8kHTxIeMibY+R1cKMTAeUhEAudVlgyEGtGRjE3yrrC
	 ycyj9h0BFdHfCLGXS10zFrwXeNkWom1sDQTmkZLPly43ap+J2LKDMAOcMxKcVvv5SH
	 bdHd1N/Hl93NlMMgpFhVTvWbBmT2vzRfQQwv0j2yKfRoNsOp6hn87v/QFq0fdIWYcn
	 crggIXpxRTQ9fi4YvqI53pTuUlmQ83OeuMgyjYWB9KbSjoz6oIscH8S8Ux9b9j07Y+
	 6xYWNSM8nl8rINbl045TRolCeT/5rJu0f6AIaWg52y0W8DHW6S/Mq12qTNacmFZVHw
	 bvK7Uje4sLOAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] sched_ext: Fix sched_ext_dead() race with
 scx_root_enable_workfn()
Reply-To: sashiko@lists.linux.dev
To: "zhidao su" <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260506054001.1105522-1-suzhidao@xiaomi.com>
References: <20260506054001.1105522-1-suzhidao@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 06:16:32 +0000
Message-Id: <20260506061633.73070C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Calling `scx_set_task_state(p, SCX_TASK_READY)` without holding `t=
ask_rq_lock(p)` introduces a Time-Of-Check to Time-Of-Use (TOCTOU) data rac=
e against `sched_ext_dead()`.
- [High] A memory ordering vulnerability defeats the bug 1 fix on weakly or=
dered architectures, allowing the NULL pointer dereference to still occur.
- [Medium] Missing `SCX_TASK_OFF_TASKS` flag on the `scx_root_enable_workfn=
()` cleanup path exposes dead tasks to cgroup iterators, causing sub-schedu=
ler enables to abort.
--

commit 1d291365affa3415c03f2031e9198ebe7208a245
Author: zhidao su <soolaugust@gmail.com>

sched_ext: Fix sched_ext_dead() race with scx_root_enable_workfn()

In CONFIG_EXT_SUB_SCHED, scx_task_sched(p) returns p->scx.sched instead
of scx_root. scx_root_enable_workfn() iterates all tasks and for each
releases scx_tasks_lock via scx_task_iter_unlock() before calling
scx_init_task().

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5600618dcef8e..98505577d56ca 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3690,7 +3690,15 @@ static int scx_init_task(struct scx_sched *sch, st=
ruct task_struct *p, bool fork
>  		/*
>  		 * While @p's rq is not locked. @p is not visible to the rest of
>  		 * SCX yet and it's safe to update the flags and state.
> +		 *
> +		 * Install p->scx.sched before transitioning state off NONE so
> +		 * that the invariant state!=3DNONE =3D> p->scx.sched!=3DNULL holds as
> +		 * soon as state becomes observable.  A concurrent sched_ext_dead()
> +		 * that races the INIT window will then always find a valid
> +		 * scheduler pointer and can call scx_disable_and_exit_task()
> +		 * to release resources allocated by ops.init_task().
>  		 */
> +		scx_set_task_sched(p, sch);
>  		p->scx.flags |=3D SCX_TASK_RESET_RUNNABLE_AT;
>  		scx_set_task_state(p, SCX_TASK_INIT);
>  	}

Can this result in a memory ordering vulnerability on weakly ordered
architectures?

In scx_init_task(), scx_set_task_sched() uses rcu_assign_pointer(), which
relies on smp_store_release(). While smp_store_release() guarantees prior
operations are visible, it does not prevent subsequent memory operations
from being reordered before the release.

Could the CPU commit the store updating p->scx.flags to SCX_TASK_INIT
before the store to p->scx.sched is completed? If a concurrent
sched_ext_dead() observes state =3D=3D SCX_TASK_INIT, branches into the cle=
anup
path, and reads a NULL scheduler pointer, it would pass it to
scx_disable_and_exit_task() which crashes in SCX_HAS_OP().

Does this require a full write memory barrier (e.g., smp_wmb()) between
setting the scheduler pointer and transitioning the state?

[ ... ]

> @@ -7130,7 +7133,49 @@ static void scx_root_enable_workfn(struct kthread_=
work *work)
>  			goto err_disable_unlock_all;
>  		}
> =20
> -		scx_set_task_sched(p, sch);
> +		/*
> +		 * sched_ext_dead() may have raced while locks were dropped in
> +		 * scx_task_iter_unlock().  Two cases:
> +		 *
> +		 * (a) sched_ext_dead() ran after scx_init_task() set state=3DINIT:
> +		 *     it called scx_disable_and_exit_task() (cancelled=3Dtrue) and
> +		 *     reset state to NONE.  ops.exit_task() already ran; skip.
> +		 *
> +		 * (b) sched_ext_dead() ran before scx_init_task() (state=3DNONE at
> +		 *     the time): it skipped scx_disable_and_exit_task() because
> +		 *     state was NONE.  scx_init_task() subsequently called
> +		 *     ops.init_task() and set state=3DINIT, leaving allocated
> +		 *     resources with no owner.  We must call
> +		 *     scx_disable_and_exit_task() here to release them.
> +		 *
> +		 * Distinguish case (a) from (b) by reading state: (a) leaves
> +		 * state=3DNONE (reset by scx_disable_and_exit_task); (b) leaves
> +		 * state=3DINIT (set by scx_init_task, never reset).
> +		 */
> +		{
> +			bool p_dead =3D false, need_exit =3D false;
> +
> +			scoped_guard(raw_spinlock_irq, &scx_tasks_lock) {
> +				if (list_empty(&p->scx.tasks_node)) {
> +					p_dead =3D true;
> +					need_exit =3D scx_get_task_state(p) !=3D SCX_TASK_NONE;
> +				}
> +			}
> +
> +			if (p_dead) {
> +				if (need_exit) {
> +					struct rq_flags rf;
> +					struct rq *rq;
> +
> +					rq =3D task_rq_lock(p, &rf);
> +					scx_disable_and_exit_task(sch, p);
> +					task_rq_unlock(rq, p, &rf);

Is this cleanup path missing the SCX_TASK_OFF_TASKS flag?

If sched_ext_dead() runs before scx_init_task() completes, it sees state
NONE and skips setting SCX_TASK_OFF_TASKS. When this cleanup path calls
scx_disable_and_exit_task() under task_rq_lock(), the SCX_TASK_OFF_TASKS
flag is not set before the runqueue is unlocked.

Because the flag is missing, if a cgroup iterator traverses the cgroup
before cgroup_task_dead() removes the task, could the iterator erroneously
yield the dead task with state NONE, hit assert_task_ready_or_enabled(p),
and abort the sub-scheduler enable?

> +				}
> +				put_task_struct(p);
> +				continue;
> +			}
> +		}
> +
>  		scx_set_task_state(p, SCX_TASK_READY);

Can this cause a Time-Of-Check to Time-Of-Use (TOCTOU) data race against
sched_ext_dead()?

The code checks list_empty(&p->scx.tasks_node) under scx_tasks_lock to
determine if a concurrent sched_ext_dead() has started processing.

However, once scx_tasks_lock is dropped, sched_ext_dead() can acquire it,
remove the task, and proceed to exit the task, eventually doing
p->scx.flags |=3D SCX_TASK_OFF_TASKS under task_rq_lock(p).

Meanwhile, scx_root_enable_workfn() continues past the lock and
unconditionally calls scx_set_task_state(p, SCX_TASK_READY) without holding
task_rq_lock(p). Because scx_set_task_state() performs a non-atomic
read-modify-write on p->scx.flags, could this overwrite and permanently
lose the SCX_TASK_OFF_TASKS flag?

Also, could this incorrectly transition a dead task to SCX_TASK_READY after
its scheduler resources were torn down, triggering a warning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506054001.1105=
522-1-suzhidao@xiaomi.com?part=3D1
