Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795430103;
	b=hHT7ytceTIBSKImylQ6lnM9d+NH6IJAdM4cOA005AvUeXCLnD9g35deVNjaUxgASzg4L
	 Vbbi1wJpxf2Ahw5jawI5dT+++bePk7ZK4uN7qnhMrnJagtVTH9vQhi1Zd43bAo8TmDYFM
	 lnhKysSasfv+RM9HUSmcptxChlYwBDBW0WZefJ5W6Dk8cOM2yLwEdm0Tb5UugyuPO3ANJ
	 4Hno0NAwnqtBJIXM2lVXHVi0aTG+sexPzEyf2joICniXFl/ZUZErVJmzZ0wwlfaQzOWYQ
	 xPFro3G8uaUx45NrmZ5WqLWwm4E0pw3SyrtH9gJZSTM1+ZPpV8M8Wx+tKbjWC9msjxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=FkLm2QDvo0RLh/Me+j1f+/tll97oLAwEndJ2bmbVDp8=;
	b=T3+ohJ1xaww2JATnhAGg2CdR4c3xdcT8Yp8iZ0oNS+ye8Ixxtin7YXXCZYDcbhYu5fpL
	 vX36G8f3ywnuRKvXrjwbYm2CtBMyfv8Cs4r4zFHQlGgVVAIMO6B0ZfneVpY5gS/ua4dlF
	 eqtU2bWKeDw5ve/X4J28Aq+iUE7m4HQl8sslhXM0Aa+9c2koIPSwCqpccBCGCuavLohkO
	 U7rFOr2duqqW0wyfMDny8JzWu/fmZjLqGcn36zRZ0h9p4GjgUu3T7+hRd0MH0stfvsEVU
	 zbthqYyXuCl5tAMq0JvrtrtPTtv2RAxcHPvJSEHaiGJ1uG6MtDTxXqSb3beOMS3HnCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=whbCRWOj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC07606A31A
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 10:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CC07606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=whbCRWOj
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6bab10842f8so1454449a12.0
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 02:35:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795430101; cv=none;
        d=google.com; s=arc-20260327;
        b=EW5Aaob5gqXnmqrAcyBa1u3h0JAeiKiDprVcRxA8z8QLVgSAtZ7+nPMxpzV3K+onZq
         545qAprLSb/7+hZKMIDH95fvZRGD2Nxo5my9bdMMMuRjvdd71tGGqCypLLrtJ/TvqWkC
         SyHWfCPSgWF5k+fNRt+msdcaswImMdM2VmzHNSE9yM+KGKjBtApU2xF2fhG0GKhpa9vm
         OVR1k6ORa2hoUblNZjH/N3+nba0YCwmgqcf3xM8tQdI9WO0AjS2McycOc+Wjg/dQ/ENm
         Apbpz0J+cBcQDbkCnZjUKl8kAH1kP7yDN8PzXTmtJkoqVwVeX75bhARZhw2F76aFdmYH
         m4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FkLm2QDvo0RLh/Me+j1f+/tll97oLAwEndJ2bmbVDp8=;
        fh=QVxQuDk2F4xczyTwBZOqBWO0eYvyUDQ2GWh11BR793Y=;
        b=pJm/VtjYrfqkRGPpL2vZFdI/M2dQpCo+B/RjXHqasd8txDXjg5/kQj5znIRT09Ljts
         oF/WPDhwRizfRqEegmhoH/KLDkbTdzs6ziHwUa2KyBG0mtsW3rq82CFn+H9tmF3qYT9D
         GhvhX/va4rw2coAg8xy+S1V6crF3wyz3hXIMq+53GowPd1SJiAysfMx1UExBuR1Daqnk
         hITPFt8OWTTAXU8tik5GRmz2PCM6MoCMV1fE2C7pdtBYEKrkOb3un2Guadny8IM21j9b
         2qhLJ8Fp00VXeepRwt4/xYSYXaBZqkNs5rFfb+O9l92psuGQ7dFKf58TMkYtbjE79UV5
         j/gw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795430101; x=1796034901; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FkLm2QDvo0RLh/Me+j1f+/tll97oLAwEndJ2bmbVDp8=;
        b=whbCRWOjZWCa9wGU2so/MOOjPy1Id20hwT2Y4WRneUt60zYOHjil3tKaRr9izMCxG6
         4x/9iMgqBBRljkvAmrQWnsWiDfvYHxUQZ6dG3VTOpCvUSmtq0W1z6pa60nodRqNk6NWp
         kEnJ8/X0D3OabsKndk3lTY4SM+rQEqCEeFm5gXcodKQJfq8YtUMS1gcTQJ7jMbUEbGo3
         IslFiCyGT3oEgQTRSQSwEuOp6+AxmVnq+MphIdO1lk3B/+l0vlemdCsl1wxZpEuP6hf8
         McmR/ZX1NyVMfoGnVLV7zoWCV55kNiHPLLWTcKlB6LfD1hUqxB6vZ7fwnxhMGdv/E6KW
         WuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795430101; x=1796034901;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FkLm2QDvo0RLh/Me+j1f+/tll97oLAwEndJ2bmbVDp8=;
        b=QDJQtdSOCaBHu1ZEu1G4u91qB/EE7iC6QBZRMzZXqgoV/qm48YqVygw9dn/biPYQHX
         XXGY7XymzYIbza2qJlNcpXM2257Znhqu6EzX7nqOJ4XUTULHg7LwLg/4MvcVG9DCFBSK
         IdkW4fD11QgfHS5hqrnA9ECf5y729d8p0oUL800jVabmTj+0yXbPE2pTJmG/AGp/C+tK
         ErxJZMOUR9sgK4Ztnq12umLl2xy1KKx0Dt1p5qs1tZVrh0jED4xzb+/10hYBmTBQJ+fb
         bvQSjTwIRC8QYhwKutJH3AwhrgBhwbL9xBqwwl8cCrBQf+5MWI8EYRs22PN/Idj5G834
         +hiw==
X-Forwarded-Encrypted: i=1; AL+hErEDY/Uh6e6plJowEtUtEqpDEdZQyV1hBxYLidWcpdnIIQZYMn6jTbgnjhdbviX1I5Q4blo+EIYgOf0=@lists.linux.dev
X-Gm-Message-State: APuU4Z+FNxL2b9fsGkOE+mm5q2x+v2PCjD4KEbl9NT+R3DKTYb5L9nZB
	HSNbOfZPK0pusV0z0cDNBoRpCy/r0yWWYCTvtnTcBsL3ybJzpMftJpk73l213C2ppjkTu6TpXZU
	lSihrQmu0iSAP+J40dpGpHwGt4awr8PGySKh0ib3hUA==
X-Gm-Gg: AZFdTZd6LvE6L+bH0QdDcbX5wvMiLuYbqFbwVHvgHaVubvohzvelVokVqQshQ7hGIbE
	OITTCtTgpcZRcQ7sku61wWDJnMfpXACge3HqZ6TREEOyFxp3WaBLXSg2qjTE6oe0SXwRo5eWT1u
	BnHWa/THS0fYpn1ST56QAkfFKzukyBVSaSg1Ra5PhE5e84W4H8ySjXnPkxnxpgF5A1XuufGXXtV
	GNs6tZr4JP8TmHRgIeQC/otPgxj6ZDh2AutcDFqpo85HY8lpe31pu0aC4dFj5N++dMeIgQoti3r
	PXgVhZQiHqPj+WFTe0RxHXeWgtV977Dwsd8+MJEtz99khpC7YF4+HmIDlI0Zs0jGbIFwvCGYHzf
	FGLgsfk/f5t4vTRcP/DIPvh3nydZZ0nHLXxou06YOS77CRfh4v7Jf+IOKJKd41KFnCJ0SWA==
X-Received: by 2002:aa7:db47:0:b0:6b7:aca7:2264 with SMTP id
 4fb4d7f45d1cf-6ba37e6980dmr5721448a12.9.1795430100790; Mon, 23 Nov 2026
 02:35:00 -0800 (PST)
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
In-Reply-To: <20261122015729.2512645-1-penghuang@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 23 Nov 2026 11:34:48 +0100
X-Gm-Features: Aa3M54pS5nfq3tiUm_gWyIlrBynlKLIymvZi5sxhT7ewjNFDS4BdqeJJrs3PYqU
Message-ID: <CAKfTPtCQpVhtVT7Mhqe1=Ukcmc1pX8Jgn9ypb64--8cJ-7G4BQ@mail.gmail.com>
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

On Sun, 22 Nov 2026 at 02:57, Peng Huang <penghuang@google.com> wrote:
>
> When scx_switched_all() is enabled, all fair-class tasks move to
> sched_ext, scheduler_tick() skips sched_balance_trigger(), and fair_rq
> scheduling is bypassed. As a result, rq->cfs.avg.util_sum stops updating
> and retains whatever stale load was present prior to switching to SCX.

When all tasks are moved to sched_ext, fair utilization should be 0

>
> When a CPU later goes idle, update_idle_rq_clock_pelt() still adds this
> dormant rq->cfs.avg.util_sum. If stale cfs.avg.util_sum plus active RT
> and DL util_sum reaches divider, update_idle_rq_clock_pelt() treats the
> rq as overutilized, continuously increments rq->lost_idle_time, and
> stalls rq_clock_pelt(), which in turn freezes RT and DL PELT updates.
>
> Exclude rq->cfs.avg.util_sum in update_idle_rq_clock_pelt() while
> scx_switched_all() is active so dormant CFS load cannot stall idle
> rq_clock_pelt().

This is not the right solution but a bandaid to hide the issue. When
there is not fair task,  rq->cfs.avg.util_sum shoudl become null.
Please look at why it is not null.
It could be that the update stops before everything has been
propagated correctly in the task group tree

>
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peng Huang <penghuang@google.com>
> ---
>  kernel/sched/pelt.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index f921302dc40f..6d31e1fbd094 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -138,7 +138,12 @@ static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
>  static inline void update_idle_rq_clock_pelt(struct rq *rq)
>  {
>         u32 divider = ((LOAD_AVG_MAX - 1024) << SCHED_CAPACITY_SHIFT) - LOAD_AVG_MAX;
> -       u32 util_sum = rq->cfs.avg.util_sum;
> +       /*
> +        * Under scx_switched_all(), CFS PELT is dormant and may stay stale;
> +        * exclude it so idle CPUs do not trip lost_idle_time and freeze RT
> +        * PELT.
> +        */
> +       u32 util_sum = scx_switched_all() ? 0 : rq->cfs.avg.util_sum;
>         util_sum += rq->avg_rt.util_sum;
>         util_sum += rq->avg_dl.util_sum;
>
> --
> 2.56.1.750.gf70dc682cf-goog
>
