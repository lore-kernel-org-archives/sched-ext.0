Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ED42EA47C
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763815; cv=none; b=ETmXiyPIxro6hiQtc4Pz1SEvBMR+9334auH19vxmCaqsExWOZ5OwfH0IQ93xjugjdeCTt/eyXDZCfAneoCCKyqgcz/EQCcYjpR8cVLBCr73Kh8A78orlc3YYZIyh8buWAWcIGgKsRm9yqmC6BmQI3/wqWqdjmM2ISNu4deTdhZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763815; c=relaxed/simple;
	bh=0821OJoO9v1zdMJoDbcQKYvr7EfGnWEOrTrYjU7dXGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhmzynk4jKIqxwZ+azQEMWHqXSZVUpfh5Jutmb3JBYIhujX9dAAsZSZQllzT17ZCKmlPaX1gvgHBNgWvRAZXmw/PMUkb98gUB24VesZMywpw7WymdF7uG+K1P49IJ51UtiO/A8dIQXhyFMGPsPpszm3VTlJmtZYNaQ7cVMPuLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ov2zhITS; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ov2zhITS"
Date: Mon, 10 Nov 2025 09:36:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762763811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I+VBD76g2XS7+HhQ07AhRyPzDR05ambIwPaE1MqxW2Q=;
	b=ov2zhITSZf+F/wPKSEZtGmSbh/cEGOIKirZb8V0PxaKncCQXYjaelM5eAnE5n2mjr09Qja
	Yh30zcSr2Wc4RJdM8dBwEXIo5HHVB5H7IQ4Yics9O5xO9uHqSjA/YqCOPG3IrrxWYujmK+
	w6paRuzAGV5/WsybxgDeO//xgLiXj6g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] sched_ext: Add scx_cpu0 example scheduler
Message-ID: <aRGkHhAWTWdWELAY@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-12-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-12-tj@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi Tejun,

On Sun, Nov 09, 2025 at 08:31:10AM -1000, Tejun Heo wrote:
> Add scx_cpu0, a simple scheduler that queues all tasks to a single DSQ and
> only dispatches them from CPU0 in FIFO order. This is useful for testing bypass
> behavior when many tasks are concentrated on a single CPU. If the load balancer
> doesn't work, bypass mode can trigger task hangs or RCU stalls as the queue is
> long and there's only one CPU working on it.
> 
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Emil Tsalapatis <etsal@meta.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  tools/sched_ext/Makefile       |   2 +-
>  tools/sched_ext/scx_cpu0.bpf.c |  84 ++++++++++++++++++++++++++
>  tools/sched_ext/scx_cpu0.c     | 106 +++++++++++++++++++++++++++++++++
>  3 files changed, 191 insertions(+), 1 deletion(-)
>  create mode 100644 tools/sched_ext/scx_cpu0.bpf.c
>  create mode 100644 tools/sched_ext/scx_cpu0.c
> 
> diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
> index d68780e2e03d..069b0bc38e55 100644
> --- a/tools/sched_ext/Makefile
> +++ b/tools/sched_ext/Makefile
> @@ -187,7 +187,7 @@ $(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BP
>  
>  SCX_COMMON_DEPS := include/scx/common.h include/scx/user_exit_info.h | $(BINDIR)
>  
> -c-sched-targets = scx_simple scx_qmap scx_central scx_flatcg
> +c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_flatcg
>  
>  $(addprefix $(BINDIR)/,$(c-sched-targets)): \
>  	$(BINDIR)/%: \
> diff --git a/tools/sched_ext/scx_cpu0.bpf.c b/tools/sched_ext/scx_cpu0.bpf.c
> new file mode 100644
> index 000000000000..8626bd369f60
> --- /dev/null
> +++ b/tools/sched_ext/scx_cpu0.bpf.c
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * A CPU0 scheduler.
> + *
> + * This scheduler queues all tasks to a shared DSQ and only dispatches them on
> + * CPU0 in FIFO order. This is useful for testing bypass behavior when many
> + * tasks are concentrated on a single CPU. If the load balancer doesn't work,
> + * bypass mode can trigger task hangs or RCU stalls as the queue is long and
> + * there's only one CPU working on it.
> + *
> + * - Statistics tracking how many tasks are queued to local and CPU0 DSQs.
> + * - Termination notification for userspace.
> + *
> + * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2025 Tejun Heo <tj@kernel.org>
> + */
> +#include <scx/common.bpf.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +const volatile u32 nr_cpus = 32;	/* !0 for veristat, set during init */
> +
> +UEI_DEFINE(uei);
> +
> +/*
> + * We create a custom DSQ with ID 0 that we dispatch to and consume from on
> + * CPU0.
> + */
> +#define DSQ_CPU0 0
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(key_size, sizeof(u32));
> +	__uint(value_size, sizeof(u64));
> +	__uint(max_entries, 2);			/* [local, cpu0] */
> +} stats SEC(".maps");
> +
> +static void stat_inc(u32 idx)
> +{
> +	u64 *cnt_p = bpf_map_lookup_elem(&stats, &idx);
> +	if (cnt_p)
> +		(*cnt_p)++;
> +}
> +
> +s32 BPF_STRUCT_OPS(cpu0_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
> +{
> +	return 0;
> +}
> +
> +void BPF_STRUCT_OPS(cpu0_enqueue, struct task_struct *p, u64 enq_flags)
> +{
> +	if (p->nr_cpus_allowed < nr_cpus) {

We could be even more aggressive with DSQ_CPU0 and check
bpf_cpumask_test_cpu(0, p->cpus_ptr), but this is fine as well.

> +		stat_inc(0);	/* count local queueing */
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);

And this is why I was suggesting to automatically fallback to the new
global default time slice internally. In this case do we want to preserve
the old 20ms default or automatically switch to the new one?

Apart than these minor details that we can address later:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> +		return;
> +	}
> +
> +	stat_inc(1);	/* count cpu0 queueing */
> +	scx_bpf_dsq_insert(p, DSQ_CPU0, SCX_SLICE_DFL, enq_flags);
> +}
> +
> +void BPF_STRUCT_OPS(cpu0_dispatch, s32 cpu, struct task_struct *prev)
> +{
> +	if (cpu == 0)
> +		scx_bpf_dsq_move_to_local(DSQ_CPU0);
> +}
> +
> +s32 BPF_STRUCT_OPS_SLEEPABLE(cpu0_init)
> +{
> +	return scx_bpf_create_dsq(DSQ_CPU0, -1);
> +}
> +
> +void BPF_STRUCT_OPS(cpu0_exit, struct scx_exit_info *ei)
> +{
> +	UEI_RECORD(uei, ei);
> +}
> +
> +SCX_OPS_DEFINE(cpu0_ops,
> +	       .select_cpu		= (void *)cpu0_select_cpu,
> +	       .enqueue			= (void *)cpu0_enqueue,
> +	       .dispatch		= (void *)cpu0_dispatch,
> +	       .init			= (void *)cpu0_init,
> +	       .exit			= (void *)cpu0_exit,
> +	       .name			= "cpu0");
> diff --git a/tools/sched_ext/scx_cpu0.c b/tools/sched_ext/scx_cpu0.c
> new file mode 100644
> index 000000000000..1e4fa4ab8da9
> --- /dev/null
> +++ b/tools/sched_ext/scx_cpu0.c
> @@ -0,0 +1,106 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2025 Tejun Heo <tj@kernel.org>
> + */
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <assert.h>
> +#include <libgen.h>
> +#include <bpf/bpf.h>
> +#include <scx/common.h>
> +#include "scx_cpu0.bpf.skel.h"
> +
> +const char help_fmt[] =
> +"A cpu0 sched_ext scheduler.\n"
> +"\n"
> +"See the top-level comment in .bpf.c for more details.\n"
> +"\n"
> +"Usage: %s [-v]\n"
> +"\n"
> +"  -v            Print libbpf debug messages\n"
> +"  -h            Display this help and exit\n";
> +
> +static bool verbose;
> +static volatile int exit_req;
> +
> +static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
> +{
> +	if (level == LIBBPF_DEBUG && !verbose)
> +		return 0;
> +	return vfprintf(stderr, format, args);
> +}
> +
> +static void sigint_handler(int sig)
> +{
> +	exit_req = 1;
> +}
> +
> +static void read_stats(struct scx_cpu0 *skel, __u64 *stats)
> +{
> +	int nr_cpus = libbpf_num_possible_cpus();
> +	assert(nr_cpus > 0);
> +	__u64 cnts[2][nr_cpus];
> +	__u32 idx;
> +
> +	memset(stats, 0, sizeof(stats[0]) * 2);
> +
> +	for (idx = 0; idx < 2; idx++) {
> +		int ret, cpu;
> +
> +		ret = bpf_map_lookup_elem(bpf_map__fd(skel->maps.stats),
> +					  &idx, cnts[idx]);
> +		if (ret < 0)
> +			continue;
> +		for (cpu = 0; cpu < nr_cpus; cpu++)
> +			stats[idx] += cnts[idx][cpu];
> +	}
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct scx_cpu0 *skel;
> +	struct bpf_link *link;
> +	__u32 opt;
> +	__u64 ecode;
> +
> +	libbpf_set_print(libbpf_print_fn);
> +	signal(SIGINT, sigint_handler);
> +	signal(SIGTERM, sigint_handler);
> +restart:
> +	skel = SCX_OPS_OPEN(cpu0_ops, scx_cpu0);
> +
> +	skel->rodata->nr_cpus = libbpf_num_possible_cpus();
> +
> +	while ((opt = getopt(argc, argv, "vh")) != -1) {
> +		switch (opt) {
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			fprintf(stderr, help_fmt, basename(argv[0]));
> +			return opt != 'h';
> +		}
> +	}
> +
> +	SCX_OPS_LOAD(skel, cpu0_ops, scx_cpu0, uei);
> +	link = SCX_OPS_ATTACH(skel, cpu0_ops, scx_cpu0);
> +
> +	while (!exit_req && !UEI_EXITED(skel, uei)) {
> +		__u64 stats[2];
> +
> +		read_stats(skel, stats);
> +		printf("local=%llu cpu0=%llu\n", stats[0], stats[1]);
> +		fflush(stdout);
> +		sleep(1);
> +	}
> +
> +	bpf_link__destroy(link);
> +	ecode = UEI_REPORT(skel, uei);
> +	scx_cpu0__destroy(skel);
> +
> +	if (UEI_ECODE_RESTART(ecode))
> +		goto restart;
> +	return 0;
> +}
> -- 
> 2.51.1
> 
