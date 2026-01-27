Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294235D5F3
	for <sched-ext@lists.linux.dev>; Tue, 27 Jan 2026 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532842; cv=none; b=kbPEueDagJrJ8wzEtON8AswL25r/kHdORUPxK8Y+b2zdA3RZk4xKMI9nKPuDhDKBWgLGqAzTrry1T10vuhhTijS7MPlzrh+gfQW1JzNrW9VgXqzcV7jubOis00g3Z8+OLDKWeumSsvVopYwNGn8FbxLCbpMuhyZc+m9o3KBFhSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532842; c=relaxed/simple;
	bh=UtTyTaaySF5Ve6Dz+/Q7qglULmirSq3hMliNVQAQ66w=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ZiOlYgIMC9GY6l2ddFulPkIZvsgzKe7tpyqXwOOxkNF9Y5vUN585RXJ7qKy4pmmEgso5khAEzt7hWsVXaiqnyUEaCcwNYs3aMyfRq3FCGhNwlFbCdJLJFMOJprdjK9KnXZ7EtMo49Nv4n5DC10VByBxtMhK0zCfCCfljpyFCC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=QCvrtFVF; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="QCvrtFVF"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8947e17968eso64121466d6.0
        for <sched-ext@lists.linux.dev>; Tue, 27 Jan 2026 08:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769532839; x=1770137639; darn=lists.linux.dev;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymQHWH//sQsMyZnQ+jRKhOk9bIvqFpPvAn7HEO6pFXo=;
        b=QCvrtFVFH66xpCKZxm6ztsfIv4hKNumy2xlquBAasXwiLRUI3PYz/WHNkFosjfgeCY
         NtKZmE5mZlWfd27//Vbb/ADDb251SzHRJgBioortpInMKcWY7+5j85CA5a6Xn8GZNWrT
         NSRPA1DRK5ZI+S4yD9W/PcjlFAdPYQiN35KP1WwAiqyjeEpA/S1aR4j/fOT7bys5Os92
         fZ8qbK/yrsDGclcn7K2amSSWhutNNS4xF3voFO6ZU312/c2YT91mlI6VhkLr+YuFPqCT
         V8AUVaJ0pi0Tv2GOUo6fIF72SrsvdLtQNclUkB/SNWjsgtR47ilDy0W9EZDLwTagG+Q2
         Hzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769532839; x=1770137639;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymQHWH//sQsMyZnQ+jRKhOk9bIvqFpPvAn7HEO6pFXo=;
        b=kR0EzqaSVhsHWDml0KSgWp4Bp8T2m12TDUPW2bNxzr3rj+SCRK03gbTxiiDXl+m/gY
         GQZBpls9udp7j3yIriSPQ7MEHz6GqtMHqmDny7ztA/nV53ikTWoJjRKQO/lMFSnarOSu
         IoE+61K5lTJQs6W6cDoMCJuZZk5pvO2mjdIKbtFXJtyAuqEvktSg2Q5Q4TwsBWz/pS0G
         uaHikzjwfxDcJj/OdnKuca+l9CkPwPMY7LI8WL0Nqpov9aURfPGIqjRbfblXCIGDQXoZ
         C2p9twA7EXvC6YzkSSAUQylWXEQ0jSe5TSVJBjo+SuqGOqCWPwR33BtUra2RXDdW1HN/
         AXow==
X-Forwarded-Encrypted: i=1; AJvYcCVkDqpG2RWwMGfSpQFAsE/UYqsNBoHgA+d0C4I3PkMyW0A57qK4OYNXE7IelS0Zp2r3qktdEsjGrfs=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz76gLM3wOU1HeQz6KD/5d3ER1CFaETvoZL6lKehig+LgEGyN8o
	6LNLnQi1WokvnsJBGwCG0nJkbF7z5IhtsXfhqSJtFwMSBAyQJbPlgYoJ3gGyn7i9RHw=
X-Gm-Gg: AZuq6aK8BiMwOioB9VmBaRav8CgmHvHR32tBVM1HfOOLkq/evJiSUvwQOHjzkF1yZWK
	ikxJh1qYNUh1j3xlJNDhftlanenpB1cWv/aJAYxNN0TBANHvC4QEGcLgWoDPqos+bHtG5RX+73e
	pqJauRb0gZivgh4BqpDs+uZ8KSySwwVLrs41Zt8e0BJLQvgr/EW0yHsonFxVu9XMYX3LXDbOTr/
	kZ4naUGFoyGohaDgfLBtaDG0M+xsuA6sBbPA2sYGVb5MYrfi01p4ZqWpbCPoECgFpkWLcQrHbeb
	DNwlIq0zi8TClAEULzkcGRukK5gJUOAg5HMFrutD2QJvX83WPofuIQoDauy5cqlMxfWulPga1/x
	nNDmNprrdJ9VksBdI8FOT8Hot+n47jtEtTcUCq5WWYf3noeZIm6HN7ZoQSyPlz1WdlcWJPI0Byh
	omGMjGgQn24UolceWSJoopfg==
X-Received: by 2002:ad4:5ba3:0:b0:888:89fd:a720 with SMTP id 6a1803df08f44-894cc7d04d4mr34472966d6.11.1769532839344;
        Tue, 27 Jan 2026 08:53:59 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d373fe92sm575046d6.32.2026.01.27.08.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 08:53:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 11:53:57 -0500
Message-Id: <DFZJ1F2FTAXR.QUA03I4GIKEX@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrea Righi" <arighi@nvidia.com>, "Tejun Heo" <tj@kernel.org>, "David
 Vernet" <void@manifault.com>, "Changwoo Min" <changwoo@igalia.com>
Cc: "Kuba Piecuch" <jpiecuch@google.com>, "Christian Loehle"
 <christian.loehle@arm.com>, "Daniel Hodges" <hodgesd@meta.com>,
 <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
X-Mailer: aerc 0.20.1
References: <20260126084258.3798129-1-arighi@nvidia.com>
 <20260126084258.3798129-3-arighi@nvidia.com>
In-Reply-To: <20260126084258.3798129-3-arighi@nvidia.com>

On Mon Jan 26, 2026 at 3:41 AM EST, Andrea Righi wrote:
> Add a new kselftest to validate that:
>  - every enqueue is followed by proper dequeue,
>  - dispatch dequeues happen exactly once per enqueue,
>  - property change dequeues (%SCX_DEQ_SCHED_CHANGE) only happen for
>    property changes,
>  - no duplicate enqueues without proper dequeue.
>
> Test scenarios:
>  - direct dispatch to local DSQ (%SCX_DSQ_LOCAL),
>  - dispatch to user DSQ,
>  - explicit property changes via sched_setaffinity().
>
> This validates that the new ops.dequeue() semantics work correctly for
> all task lifecycle scenarios.
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Emil Tsalapatis <emil@etsalapatis.com>
> Cc: Kuba Piecuch <jpiecuch@google.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>  .../testing/selftests/sched_ext/dequeue.bpf.c | 209 ++++++++++++++++++
>  tools/testing/selftests/sched_ext/dequeue.c   | 182 +++++++++++++++
>  3 files changed, 392 insertions(+)
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
> index 0000000000000..8b2f792cf7d8b
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A scheduler that validates ops.dequeue() is called correctly:
> + * - For tasks on BPF data structures (not yet dispatched)
> + * - For tasks already on DSQs (local or shared)
> + * - That every ops.enqueue() is followed by ops.dequeue()
> + *
> + * Copyright (c) 2025 NVIDIA Corporation.
> + */
> +
> +#include <scx/common.bpf.h>
> +
> +#define SHARED_DSQ	0
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
> + * - change_dequeue_cnt: Number of property change dequeues (%SCX_DEQ_SC=
HED_CHANGE)
> + */
> +u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, change_dequeue_cnt;
> +
> +/*
> + * Test scenarios:
> + * - 0: Dispatch to local DSQ
> + * - 1: Dispatch to shared DSQ
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
> +	TASK_NONE =3D 0,      /* Task is outside scheduler control */
> +	TASK_ENQUEUED,      /* ops.enqueue() called, waiting for dequeue */
> +	TASK_DISPATCHED,    /* Dispatch dequeue received, can get property chan=
ge or re-enqueue */
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
> +	/* Always bounce to ops.enqueue() */
> +	return prev_cpu;
> +}
> +
> +void BPF_STRUCT_OPS(dequeue_enqueue, struct task_struct *p, u64 enq_flag=
s)
> +{
> +	struct task_ctx *tctx;
> +
> +	__sync_fetch_and_add(&enqueue_cnt, 1);
> +
> +	tctx =3D try_lookup_task_ctx(p);
> +	if (!tctx)
> +		return;
> +
> +	/*
> +	 * Validate state transition: enqueue is only valid from NONE or
> +	 * DISPATCHED states. Getting enqueue while in ENQUEUED state
> +	 * indicates a missing dequeue.
> +	 */
> +	if (tctx->state =3D=3D TASK_ENQUEUED)
> +		scx_bpf_error("%d (%s): enqueue while in ENQUEUED state (seq %llu)",
> +			      p->pid, p->comm, tctx->enqueue_seq);
> +
> +	/* Transition to ENQUEUED state */
> +	tctx->state =3D TASK_ENQUEUED;
> +	tctx->enqueue_seq++;
> +
> +	switch (test_scenario) {
> +	case 0:
> +		/* Scenario 0: Direct dispatch to the local DSQ */
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
> +		break;
> +
> +	case 1:
> +		/* Scenario 1: Dispatch to shared DSQ */
> +		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
> +		break;
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
> +	 * Validate state: dequeue should only happen from ENQUEUED or
> +	 * DISPATCHED states. Getting dequeue from NONE indicates a bug.
> +	 */
> +	if (tctx->state =3D=3D TASK_NONE)
> +		scx_bpf_error("%d (%s): dequeue from NONE state (seq %llu)",
> +			      p->pid, p->comm, tctx->enqueue_seq);
> +
> +	if (deq_flags & SCX_DEQ_SCHED_CHANGE) {
> +		/*
> +		 * Async dequeue: property change interrupting the workflow.
> +		 * Valid from both ENQUEUED and DISPATCHED states.
> +		 * Transitions task back to NONE state.
> +		 */
> +		__sync_fetch_and_add(&change_dequeue_cnt, 1);
> +
> +		/* Validate state transition */
> +		if (tctx->state !=3D TASK_ENQUEUED && tctx->state !=3D TASK_DISPATCHED=
)
> +			scx_bpf_error("%d (%s): property change dequeue from invalid state %d=
 (seq %llu)",
> +				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
> +
> +		/* Transition back to NONE - task outside scheduler control */
> +		tctx->state =3D TASK_NONE;
> +	} else {
> +		/*
> +		 * Regular dispatch dequeue: normal workflow step.
> +		 * Valid only from ENQUEUED state (after enqueue, before dispatch dequ=
eue).
> +		 * Transitions to DISPATCHED state.
> +		 */
> +		__sync_fetch_and_add(&dispatch_dequeue_cnt, 1);
> +
> +		/* Validate: dispatch dequeue should NOT have %SCX_DEQ_SCHED_CHANGE fl=
ag */
> +		if (deq_flags & SCX_DEQ_SCHED_CHANGE)
> +			scx_bpf_error("%d (%s): SCX_DEQ_SCHED_CHANGE in dispatch dequeue (seq=
 %llu)",
> +				      p->pid, p->comm, tctx->enqueue_seq);
> +
> +		/* Must be in ENQUEUED state */
> +		if (tctx->state !=3D TASK_ENQUEUED)
> +			scx_bpf_error("%d (%s): dispatch dequeue from state %d (seq %llu)",
> +				      p->pid, p->comm, tctx->state, tctx->enqueue_seq);
> +
> +		/* Transition to DISPATCHED - normal cycle completed dispatch */
> +		tctx->state =3D TASK_DISPATCHED;
> +	}
> +}
> +
> +void BPF_STRUCT_OPS(dequeue_dispatch, s32 cpu, struct task_struct *prev)
> +{
> +	scx_bpf_dsq_move_to_local(SHARED_DSQ);
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
> index 0000000000000..6861257d79b47
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/dequeue.c
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 NVIDIA Corporation.
> + */
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <bpf/bpf.h>
> +#include <scx/common.h>
> +#include <sys/wait.h>
> +#include <sched.h>
> +#include <pthread.h>
> +#include "scx_test.h"
> +#include "dequeue.bpf.skel.h"
> +
> +#define NUM_WORKERS 8
> +
> +/*
> + * Worker function that creates enqueue/dequeue events. It alternates
> + * between CPU work, sleeping, and affinity changes to trigger dequeues.
> + */
> +static void worker_fn(int id)
> +{
> +	cpu_set_t cpuset;
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
> +		/* Change affinity to trigger dequeue */
> +		if (i % 10 =3D=3D 0) {
> +			CPU_ZERO(&cpuset);
> +			/* Rotate through the first 4 CPUs */
> +			CPU_SET(i % 4, &cpuset);
> +			sched_setaffinity(0, sizeof(cpuset), &cpuset);
> +		}
> +
> +		/* Do additional work */
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
> +static enum scx_test_status run_scenario(struct dequeue *skel, u32 scena=
rio,
> +					 const char *scenario_name)
> +{
> +	struct bpf_link *link;
> +	pid_t pids[NUM_WORKERS];
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
> +	/* Wait for all workers to complete */
> +	for (i =3D 0; i < NUM_WORKERS; i++) {
> +		SCX_FAIL_IF(waitpid(pids[i], &status, 0) !=3D pids[i],
> +			    "Failed to wait for worker %d", i);
> +		SCX_FAIL_IF(status !=3D 0, "Worker %d exited with status %d", i, statu=
s);
> +	}
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
> +	 * Validate that we got enqueue and dequeue events.
> +	 * The BPF code does strict state machine validation with scx_bpf_error=
()
> +	 * to ensure the workflow semantics are correct. If we reach here witho=
ut
> +	 * errors, the semantics are validated correctly.
> +	 */
> +	SCX_GT(enq_delta, 0);
> +	SCX_GT(deq_delta, 0);
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
> +	status =3D run_scenario(skel, 0, "Local DSQ");
> +	if (status !=3D SCX_TEST_PASS)
> +		return status;
> +
> +	status =3D run_scenario(skel, 1, "User DSQ");
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
> +	printf("-> Validated: Correct state transitions (NONE -> ENQUEUED -> DI=
SPATCHED)\n");
> +	printf("-> Validated: Dispatch dequeues have no flags (normal workflow)=
\n");
> +	printf("-> Validated: Async dequeues have SCX_DEQ_SCHED_CHANGE flag (in=
terruptions)\n");
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
> +	.description =3D "Verify that ops.enqueue() is balanced with ops.dequeu=
e()",
> +	.setup =3D setup,
> +	.run =3D run,
> +	.cleanup =3D cleanup,
> +};
> +
> +REGISTER_SCX_TEST(&dequeue_test)

