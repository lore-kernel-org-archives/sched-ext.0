Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482969;
	b=ES5KTFJpDQu8elL4bklwes1U0sHYg2SNyDC0XkhL3MrmdDr7G7lb65ADXmG510ZB6J24
	 yPKSwb4vXQST+xBb6XQRKp6pnBIGgjb1fCB1PBvPh216qOcnEM0kEygI1MFZQ71IX+uIN
	 ZZEOIbjRlqXrFMnzdMWBvs+RMpfa6tKA7+JKT+m/yF6i7jQHS0mMeEt2GOQi03skEDMJk
	 dZMOvvo9S9j1IIqKyYGT8FCjspBaIyKo0FVLtirzXVI2lC4OE6l4HCWs3hzY6BoidMPHI
	 nVlM//wD201C80rf+X5k4L2U1HqhIVTrqlQXEHRD/LMt0NeLPQ3hwKCVcQgNCiNNUqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=IhR5gAqeEKQ9dwc7R6qIHFTbcxe4WVe/vtyqIhgfFqc=;
	b=uKes5/I+6y8/hTead1N7ivasd6y+EqsqVObWH6gR4akZH/yla1cutYjM5BCfINRok9z6
	 LkD3U4/L7PWJh+630zY8x0PCHbLeHCIUmVIPlIJE7/8w2sWnIxc/3tyw0SFTFLxJV6qY2
	 7wRKwEKcFBQd2eWzRglpzBdnVgqyE8SYIU4FuTqnW4jAgJEznskptYDfIN04V+qiNXRsO
	 qF97PpZWsOihMLfdM5RyjKNid7n2mKnB73AMtxLLXfoOEa4yyoQrN94V2t6ok4LiK1BQ0
	 cRX+gV2BEdSz/wB8BXu2SVt0/gXLBb86u/fEIC45IsSvYFprfNnEnXUBnV/INCcRYPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NixIIDo8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63282606A88B
	for <sched-ext@lists.linux.dev>; Thu, 12 Nov 2026 11:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63282606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NixIIDo8
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b570ff3dfdso4504371a12.3
        for <sched-ext@lists.linux.dev>; Thu, 12 Nov 2026 03:29:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794482967; cv=none;
        d=google.com; s=arc-20260327;
        b=sF/fy8jip7Gd0P1Ro7UoUh3ifHFLxhlloy92NPmtYtTrKT8zZiL+Ut0/OfZYdmScl5
         +6lpANs7XlZ3GFp0W7G26Zrqb/x14B9NOW1yfL0b8lv4D8VLGiB9QYuCxRptSwBSWYBn
         6gkGfVQdP+PYSeShFN7VFfE3emennSv2Ll0JxFt/PKIqv8QZ0WfIWcBDdqK3ztoSNMf2
         JfEy0pZAwSZh6HUl7zpzBw9ZZqcSZf8wHN7esVXPT0Myxcvl3Y+9iu0nfmMbBD8YXRKi
         91fn98uvxuWn0rlPDA2veGpQm1GqkGXaKtrTCaJU/oKjUTcaZ3oemzxCvGLbVozMJBRW
         U3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IhR5gAqeEKQ9dwc7R6qIHFTbcxe4WVe/vtyqIhgfFqc=;
        fh=gZOzKKSaOTL3gm35XAmE+65U5FZdEZIwuKhDIzSMy64=;
        b=BfD/+sALFxpk6kwcSumULcw4cMdyE+VdCeTLkgQ65ElzeP4ydwH9EwKbiaO3VvXSWH
         IMsQtCYRvg9+V/a3WncRqxmw+3u7mlHDRoO5kWRPk0QqD2AgQvEmOPqEWYiBJ9mAm/jE
         w9BY94OlMGLZeVOS0R7+nXjirfiDmKFyvuGQ/fTLflbor3tEAu91erEdDhOh/zJHvLXS
         Vl0rO1sLOuZCYcEG/RluZhWNnT/jnWhodC1Zd3k1R0WOADWIFnf+S99xzNNZ30lHjwrq
         tGzFg2SSlw3NoPbqy6yTphY89xf1DxXzfYKJZnQWJBKDOib3y4lrVtGnvLxbB8hjjxpV
         NgmQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794482967; x=1795087767; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IhR5gAqeEKQ9dwc7R6qIHFTbcxe4WVe/vtyqIhgfFqc=;
        b=NixIIDo8sX9YjZGpN0LoHKVDbgk3M+HNB+BPXUQj1FM80IiM7KuwyX6lowb8fcneCM
         ugsN8TRC67KfvgkFEH/HAQtX8ANx0HObmRt6QLuXY9uH3cKMscK2rgFDl6Io80pvu/wg
         tcRF8pYp4k8MPW4Yf5vbWl1yotCxwuUAGKk6OaN17AT/bf1OEL50MvDB4j5lrMc4Nkmm
         WdgPdrYvdYsgcoCkrTpVu43ocHZCTav9hxrNKMsMfGN8QVAVL+lT3F8whfV9+9QZHqKu
         JfrU5FQUdydiwVp3aPDs8d/JCthsamji7HwJ4SRkZkrRWhqRSkZ+oOy38JsaBd3IpSti
         7Nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794482967; x=1795087767;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IhR5gAqeEKQ9dwc7R6qIHFTbcxe4WVe/vtyqIhgfFqc=;
        b=p/WeVe1xHIbQm6HQLZ8PEKJB+UY+htHqfLYmDYGW4wD1y56LY0/oDEcd+v7WYR9GgO
         1UgCr8YDcJr58z+MHt5IR/oguCD9y8FIDqjwcCBkasu0qqaPFLxf8HMjV6GZFSE63S7P
         LqpEI+H1xlB0vNOSIiaCHQKvNs/hHkVVzNjxRAlvsnYdbQYqFLjP6Go3TRxanHCG/4Mk
         L6b56lQaa+N/iqakA9oyTgifrqeMqfUBMdqcig7EAGwjci50vKzZtGMhZNqbJi9zTrqh
         HM/c0uYAGjpOwNpVCdq7/r3b91+TNQo8W9ealw1tp85BEr/u/D/4arxJY9jkz3fsI2lQ
         XQFw==
X-Forwarded-Encrypted: i=1; AL+hErFclvIq/t3y+6YPH0hdZapqJ0+KOnujvE7uO9rIMzCuRTwihcHdrjADMuzpU6gLRtAtDiCX2WLX8uQ=@lists.linux.dev
X-Gm-Message-State: APuU4Z9NKdSMTx1syxneqBc43i/5B0mW/+Qjlp43GgQdjoOragk188Ic
	thEv/LP6FQW5tYpXIr6moa1PuFMqchvJoRCMgVUds+IjlvDugA0J/EINvjx5tY6cVi7BDPEJEK1
	K7rvLbxyYqknqpdNdEJetkfAqoTbvgShugUcr3pKqIA==
X-Gm-Gg: AYBFou2COomaTGyj8Zwa+y013eEeZgNknDwfeazAArkQOdvKX5gCePZVFEzaMmmKMx1
	ce2awzXIGgfPUQcSX0buxahLutqnvffjOxBdW0oa3zafZMwQra0OPomaLFRgTS0bJQeBldF4/E4
	sVvZ36r/W4EsKHfYuDg8FzG3mPuIsCVDfl7t7VlnIhc04uYkOpX19MrbViDwYBCUYOIWwdySwuR
	bOdyqKkDkUmZI33enyRm44gQqYKEcdZPSRhXaQmmt3DqCKKMeGiAVV1fqks5fOVmbfN3FhA5JRU
	pLiTQDnzL8Xtpk0v4FdxRWNCgws7lk+d/sh01Mk5XU3oP6w7eexevaDfpqnyC/zdAzsefmKIGmZ
	cGgw/B8s9ZSbM15FGyki8RsO8UyS00CrAhNKulgedS+YwNliNnfRjacMsWIavj1coFLC73g==
X-Received: by 2002:a05:6402:1d51:b0:6b4:16be:4fa with SMTP id
 4fb4d7f45d1cf-6b7773edeeamr4079109a12.15.1794482966709; Thu, 12 Nov 2026
 03:29:26 -0800 (PST)
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
 <CAKfTPtA-nrgGQGcBPqNoPk4atOHakyZK9Fk-4AsrHBrnvPXTLQ@mail.gmail.com>
 <20261111090155.GF2668564@noisy.programming.kicks-ass.net>
 <CAKfTPtBfQd5nD9jNdayGbEW_P2bDMvOm=GZ3Q-gu+O6KkQmKbA@mail.gmail.com> <20261112094910.GK2668804@noisy.programming.kicks-ass.net>
In-Reply-To: <20261112094910.GK2668804@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Nov 2026 12:29:14 +0100
X-Gm-Features: AclHuK8GqM8XGi-ga2efC_FAPlazK7Ox3_1G0kC0seKYatyPLvqoUsk26qpWqiE
Message-ID: <CAKfTPtBNx9Dpe4zBAzJU1iabp6riGAN8v-GP9bc5fh8NZq57hQ@mail.gmail.com>
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

On Thu, 12 Nov 2026 at 10:49, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 12, 2026 at 08:01:17AM +0100, Vincent Guittot wrote:
>
> > I don't want to take any random task from the rq but only one that is
> > meaningful. Why do you think having a dedicated pushable list like rt
> > and deadline isn't worthwhile?
>
> Well, effectively cfs_tasks *is* the pushable list. The below patch
> makes no effective difference, and can be argued to be an optimization.
> Currently every consumer of cfs_tasks goes through can_migrate_task()
> and every task that has nr_cpus_allowed == 1, will fail that function.
>
> The thing seems to be that you want additional constraints on your list;
> like dropping tasks after one push attempt. The other classes don't do
> that, they do the same thing cfs_tasks does and keep all runnable tasks
> that can migrate on the list.
>
> I'm not against adding another list per-se, I'm just struggling to
> understand your extra semantics, because its not _just_ another pushable
> list, it has some extra flavour.

The main case is to periodically look for another CPU when a task is
put back in the runnable list. I also have other cases like patch 20
where several short tasks end up selecting the same CPU or when the
short task finally can run 1st and should look for another CPU.
Because anything can happen between wakeup preempt and pick_task_fair
I don't know if the 1st item is the one that might to be pushed or how
much requested it

>
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0552eaf64e95..8c81d236b24d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4693,7 +4693,8 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>
>                 account_numa_enqueue(rq, p);
>                 account_llc_enqueue(rq, p);
> -               list_add(&se->group_node, &rq->cfs_tasks);
> +               if (p->nr_cpus_allowed > 1)
> +                       list_add(&se->group_node, &rq->cfs_tasks);
>         }
>         cfs_rq->nr_queued++;
>  }
> @@ -4709,7 +4710,8 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>
>                 account_numa_dequeue(rq, p);
>                 account_llc_dequeue(rq, p);
> -               list_del_init(&se->group_node);
> +               if (p->nr_cpus_allowed > 1)
> +                       list_del_init(&se->group_node);
>         }
>         cfs_rq->nr_queued--;
>  }
> @@ -15620,7 +15622,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
>                         set_protect_slice(cfs_rq, se);
>         }
>
> -       if (task_on_rq_queued(p)) {
> +       if (task_on_rq_queued(p) && p->nr_cpus_allowed > 1) {
>                 /*
>                  * Move the next running task to the front of the list, so our
>                  * cfs_tasks list becomes MRU one.
>
