Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D07F2749EA
	for <sched-ext@lists.linux.dev>; Sun,  8 Feb 2026 05:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770527475; cv=none; b=gbuE4ZunW5gGbGhSWI64yO2UCrSayGiAkixdYxLnRddlecjcW05tdwT9iGjJ5KiZ48X0KeSRAvAh+gfKZ0WDn/OETLV0anqhi7cmP30HN6my4HG3Vn8gFiVTbf9oNSvbwSyXBO/xtzwEwV8EvoZLovdEntPFOTjPjvmvyo5RGMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770527475; c=relaxed/simple;
	bh=Gc+1ng7a0wNh9EgGN1HtkUb+en5mXNuK9KA8hxvALLs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fK0ab93YzaWYSO9tg0TNOr5YdCTPCsoeXovYWCug5ZIphKBTpGAFxyGS6JyQunnznC3OUNxVPf7mKMSkDqOx9RSq3rUgKT8Li1+YCYCNLh1iXIXclmB5LceagO/qoUotFNLyYYS1Lhamqx/vg0oJhtCJLEODgPzsNuK38H2flGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=SF/brcnm; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="SF/brcnm"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c711959442so364900185a.0
        for <sched-ext@lists.linux.dev>; Sat, 07 Feb 2026 21:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770527474; x=1771132274; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JZGIzflDH60Bg0WRttJqOP51M73UmsA3HnkSs7qnCM=;
        b=SF/brcnmtXwJpjUFwbOfF1TsKJrUtSxTlZAe4UuoQmHSEk2005gOzRSG/H2241TJLr
         qfyW9Nc1XqxVcLRj65/lcn4beRYjTRQ/CXCElQ+8RJsXPXmjSrETFkNdL+Irviwg2UkO
         3Bx5saK341nik44hQOijNY31QuenUKyQZUKgetsIbRcSqsZCohSCk9ys+r19cV47OKqo
         q1VHE4FwJtBQOz56sVPHBirMJ1Xaeq80nQhRqaMuEbAqgZolHPIWRaF1WC8DbiBOmECF
         UeuSBnhtvjxfJWzxh0zFZzDuTBifV5MVzTQ5d+EkUHWAV7wjjfKkKjXME7B6uzVkOouB
         hUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770527474; x=1771132274;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JZGIzflDH60Bg0WRttJqOP51M73UmsA3HnkSs7qnCM=;
        b=oixpKdFeQl7rVMpJrTHMgzkemNEnpLY8D8HbWlWN3i3xG75H82LYY2s9BIMUEzP6WQ
         9CR8YI0qHc7sandHUZLoRdmcnGcvMYOX+1lDKFPCzly3uKgNr0xUdqAzXKZI3g+r0XSW
         uSJJTlo5joPuASio9KzYEN/7Egamny5ySxavOrRD6YHrksBpi/HZsGkkAsa8gvWfgE7+
         p2DsTqOOOJn44tRZJe45g8+LfFaynjZhdp5vja+5kkq9hHxsxl2R9IKUFG8PHHeG/dJ+
         YyvHTgBJvOhXf+xbESCfPEHwx+JNdHdnkGDB/kD4U2VAE1gXX0Ke8cfVxDCwTCLazGfV
         IVLw==
X-Forwarded-Encrypted: i=1; AJvYcCVOSobaLpVkZiUybUvbVmCefoGkd5ytcdjzXQYN+7RjYezV2Mw7XdIHX3n54gxVhHxd0W7vm9Adeqo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwwaK/fUWdZqWL0PBh4OcCQRouf0U6xEwC3uUNCRl14lzCsD87J
	ga1kLo2p8d0kf8dV79I0hLHY2h9+0YNrUm0OogKam6H18CXC4MwwaLCipcc4FDL9Ofc=
X-Gm-Gg: AZuq6aIk/Qu8RgLJL7AS1XvdN7nX1fzh2K8DbEOM9lWDsZNThFQ0yUqbXWScTqAjI0z
	FhbKCVUhbmhUQf2QwLsMhM/rsqsKCUdjtldHqGnOm1LYMXSwlVFY/R8q5faFaMm594vjTYIK0n7
	B+kA0pAMp6jfsNLghw2prLtCM2Tjig9Ev53oaeQUSmh2arfWpNIXpt1vXfvjuKFYTnvXl41lNfF
	0b+ESD6GPQ7SshKhEQXDYEtAfzOLW7SDxc7n107XHwhiuMNlwibD87E9y/AJCUU979x4q2mv0mP
	d04uOO8O0KAffm3mRNzXvhpWoRqnWCpOhNs44I1Jrjq9MPMZLUnw70s7cL/XPBTH7GaCxM5QdcJ
	upMNJFtqs/87WXFAT8kABf64m7rdTw4QMjXk7yrb3fDiy2JekAos1zYBLuk7sh0M3gV7luPswP9
	XMFQFsyiODcevgCv1pKpBLdg==
X-Received: by 2002:a05:620a:7086:b0:8c6:a85c:84b1 with SMTP id af79cd13be357-8cae3387b3cmr1045696285a.39.1770527473648;
        Sat, 07 Feb 2026 21:11:13 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf7aefbc5sm514126685a.17.2026.02.07.21.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 21:11:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Feb 2026 00:11:11 -0500
Message-Id: <DG9BLVVE2TJQ.381PKRLX41AM2@etsalapatis.com>
Cc: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Changwoo Min" <changwoo@igalia.com>, "Kuba Piecuch" <jpiecuch@google.com>,
 "Christian Loehle" <christian.loehle@arm.com>, "Daniel Hodges"
 <hodgesd@meta.com>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrea Righi" <arighi@nvidia.com>
X-Mailer: aerc 0.20.1
References: <20260206135742.2339918-1-arighi@nvidia.com>
 <20260206135742.2339918-3-arighi@nvidia.com>
 <DG85HO9OMIUH.278JKOJEN6QPL@etsalapatis.com> <aYcC_aKj_tO62rXZ@gpd4>
In-Reply-To: <aYcC_aKj_tO62rXZ@gpd4>

On Sat Feb 7, 2026 at 4:16 AM EST, Andrea Righi wrote:
> Hi Emil,
>

Hi Andrea,

> On Fri, Feb 06, 2026 at 03:10:55PM -0500, Emil Tsalapatis wrote:
>> On Fri Feb 6, 2026 at 8:54 AM EST, Andrea Righi wrote:
>>=20
>> Hi Andrea,
>>=20
>> > Add a new kselftest to validate that the new ops.dequeue() semantics
>> > work correctly for all task lifecycle scenarios, including the
>> > distinction between terminal DSQs (where BPF scheduler is done with th=
e
>> > task), user DSQs (where BPF scheduler manages the task lifecycle) and
>> > BPF data structures, regardless of which event performs the dispatch.
>> >
>> > The test validates the following scenarios:
>> >
>> >  - From ops.select_cpu():
>> >      - scenario 0 (local DSQ): tasks dispatched to the local DSQ bypas=
s
>> >        the BPF scheduler entirely; they never enter BPF custody, so
>> >        ops.dequeue() is not called,
>> >      - scenario 1 (global DSQ): tasks dispatched to SCX_DSQ_GLOBAL als=
o
>> >        bypass the BPF scheduler, like the local DSQ; ops.dequeue() is
>> >        not called,
>> >      - scenario 2 (user DSQ): tasks enter BPF scheduler custody with f=
ull
>> >        enqueue/dequeue lifecycle tracking and state machine validation
>> >        (expects 1:1 enqueue/dequeue pairing).
>>=20
>> Could you add a note here about why there's no equivalent to scenario 6?
>> The differentiating factor between that and scenario 2 (nonterminal queu=
e) is=20
>> that scx_dsq_insert_commit() is called regardless of whether the queue i=
s terminal.
>> And this makes sense since for non-DSQ queues the BPF scheduler can do i=
ts
>> own tracking of enqueue/dequeue (plus it does not make too much sense to
>> do BPF-internal enqueueing in select_cpu).
>>=20
>> What do you think? If the above makes sense, maybe we should spell it ou=
t=20
>> in the documentation too. Maybe also add it makes no sense to enqueue
>> in an internal BPF structure from select_cpu - the task is not yet
>> enqueued, and would have to go through enqueue anyway.
>
> Oh, I just didn't think about it, we can definitely add to ops.select_cpu=
()
> a scenario equivalent to scenario 6 (push task to the BPF queue).
>
> From a practical standpoint the benefits are questionable, but in the sco=
pe
> of the kselftest I think it makes sense to better validate the entire sta=
te
> machine in all cases. I'll add this scenario as well.
>

That makes sense! Let's add it for completeness. Even if it doesn't make
sense right now that may change in the future. For example, if we end
up finding a good reason to add the task into an internal structure from
.select_cpu(), we may allow the task to be explicitly marked as being in
the BPF scheduler's custody from a kfunc. Right now we can't do that
from select_cpu() unless we direct dispatch IIUC.

>>=20
>> >
>> >    - From ops.enqueue():
>> >      - scenario 3 (local DSQ): same behavior as scenario 0,
>> >      - scenario 4 (global DSQ): same behavior as scenario 1,
>> >      - scenario 5 (user DSQ): same behavior as scenario 2,
>> >      - scenario 6 (BPF internal queue): tasks are stored in a BPF queu=
e
>> >        in ops.enqueue() and consumed in ops.dispatch(); they remain in
>> >        BPF custody until dispatch, with full lifecycle tracking and 1:=
1
>> >        enqueue/dequeue validation.
>> >
>> > This verifies that:
>> >  - terminal DSQ dispatch (local, global) don't trigger ops.dequeue(),
>> >  - user DSQ / internal BPF data structure dispatch has exact 1:1
>> >    ops.enqueue()/dequeue() pairing,
>> >  - dispatch dequeues have no flags (normal workflow),
>> >  - property change dequeues have the %SCX_DEQ_SCHED_CHANGE flag set,
>> >  - no duplicate enqueues or invalid state transitions are happening,
>> >  - ops.enqueue() and ops.select_cpu() dispatch paths behave identicall=
y.
>> >
>> > Cc: Tejun Heo <tj@kernel.org>
>> > Cc: Emil Tsalapatis <emil@etsalapatis.com>
>> > Cc: Kuba Piecuch <jpiecuch@google.com>
>> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
>> > ---
>> >  tools/testing/selftests/sched_ext/Makefile    |   1 +
>> >  .../testing/selftests/sched_ext/dequeue.bpf.c | 403 +++++++++++++++++=
+
>> >  tools/testing/selftests/sched_ext/dequeue.c   | 258 +++++++++++
>> >  3 files changed, 662 insertions(+)
>> >  create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
>> >  create mode 100644 tools/testing/selftests/sched_ext/dequeue.c
>> >
>> > diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testin=
g/selftests/sched_ext/Makefile
>> > index 5fe45f9c5f8fd..764e91edabf93 100644
>> > --- a/tools/testing/selftests/sched_ext/Makefile
>> > +++ b/tools/testing/selftests/sched_ext/Makefile
>> > @@ -161,6 +161,7 @@ all_test_bpfprogs :=3D $(foreach prog,$(wildcard *=
.bpf.c),$(INCLUDE_DIR)/$(patsubs
>> > =20
>> >  auto-test-targets :=3D			\
>> >  	create_dsq			\
>> > +	dequeue				\
>> >  	enq_last_no_enq_fails		\
>> >  	ddsp_bogus_dsq_fail		\
>> >  	ddsp_vtimelocal_fail		\
>> > diff --git a/tools/testing/selftests/sched_ext/dequeue.bpf.c b/tools/t=
esting/selftests/sched_ext/dequeue.bpf.c
>> > new file mode 100644
>> > index 0000000000000..4ba657ba1bff5
>> > --- /dev/null
>> > +++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
>> > @@ -0,0 +1,403 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +/*
>> > + * A scheduler that validates ops.dequeue() is called correctly:
>> > + * - Tasks dispatched to terminal DSQs (local, global) bypass the BPF
>> > + *   scheduler entirely: no ops.dequeue() should be called
>> > + * - Tasks dispatched to user DSQs enter BPF custody: ops.dequeue() m=
ust be
>> > + *   called when they leave custody
>> > + * - Every ops.enqueue() for non-terminal DSQs is followed by exactly=
 one
>> > + *   ops.dequeue() (validate 1:1 pairing and state machine)
>> > + *
>> > + * Copyright (c) 2026 NVIDIA Corporation.
>> > + */
>> > +
>> > +#include <scx/common.bpf.h>
>> > +
>> > +#define SHARED_DSQ	0
>> > +
>> > +/*
>> > + * Scenario 6: BPF internal queue. Tasks are stored here from ops.enq=
ueue()
>> > + * and consumed from ops.dispatch(), validating that tasks not on a u=
ser DSQ
>> > + * (only on BPF internal structures) still get ops.dequeue() when the=
y leave.
>> > + */
>> > +struct {
>> > +	__uint(type, BPF_MAP_TYPE_QUEUE);
>> > +	__uint(max_entries, 4096);
>>=20
>> Nit: Can we make this larger? I don't think there's any downsides. I kno=
w
>> there's a mitigation for if the queue gets full, please see nit below.
>
> Sure, like 32768?
>
> Or we can keep it like this so we can potentially test also the fallback
> path sometimes (mixed BPF queue dispatches + built-in DSQ dispatches).
>

32K makes sense. If we keep the fallback, maybe we can just add a
WARN_ON_ONCE() equivalent that it is being triggered so that we make
sure we don't trigger it every single time (e.g. because the BPF queue
is misbehaving)?

>>=20
>> > +	__type(value, s32);
>> > +} global_queue SEC(".maps");
>> > +
>> > +char _license[] SEC("license") =3D "GPL";
>> > +
>> > +UEI_DEFINE(uei);
>> > +
>> > +/*
>> > + * Counters to track the lifecycle of tasks:
>> > + * - enqueue_cnt: Number of times ops.enqueue() was called
>> > + * - dequeue_cnt: Number of times ops.dequeue() was called (any type)
>> > + * - dispatch_dequeue_cnt: Number of regular dispatch dequeues (no fl=
ag)
>> > + * - change_dequeue_cnt: Number of property change dequeues
>> > + */
>> > +u64 enqueue_cnt, dequeue_cnt, dispatch_dequeue_cnt, change_dequeue_cn=
t;
>> > +
>> > +/*
>> > + * Test scenarios (0-2: ops.select_cpu(), 3-6: ops.enqueue()):
>> > + * 0) Dispatch to local DSQ from ops.select_cpu() (terminal DSQ, bypa=
sses BPF
>> > + *    scheduler, no dequeue callbacks)
>> > + * 1) Dispatch to global DSQ from ops.select_cpu() (terminal DSQ, byp=
asses BPF
>> > + *    scheduler, no dequeue callbacks)
>> > + * 2) Dispatch to shared user DSQ from ops.select_cpu() (enters BPF s=
cheduler,
>> > + *    dequeue callbacks expected)
>> > + * 3) Dispatch to local DSQ from ops.enqueue() (terminal DSQ, bypasse=
s BPF
>> > + *    scheduler, no dequeue callbacks)
>> > + * 4) Dispatch to global DSQ from ops.enqueue() (terminal DSQ, bypass=
es BPF
>> > + *    scheduler, no dequeue callbacks)
>> > + * 5) Dispatch to shared user DSQ from ops.enqueue() (enters BPF sche=
duler,
>> > + *    dequeue callbacks expected)
>> > + * 6) BPF internal queue: store task PIDs in ops.enqueue(), consume i=
n
>> > + *    ops.dispatch() and dispatch to local DSQ (validates dequeue for=
 tasks
>> > + *    in BPF custody but not on a user DSQ)
>> > + */
>> > +u32 test_scenario;
>> > +
>> > +/*
>> > + * Per-task state to track lifecycle and validate workflow semantics.
>> > + * State transitions:
>> > + *   NONE -> ENQUEUED (on enqueue)
>> > + *   ENQUEUED -> DISPATCHED (on dispatch dequeue)
>> > + *   DISPATCHED -> NONE (on property change dequeue or re-enqueue)
>> > + *   ENQUEUED -> NONE (on property change dequeue before dispatch)
>> > + */
>> > +enum task_state {
>> > +	TASK_NONE =3D 0,
>> > +	TASK_ENQUEUED,
>> > +	TASK_DISPATCHED,
>> > +};
>> > +
>> > +struct task_ctx {
>> > +	enum task_state state; /* Current state in the workflow */
>> > +	u64 enqueue_seq;       /* Sequence number for debugging */
>> > +};
>> > +
>> > +struct {
>> > +	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
>> > +	__uint(map_flags, BPF_F_NO_PREALLOC);
>> > +	__type(key, int);
>> > +	__type(value, struct task_ctx);
>> > +} task_ctx_stor SEC(".maps");
>> > +
>> > +static struct task_ctx *try_lookup_task_ctx(struct task_struct *p)
>> > +{
>> > +	return bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
>> > +}
>> > +
>> > +s32 BPF_STRUCT_OPS(dequeue_select_cpu, struct task_struct *p,
>> > +		   s32 prev_cpu, u64 wake_flags)
>> > +{
>> > +	struct task_ctx *tctx;
>> > +
>> > +	tctx =3D try_lookup_task_ctx(p);
>> > +	if (!tctx)
>> > +		return prev_cpu;
>> > +
>> > +	switch (test_scenario) {
>> > +	case 0:
>> > +		/*
>> > +		 * Scenario 0: Direct dispatch to local DSQ from select_cpu.
>> > +		 *
>> > +		 * Task bypasses BPF scheduler entirely: no enqueue
>> > +		 * tracking, no dequeue callbacks. Behavior should be
>> > +		 * identical to scenario 3.
>> > +		 */
>> > +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
>> > +		return prev_cpu;
>> > +
>> > +	case 1:
>> > +		/*
>> > +		 * Scenario 1: Direct dispatch to global DSQ from select_cpu.
>> > +		 *
>> > +		 * Like scenario 0, task bypasses BPF scheduler entirely.
>> > +		 * Behavior should be identical to scenario 4.
>> > +		 */
>> > +		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
>> > +		return prev_cpu;
>> > +
>> > +	case 2:
>> > +		/*
>> > +		 * Scenario 2: Dispatch to shared user DSQ from select_cpu.
>> > +		 *
>> > +		 * Task enters BPF scheduler management: track
>> > +		 * enqueue/dequeue lifecycle and validate state transitions.
>> > +		 * Behavior should be identical to scenario 5.
>> > +		 */
>> > +		__sync_fetch_and_add(&enqueue_cnt, 1);
>> > +
>> > +		/*
>> > +		 * Validate state transition: enqueue is only valid from
>> > +		 * NONE or DISPATCHED states. Getting enqueue while in
>> > +		 * ENQUEUED state indicates a missing dequeue.
>> > +		 */
>> > +		if (tctx->state =3D=3D TASK_ENQUEUED)
>> > +			scx_bpf_error("%d (%s): enqueue while in ENQUEUED state seq=3D%llu=
",
>> > +				      p->pid, p->comm, tctx->enqueue_seq);
>> > +
>> > +		/* Transition to ENQUEUED state */
>> > +		tctx->state =3D TASK_ENQUEUED;
>> > +		tctx->enqueue_seq++;
>> > +
>> > +		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, 0);
>> > +		return prev_cpu;
>> > +
>> > +	default:
>> > +		/*
>> > +		 * Force all tasks through ops.enqueue().
>> > +		 */
>> > +		return prev_cpu;
>> > +	}
>> > +}
>> > +
>> > +void BPF_STRUCT_OPS(dequeue_enqueue, struct task_struct *p, u64 enq_f=
lags)
>> > +{
>> > +	struct task_ctx *tctx;
>> > +
>> > +	tctx =3D try_lookup_task_ctx(p);
>> > +	if (!tctx)
>> > +		return;
>> > +
>> > +	switch (test_scenario) {
>> > +	case 3:
>> > +		/*
>> > +		 * Scenario 3: Direct dispatch to the local DSQ.
>> > +		 *
>> > +		 * Task bypasses BPF scheduler entirely: no enqueue
>> > +		 * tracking, no dequeue callbacks. Don't increment counters
>> > +		 * or validate state since the task never enters BPF
>> > +		 * scheduler management.
>> > +		 */
>> > +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
>> > +		break;
>> > +
>> > +	case 4:
>> > +		/*
>> > +		 * Scenario 4: Direct dispatch to the global DSQ.
>> > +		 *
>> > +		 * Like scenario 3, task bypasses BPF scheduler entirely.
>> > +		 * SCX_DSQ_GLOBAL is a terminal DSQ, tasks dispatched to it
>> > +		 * leave BPF custody immediately, so no dequeue callbacks
>> > +		 * should be triggered.
>> > +		 */
>> > +		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
>> > +		break;
>> > +
>> > +	case 5:
>> > +		/*
>> > +		 * Scenario 5: Dispatch to shared user DSQ.
>> > +		 *
>> > +		 * Task enters BPF scheduler management: track
>> > +		 * enqueue/dequeue lifecycle and validate state
>> > +		 * transitions.
>> > +		 */
>> > +		__sync_fetch_and_add(&enqueue_cnt, 1);
>> > +
>> > +		/*
>> > +		 * Validate state transition: enqueue is only valid from
>> > +		 * NONE or DISPATCHED states. Getting enqueue while in
>> > +		 * ENQUEUED state indicates a missing dequeue (or stale state
>> > +		 * from a previous scenario when the scheduler was unregistered
>> > +		 * with tasks still on a DSQ). Reset and proceed to avoid false
>> > +		 * positives across scenario switches.
>> > +		 */
>> > +		if (tctx->state =3D=3D TASK_ENQUEUED)
>> > +			tctx->state =3D TASK_NONE;
>> > +
>> > +		/* Transition to ENQUEUED state */
>> > +		tctx->state =3D TASK_ENQUEUED;
>> > +		tctx->enqueue_seq++;
>> > +
>> > +		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
>> > +		break;
>> > +
>> > +	case 6:
>> > +		/*
>> > +		 * Scenario 6: Store task in BPF internal queue. Task enters
>> > +		 * BPF custody (kernel sets SCX_TASK_NEED_DEQ). When
>> > +		 * ops.dispatch() later pops and inserts to local DSQ,
>> > +		 * ops.dequeue() must be called.
>> > +		 *
>> > +		 * If the queue is full, fallback to local DSQ. The task still
>> > +		 * goes through QUEUED in the kernel and gets ops.dequeue()
>> > +		 * when moved to the terminal DSQ, so we track it the same.
>> > +		 *
>> > +		 * If state is already ENQUEUED (e.g. task was on a DSQ when
>> > +		 * the scheduler was unregistered in a previous scenario),
>> > +		 * reset to NONE and proceed to avoid false positives.
>> > +		 */
>> > +		{
>> > +			s32 pid =3D p->pid;
>> > +
>> > +			if (tctx->state =3D=3D TASK_ENQUEUED)
>> > +				tctx->state =3D TASK_NONE;
>> > +
>> > +			tctx->state =3D TASK_ENQUEUED;
>> > +			tctx->enqueue_seq++;
>> > +
>> > +			/* Queue full: fallback to the global DSQ */
>> Nit: Can we remove this fallback? This silently changes the behavior of
>> the test, and even though it makes sense to avoid overflowing the queue,
>> it causes the test to succeed even if for some reason the
>> bpf_map_push_elem fails. Why not just bump the queue number to a
>> reasonably large number amount instead?
>
> Hm... but if for any reason we overflow the queue we'd get a false positi=
ve
> error: task is ignored, we trigger a stall and it looks like something is
> wrong in ops.dequeue(). WDYT?
>

I agree, but if we bump the queue size to a large number the probability
of that is nonexistent: I think these test make sense to run in CI-like
environments where there's few processes anyway, so if a queue is large
enough there will not be enough tasks to overflow it anyway. This is an
assumption we make for dsp_local_on, too. Maybe we can keep the fallback
but warn when it's used (see above)?

> Thanks,
> -Andrea

