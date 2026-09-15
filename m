Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696053F39FF
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 21:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506868; cv=pass; b=QAnYH8BCQnqJZpDF4TH09ZxMQtt/bYIsfo/I8sPspLb8xrYvmJc8FCwG1w1iRs9eLxVp26XfQAjBZgTTIMrjzOEj+2RSwloxPzyY5O+/3GQ2RQjD+g+G2EsSavI50q084wIxePISujJ8CfR7Gb+qpo5ShfbYESbSTKbjFSsj4Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506868; c=relaxed/simple;
	bh=QNmG5GgewlFBWPJxTq5LZn0y4Pgh+2nWnbyHqUhkWUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suDeZjhFuI+QD2VpqUHNFD5XWm9fZ0mvI23jN2XFdOOa4N5/7K6lGYiPG+NVQFInFbZwKOn1PTDov/Y3u9ZK+lILcBNT5EAhpoTD7nP0miO95RviagKNuftXG9/Q6ZTqczuS4LYzu8GxSNPlCj2gAg3KGdMov/JOa+WetuPd2WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e961VMuQ; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e961VMuQ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93a10f9a2easo120702285a.0
        for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 14:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789506866; cv=none;
        d=google.com; s=arc-20260327;
        b=g3EOSieR9DoB6UrVR3C2qzAe/yO937jXW3lfxUCZEeGmgPYhCulGXxowM/ngPs3wuG
         QwWtfGXt4D+ERAkAL6S4qih1Cuh/NkobOgNBVOZBMZqOZtT/tSYGozKqiw0wD6eHH//T
         CzO1m9qcGhqMcfnNN9w15VNMWIDMvXzyE9A32mNgSH90Gm9dvZVpZZpwZ4JjEczVEQCI
         lbRWJpmhpdQzKHiYHv2icOxbTxcSTreLHbuQ27sKcwqqSHGoP/eFfNQ6kBQ208WkAhsX
         FXjwhcxqzW208A/aXGzSGpQKoHZhe/yHf79QY26iOP9hCHTTjLrM3VApKey68NlUvtyj
         YOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZVe04XZjK+KSdvjTZCzcBxC5Sq+YHQdldpTWQ+9/EVw=;
        fh=V93mn4SnM0oUYLy+JVrCYNs+Su38oWovSumClFLJRn8=;
        b=g1WffpybBlN5DVK95vATe4uG6SXsMgo4UgEpXQfEJiIu3ztNKSBjwgUDYDzl3UZLnd
         1MWNTXPkAo/KPuu6HkpJtdTOs6OplCCVxlkAiTh7AK870yoiNCSDW54+0OyyQo769qu0
         BkOwqubxlWMiLTwq7uIzaXilWIJLHr39/tjyymQZfXSfTvqecmn4fHXJ6mwUow8SH9Q1
         +zG8guXNqLoaLippAzy0DM64zX7BXZE+fnfVaY+o0EIxqf3lFpQrRe8VrWxx6B1UOscE
         zrfjK0ag5F404/Oznait1i8FnKNzs2G8F0n8hNSJMgkSKmyYa1qUuFEueWBxZLcEtmpI
         pHoQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789506866; x=1790111666; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZVe04XZjK+KSdvjTZCzcBxC5Sq+YHQdldpTWQ+9/EVw=;
        b=e961VMuQoHkKWhatdaFltVLtpgxm7p3eDtoI3XxVtqjZ55pAqF3uUrsn7jxDYD7DMd
         SBZaHxiO9dj0msYYOsN70hjkNDCJA0T/wWVPobvAmTrSfajyp7ZNbMOVpg0sVX5iYSd4
         dpfjc2ETlDnwsfJgxP53V5a73Q2Zxh+tVC+XkyqhuLRSkvKhdbvjH7Q8bSnUC4RDu4Gn
         aJHwKddyyQkPKp3rsPJHEWxzxNED7SJYTbU1+luQJZ4GS7lh0VotuFZi1YBROoCEGZNR
         f5AkXnqx8brjGn1xKhSj5uTjBzG63KkRJxom+jf6dHBQKQqL9j47K/DyMnvlXVOJJUxQ
         Rn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506866; x=1790111666;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZVe04XZjK+KSdvjTZCzcBxC5Sq+YHQdldpTWQ+9/EVw=;
        b=aswMw/h0voV3QoWq3TRUVBksjbq2eEEJCVlF4cjtEjZmeboqGKdbQCB2h1APX4V415
         Gla84uzn50Q4qSd/jl+GmZOVDpyrVT/5794YXHWiLeVow1IbstMPEz6HSjGJrFPxsdt1
         d+En5TEfuAixp73VLJD9rQPFsujcb84mcNR0c5a20rwcNRDwcgEi1UaPi26dQfHLEIpi
         w3BksWOyOFHYsqGMhTgDFva34EEjOvulS45+2ybF3rRwINW8r7g764/G3/RNGNHdpjkK
         nJceugUISO5clkbOxcwp0XLUjlWiGZ/H22eNoXZeEea8Sj/pb3g0DF5eI41kPg35U9xb
         0yWg==
X-Forwarded-Encrypted: i=1; AKwUvBzlV9l8aKgObPLkw/lz/H9PJeoEIPkPmhIQZokSgDFV3NGjRVtbbu3mJycssme3sOEkCCmR/M7VrCo=@lists.linux.dev
X-Gm-Message-State: AFuF++nZH8rezq526+hzs4mlDZzA+R290Mjd9aaP+PPKjluZN+7VcOPd
	rL6FnlfXN6bIYcoQSjKGSul3cVosIFim7h0f6WIzbLI1HTJp03bRIJb5mkOCNVS3kusWpVEHwcf
	AZ1koJo85PagT4jYE3SDEiN9nv5LlNj1NMx+aEEY=
X-Gm-Gg: AYBFou3g2lwO9hoPXierUQef7Ukaz3XZbsv9C/CK+c3sl3tpblsQrd+uI9H4faf7U6X
	pDWkBevDpnpg8jUGq7sEFNUbf4WFeDO4AwZ6anRCpEE+Du0zNv06chW/Qp/34xK6BGsdLlFoddb
	UYovQdLFvQQDD2AgynHVTIe2+rsYxKNg+TxFD1SxjKNGYvdr9k2GvGObEfq+r/VxBQPNS/MVg83
	IYF6E2+51W6ZCt6FDqSeFT0r7HdYxbhJaCFgyrhaAsO+LlVyDbrxEeHeOFtC6Dgh8qYGs/+4Pxe
	MZT8QjRn9gRuXryhRaDIhFjbZjixHnapvFwuTKNk8wlP48skGAzEQDFkOxWYg+XlrY6Wn7AyUvG
	BzJgXfjxm3tNJoBf1yGiJct9vMVoAT6zyLkwe5hqA3y705dP1zSuuIHKS7z3vzCAS0+5yOnxN7q
	F2PxCjtg==
X-Received: by 2002:a05:620a:44c7:b0:939:f1c2:7df7 with SMTP id
 af79cd13be357-93a3474acf9mr759579985a.41.1789506865533; Tue, 15 Sep 2026
 14:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260831134338.1531664-1-arighi@nvidia.com> <20260831134338.1531664-9-arighi@nvidia.com>
 <20260910104528.GI4120091@noisy.programming.kicks-ass.net> <aqmw0OT5cCtge-QI@gpd4>
In-Reply-To: <aqmw0OT5cCtge-QI@gpd4>
From: John Stultz <jstultz@google.com>
Date: Tue, 15 Sep 2026 14:14:11 -0700
X-Gm-Features: AcwNN1VMX_7ktPPiVAsPMREf9lXyECJY-Re-ECGI3fsOR84NWtLvN_oG1il_JF8
Message-ID: <CANDhNCqN+mJdrjgjRD_pMQYssHCrmrnE9CW8cMprPQm0dZPtWw@mail.gmail.com>
Subject: Re: [PATCH 08/18] sched: Introduce WF_ON_RQ wake flag
To: Andrea Righi <arighi@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Christian Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, 
	Emil Tsalapatis <etsal@meta.com>, Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>, 
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:55=E2=80=AFPM Andrea Righi <arighi@nvidia.com> wr=
ote:
> On Thu, Sep 10, 2026 at 12:45:28PM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 31, 2026 at 03:42:18PM +0200, Andrea Righi wrote:
> > > ttwu_runnable() handles wakeups for tasks which are already on the
> > > runqueue, but scheduling classes cannot distinguish that path from a
> > > full wakeup activation in wakeup_preempt().
> > >
> > > Pass WF_ON_RQ to wakeup_preempt() from ttwu_runnable() so scheduling
> > > classes can handle already-runnable wakeups separately.
> > >
> > > This is a preparatory change to support proxy execution with sched_ex=
t.
> > > No functional change.
> > >
> > > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > > ---
> > >  kernel/sched/core.c  | 2 +-
> > >  kernel/sched/sched.h | 1 +
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index d578dd635f2eb..f142ab455b797 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -3908,7 +3908,7 @@ static int ttwu_runnable(struct task_struct *p,=
 int wake_flags)
> > >              * When on_rq && !on_cpu the task is preempted, see if
> > >              * it should preempt the task that is current now.
> > >              */
> > > -           wakeup_preempt(rq, p, wake_flags);
> > > +           wakeup_preempt(rq, p, wake_flags | WF_ON_RQ);
> > >     }
> > >     ttwu_do_wakeup(p);
> > >     return 1;
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index 56ac104f1f825..f30d122909e7b 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -2538,6 +2538,7 @@ static inline int task_on_rq_migrating(struct t=
ask_struct *p)
> > >  #define WF_MIGRATED                0x20 /* Internal use, task got mi=
grated */
> > >  #define WF_CURRENT_CPU             0x40 /* Prefer to move the wakee =
to the current CPU. */
> > >  #define WF_RQ_SELECTED             0x80 /* ->select_task_rq() was ca=
lled */
> > > +#define WF_ON_RQ           0x100 /* Wakeup of an already runnable ta=
sk */
> >
> > I are confused again... help?
> >
> > wakeup_preempt() can only ever be called for tasks that are on the
> > runqueue. That is more or less the point of wakeup-preemption.
> >
> > Even the already-runnable distinction would mean things like
> > move_queued_task() should also have this. The task is new to this
> > runqueue, but was definitely already runnable before.
> >
> > What actual distinction are you needing?
>
> Hm... yeah, WF_ON_RQ describes the wrong distinction.
>
> What sched_ext actually needs to know is: did this wakeup use ttwu_runnab=
le(),
> changing the task back to TASK_RUNNING without calling activate_task() /
> enqueue_task()?
>
> We need the distinction because a retained proxy donor remains on the run=
queue
> while blocked. When it wakes, ttwu_runnable() can clear its blocked state
> without calling enqueue_task_scx() again.
>
> sched_ext must therefore request a reschedule so the newly unblocked task
> is reconsidered for dispatch. We don't want this extra reschedule for a n=
ormal
> wakeup because that path already called enqueue_task_scx() and performed =
the
> required sched_ext bookkeeping.

Would it be sufficient to just drop the if (task_cpu(p) =3D=3D
p->wake_cpu)  shortcut in proxy_needs_return()?
(or conditionalize it on the sched_class?)

thanks
-john
