Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465200;
	b=MGLwCJZH0nYetgBY1HuczUBmGXhT6MHhn0tNO0dqKX3vPcrL/Vl8K3lXohFmCWnDmbyx
	 UyMXZSziVKeJfCLhxX9GOTKtpsCm3EXudggBsoMG4Sy1wNa+sYh7Gp83P7Pl7hPDBrX3j
	 7q1bU5AfND0XinXWScW1tLTjVuMEEThBMrwgbqVuos6M7JyTVVmIN68onB8h2f91WibQh
	 eaBOxitW5MPYRIc8mMBErgbArNPGr0bbmoYKNqeKp1SSEp2WF1NBr68eR2FLY2rsK/96g
	 K/wzxFUz0fN6TX1gGL1aFCgm5xt4pBblJKc0aw4ANFdkYbjeV0axxt971RWcpWzIahw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RUQ8/mle70/OoJSe7E2/7hmZoUcB7bVUUwPl6zEwLxc=;
	b=M++8mOTZX2zWfGerhIZnYmkXGRmDVVUXUtKKnXzNDCrFqxYmBsb2D/qdDQTc/0MeN7AU
	 eAy2GoSIeWqv5CZYz8/jkFu3kZYmGnsYJjld9Kvqz/1/sGU+/4e8Armglfzfkg3isGRiE
	 z0YjHMwhHC4TYDDJUvRWUa9CB/GCoVpeA6hKWkLyBrCYqWdFp6T97FcCIU7F+kltXLRCj
	 k/GeFRfFn0kXKEKN6VS1156qpL6e1pQiVORPjRGMfu1W65Mh9SQYqaBdJr9dzQS5iSoSG
	 AZQMNUlkv19QxBPAeMzg9uRf0EzA9JXbc0ADOpQJnX/QCwxqgLxfPt/iRVKJscyUCVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=irP3nzR8;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D4606A31E
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 20:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 586D4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=irP3nzR8
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so6028196eec.1
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795465199; x=1796069999; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUQ8/mle70/OoJSe7E2/7hmZoUcB7bVUUwPl6zEwLxc=;
        b=irP3nzR8K/g2T1jBFG9tDcCHp6tUQYCL7Ct/lL8qJ2ypEPVyfHZA1fvheqlkgHrYNi
         nneH1FfPrIAEvlLY2R3SkKqBm0enUvFrAjEwRJ+mfJ2zLLXVu0ChEnRFgT/hY8dkwAMx
         tqsBN+unS+/LrZtz8eHeGEphBUyZlDrZ3EY4wR1w+Y3mUFPXEoM3GhCQUyESnmjsTMNg
         NqlE3JISpZaN0zD8StcgD2sgDuZvzulZDkPWKUaS4nKDkvH2ipBAu9vAF1Z0YpYUQc4X
         8hwsgsAWX7acsnubWDnohntgvUg4uDmFBsLnRrH9aEa5xwff/FtFz26lJZuOzkq90NOv
         JR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465199; x=1796069999;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RUQ8/mle70/OoJSe7E2/7hmZoUcB7bVUUwPl6zEwLxc=;
        b=Kgu7fHhTwpNzxusrKjuXl/szEoWJ2uurGNK6Fu7lLOCFozcnBF2AMrsQ0HWbJAlh1e
         MDo2iqF5UGd9jornqJK8MOHC6yjcFwM6wKx/D7BY7/QJvHX+2fWnCHjPg/FrK1YrxQLf
         gNWlILpV8yO0zc2VymJYZSSF9ZrcKcjCLIob/a9v+WuEA0jOFqTWa677/1kp/v6UKaCl
         wlIIuUTa4L935CzNBuesnAfYyQpN/ut7syOQSZRYEczIvJbjGjVhBSXct7RsCqK/MbDB
         ZEY4Ly530yyZjmHS9W0aYRS6wM5MQ5OcWbh5zjFlc5Ygd0nVXfbAkTHc/ecvE34ppKAa
         LMdQ==
X-Forwarded-Encrypted: i=1; AL+hErHgw7TjqHhj3myManwqpHJ5HeZzKcdasfIRlM0FWPcQ96VyepC2rHg4gB0bVDBq/H5upptzTjHDH50=@lists.linux.dev
X-Gm-Message-State: APuU4Z9Ebr+T0DGXL2J9kuS+9v5AiLRDNisSobG7koElsQ2h+pVyemZO
	lqDZcOGBkCRLdgBsVHaoaroSeTgZxcFUkMHnPm/Qj0wfxUrEM7pwNf8LArmF42ZK0Zcv9o5hiat
	ID1KOXSvnWRcUgA+FDg==
X-Received: from dybci24.prod.google.com ([2002:a05:7300:a498:b0:37a:8a0f:3aba])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:51f6:b0:384:7b4c:8564 with SMTP id 5a478bee46e88-3857131a749mr14683264eec.41.1795465199126;
 Mon, 23 Nov 2026 12:19:59 -0800 (PST)
Date: Mon, 23 Nov 2026 12:19:58 -0800
In-Reply-To: <06baa96f105bbe10e6283e908f1240cb@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261122033316.2819845-1-penghuang@google.com>
 <20261122062121.4172437-1-penghuang@google.com> <06baa96f105bbe10e6283e908f1240cb@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261123201958.3988584-1-penghuang@google.com>
Subject: Re: [PATCH v2] sched_ext: Update other_load_avgs on set_next_task_scx
 and idle entry
From: Peng Huang <penghuang@google.com>
To: Tejun Heo <tj@kernel.org>
Cc: Peng Huang <penghuang@google.com>, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, sched-ext@lists.linux.dev, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	haoluo@google.com, brho@google.com, joshdon@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Tejun,

On Sun, Nov 22, 2026 at 11:47:04PM -1000, Tejun Heo wrote:
> I think this overstates the staleness. While the tick is running,
> scx_tick() updates them on every tick, so they're at most a tick old,
> at idle entry too. That's already a lot more often than fair, which
> updates them at load balancing intervals.
>
> update_other_load_avgs() isn't necessarily cheap and I don't think we
> want to call it from scheduling hot paths. If anything, sched_ext is
> already updating them too often and we should pace it down.
>
> The actual hole is CPUs with the tick stopped, where nothing updates
> them, and this patch doesn't address that.
>
> Also, how was this tested? Is this from reading the code, or was the
> effect observed or tested in some way?

Fair points on all counts -- calling update_other_load_avgs() from
set_next_task_scx() and put_prev_task_scx() adds unnecessary hot-path
cost when scx_tick() already covers active-tick CPUs every tick.

To answer your question on testing: on an Android 6.18 setup running
sched_ext, we observed frozen/elevated avg_rt in Perfetto traces, but
the actual root cause there turned out to be idle rq_clock_pelt()
stalling due to non-zero dormant rq->cfs.avg.util_sum (discussed in
the separate sched/pelt thread). This upstream patch came from reading
the SCX_RQ_CAN_STOP_TICK code paths afterwards rather than an isolated
reproducer on mainline.

Let's drop this patch. If we later observe a concrete issue on
tick-stopped CPUs, we can come back with a targeted fix and benchmark
numbers.

Thanks,
Peng
