Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2D433E9E
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323375; cv=none; b=LJhW+YKSc+nqlPEb8Lrpp+fNQvBA13tCNTGi+slKUFFn+F+tawxLUJFICqADKkohxpSGOi71qb14LCQsLWZj8Wfq6SiNolKh/S07kMNaYx6WPFzlbKlvR9HsjpXsnKkRpEwKNKxjgO0Hvb67HBad1lIqRhzs6x8VdS8IetTPq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323375; c=relaxed/simple;
	bh=souQwihaoM5mdQ9AH0h5COguRQet04UrBsw/Ah8cQXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dXBIM6mbuHObw9t2C/Ber8lDR/Ol5H5wUD1OeUWW+j1tqXn99TkK1sNsEmEAWMj2OCTIjbA+fxfW271fFtxtEMxdRmyunPGJ0+KUw+w7W3HupXfZrtjjKymoA8ujiim26sywD5lGedRU1+JElxbpBpQvsVIQ0C65xm0lZ9wga2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyPFSI/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyPFSI/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3D41F000E9;
	Mon,  6 Jul 2026 07:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783323364;
	bh=yGkh3X8OsfYj6Ay6rUGvSG/PowdG/jiHKo0mdGvPAlc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OyPFSI/tLuKEih2AMZOyK634YsK5axK61B7GwmFctpYewyqdzcbitMB4R6EWM5p8Q
	 qaCFaAbFwxf90hzrSBzjWVARRiltnqG2Q6Qb5hXMk/II3z8egvLyT2ZmxhBjds3ezm
	 Tk0G8snWTbyDDB1LcYxmjcMtL7ari0U0lB7K29Hn/xS2jTLBNtP54JMpK/scJHK9C2
	 KfCXuKDleN7LwAJmJNda/isLgLfCRTmXHlqycMqPdatNigfzZHMnDosnRWzASM+1ho
	 o5LrGWsu13ztYZUu2dXKrl9M8RC02DMfAQaZTnR8JzTo9ah0zKjtIC5ZxYCT4cgn0C
	 LqcaOcZsBKpBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706070410.282826-7-arighi@nvidia.com>
References: <20260706070410.282826-1-arighi@nvidia.com>
 <20260706070410.282826-7-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 07:36:04 +0000
Message-Id: <20260706073604.BD3D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] task_proxy_cpu() locklessly accesses p->blocked_on and derefer=
ences the mutex to acquire its wait_lock, leading to a Use-After-Free if th=
e target task is awakened and the mutex is concurrently destroyed.
- [High] task_proxy_cpu() acquires p->blocked_lock using raw_spinlock witho=
ut disabling interrupts, risking a hard deadlock against hardware IRQ handl=
ers.
- [High] sched_proxy_block_task() asynchronously swaps the proxy donor to i=
dle without forcing a reschedule on the target CPU, leaving the target CPU =
to run the mutex owner indefinitely under idle accounting.
- [High] sched_setscheduler() fails to block proxy donors when transitionin=
g them to a BPF scheduler without SCX_OPS_ENQ_BLOCKED, violating scheduler =
admission policies.
- [High] scx_prepare_task_sched_change() is called locklessly, modifying ru=
nqueue state and updating the runqueue clock without holding rq->lock or pi=
_lock.
--

commit fbf923089be5e0555003149fc8823b7f5e5723f7
Author: Andrea Righi <arighi@nvidia.com>
Subject: sched_ext: Delegate proxy donor admission to BPF schedulers

Proxy execution keeps a blocked donor runnable so its scheduling context
can execute the mutex owner. This commit adds SCX_OPS_ENQ_BLOCKED to delega=
te
proxy execution admission to BPF schedulers, allowing them to handle blocked
donors according to their own policies. Schedulers without this capability
have their donors blocked normally via sched_proxy_block_task().

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3673b17f6098c..19a6a78ef8472 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c

[ ... ]

> @@ -6767,6 +6767,28 @@ static void proxy_deactivate(struct rq *rq, struct=
 task_struct *donor)
>  	block_task(rq, donor, state);
>  }
> =20
> +/*
> + * Remove a retained proxy donor before changing its scheduler ownership.
> + * The caller holds p->pi_lock, so p cannot wake and migrate after block=
_task()
> + * drops it from the runqueue.
> + */
> +void sched_proxy_block_task(struct rq *rq, struct task_struct *p)
> +{
> +	unsigned long state =3D READ_ONCE(p->__state);
> +
> +	lockdep_assert_held(&p->pi_lock);
> +	lockdep_assert_rq_held(rq);
> +
> +	if (!task_is_blocked(p) || !task_on_rq_queued(p))
> +		return;
> +	if (WARN_ON_ONCE(state =3D=3D TASK_RUNNING))
> +		return;
> +
> +	if (task_current_donor(rq, p))
> +		proxy_resched_idle(rq);
> +	block_task(rq, p, state);
> +}

[Severity: High]
Is this missing a resched_curr(rq) call?

When scx_prepare_task_sched_change() calls sched_proxy_block_task() remotel=
y, it
replaces rq->donor with rq->idle via proxy_resched_idle(rq). If no IPI is s=
ent
to notify the remote CPU (since resched_curr() is omitted), won't the remot=
e CPU
continue running the mutex owner indefinitely under idle accounting, comple=
tely
bypassing scheduler preemption?

[ ... ]

> @@ -7009,6 +7031,39 @@ find_proxy_task(struct rq *rq, struct task_struct =
*donor, struct rq_flags *rf)
>  	proxy_migrate_task(rq, rf, p, owner_cpu);
>  	return NULL;
>  }
> +
> +int task_proxy_cpu(struct task_struct *p)
> +{
> +	struct task_struct *owner;
> +	struct mutex *mutex;
> +	int owner_cpu;
> +
> +	if (!task_is_blocked(p))
> +		return -ENOENT;
> +
> +	mutex =3D READ_ONCE(p->blocked_on);
> +	if (!mutex)
> +		return -ENOENT;
> +
> +	guard(raw_spinlock)(&mutex->wait_lock);

[Severity: Critical]
Can this result in a use-after-free?

The scx_bpf_task_proxy_cpu() kfunc can invoke this on any RCU-protected tas=
k.
The lockless read of p->blocked_on above occurs without holding p->pi_lock =
or
rq->lock. If the target task concurrently wakes up, finishes its execution,=
 and
frees the mutex, the wait_lock acquisition here would be dereferencing freed
memory.

> +	guard(raw_spinlock)(&p->blocked_lock);

[Severity: High]
Can this cause a spinlock deadlock against hardware IRQs?

The scx_bpf_task_proxy_cpu() kfunc can be called from IRQ-enabled contexts =
like
BPF_PROG_TYPE_SYSCALL programs. Because guard(raw_spinlock) does not disable
interrupts (unlike raw_spinlock_irqsave), if an interrupt fires while the l=
ock
is held and tries to wake the same task (calling clear_task_blocked_on() fr=
om
hardirq context), it will deadlock trying to acquire p->blocked_lock.

[ ... ]

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 85e07cbe626f6..a47ddbf741ea3 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -23,6 +23,27 @@
> =20
>  DEFINE_RAW_SPINLOCK(scx_sched_lock);
> =20
> +bool scx_allow_proxy_exec(const struct task_struct *p)
> +{
> +	if (!task_on_scx(p))
> +		return true;
> +
> +	return scx_task_sched(p)->ops.flags & SCX_OPS_ENQ_BLOCKED;
> +}
> +
> +/*
> + * Called immediately before sched_change_begin(). The caller must pass
> + * DEQUEUE_NOCLOCK so the rq clock is updated only once.
> + */
> +void scx_prepare_task_sched_change(struct task_struct *p, struct scx_sch=
ed *sch)
> +{
> +	update_rq_clock(task_rq(p));
> +
> +	/* Block retained donors that the incoming scheduler cannot manage. */
> +	if (!(sch->ops.flags & SCX_OPS_ENQ_BLOCKED))
> +		sched_proxy_block_task(task_rq(p), p);
> +}

[Severity: High]
How are blocked donors handled when a task policy is changed via the
sched_setscheduler() syscall?

It appears __sched_setscheduler() changes the task's class but does not inv=
oke
scx_prepare_task_sched_change(), nor does scx_check_setscheduler() validate
this transition. If a blocked proxy donor transitions to a BPF scheduler th=
at
lacks SCX_OPS_ENQ_BLOCKED, won't it bypass the admission check and get enqu=
eued
as a normal runnable task instead of a blocked donor?

[ ... ]

> @@ -6950,6 +6985,10 @@ static void scx_root_enable_workfn(struct kthread_=
work *work)
> =20
>  		if (old_class !=3D new_class)
>  			queue_flags |=3D DEQUEUE_CLASS;
> +		if (new_class =3D=3D &ext_sched_class) {
> +			scx_prepare_task_sched_change(p, sch);
> +			queue_flags |=3D DEQUEUE_NOCLOCK;
> +		}
> =20
>  		scoped_guard (sched_change, p, queue_flags) {

[Severity: High]
Is it safe to call scx_prepare_task_sched_change() outside the sched_change=
 guard?

scx_prepare_task_sched_change() calls update_rq_clock() and
sched_proxy_block_task(), both of which strictly require rq->lock. However,=
 here
they are called locklessly before scoped_guard() acquires p->pi_lock and rq=
->lock.
Could this cause runqueue RB-tree corruption and lockdep panics?

[ ... ]

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 0504204272732..0a5b84575ba5a 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c

[ ... ]

> @@ -117,7 +117,9 @@ static void scx_fail_parent(struct scx_sched *sch,
>  		if (scx_task_on_sched(parent, p))
>  			continue;
> =20
> -		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
> +		scx_prepare_task_sched_change(p, parent);
> +		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
> +			      DEQUEUE_NOCLOCK) {

[Severity: High]
Same issue here. scx_prepare_task_sched_change() is called locklessly before
the rq->lock is acquired by the sched_change guard.

[ ... ]

> @@ -209,7 +211,9 @@ void scx_sub_disable(struct scx_sched *sch)
>  			continue;
>  		}
> =20
> -		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
> +		scx_prepare_task_sched_change(p, parent);
> +		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
> +			      DEQUEUE_NOCLOCK) {

[Severity: High]
Same issue here. scx_prepare_task_sched_change() is called locklessly.

[ ... ]

> @@ -503,7 +507,9 @@ void scx_sub_enable_workfn(struct kthread_work *work)
>  		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
>  			continue;
> =20
> -		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
> +		scx_prepare_task_sched_change(p, sch);
> +		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE |
> +			      DEQUEUE_NOCLOCK) {

[Severity: High]
Same issue here. scx_prepare_task_sched_change() is called locklessly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706070410.2828=
26-1-arighi@nvidia.com?part=3D6
