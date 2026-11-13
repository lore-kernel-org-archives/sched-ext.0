Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794566958;
	b=TbRBcl3f5AYTu4cfpS9pkH0G2bqqFSz6yyzIHlY1Q8wVLahth48CQFddC3K+5f25VFaD
	 ct9xfI25TBbv+cMSkufeNpxG5hv9gfK5J9sY5VwLscOyI9cEEl4DYe2exXAhkPQGAntL5
	 93LgjgZiHWXXtRMkJ5PsAnRCcvxV22KYCTdX+7RrdRQM2fDH27f1BRlqV8doh04eLyi7R
	 xpHhcEgZGixuTkaHbYGmdu9Y/lVIumi38RgFVNl5ve7BOFJQGtrz4VVbknhYdlM1CLSVg
	 IZZDH5StZ7wfa6Eo2GJ6WMUFk01O3Y+TrHJILCnZwiu/rAL8D5ndqp2GUEl45PF6FCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=JTfJbS10SAhLayZBK7QayKezkLtHPNyapi94XEiP8bo=;
	b=pGPB95oJ1OmQ6PgyZgOqrhgegqHipS6/xW4Iq1rIS7NKtktIm72yydvW7YUFyuUJUN7U
	 Lr21AQOPk8dDmvzAUzX5UlQ660RGdgt29+LBhx+Pi5gWcNnJYO6GxEEbW4eXtzh+HAPXt
	 esx0k3JzPRKmUyqRDQnSN8zxesfMzntw/ZGsSK9+lNfRl58II/QEjlYaGDnuRXaz97abc
	 BgNoMcUUMQrzZakdGICf8EUDToI2xzRZ0pmTzoNoodyOBK7PUYZtmB1Re/IT/GOTaDvA4
	 YJN+I93Qyrft/mhiQ7ceSt6oU6/FPIU/pI+T/lnU0T98dHHwcB3QIncUgwrIte8xUTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FVuv0iQR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2AF606A330
	for <sched-ext@lists.linux.dev>; Fri, 13 Nov 2026 10:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E2AF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FVuv0iQR
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b5973a4b4cso1553300a12.2
        for <sched-ext@lists.linux.dev>; Fri, 13 Nov 2026 02:49:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794566956; cv=none;
        d=google.com; s=arc-20260327;
        b=RfSdsZFwGtsSOLMNd3H0GIXKzYwato2DZUA4GnOL5+BVcdzkD9cWt2Wd1SYjmwXh4/
         Tb4UpSUab3jnrmF/IacK2oiBflYDiq26lyp8Imo/UwFdHEZ6NmUO74jHXHyje/mS+pRw
         +4hc1vcApsfaMngpMfa+2BsFPPQ9ZIgqiUEFCRvFZ90BxZVpbj3vKo/WsLfo3hCoZ06m
         atVefl1dTvGcEdUKJV8Ip/eIiYWvwIQxfncAomovlXhHxqrFIzTzxgW1UJsS8YgjoZly
         Jn4kIa/BYMmhS0xrlTpEyiBh9PtGn43BZmP+YkuwAqILVo1hS/21XSYuVs2UMcZCyXea
         2opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JTfJbS10SAhLayZBK7QayKezkLtHPNyapi94XEiP8bo=;
        fh=j7KZVR5UEdoKMFo13ltimhtY6IEg2yMJ7K///cV96qM=;
        b=O0zxVpMsjeSApmmmZ+kI1Sbkf8d35qvOlEbDK/mjKSNiB+3S12HvQ4phum5FdqlzwD
         Nw35AbVdFYg/8536KmLWE6lg7U18+jbKYlYAlF/TslkF21LZQhwkl6budbTwJprC1I3A
         GHWbyxK2LnXNxqxNgEhm862HmVykYpzARRVFyvQz1kyqKJHCPVGhLOJ3N9+NzOgw+6iT
         7oVwRs+RCB9ciWGsq6ntV1GyISlm4f0A0SmjcLdD7ekP2wPWkcaIiZSB74bS8yczDlv+
         oz+fl2rM9JZfX2kFHuGD96mVb+ztY0eQQLKCLRkeoIZCq0wrD+ZnX2g/rL/cHwlvjEwY
         iObQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794566956; x=1795171756; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JTfJbS10SAhLayZBK7QayKezkLtHPNyapi94XEiP8bo=;
        b=FVuv0iQR4D1t7THEy5/0PXcXG+OjPkoeWhder08Uhd6ITNt0BPJT1DTnTgxKnqlKvS
         87HdkQWrRoRVT93xAET8vZV0dWD9kwfVXCiRjggHCpuI3gDQNFzgitOVfznxBstBKYQc
         a3e7azP1STCXRz7SunfZCSKeJiU9vUnvT42OhQuT9IctjTYf6GuXb7pNNdZznvJr7cQH
         5+5UmZLgt4MMWF1gKrzhmap3ZOhCvRD0MnJJ2TlL1+FXiLM/jItT7jfZsui09fPEX4f0
         sU9ar23QwkWpCw6nCpiuxNtWVsv5OqJn7TnZspdozKU5SOYdI6G5KHOPEdbWDCsyIF7y
         TMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794566956; x=1795171756;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JTfJbS10SAhLayZBK7QayKezkLtHPNyapi94XEiP8bo=;
        b=TF8vCRpilFeR0BfNzUMZzWa2PyTSb0uYk4aYcBwLnRCdpZDIfJSOxqxNAiIJnljKMK
         jq6AHqN8c60bpFB08VK+hKWuGX21gpf1Cx1oPns4RJ84TyQev90wlgrbJEfBpV8w1uDk
         bsNfM43o7VVlYSyWBoDctv+Anl31weddFrAEzhBt/QvLPbFOnKhwu91PWxGULMidkO7D
         4sXN9SVYnv13xUQ4wXoXKg3+OY6MPSBiiXhvWZJczvLug7YOXJl0SX3jD2jj1PD9gnQT
         uzd6Cm1B9RIVRo+qZh6h+eJLVZWu2OOXPTS0rkZBvrLcOTMTBQ+4a5NM54F8f6+FAwle
         jWuw==
X-Forwarded-Encrypted: i=1; AL+hErFpvlaA1U6mi/zbJtpHdwNpKqeDG1KIvhRY9ykQWpDlkYqGFeFSJfkQevDFXvfeowtmJjemNspjxEo=@lists.linux.dev
X-Gm-Message-State: APuU4Z+nVbD8FDOXAUBrqXm4P6N4PnIcAWNQoEnk1GRxDDctrGgMXYkb
	LQOBDaoDSd/xeu3bu7kAGKLhejJsjfx4bCjsHJ3u+2pD3pNBT5UGKCzUMhYmjLesq/u5yj7phFU
	f/6L8vWSO7n2/rHvCYtwksNwMsXtKuzvrts9gY+ZwbQ==
X-Gm-Gg: AYBFou3nJInjDV/8nJBuOJoI4aN3p/DEjYXG8+6k+XS01BcklmxLMId/B7UBZzOKvK1
	YDPUq9WTjeaZq6FTeVhBhJDmbPpXIX+wCx0dgsSJSg8ly9bZATLkO4bAYNNMwDiUzZTKeb7rXh9
	VV+wfv0oTgHQSAElahLHR86AeB+ojqYmaUQd1ZovbZFhcOxwypZwaY51/CNiUlHyykuIiAuKyq6
	QDdY1F4iWRtKXE96GNdSswouOFB4Ro/ZpfJrGUFwrUNTeu+tJhlE2IF7PjKCiezveQ15AMRvbX5
	N6klqgWku8qB5Dnk0q3GZh91F4MK7/vLi2b5QCU4VIDq3+Rn0bJP+sjvPQcfkg9CNSWlBYWyaj+
	rddFmXV3kzo702z81/5tPdeqK2dTmYMFiIphl48qSMk0QvBh8uI31DPl3WNNN9/BDVvPOww==
X-Received: by 2002:a05:6402:e05:b0:6b4:2fb2:44f8 with SMTP id
 4fb4d7f45d1cf-6b7c0d1cabcmr1977930a12.42.1794566955396; Fri, 13 Nov 2026
 02:49:15 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-14-vincent.guittot@linaro.org> <fceb72e4-0042-249b-8223-f912f2a50d80@open-hieco.net>
In-Reply-To: <fceb72e4-0042-249b-8223-f912f2a50d80@open-hieco.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 13 Nov 2026 11:49:01 +0100
X-Gm-Features: AclHuK93LzBqjNugOvp7vsT1Zi6WPLqjO3BWR9AFgUHwCjO2r9c6gTAQV4RnDhw
Message-ID: <CAKfTPtBE3pU=71EyEfVRSbOBG+Y9itNEhfwd7svT9+JZhek-vQ@mail.gmail.com>
Subject: Re: [PATCH 13/20] sched/eevdf: Try to push short slice task on a
 better CPU
To: Li kunyu <likunyu@open-hieco.net>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, kayracizmeci@gmail.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 10:25, Li kunyu <likunyu@open-hieco.net> wrote:
>
>
>
> On 2026/11/6 23:19, Vincent Guittot wrote:
> >  static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
> >  {
> >       if (!__check_pushable_fair_task(rq, p))
> > @@ -10120,6 +10137,12 @@ static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struc
> >       if (next == p)
> >               return false;
> >
> > +     if (next && next->sched_class != p->sched_class)
> > +             return true;
>
> Would it be more appropriate to use sched_class_above(next->sched_class,
> &fair_sched_class) here? I think placing prev on rq->cfs.pushable_tasks is
> justified only when next belongs to a scheduling class strictly higher than fair.

class strictly higher is the most common case but we can have cases
where sched ext dl server preempt fair task

>
> I also wonder whether doing this in the normal CFS hot paths -
> put_prev_task_fair(), set_next_task_fair() is really desirable. PATCH 09/20
> already replaces the unconditional raw_spin_rq_unlock() + task_rq_lock()
> sequence with a raw_spin_trylock(&next_task->pi_lock) that skips the push when
> the task is already locked, which I agree is an improvement.
> But could the push decision itself be moved into the load balancing path
> instead? That would keep the hot paths free of migration-related locking and

LB is not the right place for several reasons:
- the period between LB can be quite long compared to scheduling constraint
- EAS disables load balance
- periodic load balance looks at balancing the CPUs in a scheduling
domain without taking care of indiviual tasks requirements. It looks
at CPUs and then tries to find a task on this CPU that matches the
constraints whereas the push mecansim is done per task so we can take
into account task specific insights like slice, min capacity,
preferred_llc when looking at a CPU.
- We want to use push in a selected number of cases where we want to
act immediately

> select_task_rq_fair() calls. Or is the next-aware context (knowing which task is
> preempting) something the load balancer cannot reconstruct, making the current
> placement necessary?
>
> Is my understanding correct?
>
> https://lore.kernel.org/all/20261020083746.37068-2-likunyu@open-hieco.net/
>
> The SMT push work in this patch is intentionally quite simple; I think
> it could be generalized with only modest changes to perform push at
> larger scheduling-domain scopes, such as the LLC (last-level cache)
> domain.
>
> I realize the push direction is somewhat at odds with the current
> cache-aware scheduling work, which instead tries to make cross-LLC
> migration less attractive. Still, I'd be interested to hear whether you
> see any value in a push-based approach at the LLC level, or if there
> are related plans I should be aware of.

I think that Chen is looking at using the push mechanism proposed here
for cache-aware scheduling
https://lore.kernel.org/all/as2-2b417B8ZaFdO@chenyu-dev/

Thanks

>
> --
> thanks,
> kunyu
