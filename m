Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FCB2D77E5
	for <sched-ext@lists.linux.dev>; Thu, 28 May 2026 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779936844; cv=none; b=av4gGR9AMcrGJNc5XahZrlhBp6/uNocq+CYr3p+8C2U4KZ4Ji//5HBpoLEFHQ6Dg2dtcEqr/xJ249SWUCTeIXBUxoK7BJp5ewh2mwFH2D8KvWgbxqaDZ8vJ4qo2pux+vsmdBJu2QqHUm620ZbpDpgIOPJ5rlSiLIcOPvbbVARMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779936844; c=relaxed/simple;
	bh=jkIF/uI6OpWbPs+UO2A/vqAqrubs6R3F1w7AqmosRkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vul7FvzibJKmRX3VUrGjWcmnBwaB4YQJxKA7sWm3q9Di68zaTfmiX+OYCB1chjo8kIFnGMl/Bd9z8ArP9VKEiz/xw2u4M12gbPT+p8x71JA+VdFvjUEHb3hs+h5cTjnivcNAE0L3RMFp+BnvcLxy+fG2Qb96+YDlJGG6IhKLXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWUQzGMY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWUQzGMY"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so7096850a91.2
        for <sched-ext@lists.linux.dev>; Wed, 27 May 2026 19:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779936842; x=1780541642; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rOvmruqBOQaVQQy1Yls1qWAcHtuLmD+8Nz7yrmG8Pg=;
        b=OWUQzGMY7E0/mdu/8PGd2DTLTBkhnyGGtPlDE1NWhMSbJ8im3LWh2igpji86TePm0N
         IZXb5cp/qYhZsWaenKroVJxxw7Bp5KwTVYNW1ZUBOHp/xE/QNgRpfPdCS4lDS+c5GacS
         ue/GUblPpjCfTmzoJoMYoEB8v7AWA5mIMsZn9kbQ3inrTe3GjD4Az2lDurf99Z0YTXyT
         6bmB1fmUQ8aMFOQ0QNuI/bVusEaAcAnT53eVAAMv7TFuL/PSKeWlRBK1044QVX+0rJwa
         9hUDUVnwscU/N9dyfygPTmzzZ38/JZuq+lfLpJK3NP7vZn8MSoVYnPsbCdY9VBBXDZvB
         ZP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779936842; x=1780541642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8rOvmruqBOQaVQQy1Yls1qWAcHtuLmD+8Nz7yrmG8Pg=;
        b=H9FRyrF5nH+lUF5nf2Q8E3r5fZSnghqv3usP0YDuzpMCHjxkattsor0giuk4Z+X78Z
         oX8B73B0AtcYICNf1tRjRrB+axvl6yEoarHlC7ZrSZPsGPaDgmzBKiOSUju7Rgk5FN42
         vJ8CqvqTQvqeX0mvlu3xine4WxYOQ1t0z3EOR7INmH88FNrLKaV1JHO42713li/AJF8b
         WiAw0q3s0fEkwobQxMWzg/1qU9RqC7OIOYB+OFYoNeu/+3i/YmKi1U744PMe+b1QnMfd
         KFfoU93ptqqkto7IVp2qXo4ndmGFEYiXgMbV9uGg1/2Azc7HiLhst6jHb+gpUcq7ez0f
         A20A==
X-Forwarded-Encrypted: i=1; AFNElJ+w2/vofqXFrlqueqJnc0o2b3P34mVEMKc/QAbr0gbp92Hf70WCjsEDjrJdeNeSZWs2Myj0FZeE3Zc=@lists.linux.dev
X-Gm-Message-State: AOJu0YwzlxN9evA9n2H8o4IVmXBIEFSSEffBu/WZkOymS0pJSFenbJXO
	kSXfuzguTNs8lBsmMpz11xbcH8MJQaK+nt6j5tM8CU50+AtgFxxKz6pU
X-Gm-Gg: Acq92OGDYfR12pO3fdyfjXzQ3nhKs+OrQHjdmlw9eTQTYHM4H6SUHrO0utYEVZsBADH
	rWzPGcnH47S76YBqw6CRuze2AnIadzSvuOyyzsUadGMkRUydzdTwgCa3nrN/JJvtDx5SaDt/ZNx
	fDasO/UfYKh3ZlEfe1RT7A3WpHt0GwGv7UWJ5X29riz4GmdruF8g3seT1DajnDsz/VKt+caX0sO
	sFceTabR8AH0ZAbJR9YnRDFSrTkYA1T4BhgOcsA6MYok+A0CaIDueaU6ABwg6lwpL0RLNEeJfNP
	Lg0Tw+TZezX7/S8roZD5NOmge7LiLvIr1PQ2xI91RqbvLvCpBlT6G7+nQCa/2NCtawJS72mY6Iy
	jF9Txl+sN5eHQsy9NOFoKrR29DVlYPVqFvoGvxTPvo1nTefwr1EDynZ7lH0+cO+Djua+09uZ4Kd
	QJhjbKbyl/cBqfqR6mwtuiT0B7saNpQDZYZ6KyFWCc+fvKb3EOGpZNRmU=
X-Received: by 2002:a17:903:1245:b0:2bd:8c9a:a684 with SMTP id d9443c01a7336-2beb069c63cmr287081535ad.4.1779936842216;
        Wed, 27 May 2026 19:54:02 -0700 (PDT)
Received: from [10.23.182.65] ([139.159.170.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b3058sm171402855ad.39.2026.05.27.19.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 19:54:01 -0700 (PDT)
Message-ID: <3c258a36-2b28-4221-b2b6-776a0b1693ab@gmail.com>
Date: Thu, 28 May 2026 10:53:54 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched_ext: Rebuild fair weight on ext to fair switches
To: Peter Zijlstra <peterz@infradead.org>
Cc: arighi@nvidia.com, brho@google.com, bsegall@google.com,
 changwoo@igalia.com, dietmar.eggemann@arm.com, haoluo@google.com,
 joshdon@google.com, juri.lelli@redhat.co, kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
 quzicheng@huawei.com, rostedt@goodmis.org, sched-ext@lists.linux.dev,
 tanghui20@huawei.com, tj@kernel.org, vincent.guittot@linaro.org,
 void@manifault.com, vschneid@redhat.com, zhangqiao22@huawei.com,
 quzicheng315@gmail.com
References: <ahXWaL2BYLU6ukkO@gpd4>
 <20260527094037.3494671-1-quzicheng315@gmail.com>
 <20260527112624.GT3126523@noisy.programming.kicks-ass.net>
From: Zicheng Qu <quzicheng315@gmail.com>
In-Reply-To: <20260527112624.GT3126523@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On Wed, May 27, 2026 at 07:26PM +0800, Peter Zijlstra wrote:

> This is truly horrible. We have 4 class methods involved with switching
> classes and you stick in a random call in a place that is called when no
> class is changed.
>
> Would not something like this work?
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 62a2dcb0d03e..a2eb43bd73b9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -14957,6 +14957,11 @@ static void switched_from_fair(struct rq *rq, struct task_struct *p)
>   	detach_task_cfs_rq(p);
>   }
>   
> +static void switching_to_fair(struct rq *rq, struct task_struct *p)
> +{
> +	set_load_weight(p, false);
> +}
> +
>   static void switched_to_fair(struct rq *rq, struct task_struct *p)
>   {
>   	WARN_ON_ONCE(p->se.sched_delayed);
> @@ -15351,6 +15356,7 @@ DEFINE_SCHED_CLASS(fair) = {
>   	.prio_changed		= prio_changed_fair,
>   	.switching_from		= switching_from_fair,
>   	.switched_from		= switched_from_fair,
> +	.switching_to		= switching_to_fair,
>   	.switched_to		= switched_to_fair,
>   
>   	.get_rr_interval	= get_rr_interval_fair,
Yes, from the class switch point of view, `switching_to_fair()` is a better
fit.

Before v2, I was weighing three possible places for the fix:

1. Updating `p->se.load` from `reweight_task_scx()`. This would keep the 
fair
weight in sync while the task is on sched_ext, so switching back to fair 
would
not need any extra fixup. However, it would also make sched_ext maintain 
fair
class state even when fair is not using it, which does not seem like the 
right
ownership model.

2. Rebuilding `p->se.load` from fair's `switching_to` hook. This is the most
natural place semantically, since the task is entering fair and fair 
prepares
its own state before enqueue. My only concern was that, for non-ext -> fair
paths, `__setscheduler_params()` may have already updated `p->se.load` 
through
`set_load_weight(p, true)`, so calling `set_load_weight(p, false)`
unconditionally here can be redundant logically. Functionally, though, it is
harmless.

3. Rebuilding in `sched_change_end()` based on the old/new classes. That was
the v2 choice because both classes are available there, the task has not 
been
enqueued yet, and it covers both `scx_root_disable()` and the partial-mode
`sched_setscheduler()` path. In hindsight, though, this makes the generic
sched_change path handle a scx & fair-specific fixup. That is more awkward
than letting fair prepare its own state in `switching_to_fair()`.

I'll respin v3 as you suggested.


Thanks,

Zicheng

