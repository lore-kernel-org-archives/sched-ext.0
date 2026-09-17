Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67CE2E738B;
	Thu, 17 Sep 2026 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673249; cv=none; b=Ey3uPlLhmTNPVzRz9Ck1AvzhaNB98zwq9esBEamiRFe2Wqmdtk5lpoXL0VNl29g+iRspF+0K/WS7CIaPoyiV7POKT+CaRFD2yWX2IMjsXWQM9cZJjtgFi0hBz+h/qGOEuDGvmZCWRezMSno04LH9wnChMWKtUXHz0t6twrrTmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673249; c=relaxed/simple;
	bh=6yglPVyYGVvRIQQhNc5vTGbU3fJQ2pO+UAaDxSt7bgU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3nbbnoLJvTWs3NUoEssfy92dokT/zQvYNb9LYjLVQ+TV+gUlcinyQymVX8OyB21BHd5nbiaqq2FitR4lncw3tewGjQsm9pe77IjZHxqMV1C5PP3fbtkwrsOzJxplaQ9GqTgp4sI6Ed2/U6WybyrBi9YS1i0LzXnqB6jFBQ1Qsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POPxtgKp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POPxtgKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D1F1F00893;
	Thu, 17 Sep 2026 19:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673247;
	bh=PAkvEeDFBzfpuZNM1z9geJTJXi4f0w8rI259tQZTKiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=POPxtgKpAsDCnelbFE3PKu9lfsKW3qG8bndSg9diU8BFIRle9SvpVEko1W8qfwbZH
	 AfyhfTNUDLK5GKKx9mC4jagp9VEcJYgQMnfkVPiyAHRBQ866A7mlgOR5ACSU1ge4Ia
	 j+Gd1JaAGsmeISDKyCnN1l3YuiemUoW12334kKmiL/X1e0vJiSvHC62XZuB4umUaHh
	 TOQKQViCkt9cO+BLMvwN4A+cPPIp9xtNmwcqQb7wvES5nU/q9Yx+4n46WTOtSZB2wg
	 p0iVVFIbRPZEx+bSvS593pKvciBEva6LPJ7btHOC2cu5yze8RA6Bq5CGZeVo70dmSd
	 F3JNti2GpDf8g==
Message-ID: <04f2f87431aae3f2d5f34349f685b397@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <etsal@meta.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add lazy preemption tests
Date: Thu, 17 Sep 2026 09:19:07 -1000
In-Reply-To: <20260917070751.3617935-3-arighi@nvidia.com>
References: <20260917070751.3617935-1-arighi@nvidia.com>
 <20260917070751.3617935-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Andrea.

This is an AI review. The series was built and the tests pass under vng here
in lazy and full modes, with nohz_full on 2-3 and on 1-3. Three things worth
fixing and some leftovers.

On Thu, Sep 17, 2026 at 09:02:53AM +0200, Andrea Righi wrote:
> +enum kick_scenario {

exit_test.h and hotplug_test.h share such enums between the BPF and user
sides. The same would work here and for nohz_phase. run_invalid() and
is_trace_scenario() depend on the two copies staying in order.

> +#ifdef HAVE_GENHDR
> +#include "autoconf.h"
> +#endif

Nothing uses CONFIG_ in kick.c anymore.

> +static struct victim spawn_victim(int cpu)

Same as spawn_gated_worker() in nohz_tick.c except for sched_setscheduler().
util.c could hold one copy.

> +	file = fopen("/sys/kernel/debug/sched/preempt", "r");
> +	if (!file)
> +		return -1;

That file only exists with PREEMPT_DYNAMIC, and needs debugfs mounted. Every
static kernel takes the INFO path and passes without comparing, including
static PREEMPT_LAZY, which is the default on arm64, riscv, powerpc, s390 and
loongarch where PREEMPT_DYNAMIC defaults off. uname can't tell either, as
PREEMPT_LAZY selects PREEMPT_BUILD. /proc/config.gz covers static kernels
when it's there. Otherwise skipping would be more honest than passing.

> +	SCX_EQ(both.resched_tif, immediate.resched_tif);
> +	SCX_EQ(lazy_wait.resched_tif, immediate.resched_tif);

Outside lazy mode the lazy TIF is the immediate one, so these and the
override checks in run_tick() hold whatever kick_one_cpu() decided. Maybe
skip or note it when the mode isn't lazy.

> +	case NOHZ_PHASE_LAZY_ENQ:
> +	case NOHZ_PHASE_LAZY_KICK:
> +		dsq_id = SCX_DSQ_LOCAL;
> +		slice = p->pid == victim_pid ? SCX_SLICE_INF : SCX_SLICE_DFL;

The victim gets an infinite slice on every enqueue, including the one after
the lazy preemption puts it back. In the kick phase the challenger is stopped
first; if its slice runs out before the SIGKILL lands, it's re-enqueued
behind the victim and never runs again, waitpid() blocks, and the 5s watchdog
aborts the scheduler, which then fails the test at check_exit. The enqueue
phase is safe as the challenger re-inserts at the head. Stopping the victim
first avoids it. ENQ_BOTH in kick.c has the same shape with the global DSQ
and the default 30s watchdog, a stall rather than a failure there.

> +static bool wait_for_tick_stop(const u64 *counter, int timeout_ms)

Neither this nor wait_for_counter() checks uei.kind, so a watchdog abort
mid-phase reports as no progress.

> +	if (!start_gated_worker(&challenger) ||
> +	    !wait_for_counter(&skel->bss->nr_lazy_enq_running, 1,
> +			      PHASE_TIMEOUT_MS)) {
> +		SCX_ERR("Lazy enqueue made no progress on CPU %d", ctx->test_cpu);

This passes even without the tick dependency restore. sched_tick_remote()
runs task_tick_scx() once a second on the tick-stopped CPU, and as
nohz_tick_ops doesn't set SCX_OPS_LAZY_SLICE_EXPIRY that path does
resched_curr() with an IPI, so the challenger runs within a second either
way. Setting the flag on nohz_tick_ops keeps the remote tick lazy, so a
missing restore shows up as the timeout. Both phases only test anything in
lazy mode.

Thanks.

-- 
tejun
