Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87143F6604
	for <sched-ext@lists.linux.dev>; Tue, 17 Mar 2026 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773626; cv=pass; b=qNysnx2vtJcBBJ111KoiJ0JgSC+AF3RjvA0HfhQyzosnefJdvmVLt6cbINAJi5i0Sx905myoYn9+8h2LRGV3/WF92RUB8neQd4DHUjhFySn+EeNPkqxA9cOEup/t+mDvZi5Nds6Ur47Y0eHc3rtk7hlp0dcq2gfxwgHn9W8w6ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773626; c=relaxed/simple;
	bh=JENApLGJIbJ7XXTfCif6eBY2e7Pz4EAojrBewQN6dbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRwy/OROq+lB23t/P7KnMg3GLtLkGsT7ruyTaX2duCnl+Qotr4372LK2PsKHRTECWvY0Q6JYQvAz1/rPlT06bRz/yZ1LrFtdvA7lwzzfOT5mtw46SleXEIlKgfl+nFvd4G0er6E0e13SfeVYQlB3Lsr34TESOqdlWz32vY8ftkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDGNxq+3; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDGNxq+3"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-439c6fc2910so4625298f8f.0
        for <sched-ext@lists.linux.dev>; Tue, 17 Mar 2026 11:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773773622; cv=none;
        d=google.com; s=arc-20240605;
        b=PziTBb33QhpMbQajDv37u5FgzUyX1Nx8wiHLgooYPGLzkRygGzt2oAfHRFtvJ+Mu6t
         Ckb/i+Z6WpwaznNDE/ZxeM4Gcd9t5GCEuve1/F74c1nNhKGAH0SwJxkkxLTk0fbSwvvH
         h430Q0bIJjAepO6O2XK9xJbKMw8zviTJ6L4PvMnWT2qw+9VrpXufkcwtVdHLXzYEm89m
         IVcKNxp+M+dFozuC7UPzQOVs989c7VNwBS9dc4pVoY7WAlZ2ptpSW2SJ4lqhJQD7Zue/
         t8U1Vy4sFnRycrCYn0EaPXgDhG3xsyk1lvSRmgQdE38Kvh/4EVR72Nn26xdIjY86TlIh
         Nuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4Go+5Gw4/e0jsV9MDug+gfz01GjxVixoD+Atq+8XTyM=;
        fh=C/36uI/2IR2h4OQLWThstKHZb/+a9LnGB1BqLp+n8RE=;
        b=kEbrsEQFwBWsZU5DYZSHFVQFZm6QFRyiv0rN7BAUaY2KamMc0lAHe1rPeJFa6eLL3M
         WHZztpR2Jh29/VnJAdvuCcYnhT78MXon41VmGNu5H4tah6d1f3c14d0k9c8U0lTJQ1ut
         HT6eoX3OAdn/gENDHWQW66eZFbelLkgjdKeLw3haM1Y5+UPAGYiXSTUzIvCIBT4h+bbj
         Ur2UfN9i70gtcUGmKX/6HcBCZsOlOPSCIcRPGJhakVKV2GYPdkLKGU9b0V4mhmwMd/Lz
         t/TJrKzCkPRkbBbhFtvX4ilz5+P4YjJku14w3GidyaMCs830MZSb4UZGwG3DEmMbTzSA
         O48A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773773622; x=1774378422; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Go+5Gw4/e0jsV9MDug+gfz01GjxVixoD+Atq+8XTyM=;
        b=SDGNxq+3mBGmNJGRoc++yEwHdZZXgYzYpINjvyQ0ptojSGh4cEL49c44ChvaO3ifAG
         3JjqGouvRvSLSVhlwWZUtey3fYL6AlSzCXxkjfrjIbJM6KWRdx8AeDFIB7qRjSANQZFg
         zy1M3AM+tOGI7Nb2kOVwRA5nFTxjf2FzSBGWGneUKp+10RM2vIqWTGTZW3qv/fw+A0TE
         0LYSo8HrnLhKZjOIH1xfiq2cpwMtV4e/wLqjB2X3HNbZGIlX/Ki8fAf9xJC8yR4tZsS9
         7aDd0BV0Wzw6UmsTyVhmpRW/OVrjxRXPuSp1a5tTaZ/754cy41nTibhHG0zT8xB0rIc+
         vyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773773622; x=1774378422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Go+5Gw4/e0jsV9MDug+gfz01GjxVixoD+Atq+8XTyM=;
        b=UEhd2pBlKBpB7CvBimsv4s1NQsDAEsQN9ETM3oJcwRBzFI8HHetwoJN88YVboGk9Qi
         HViFPCA80H5NSf/JHJLuMaJwujJ/+X6b6dQKE/NGYRm3froKQccHXO9xsgiZE4sWKJnT
         TtI2CY1mjXRGEVkAwKPscz0W9UTeH9nE/8UbLbfqrN5cqpZ7SsXMj3LHCIh62CJMa5ZN
         80RIYFlcCEy16m2u//6uUa7L9x1ZyKWtST1A+h7IkrCmcUpzXt7GT4mjqnVpvmt3rF7b
         CCh1p152rXrT4D2Nv4lxmoqffbBCXnNNW38BraVUyuddfpxMyzUKvUe5F3/JPuvBcnHX
         qKeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/JMu4JTbZJdPPn+DMn8SMpxZPv22BE6zJtN3r+CG9nKGcRD5aaHm5GNVbVgoEZawyQJOBspDHecI=@lists.linux.dev
X-Gm-Message-State: AOJu0YyFCEIu7w4szDQ2OtPMNjLIGyUnjbE+8RpfGH1KQTie6KCDrG80
	KKj7IkUqY6ZORkApJE9kEpdVVJt4vLl4ud5MMf8OLv9zX2mY4G4OPxwgkAo/np0hj3to1HN860Y
	L377xge8J1Ipbw8q7rM9p3KhhAAGReYM=
X-Gm-Gg: ATEYQzz4iiBQGXj8P8e+6ymiA1uZh8j9aazW27jAHP4gX3wgGtE/Ldt3glFQlBAfYVA
	klKQUJrpUX5fUiiitetnM/nFZyoozaT6Aszb8VQl5JQJkGfwtX8h6dFAK2JPh4VFeVLGg+35hNJ
	0wHSWwrP8tqgMvjPORPPjTY/Z6Gtbc7zLp5TMxIReHmRX/Xt947e/Prw66gxBKdhhgxuV3QXfqQ
	/c1x6TitAZsNn29SvTrOvujF4QNd9r5W32tq2QrvF2cjs3QVubdea45yCUBRPrldlz94jLjxVwM
	ccNdEBXIWBQU6XIALh/yUbSM5MeBj594dHcgn/LCp5tHbM2RWK2Xdac1iN0=
X-Received: by 2002:a5d:5f54:0:b0:43b:4881:cee with SMTP id
 ffacd0b85a97d-43b527a3c82mr639156f8f.1.1773773621877; Tue, 17 Mar 2026
 11:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260316222758.1558463-1-arighi@nvidia.com> <CAP01T75eKpvw+95NqNWg9P-1+kzVzojpN0NLat+28SF1B9wQQQ@mail.gmail.com>
 <abjzvz_tL_siV17s@gpd4> <abkNtYPMARqxXibW@gpd4>
In-Reply-To: <abkNtYPMARqxXibW@gpd4>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 17 Mar 2026 19:53:04 +0100
X-Gm-Features: AaiRm50pic9LcRO928ElUxVlo5YBN8HzhV24NoW6grmJvKU12XQ_AFGBsImZgXY
Message-ID: <CAP01T75+2GWPbuda+NUBn+oon8Zdq=_45Me8BUE8B9=xcCoqyg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Always defer local storage free
To: Andrea Righi <arighi@nvidia.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Mar 2026 at 09:16, Andrea Righi <arighi@nvidia.com> wrote:
>
> On Tue, Mar 17, 2026 at 07:25:18AM +0100, Andrea Righi wrote:
> > Hi Kumar,
> >
> > On Tue, Mar 17, 2026 at 12:39:00AM +0100, Kumar Kartikeya Dwivedi wrote:
> > > On Mon, 16 Mar 2026 at 23:28, Andrea Righi <arighi@nvidia.com> wrote:
> > > >
> > > > bpf_task_storage_delete() can be invoked from contexts that hold a raw
> > > > spinlock, such as sched_ext's ops.exit_task() callback, that is running
> > > > with the rq lock held.
> > > >
> > > > The delete path eventually calls bpf_selem_unlink(), which frees the
> > > > element via bpf_selem_free_list() -> bpf_selem_free(). For task storage
> > > > with use_kmalloc_nolock, call_rcu_tasks_trace() is used, which is not
> > > > safe from raw spinlock context, triggering the following:
> > > >
> > >
> > > Paul posted [0] to fix it in SRCU. It was always safe to
> > > call_rcu_tasks_trace() under raw spin lock, but became problematic on
> > > RT with the recent conversion that uses SRCU underneath, please give
> > > [0] a spin. While I couldn't reproduce the warning using scx_cosmos, I
> > > verified that it goes away for me when calling the path from atomic
> > > context.
> > >
> > >   [0]: https://lore.kernel.org/rcu/841c8a0b-0f50-4617-98b2-76523e13b910@paulmck-laptop
> >
> > With this applied I get the following:
> >
> > [   26.986798] ======================================================
> > [   26.986883] WARNING: possible circular locking dependency detected
> > [   26.986957] 7.0.0-rc4-virtme #15 Not tainted
> > [   26.987020] ------------------------------------------------------
> > [   26.987094] schbench/532 is trying to acquire lock:
> > [   26.987155] ffffffff9cd70d90 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{2:2}, at: raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
> > [   26.987313]
> > [   26.987313] but task is already holding lock:
> > [   26.987394] ffff8df7fb9bdae0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x24/0xb0
> > [   26.987512]
> > [   26.987512] which lock already depends on the new lock.
> > [   26.987512]
> > [   26.987598]
> > [   26.987598] the existing dependency chain (in reverse order) is:
> > [   26.987704]
> > [   26.987704] -> #3 (&rq->__lock){-.-.}-{2:2}:
> > [   26.987779]        lock_acquire+0xcf/0x310
> > [   26.987844]        _raw_spin_lock_nested+0x2e/0x40
> > [   26.987911]        raw_spin_rq_lock_nested+0x24/0xb0
> > [   26.987973]        ___task_rq_lock+0x42/0x110
> > [   26.988034]        wake_up_new_task+0x198/0x440
> > [   26.988099]        kernel_clone+0x118/0x3c0
> > [   26.988149]        user_mode_thread+0x61/0x90
> > [   26.988222]        rest_init+0x1e/0x160
> > [   26.988272]        start_kernel+0x7a2/0x7b0
> > [   26.988329]        x86_64_start_reservations+0x24/0x30
> > [   26.988392]        x86_64_start_kernel+0xd1/0xe0
> > [   26.988451]        common_startup_64+0x13e/0x148
> > [   26.988523]
> > [   26.988523] -> #2 (&p->pi_lock){-.-.}-{2:2}:
> > [   26.988598]        lock_acquire+0xcf/0x310
> > [   26.988650]        _raw_spin_lock_irqsave+0x39/0x60
> > [   26.988718]        try_to_wake_up+0x57/0xbb0
> > [   26.988779]        create_worker+0x17e/0x200
> > [   26.988839]        workqueue_init+0x28d/0x300
> > [   26.988902]        kernel_init_freeable+0x134/0x2b0
> > [   26.988964]        kernel_init+0x1a/0x130
> > [   26.989016]        ret_from_fork+0x2bd/0x370
> > [   26.989079]        ret_from_fork_asm+0x1a/0x30
> > [   26.989143]
> > [   26.989143] -> #1 (&pool->lock){-.-.}-{2:2}:
> > [   26.989217]        lock_acquire+0xcf/0x310
> > [   26.989263]        _raw_spin_lock+0x30/0x40
> > [   26.989315]        __queue_work+0xdb/0x6d0
> > [   26.989367]        queue_delayed_work_on+0xc7/0xe0
> > [   26.989427]        srcu_gp_start_if_needed+0x3cc/0x540
> > [   26.989507]        __synchronize_srcu+0xf6/0x1b0
> > [   26.989567]        rcu_init_tasks_generic+0xfe/0x120
> > [   26.989626]        do_one_initcall+0x6f/0x300
> > [   26.989691]        kernel_init_freeable+0x24b/0x2b0
> > [   26.989750]        kernel_init+0x1a/0x130
> > [   26.989797]        ret_from_fork+0x2bd/0x370
> > [   26.989857]        ret_from_fork_asm+0x1a/0x30
> > [   26.989916]
> > [   26.989916] -> #0 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{2:2}:
> > [   26.990015]        check_prev_add+0xe1/0xd30
> > [   26.990076]        __lock_acquire+0x1561/0x1de0
> > [   26.990137]        lock_acquire+0xcf/0x310
> > [   26.990182]        _raw_spin_lock_irqsave+0x39/0x60
> > [   26.990240]        raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
> > [   26.990312]        srcu_gp_start_if_needed+0x92/0x540
> > [   26.990370]        bpf_selem_unlink+0x267/0x5c0
> > [   26.990430]        bpf_task_storage_delete+0x3a/0x90
> > [   26.990495]        bpf_prog_134dba630b11d3b7_scx_pmu_task_fini+0x26/0x2a
> > [   26.990566]        bpf_prog_4b1530d9d9852432_cosmos_exit_task+0x1d/0x1f
> > [   26.990636]        bpf__sched_ext_ops_exit_task+0x4b/0xa7
> > [   26.990694]        scx_exit_task+0x17a/0x230
> > [   26.990753]        sched_ext_dead+0xb2/0x120
> > [   26.990811]        finish_task_switch.isra.0+0x305/0x370
> > [   26.990870]        __schedule+0x576/0x1d60
> > [   26.990917]        schedule+0x3a/0x130
> > [   26.990962]        futex_do_wait+0x4a/0xa0
> > [   26.991008]        __futex_wait+0x8e/0xf0
> > [   26.991054]        futex_wait+0x78/0x120
> > [   26.991099]        do_futex+0xc5/0x190
> > [   26.991144]        __x64_sys_futex+0x12d/0x220
> > [   26.991202]        do_syscall_64+0x117/0xf80
> > [   26.991260]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > [   26.991318]
> > [   26.991318] other info that might help us debug this:
> > [   26.991318]
> > [   26.991400] Chain exists of:
> > [   26.991400]   rcu_tasks_trace_srcu_struct_srcu_usage.lock --> &p->pi_lock --> &rq->__lock
> > [   26.991400]
> > [   26.991524]  Possible unsafe locking scenario:
> > [   26.991524]
> > [   26.991592]        CPU0                    CPU1
> > [   26.991647]        ----                    ----
> > [   26.991702]   lock(&rq->__lock);
> > [   26.991747]                                lock(&p->pi_lock);
> > [   26.991816]                                lock(&rq->__lock);
> > [   26.991884]   lock(rcu_tasks_trace_srcu_struct_srcu_usage.lock);
> > [   26.991953]
> > [   26.991953]  *** DEADLOCK ***
> > [   26.991953]
> > [   26.992021] 3 locks held by schbench/532:
> > [   26.992065]  #0: ffff8df7cc154f18 (&p->pi_lock){-.-.}-{2:2}, at: _task_rq_lock+0x2c/0x100
> > [   26.992151]  #1: ffff8df7fb9bdae0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x24/0xb0
> > [   26.992250]  #2: ffffffff9cd71b20 (rcu_read_lock){....}-{1:3}, at: __bpf_prog_enter+0x64/0x110
> > [   26.992348]
> > [   26.992348] stack backtrace:
> > [   26.992406] CPU: 7 UID: 1000 PID: 532 Comm: schbench Not tainted 7.0.0-rc4-virtme #15 PREEMPT(full)
> > [   26.992409] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> > [   26.992411] Sched_ext: cosmos_1.1.0_g0949d453c_x86_64_unknown^_linux_gnu (enabled+all), task: runnable_at=+0ms
> > [   26.992412] Call Trace:
> > [   26.992414]  C<TASK>
> > [   26.992415]  dump_stack_lvl+0x6f/0xb0
> > [   26.992418]  print_circular_bug.cold+0x18b/0x1d6
> > [   26.992422]  check_noncircular+0x165/0x190
> > [   26.992425]  check_prev_add+0xe1/0xd30
> > [   26.992428]  __lock_acquire+0x1561/0x1de0
> > [   26.992430]  lock_acquire+0xcf/0x310
> > [   26.992431]  ? raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
> > [   26.992434]  _raw_spin_lock_irqsave+0x39/0x60
> > [   26.992435]  ? raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
> > [   26.992437]  raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
> > [   26.992439]  srcu_gp_start_if_needed+0x92/0x540
> > [   26.992441]  bpf_selem_unlink+0x267/0x5c0
> > [   26.992443]  bpf_task_storage_delete+0x3a/0x90
> > [   26.992445]  bpf_prog_134dba630b11d3b7_scx_pmu_task_fini+0x26/0x2a
> > [   26.992447]  bpf_prog_4b1530d9d9852432_cosmos_exit_task+0x1d/0x1f
> > [   26.992448]  bpf__sched_ext_ops_exit_task+0x4b/0xa7
> > [   26.992449]  scx_exit_task+0x17a/0x230
> > [   26.992451]  sched_ext_dead+0xb2/0x120
> > [   26.992453]  finish_task_switch.isra.0+0x305/0x370
> > [   26.992455]  __schedule+0x576/0x1d60
> > [   26.992457]  ? find_held_lock+0x2b/0x80
> > [   26.992460]  schedule+0x3a/0x130
> > [   26.992462]  futex_do_wait+0x4a/0xa0
> > [   26.992463]  __futex_wait+0x8e/0xf0
> > [   26.992465]  ? __pfx_futex_wake_mark+0x10/0x10
> > [   26.992468]  futex_wait+0x78/0x120
> > [   26.992469]  ? find_held_lock+0x2b/0x80
> > [   26.992472]  do_futex+0xc5/0x190
> > [   26.992473]  __x64_sys_futex+0x12d/0x220
> > [   26.992474]  ? restore_fpregs_from_fpstate+0x48/0xd0
> > [   26.992477]  do_syscall_64+0x117/0xf80
> > [   26.992478]  ? __irq_exit_rcu+0x38/0xc0
> > [   26.992481]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > [   26.992482] RIP: 0033:0x7fe20e52eb1d
>
> With the following on top everything looks good on my side, let me know
> what you think.
>
> Thanks,
> -Andrea
>
> From: Andrea Righi <arighi@nvidia.com>
> Subject: [PATCH] bpf: Avoid circular lock dependency when deleting local
>  storage
>
> Calling bpf_task_storage_delete() from a context that holds the runqueue
> lock (e.g., sched_ext's ops.exit_task() callback) can lead to a circular
> lock dependency:
>
>  WARNING: possible circular locking dependency detected
>  ...
>  Chain exists of:
>    rcu_tasks_trace_srcu_struct_srcu_usage.lock --> &p->pi_lock --> &rq->__lock
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(&rq->__lock);
>                                 lock(&p->pi_lock);
>                                 lock(&rq->__lock);
>    lock(rcu_tasks_trace_srcu_struct_srcu_usage.lock);
>
>   *** DEADLOCK ***
>
> Fix by adding a reuse_now flag to bpf_selem_unlink() with the same
> meaning as in bpf_selem_free() and bpf_local_storage_free(). When the
> task is in the TASK_DEAD state it will not run sleepable BPF again, so
> it is safe to free storage immediately via call_rcu() instead of
> call_rcu_tasks_trace() and we can prevent the circular lock dependency.
>
> Other local storage types (sk, cgrp, inode) use reuse_now=false and keep
> waiting for sleepable BPF before freeing.
>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
> [...]

Thanks for the report Andrea. The bug noted by lockdep looks real, and
Paul agrees it is something to fix, which he will look into.

https://lore.kernel.org/rcu/fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop

The fix you provided below unfortunately can't work, we cannot free
the selem immediately as the program may have formed pointers to the
local storage before calling delete, so even if the task is dead
(which is task specific anyway, we don't address other local storages)
we can still have use-after-free after we return from
bpf_task_storage_delete() back to the program. We discussed this
'instant free' optimization several times in the past for local
storage to reduce call_rcu() pressure and realized it cannot work
correctly.

So the right fix again would be in SRCU, which would be to defer the
pi->lock -> rq->lock in call_srcu() when irqs_disabled() is true. This
should address the circular deadlock when calling it under the
protection of rq->lock, such as the case you hit.

Thanks

> [...]
