Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8617E8287E
	for <sched-ext@lists.linux.dev>; Sun, 28 Dec 2025 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766892497; cv=none; b=lcaRRQmNhg56KWPqW4XYluJkezLFtpHwODrDM7peyy/wH64qnLHbyasasJXKSqlMs4Z2LQnElqO7ZExDpbkNfsKzDkF3MgRL0mAP01faP/sIqqVJXHkwffbcZpD3DoiFjiDIkiYdAEGFhPuNL8HpfEFriAuDRBJdWfnBremO1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766892497; c=relaxed/simple;
	bh=UiyNu/itFSk5RoPlo40JKZoQHav/R7jPZwUIIIns/DA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Hm2rUB4aEP+X8tEJV8ABJ4oStsJ1BCHmEFvLpS7iYCOXulqAKeC8ibxQZMZodoZ2k2dd0W5OAuuUk58RgrhVP9VBPpDLLxY44rjSE37eTLIGBpU9P+gQrokaQA0gM10o6mDtHA/KVJeSTT8v2qO0V1yUOBQADL5o60Lsz1rjY+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=gba6KerY; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="gba6KerY"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88888c41a13so103076576d6.3
        for <sched-ext@lists.linux.dev>; Sat, 27 Dec 2025 19:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1766892493; x=1767497293; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1GJKnlFvsBc0DJz2nZmZKmRyHqx8pv0saxySKmboAc=;
        b=gba6KerYaw5hHRNE14QVzQ3PMQ1oVOb4s8YD8kE7Dw51allamueFWwLQESISrpTB+B
         z+6rZDVKezE2C4W0bsFDcMQssQvPICWDLCRMfSoBrLArryIHK5Qqvhsn6hGD2V8WwXwg
         JrbZ5SomI/oXgylFVad4ZChasZxLOOIh6PKt7OOXiHSw+OFd05Y72C93Nwx/j4ShQdga
         yXZO2ASHDeytvcl89lvFewRk8Z55pV1L1wXcajLNMYb9jCU236KZVAn5fltr5jfj0I1c
         qp0sXZPHu/UVonSpEoLTU7Q51T5f/DbJePlhmRRieSGj27Yxlvmedib380s4ZixtbyX8
         Iemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766892493; x=1767497293;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1GJKnlFvsBc0DJz2nZmZKmRyHqx8pv0saxySKmboAc=;
        b=TV40FsRm1WIeqGXnO2NAKW6OavwP4Ur6AIPbXTJzIVDB3+KV7nAkm0FN/rvf2hoNxH
         VjzOge/RpvPjhsPyJZ7ijRDV3phdQ5EvjtYr1q23wDoaRwH9qp3OvaYlqL3aA80AazZc
         aqNfZgAG7yCOj1cDp8UNLHaKLqx4Ie/ly3WMD1eDtp8OIX1HqVO+K2QtWP87mNsIV6Pz
         FVbPBrI3tM++doyQvOU60p1/SCJsf3OKlOrPnGh78aHIEVrZTKQJrrgaVzJ6wPyflJdJ
         hs571Z4DEwUtnehve/2dGEq1fVt15HRyvdNpSqGBGhw+uQKW9aL9MJ6oI7DkgocDUwAd
         92zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKVn/YONOq3oF4ob0XnDmRspOk0vNCGXFMFWX9JMXzppJ8jiecdvH2Ls7cZQbIBTNZtLQbi618XzI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxTlJiUPhWFO7C7aYRDyj/5lREQCnFvJa7HYNTuLZacfa51HIRm
	uu90KzIropHW/ZgPARIv102LcAFVdesYKvavSWylnIEbgDR4Pp6i1uNnqqo2AGkoiAg=
X-Gm-Gg: AY/fxX7pNp5NR4EZaike0mT8sYCzZhcaHLv1wtqZ/Tx/ZAlPq/pmTboWi8CcN+i2roF
	VrqEUPA27+PhZdi0IAdMi5vuiq8F8tS5idjiSp6VGbUySjhproULb8XUDuC99YkRlmUQ+p8zYI1
	7x6plCf/q56xHAR2VHBvnCe70v37E1rZJ0BS6BgE2gSrxvkjgbhZxfPcnhjhW6PgV2qW/zNKw8r
	eerLpCQ4Mpjpo7GOyTek3mejBB71xlkiorb7nrtg/PgKOF+KtU+5yz7SG9aCUdAPPzc+IG5NnbE
	jrH23s5XsSpzPi0XEYMj4lx65KDlRIMC79DOAvb+D+zmUK7OFtTxDLM5W6RU+0T9uFNobyGBRzo
	9LVeogoGtlCoibfvwbXc53t11P2jW2J/tIbc1vPQ3X7ga+pi7NC29OaKFFSNDbMc/GZUamIZ0DA
	2L+q+9SYwzi5d3VLkc0Cy1Nw==
X-Google-Smtp-Source: AGHT+IFzKaRU9VhOR2GreSWFUbJNutLvzh1trPwA4ZZBwsnI7hfQJyWne+B1Ni/HKWborvfD2g/zqA==
X-Received: by 2002:a05:6214:5a02:b0:882:8746:b047 with SMTP id 6a1803df08f44-88d81278ab3mr440363906d6.10.1766892493219;
        Sat, 27 Dec 2025 19:28:13 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d96bec097sm200074966d6.16.2025.12.27.19.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 19:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Dec 2025 22:28:11 -0500
Message-Id: <DF9J45056GT3.9VDAT91SZW7T@etsalapatis.com>
Cc: "Daniel Hodges" <hodgesd@meta.com>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrea Righi" <arighi@nvidia.com>, "Tejun Heo" <tj@kernel.org>, "David
 Vernet" <void@manifault.com>, "Changwoo Min" <changwoo@igalia.com>
X-Mailer: aerc 0.20.1
References: <20251219224450.2537941-1-arighi@nvidia.com>
 <20251219224450.2537941-3-arighi@nvidia.com>
In-Reply-To: <20251219224450.2537941-3-arighi@nvidia.com>

On Fri Dec 19, 2025 at 5:43 PM EST, Andrea Righi wrote:
> Add a kselftest to validate ops.dequeue() semantics with direct
> dispatch, user DSQ dispatch, affinity changes and verify that any
> ops.enqueue() is balanced by a corresponding ops.dequeue().
>
> Cc: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Hi Andrea,

>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>  .../testing/selftests/sched_ext/dequeue.bpf.c | 139 ++++++++++++++
>  tools/testing/selftests/sched_ext/dequeue.c   | 172 ++++++++++++++++++
>  3 files changed, 312 insertions(+)
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
> index 0000000000000..aae19bfd42f04
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/dequeue.bpf.c
> @@ -0,0 +1,139 @@
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
> + * - dequeue_cnt: Number of times ops.dequeue() was called
> + */
> +u64 enqueue_cnt, dequeue_cnt;
> +
> +/*
> + * Test scenarios:
> + * - 0: Dispatch to local DSQ
> + * - 1: Dispatch to shared DSQ
> + */
> +u32 test_scenario;
> +
> +/* Per-task state */
> +struct task_ctx {
> +	u64 enqueued;	/* was this task enqueued? */

Do we use this for anything? If not, can we remove it?
We can also just do an extra sanity check with it during
enqueues/dequeues to ensure we have no double operations.


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
> +	tctx->enqueued =3D 1;
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
> +	tctx->enqueued =3D 0;
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
> index 0000000000000..0fd6748786079
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/dequeue.c
> @@ -0,0 +1,172 @@
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
> +	u64 enq_start, deq_start;
> +	u64 enq_delta, deq_delta;
> +
> +	/* Set the test scenario */
> +	skel->bss->test_scenario =3D scenario;
> +
> +	/* Record starting counts */
> +	enq_start =3D skel->bss->enqueue_cnt;
> +	deq_start =3D skel->bss->dequeue_cnt;
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
> +
> +	printf("%s:\n", scenario_name);
> +	printf("  enqueues: %lu\n", (unsigned long)enq_delta);
> +	printf("  dequeues: %lu\n", (unsigned long)deq_delta);
> +
> +	/* Validate that we got enqueue and dequeue events */
> +	SCX_GT(enq_delta, 0);
> +	SCX_GT(deq_delta, 0);
> +
> +	if (enq_delta > deq_delta)
> +		SCX_FAIL("Too many enqueues without dequeues: %lu enqueues, %lu dequeu=
es",
> +			    (unsigned long)enq_delta, (unsigned long)deq_delta);
> +	else if (deq_delta > enq_delta)
> +		SCX_FAIL("More dequeues than enqueues: %lu enqueues, %lu dequeues",
> +			    (unsigned long)enq_delta, (unsigned long)deq_delta);
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
> +	printf("\nAll scenarios passed\n");
> +	printf("-> Validated: ops.dequeue() is called for tasks on local DSQ\n"=
);
> +	printf("-> Validated: ops.dequeue() is called for tasks on user DSQ\n")=
;
> +	printf("-> Validated: Every enqueue is balanced with dequeue or executi=
on\n");
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

