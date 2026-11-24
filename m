Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527327;
	b=Hn4Na0hRKCQwoBHDn6JNii/tPwM2palchuvplcFBF29pWS0VvFnoi0n2AlRArJE/0tqR
	 ZQiYclj+oyvZjXwdMwH3aGwfv1a3MH1dkk8yaG6axeWN5nydkXKN8kEwBwErK7Nh7hJEf
	 IuuOmzY2K1OyslUjVVJsmLOQ+9vcV9aviVoazGjnqq50KHGqfDD4i9bYidLNW9U3X/rBG
	 bwODKWUddBWpEvEzUmW7lnEs0o4Nh40L5PmS5xG12yEopKD9axShqPP8UNXb+5FZPZbKB
	 Kq9OIGNpALC6HWVOEfqq4y9gz1AXRaMKF1FF5BKCpweM5TF3SrPsbfIhyUffpT+71Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=b1up1oCF6qzRTwv6vvBBSZW6ICBIiKGkgn9Tp8EvIiA=;
	b=RNd68r4a8nNMKK4GIJq1cfk4R45IXNckbE8Cb1KYIAe7/PEzqrhakw3EiNKv0TfeqmNw
	 Rsmu1LHVO1DmiSlwGwMmjQkfp/z734mBj0kdbAK9H2RUPmbGWJ/N4ZhA2XnrNvS2wuuTq
	 TPH/0tFxKoPoziOOJj+4g2u1MK7UTsBZCRjtutZZTgZxsGCmZcazUT3XGs//NZWoPHwc8
	 ch+0rH2AVoDQgVVvFVYydFPOTOcJ3Dt+GPxm6hibxhEkPQcwcdKV3sLr8j1AsosA3hAUv
	 kHGpJnBKjJwRdmgJv9IlE1i6gWbOj7qSliGraVeZEUS5WiltvJA6ms63f/xHG8QFn2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=L+ZuswBv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E15606A326
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 13:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28E15606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=L+ZuswBv
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b86bbce3d1so6040981a12.0
        for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 05:35:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795527325; cv=none;
        d=google.com; s=arc-20260327;
        b=TeoL7MuPryt2UcJr/tdOb6wwGJosRUZB+phYLR+zsGJVln2l+3jUTrd/MAcOeVD8oe
         j/iTlbeU+I2mWJjhgn/QErxx33fZPWX0x9eQ3zKHoGhR9wP6vnmBUAFcr2/GeHXb9TBD
         bNRwUXSQkaZ/jKd7xXDCmcac/qxFHcI1cw8Z4ksLlQlNv8oIpwbaX5CSKwYlcJMOK0yi
         oWWK12WpGXBiPVXDVBq6Lcw8tTK8+K8NgLsJ7qtbHZ7SgWYiXzTCKZxvltKQ4phflqQl
         rJu8/eBaBcl1OrQC2HlvTdvBTu/c0GCsb7HZZX+bBUdrbOSOoXdB0KQjVCpP3OIk0O8m
         1jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b1up1oCF6qzRTwv6vvBBSZW6ICBIiKGkgn9Tp8EvIiA=;
        fh=bslMO+KFils2EZO3pZk54e04l5XaOMxoc8tsnHVlexE=;
        b=OOG12Um2bVN4U1fDRuK3ITVy/cbfRTo3PjojxDCpsVvl2Kh7hKZYVT9uYZ0zbme0rR
         1WuKjMt3ol26L8oKTLrofveMF0b5l2eTaOtmGhLT2YEMSMV62xgQVgQgZxWGbuMc+IbP
         FPdwWY7esTXFVa9dDIdO9HmMBJU857RCKD4s3lBNwiHT9cOuF/HjQ8+BjNHiy9o85a44
         oZo+pvlkCXa0HmzDseJLcurN3IBwGVhLlU/zolU+akgD8lSohp04d0SljGMc75DdDXCv
         Krv2mtdMUUTDehEcRVvy/pvpTmC+n0ZBHASMucLo0oBl700NJnwKBZ2GDq+ur/oRagne
         eMBQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795527325; x=1796132125; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1up1oCF6qzRTwv6vvBBSZW6ICBIiKGkgn9Tp8EvIiA=;
        b=L+ZuswBv00mmVRrqpROqEao4McJM73eotBm1HraOC8Z1D2TyhZ1GT9h690Mq61L/Gw
         7bmJ98OYxjesZ84+dCUei6KrmvViAtaAh2Rd9iOT4L0vsces/F6ul4rVpHT1WwD6ZpeZ
         7uEUXVw/yf0Q41bMPt5cW1YI7YGb4q9z5bdPhYvUAlBpItRKeU5VgK/eYnZcBqmRDL0r
         bkHao8UyWW9MfszV5kHW+jSzf+L0wx5bHgHn5oJMlO1DUHqKZeJ7Q+0FnQx/8X8C5utB
         iVoHXNy6TGMnG8q2iqawdE82j1i6vr3AoURAcLVt+WAQPobJ7KGUgFDrmeN4UEKfYxj6
         jkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527325; x=1796132125;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b1up1oCF6qzRTwv6vvBBSZW6ICBIiKGkgn9Tp8EvIiA=;
        b=Au0c7E6qD/ke3DR8Fr2gBqyrykS3kCgIbfycBp8CVw1U/dLdoK6OqKL1blT0aZd4MP
         P9GC5oCGFQ6W9xBBuq8zakxQIWD2U0A4urr8HtDnluxtKZJ+I9uy7t249uuBWbuRNCa6
         6h962jyq8P07nisQgCopyXif3XX5dPKw/smwGWDkLG7rVBTqE0+8uS5uWc23q74ul6Yy
         6iupH80OVC1O71/uNVZCmWLysuQS6zuZ3eLg73WjiJPSWKiYbGrqs+OciYebonJXrjHT
         pjJOYUlWo6NjbIQPVmNm1uCV1lVCjf8s4ltqmD3zVtaq+l9Zx4/2Yy6e+8H+z/70UrBp
         Aj+Q==
X-Forwarded-Encrypted: i=1; AL+hErHsy4b2llaZRekumwMyFG/Jky/DI07MyDeBo6YRk5xNZNSjEatj8B3XyfhCTBfIuFUhs2UOdlyT31I=@lists.linux.dev
X-Gm-Message-State: APuU4Z8F22e2V+Bs4lgtaawsk2Wr7g871LXliKik6lsImqdLc0A/SHuW
	5zD4FTfKZlEwshIedB/qk1rqzkA/5dSAyytiuyYwbCUFk+5TkclmcHvl1KQCtbrhqL+mGnIJ9dI
	Nc7fvWv+zc0zCsDyxygSfixfrKZaexxSkhR6vN6q8IA==
X-Gm-Gg: AZFdTZdBIlaPgelCBKRFeNi+AXUtDvb7gv3KLOoRav2HxC6eCBtJLS/xQ+Qi7XG63y2
	MTi+KSSPDq5bkrWXMwqdFdoblog5lu87m0lBhwu0ZjeTOO75ZVPFolkaKE8TC9SJJsy6oylISRi
	bO0ow3BztvqQvDODzRJnc6MSX7goo4ckgbQzWDyXd2Ff17BkIAmDT47ozyErj9aNUIuuqFBqvWh
	/Ct/HyMCnOAQdFFMGVc29euGHsCISmcSrocLJaFC8nSkLuhIcwn9of9b63vKVD7XPmNTl0Q8gbX
	NSk46O3bzszxfOSGB34mE4Qu0A6ezFt2n52BTWzpy+6mbuoQ9mbqXXwMy+xs83MywfvysVxXbDi
	biFTZ6c07yJEENvoMdM14/H2FpWxUgAzRHI096P2iurlYGyJjbDjcWTvOONWBAzJgQCIu2g==
X-Received: by 2002:a05:6402:1c05:b0:6b9:c43d:892 with SMTP id
 4fb4d7f45d1cf-6ba37c7bebdmr7896114a12.1.1795527325503; Tue, 24 Nov 2026
 05:35:25 -0800 (PST)
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
 <cover.1795462673.git.penghuang@google.com> <2b1ef28e12d12a1f894827b951910c1979d54d45.1795462673.git.penghuang@google.com>
In-Reply-To: <2b1ef28e12d12a1f894827b951910c1979d54d45.1795462673.git.penghuang@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 24 Nov 2026 14:35:13 +0100
X-Gm-Features: Aa3M54r_GuyHMOfbhsDgXKslUX5_bNC9UFQqsD7NbKjR0P0AP7-nwsbW-9M7qek
Message-ID: <CAKfTPtAkNzqFbNsw2YKoNCsqzpC0wEs_LTrV0S_TU-FvDPu21g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext, sched/fair: Drain blocked load on scx_switched_all
To: Peng Huang <penghuang@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 21:13, Peng Huang <penghuang@google.com> wrote:
>
> Tasks that exit or migrate while sleeping queue their PELT load and
> utilization in cfs_rq->removed rather than deducting and propagating
> immediately. When scx_enable() switches all fair tasks to sched_ext,
> switched_from_fair() only visits cfs_rq chains that still hold live
> fair tasks, leaving unvisited leaf cfs_rqs undrained in rq->cfs.avg.
>
> Once __scx_switched_all is enabled, scheduler_tick() skips
> sched_balance_trigger() and fair_sched_class is bypassed, freezing
> blocked-load updates. Stale rq->cfs.avg.util_sum can then combine with
> active RT/DL util_sum in update_idle_rq_clock_pelt() to exceed divider,
> inflating rq->lost_idle_time and stalling rq_clock_pelt().
>
> Export __sched_balance_update_blocked_averages() and call it on each
> CPU in scx_enable()'s per-CPU scx_switched_all() loop so pending
> cfs_rq->removed entries and task-group propagations are drained cleanly.
>
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Peng Huang <penghuang@google.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/ext/ext.c | 9 ++++-----
>  kernel/sched/fair.c    | 7 ++++++-
>  kernel/sched/sched.h   | 1 +
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 10de6bd865e8..f7c573092e17 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -9013,11 +9013,9 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>                 static_branch_enable(&__scx_switched_all);
>
>         /*
> -        * Detach the fair_server bandwidth reservation now that the switch
> -        * is fully committed. In full mode (!SCX_OPS_SWITCH_PARTIAL) no
> -        * task will ever run in the fair class, so give that bandwidth
> -        * back to the RT class. The matching ext_server attach already
> -        * happened earlier; this only releases bandwidth and cannot fail.
> +        * Detach the fair_server bandwidth reservation and drain any
> +        * remaining blocked or removed fair load now that the switch is
> +        * fully committed and periodic fair blocked-load updates stop.
>          *
>          * In partial mode keep fair_server attached.
>          */
> @@ -9028,6 +9026,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>                         guard(rq_lock_irqsave)(rq);
>                         update_rq_clock(rq);
>                         dl_server_detach_bw(&rq->fair_server);
> +                       __sched_balance_update_blocked_averages(rq);
>                 }
>         }
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f6c3bbb19557..f19f498e01a4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11655,10 +11655,15 @@ static unsigned long task_h_load(struct task_struct *p)
>  }
>  #endif /* !CONFIG_FAIR_GROUP_SCHED */
>
> -static void __sched_balance_update_blocked_averages(struct rq *rq)
> +/*
> + * Update blocked PELT averages for RT/DL/IRQ and fair cfs_rqs on @rq.
> + * Caller must hold @rq's lock and have updated @rq's clock.
> + */
> +void __sched_balance_update_blocked_averages(struct rq *rq)
>  {
>         bool decayed = false, done = true;
>
> +       lockdep_assert_rq_held(rq);
>         update_blocked_load_tick(rq);
>
>         decayed |= __update_blocked_others(rq, &done);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 220927453a88..71a69f90e5df 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2977,6 +2977,7 @@ extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
>  extern void update_group_capacity(struct sched_domain *sd, int cpu);
>
>  extern void sched_balance_trigger(struct rq *rq);
> +void __sched_balance_update_blocked_averages(struct rq *rq);
>
>  extern int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx);
>  extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx);
> --
> 2.56.1.831.g720f3f5937-goog
>
