Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4C132F743
	for <sched-ext@lists.linux.dev>; Tue, 16 Dec 2025 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905840; cv=none; b=ZKEFG7ORRql7ItgPPbeE7erVvtJ9wpCzEW5B+mChb1Om2AQ3vgD7qNb1N4g8llR+jO8U48PXSYrr9MSEg6fXt6VOQWRpoToZyE7apKQdY+mLQDQ6dg8cZd4ymg+KCUDVxWuItKi3t4WFeXnNDexLae01UOVXDyHncEhcMt96ew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905840; c=relaxed/simple;
	bh=RuGy/mOZxbUiOWW2dQnzHSEe1henkHdcwZNMg89NjPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKkktvewOf4HzaLnnE3mj90c7SJaCz8DZM2L8tTVK7UI+E+lQpD6GGetvnVvJZv+yxMwM7gZA14C1mjWPdP1bHemyJbLJ6kSBFggJqGMnP/UtyVsRHNCBIX0xEczHFkQhxLuNIuMkVPe/DPO9/jVGB9bK60xz1gfww+P6wflOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27FB8FEC;
	Tue, 16 Dec 2025 09:23:48 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACD9D3F73B;
	Tue, 16 Dec 2025 09:23:52 -0800 (PST)
Date: Tue, 16 Dec 2025 17:23:47 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: sched-ext@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com
Subject: Re: Boot regression: arm64: WARNING: kernel/sched/core.c:10851 at
 sched_change_end
Message-ID: <aUGVACX9sd4IUR9k@J2N7QTR9R3>
References: <CA+G9fYuphjUO2x6qP2qPBFGSYz2WPp8fdGdiNGtyd1PmEVJrmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuphjUO2x6qP2qPBFGSYz2WPp8fdGdiNGtyd1PmEVJrmQ@mail.gmail.com>

On Tue, Dec 16, 2025 at 05:09:52PM +0530, Naresh Kamboju wrote:
> The following boot warning is noticed on qemu-arm64 devices booting
> Linux next-20251215 on wards.

I didn't realise LKFT was operating from a hospital!

> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> First seen on next-20251215
> Bad:  next-20251215 and next-20251216
> Good: next-20251212
> 
> Boot regression: arm64: WARNING: kernel/sched/core.c:10851 at sched_change_end

This email is really painful to read, because the information is
out-of-order and has random words added to obscure relevant information.

The warning you quote should be the *FIRST* line after you mention "The
following boot warning".

That should be quoted *exactly* as the kernel logged it, without being
prefixed by "Boot regression: arm64:", which the kernel didn't log, and
which is redundant given the title and surrounding context.

It'd be *significantly* clearer to have:

| I'm seeing the following warning consistently on qemu-arm64 when
| booting next-20251215 and later:
|
|   WARNING: kernel/sched/core.c:10851 at sched_change_end
|
| Note: full splat at the end of this mail.
|
| First seen on next-20251215
| Bad:  next-20251215 and next-20251216
| Good: next-20251212
|
| This looks to be a regression.

... where someone can see all the relevant details at a glance.

> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> $ git blame  -L 10842  kernel/sched/core.c
> 5d1f0b2f278eb (Peter Zijlstra 2025-12-10 09:06:50 +0100 10842)  ---->
>       if (ctx->running && sched_class_above(p->sched_class,
> ctx->class)) {
> 5d1f0b2f278eb (Peter Zijlstra 2025-12-10 09:06:50 +0100 10843)
>          rq->next_class->wakeup_preempt(rq, p, 0);
> 5d1f0b2f278eb (Peter Zijlstra 2025-12-10 09:06:50 +0100 10844)
>          rq->next_class = p->sched_class;
> 5d1f0b2f278eb (Peter Zijlstra 2025-12-10 09:06:50 +0100 10845)          }
> 5d1f0b2f278eb (Peter Zijlstra 2025-12-10 09:06:50 +0100 10846)
> 47efe2ddccb1f (Peter Zijlstra 2025-10-30 12:56:34 +0100 10847)          /*
> 47efe2ddccb1f (Peter Zijlstra 2025-10-30 12:56:34 +0100 10848)
>   * If this was a degradation in class someone should have set
> 47efe2ddccb1f (Peter Zijlstra 2025-10-30 12:56:34 +0100 10849)
>   * need_resched by now.
> 47efe2ddccb1f (Peter Zijlstra 2025-10-30 12:56:34 +0100 10850)           */
> 47efe2ddccb1f (Peter Zijlstra 2025-10-30 12:56:34 +0100 10851)  ---->
>       WARN_ON_ONCE(sched_class_above(ctx->class, p->sched_class) &&
> 47efe2ddccb1f (Peter Zijlstra 2025-10-30 12:56:34 +0100 10852)
>               !test_tsk_need_resched(p));
> 6455ad5346c9c (Peter Zijlstra 2024-11-01 14:16:10 +0100 10853)  } else {
> 6455ad5346c9c (Peter Zijlstra 2024-11-01 14:16:10 +0100 10854)
>  p->sched_class->prio_changed(rq, p, ctx->prio);
> 6455ad5346c9c (Peter Zijlstra 2024-11-01 14:16:10 +0100 10855)  }
> f0e1a0643a59b (Tejun Heo      2024-06-18 10:09:17 -1000 10856) }

This is all formatted illegibly since it was line-wrapped, and you
didn't mention why you're dumping this. AFAICT the only relevant bit is
that the warning is from:

	WARN_ON_ONCE(sched_class_above(ctx->class, p->sched_class) &&
		     !test_tsk_need_resched(p));

... which Peter added in commit:

  47efe2ddccb1f ("sched/core: Add assertions to QUEUE_CLASS")

Have you tried looking around that commit, or bisecting?

[...]

Note: I've fixed the line-wrapping for the below. Please fix that in
future.

> [   14.696414] ------------[ cut here ]------------
> [   14.696418] WARNING: kernel/sched/core.c:10851 at sched_change_end+0x168/0x188, CPU#12: ktimers/12/117
> [   14.729321] Modules linked in: cppc_cpufreq(+) arm_dsu_pmu(+) fuse drm backlight
> [   14.736718] CPU: 12 UID: 0 PID: 117 Comm: ktimers/12 Not tainted 6.19.0-rc1-next-20251216 #1 PREEMPT_RT
> [   14.746190] Hardware name: WIWYNN Mt.Jade Server System B81.030Z1.0010/Mt.Jade Motherboard, BIOS 2.10.20250506-1P (SCP: 2.10.20250506) 2025/05/06

This doesn't look like a "qemu-arm64 device" to me. Are you *sure* this
wasn't bare-metal on a "WIWYNN Mt.Jade Server System"?

If not, why is QEMU passing that gunk to the guest!?

Mark.

> [   14.759217] pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   14.766169] pc : sched_change_end (kernel/sched/core.c:10851 (discriminator 7))
> [   14.770519] lr : sched_change_end (kernel/sched/core.c:10842 (discriminator 1))
> [   14.774781] sp : ffff800080d33b90
> [   14.778084] x29: ffff800080d33b90 x28: ffff07ff822f5500 x27: ffff80008e0c3660
> [   14.785213] x26: 00000000000000f0 x25: ffff07ff822f5500 x24: 0000000000000000
> [   14.792342] x23: 00000000ffffffff x22: ffffb4099c0d64d0 x21: ffff07ff822f5500
> [   14.799469] x20: ffff083e5eeaf140 x19: ffff083e5ee9b290 x18: 0000000000000000
> [   14.806597] x17: 0000000000000000 x16: ffffb4099a40ee68 x15: 0000000000000000
> [   14.813725] x14: 0000000000000000 x13: 0000000000000000 x12: 0000020000000000
> [   14.820853] x11: 00000000000000c0 x10: 0000000000000c60 x9 : ffffb40999b8d640
> [   14.827981] x8 : 000000000000000c x7 : ffff07ff92ad8400 x6 : 00000000ffffffff
> [   14.835109] x5 : 00000000000000ee x4 : 000000036b338800 x3 : 000000036b33b800
> [   14.842238] x2 : 0000000000000001 x1 : ffffb4099c0d63d8 x0 : 0000000000000010
> [   14.849366] Call trace:
> [   14.851802]  sched_change_end (kernel/sched/core.c:10851 (discriminator 7)) (P)
> [   14.856153]  rt_mutex_setprio (kernel/sched/sched.h:1813 kernel/sched/core.c:7368)
> [   14.860157]  rt_mutex_slowunlock (kernel/locking/rtmutex.c:1341 kernel/locking/rtmutex.c:1466)
> [   14.864422]  rt_spin_unlock (kernel/locking/spinlock_rt.c:86)
> [   14.868165]  __hrtimer_run_queues (include/linux/spinlock_rt.h:44 kernel/time/hrtimer.c:1398 kernel/time/hrtimer.c:1843)
> [   14.872513]  hrtimer_run_softirq (kernel/time/hrtimer.c:579 kernel/time/hrtimer.c:1193 kernel/time/hrtimer.c:1861)
> [   14.876600]  handle_softirqs.isra.0 (arch/arm64/include/asm/jump_label.h:36 include/trace/events/irq.h:142 kernel/softirq.c:627)
> [   14.881125]  run_ktimerd (kernel/softirq.c:325 kernel/softirq.c:1144)
> [   14.884520]  smpboot_thread_fn (kernel/smpboot.c:160)
> [   14.888608]  kthread (kernel/kthread.c:463)
> [   14.891828]  ret_from_fork (arch/arm64/kernel/entry.S:861)
> [   14.895396] ---[ end trace 0000000000000000 ]---
> 
> ## Source
> * Kernel version: 6.19.0-rc1
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git commit: 4a5663c04bb679631985a15efab774da58c37815
> * Git Describe: next-20251215
> * Test Details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20251215
> 
> ## Boot details
> * Boot log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20251215/testrun/30561916/suite/log-parser-test/test/exception-warning-kernelschedcore-at-sched_change_end/log
> * Test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20251215/testrun/30561916/suite/log-parser-test/test/exception-warning-kernelschedcore-at-sched_change_end/details/
> * Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/36sbHUVfnUKPzZ4LNkOCLdiFOin
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/36sbH5DQckAagO0V1UEWBBkOB54/
> * Kernel config: https://storage.tuxsuite.com/public/linaro/lkft/builds/36sbH5DQckAagO0V1UEWBBkOB54/config
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 
