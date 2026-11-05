Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910811;
	b=IyTOgCLu794Y/4XGjc2BURAIG+4TN9Zj0Kvkv6vhuyWFrbbAY0VGmIyGAmXaPgddXM6e
	 Bx85TRDyzbB5G2O78epBIEVSYbkbjpOzkAoTYTlZ4qtMfXZUXFN46wkx1cqXjA+XEut1V
	 PBciUXhMcaddytcEZpYW0Utzm/GAJw0wcUcyqll1DPD/vNEKjNwlKuMtZDXA8gKIRc6Wf
	 /6Y/213GDz5BZpG/cuMZFMmaWr4RQcfX7ILlK8ErsTSeuqsn8HPBxYfofW2E+nAQokVCL
	 FIMfHaYZQjDI8+jYObKVYUzn5Skn7AHgLpEGZC1K6jhsXNrofO4YMxKjfbr3tjBOLkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910811;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P/Bsy37Bzh45Q+um6Yxg+ZiZr825uDNRkO+9s/JT654=;
	b=EjhZxdUlkOKw+bWCT/ax8r6255ozQdScuzUlTwUTMQg6dsRHZ36lNLmaPRjUXiuexU3G
	 IPEaLzkohWauzlxGWew1Fxu+aDUC/8iBZIh5yL+6hMvc2Cd12b+do/8cXCP1q3bhMQ8mN
	 Th49u6QwQC6VfbUx88qXrKCictsUEso2EexkG1VrCdorwQwHK5YJbMZPpBf7Yq7+MZ3tB
	 pNPFyVrJU9k0wqgEUYS8W5/CxJ75kCPZAi5zRIzfKPxVVmUN0lyGv1xeUe8gCMA47WazV
	 wHyDs5us6xxD44no0BXqy0nGJAeubExCA1ds2O5T+vqrzXk7sSi5ymKyhzyjOH11k4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7qdneVk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34801606A32F
	for <sched-ext@lists.linux.dev>; Thu,  5 Nov 2026 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7qdneVk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A057F1F0089F;
	Thu,  5 Nov 2026 20:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793910810;
	bh=P/Bsy37Bzh45Q+um6Yxg+ZiZr825uDNRkO+9s/JT654=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P7qdneVkLlfpJF5GrEtgTNswIE+zu6iEZqoNj1d4yCch0OrrAWmBV5MFw1wHiBwRl
	 8Zxwybg/dYpgBFNFT0EjQ17MYiDwGpi4crm9EDi+kZSlhZ7j5EN+D1+Vs+ALS+pKp/
	 AXtUgOFb78O8rVM4Y6YNhR+ZvnYUhbGjLo+77Tu0JlneAI6AvuiA9e/E1FALA2McQ/
	 50hU1soSmA9769W4ijKHTJaOQVnOUITdWaWtn94bj/N5g3yYJeOOCXMSKOtjOPtmJg
	 nZ/+NorALPNzGjDg4rYfJ31ebXQI1y9/UpX4a0VYQs5ouTvDkDsbfSuA2dPPkfxvA2
	 y8u7u2oGfTMJA==
Message-ID: <sashiko-outbox-200111@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add scx_tickbug, a scheduler that holds
 a task on an idle CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Radu Toader" <radu.m.toader@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261105200205.1178097-2-radu.m.toader@gmail.com>
References: <20261105200205.1178097-1-radu.m.toader@gmail.com>
 <20261105200205.1178097-2-radu.m.toader@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:33:30 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Medium] sched_ext: SCX_OPS_ENQ_LAST in tickbug_enqueue() fails to hold o=
r stalls tasks
- [Medium] sched_ext: global held_at overwritten across queued tasks in tic=
kbug_enqueue()
- [Medium] sched_ext: missing ops.dequeue in scx_tickbug corrupts hold_q an=
d nr_held_now
- [Medium] sched_ext: scx_tickbug fails to ensure release_timer is armed on=
 timer_cpu
- [Medium] sched_ext: scx_tickbug runs untagged tasks on target_cpu during =
hold
- [Medium] sched_ext: missing nr_cpu_ids check for default timer_cpu in scx=
_tickbug
--

commit 1398ab9e5efd3cabedac623d79d370424ce29d54
Author: Radu Toader <radu.m.toader@gmail.com>

sched_ext: Add scx_tickbug, a scheduler that holds a task on an idle CPU

This commit adds the scx_tickbug test scheduler to hold tasks named "spin"
runnable in a BPF queue while the target CPU remains in the idle loop until
a periodic timer pinned to another CPU releases them.

> diff --git a/tools/sched_ext/scx_tickbug.bpf.c b/tools/sched_ext/scx_tick=
bug.bpf.c
> new file mode 100644
> index 0000000000000..e6a6d627f042e
> --- /dev/null
> +++ b/tools/sched_ext/scx_tickbug.bpf.c
[ ... ]
> +s32 BPF_STRUCT_OPS(tickbug_select_cpu, struct task_struct *p,
> +		   s32 prev_cpu, u64 wake_flags)
> +{
> +	if (is_tagged(p))
> +		return target_cpu;
> +	return prev_cpu;
> +}

[Severity: Medium]
What happens when an untagged task wakes up with prev_cpu =3D=3D target_cpu=
 while
target_cpu is idling with a tagged task held in hold_q?

Because tickbug_select_cpu() returns prev_cpu, ttwu_do_activate() enqueues =
the
untagged task on target_cpu and calls wakeup_preempt(), which sees
rq->next_class =3D=3D &idle_sched_class and calls resched_curr() on target_=
cpu.
That forces target_cpu out of do_idle() (calling tick_nohz_idle_exit()) and
into tickbug_dispatch():

	if (cpu =3D=3D target_cpu && release_now) {
		release_now =3D false;
		if (release_one())
			return;
	}

	scx_bpf_dsq_move_to_local(SHARED_DSQ, 0);

When release_now is false, tickbug_dispatch() falls through to
scx_bpf_dsq_move_to_local(SHARED_DSQ, 0) even while nr_held_now > 0 (or when
prev on target_cpu is a tagged task whose slice just expired), so target_cpu
executes untagged tasks from SHARED_DSQ instead of remaining idle. Later,
release_one() still credits the entire now - held_at interval to
total_held_ns and max_held_ns as if target_cpu had been idle the whole time.

Should tickbug_select_cpu() avoid returning target_cpu for untagged tasks, =
and
should tickbug_dispatch() avoid pulling from SHARED_DSQ onto target_cpu whi=
le
a tagged task is held?

> +
> +void BPF_STRUCT_OPS(tickbug_enqueue, struct task_struct *p, u64 enq_flag=
s)
> +{
> +	s32 pid =3D p->pid;
> +
> +	__sync_fetch_and_add(&nr_enq, 1);
> +
> +	/*
> +	 * Per-CPU kthreads go to the head of their own CPU's local DSQ with
> +	 * preemption. The release timer runs from a softirq, so if a kthread
> +	 * such as ksoftirqd were starved behind a user task the held task
> +	 * would never be released.
> +	 */
> +	if ((p->flags & PF_KTHREAD) && p->nr_cpus_allowed =3D=3D 1) {
> +		__sync_fetch_and_add(&nr_locals, 1);
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, slice_ns,
> +				   enq_flags | SCX_ENQ_PREEMPT);
> +		return;
> +	}
> +
> +	if (is_tagged(p)) {
> +		if (scx_bpf_task_cpu(p) !=3D target_cpu) {
> +			/*
> +			 * ops.select_cpu() is only a hint and is not called on
> +			 * every path. Counted rather than forced: a run with a
> +			 * non-zero count here did not test what it meant to.
> +			 */
> +			__sync_fetch_and_add(&nr_other_cpu, 1);
> +		} else if (scx_bpf_task_running(p)) {
> +			/*
> +			 * Already on the CPU and merely re-enqueued, e.g. after
> +			 * a kthread preempted it. Holding it here would take
> +			 * CPU away from work already in progress, which is not
> +			 * the state under test: the hold belongs at the start
> +			 * of a run, not in the middle of one. Put it straight
> +			 * back so it carries on.
> +			 */
> +			__sync_fetch_and_add(&nr_requeue, 1);
> +			scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, slice_ns, enq_flags);
> +			return;
> +		} else if (bpf_map_push_elem(&hold_q, &pid, 0)) {
> +			__sync_fetch_and_add(&nr_overflow, 1);
> +		} else {
> +			/*
> +			 * This is the whole scheduler. The task is already in
> +			 * target_cpu's rq->nr_running; parking its pid here
> +			 * and deliberately not kicking the CPU leaves it in
> +			 * the idle loop with a runnable task queued.
> +			 */
> +			held_at =3D scx_bpf_now() ?: 1;
> +			__sync_fetch_and_add(&nr_held, 1);
> +			__sync_fetch_and_add(&nr_held_now, 1);
> +			return;
> +		}
> +	}
> +
> +	__sync_fetch_and_add(&nr_passthru, 1);
> +	scx_bpf_dsq_insert(p, SHARED_DSQ, slice_ns, enq_flags);
> +}

[Severity: Medium]
Does SCX_OPS_ENQ_LAST in tickbug_ops work as intended with tickbug_enqueue(=
)?

When the sole runnable task on a CPU exhausts its slice and SHARED_DSQ is
empty, SCX_OPS_ENQ_LAST prevents dispatch_one() from keeping prev running v=
ia
SCX_DSP_PREV. Instead, __pick_next_task() picks next =3D rq->idle and
put_prev_set_next_task() calls:

  put_prev_task_scx(rq, prev, rq->idle)
    -> scx_do_enqueue_task(rq, prev, SCX_ENQ_LAST, -1)
      -> tickbug_enqueue(prev, SCX_ENQ_LAST)

Because __schedule() only updates rq->donor to next via rq_set_donor(rq, ne=
xt)
after pick_next_task() returns, task_rq(p)->donor is still p throughout
put_prev_task_scx(). As a result, scx_bpf_task_running(p) (which checks
rcu_access_pointer(task_rq(p)->donor) =3D=3D p) is always true on every
SCX_ENQ_LAST enqueue:

1. For a tagged spin task on target_cpu, tickbug_enqueue() always takes the
scx_bpf_task_running(p) branch, increments nr_requeue, and inserts p back i=
nto
SCX_DSQ_LOCAL instead of holding it in hold_q. In put_prev_task_scx(),
going_idle && p->scx.dsq =3D=3D &rq->scx.local_dsq then sets need_resched on
rq->idle, so target_cpu switches to rq->idle, enters do_idle() (calling
tick_nohz_idle_enter() and tick_nohz_idle_exit()), and immediately switches
back to spin on every slice expiry.

2. For an untagged task (or a tagged task not on target_cpu) enqueued with
SCX_ENQ_LAST, tickbug_enqueue() inserts it into SHARED_DSQ without kicking =
the
CPU. Because p->scx.dsq is not &rq->scx.local_dsq, put_prev_task_scx() does
not set need_resched on rq->idle, and the CPU switches to rq->idle and goes=
 to
sleep with the task stranded in SHARED_DSQ.

Should tickbug_enqueue() check (enq_flags & SCX_ENQ_LAST) before treating
scx_bpf_task_running(p) as a mid-run preemption, and either insert untagged
SCX_ENQ_LAST tasks into SCX_DSQ_LOCAL or kick the CPU?

> +
> +/* Let one held task run on the CPU we are dispatching for. */
> +static bool release_one(void)
> +{
> +	struct task_struct *p;
> +	s32 pid;
> +
> +	bpf_repeat(BPF_MAX_LOOPS) {
> +		u64 now, at;
> +
> +		if (bpf_map_pop_elem(&hold_q, &pid))
> +			return false;
> +
> +		p =3D bpf_task_from_pid(pid);
> +		if (!p) {
> +			__sync_fetch_and_add(&nr_lost, 1);
> +			__sync_fetch_and_sub(&nr_held_now, 1);
> +			continue;
> +		}
> +
> +		/*
> +		 * Affinity may have changed while the task sat in the queue.
> +		 * Such a task goes to the shared DSQ instead of being pinned
> +		 * to a CPU it is no longer allowed on.
> +		 */
> +		if (!bpf_cpumask_test_cpu(target_cpu, p->cpus_ptr) ||
> +		    is_migration_disabled(p)) {
> +			scx_bpf_dsq_insert(p, SHARED_DSQ, slice_ns, 0);
> +			bpf_task_release(p);
> +			__sync_fetch_and_sub(&nr_held_now, 1);
> +			if (!scx_bpf_dispatch_nr_slots())
> +				return false;
> +			continue;
> +		}
> +
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, slice_ns, 0);
> +		bpf_task_release(p);
> +		__sync_fetch_and_sub(&nr_held_now, 1);
> +
> +		at =3D held_at;
> +		now =3D scx_bpf_now();
> +		if (at && now > at) {
> +			u64 d =3D now - at;
> +
> +			__sync_fetch_and_add(&total_held_ns, d);
> +			if (d > max_held_ns)
> +				max_held_ns =3D d;
> +		}
> +		held_at =3D 0;
> +
> +		__sync_fetch_and_add(&nr_released, 1);
> +		return true;
> +	}
> +
> +	return false;
> +}

[Severity: Medium]
Can a single global held_at variable track hold duration when multiple tagg=
ed
tasks are queued in hold_q?

hold_q has 1024 entries and nr_held_now counts how many tagged tasks are
currently held, but held_at is a single global scalar. If two spin tasks are
queued in hold_q before release_one() runs:

1. The second task's tickbug_enqueue() overwrites held_at with its own
timestamp and increments nr_held_now to 2.

2. When release_one() pops the first task, it computes now - held_at using =
the
second task's timestamp, clears held_at =3D 0, decrements nr_held_now to 1,=
 and
increments nr_released.

3. On the next timer tick, nr_held_now is still 1, so release_timerfn() kic=
ks
target_cpu with SCX_KICK_PREEMPT (preempting the first released task mid-ru=
n),
and release_one() pops the second task with held_at =3D=3D 0, adding nothin=
g to
total_held_ns while incrementing nr_released again, which skews the mean ho=
ld
reported by main() (total_held_ns / released).

Should the enqueue timestamp be stored alongside pid in the hold_q map value
struct instead of in a single global variable?

[ ... ]
> +void BPF_STRUCT_OPS(tickbug_dispatch, s32 cpu, struct task_struct *prev)
> +{
> +	/*
> +	 * Arm the timer from the CPU it must be pinned to. ops.init() runs in
> +	 * whatever context loaded the scheduler, which is the wrong CPU.
> +	 */
> +	if (cpu =3D=3D timer_cpu)
> +		start_release_timer();

[Severity: Medium]
Can start_release_timer() pin release_timer to the wrong CPU or fail to run
when timer_cpu is busy?

First, start_release_timer() calls bpf_timer_start(timer, hold_ns,
BPF_F_TIMER_CPU_PIN), which pins the hrtimer to bpf_get_smp_processor_id()
rather than the cpu argument passed to tickbug_dispatch(). Under
CONFIG_SCHED_CORE, pick_next_task() on target_cpu can invoke
dispatch_core_pick() -> tickbug_dispatch(timer_cpu, prev) for its SMT sibli=
ng
while executing on target_cpu. Because cpu =3D=3D timer_cpu is true while
bpf_get_smp_processor_id() =3D=3D target_cpu, release_timer is pinned to
target_cpu and release_timerfn() then aborts the scheduler via scx_bpf_erro=
r()
when curr_cpu =3D=3D target_cpu.

Second, tickbug_init() calls scx_bpf_kick_cpu(timer_cpu, 0) before
__scx_enabled is set and before tasks are switched to ext_sched_class. When
SCX is enabled and resched_curr() runs on timer_cpu, if timer_cpu is runnin=
g a
task with remaining slice (prev->scx.slice > 0), dispatch_one() returns
SCX_DSP_PREV without calling tickbug_dispatch(), leaving release_timer
unstarted unless timer_cpu is kicked with SCX_KICK_PREEMPT when !timer_star=
ted.

Should start_release_timer() check bpf_get_smp_processor_id() =3D=3D timer_=
cpu,
and should tickbug_enqueue() kick timer_cpu with SCX_KICK_PREEMPT if
!timer_started?

[ ... ]
> +SCX_OPS_DEFINE(tickbug_ops,
> +	       /*
> +		* The last runnable task on a CPU has to come through
> +		* ops.enqueue() too, otherwise the tagged task would simply
> +		* keep running on @target_cpu and never be held.
> +		*/
> +	       .flags			=3D SCX_OPS_ENQ_LAST,
> +
> +	       .select_cpu		=3D (void *)tickbug_select_cpu,
> +	       .enqueue			=3D (void *)tickbug_enqueue,
> +	       .dispatch		=3D (void *)tickbug_dispatch,
> +	       .init			=3D (void *)tickbug_init,
> +	       .exit			=3D (void *)tickbug_exit,

[Severity: Medium]
Does tickbug_ops need an ops.dequeue callback to keep hold_q and nr_held_now
consistent when a held task leaves BPF custody?

In release_one(), the code checks whether a held task's affinity changed wh=
ile
it sat in hold_q:

	if (!bpf_cpumask_test_cpu(target_cpu, p->cpus_ptr) ||
	    is_migration_disabled(p)) {

However, when a task parked in hold_q undergoes an affinity change via
sched_setaffinity() (or a property change such as setpriority(),
sched_setscheduler(), or cgroup migration), the scheduler core calls
dequeue_task_scx() followed by enqueue_task_scx(). Without ops.dequeue:

1. If affinity changed away from target_cpu, move_queued_task() dequeues p
from target_cpu without decrementing nr_held_now and re-enqueues p on
dest_cpu !=3D target_cpu, where tickbug_enqueue() dispatches it immediately=
 to
SHARED_DSQ while leaving a stale pid in hold_q and nr_held_now inflated.

2. If the property change keeps p on target_cpu, enqueue_task_scx() calls
tickbug_enqueue() again while scx_bpf_task_running(p) is false, pushing a
duplicate pid into hold_q and incrementing nr_held_now to 2 for a single ta=
sk.
When the first timer tick releases the task, nr_held_now stays at 1, so the
next release_timerfn() tick kicks target_cpu with SCX_KICK_PREEMPT and
preempts the running task.

> diff --git a/tools/sched_ext/scx_tickbug.c b/tools/sched_ext/scx_tickbug.c
> new file mode 100644
> index 0000000000000..8acca5c1ff6ae
> --- /dev/null
> +++ b/tools/sched_ext/scx_tickbug.c
[ ... ]
> +	nr_cpu_ids =3D libbpf_num_possible_cpus();
> +	assert(nr_cpu_ids > 0);
> +	assert(nr_cpu_ids <=3D INT32_MAX);
> +
> +	skel->rodata->nr_cpu_ids =3D nr_cpu_ids;
> +	skel->rodata->target_cpu =3D 0;
> +	skel->rodata->timer_cpu =3D 1;
> +	skel->rodata->hold_ns =3D 10ULL * 1000 * 1000;
> +	skel->rodata->slice_ns =3D __COMPAT_ENUM_OR_ZERO("scx_public_consts", "=
SCX_SLICE_DFL");
> +
> +	while ((opt =3D getopt(argc, argv, "c:t:H:s:vh")) !=3D -1) {
> +		switch (opt) {
> +		case 'c':
> +		case 't': {
> +			unsigned long cpu =3D strtoul(optarg, NULL, 0);
> +
> +			if (cpu >=3D nr_cpu_ids) {
> +				fprintf(stderr, "invalid CPU id %lu (%u max)\n",
> +					cpu, nr_cpu_ids - 1);
> +				scx_tickbug__destroy(skel);
> +				return 1;
> +			}
> +			if (opt =3D=3D 'c')
> +				skel->rodata->target_cpu =3D (s32)cpu;
> +			else
> +				skel->rodata->timer_cpu =3D (s32)cpu;
> +			break;
> +		}
> +		case 'H':
> +			skel->rodata->hold_ns =3D strtoull(optarg, NULL, 0) * 1000 * 1000;
> +			break;
> +		case 's':
> +			skel->rodata->slice_ns =3D strtoull(optarg, NULL, 0) * 1000;
> +			break;
> +		case 'v':
> +			verbose =3D true;
> +			break;
> +		default:
> +			fprintf(stderr, help_fmt, basename(argv[0]));
> +			return opt !=3D 'h';
> +		}
> +	}

[Severity: Medium]
What happens if scx_tickbug is run without -t on a single-CPU system where
nr_cpu_ids =3D=3D 1?

In main(), skel->rodata->timer_cpu defaults to 1 while cpu >=3D nr_cpu_ids =
is
only checked inside the getopt() cases for -c and -t (and rodata->nr_cpu_ids
is never referenced in scx_tickbug.bpf.c). On a 1-CPU system, timer_cpu =3D=
 1
passes the target_cpu =3D=3D timer_cpu check, loads the BPF program, and th=
en
triggers scx_error() in scx_cpu_valid() when tickbug_init() calls
scx_bpf_kick_cpu(timer_cpu, 0). Also, the default branch in the getopt() lo=
op
returns without calling scx_tickbug__destroy(skel).

Should main() verify that nr_cpu_ids >=3D 2 (or validate timer_cpu < nr_cpu=
_ids
after the getopt() loop) and destroy skel before returning in the default
case?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105200205.1178=
097-1-radu.m.toader@gmail.com?part=3D1
