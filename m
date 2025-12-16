Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45223263C8F;
	Tue, 16 Dec 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894656; cv=none; b=kzst4Rjk5ey4rEFl0TqnMdleksx1DpO7hzKhnq1H6kwKTPLGjV1zT4itFnDMWmufFhfPuiZaIlQq7QeHX2/kPh0fBIH+pfkc1HI4iF5mw/6tSFlpIBPdaNDPATqW+sig+/kD4EZfQRAEhojbQUCbkVr98aF/mSOaaFJ3AktaxdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894656; c=relaxed/simple;
	bh=ZDz7H5wcVzoWgJukrna3BlwmjfRCThJJoUV4QEnFG0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iV2ZkySkJKgX7+T8jsEb73G91mAdyaev+N6s4shNPCMCH/OqdHz8UE6BbxTu4mdlNDZNFgw7CS+wzE1wP7qQ6nOobFlbxcDMmIQU26Hhb1oIW/9QFtV5zOXahileoZ7G/CxWvyGbTZNrN+MwJQfs8g+lSIkpJ5c8W6dxjBlKsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R92JdyY0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R92JdyY0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CensiGvQn2xGJA82FRSYSjWfbmAEoSdFVnq33xq5JSM=; b=R92JdyY0dDVyW7MzPMyummYw9B
	J81RZhMPEE4U91CjHgJq02YVDZ8jMSKbA1qxfAIh4/jDMSvchBbgxcb5Cg+hv+4M28/4NC8+PoIXr
	o0iY9xMMS2vewhgDfLBWfR2ibZm5QdlFMAJ01mjzfCKI5lhKlnD/g7Udiay4CkTppqT8yyyzW9INy
	eNrW7Kl8vDuaOPX2jmk9hM+r70siLfBcSDzmqot/cLq5psGomueUqIntECrdIM9BuaSl+l6o8sUQt
	HuZfBNstPw0BAV98vkOztQYJUzB+vz8mfmSIT2pVaY93d5J/Mo97S+OhJyuuv9uJPWZTkxO8+fv1K
	yVbEVA2w==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVVri-00000003NjP-3Dih;
	Tue, 16 Dec 2025 14:17:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C425D30029E; Tue, 16 Dec 2025 15:17:25 +0100 (CET)
Date: Tue, 16 Dec 2025 15:17:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: sched-ext@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org, Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: Boot regression: next-20251215: arm64: WARNING:
 kernel/sched/core.c:10851 at sched_change_end
Message-ID: <20251216141725.GW3707837@noisy.programming.kicks-ass.net>
References: <CA+G9fYuUYboYg9Kq24NL+LY3XqCELWkwbGZ8bh9EjQdoj2k7yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuUYboYg9Kq24NL+LY3XqCELWkwbGZ8bh9EjQdoj2k7yg@mail.gmail.com>

On Tue, Dec 16, 2025 at 06:11:11PM +0530, Naresh Kamboju wrote:
> [Re-sending with unwrapping]
> 
> The following boot warning is noticed on qemu-arm64 booting the
> Linux next-20251215 and next-20251216.
> 
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Yes
> 
> First seen on next-20251215
> Bad:  next-20251215 and next-20251216
> Good: next-20251212
> 
> Boot regression: arm64: WARNING: kernel/sched/core.c:10851 at sched_change_end
> 
> Are these expected warnings ? Anyone noticed ?
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Still a wrapped mess :/

Anyway, afaik you're the first to notice.

> Full boot log links provided at the bottom of the email.
> 
> ## Boot log
> [    0.000000] Linux version 6.19.0-rc1-next-20251215
> (tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 13.3.0-16) 13.3.0,
> GNU ld (GNU Binutils for Debian) 2.44) #1 SMP PREEMPT @1765798467
> ...
> [   14.659447] mlx5_core 0000:01:00.1 enp1s0f1np1: renamed from eth1
> [   14.691267] CPPC Cpufreq:FIE not enabled on systems with registers in PCC
> ** replaying previous printk message **
> [   14.691267] CPPC Cpufreq:FIE not enabled on systems with registers in PCC
> [   14.694920] mlx5_core 0000:01:00.0 enp1s0f0np0: renamed from eth0 (while UP)
> [   14.696414] ------------[ cut here ]------------
> [   14.696418] WARNING: kernel/sched/core.c:10851 at
> sched_change_end+0x168/0x188, CPU#12: ktimers/12/117
> [   14.729321] Modules linked in: cppc_cpufreq(+) arm_dsu_pmu(+) fuse
> drm backlight
> [   14.736718] CPU: 12 UID: 0 PID: 117 Comm: ktimers/12 Not tainted
> 6.19.0-rc1-next-20251216 #1 PREEMPT_RT
> [   14.746190] Hardware name: WIWYNN Mt.Jade Server System
> B81.030Z1.0010/Mt.Jade Motherboard, BIOS 2.10.20250506-1P (SCP:
> 2.10.20250506) 2025/05/06
> [   14.759217] pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   14.766169] pc : sched_change_end (kernel/sched/core.c:10851
> (discriminator 7))
> [   14.770519] lr : sched_change_end (kernel/sched/core.c:10842
> (discriminator 1))
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
> [   14.851802]  sched_change_end (kernel/sched/core.c:10851
> (discriminator 7)) (P)
> [   14.856153]  rt_mutex_setprio (kernel/sched/sched.h:1813
> kernel/sched/core.c:7368)
> [   14.860157]  rt_mutex_slowunlock (kernel/locking/rtmutex.c:1341
> kernel/locking/rtmutex.c:1466)
> [   14.864422]  rt_spin_unlock (kernel/locking/spinlock_rt.c:86)
> [   14.868165]  __hrtimer_run_queues (include/linux/spinlock_rt.h:44
> kernel/time/hrtimer.c:1398 kernel/time/hrtimer.c:1843)
> [   14.872513]  hrtimer_run_softirq (kernel/time/hrtimer.c:579
> kernel/time/hrtimer.c:1193 kernel/time/hrtimer.c:1861)
> [   14.876600]  handle_softirqs.isra.0
> (arch/arm64/include/asm/jump_label.h:36 include/trace/events/irq.h:142
> kernel/softirq.c:627)
> [   14.881125]  run_ktimerd (kernel/softirq.c:325 kernel/softirq.c:1144)
> [   14.884520]  smpboot_thread_fn (kernel/smpboot.c:160)
> [   14.888608]  kthread (kernel/kthread.c:463)
> [   14.891828]  ret_from_fork (arch/arm64/kernel/entry.S:861)
> [   14.895396] ---[ end trace 0000000000000000 ]---

This is:

	WARN_ON_ONCE(sched_class_above(ctx->class, p->sched_class) && 
			!test_tsk_need_resched(p));

And rt_mutex_setprio() doesn't set need_resched() on demotion; but
worse, reading it now, I realize that if p != current, nobody ever will.

I suppose something like so will cure things?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7d0a862a8c75..5b17d8e3cb55 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10833,23 +10833,24 @@ void sched_change_end(struct sched_change_ctx *ctx)
 		if (p->sched_class->switched_to)
 			p->sched_class->switched_to(rq, p);
 
-		/*
-		 * If this was a class promotion; let the old class know it
-		 * got preempted. Note that none of the switch*_from() methods
-		 * know the new class and none of the switch*_to() methods
-		 * know the old class.
-		 */
-		if (ctx->running && sched_class_above(p->sched_class, ctx->class)) {
-			rq->next_class->wakeup_preempt(rq, p, 0);
-			rq->next_class = p->sched_class;
+		if (ctx->running) {
+			/*
+			 * If this was a class promotion; let the old class
+			 * know it got preempted. Note that none of the
+			 * switch*_from() methods know the new class and none
+			 * of the switch*_to() methods know the old class.
+			 */
+			if (sched_class_above(p->sched_class, ctx->class)) {
+				rq->next_class->wakeup_preempt(rq, p, 0);
+				rq->next_class = p->sched_class;
+			}
+			/*
+			 * If this was a degradation in class; make sure to
+			 * reschedule.
+			 */
+			if (sched_class_above(ctx->class, p->sched_class))
+				resched_curr(rq);
 		}
-
-		/*
-		 * If this was a degradation in class someone should have set
-		 * need_resched by now.
-		 */
-		WARN_ON_ONCE(sched_class_above(ctx->class, p->sched_class) &&
-			     !test_tsk_need_resched(p));
 	} else {
 		p->sched_class->prio_changed(rq, p, ctx->prio);
 	}


