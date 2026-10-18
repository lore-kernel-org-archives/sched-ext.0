Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFECA48A8B8
	for <sched-ext@lists.linux.dev>; Sun, 18 Oct 2026 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792326634; cv=none; b=UhW9s4onX0lyzP9GlNIA9rRURio1TtmypW2p8zrkFvBo5cM0Z872tw8Bdfj++mD9LyvxRJl/kORr6C3QA2lMg1VI/QSuKjJ2ybcqEmciO5HV+YMi6+2F8aN3hJTQ+l+SsWd9ZktYhVqNXdT7yDink/+JTWwx3s5g2Ez70juPB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792326634; c=relaxed/simple;
	bh=JeMI1pnWKhx2wlVM9pQ1+0L65lEI53tr1L+qOVTjjGE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HOd/NAiwrOuiL/+aJfJKIxfgIZjgNZXpjCUW+gOCWaLVdKlCNls2X+PPIHsPOEv9qOsNvL4VntBiwqisnvnCzj+uLua52appcG1uFk4QzzjxuvpUcQNDEZ4GK9U5Eqr24iRci4kLPM6YLRAlxoqBfJhE+2BjU5wTiQimOUPIok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BepoEe9i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BepoEe9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4181F000C4;
	Sun, 18 Oct 2026 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792326632;
	bh=9BzMjhWQ7yrYdxLqsdPNH73mkFtJ7Y12KF4NHg83Ghw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BepoEe9i9CUCax5uobLH1opwl5NILMwa+oBsgADzhsngFZ8SJR6IAJItJ9rcweKhM
	 pq15jkshBRVxafEcz4uIemRJ0Z0wkS2qrJFvoplO1yEdbvfwBDGRsv1N4T/zPnpbqm
	 czw3zz6P4+0m5KC+vQLSCqhFAF0K7txti94KPusxtQ3lSHAuqHshsJJDhenAT4lzuX
	 chGVEO88CMZesh0JsoeEADUJdTAEIsDkXaQecq0zitcaE1dDsHrYT7r3hw3i+Ps9L0
	 LepBeseA/wrRZXqYolXgKOvgL3AWiA0j+XmgTF3XifFK+M1JUH22pRVeNWmej32MM5
	 /iNYy/TBQL/Ag==
Message-ID: <sashiko-outbox-176108@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/5] selftests/sched_ext: Add cpu_avail tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuba Piecuch" <jpiecuch@google.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <935eb08e4c7ebce012b4f1c61406a0a53b016862.1792248922.git.jpiecuch@google.com>
References: <cover.1792248922.git.jpiecuch@google.com>
 <935eb08e4c7ebce012b4f1c61406a0a53b016862.1792248922.git.jpiecuch@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 12:30:32 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/sched_ext: spinners in test_churn() inherit single-CPU=
 affinity
--

commit 8fdb05fa56aeeeb8544b8552cb1d015e3ebd3eff
Author: Kuba Piecuch <jpiecuch@google.com>

selftests/sched_ext: Add cpu_avail tests

This commit adds the cpu_avail and cpu_avail_core selftests to verify that
ops.cpu_acquire() and ops.cpu_release() accurately track CPU availability
across various scheduling transitions, hotplug events, and core scheduling.

> diff --git a/tools/testing/selftests/sched_ext/cpu_avail.c b/tools/testin=
g/selftests/sched_ext/cpu_avail.c
> new file mode 100644
> index 0000000000000..3796f94b05a93
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/cpu_avail.c

[ ... ]

> +/*
> + * Run RT tasks, SCX tasks and sched_setscheduler() class changes on all=
 CPUs
> + * at once. The sched_switch checker must not find any inconsistencies.
> + */
> +static enum scx_test_status test_churn(struct cpu_avail_ctx *ctx)
> +{
> +	struct cpu_avail__bss *bss =3D ctx->skel->bss;
> +	struct task_spec spinner =3D { .cpu =3D -1, .policy =3D SCHED_OTHER };
> +	struct task_spec rt =3D {
> +		.policy =3D SCHED_FIFO, .prio =3D 20,
> +		.period_us =3D 1000, .run_us =3D 200, .duration_ms =3D 1500,
> +	};
> +	enum scx_test_status ret =3D SCX_TEST_FAIL;
> +	int nr_spinners =3D 0, nr_rts =3D 0, cpu, i;
> +	pid_t *spinners, *rts;
> +	u64 checks =3D bss->nr_checks;
> +	u64 end;
> +
> +	spinners =3D calloc(ctx->nr_cpus, sizeof(pid_t));
> +	rts =3D calloc(ctx->nr_cpus, sizeof(pid_t));
> +	if (!spinners || !rts) {
> +		SCX_ERR("Failed to allocate");
> +		goto out;
> +	}
> +
> +	for (cpu =3D 0; cpu < ctx->nr_cpus; cpu++) {
> +		if (!cpu_is_online(cpu))
> +			continue;
> +
> +		spinners[nr_spinners] =3D spawn_task(&spinner);
> +		if (spinners[nr_spinners] < 0) {
> +			SCX_ERR("Failed to fork (%d)", errno);
> +			goto out;
> +		}
> +		nr_spinners++;
> +
> +		rt.cpu =3D cpu;
> +		rts[nr_rts] =3D spawn_task(&rt);
> +		if (rts[nr_rts] < 0) {
> +			SCX_ERR("Failed to fork (%d)", errno);
> +			goto out;
> +		}
> +		nr_rts++;
> +	}
> +
> +	/* flip a spinner between SCX and RT while the RT tasks run */
> +	end =3D now_ns() + 1500 * 1000000ULL;
> +	for (i =3D 0; now_ns() < end; i++) {
> +		if (set_policy(spinners[0], i % 2 ? SCHED_OTHER : SCHED_FIFO,
> +			       i % 2 ? 0 : 1)) {
> +			SCX_ERR("Failed to set policy (%d)", errno);
> +			goto out;
> +		}
> +		sleep_ms(2);
> +	}

[ ... ]

> +static enum scx_test_status setup(void **ctxp)
> +{
> +	struct cpu_avail_ctx *ctx;
> +	int cpu;

[ ... ]

> +	if (sched_getaffinity(0, sizeof(ctx->orig_mask), &ctx->orig_mask) ||
> +	    pin_to_cpu(0, ctx->ctl_cpu)) {
> +		SCX_ERR("Failed to pin to CPU %d", ctx->ctl_cpu);
> +		free(ctx);
> +		return SCX_TEST_FAIL;
> +	}

[ ... ]

> diff --git a/tools/testing/selftests/sched_ext/cpu_avail.h b/tools/testin=
g/selftests/sched_ext/cpu_avail.h
> new file mode 100644
> index 0000000000000..97659e1061b87
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/cpu_avail.h

[ ... ]

> +static inline pid_t fork_task(const struct task_spec *spec, int *go_fd)
> +{
> +	int fds[2];
> +	pid_t pid;
> +	char c;
> +
> +	if (pipe(fds))
> +		return -1;
> +
> +	pid =3D fork();
> +	if (pid < 0) {
> +		close(fds[0]);
> +		close(fds[1]);
> +		return -1;
> +	}
> +
> +	if (!pid) {
> +		close(fds[1]);
> +		if (read(fds[0], &c, 1) !=3D 1)
> +			exit(EXIT_FAILURE);
> +		close(fds[0]);
> +		if (spec->cpu >=3D 0 && pin_to_cpu(0, spec->cpu))
> +			exit(EXIT_FAILURE);

[Severity: Medium]
Does setting spec->cpu =3D -1 in test_churn() leave all spinner tasks pinned
to ctx->ctl_cpu instead of running across all CPUs?

In setup(), the parent test runner pins itself to ctx->ctl_cpu via
pin_to_cpu(0, ctx->ctl_cpu). When test_churn() spawns spinners with
spinner.cpu =3D -1 via spawn_task() -> fork_task(), fork_task() only changes
affinity when spec->cpu >=3D 0, so the child inherits the parent's single-C=
PU
affinity mask on ctx->ctl_cpu.

Because p->nr_cpus_allowed is 1, cpu_avail_enqueue() in
tools/testing/selftests/sched_ext/cpu_avail.bpf.c queues all spinners onto
SCX_DSQ_LOCAL for ctx->ctl_cpu rather than SCX_DSQ_GLOBAL:

	/* queue pinned tasks on the local DSQ of the CPU they're enqueued on */
	if (p->nr_cpus_allowed =3D=3D 1)
		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, slice, enq_flags);
	else
		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, slice, enq_flags);

In addition, when test_churn() switches spinners[0] (an infinite busy-loop
task with period_us =3D=3D 0) to SCHED_FIFO on iteration i =3D 0, spinners[=
0] is
pinned to the same ctx->ctl_cpu as the SCHED_OTHER test runner. This
immediately preempts and starves the test runner until RT throttling kicks
in, where the runner then has to wait behind all the other spinners queued
on ctx->ctl_cpu's local DSQ (which on machines with many CPUs can stall
runnable tasks on ctx->ctl_cpu past the 10-second watchdog timeout).

Should fork_task() restore a full CPU affinity mask (such as ctx->orig_mask)
when spec->cpu < 0?

> +		if (spec->policy !=3D SCHED_OTHER &&
> +		    set_policy(0, spec->policy, spec->prio))
> +			exit(EXIT_FAILURE);
> +		task_body(spec);
> +		exit(EXIT_SUCCESS);
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792248922.gi=
t.jpiecuch@google.com?part=3D5
