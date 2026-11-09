Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794240894;
	b=eRslcFmvK+HPJTar2kKa46gFEtxkOAe1xy+/ukEaroI6bLjY6rhI8U0Fl7jMzBpFmlXP
	 S2ng20vuInOz8AcxI/O4bY2M0wtaMGAPY2nsinaiVpn0Wp/Ia6IQ8KnEWvMZBTDQvKvBV
	 17+6bWFoHVt20vMikVVsbrxHE2/atUAJ9t5Q4av0k3SvCcW/nfWFEF56//ZJO4YHi2cjM
	 sOxgU4jjtbYUma4K9dPJGYtjGP+5XllMcWjtKCxR4TJ7vOMRG/9OsG3dtHnFds01MmS1j
	 7G5Ws2Brd+gXisrV5WIlm1JRR6Q4gP6B4vFZAvqe35mnTZtyDteeJl6FNEGkanR7jVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Iazb6upx9SUGzyZFOTqETYh5xGwU5uNLEyV8UXrgEeE=;
	b=DVtTT9X8OsQD6t8h+fzx8ILCayTpyVR6kuPb5GCvtQ4fNYqqzU4DRxTrLrddjC2GYPz4
	 tRqIBzgf6Sto6ExB3B81Y8Kd54V8+JWcq2cV3FlVuMe51wc5M5BlULpDJFW8B6NPmpt2H
	 mO4iCjVPC1ackzS/Cv33JCmAzmkFWjmwXLAjKGduIRMr4+P9k1DgadgDr2c5xVZ9gb+hC
	 DNIQdxVG0+zGzykilzFs/K1H7tz/xOdcMR5NbgAjih+o4UJFok0iinGOo6FmdqYpSbnNV
	 sRFoCc3RocEtXu3JxhMc7LFYOqf8D/GS2E70KugFTAZu/YAaYUH26/zVLzpLCM8rqeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=M3vZdfHN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC5606A326
	for <sched-ext@lists.linux.dev>; Mon,  9 Nov 2026 16:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53EC5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=M3vZdfHN
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b6e7a05225so1430090a12.0
        for <sched-ext@lists.linux.dev>; Mon, 09 Nov 2026 08:14:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794240893; cv=none;
        d=google.com; s=arc-20260327;
        b=DTzD1eqU0IHXBFVPX8jSyi4rZUYmg834AzJBElqxf3Hn/m7Swja9bdq7YGfaZSJKce
         DXDNz4UHXwQFHw4/Lf2+l+NSkLQMK0RXnh/AZN02EsjRju/tmv7PBBVSJZnid86mu5cF
         RGJAwIZvx9A60rquxCh4uvi3Rx1AawSniGF91Mku+wV3rAzNDcoOPpkkfdxFtMSk0Z3u
         YN2E4NlN63AcQr2etIl0VA0W0cEFUjXKKrfqx3tV5CdLHwrqxhbnQSK526Rs1otS8R/6
         MBe+Cuctyh6SgmZSo8+pTn0khNvvoiwhv5hvDmVmXWxRZxt9bPNRER1T/dz6NkBrm15U
         9h8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Iazb6upx9SUGzyZFOTqETYh5xGwU5uNLEyV8UXrgEeE=;
        fh=Irh9uPzV+0M2MMCpz1khbolCzfSZEbXw3DIm56B4Ft4=;
        b=nsi9VIsFrbXG2OQC2ulWmRCYJne4cQvJry3mQLholLp2ds3+TPyY1JqzRbW94Cl0WE
         bQQ9ZDrEglNlR92ntGEz1+rQnDHmNf19YNya9ZXpyC80tuqlvU0GR7tNDu2j3ffCOEsx
         p5wOYe5pbwFcgiVAb+eaycrkTKxsmDNAjDy8Q8GLam3uBTnhKJ22hd7sityeIHLoD7ov
         GZGff6sU9UtxrS4sCAfCEnMUGoXwgtN506QiI39qiTwDJo8mYpbee38v39326rpIm0ff
         N2mHZthLzmC/PrIS0sJt+TkU+VOQrgiK8Lgmpe9pKhJVVIUz9g2emd3LGSHsVZ4xjWZb
         evIg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794240893; x=1794845693; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iazb6upx9SUGzyZFOTqETYh5xGwU5uNLEyV8UXrgEeE=;
        b=M3vZdfHNC9H5jaWeA3Skwrk7fmOUtdAVNhwIYTixbj3ECkWVMLNV9A6NMMNgEyA3r3
         hOPmDLtDQuueWFkTweO5BDakF806lmONh/HvhL8O8+rYPh45odSSmP87tlPotnWsWHZE
         oXv4Z0CNGXwKZYNa0Ay5fVP7x691ny24lVjPLw+Uqdk7D/3yGhlvqifPNw8hnFmGxmyS
         QqHkxsVVxY9HNXvCJo8DXchQmr4XgIGwg16+bvueUCknEiZv2g02U/YiO6HRdh4ogy3g
         Iyr7OIn1XH7n4Xx3i9QAAXq8WsbkhEqDzYWFKSJ2XB45Fwlm1S88YA3VZRlc2Hn05oep
         7XdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240893; x=1794845693;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Iazb6upx9SUGzyZFOTqETYh5xGwU5uNLEyV8UXrgEeE=;
        b=oYVyeiTEPpQEu6nGEhD6CL9d7lMW2x3dACXp//SawXp2tC0ahPv3C2MW0+wC3BC9SE
         Mf++TtKxnijM5ou+MqRx8pPNmoD6LKRiHaTQcQmdaNXkUJrSmQXPBSBhclkKkQZLtcfm
         HOypvJZp3dY9zWEvJMAaeBfgTeUI2uKc2ju2Uia9CN+u2/atVpSbGUWoYkbFGh7y1h1A
         xAIw+u+jN6vP/gYE7hsrvitVPxq8cRtUchNHVeRiFlPIfbCNdDo4JliT1fRyld3bVYlx
         gDza5PVvIQKwKdD450L12ctTtLwN7xHdDvLfUPoduMrNthWDmAlcttpgCmSX9eO05QTk
         Xsng==
X-Forwarded-Encrypted: i=1; AL+hErFXqscIaXO7rOxQ87HVqaaY6vkAqHdB/dYs2nrdUbKsDN1v+uagkEyYg1IrQGCv4cGmUKShdks8tTs=@lists.linux.dev
X-Gm-Message-State: APuU4Z/o2hGiqcAgHL0+zwuSq1n0msWc9I/O6kVQgVLoG+1+ERElNMRo
	z6mw+ttDkAO7NcWK8GB3ObU7b6+hiGpYfEv4pE9kMORBb/LdTFO/BMzae8PjyNGNL9LS39WW2h4
	1jz7MkYoesPjiRLrBq3rhsEqIihJdr2luZpAcnKbzMg==
X-Gm-Gg: AYBFou2MH11TWPUrCfByCr5Og2eXYZZeQ1GvIRyDcAOVbtn4kKoWorW/4mRlKvr1u6Q
	woXwZ2M0Yivcxmo3kSMGNhdgwuK2wHmFOQ4T5bHUGGJesjm8CEwZ7me0dygvQCpZ51RrKZFFPse
	PzgNQyjMzRUne2HDQf55hVR6d3bQiBtKMs9bDjufOPHtU9ouNmuOJVN8x766RR3zNmjv6fozkdm
	50spyJbLzgma2iQnXAdXBHOnKlDRlLOcDVLostnasPtCjySTLNSKgdVL1Dqauis4Ge1lJNWQyX/
	punhfWXGgcI7Ofd4kuu9BDPtHYLRyQl8/MYIa2JMp80Vu9ooeg65eBBBbO3FNRkE7+Oea4MP2re
	PByhCg8Q5pWxBUl8IJfhk86av5adh8WdSEPNG2XxwwyfLoXSxjvNfDeCAbNKrT9Czu6/HEA==
X-Received: by 2002:aa7:d7d5:0:b0:6b6:e808:9701 with SMTP id
 4fb4d7f45d1cf-6b755e6b4aamr53584a12.1.1794240892542; Mon, 09 Nov 2026
 08:14:52 -0800 (PST)
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
 <20261106151947.3991524-9-vincent.guittot@linaro.org> <20261109155418.GL1779021@noisy.programming.kicks-ass.net>
In-Reply-To: <20261109155418.GL1779021@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Nov 2026 17:14:39 +0100
X-Gm-Features: AclHuK8Lril_R7chVytS1fQiJPDmi6Vo891N6VuKxGIj8nfdzRAKgkQea7WMEGA
Message-ID: <CAKfTPtA-nrgGQGcBPqNoPk4atOHakyZK9Fk-4AsrHBrnvPXTLQ@mail.gmail.com>
Subject: Re: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, lukasz.luba@arm.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, kayracizmeci@gmail.com, 
	tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 16:54, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 06, 2026 at 04:19:35PM +0100, Vincent Guittot wrote:
>
> > +static bool __check_pushable_fair_task(struct rq *rq, struct task_struct *p)
> > +{
> > +     if (!task_on_rq_queued(p))
> > +             return false;
> > +
> > +     if (p->se.sched_delayed)
> > +             return false;
> > +
> > +     if (p->nr_cpus_allowed <= 1)
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> > +static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
> > +{
> > +     if (!__check_pushable_fair_task(rq, p))
> > +             return false;
> > +
> > +     if (next == p)
> > +             return false;
> > +
> > +     return false;
> > +}
>
> > +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p)
> > +{
> > +     if (sched_push_task_enabled())
> > +             plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +}
> > +
> > +static void __fair_add_pushable_task(struct rq *rq, struct task_struct *p)
> > +{
> > +     plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +     plist_node_init(&p->pushable_tasks, p->prio);
> > +     plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +}
> > +
> > +static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev,
> > +                                struct task_struct *next)
> > +{
> > +     if (sched_push_task_enabled() && fair_check_pushable_task(rq, prev, next))
> > +             __fair_add_pushable_task(rq, prev);
> > +}
>
>
> Can't we add the 'p->nr_cpus_allowed > 1' condition to rq->cfs_tasks and
> use that, rather than adding yet another list? I mean, its used for
> migration, so excluding all pinned tasks actually makes sense.

rq->cfs_tasks can be quite large (we even take a breath during LB)
whereas this list should be 1 task most of the time (except during
wakeup)

>
> Also, I'm still not sure why we need a plist. The rq->cfs_tasks list is
> MRU per set_next_task_fair() moving the current task to the front.

The plist was only to reuse struct plist_node pushable_tasks; in
struct task that is already there for RT

>
> So reserve iterating rq->cfs_tasks, skipping blocked and current and
> such, should get you much the same over-all.

Yes but I was afraid by the overhead of iterating this list which can
be very long; We have already seen email about bug with thousands of
tasks queued on the rq

>
> That is, why can't push_task_fair() be something like:
>
>         list_for_each_entry_reserve(p, rq->cfs_tasks, se.group_node) {
>
>                 if (!can_push_task(p,..))
>                         continue;
>
>                 ...
>         }
>
> This would result in pushing the task that has not ran longest; which I
> think makes most sense. Hmm?
