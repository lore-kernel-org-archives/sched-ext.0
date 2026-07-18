Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4D123909F
	for <sched-ext@lists.linux.dev>; Sat, 18 Jul 2026 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784355398; cv=pass; b=dWKRBCOF1HxZ7XQT0KopPf89GVXZSLDABJ+yFE3G3UNTMhM7giRq2al0NuWxvLoqlluwa3B8853jNBLRMmysTg+EJAu0zFWY1BCmux3+foG3e2penJ5zOp9XvT0zyL6/gfIsqXFIuo29dbjtJTpNUFN7saz47q6FqspjqR2wb8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784355398; c=relaxed/simple;
	bh=wR7xbofcm9BqEigjKip3hvRQFHsMyfIzcHfWjgPz0Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvzDzjOXcXCz9iFzE4CK8X9Z2z8teRut+O4fvGnVNYixhch7YwzOQ8aRUGZS/PJA+9vBqXDSRqG0d79qNEWdDurQ8kis0UUWZyp1pUUrmAPIwwHDczKEqctkkg9pf/cqFHN3cOSF9SGDzru/bYjHPHhXXAW6IqI5uM+2L1ljHV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RRxNnimJ; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RRxNnimJ"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5bfc5b77c02so6251685e0c.0
        for <sched-ext@lists.linux.dev>; Fri, 17 Jul 2026 23:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784355396; cv=none;
        d=google.com; s=arc-20260327;
        b=aCMF2Rd55B0H20iMDae2zh9IUFZUGA7xOjuA4niZjaRQ8YSxK3J65x2IfFqJdSIast
         b0E7YLYjjuQin1OBHfQmD8uc1o+bmDBBdkmJSOewnOORVgPGzeD85Q1NZKNfHXGYh2ew
         lG+GnENhyAhfMl1abUsiSyLabNZOk5ZQS7FEuRnxI6Ztb0TwzHHNS7zru/XtLkM/Ecx2
         XIY1Ycvq0MZcMpokVUZv2CUMr3x1XAukpwS4BAh780mhWchTNv3griPzMczJ2RjobP9k
         2744sjiyEwgewQpFLBP4s1QlnfJXoEAc2epkTHIZPhvgljbt9IL7onN9j+9wAiSE3r2Y
         qP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bRge5/f4gJT/nk0+EQUzC2AyKsSXb74Jpxkvon//pOI=;
        fh=D9rza0Sl3h53dP/a1w03pVfkcH4TL9Fm34JFbAKdlbE=;
        b=plYAjfICL5CcJLbcF+dTjGawLZNId3pOBWuf2Zr07LNN7D1xy8H5jsXzSrt/cL9dsS
         VbVBwjQ5CU3UAlpiqtzyQLeOTk6Bxy2HS26OV61MwLbHzTVBkiLqcO8kmCEAdmlXTNCs
         6GJgYKer2AKOtk3NhKHHR7tixT0oBUPE9IZEf2sPd4s5fhNwmS9m/U07oOhNT72irfdr
         3dLlEQY7Ix4D0IUMUmp+tRADrHkjd0CiHcE5d0ocLRlk71m3rIdDWWhuXyW1AtkMMaay
         lM1XN/EcGK/OfHUVIDq4tMHPTu/HcyQOUBSh5t/87PZssAVdaidR7LLehQpEPpv8CEH6
         ap1Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784355396; x=1784960196; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bRge5/f4gJT/nk0+EQUzC2AyKsSXb74Jpxkvon//pOI=;
        b=RRxNnimJoVAnyIo3gpV8ZNjfO6Yr1uFfo0MA1wBF3h+okhvvvafB80jLXeW+M7GSrS
         RikZsGZexhYnCJKRFcQccyFidNybxIHkML+lJvhBbIY2N3wRGGCtEdvm8IfHyV+RlLCF
         uiHWIKx8i9cCVgIfrUtCpokkUm/LR/MGDvBnH8FE1ZArAeCji+hhKC6AbL2ef5InxicI
         IF4XGbJenRkQuGTVzvFLKDiCku6rGLy/rofRvUuqKQZzlzqhmbroWqJyrD4ZgwD+5ESt
         1qyjf2Lm+TQix0lKHfsiEc/XKWYo94jhebOkfDM6awlb2Uk7Ekt91egRyEQTJBvVkalY
         Je4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784355396; x=1784960196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bRge5/f4gJT/nk0+EQUzC2AyKsSXb74Jpxkvon//pOI=;
        b=mx31Q6SS9Lf8H63SeqwJjsJJw1AQNHr7ng4bADuUdlZ/ArqZyVKxCbwPN3X1LCNskg
         OWdvFxhHWoFtKOKKoSlnNTtkywKIn7RL+PIohmOwP37pZyKBrp6QvuuBHEhWSKgNATEu
         k41qLGg92MsArwySAJryxIov700YuTNwiylwc4fU6exfG8kML4LeqzYKEUcz9H+s4PB/
         yF1uIF+WVQKGsLrcRSlzX3KjOfEBqoH88B1eJVRzDk1BFIm5+G7KVvVOfaSnQlD9NYGr
         gWPZ97Ib6Z77a16QOPOFPMkBjDgMh4HA70DCbacoUMVRYwbiG93Q50OxStZmNztCca9l
         tytg==
X-Forwarded-Encrypted: i=1; AHgh+Rr8BNNb5Vqic75VlV3pOWBTvLpugP+AxGeHkBjDON4J3FzwV/R4glmYFTy528Wc2tvGsFbDmhEug5o=@lists.linux.dev
X-Gm-Message-State: AOJu0YzF6JqUgL+yd9m9I3f57JUPRaycnKTBK0sAEbAk8t1Y27oW2VkH
	8Nti8XmJTSS9+LuwvUwf4djA8wxRs6BBKBZ9wTPHe0YmZWnKHv3Ur+aL6FuRfBXeM8+ygoDQbs1
	8ZjwrgB0PznhCpHKml5iHWGDLBQD/wGDoBoc4GlQ=
X-Gm-Gg: AfdE7clQ+FGLriHikfPJ9Lzwr3kU6129YrYTAhWT/gIPg7TEef2GyA+7/cLzlerWzyC
	otuKS7kJCQFi+c4Cq5QOydAh5YmMwyVVdScSRe5+6LNqbT3m0eHUBCP/4u0klJIASCO89ojBWZ0
	B1JGWE30LYyZEoK8CwxvkF/x8i2TZGmZtZqr5VhRBoqmn1aIcy/MaxxzMslKTbd60X4ScYNzei1
	w/1pcGuxW64MoSORa1mlNhDj8kXVzkbrkEXUjdEmsplIHqdkCxvNAES2GMZmLWNf1ywTNl73G9J
	up/elRpeF0e8ygLt9lFhSIjaWF4ELkqmkfXqlD6+eXKJ4Il5JbrtZJ+22go/X7Q2W4rB0ab9zxF
	SOLhuLXiI72EdvA==
X-Received: by 2002:a05:6102:3ca4:b0:740:2654:b49b with SMTP id
 ada2fe7eead31-7475372d5a1mr1355747137.21.1784355395459; Fri, 17 Jul 2026
 23:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260716132229.61603-1-arighi@nvidia.com> <20260716132229.61603-9-arighi@nvidia.com>
In-Reply-To: <20260716132229.61603-9-arighi@nvidia.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 17 Jul 2026 23:16:23 -0700
X-Gm-Features: AUfX_myUAMsrSM-A0qaaHGCUDID7yrgvscL4yOZW98JbugChRQUDCdFVA-8kxro
Message-ID: <CANDhNCq4pijyx=h5mcqFji0hDQSOPDqkS7LdeYcUKNneX_wNsw@mail.gmail.com>
Subject: Re: [PATCH 08/11] sched_ext: Delegate proxy donor admission to BPF schedulers
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Christian Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, 
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>, 
	Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 6:23=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
> @@ -3098,18 +3164,16 @@ static void put_prev_task_scx(struct rq *rq, stru=
ct task_struct *p,
>                 set_task_runnable(rq, p);
>
>                 /*
> -                * Mutex-blocked donors stay queued on the runqueue under=
 proxy
> -                * execution, but the donor never runs as itself, proxy-e=
xec
> -                * walks the blocked_on chain on the next __schedule() an=
d runs
> -                * the lock owner in its place.
> +                * Mutex-blocked donors only stay queued when their BPF s=
cheduler
> +                * enables %SCX_OPS_ENQ_BLOCKED. The rq lock has remained=
 held since
> +                * scx_allow_proxy_exec(), so @p's scheduler association =
cannot have
> +                * changed and @sch must be non-NULL with the flag set.
>                  *
> -                * Put the donor on the local DSQ directly so pick_next_t=
ask()
> -                * can still see it. find_proxy_task() will either run th=
e chain
> -                * owner or deactivate the donor so the wakeup path can r=
eturn it
> -                * and let BPF make a new dispatch decision once it is un=
blocked.
> +                * Delegate admission to the BPF scheduler.
>                  */
>                 if (p->is_blocked) {
> -                       scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq,=
 p, 0);
> +                       WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCK=
ED));
> +                       scx_do_enqueue_task(rq, p, 0, -1);
>                         goto switch_class;
>                 }
>

So this isn't a blocker for your patches, but just as a heads up: when
applying my sleeping owner handling changes (even just patches 4-7
from my v30 submission[1]), I managed to trip the above WARN_ON, when
running the test-ww_mutex driver under the scx_pair (usually right as
scx_pair loads).

[ 5818.970324] WARNING: kernel/sched/ext/ext.c:3175 at
put_prev_task_scx+0x527/0x550, CPU#54: kworker/u261:11/30527
[ 5818.974927] CPU: 54 UID: 0 PID: 30527 Comm: kworker/u261:11
Tainted: G        W           7.1.0-13303-gb5ecf3c9f881 #116
PREEMPT(full)
[ 5818.979484] Tainted: [W]=3DWARN
[ 5818.980654] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[ 5818.984225] Workqueue: test-ww_mutex test_cycle_work
[ 5818.986199] Sched_ext: pair (enabled+all), task: runnable_at=3D-369ms
[ 5818.986202] RIP: 0010:put_prev_task_scx+0x527/0x550
[ 5818.990473] Code: 48 2b 05 34 f3 21 03 75 3c 48 83 c4 30 48 89 de
48 89 ef b9 ff ff ff ff 5b 31 d2 5d 41 5c 41 5d 41 5e 41 5f e9 fa f0
ff ff 90 <0f> 0b 90 e9 b8 fe ff ff 90 0f 0b 90 e9 35 fe ff ff b8 02 00
00 00
[ 5818.997428] RSP: 0018:ffffc900088dfb28 EFLAGS: 00010046
[ 5818.999426] RAX: 0000000000000036 RBX: ffff888101258000 RCX: ffff888101d=
64990
[ 5819.002113] RDX: ffff8881b9bae638 RSI: ffff888101d64990 RDI: ffff8881012=
58390
[ 5819.004787] RBP: ffff8881b9badb00 R08: ffff8881b9badb00 R09: 00000000000=
00000
[ 5819.007967] R10: 0000000000000036 R11: ffff888120a9b030 R12: ffff888100c=
30000
[ 5819.010697] R13: ffff88810d163800 R14: ffff888101258000 R15: ffff888100c=
30000
[ 5819.013378] FS:  0000000000000000(0000) GS:ffff8882355c0000(0000)
knlGS:0000000000000000
[ 5819.016354] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5819.018524] CR2: 00007ffe7b985348 CR3: 0000000123ec6004 CR4: 00000000003=
70ef0
[ 5819.021163] Call Trace:
[ 5819.022168]  <TASK>
[ 5819.023010]  __schedule+0x15c4/0x2460
[ 5819.024504]  ? find_held_lock+0x2b/0x80
[ 5819.025981]  ? lock_release+0x191/0x310
[ 5819.027503]  schedule+0x3d/0x130
[ 5819.028772]  schedule_preempt_disabled+0x18/0x30
[ 5819.030539]  __ww_mutex_lock.constprop.0+0xaea/0x19e0
[ 5819.032492]  ? schedule_timeout+0xca/0x130
[ 5819.034095]  ? test_cycle_work+0x15d/0x340
[ 5819.035686]  ? ww_mutex_lock+0x3c/0xb0
[ 5819.037094]  ww_mutex_lock+0x3c/0xb0
[ 5819.038494]  test_cycle_work+0x15d/0x340
[ 5819.039949]  process_one_work+0x20c/0x5e0
[ 5819.041631]  ? lock_is_held_type+0xcd/0x130
[ 5819.043277]  worker_thread+0x1a4/0x360
[ 5819.044717]  ? __pfx_worker_thread+0x10/0x10
[ 5819.046392]  kthread+0x103/0x130
[ 5819.047650]  ? __pfx_kthread+0x10/0x10
[ 5819.049074]  ret_from_fork+0x27c/0x340
[ 5819.050525]  ? __pfx_kthread+0x10/0x10
[ 5819.051990]  ret_from_fork_asm+0x1a/0x30
[ 5819.053488]  </TASK>
[ 5819.054371] irq event stamp: 38
[ 5819.055583] hardirqs last  enabled at (37): [<ffffffff826a7100>]
_raw_spin_unlock_irqrestore+0x50/0x60
[ 5819.059054] hardirqs last disabled at (38): [<ffffffff82699205>]
__schedule+0xb95/0x2460
[ 5819.061998] softirqs last  enabled at (26): [<ffffffff813244d0>]
__irq_exit_rcu+0xe0/0x150
[ 5819.065015] softirqs last disabled at (21): [<ffffffff813244d0>]
__irq_exit_rcu+0xe0/0x150
[ 5819.068013] ---[ end trace 0000000000000000 ]---

It seems to be coming from the proxy_resched_idle() call in the "if
(!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {" case in
find_proxy_task(), prior to proxy_enqueue_on_owner() calling
block_task().

I'll have to dig a bit more next week on this, as I'm not yet seeing
whats going wrong here.

Anyway, I'm very eager to see your changes move forward!

thanks
-john

[1] https://lore.kernel.org/lkml/20260701214615.3773339-1-jstultz@google.co=
m/
