Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A7D3FCC
	for <sched-ext@lists.linux.dev>; Sat, 11 Jul 2026 01:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783734239; cv=pass; b=QX4W2HrGwUgzO1eNki0YS4yleTAbbcML/m1JY7hPjL9zfrl25xjhXfMyG7O/vHVOCrxrt0CVTeeo2YsHclhV4+eg3pk9M2H9vjiFv2Hum/arPHoVb5wcUcUy6xjmBenZvEeJ5+FIMxdfXEm8YmB9XpbcdK/hTGZyofu+IOf8cu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783734239; c=relaxed/simple;
	bh=cJCeCKtBL8dqVkAaClVK5Cop6OVcLqwiMcwWdXPmMQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jca/AxcomC6Jb/o/ulWfAjUgXP76OOG9CA9mkciQmGEzKmK6gVwGXHp8JhIwIKYZH0uttOR8waM06tl4JX9KUkpbhjpZ7wdvu6AO8WwrmL2zAhog8yWqnOcuMITHs+/kF7Xe0yb/E/qNja0AGtGP2SYSFHjInzxXmf2ZurZ6KPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SACCQCei; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SACCQCei"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cace91f112so12516885ad.0
        for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 18:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783734237; cv=none;
        d=google.com; s=arc-20260327;
        b=igVRj0mdpYPDaQhDdw/WA9wGje6etUKMLYK2+xRFtCWHWLVu58ozhIb3vmA0wzFp44
         tXswwcwOLAw4aEn7AtqvEkxI3NuLvRWdRGORJl94G8yQkt6+doO9hce6EA/FebJzfcYh
         q7OOL3vu74vhNv4EylgQRAi4t6lHnksfzQg/81ltukIoOmMgYuBYqvZQ5bGgmDnoDSZR
         F1Zs1Hl/yNhvBV1CE2GbDXawtzuNPhj6GRnpvHJ66IKztFzpCWariysAoxT2E9vMa+vL
         HtAwwjKzGYwwMEjvwSqvKTN09Qs70cVeFWQ5DRjbrzTuOjp62g1PyEzygOkiDtEZKRSv
         /bMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dCW0TEu9lqcop4KXkydeJt+1JtZ86ubjbOEpYQqxR94=;
        fh=NX1AY+3kmkApiCgige7UJk2LTaX3LRIA/cfGHSko84g=;
        b=UMQPWDVz6xrG40Uq3Tfj/9AqfkSlDxXmsZTFzyaBWyrRKOcoJYJzRWWNGWDqt02CKM
         0lJa560RaoGWBdBCadaJeiIihFxOQtFj8ENpLswDi2E7UAbhF+qtIRww4neruJLtJ4MQ
         Z5Wj8n2ax+vOWnruhFG6RGGvtoGk8BXHf/6pC6+7mkmyfRJhsmfluGsn/8aGW/P51TY3
         mRoLNpxwcJ1bYIqYxu9MUjANZMNklgV6EAJF+hJKokTgeIwo7AzxcCYrIJ8aLxFhDsOx
         lKyiOij238Gf1WKh3PZ4NW2A4xwaqjIafYmTDjnyeNkouHvehEqWCb3aUDD8nhmhjdz3
         D9bw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783734237; x=1784339037; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dCW0TEu9lqcop4KXkydeJt+1JtZ86ubjbOEpYQqxR94=;
        b=SACCQCeiDtkL7qEpAFqwg2VrCz2mV3AXRGM3c3MjDpqh/vANx/bOwluXq3soHzNnLy
         4PvKgKQyss/JX85N9V9jTEu1hIgUElcU9TKQtlsHBKpxNtRAp4tLPhuoVRXyah/4mNr1
         LNFfpYgwYJp46eTsGu5rrXJ04fYQqOfuU4FsIHPAa6W8d9lD1N6Ihuimk7ht1eQCf3Vi
         mNKoQEPkiJusr+Gko3NVJB5zaN8X5FBX2pRgAu5vONjUKp6i59iYdwbb7dw++Hzk+xf8
         T//6WciuxlaqlsBowP4/rgxf+AEG+203ZSwaeOrrUCd8oGZ1ztb06BwR2DWDY/p5E+dZ
         4c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783734237; x=1784339037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dCW0TEu9lqcop4KXkydeJt+1JtZ86ubjbOEpYQqxR94=;
        b=Q38K0Nz/7Bl0XVq+j2mcZ6pG/beILvvVR0K2EPSA2u6xVMtFu9Xp++GdlpV8zgGEqV
         YVMvRMd9HQYGMyVvvlBF9x0hAcGR1MFP5bs9DalPnCcoZI+/O6ecZkmFAChTXHka8v85
         WVJKJsxUUHxdFM92CTETnAMrCqtUgyLLSWjlTQPG/ZgiD8Z/1/mKeEOWsLN4Swbrm1c/
         EG9+MzY9CU091/gAlyp9F5e2UT9NzGQXyKJRddJV8MUidPVtaCE2Kw9FCBVny3Bb13bm
         wxVLkyyx/zd9wVq21b8VZPQowRRx4xgnoGmSKwU5yRin1BslO6T8s7SVnU1djpjHFYeN
         KYBg==
X-Forwarded-Encrypted: i=1; AHgh+RrWyNc+X8RPylBLOEty/IxqEM5nt9UO5ubxkO7cQEsJL5UyH23GCDs/+d8JeIaPWPmvNfnMAnMHdSs=@lists.linux.dev
X-Gm-Message-State: AOJu0YxajwTXmmqaihsKl2X19gXMvlj7PeQC3oTVq1eYwmn7Gu+1ZOg9
	BYtNsUAvAGPCiXfWgBd3lziTQFEM9tEfdiQc6EIGZXjya35HKPnt3HP6WvPjf1j8P3gSFfzYMOy
	od95Eo+LZioSubb65ViSUQG/15rn0s9St8VdZa3Y=
X-Gm-Gg: AfdE7cmphbfIiY2jIoEehHqWqPRYU5c7ZKz3l71ssSxh/9tft1COChd+C6TGPV/zJ3F
	KI/LqgFjvEfFviJtNCsEz48GGusrX5CB47LaGCiHK9zWaFQ1q7egVkfQPH61WvszJJCzMGloGfS
	4QqbP9PS6fG3beUJIoDumBAeJOtU6bRwGwlLJCvRnKA32JPVI4+BfLjUxFShF0K90IDTSN8crWD
	ITXxgZ7RAKOUdxHKo7T4KYAh+YbLJAvlw0xXuys06yufXB7GUQh5Aya/j8wU/5WavYnM0ODrJuI
	LMiRSNSoytSiUWN5Dfgcb2Y1Sk5NP6ZZ6EfF5yfcVf77VSW+u03lElmpS6Ukv/2R8DdyYmAAkCN
	TWHWS9au1DU9SWhbCIPXox3Ik
X-Received: by 2002:a05:6a20:c98b:b0:3bf:6e72:68f9 with SMTP id
 adf61e73a8af0-3c110ad2e1fmr1328780637.38.1783734237142; Fri, 10 Jul 2026
 18:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260710083913.30573-1-arighi@nvidia.com> <20260710083913.30573-7-arighi@nvidia.com>
In-Reply-To: <20260710083913.30573-7-arighi@nvidia.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 10 Jul 2026 18:43:44 -0700
X-Gm-Features: AVVi8CcYRNDju1Xx-K37Q9hhZOI55OZ9hzL2AvLS79qUe6ag_ACaIQVS36XsVyQ
Message-ID: <CANDhNCr2eTjjvFv-iNwD-XpStibW_NwyR7Zg+5Zh20mEuPsQ1w@mail.gmail.com>
Subject: Re: [PATCH 06/10] sched_ext: Delegate proxy donor admission to BPF schedulers
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

On Fri, Jul 10, 2026 at 1:40=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
> @@ -2866,18 +2938,12 @@ static void put_prev_task_scx(struct rq *rq, stru=
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
> -                *
> -                * Put the donor on the local DSQ directly so pick_next_t=
ask()
> -                * can still see it. find_proxy_task() will either run th=
e chain
> -                * owner or deactivate the donor so the wakeup path can r=
eturn it
> -                * and let BPF make a new dispatch decision once it is un=
blocked.
> +                * Mutex-blocked donors only stay queued when their BPF s=
cheduler
> +                * enables %SCX_OPS_ENQ_BLOCKED, so always delegate their=
 admission.
>                  */
>                 if (task_is_blocked(p)) {
> -                       scx_dispatch_enqueue(sch, rq, &rq->scx.local_dsq,=
 p, 0);
> +                       WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_BLOCK=
ED));
> +                       scx_do_enqueue_task(rq, p, 0, -1);
>                         goto switch_class;
>                 }
>

Just FYI: So in doing some testing running my priority-inversion-demo
test in a loop with this series (rebased on 7.2-rc2), goining through
the example schedulers in tools/sched_ext/ I hit this WARN_ON after
running awhile with the scx_pair scheduler.

Haven't done much debugging on it yet, may have to wait until monday,
but the splat is below.

thanks
-john

[25733.271828] WARNING: kernel/sched/ext/ext.c:2945 at
put_prev_task_scx+0x449/0x460, CPU#0: foreground/25080
[25733.277072] CPU: 0 UID: 0 PID: 25080 Comm: foreground Not tainted
7.2.0-rc2-00043-g9699f4add4b0 #39 PREEMPT(full)
[25733.286458] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[25733.295933] Sched_ext: pair (enabled+all), task: runnable_at=3D-798ms
[25733.295937] RIP: 0010:put_prev_task_scx+0x449/0x460
[25733.306251] Code: 48 8b 83 68 11 00 00 48 8b b5 10 04 00 00 48 39
b0 98 11 00 00 0f 85 79 ff ff ff e9 65 ff ff ff 90 0f 0b 90 e9 46 fe
ff ff 90 <0f> 0b 90 e9 b5 fd ff ff b8 02 00 00 00 e9 94 fc ff ff e8 90
bb 2d
[25733.322497] RSP: 0018:ffffc90011f7faa8 EFLAGS: 00010046
[25733.325750] RAX: 0000000000000001 RBX: ffff8881b8e2db80 RCX: ffff8880bd4=
82650
[25733.333460] RDX: ffff8881b8e2e618 RSI: ffff8880bd482650 RDI: ffff8881073=
b2650
[25733.338640] RBP: ffff8881073b22c0 R08: 0000000000000000 R09: 00000000000=
00000
[25733.344710] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88800ba=
23000
[25733.351179] R13: ffff8880bd4822c0 R14: ffffffff82f6a518 R15: ffffffff82f=
6a040
[25733.356585] FS:  00007f9badd90780(0000) GS:ffff888234841000(0000)
knlGS:0000000000000000
[25733.362523] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[25733.365426] CR2: 00007f91f1e48110 CR3: 000000001113c006 CR4: 00000000003=
70ef0
[25733.372285] Call Trace:
[25733.373817]  <TASK>
[25733.375178]  __pick_next_task+0xa8/0x180
[25733.378968]  __schedule+0x268/0x2600
[25733.381092]  ? mark_held_locks+0x40/0x70
[25733.383556]  preempt_schedule_notrace+0x43/0xa0
[25733.386311]  ? preempt_schedule_notrace_thunk+0x16/0x30
[25733.390954]  preempt_schedule_notrace_thunk+0x16/0x30
[25733.395476]  rcu_is_watching+0x3e/0x50
[25733.397722]  lock_acquire+0x2c0/0x310
[25733.401168]  ? _raw_spin_unlock_irqrestore+0x50/0x60
[25733.404224]  schedule+0x9d/0x100
[25733.406428]  ? schedule+0x7e/0x100
[25733.408130]  schedule_preempt_disabled+0x18/0x30
[25733.411008]  __mutex_lock+0x800/0x1100
[25733.415788]  ? __start_renaming+0x5d/0x190
[25733.419011]  ? lock_acquire+0xd9/0x310
[25733.421518]  ? __start_renaming+0x5d/0x190
[25733.424188]  __start_renaming+0x5d/0x190
[25733.426676]  filename_renameat2+0x318/0x420
[25733.429258]  ? find_held_lock+0x2b/0x80
[25733.432581]  __x64_sys_rename+0x48/0x70
[25733.435240]  do_syscall_64+0xf3/0x6c0
[25733.437675]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
