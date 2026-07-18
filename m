Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91915342CB4
	for <sched-ext@lists.linux.dev>; Sat, 18 Jul 2026 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784357437; cv=pass; b=RSiHx3bAs3TWhH6U5jslqWpt/syMc/ruhKQc8j5+wJFqjVgcm2g4fFjXrfnaQ2O4Kl5PsCnq/M+Pxbqb6OJ0Ln3LFj624SO0xxUwNjPdXMcPmEjLtVBlYpjSPI/ItEMzoAx8eQBwcW9x4aGaQLxv/IEJytn7Tp/4i4pE+ECcHAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784357437; c=relaxed/simple;
	bh=GaoOA5VnCPtcDKmlQFX7wui1VvXJhnkzw6dkxaJhlCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOQyMzZX1fc3FjK7Bb+Bvu3G2QAlQil7BDb5v/QIwj+ibMckJhUmy6Bl+893a7Kf/q2ns8BkyEDP2a2HuZ6kHfZSZrtfhH5GNBje2oNsR9F7k7LwcS83XkWwA1f6JA2FBF+KPXkOtYr3NBn4R9EMsK+/SKIcPaBk8udKmDrhWoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rZTjN+5Z; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rZTjN+5Z"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-736eea06c3eso2614539137.0
        for <sched-ext@lists.linux.dev>; Fri, 17 Jul 2026 23:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784357433; cv=none;
        d=google.com; s=arc-20260327;
        b=V3s+79yFsUCECFJZyEfal4Gv4w+4S/xrXiBUSz5jTEGOpYsVFWFEyqDfuyNlgkPQaZ
         3RkJLZdxDdalYoghVru04nq3D3nCcZnOoiRmm3dHxkG7AvvVO6B5J/I597EwZxgupXDh
         +z3QqeJKklS0IwTg2kECOJPZ3S/Wf43/lES2mcGkuFjPyTCQcOx3PHB9DyGLHN/dDgHa
         DY4gtgRkWJSvyoyBJQQ+/udn8i5VJVeG09jQskM3U4LuwpUI2KCxsUl/CxNRabci/l6t
         RBd8THgofVokLlmaw20/dVyqpw9Sl1pQYhhX7AXRbRbIFdPfMEfS2neNa0LJIJ0BJ3pE
         WZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oq89B3FaRsthwqm84N6YNJf4ve7Y5JXosByNrq2e5hM=;
        fh=9uRXq06oz0eli5U7wvowQ+N5Zxl4H6oJ56/hbHTbf4Q=;
        b=GVBBkyOZZF4ClOVtLnR6s9cSAA47e4zAOEesz8lZDma3g925q/OPEPe7LO1es7Dohx
         IzhcAutLWUAbuC40RnrRU9YtKduNuAMAUzCqxiewsApZyNd+b/UhAxFPOyY3/kC/Xc5T
         IhqVj7JkajLyAKWFi1ua1WKgcnxxtvhM3GxYKVgnHBSRvja5rTMIEIlh9IDszJQFw1Ka
         FGosL8IPDvPrL31bvbp26KzUDfyPOMXj/xTjtu1knueZ2UnqomPfX9Qg1VULsmfkfFoS
         LKLKy7aPZaPBdgGA+rvJ/UT4NL8ALAjF1VfxOgSX+aguxaO9Hd3LIg087o1WnwT2mG/z
         GO3A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784357433; x=1784962233; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oq89B3FaRsthwqm84N6YNJf4ve7Y5JXosByNrq2e5hM=;
        b=rZTjN+5ZWinWVDfpcEQM+KuTxiZKYbWtdUxV7I49O1umdhebQf6rgI36HatZwHyxz9
         JhitdjM3576j4QEO+p7JWLKpoyuo6oNi6sx5MOfvesHkrMjQTCsfpFGtYKWHioOJ/D5M
         o1Z0piIb2m/33JufFcGsPJqt6A/RprQemRZszBy88AcKPe80v8t0huIyasDQxxYkXGFV
         sboum2Hcb7GLaqNsDcBAPrlcpVsx8ZXnE6J+XRmAafWjxVRwQkWEblxuBCWUEGis0tf8
         7GC8Cluot+F0YrGsES1d1SSwQl+x7jCwG+CX/+82H4gTh4eRWerGz8UWSE5y1BF2il7p
         gfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784357433; x=1784962233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oq89B3FaRsthwqm84N6YNJf4ve7Y5JXosByNrq2e5hM=;
        b=GJa1CNd/C0CVkAu7wLknb9BGUtBryfhqWRGUi2LQBRzgBPpcliAtz69CPAflhHqPYV
         cWGqSmZn6A+tjB7aUk71IaCMuLWwdQL7LQm/AIaTQgmKO//9a+TVa986sGN7X04d6nXG
         OoclIhVj19dzuP5swhNyoS3XhLfPiMtuXl2fueSYvHY6k5mWonBq+sBJlVhdIHp2YB5i
         +RGtZI1MhrJX8Tn/EeaaBsASBIIQy2T5uqJnUt+hB+96VBTNMqw+73NQUWZXW4FhYGtH
         3pz2gZqWx3OqNcyCXE8G/047DebwxLzP24Z5G3GVSIbywyR8+z4YOmRhscKvdR3MXlD6
         HmDA==
X-Forwarded-Encrypted: i=1; AHgh+Rq2/LgoKXFasBE058N5BMoyrDra9/UCjYCGRO5uW/d4UTYeCevrPYRfXFlUlg6NLU2VHnKzV8lDHF4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwEQDmqxfyOMSeZqa4xYUJy9h9PYw+JUwZlSNh2tl08ZeFeIOtM
	5O5zbi+YHZBLyvc//GNrxqj8q55FXplJ3IOMOalha+ubPpIsbfEqm4znoZxwJ1o2sd8oZn1tbks
	XEKb9zsZrXjo3owrJ3GgNbtItMeztIhpEMFEFxWg=
X-Gm-Gg: AfdE7clmC5U9S7Mq2QWSmBe4qp+luPovBSAUT4l/PAC6Hl+ztrFvWRs7dW07sutfRmW
	Mwi0evJBphDD3lFFftAE8SF/BSbZd+bghRWGaBLENmN4r+Yi1mbmZ5BQcI0YRc8lvTfVddM68tG
	fXbY0Ilrsc/CLeFS0UG/05wqv9Adz9iYeFa8ggmGnxw3gmzNxrw2E9UnDuCFgM7syVfol+gm1Us
	9qXY0V2HKD22gWSgq+OssQvY7YFta2TxyTmW3fINJyAfPM5ZCM2Zrc0amNFxrFrVqB0wIFevmmu
	xYQqTcOj918au2PlLTuimsOu4BR90RiUVxjjiig8rLQQqTUEWqFgrZ+SyshMeWRYhY/1uYXBkTA
	ZxtkPIsA3zrIspA==
X-Received: by 2002:a05:6102:5cc4:b0:6c2:e290:cc69 with SMTP id
 ada2fe7eead31-747537027c1mr1108529137.23.1784357432925; Fri, 17 Jul 2026
 23:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260716132229.61603-1-arighi@nvidia.com> <20260716132229.61603-9-arighi@nvidia.com>
 <CANDhNCq4pijyx=h5mcqFji0hDQSOPDqkS7LdeYcUKNneX_wNsw@mail.gmail.com>
In-Reply-To: <CANDhNCq4pijyx=h5mcqFji0hDQSOPDqkS7LdeYcUKNneX_wNsw@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 17 Jul 2026 23:50:20 -0700
X-Gm-Features: AUfX_mx8OG634FrFuvMGnDDGw7RB3ixWK1fqh2Cl8opTtHtm7rnqhJLx-pRFVw4
Message-ID: <CANDhNCp01g3PN4=hZgCBLUn79_H++y8hyAr4RZP+C3MYckon7g@mail.gmail.com>
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

On Fri, Jul 17, 2026 at 11:16=E2=80=AFPM John Stultz <jstultz@google.com> w=
rote:
>
> On Thu, Jul 16, 2026 at 6:23=E2=80=AFAM Andrea Righi <arighi@nvidia.com> =
wrote:
> > @@ -3098,18 +3164,16 @@ static void put_prev_task_scx(struct rq *rq, st=
ruct task_struct *p,
> >                 set_task_runnable(rq, p);
> >
> >                 /*
> > -                * Mutex-blocked donors stay queued on the runqueue und=
er proxy
> > -                * execution, but the donor never runs as itself, proxy=
-exec
> > -                * walks the blocked_on chain on the next __schedule() =
and runs
> > -                * the lock owner in its place.
> > +                * Mutex-blocked donors only stay queued when their BPF=
 scheduler
> > +                * enables %SCX_OPS_ENQ_BLOCKED. The rq lock has remain=
ed held since
> > +                * scx_allow_proxy_exec(), so @p's scheduler associatio=
n cannot have
> > +                * changed and @sch must be non-NULL with the flag set.
> >                  *
> > -                * Put the donor on the local DSQ directly so pick_next=
_task()
> > -                * can still see it. find_proxy_task() will either run =
the chain
> > -                * owner or deactivate the donor so the wakeup path can=
 return it
> > -                * and let BPF make a new dispatch decision once it is =
unblocked.
> > +                * Delegate admission to the BPF scheduler.
> >                  */
> >                 if (p->is_blocked) {
> > -                       scx_dispatch_enqueue(sch, rq, &rq->scx.local_ds=
q, p, 0);
> > +                       WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLO=
CKED));
> > +                       scx_do_enqueue_task(rq, p, 0, -1);
> >                         goto switch_class;
> >                 }
> >
>
> So this isn't a blocker for your patches, but just as a heads up: when
> applying my sleeping owner handling changes (even just patches 4-7
> from my v30 submission[1]), I managed to trip the above WARN_ON, when
> running the test-ww_mutex driver under the scx_pair (usually right as
> scx_pair loads).
>
> [ 5818.970324] WARNING: kernel/sched/ext/ext.c:3175 at
> put_prev_task_scx+0x527/0x550, CPU#54: kworker/u261:11/30527
> [ 5818.974927] CPU: 54 UID: 0 PID: 30527 Comm: kworker/u261:11
> Tainted: G        W           7.1.0-13303-gb5ecf3c9f881 #116
> PREEMPT(full)
> [ 5818.979484] Tainted: [W]=3DWARN
> [ 5818.980654] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> [ 5818.984225] Workqueue: test-ww_mutex test_cycle_work
> [ 5818.986199] Sched_ext: pair (enabled+all), task: runnable_at=3D-369ms
> [ 5818.986202] RIP: 0010:put_prev_task_scx+0x527/0x550
> [ 5818.990473] Code: 48 2b 05 34 f3 21 03 75 3c 48 83 c4 30 48 89 de
> 48 89 ef b9 ff ff ff ff 5b 31 d2 5d 41 5c 41 5d 41 5e 41 5f e9 fa f0
> ff ff 90 <0f> 0b 90 e9 b8 fe ff ff 90 0f 0b 90 e9 35 fe ff ff b8 02 00
> 00 00
> [ 5818.997428] RSP: 0018:ffffc900088dfb28 EFLAGS: 00010046
> [ 5818.999426] RAX: 0000000000000036 RBX: ffff888101258000 RCX: ffff88810=
1d64990
> [ 5819.002113] RDX: ffff8881b9bae638 RSI: ffff888101d64990 RDI: ffff88810=
1258390
> [ 5819.004787] RBP: ffff8881b9badb00 R08: ffff8881b9badb00 R09: 000000000=
0000000
> [ 5819.007967] R10: 0000000000000036 R11: ffff888120a9b030 R12: ffff88810=
0c30000
> [ 5819.010697] R13: ffff88810d163800 R14: ffff888101258000 R15: ffff88810=
0c30000
> [ 5819.013378] FS:  0000000000000000(0000) GS:ffff8882355c0000(0000)
> knlGS:0000000000000000
> [ 5819.016354] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5819.018524] CR2: 00007ffe7b985348 CR3: 0000000123ec6004 CR4: 000000000=
0370ef0
> [ 5819.021163] Call Trace:
> [ 5819.022168]  <TASK>
> [ 5819.023010]  __schedule+0x15c4/0x2460
> [ 5819.024504]  ? find_held_lock+0x2b/0x80
> [ 5819.025981]  ? lock_release+0x191/0x310
> [ 5819.027503]  schedule+0x3d/0x130
> [ 5819.028772]  schedule_preempt_disabled+0x18/0x30
> [ 5819.030539]  __ww_mutex_lock.constprop.0+0xaea/0x19e0
> [ 5819.032492]  ? schedule_timeout+0xca/0x130
> [ 5819.034095]  ? test_cycle_work+0x15d/0x340
> [ 5819.035686]  ? ww_mutex_lock+0x3c/0xb0
> [ 5819.037094]  ww_mutex_lock+0x3c/0xb0
> [ 5819.038494]  test_cycle_work+0x15d/0x340
> [ 5819.039949]  process_one_work+0x20c/0x5e0
> [ 5819.041631]  ? lock_is_held_type+0xcd/0x130
> [ 5819.043277]  worker_thread+0x1a4/0x360
> [ 5819.044717]  ? __pfx_worker_thread+0x10/0x10
> [ 5819.046392]  kthread+0x103/0x130
> [ 5819.047650]  ? __pfx_kthread+0x10/0x10
> [ 5819.049074]  ret_from_fork+0x27c/0x340
> [ 5819.050525]  ? __pfx_kthread+0x10/0x10
> [ 5819.051990]  ret_from_fork_asm+0x1a/0x30
> [ 5819.053488]  </TASK>
> [ 5819.054371] irq event stamp: 38
> [ 5819.055583] hardirqs last  enabled at (37): [<ffffffff826a7100>]
> _raw_spin_unlock_irqrestore+0x50/0x60
> [ 5819.059054] hardirqs last disabled at (38): [<ffffffff82699205>]
> __schedule+0xb95/0x2460
> [ 5819.061998] softirqs last  enabled at (26): [<ffffffff813244d0>]
> __irq_exit_rcu+0xe0/0x150
> [ 5819.065015] softirqs last disabled at (21): [<ffffffff813244d0>]
> __irq_exit_rcu+0xe0/0x150
> [ 5819.068013] ---[ end trace 0000000000000000 ]---
>
> It seems to be coming from the proxy_resched_idle() call in the "if
> (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {" case in
> find_proxy_task(), prior to proxy_enqueue_on_owner() calling
> block_task().
>
> I'll have to dig a bit more next week on this, as I'm not yet seeing
> whats going wrong here.

Ok, my tired theory is something like:

1) You have a task A that that is_blocked waiting on a sleeping owner
B. It gets enqueued onto that owner and waits.

2) We start scx_pair, and scx_prepare_task_sched_change() calls
sched_proxy_block_task(), which bails because !task_on_rq_queued()

3) B wakes up, and that causes us to activate_blocked_waiters(), which
re-adds A (with is_blocked still set) to the rq
   - this is problematic because now we have is_blocked tasks on the
sched_ext DSQ where its not allowed.

4) A is selected as a donor, and maybe B is sleeping again, so we call
put_prev_set_next() and hti the warning because we see A is is_blocked
when the sched_ext scheduler doesn't support it.

I'll work to prove this out a bit further next week.  I suspect we'll
need something somewhere between activate_blocked_waiters() ->
scx_do_enqueue_task() to skip enquing of is_blocked tasks when
SCX_OPS_ENQ_BLOCKED isn't set.

thanks
-john
