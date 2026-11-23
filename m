Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450177;
	b=yfAZyC2uKnSy72JOAC6UWg/3jlqfC92MnUin9hQidvuPv72akT33+M2iwO+BphwNKnok
	 NPotHhEqFbMNXUWAc7z4HwamK9EK2ITWS+tbuIXKACGI6MwAT4XkW0cgPMYKt7kRv7887
	 U1+XtXZmbQTw8XBCKQl+eW9kg2s1gVbW2W2sVreZ4kVhlyScFsrgf3JWRlLBkMny/EdmP
	 rIxlZp7HbrebVuBIA5zbnsgZkNG9gei7zfbiCNbYZKaOpnPIEDXICsa4jY1l1vGB3I9dL
	 O2hzGXacduKsIKH9rgg/e9h3U4FcyIX1caLTFKvDkS3cA86YMfzm66MnrCY3fyq2acA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=JhcfpBwHSU7MgwxhgP4Qq1k5bLuK7ieaSxmvk+gyAcc=;
	b=3Yzfy/x15gDP7vRswtjsrx18ZwG3mcosSKPR+rSITQVfRlQx8WfZVeQVYmYP2lgvepd2
	 oAkEMtPaC/esckydDr81wzGu72H5y2ZMJ5bhOnH0rDhqxzQ2E42b3Pl/Z9Ply/5zdDz6U
	 L/BOiEeamWFX7HPVzd9HWRVBSw85xNNwmvOS+g20VsXFVosZk6mPK2aNsDeuBVV2DCGgR
	 ivg+XvwF1AzyqutA2lcnEeCc2arlBQpHLY4jmEg35F2RKz2fmTGn5VtkX7Cn+71f3Iaan
	 1dv/b6h5UsOhqEW+7whgEg/+J1P+BdNeAXY4V4yhB7pW2NGkcFO9O7Sxvoo2fyGC+nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LeIUUdve;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3406606A31A
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 16:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3406606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LeIUUdve
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3869865a304so1559798eec.0
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 08:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795450176; x=1796054976; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JhcfpBwHSU7MgwxhgP4Qq1k5bLuK7ieaSxmvk+gyAcc=;
        b=LeIUUdve/sEcPtXOAos5cjvpS5I0o4sWtpH1mnWCZoQQj4inVSw1SHAwt2ewJl/Z0H
         ZaybExfzPFKIFsJ7GpIyuh2mpbDCgl6FJW4taY/W4xI7jv3QkUkQ6UUcC0QgRGXS900y
         8NE5Cya0XD8EWZhNyHdanG+xSuh5p0/zuTnyl1rjUiWJQy2H639v/m5V36299jlEBSUq
         crzgq6CaZ9Qkq4HsdIfCIIh/SegFcT8pXJSIwZBjqVuGRf9ZKjk/WvKcI9QIUyE4dPr6
         fPHwk+ny8Tq1lVkmoewVMEUXlILyeWO528jRqOG3558P4LshaIHZZriTPMYOnJiGU8Dx
         CiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450176; x=1796054976;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhcfpBwHSU7MgwxhgP4Qq1k5bLuK7ieaSxmvk+gyAcc=;
        b=nM7RJgwazjhTH8WL9bDckngmzYxmnpRZciIIr2H7UEMjxG13Bo53TB1WR2rAg5/jND
         h5Ou1Mwoodiaj6n2Ijm+wmq4NFHPgNckN8eEHV/TSPsScWbtHlMenImGcIxsJ4mIyItD
         eXwm1jPK5RAv8ARTCrl55nK2vdfgfifiHD2CBXsdmLBL89tmEbx+NZUHs1l0fjNA7CJb
         BV43r4i6nV96XRCIFfYWpqF7uOmuz3A+WN2ctk9gJFGgfDcNwVdJdObQZxhMBPxHwnuW
         9NIQLKFgVUg7MmMATBp18V17SSxR/MHkG73s7j7ck8b2posB7Heyr1Rl90jAx7qp3Ol9
         CAEg==
X-Forwarded-Encrypted: i=1; AL+hErGUOTPP17P7HvPsR7suIsV7tucEr0DZJYYdUir5gWGzv2Q797gyE4OL1LQnOXqmPpI7uDaAUBN+Ado=@lists.linux.dev
X-Gm-Message-State: APuU4Z+cMnliypWWrCbJ3lKc1gu+8g0Haon2vZ5c8jFuJHlgVbgToTtK
	1U582PUz9TzjvobrFpzujqtI7zRC9Il2XFM0IsDdIa1JE/DXqhNjzYeimOTj7wFyNiwFuhuSM4D
	DAvW0RubqUhZF5WvxgQ==
X-Received: from dybmf40.prod.google.com ([2002:a05:7301:928:b0:36c:9b55:8436])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:4284:b0:382:1aea:c21d with SMTP id 5a478bee46e88-3857191bcf7mr12981179eec.41.1795450175386;
 Mon, 23 Nov 2026 08:09:35 -0800 (PST)
Date: Mon, 23 Nov 2026 08:09:34 -0800
In-Reply-To: <CAKfTPtCQpVhtVT7Mhqe1=Ukcmc1pX8Jgn9ypb64--8cJ-7G4BQ@mail.gmail.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com> <CAKfTPtCQpVhtVT7Mhqe1=Ukcmc1pX8Jgn9ypb64--8cJ-7G4BQ@mail.gmail.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123160934.2289260-1-penghuang@google.com>
Subject: Re: [PATCH] sched/pelt: Skip dormant cfs util_sum under scx_switched_all
From: Peng Huang <penghuang@google.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peng Huang <penghuang@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 11:34, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> When all tasks are moved to sched_ext, fair utilization should be 0
>
> ...
>
> This is not the right solution but a bandaid to hide the issue. When
> there is not fair task,  rq->cfs.avg.util_sum shoudl become null.
> Please look at why it is not null.
> It could be that the update stops before everything has been
> propagated correctly in the task group tree

Thanks for pointing this out -- you are right, and looking into the
code confirms your suspicion about stopped updates and incomplete task
group propagation:

1. Deferred cfs_rq->removed and unvisited sibling task groups:
   Tasks that exited (task_dead_fair()) or migrated while sleeping
   (migrate_task_rq_fair()) before scx_enable() queue their load/util
   in cfs_rq->removed via remove_entity_load_avg() rather than
   deducting and propagating immediately.

   During scx_enable(), switched_from_fair() -> detach_task_cfs_rq()
   only visits and propagates along cfs_rq chains that still have at
   least one live attached fair task. Any CPU or sibling cgroup cfs_rq
   with no remaining live fair task is never visited, so its
   cfs_rq->removed stays undrained and its tg_se contribution remains
   in rq->cfs.avg. Once __scx_switched_all is enabled,
   scheduler_tick() skips sched_balance_trigger() and fair_sched_class
   is bypassed, so __update_blocked_fair() never runs to drain and
   propagate those remaining leaf cfs_rqs.

2. Sub-divider util_sum residuals:
   Even on visited chains, if tg_se->avg.util_avg has already decayed
   to 0 (with 0 < tg_se->avg.util_sum < divider) when the child
   gcfs_rq's last task detaches, update_tg_cfs_util() sees
   delta_avg == 0 and returns early without subtracting
   tg_se->avg.util_sum from the parent cfs_rq. Independent PELT decay
   truncation and integer removed.util_avg accounting can also leave a
   < divider remainder in cfs_rq->avg.util_sum after util_avg hits 0.

For v2, rather than touching update_idle_rq_clock_pelt(), how about
adding a fair helper (similar in spirit to rq_offline_fair() ->
clear_tg_offline_cfs_rqs()) and calling it from scx_enable() in the
existing per-CPU scx_switched_all() loop (where rq->lock is held,
rq->clock is updated, and rq->cfs.h_nr_queued == 0)? Specifically, it
would walk leaf_cfs_rq_list bottom-up (plus &rq->cfs) to:
- flush cfs_rq->removed,
- clear load/runnable/util _sum and _avg on the empty cfs_rqs and
  their tg_ses while preserving last_update_time and period_contrib,
- clear tg contributions via clear_tg_load_avg(), remove the empty
  cfs_rqs from leaf_cfs_rq_list, and update rq->has_blocked_load.

Does this direction look reasonable to you?

Thanks,
Peng
