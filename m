Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC82E2C2359
	for <sched-ext@lists.linux.dev>; Wed, 15 Oct 2025 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521315; cv=none; b=LDeQG2tFTiRT8qZ7FaQNetIfDUD3A7VT1jgDz59Kzd0BPPLJZeAiEUGJ98CAh8uOIopKipU+hX2qvNa0SRLnXPIkhUxVnSZgZniRkux1Vqb8/d3x/SDkGRfGYgq6ueTXZY/KGty07vn6XkDrjUANtFJuRtXQRNAGWPsbVYtKpCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521315; c=relaxed/simple;
	bh=jDK3wY41Y7yvUrK8211NgAoyyzvMcoyeGVytmAiwrIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paezYy+VLKWhWEf63NRmpxCICM7uelta19i+eVWNCO2BgZpkzaaUy5BqWo8wcRcqGQQUYHiSps5mqYLG+5iaXQ3wYG6Dik0R81kS1tSeZLkj/pwNAAZXnyJ+JvUOywKV9hKCb+dE4gXPjcllqOogBlt/oOfGy3oFqxOrhxtm0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 390DE16A3;
	Wed, 15 Oct 2025 02:41:45 -0700 (PDT)
Received: from [10.1.32.75] (e127648.arm.com [10.1.32.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 689F43F6A8;
	Wed, 15 Oct 2025 02:41:52 -0700 (PDT)
Message-ID: <69bda5d0-50fd-4508-95e0-d39bf2704255@arm.com>
Date: Wed, 15 Oct 2025 10:41:50 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] sched_ext: Add a selftest for scx_bpf_dsq_peek
To: Ryan Newton <rrnewton@gmail.com>, linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev, tj@kernel.org, arighi@nvidia.com,
 newton@meta.com
References: <20251015015712.3996346-1-rrnewton@gmail.com>
 <20251015015712.3996346-3-rrnewton@gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251015015712.3996346-3-rrnewton@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/25 02:57, Ryan Newton wrote:
> From: Ryan Newton <newton@meta.com>
> 
> This is the most basic unit test: make sure an empty queue peeks as
> empty, and when we put one element in the queue, make sure peek returns
> that element.
> 
> However, even this simple test is a little complicated by the different
> behavior of scx_bpf_dsq_insert in different calling contexts:
>  - insert is for direct dispatch in enqueue
>  - insert is delayed when called from select_cpu
> 
> In this case we split the insert and the peek that verifies the
> result between enqueue/dispatch.
> 
> Note: An alternative would be to call `scx_bpf_dsq_move_to_local` on an
> empty queue, which in turn calls `flush_dispatch_buf`, in order to flush
> the buffered insert. Unfortunately, this is not viable within the
> enqueue path, as it attempts a voluntary context switch within an RCU
> read-side critical section.
> 
> Signed-off-by: Ryan Newton <newton@meta.com>
> ---
>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>  .../selftests/sched_ext/peek_dsq.bpf.c        | 251 ++++++++++++++++++
>  tools/testing/selftests/sched_ext/peek_dsq.c  | 222 ++++++++++++++++
>  3 files changed, 474 insertions(+)
>  create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c
> 
> diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
> index 9d9d6b4c38b0..5fe45f9c5f8f 100644
> --- a/tools/testing/selftests/sched_ext/Makefile
> +++ b/tools/testing/selftests/sched_ext/Makefile
> @@ -174,6 +174,7 @@ auto-test-targets :=			\
>  	minimal				\
>  	numa				\
>  	allowed_cpus			\
> +	peek_dsq			\
>  	prog_run			\
>  	reload_loop			\
>  	select_cpu_dfl			\
> diff --git a/tools/testing/selftests/sched_ext/peek_dsq.bpf.c b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
> new file mode 100644
> index 000000000000..65e3f688ea39
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A BPF program for testing DSQ operations and peek in particular.
> + *
> + * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2025 Ryan Newton <ryan.newton@alum.mit.edu>
> + */
> +
> +#include <scx/common.bpf.h>
> +#include <scx/compat.bpf.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +UEI_DEFINE(uei); /* Error handling */
> +
> +#define MAX_SAMPLES 100
> +#define MAX_CPUS 512
> +#define DSQ_POOL_SIZE 8
> +int max_samples = MAX_SAMPLES;
> +int max_cpus = MAX_CPUS;
> +int dsq_pool_size = DSQ_POOL_SIZE;
> +
> +/* Global variables to store test results */
> +int dsq_peek_result1 = -1;
> +long dsq_inserted_pid = -1;
> +int insert_test_cpu = -1; /* Set to the cpu that performs the test */
> +long dsq_peek_result2 = -1;
> +long dsq_peek_result2_pid = -1;
> +long dsq_peek_result2_expected = -1;
> +int test_dsq_id = 1234; /* Use a simple ID like create_dsq example */
> +int real_dsq_id = 1235; /* DSQ for normal operation */
> +int enqueue_count = -1;
> +int dispatch_count = -1;
> +bool debug_ksym_exists;
> +
> +/* DSQ pool for stress testing */
> +int dsq_pool_base_id = 2000;
> +int phase1_complete = -1;
> +int total_peek_attempts = -1;
> +int successful_peeks = -1;
> +
> +/* BPF map for sharing peek results with userspace */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, MAX_SAMPLES);
> +	__type(key, u32);
> +	__type(value, long);
> +} peek_results SEC(".maps");
> +
> +static int get_random_dsq_id(void)
> +{
> +	u64 time = bpf_ktime_get_ns();
> +
> +	return dsq_pool_base_id + (time % DSQ_POOL_SIZE);
> +}
> +
> +static void record_peek_result(long pid)
> +{
> +	u32 slot_key;
> +	long *slot_pid_ptr;
> +	int ix;
> +
> +	if (pid <= 0)
> +		return;
> +
> +	/* Find an empty slot or one with the same PID */
> +	bpf_for(ix, 0, 10) {
> +		slot_key = (pid + ix) % MAX_SAMPLES;
> +		slot_pid_ptr = bpf_map_lookup_elem(&peek_results, &slot_key);
> +		if (!slot_pid_ptr)
> +			continue;
> +
> +		if (*slot_pid_ptr == -1 || *slot_pid_ptr == pid) {
> +			*slot_pid_ptr = pid;
> +			break;
> +		}
> +	}
> +}
> +
> +/* Scan all DSQs in the pool and try to move a task to local */
> +static int scan_dsq_pool(void)
> +{
> +	struct task_struct *task;
> +	int moved = 0;
> +	int i;
> +
> +	bpf_for(i, 0, DSQ_POOL_SIZE) {
> +		int dsq_id = dsq_pool_base_id + i;
> +
> +		total_peek_attempts++;
> +
> +		task = __COMPAT_scx_bpf_dsq_peek(dsq_id);
> +		if (task) {
> +			successful_peeks++;
> +			record_peek_result(task->pid);
> +
> +			/* Try to move this task to local */
> +			if (!moved && scx_bpf_dsq_move_to_local(dsq_id) == 0) {
> +				moved = 1;
> +				break;
> +			}
> +		}
> +	}
> +	return moved;
> +}
> +
> +/* Struct_ops scheduler for testing DSQ peek operations */
> +void BPF_STRUCT_OPS(peek_dsq_enqueue, struct task_struct *p, u64 enq_flags)
> +{
> +	struct task_struct *peek_result;
> +	int last_insert_test_cpu, cpu;
> +
> +	enqueue_count++;
> +	cpu = bpf_get_smp_processor_id();
> +	last_insert_test_cpu = __sync_val_compare_and_swap(&insert_test_cpu, -1, cpu);
> +
> +	/* Phase 1: Simple insert-then-peek test (only on first task) */
> +	if (last_insert_test_cpu == -1) {
> +		bpf_printk("peek_dsq_enqueue beginning phase 1 peek test on cpu %d", cpu);
> +
> +		/* Test 1: Peek empty DSQ - should return NULL */
> +		peek_result = __COMPAT_scx_bpf_dsq_peek(test_dsq_id);
> +		dsq_peek_result1 = (long)peek_result; /* Should be 0 (NULL) */
> +
> +		/* Test 2: Insert task into test DSQ for testing in dispatch callback */
> +		dsq_inserted_pid = p->pid;
> +		scx_bpf_dsq_insert(p, test_dsq_id, 0, enq_flags);
> +		dsq_peek_result2_expected = (long)p; /* Expected the task we just inserted */
> +	} else if (!phase1_complete) {
> +		/* Still in phase 1, use real DSQ */
> +		scx_bpf_dsq_insert(p, real_dsq_id, 0, enq_flags);
> +	} else {
> +		/* Phase 2: Random DSQ insertion for stress testing */
> +		int random_dsq_id = get_random_dsq_id();
> +
> +		scx_bpf_dsq_insert(p, random_dsq_id, 0, enq_flags);
> +	}
> +}
> +
> +void BPF_STRUCT_OPS(peek_dsq_dispatch, s32 cpu, struct task_struct *prev)
> +{
> +	dispatch_count++;
> +
> +	/* Phase 1: Complete the simple peek test if we inserted a task but
> +	 * haven't tested peek yet
> +	 */
> +	if (insert_test_cpu == cpu && dsq_peek_result2 == -1) {
> +		struct task_struct *peek_result;
> +
> +		bpf_printk("peek_dsq_dispatch completing phase 1 peek test on cpu %d", cpu);
> +
> +		/* Test 3: Peek DSQ after insert - should return the task we inserted */
> +		peek_result = __COMPAT_scx_bpf_dsq_peek(test_dsq_id);
> +		/* Store the PID of the peeked task for comparison */
> +		dsq_peek_result2 = (long)peek_result;
> +		dsq_peek_result2_pid = peek_result ? peek_result->pid : -1;
> +
> +		/* Now consume the task since we've peeked at it */
> +		scx_bpf_dsq_move_to_local(test_dsq_id);
> +
> +		/* Mark phase 1 as complete */
> +		phase1_complete = 1;
> +		bpf_printk("Phase 1 complete, starting phase 2 stress testing");
> +	} else if (!phase1_complete) {
> +		/* Still in phase 1, use real DSQ */
> +		scx_bpf_dsq_move_to_local(real_dsq_id);
> +	} else {
> +		/* Phase 2: Scan all DSQs in the pool and try to move a task */
> +		if (!scan_dsq_pool()) {
> +			/* No tasks found in DSQ pool, fall back to real DSQ */
> +			scx_bpf_dsq_move_to_local(real_dsq_id);
> +		}
> +	}
> +}
> +
> +s32 BPF_STRUCT_OPS_SLEEPABLE(peek_dsq_init)
> +{
> +	s32 err;
> +	int i;
> +
> +	/* Always set debug values so we can see which version we're using */
> +	debug_ksym_exists = bpf_ksym_exists(scx_bpf_dsq_peek) ? 1 : 0;
> +
> +	/* Initialize state first */
> +	insert_test_cpu = -1;
> +	enqueue_count = 0;
> +	dispatch_count = 0;
> +	phase1_complete = 0;
> +	total_peek_attempts = 0;
> +	successful_peeks = 0;
> +
> +	/* Create the test and real DSQs */
> +	err = scx_bpf_create_dsq(test_dsq_id, -1);
> +	if (err) {
> +		scx_bpf_error("Failed to create DSQ %d: %d", test_dsq_id, err);
> +	return err;

indentation
The rest looks okay to me.
