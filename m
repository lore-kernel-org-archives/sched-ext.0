Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF603B5311;
	Wed, 16 Sep 2026 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593562; cv=none; b=JQIHn0qSyFtkHc5gV1UHj18cI9WGrDlLwO2e1AOGjYimAUVijfw8Tc9JJJzK6SWEEYU9p1fYVj8PPkhWfgAnm1qezdRXhqbVfzQN2rDu7XuOArLdyxMdhPNQ9PaspKBY70FgtE1VrYrYbpVlcEgT/bLhCLi3o3OHvZvOl70kXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593562; c=relaxed/simple;
	bh=ZJj6sOnAWihmjCAI1p9TzUptqhR6jfpsZ0hJnvzvjA4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJGTpFfK9ItoEOGQwykN4H+dzthW7doYdwBwLHNr3JFMjO/EatUfZB9xNZqU2fEts0/lpq89UZmRyElGppfUPeOxMTuWdq2555t7Y88bWXLBCBuv+CTnNNHZNeyfqCsHxbrvnBYJ6VJFsHBChTWAlkbVN8d8NGP3UwExbf/LF9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auPAgx9P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auPAgx9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7711F00893;
	Wed, 16 Sep 2026 21:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789593542;
	bh=GrE93os0smfRVept2SAd6k9NjBTA7zM10Cs3NirTs20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=auPAgx9PgTFnpeSp/JBqkRFzaWH9lJJ2wDmVTstmDvlNA6hKESZr3jp+YcySerB8l
	 rDeCRq8tPkt2FO7SR3EdFg5Tg3Rcypd1Fzg15oljQ2ooe2hLxBxDQc1QwEmK+/C9Z2
	 r6zpeOTUj/kI6VCoUZAJejUNUp/Y0MDCzpsOT1L05BqSxYQC9j3K426mHJ1LNElSm2
	 zVSySWfgWeQbl7drn54kNXTV5OrM559Bn0Xf13jMSLjipEpAtZ+kwmQieBhJJ/wUxD
	 7wuVGO542ayrhEeLpSck/+e7zgRnIBtAJSJwIfNSXOxYAXm9oaejNaQ+dDtz4C4fQL
	 0m93vLFgf9uyg==
Message-ID: <3cd8e126a2f214673abfa78fc303b1b1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <etsal@meta.com>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add lazy preemption tests
Date: Wed, 16 Sep 2026 11:03:36 -1000
In-Reply-To: <20260915194611.2674127-3-arighi@nvidia.com>
References: <20260915194611.2674127-1-arighi@nvidia.com>
 <20260915194611.2674127-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Andrea.

This is an AI review. The tests pass here under vng in lazy, full and none
modes. The timing below was measured with the target CPU on nohz_full.

On Tue, Sep 15, 2026 at 09:45:13PM +0200, Andrea Righi wrote:
> +void BPF_STRUCT_OPS(kick_stopping, struct task_struct *p, bool runnable)
> +{
> +	if (p->pid == victim_pid && state == KICK_STATE_RESCHED)
> +		state = KICK_STATE_DONE;
> +}

In the kick and tick scenarios the victim is the only runnable task on the
target CPU, so when its slice is cleared the kernel keeps running it with a
refilled slice and ops.stopping() is never called. DONE only arrives when some
other task pinned to that CPU wakes up. With the target CPU on nohz_full here,
the first such wakeup was a kworker 2.86s after the victim started, against
the 3s wait. Without nohz_full the scenarios still spend about half a second
each waiting for one. SCX_OPS_ENQ_LAST with the SCX_ENQ_LAST kick as in
nohz_tick.bpf.c would put the victim through ops.stopping() on its own.

> +SEC("fexit/__resched_curr")
> +int BPF_PROG(kick_need_resched, struct rq *rq, int tif)
> +{
> +	struct task_struct *task = BPF_CORE_READ(rq, curr);
> +
> +	if (!task || BPF_CORE_READ(task, pid) != victim_pid ||
> +	    BPF_CORE_READ(rq, cpu) != target_cpu || state != KICK_STATE_QUEUED)
> +		return 0;

This latches the first resched of the victim whatever the cause. A higher
class wakeup on the target CPU inside the window, which is the whole 20ms
slice in TICK_EXPIRY, records a full slice and fails observation_valid().
Skipping observations with a non-zero slice would be more robust.

> +	SCX_EQ(lazy_wait.resched_tif, immediate.resched_tif);
> +	SCX_GT(lazy_wait.nr_wait_callbacks, 0);

DONE is set from ops.stopping() before the context switch and the balance
callback runs after it, so this read can race the increment. Poll for it.

> +	file = fopen("/sys/kernel/debug/sched/preempt", "r");
> +	if (!file) {
> +#if defined(CONFIG_PREEMPT_LAZY) && !defined(CONFIG_PREEMPT_DYNAMIC)
> +		return 1;
> +#else
> +		return -1;
> +#endif

This reflects the build tree, not the running kernel. Also, none and voluntary
return -1 and skip the comparison, but the TIFs must match in those modes too.

> +	skel->rodata->scenario = scenario;
> +	if (kick__load(skel))
> +		goto out;

If __resched_curr() isn't in BTF, this fails too and kick_invalid FAILs along
with the other four although it doesn't use the tracer. Skipping when the
target is missing would be better.

> +	if (!start_gated_worker(&victim) ||
> +	    !wait_for_counter(&skel->bss->nr_lazy_victim_running, 1,
> +			      PHASE_TIMEOUT_MS)) {
> +		SCX_ERR("Lazy-enqueue victim was not scheduled");
> +		goto out;
> +	}
> +	usleep(100000);

Neither lazy phase checks that the tick actually stopped before the request,
so they pass with the tick running the whole time.

> Extend the NO_HZ_FULL test with infinite-slice victims. Verify that lazy
> enqueue and kick requests restart a stopped tick and make forward
> progress. Keep invalid kick flag coverage and skip modes not exposed by
> the running kernel.

kick.c is new, nothing is kept. The controller mask and timeout changes to
nohz_tick aren't mentioned either.

Thanks.

--
tejun
