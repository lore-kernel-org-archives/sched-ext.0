Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795453670;
	b=BUes1KyLcJBiojWg1hkt1lJsXbkXlWl7gAkYyszqUW7hKe6kWFzpsy2oFgCdpVm015+8
	 if4XmlZ68AJFS7bEqtxz6E8WMMfNMC78EvGDNFAfIZ6wtSG++eSOVdofGNQ3oI1iQbk3O
	 4nHXz+TSme3Mm3YQUrdyEWpe8JDWDyNSyTHvtgJfz3FKx2jDj8CIQ5n7tqRCc+XVFiwIH
	 O1LA1r2fShCfs+JjDpGn8i/zTQ32wbNoALyhHA5IRxzBc9PLmo9qVZLr3cMGUR8QuAONu
	 gSoHYOdhPlEVM6RJPxaED6H7ZN6P7utKAfa77hvHoVYkPP4xgESNWNWa3rfY2UbNc+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+xaIvYw9qB8U9m5yBZTbNli0aV2ssc6MRhHdFn2AjAQ=;
	b=EEz/Ehmvg8JCH3RAWH1Eo9H2GVcj9cGN4g8OduP4IuE6RCZ6LDoDORAfdkPi994jFmBY
	 9d03cQ6OyiDPsL1watVQawEyVujDwzJkqi5NTdD5K+WC7tEwrn3Y7my8YT38cC2rca17z
	 A+MY8ePoWhkWOhA9r1XNtXszt0UXoKTcvr5GnvsmW15F63m8tPUB7M1WXZ9STHAGydFDN
	 IZp3uG7fkLDqtx5aff3QfWfnOXAFGjdLfZ4g26mOmT6BZtfW6DbtiL+qdNND1Pn8SkidD
	 P3YxWl4mfGJdEc5mpRXy3g8DMHUpu04lJXnhj8/vA2O6X/uAjuyMMM0g1//031x3Iaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KStxFp7Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CED606A31E
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 17:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1CED606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KStxFp7Y
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b88d143160so4302973a12.1
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 09:07:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795453668; cv=none;
        d=google.com; s=arc-20260327;
        b=iL/A3QwlSC1vw3rPG6fGUYFUjK8wmpwZbCouieMNP9v+CIHSKE1mkssNbD+ogsk1Cb
         ecDgdKJwHEEwkbdbM3oTw5bZFq6qPZUfLSavQu3o2/9xnpfeZBsDOGaYklcCa7Uhjjcw
         3Qfd8AtCMf1QhleQbAKq3h3OoSL3beLPHhXQmGgmZPTWCkdOY7cmKPsfoiZ1nDp5ubNx
         7Rs98wE+hHfD2tFwCps6QOfzpV60PBHOlTyImxInoax0JjrOXVeplVSsTTg9OjpfI6xx
         ppFRL1GRTsK/T4NlPZ0TX9r7Np4FNC2flY5kemizeZLwBPexDD2eelkLVkF158eAwrso
         Saug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+xaIvYw9qB8U9m5yBZTbNli0aV2ssc6MRhHdFn2AjAQ=;
        fh=2q2s08xZq+od6SCF+HQJU9UpwfDLyGQQ8a4D9FHpEQY=;
        b=Fae0JZg4rKEL0jzui2QFQztWdltwrWfx0bncvYVadF5D7wUB8j501+GtAHCcJZdmTx
         rTlyurB+yulO4ufur0vLPYdDUDJuttIWn6wbN0kOlB7MeiUIvRyc26ZGqncn3Ua/IpdY
         ngYlJ1+1CmrlqvTKuYi5lhUpD6TxhJlwpImDGeG7E/S00/Xugh6pzgsGJCPIOJ+tZweu
         4kfCWSnxxIX2dgvG/c9PLIwSZmJZmoIS81haEmzi5FIO1pliwSqKcvaWiSjO8wcN44W4
         GCUlG+65jCkz38rhNg95lTss31FQjZMlA6sklRu33ZzfgNfu6dBMVyODEVBDlA5FUyCW
         8RqQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795453668; x=1796058468; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+xaIvYw9qB8U9m5yBZTbNli0aV2ssc6MRhHdFn2AjAQ=;
        b=KStxFp7YA9tI6NId2DkgJjxn5YJhGqos7saRXdZOKOijnhYGGzgdqkuy9Z1aWTDGw/
         33E5jOhjuY2MeSDIJrGYEnWFHN6+1sO0Dh1PTMWc6s/3R7BsXOpP1bmMq5rsHqvnSc24
         dyz9ggHB5m+JGHU3QuRE8CBNWprrsnGq4dFmDz0fMzbvv7Z0srVT5Ge5FaCHPgp2Vb0e
         D1gdj2/xrHDBUI+XO0Qty6mPyTz7UdhDULb3LMKN6b3UjsUsOL9+vwapYgKukZlwIy3i
         Jq3dIcjtQmkNaTQjywCVg4yu1Go2+osa7Z40HFXvfhO55UBkJ8/fzEezNcGhM6JcNsC/
         yy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453668; x=1796058468;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+xaIvYw9qB8U9m5yBZTbNli0aV2ssc6MRhHdFn2AjAQ=;
        b=xaa7XSkTu6TJ+Or76sYkDs5/EjhOv63d3EEn5aHbgqCEtraSuBn/FJGPECd4vgtwoH
         ExDu0mNtkqRHeGjuzlLWK/Y2c5r5OWPql0v7c4by9hpfor6DhmNzF7Pk6uo+WeZU1hpS
         jOjjMxWwybb2COtx5uyTqLxVh6UfujfqfBsQBrmU0WWBUHcaO4tired3gcRl14Lw0Rw+
         0gpfofSJ7Fgm6CyYwVd5vdtnJTaxUdateLJH3msSBWvNHfS8WEAHgky5mNsFexc570WI
         I/u2y6jmHYmyIHMvVs0I3IhkrqiR+jZpdZvBBbYwjRZJgoC6gBoTdy0X2VTAY7XErOTF
         PiiQ==
X-Forwarded-Encrypted: i=1; AL+hErEOAWu3YlWQlo431g43p77U++xH8Wmw7Qpfn7kpRBMuRCAJHsRbdVkkgtf88GCShMaKuO1B99hqFaU=@lists.linux.dev
X-Gm-Message-State: APuU4Z/1XKFymcZ4lL1oWTwA/qqcbkYwUuSPkwQRCk9BTh/SWlP0SiKi
	mQSS4CG++DuNqxM4x+vY2830BvRVEsuOCKZ/tZ/TF1nWiqzkGVaCNbgS+MoXLJrInGf7AGHpZz9
	Oh2Mbq7wJApYyLbVIHauqLTQusIXe8PRn4+i6nvV+QA==
X-Gm-Gg: AZFdTZflnqte3RcDn04o+PnrURJpE3fnFoVtAhNXJBSCLGAGZ4HdTbagHClfHnY/y+R
	W/aqUDT9ke7nPJ0Rip2ll7WbTRIEYn0NEaV3/YPXrJDzT+BOrzGuK0pjlU8D1M0qT1CPWusJx2A
	ox+varyNiy97f6upPYNfxWdBEM2hckzoQ9qlfQZFtgYHaZj+aFsqbz2/YEFC1EpQSfVEe4uZPcu
	V2TQ8TD1TCswyWr72iWRQrejCJAS4Q07EVX2GiOsltdDLtFNj/5gKSN+XFRpnh5/35grpDzrOGd
	fK68M0OWQWJHAhtzPaaPSyOeLK0NrJ5NWfzdOlER1IUH021QZpp5D2ygMKcdRtt3V0JmshAONRX
	PWwZ2200VcjXVcNMgnvbWzDUOoq1paSyAQb37vx+kV50uJ6JqbnFkMKdfKV7tfL7LX3TS1g==
X-Received: by 2002:a05:6402:1f90:b0:6b8:6d0e:42d1 with SMTP id
 4fb4d7f45d1cf-6ba37ec55b7mr8892708a12.42.1795453667947; Mon, 23 Nov 2026
 09:07:47 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com>
 <CAKfTPtCQpVhtVT7Mhqe1=Ukcmc1pX8Jgn9ypb64--8cJ-7G4BQ@mail.gmail.com> <20261123160934.2289260-1-penghuang@google.com>
In-Reply-To: <20261123160934.2289260-1-penghuang@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 23 Nov 2026 18:07:36 +0100
X-Gm-Features: Aa3M54pZP_B9lARK2Zw6EDmAmPbhCNYrxOAs4lBrYCe4I2A8S177FGDlJx_bcaI
Message-ID: <CAKfTPtD17e-veL1QgrhO6i4nsKyA3QfOEm8jNinJ_zf+vc8RDw@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: Skip dormant cfs util_sum under scx_switched_all
To: Peng Huang <penghuang@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 17:09, Peng Huang <penghuang@google.com> wrote:
>
> On Mon, 23 Nov 2026 at 11:34, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >
> > When all tasks are moved to sched_ext, fair utilization should be 0
> >
> > ...
> >
> > This is not the right solution but a bandaid to hide the issue. When
> > there is not fair task,  rq->cfs.avg.util_sum shoudl become null.
> > Please look at why it is not null.
> > It could be that the update stops before everything has been
> > propagated correctly in the task group tree
>
> Thanks for pointing this out -- you are right, and looking into the
> code confirms your suspicion about stopped updates and incomplete task
> group propagation:
>
> 1. Deferred cfs_rq->removed and unvisited sibling task groups:
>    Tasks that exited (task_dead_fair()) or migrated while sleeping
>    (migrate_task_rq_fair()) before scx_enable() queue their load/util
>    in cfs_rq->removed via remove_entity_load_avg() rather than
>    deducting and propagating immediately.
>
>    During scx_enable(), switched_from_fair() -> detach_task_cfs_rq()
>    only visits and propagates along cfs_rq chains that still have at
>    least one live attached fair task. Any CPU or sibling cgroup cfs_rq
>    with no remaining live fair task is never visited, so its
>    cfs_rq->removed stays undrained and its tg_se contribution remains
>    in rq->cfs.avg. Once __scx_switched_all is enabled,
>    scheduler_tick() skips sched_balance_trigger() and fair_sched_class
>    is bypassed, so __update_blocked_fair() never runs to drain and
>    propagate those remaining leaf cfs_rqs.
>
> 2. Sub-divider util_sum residuals:
>    Even on visited chains, if tg_se->avg.util_avg has already decayed
>    to 0 (with 0 < tg_se->avg.util_sum < divider) when the child
>    gcfs_rq's last task detaches, update_tg_cfs_util() sees
>    delta_avg == 0 and returns early without subtracting
>    tg_se->avg.util_sum from the parent cfs_rq. Independent PELT decay
>    truncation and integer removed.util_avg accounting can also leave a
>    < divider remainder in cfs_rq->avg.util_sum after util_avg hits 0.
>
> For v2, rather than touching update_idle_rq_clock_pelt(), how about
> adding a fair helper (similar in spirit to rq_offline_fair() ->
> clear_tg_offline_cfs_rqs()) and calling it from scx_enable() in the
> existing per-CPU scx_switched_all() loop (where rq->lock is held,
> rq->clock is updated, and rq->cfs.h_nr_queued == 0)? Specifically, it
> would walk leaf_cfs_rq_list bottom-up (plus &rq->cfs) to:
> - flush cfs_rq->removed,
> - clear load/runnable/util _sum and _avg on the empty cfs_rqs and
>   their tg_ses while preserving last_update_time and period_contrib,
> - clear tg contributions via clear_tg_load_avg(), remove the empty
>   cfs_rqs from leaf_cfs_rq_list, and update rq->has_blocked_load.
>
> Does this direction look reasonable to you?

Yes this seems a better solution but It would be good to reuse
__update_blocked_fair() which already does the work for pelt signal.
Regarding your issue with util_avg == 0 whereas we still have a
util_sum != 0, we can use delta_sum = gcfs_rq->avg.util_sum -
se->avg.util_sum; in update_tg_cfs_util() instead. When util_avg == 0
we will be sure to clear util_sum too

Thanks,
Vincent
>
> Thanks,
> Peng
