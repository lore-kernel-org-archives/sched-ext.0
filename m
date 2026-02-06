Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FED304BDE
	for <sched-ext@lists.linux.dev>; Fri,  6 Feb 2026 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770408658; cv=none; b=osWgwy443oKfeNFFAILf1QUXNQIwA2VUZWdlaeLnCaUe8TkUFoG31ozvtdDPLg/2Y3VXFTa+2l0UmRNEFCReNlv8X7viNn3JaNyO55lCdOeBHFYY9/G9kggfG4YdvKuo2GPLJc50jqK5qUeKQH1HwVBqzqYlQD0gq4QP6gBiCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770408658; c=relaxed/simple;
	bh=fOgcvdHcwE7Cc85kjFL/XUSzGtnz4b8M8XEA0Ckrrqg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ezL2ZBDcrUva1jwqcZXfx0tuNvxcnzmCxeeJK0/O7S1Uq6Ldv/MdZdB2tIsm2jvHJ8SLq7jVk5o86+pvwZxxXDSF/pW/A2mgc+918rv95BcVONKuXifiNc3i2MDwcL9KR1+dc4b5OCg1i/xOaQFidKiyrCe1keuXixHcbhPKEjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=TnffFQrO; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="TnffFQrO"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c711959442so294003285a.0
        for <sched-ext@lists.linux.dev>; Fri, 06 Feb 2026 12:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770408657; x=1771013457; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Urnk78pimz8iK8WydoY5TYTqAi0MT+OQ2hKUCSJ7bXg=;
        b=TnffFQrOsmYDpNM+tFoGBC5m6Tz+4sKXRvnKCerKOczViBnU/O98eUyQePS8N3PPdF
         k5h3liJ2kl/yaEyzcFWzJ+URLe5MjjCObftGi1bpiVmsVDs57Fl52GXOaiigOoUVfVDS
         YAZi5ut9FoONOizIIf/7zIifmu0HacIju5E6VMxX+byhGn9Ui8sjuhRGDRNVxLoSoe2o
         iBCPEGb4F+/CiZ94duu1DXkNveSDrKC14+8x25Hj4ohW7BcBm/BrYAq6vWKFdAytI5zM
         h4jpwurSn6bu/FPtq+g+W+NcxOzPcl+bSWFOalx+vScoMqZHt70lbhhAm3tBViDIN6eb
         rB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770408657; x=1771013457;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Urnk78pimz8iK8WydoY5TYTqAi0MT+OQ2hKUCSJ7bXg=;
        b=AjHJ/YNH2ZAZfEFYnhxaZc037ttaX24rPjYzlE2T6ncsR3AZR3ECYecMD/tTwHBcsK
         ugpb4Ump++q/jfBkzAchPNeOpeAdDJQCRpnDtDV4pakxYQqMjMA/8YhGvZDt57eRqO44
         Y6OE0z/hdEutYo3yTjq/aX9xiDyrFcFkOiHj8yDAkI8KGcwhFrrGT5yPOIsHxBY/HXye
         3te8Pw+LOxjNU02uLqJxLegmZCImRmVh9wGQJyaxOrUSVHDzoLEkE0WLinZvAEAtqigW
         OT7NgdTAC8ahgLl61Gi6jgWsQYB3dj3oi3Z3mI0EuF1WuFK39G3lEHMugwC+UERkmFJ1
         ZpOg==
X-Forwarded-Encrypted: i=1; AJvYcCW4jL/IPArqlkHg2yAAn9MWjwfAuylKaRkWsLVwl+gSMFN382Mct5/3fACV5cvSmLghROyaa78pluY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwnBTRkplQMTLTw4tMilzloCDMyhVYznw4R58JqlmM+AQEUBhRr
	/TF8BIGTh260jRTfwaYpASQUn6jmiAuAr4oklDaqBR/S3ItzACRfT6y2T/OGpDbnero=
X-Gm-Gg: AZuq6aLSWjf0KjazlLe9QB8hsCh/6iC7/T2eGG4anJD2zp1NMahOpkH6kH1WvKoaUyn
	ayC9pR1ddMAROJYedf6ZKK2lPMP58NzRXsdZir3m0Xyu4NkrB+JeOtC+HG4Xd7P4Ej8p0CeSvU+
	LCmztei7zmIkRIEfxXj06Wt9KbkYWWQNcdxbk9kGs7FdC+lZJFlH4EnRm3JlKJyi7WbU29visUi
	DbdzDTPTRBNdPtz/BsyJkp76yU7QUR/GhpxOQY+J26UiAfAM+P9rzCPsIqzHA8ZTN3rlTK9TvWW
	oAZOlfL7+Ml1Su6Dj4DAErCOzuVSFQWgVSvwLZr7EEMJH5F4x7r+kqVhcRlPwoqOgAkUrvlqoiW
	jW8wH76dsfvnTRBz7DoJelFglC4sEPn0LyTpQMkX+sJYM+M5mcH/M4vUm0p3kfe981DM7FcoApl
	/s9sAChc68Nbo=
X-Received: by 2002:a05:620a:4004:b0:8ac:70cd:8727 with SMTP id af79cd13be357-8ca40b82db6mr1085437785a.11.1770408656721;
        Fri, 06 Feb 2026 12:10:56 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9a16558sm220731185a.27.2026.02.06.12.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 12:10:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Feb 2026 15:10:55 -0500
Message-Id: <DG85HO9OMIUH.278JKOJEN6QPL@etsalapatis.com>
Cc: "Kuba Piecuch" <jpiecuch@google.com>, "Christian Loehle"
 <christian.loehle@arm.com>, "Daniel Hodges" <hodgesd@meta.com>,
 <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrea Righi" <arighi@nvidia.com>, "Tejun Heo" <tj@kernel.org>, "David
 Vernet" <void@manifault.com>, "Changwoo Min" <changwoo@igalia.com>
X-Mailer: aerc 0.20.1
References: <20260206135742.2339918-1-arighi@nvidia.com>
 <20260206135742.2339918-3-arighi@nvidia.com>
In-Reply-To: <20260206135742.2339918-3-arighi@nvidia.com>

On Fri Feb 6, 2026 at 8:54 AM EST, Andrea Righi wrote:

Hi Andrea,

> Add a new kselftest to validate that the new ops.dequeue() semantics
> work correctly for all task lifecycle scenarios, including the
> distinction between terminal DSQs (where BPF scheduler is done with the
> task), user DSQs (where BPF scheduler manages the task lifecycle) and
> BPF data structures, regardless of which event performs the dispatch.
>
> The test validates the following scenarios:
>
>  - From ops.select_cpu():
>      - scenario 0 (local DSQ): tasks dispatched to the local DSQ bypass
>        the BPF scheduler entirely; they never enter BPF custody, so
>        ops.dequeue() is not called,
>      - scenario 1 (global DSQ): tasks dispatched to SCX_DSQ_GLOBAL also
>        bypass the BPF scheduler, like the local DSQ; ops.dequeue() is
>        not called,
>      - scenario 2 (user DSQ): tasks enter BPF scheduler custody with full
>        enqueue/dequeue lifecycle tracking and state machine validation
>        (expects 1:1 enqueue/dequeue pairing).

Could you add a note here about why there's no equivalent to scenario 6?
The differentiating factor between that and scenario 2 (nonterminal queue) =
is=20
that scx_dsq_insert_commit() is called regardless of whether the queue is t=
erminal.
And this makes sense since for non-DSQ queues the BPF scheduler can do its
own tracking of enqueue/dequeue (plus it does not make too much sense to
do BPF-internal enqueueing in select_cpu).

What do you think? If the above makes sense, maybe we should spell it out=
=20
in the documentation too. Maybe also add it makes no sense to enqueue
in an internal BPF structure from select_cpu - the task is not yet
enqueued, and would have to go through enqueue anyway.

>
>    - From ops.enqueue():
>      - scenario 3 (local DSQ): same behavior as scenario 0,
>      - scenario 4 (global DSQ): same behavior as scenario 1,
>      - scenario 5 (user DSQ): same behavior as scenario 2,
>      - scenario 6 (BPF internal queue): tasks are stored in a BPF queue
>        in ops.enqueue() and consumed in ops.dispatch(); they remain in
>        BPF custody until dispatch, with full lifecycle tracking and 1:1
>        enqueue/dequeue validation.
>
> This verifies that:
>  - terminal DSQ dispatch (local, global) don't trigger ops.dequeue(),
>  - user DSQ / internal BPF data structure dispatch has exact 1:1
>    ops.enqueue()/dequeue() pairing,
>  - dispatch dequeues have no flags (normal workflow),
>  - property change dequeues have the %SCX_DEQ_SCHED_CHANGE flag set,
>  - no duplicate enqueues or invalid state transitions are happening,
>  - ops.enqueue() and ops.select_cpu() dispatch paths behave identically.
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Emil Tsalapatis <emil@etsalapatis.com>
> Cc: Kuba Piecuch <jpiecuch@google.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>  .../testing/selftests/sched_ext/dequeue.bpf.c | 403 ++++++++++++++++++
>  tools/testing/selftests/sched_ext/dequeue.c   | 258 +++++++++++
>  3 files changed, 662 insertions(+)
>  create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/dequeue.c
>
> diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/s=
elftests/sched_ext/Makefile
> index 5fe45f9c5f8fd..764e91edabf93 100644
> --- a/tools/testing/selftests/sched_ext/Makefile
> +++ b/tools/testing/selftests/sched_ext/Makefile
> @@ -161,6 +161,7 @@ all_test_bpfprogs :=3D $(foreach prog,$(wildcard *.bp=
f.c),$(INCLUDE_DIR)/$(patsubs
> =20
>  auto-test-targets :=3D			\
>  	create_dsq			\
> +	dequeue				\
>  	enq_last_no_enq_fails		\
>  	ddsp_bogus_dsq_fail		\
>  	ddsp_vtimelocal_fail		\
> diff --git a/tools/testing/selftests/sched_ext/dequeue.bpf.c b/tools/test=
ing/selftests/sched_ext/dequeue.bpf.c
> new file mode 100644
> index 0000000000000..4ba657ba1bff5
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
> @@ -0,0 +1,403 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A scheduler that validates ops.dequeue() is called correctly:
> + * - Tasks dispatched to terminal DSQs (local, global) bypass the BPF
> + *   scheduler entirely: no ops.dequeue() should be called
> + * - Tasks dispatched to user DSQs enter BPF custody: ops.dequeue() must=
 be
> + *   called when they leave custody
> + * - Every ops.enqueue() for non-terminal DSQs is followed by exactly on=
e
> + *   ops.dequeue() (validate 1:1 pairing and state machine)
> + *
> + * Copyright (c) 2026 NVIDIA Corporation.
> + */
> +
> +#include <scx/common.bpf.h>
> +
> +#define SHARED_DSQ	0
> +
> +/*
> + * Scenario 6: BPF internal queue. Tasks are stored here from ops.enqueu=
e()
> + * and consumed from ops.dispatch(), validating that tasks not on a user=
 DSQ
> + * (only on BPF internal structures) still get ops.dequeue() when they l=
eave.
> + */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_QUEUE);
> +	__uint(max_entries, 4096);

Nit: Can we make this larger? I don't think there's any downsides. I know
there's a mitigation for if the queue gets full, please see nit below.

> +	__type(value, s32);
> +} global_queue SEC(".maps");
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +UEI_DEFINE(uei);
> +
> +/*
> + * Counters to track the lifecycle of tasks:
> + * - enqueue_cnt: Number of times ops.enqueue() was called
> + * - dequeue_cnt: Number of times ops.dequeue() was called (any type)
> + * - dispatch_dequeue_cnt: Number of regular dispatch dequeues (no flag)
> + * - change_dequeue_cnt: Number of property change dequeues
> + */
> +u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, change_dequeue_cnt;
> +
> +/*
> + * Test scenarios (0-2: ops.select_cpu(), 3-6: ops.enqueue()):
> + * 0) Dispatch to local DSQ from ops.select_cpu() (terminal DSQ, bypasse=
s BPF
> + *    scheduler, no dequeue callbacks)
> + * 1) Dispatch to global DSQ from ops.select_cpu() (terminal DSQ, bypass=
es BPF
> + *    scheduler, no dequeue callbacks)
> + * 2) Dispatch to shared user DSQ from ops.select_cpu() (enters BPF sche=
duler,
> + *    dequeue callbacks expected)
> + * 3) Dispatch to local DSQ from ops.enqueue() (terminal DSQ, bypasses B=
PF
> + *    scheduler, no dequeue callbacks)
> + * 4) Dispatch to global DSQ from ops.enqueue() (terminal DSQ, bypasses =
BPF
> + *    scheduler, no dequeue callbacks)
> + * 5) Dispatch to shared user DSQ from ops.enqueue() (enters BPF schedul=
er,
> + *    dequeue callbacks expected)
> + * 6) BPF internal queue: store task PIDs in ops.enqueue(), consume in
> + *    ops.dispatch() and dispatch to local DSQ (validates dequeue for ta=
sks
> + *    in BPF custody but not on a user DSQ)
> + */
> +u32 test_scenario;
> +
> +/*
> + * Per-task state to track lifecycle and validate workflow semantics.
> + * State transitions:
> + *   NONE -> ENQUEUED (on enqueue)
> + *   ENQUEUED -> DISPATCHED (on dispatch dequeue)
> + *   DISPATCHED -> NONE (on property change dequeue or re-enqueue)
> + *   ENQUEUED -> NONE (on property change dequeue before dispatch)
> + */
> +enum task_state {
> +	TASK_NONE =3D 0,
> +	TASK_ENQUEUED,
> +	TASK_DISPATCHED,
> +};
> +
> +struct task_ctx {
> +	enum task_state state; /* Current state in the workflow */
> +	u64 enqueue_seq;       /* Sequence number for debugging */
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, struct task_ctx);
> +} task_ctx_stor SEC(".maps");
> +
> +static struct task_ctx *try_lookup_task_ctx(struct task_struct *p)
> +{
> +	return bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
> +}
> +
> +s32 BPF_STRUCT_OPS(dequeue_select_cpu, struct task_struct *p,
> +		   s32 prev_cpu, u64 wake_flags)
> +{
> +	struct task_ctx *tctx;
> +
> +	tctx =3D try_lookup_task_ctx(p);
> +	if (!tctx)
> +		return prev_cpu;
> +
> +	switch (test_scenario) {
> +	case 0:
> +		/*
> +		 * Scenario 0: Direct dispatch to local DSQ from select_cpu.
> +		 *
> +		 * Task bypasses BPF scheduler entirely: no enqueue
> +		 * tracking, no dequeue callbacks. Behavior should be
> +		 * identical to scenario 3.
> +		 */
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
> +		return prev_cpu;
> +
> +	case 1:
> +		/*
> +		 * Scenario 1: Direct dispatch to global DSQ from select_cpu.
> +		 *
> +		 * Like scenario 0, task bypasses BPF scheduler entirely.
> +		 * Behavior should be identical to scenario 4.
> +		 */
> +		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
> +		return prev_cpu;
> +
> +	case 2:
> +		/*
> +		 * Scenario 2: Dispatch to shared user DSQ from select_cpu.
> +		 *
> +		 * Task enters BPF scheduler management: track
> +		 * enqueue/dequeue lifecycle and validate state transitions.
> +		 * Behavior should be identical to scenario 5.
> +		 */
> +		__sync_fetch_and_add(&enqueue_cnt, 1);
> +
> +		/*
> +		 * Validate state transition: enqueue is only valid from
> +		 * NONE or DISPATCHED states. Getting enqueue while in
> +		 * ENQUEUED state indicates a missing dequeue.
> +		 */
> +		if (tctx->state =3D=3D TASK_ENQUEUED)
> +			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=3D%llu",
> +				      p->pid, p->comm, tctx->enqueue_seq);
> +
> +		/* Transition to ENQUEUED state */
> +		tctx->state =3D TASK_ENQUEUED;
> +		tctx->enqueue_seq++;
> +
> +		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, 0);
> +		return prev_cpu;
> +
> +	default:
> +		/*
> +		 * Force all tasks through ops.enqueue().
> +		 */
> +		return prev_cpu;
> +	}
> +}
> +
> +void BPF_STRUCT_OPS(dequeue_enqueue, struct task_struct *p, u64 enq_flag=
s)
> +{
> +	struct task_ctx *tctx;
> +
> +	tctx =3D try_lookup_task_ctx(p);
> +	if (!tctx)
> +		return;
> +
> +	switch (test_scenario) {
> +	case 3:
> +		/*
> +		 * Scenario 3: Direct dispatch to the local DSQ.
> +		 *
> +		 * Task bypasses BPF scheduler entirely: no enqueue
> +		 * tracking, no dequeue callbacks. Don't increment counters
> +		 * or validate state since the task never enters BPF
> +		 * scheduler management.
> +		 */
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
> +		break;
> +
> +	case 4:
> +		/*
> +		 * Scenario 4: Direct dispatch to the global DSQ.
> +		 *
> +		 * Like scenario 3, task bypasses BPF scheduler entirely.
> +		 * SCX_DSQ_GLOBAL is a terminal DSQ, tasks dispatched to it
> +		 * leave BPF custody immediately, so no dequeue callbacks
> +		 * should be triggered.
> +		 */
> +		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
> +		break;
> +
> +	case 5:
> +		/*
> +		 * Scenario 5: Dispatch to shared user DSQ.
> +		 *
> +		 * Task enters BPF scheduler management: track
> +		 * enqueue/dequeue lifecycle and validate state
> +		 * transitions.
> +		 */
> +		__sync_fetch_and_add(&enqueue_cnt, 1);
> +
> +		/*
> +		 * Validate state transition: enqueue is only valid from
> +		 * NONE or DISPATCHED states. Getting enqueue while in
> +		 * ENQUEUED state indicates a missing dequeue (or stale state
> +		 * from a previous scenario when the scheduler was unregistered
> +		 * with tasks still on a DSQ). Reset and proceed to avoid false
> +		 * positives across scenario switches.
> +		 */
> +		if (tctx->state =3D=3D TASK_ENQUEUED)
> +			tctx->state =3D TASK_NONE;
> +
> +		/* Transition to ENQUEUED state */
> +		tctx->state =3D TASK_ENQUEUED;
> +		tctx->enqueue_seq++;
> +
> +		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
> +		break;
> +
> +	case 6:
> +		/*
> +		 * Scenario 6: Store task in BPF internal queue. Task enters
> +		 * BPF custody (kernel sets SCX_TASK_NEED_DEQ). When
> +		 * ops.dispatch() later pops and inserts to local DSQ,
> +		 * ops.dequeue() must be called.
> +		 *
> +		 * If the queue is full, fallback to local DSQ. The task still
> +		 * goes through QUEUED in the kernel and gets ops.dequeue()
> +		 * when moved to the terminal DSQ, so we track it the same.
> +		 *
> +		 * If state is already ENQUEUED (e.g. task was on a DSQ when
> +		 * the scheduler was unregistered in a previous scenario),
> +		 * reset to NONE and proceed to avoid false positives.
> +		 */
> +		{
> +			s32 pid =3D p->pid;
> +
> +			if (tctx->state =3D=3D TASK_ENQUEUED)
> +				tctx->state =3D TASK_NONE;
> +
> +			tctx->state =3D TASK_ENQUEUED;
> +			tctx->enqueue_seq++;
> +
> +			/* Queue full: fallback to the global DSQ */
Nit: Can we remove this fallback? This silently changes the behavior of
the test, and even though it makes sense to avoid overflowing the queue,
it causes the test to succeed even if for some reason the
bpf_map_push_elem fails. Why not just bump the queue number to a
reasonably large number amount instead?

> +			if (bpf_map_push_elem(&global_queue, &pid, 0))
> +				scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
> +			else
> +				__sync_fetch_and_add(&enqueue_cnt, 1);
> +
> +			scx_bpf_kick_cpu(scx_bpf_task_cpu(p), SCX_KICK_IDLE);
> +		}
> +		break;
> +
> +	default:
> +		/* For scenarios 0-2 dispatch to the global DSQ */
> +		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
> +	}
> +}
> +
> +void BPF_STRUCT_OPS(dequeue_dequeue, struct task_struct *p, u64 deq_flag=
s)
> +{
> +	struct task_ctx *tctx;
> +
> +	__sync_fetch_and_add(&dequeue_cnt, 1);
> +
> +	tctx =3D try_lookup_task_ctx(p);
> +	if (!tctx)
> +		return;
> +
> +	/*
> +	 * For scenarios 0, 1, 3, and 4 (terminal DSQs: local and global),
> +	 * ops.dequeue() should never be called because tasks bypass the
> +	 * BPF scheduler entirely. If we get here, it's a kernel bug.
> +	 */
> +	if (test_scenario =3D=3D 0 || test_scenario =3D=3D 3) {
> +		scx_bpf_error("%d (%s): dequeue called for local DSQ scenario - kernel=
 bug!",
> +			      p->pid, p->comm);
> +		return;
> +	}
> +	if (test_scenario =3D=3D 1 || test_scenario =3D=3D 4) {
> +		scx_bpf_error("%d (%s): dequeue called for global DSQ scenario - kerne=
l bug!",
> +			      p->pid, p->comm);
> +		return;
> +	}
> +
> +	/*
> +	 * Validate state: dequeue should only happen from ENQUEUED or
> +	 * DISPATCHED states. Getting dequeue from NONE indicates a bug.
> +	 */
> +	if (tctx->state =3D=3D TASK_NONE) {
> +		scx_bpf_error("%d (%s): dequeue from NONE state seq=3D%llu",
> +			      p->pid, p->comm, tctx->enqueue_seq);
> +		return;
> +	}
> +
> +	if (deq_flags & SCX_DEQ_SCHED_CHANGE) {
> +		/*
> +		 * Property change interrupting the workflow. Valid from
> +		 * both ENQUEUED and DISPATCHED states. Transitions task
> +		 * back to NONE state.
> +		 */
> +		__sync_fetch_and_add(&change_dequeue_cnt, 1);
> +
> +		/* Validate state transition */
> +		if (tctx->state !=3D TASK_ENQUEUED && tctx->state !=3D TASK_DISPATCHED=
)
> +			scx_bpf_error("%d (%s): invalid property change dequeue state=3D%d se=
q=3D%llu",
> +				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
> +
> +		/* Transition back to NONE: task outside scheduler control */
> +		tctx->state =3D TASK_NONE;
> +	} else {
> +		/*
> +		 * Regular dispatch dequeue: normal workflow step. Valid
> +		 * only from ENQUEUED state (after enqueue, before dispatch
> +		 * dequeue). Transitions to DISPATCHED state.
> +		 */
> +		__sync_fetch_and_add(&dispatch_dequeue_cnt, 1);
> +
> +		/*
> +		 * Dispatch dequeue should not have %SCX_DEQ_SCHED_CHANGE
> +		 * flag.
> +		 */
> +		if (deq_flags & SCX_DEQ_SCHED_CHANGE)
> +			scx_bpf_error("%d (%s): SCX_DEQ_SCHED_CHANGE in dispatch dequeue seq=
=3D%llu",
> +				      p->pid, p->comm, tctx->enqueue_seq);
> +
> +		/*
> +		 * Must be in ENQUEUED state.
> +		 */
> +		if (tctx->state !=3D TASK_ENQUEUED)
> +			scx_bpf_error("%d (%s): dispatch dequeue from state %d seq=3D%llu",
> +				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
> +
> +		/*
> +		 * Transition to DISPATCHED: normal cycle completed
> +		 * dispatch.
> +		 */
> +		tctx->state =3D TASK_DISPATCHED;
> +	}
> +}
> +
> +void BPF_STRUCT_OPS(dequeue_dispatch, s32 cpu, struct task_struct *prev)
> +{
> +	if (test_scenario =3D=3D 6) {
> +		s32 pid;
> +		struct task_struct *p;
> +
> +		if (bpf_map_pop_elem(&global_queue, &pid))
> +			return;
> +
> +		p =3D bpf_task_from_pid(pid);
> +		if (!p)
> +			return;
> +
> +		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr))
> +			cpu =3D scx_bpf_task_cpu(p);
> +
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL, 0);
> +		bpf_task_release(p);
> +	} else {
> +		scx_bpf_dsq_move_to_local(SHARED_DSQ);
> +	}
> +}
> +
> +s32 BPF_STRUCT_OPS(dequeue_init_task, struct task_struct *p,
> +		   struct scx_init_task_args *args)
> +{
> +	struct task_ctx *tctx;
> +
> +	tctx =3D bpf_task_storage_get(&task_ctx_stor, p, 0,
> +				   BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!tctx)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +s32 BPF_STRUCT_OPS_SLEEPABLE(dequeue_init)
> +{
> +	s32 ret;
> +
> +	ret =3D scx_bpf_create_dsq(SHARED_DSQ, -1);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +void BPF_STRUCT_OPS(dequeue_exit, struct scx_exit_info *ei)
> +{
> +	UEI_RECORD(uei, ei);
> +}
> +
> +SEC(".struct_ops.link")
> +struct sched_ext_ops dequeue_ops =3D {
> +	.select_cpu		=3D (void *)dequeue_select_cpu,
> +	.enqueue		=3D (void *)dequeue_enqueue,
> +	.dequeue		=3D (void *)dequeue_dequeue,
> +	.dispatch		=3D (void *)dequeue_dispatch,
> +	.init_task		=3D (void *)dequeue_init_task,
> +	.init			=3D (void *)dequeue_init,
> +	.exit			=3D (void *)dequeue_exit,
> +	.name			=3D "dequeue_test",
> +};
> diff --git a/tools/testing/selftests/sched_ext/dequeue.c b/tools/testing/=
selftests/sched_ext/dequeue.c
> new file mode 100644
> index 0000000000000..b0add2a516ab8
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/dequeue.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 NVIDIA Corporation.
> + */
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <time.h>
> +#include <bpf/bpf.h>
> +#include <scx/common.h>
> +#include <sys/wait.h>
> +#include <sched.h>
> +#include <pthread.h>
> +#include "scx_test.h"
> +#include "dequeue.bpf.skel.h"
> +
> +#define NUM_WORKERS 8
> +#define AFFINITY_HAMMER_MS 50   /* How long affinity hammer runs (scenar=
io 6) */
> +
> +/*
> + * Worker function that creates enqueue/dequeue events via CPU work and
> + * sleeping. Property-change dequeues are triggered by the affinity hamm=
er
> + * thread (external sched_setaffinity on worker PIDs).
> + */
> +static void worker_fn(int id)
> +{
> +	int i;
> +	volatile int sum =3D 0;
> +
> +	for (i =3D 0; i < 1000; i++) {
> +		int j;
> +
> +		/* Do some work to trigger scheduling events */
> +		for (j =3D 0; j < 10000; j++)
> +			sum +=3D j;
> +
> +		/* Sleep to trigger dequeue */
> +		usleep(1000 + (id * 100));
> +	}
> +
> +	exit(0);
> +}
> +
> +/*
> + * For scenario 6, tasks sit in the BPF queue until dispatch consumes th=
em.
> + * Property-change dequeues only happen when a task gets a property chan=
ge
> + * while still in the queue (SCX_OPSS_QUEUED), not after it has been
> + * dispatched. This thread changes workers' affinity from outside so tha=
t
> + * some changes hit tasks while they are still in the queue.
> + */
> +static void *affinity_hammer_fn(void *arg)
> +{
> +	pid_t *pids =3D arg;
> +	cpu_set_t cpuset;
> +	int i, n =3D NUM_WORKERS;
> +	struct timespec ts =3D { .tv_sec =3D 0, .tv_nsec =3D 1000000 }; /* 1ms =
*/
> +
> +	for (i =3D 0; i < (AFFINITY_HAMMER_MS * 1000 / 100); i++) {
> +		int w =3D i % n;
> +		int cpu =3D (i / n) % 4;
> +
> +		CPU_ZERO(&cpuset);
> +		CPU_SET(cpu, &cpuset);
> +		sched_setaffinity(pids[w], sizeof(cpuset), &cpuset);
> +		nanosleep(&ts, NULL);
> +	}
> +	return NULL;
> +}
> +
> +static enum scx_test_status run_scenario(struct dequeue *skel, u32 scena=
rio,
> +					 const char *scenario_name)
> +{
> +	struct bpf_link *link;
> +	pid_t pids[NUM_WORKERS];
> +	pthread_t hammer;
> +
> +	int i, status;
> +	u64 enq_start, deq_start, dispatch_deq_start, change_deq_start;
> +	u64 enq_delta, deq_delta, dispatch_deq_delta, change_deq_delta;
> +
> +	/* Set the test scenario */
> +	skel->bss->test_scenario =3D scenario;
> +
> +	/* Record starting counts */
> +	enq_start =3D skel->bss->enqueue_cnt;
> +	deq_start =3D skel->bss->dequeue_cnt;
> +	dispatch_deq_start =3D skel->bss->dispatch_dequeue_cnt;
> +	change_deq_start =3D skel->bss->change_dequeue_cnt;
> +
> +	link =3D bpf_map__attach_struct_ops(skel->maps.dequeue_ops);
> +	SCX_FAIL_IF(!link, "Failed to attach struct_ops for scenario %s", scena=
rio_name);
> +
> +	/* Fork worker processes to generate enqueue/dequeue events */
> +	for (i =3D 0; i < NUM_WORKERS; i++) {
> +		pids[i] =3D fork();
> +		SCX_FAIL_IF(pids[i] < 0, "Failed to fork worker %d", i);
> +
> +		if (pids[i] =3D=3D 0) {
> +			worker_fn(i);
> +			/* Should not reach here */
> +			exit(1);
> +		}
> +	}
> +
> +	/*
> +	 * Run an "affinity hammer" so that some property changes hit tasks
> +	 * while they are still in BPF custody (e.g. in user DSQ or BPF queue),
> +	 * triggering SCX_DEQ_SCHED_CHANGE dequeues in scenarios 2, 5 and 6.
> +	 */
> +	SCX_FAIL_IF(pthread_create(&hammer, NULL, affinity_hammer_fn, pids) !=
=3D 0,
> +		    "Failed to create affinity hammer thread");
> +
> +	/* Wait for all workers to complete */
> +	for (i =3D 0; i < NUM_WORKERS; i++) {
> +		SCX_FAIL_IF(waitpid(pids[i], &status, 0) !=3D pids[i],
> +			    "Failed to wait for worker %d", i);
> +		SCX_FAIL_IF(status !=3D 0, "Worker %d exited with status %d", i, statu=
s);
> +	}
> +
> +	pthread_join(hammer, NULL);
> +
> +	bpf_link__destroy(link);
> +
> +	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
> +
> +	/* Calculate deltas */
> +	enq_delta =3D skel->bss->enqueue_cnt - enq_start;
> +	deq_delta =3D skel->bss->dequeue_cnt - deq_start;
> +	dispatch_deq_delta =3D skel->bss->dispatch_dequeue_cnt - dispatch_deq_s=
tart;
> +	change_deq_delta =3D skel->bss->change_dequeue_cnt - change_deq_start;
> +
> +	printf("%s:\n", scenario_name);
> +	printf("  enqueues: %lu\n", (unsigned long)enq_delta);
> +	printf("  dequeues: %lu (dispatch: %lu, property_change: %lu)\n",
> +	       (unsigned long)deq_delta,
> +	       (unsigned long)dispatch_deq_delta,
> +	       (unsigned long)change_deq_delta);
> +
> +	/*
> +	 * Validate enqueue/dequeue lifecycle tracking.
> +	 *
> +	 * For scenarios 0, 1, 3, 4 (local and global DSQs from
> +	 * ops.select_cpu() and ops.enqueue()), both enqueues and dequeues
> +	 * should be 0 because tasks bypass the BPF scheduler entirely: tasks
> +	 * never enter BPF scheduler's custody.
> +	 *
> +	 * For scenarios 2, 5, and 6 (user DSQ or BPF internal queue from
> +	 * ops.select_cpu() / ops.enqueue()), we expect both enqueues and
> +	 * dequeues.
> +	 *
> +	 * The BPF code does strict state machine validation with
> +	 * scx_bpf_error() to ensure the workflow semantics are correct. If
> +	 * we reach this point without errors, the semantics are validated
> +	 * correctly.
> +	 */
> +	if (scenario =3D=3D 0 || scenario =3D=3D 1 || scenario =3D=3D 3 || scen=
ario =3D=3D 4) {
> +		/* Terminal DSQs: tasks bypass BPF scheduler completely */
> +		SCX_EQ(enq_delta, 0);
> +		SCX_EQ(deq_delta, 0);
> +		SCX_EQ(dispatch_deq_delta, 0);
> +		SCX_EQ(change_deq_delta, 0);
> +	} else {
> +		/* User DSQ: tasks enter BPF scheduler's custody */
> +		SCX_GT(enq_delta, 0);
> +		SCX_GT(deq_delta, 0);
> +		/* Validate 1:1 enqueue/dequeue pairing */
> +		SCX_EQ(enq_delta, deq_delta);
> +	}
> +
> +	return SCX_TEST_PASS;
> +}
> +
> +static enum scx_test_status setup(void **ctx)
> +{
> +	struct dequeue *skel;
> +
> +	skel =3D dequeue__open();
> +	SCX_FAIL_IF(!skel, "Failed to open skel");
> +	SCX_ENUM_INIT(skel);
> +	SCX_FAIL_IF(dequeue__load(skel), "Failed to load skel");
> +
> +	*ctx =3D skel;
> +
> +	return SCX_TEST_PASS;
> +}
> +
> +static enum scx_test_status run(void *ctx)
> +{
> +	struct dequeue *skel =3D ctx;
> +	enum scx_test_status status;
> +
> +	/* Scenarios 0-2: ops.select_cpu(), 3-6: ops.enqueue() */
> +	status =3D run_scenario(skel, 0, "Scenario 0: Local DSQ from ops.select=
_cpu()");
> +	if (status !=3D SCX_TEST_PASS)
> +		return status;
> +
> +	status =3D run_scenario(skel, 1, "Scenario 1: Global DSQ from ops.selec=
t_cpu()");
> +	if (status !=3D SCX_TEST_PASS)
> +		return status;
> +
> +	status =3D run_scenario(skel, 2, "Scenario 2: User DSQ from ops.select_=
cpu()");
> +	if (status !=3D SCX_TEST_PASS)
> +		return status;
> +
> +	status =3D run_scenario(skel, 3, "Scenario 3: Local DSQ from ops.enqueu=
e()");
> +	if (status !=3D SCX_TEST_PASS)
> +		return status;
> +
> +	status =3D run_scenario(skel, 4, "Scenario 4: Global DSQ from ops.enque=
ue()");
> +	if (status !=3D SCX_TEST_PASS)
> +		return status;
> +
> +	status =3D run_scenario(skel, 5, "Scenario 5: User DSQ from ops.enqueue=
()");
> +	if (status !=3D SCX_TEST_PASS)
> +		return status;
> +
> +	status =3D run_scenario(skel, 6,
> +			     "Scenario 6: BPF internal queue from ops.enqueue(), consumed in =
ops.dispatch()");
> +	if (status !=3D SCX_TEST_PASS)
> +		return status;
> +
> +	printf("\n=3D=3D=3D Summary =3D=3D=3D\n");
> +	printf("Total enqueues: %lu\n", (unsigned long)skel->bss->enqueue_cnt);
> +	printf("Total dequeues: %lu\n", (unsigned long)skel->bss->dequeue_cnt);
> +	printf("  Dispatch dequeues: %lu (no flag, normal workflow)\n",
> +	       (unsigned long)skel->bss->dispatch_dequeue_cnt);
> +	printf("  Property change dequeues: %lu (SCX_DEQ_SCHED_CHANGE flag)\n",
> +	       (unsigned long)skel->bss->change_dequeue_cnt);
> +	printf("\nAll scenarios passed - no state machine violations detected\n=
");
> +	printf("-> Validated: Local DSQ dispatch bypasses BPF scheduler (both p=
aths)\n");
> +	printf("-> Validated: Global DSQ dispatch bypasses BPF scheduler (both =
paths)\n");
> +	printf("-> Validated: User DSQ dispatch triggers dequeue callbacks (bot=
h paths)\n");
> +	printf("-> Validated: BPF internal queue triggers dequeue when leaving =
custody\n");
> +	printf("-> Validated: ops.enqueue() and ops.select_cpu() behave identic=
ally\n");
> +	printf("-> Validated: Dispatch dequeues have no flags (normal workflow)=
\n");
> +	printf("-> Validated: Property change dequeues have SCX_DEQ_SCHED_CHANG=
E flag\n");
> +	printf("-> Validated: No duplicate enqueues or invalid state transition=
s\n");
> +
> +	return SCX_TEST_PASS;
> +}
> +
> +static void cleanup(void *ctx)
> +{
> +	struct dequeue *skel =3D ctx;
> +
> +	dequeue__destroy(skel);
> +}
> +
> +struct scx_test dequeue_test =3D {
> +	.name =3D "dequeue",
> +	.description =3D "Verify ops.dequeue() semantics",
> +	.setup =3D setup,
> +	.run =3D run,
> +	.cleanup =3D cleanup,
> +};
> +
> +REGISTER_SCX_TEST(&dequeue_test)

