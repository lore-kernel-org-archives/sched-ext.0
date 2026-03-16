Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA39355F58
	for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773704380; cv=pass; b=MwrV/1r19siTgA9ES9lSvWhrItlyy+wLnFAdzHge74+XqepAwnkxPgfpulXAyeMquEQ6gDb4nG9jjBdR6eItJPy+PdKPuozYA7NdeAokTkx6tLxjt3gQVb261D/Ll7tkkr1wohwfcKRyVx1dg7GMO2a2x2zeptaMsdEj0k8i908=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773704380; c=relaxed/simple;
	bh=LUpdFr8nOZ8lx3r0F4s/5dNqsY4EtiZ0vGoDtM9n5pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gV/t4RdM2ouUS+z4ZUIrH8h5IP/5guXy+sgqUohJ7j2zpaCSCkWUIY+iusPmqNzvwpxI8MFB84AELsADi/FOfK7ssu4tj0UHId/hx1ppa2GPKCt161t+pq5Ew0Oyg0VBLUqHJHJTHVJ0JudyoikqiFWgjYjnk72K1HArmSlFqR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNwfmEq7; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNwfmEq7"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43b40003d13so1489690f8f.2
        for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 16:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773704377; cv=none;
        d=google.com; s=arc-20240605;
        b=an40jxwsanZnVx+LM3F4ssyilmTcAPFXcScwTbT9d3uAcdZ7Cx/K9sct/jKgXfpAHC
         r19rfyWN/KFjUoy9mNd3PItAbfcS/2VeR3Y8DvylpC5MgHNLT8A4BQTswsRPNijtCHYL
         hBzscZFc8UMYP4TPidRVswVoOl8aJWfTDQ7lWtutJG4E0yf5XeCBxsvLNpD9hey0v0cX
         gQZy8xFQZcVamgS7ZbeBkRk70EvMwGBw55wjW5r7RkbXGSkkBotzL8/HvqYDqPnmTwOd
         rSutyNDj5Gpbd6js98ihEI5kJLoQHEv44MqW/3v0f3SrvZtAx/MOIC5qAJNaubDGyvMb
         NTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qP4EcfO8blTbLu9B8ieQwix5cbr1SvW0uRiRyDgzQTQ=;
        fh=uAD7A/Y5pm8r3MS2bRUGx+khBUieKOXvCMXtpL8rOpg=;
        b=IMmKBZUCfNKLqkpptys+hPHsXLDAydxU1hFNJ+VS+4qmw11ZSkOG8R150Kf9lu+d1i
         034cuqF2x+N58LXERz5vuLZB5619mtD6dmMjgCY2xx90cHfERBYwgisBhH2D3/jpiw81
         lpG7WpF/zJziDa+7XNDBR23jDoBDpyU7audenxeyH6FJWPdc5W7Qloal4r8w3RneW/6m
         EKWUCaXK+1b0ClIt9wsjWJO2vza1ssPO846dCuj6Zr4aXQ25IOk6Ist27epAoB2umqjn
         /8YImWVyUjmVQkyWKJtwfoW1aKA9baMstN7qWMulKvjONT0RUXop1+pIvPs+Z8l3J+UL
         4tUQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773704377; x=1774309177; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qP4EcfO8blTbLu9B8ieQwix5cbr1SvW0uRiRyDgzQTQ=;
        b=nNwfmEq7XrlPUC6uvBKPEr7Rjvn2cB0I1Us5Md9MOEAcfCJArcSzeMAhkwBpMfSc4i
         WtYArPIBvS+/SCIUChSwOVyuAkP0OxlODRW3SpOwhzLiYj6fBkD/Z9bCCx5SNoQh6Cli
         XYISn8h+89e/GyMS9eTZzSxSgFdNzHKWLYRQBNWiOxY3dU5lmlGsZ2DMNw88oIhN+RF7
         7bKApgB83or35f9LMte0wqaA2gELUXAxmgOfsUIdGq8cGlyDRqRArqX7JSeDckoDzOl6
         LyaHD7lUls6asoVYi5t63/4y6Z75jZXQ6vbzcIrf+MEVSFb8xSGZwmeIG/f6uPu/Gics
         o8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773704377; x=1774309177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qP4EcfO8blTbLu9B8ieQwix5cbr1SvW0uRiRyDgzQTQ=;
        b=gqtsbuIItLbJV5Cr+7dVUpU70UhLnIb7eSrhB1WoE8rEugePZn2+j5gRD/A7PQWG6V
         1gBroQBuRBzwOkGtUMA4LkGslpWVYMYZvn80T3hVrezKOhIs7/ic8Zaw6T5FeMW3eNnz
         7p7tsbUrSJFoh6a2mRo04HsUxlWQeurcmndsNGJ15DMHpDy5owP7OjATr873AjSpT+R2
         82JcC1qn9nnzJ4ThQRUdriqNQ3fEiIaiJFVs37yc0af/IvCV4Veo8QPmyQEblLJtf8q6
         UsOmIGDUjfNtDO5vUaQW+wBn6ujIJEjhJvz2PxFdWnSZvUlx6ONYFu7H+hJRJpmZhFVg
         6i0w==
X-Forwarded-Encrypted: i=1; AJvYcCW3pqba0pVXmbWWWi0SN4sy9gSDYTZoj5In+70gFNwcDxhH76Asx0DWcUx5WKiO4n91soYfPidiSV0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxfpTwpAWoNN0x8bIFZiD7r1FP3WHbBWmivkVusUpWcWtezCeIo
	+MDBBqhiOnu4/BBqaEwc6fue+fjvD4Q+wabIhHFrJhbvuD4mmQVPfN+kszqUsuiw3xxv6cyEqOw
	GZDiKFTAgxol4uKKrTwI6RcrwRz6s8Gc=
X-Gm-Gg: ATEYQzzIvcKvFluyp7gk/I2HQw69LcEzSY0yIgM3h/AOAPq7agsGNIUU3kXDUXnN/gl
	puf8yxzPLYXpyWfKEGpY4xnsGB7bN4DjkFaAqP1nT8OeD4tgO2JS11/gFci6RRgu+Ti+PEsD076
	uj0ny4edjetGt3amqM9+VhLYWhWSCjPjlaoLQeUSKksw1MS6xhVHjMWokrn0PZlSJzWWcCaD35D
	uBpuc6CSCetnnrqz+Tjx9L4MuliC9GFbt9CcIlORo3Ie4WbWzhy42Nbfn8tgPduZP6HhAbtWi5J
	GQBlNhxu/dscgZXhMthP2IM/KQzeOE7nBOMB1VEhmbfLjXZtas+cNZ1gpCY=
X-Received: by 2002:a05:6000:2f85:b0:43b:4352:1bd8 with SMTP id
 ffacd0b85a97d-43b43521dcfmr11092768f8f.53.1773704377224; Mon, 16 Mar 2026
 16:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260316222758.1558463-1-arighi@nvidia.com>
In-Reply-To: <20260316222758.1558463-1-arighi@nvidia.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 17 Mar 2026 00:39:00 +0100
X-Gm-Features: AaiRm50QTIyuUJ_7soIEToEoeT5sSCTG2VivsOgvUWqhQsYvjGCB-NLOj-MT8JM
Message-ID: <CAP01T75eKpvw+95NqNWg9P-1+kzVzojpN0NLat+28SF1B9wQQQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Always defer local storage free
To: Andrea Righi <arighi@nvidia.com>, "Paul E . McKenney" <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 23:28, Andrea Righi <arighi@nvidia.com> wrote:
>
> bpf_task_storage_delete() can be invoked from contexts that hold a raw
> spinlock, such as sched_ext's ops.exit_task() callback, that is running
> with the rq lock held.
>
> The delete path eventually calls bpf_selem_unlink(), which frees the
> element via bpf_selem_free_list() -> bpf_selem_free(). For task storage
> with use_kmalloc_nolock, call_rcu_tasks_trace() is used, which is not
> safe from raw spinlock context, triggering the following:
>

Paul posted [0] to fix it in SRCU. It was always safe to
call_rcu_tasks_trace() under raw spin lock, but became problematic on
RT with the recent conversion that uses SRCU underneath, please give
[0] a spin. While I couldn't reproduce the warning using scx_cosmos, I
verified that it goes away for me when calling the path from atomic
context.

  [0]: https://lore.kernel.org/rcu/841c8a0b-0f50-4617-98b2-76523e13b910@paulmck-laptop

>  =============================
>  [ BUG: Invalid wait context ]
>  7.0.0-rc1-virtme #1 Not tainted
>  -----------------------------
>  (udev-worker)/115 is trying to lock:
>  ffffffffa6970dd0 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{3:3}, at: spin_lock_irqsave_ssp_contention+0x54/0x90
>  other info that might help us debug this:
>  context-{5:5}
>  3 locks held by (udev-worker)/115:
>   #0: ffff8e16c634ce58 (&p->pi_lock){-.-.}-{2:2}, at: _task_rq_lock+0x2c/0x100
>   #1: ffff8e16fbdbdae0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x24/0xb0
>   #2: ffffffffa6971b60 (rcu_read_lock){....}-{1:3}, at: __bpf_prog_enter+0x64/0x110
>  ...
>  Sched_ext: cosmos_1.0.7_g780e898fc_dirty_x86_64_unknown_linux_gnu (enabled+all), task: runnable_at=-2ms
>  Call Trace:
>   dump_stack_lvl+0x6f/0xb0
>   __lock_acquire+0xf86/0x1de0
>   lock_acquire+0xcf/0x310
>   _raw_spin_lock_irqsave+0x39/0x60
>   spin_lock_irqsave_ssp_contention+0x54/0x90
>   srcu_gp_start_if_needed+0x2a7/0x490
>   bpf_selem_unlink+0x24b/0x590
>   bpf_task_storage_delete+0x3a/0x90
>   bpf_prog_3b623b4be76cfb86_scx_pmu_task_fini+0x26/0x2a
>   bpf_prog_4b1530d9d9852432_cosmos_exit_task+0x1d/0x1f
>   bpf__sched_ext_ops_exit_task+0x4b/0xa7
>   __scx_disable_and_exit_task+0x10a/0x200
>   scx_disable_and_exit_task+0xe/0x60
>
> Fix by deferring memory deallocation to ensure it occurs outside the raw
> spinlock context.
>
> Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
> [...]
