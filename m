Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B0131E49
	for <sched-ext@lists.linux.dev>; Sat, 11 Jul 2026 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783729319; cv=pass; b=jL9FZP3HfP331opXKC2mjAGmymsJROcoNmCe8pr+cK47sdo7lPjGlXAXO9NjHlrPTCaRYYDJrAoB2kwNYrF5Db7zxNylV5Z1RDiXfPV7lFH6QoLUdv/Dw0o+Jp284WeiY+NMjO2eHltwfgBcHZ/yMUNXkLurOyaDAaOD8kx1LdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783729319; c=relaxed/simple;
	bh=y7NIx7DYQPSAHVBKha1B802ISZkGpX0LcJwzGQuil/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHNwrqA06xbVlx9TyJCf6g1TIDFmeoovM5/ntkTeb3DYEXq4WM2VdEhRTZ2KMEgmpHiYbU8kn3pECD2Vamv+cPgVyZ4SZ6/oVDFMpjwsC3hVBmlUruWj4X2yK0Rref/5wKq6wShloJ1WC0eFcP+Tefrh4ZQhILVTJCwKEppU4Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oKPcRt/h; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oKPcRt/h"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so12633975ad.3
        for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 17:21:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783729318; cv=none;
        d=google.com; s=arc-20260327;
        b=F63j/nJp6AwX/3ifblnOSKhSEXxXpBC/xqOoujf8faMuXIOkf1MZydtU3K6K+EsGWn
         DiReaZ9xnGey56cRfxCXNnnzP6l7RJt0eRmKUmyXAgj0H3eVOSdEW17LIj8ccrZp1nYC
         2q27g9DqurPEUymTMT/KF3lUMs1mDnnPdV92OW1GszWgazFfHNM/RnTITb+TwSwCIikP
         1zzFRTI6OxqsYpsuZLGRbZXeWK7R9cHY7sbKW9UQIQHfQVZeH3rWxv3l+89ZPY0eyZC4
         W3ekJK1PSPwz+chmH7Dm6oTVvjPm5jDaBr6qheMtg+H30cGLd7/8yss3T2ouJ44oVlb0
         dC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MytK5P+8sSQZBtcC5LjYGk4RIgc5EK/uc1yIAY1Ia6U=;
        fh=3czss3AnPfdLknJmXoCGSgPnlITOL/kNA0qyxg86T/8=;
        b=c08YOdXjfKUWi85ToiIWP6T4yCZVTwqCk1ruBGwHTQojBGXnFAZHvo+KFwqz5XsoOU
         39Nvm8woETwsw7wnnNRIg6MByZYrKccHQRZAn4+Dtum/2B/SrJMs3UQtp3N4TdBqAH1H
         wJWt7yvnL+m1YVCMcPJipa84vCdOz3Uy3R4zwph/QYcLWtXj6okN0PNzf4afzRu+nL+P
         LmXVJJwDe/sZv/XoTEl+dCSGzAImm9XZo29MdHl9oSqm1ui9dp/Iynvv/zIwJ6KxalRn
         re/kkDB3xjT4qjrZfkdxn81ewLZFu0+5l/2H4PJTUySWmKkVxzrgsMF3127fC7ktKpuu
         tC/Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783729318; x=1784334118; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MytK5P+8sSQZBtcC5LjYGk4RIgc5EK/uc1yIAY1Ia6U=;
        b=oKPcRt/hHvc/7oTbnOKr2EbjWqEzPxc9j+lYBO7g/tSW05PIRxrrerljaZnfJO9q6f
         DMPrztIKEp6R0VSuLWCz5hg6nio+HDeavo5Gv/hdmMrXL2g5NIA8dh9DiEgR0Q71fReE
         I0U9Z/lZqm6geQfEeLwWDqah9GKIUOGXOFNyFXwxUqr47QeV/cFeG/H141p+T70LRZtg
         lTyjC44/izkA3mhMT/iz44a8m3Yp4YwqqlwwzRI+97BF3fOFdtj0T+orvdfmk6MLcsMh
         QEchYCLQFKahY0NwiGmY5V1pO2yLGeBQZgWVLc9Zv+bWg2E9UfSKp1AdfzdHvNSlM+eI
         nj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783729318; x=1784334118;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MytK5P+8sSQZBtcC5LjYGk4RIgc5EK/uc1yIAY1Ia6U=;
        b=UrSEvTR0xlLwv8JOYO0uaB6GhOx38SStNWYX4U1nGQyobr4YYSxxST76ahJxNJQVt0
         gAfTFITfsKIHHAWXg+tQzQBkjakrlzHRs341UNduuVcRAEFoqSdxS5BcGQiTDTIVJ0OK
         UNI56MW6MzYBuCQ4+HAS3LqEv/hHscbaNJNXTOCqqS7HkjhI5IcjvpGphVvLESE3g2ML
         Bp/Z/uPUnJFUhSOxYxlZoQZbcBLT1uvDK4W4X+pWr7rMHNP0EOT/QvCETdBhh9iC/4uX
         QNKoh6aa4gkHBuKHsWAAzcNCiTyveKX34PaFhg0i2piyrCbEhZ2HrAt/hAzvihM+8EFZ
         BIWA==
X-Forwarded-Encrypted: i=1; AHgh+RogDL53F/8Z+Z0GqzgknxP8FE/x9TIzhqd9tWSDjCjIwlka0uMGuo2tJEc1IvzoeBpDYsJt1rljVUk=@lists.linux.dev
X-Gm-Message-State: AOJu0YxoDnTQKLSVzD2ZPIZLD4yjwJG4OzG8JZ1BzsGCwFIqaQFVXtoc
	JxjRvgOTC0jHmqlGdsg/7xgktzQiOidyHwIV9KBCyHifve1jQm+xusd/p5OUvGhuZM7X47iR48f
	G4KuPtx+pCLHn1ohTU4er81QEXWRfgUs6z0DUfYo=
X-Gm-Gg: AfdE7cnYrkU5Ut5TeztmThx//IkBduUWfx4nbqwaHlG2Osdawe9mVD7lU07+T+3a8AE
	1msRxZLYzIrKKtsgi0qL1gciFAAlyovdoIFrVNcQ2EOFq0WZPQedDKKoQcTK0dVQ4UKJliFawmY
	plnwY7r58CWURjsQ8Fnke+u6Ya6wry0wzVV8sYfB2rzc7OGF3eMkBO5BN6O3yGxjroAmPpEIJMo
	55BWKcmSWMwqcC3kpkd5n15efrR/UiUiJobLuBbDQcFDFRJSD2sajdVY7fwvgcB5Zuuf2CyHhgu
	rtcr2H11mqMa57AAjsDKPn95C8311B/2AqfdustYPJhSbBE0rdJGY4cmUF2lYbC8+f3F/teZ6Hm
	ov2VJC9QLHE609gwKLAp2qsuf+ZhqnW8pEJg=
X-Received: by 2002:a05:6a21:3990:b0:3c0:9c1a:894e with SMTP id
 adf61e73a8af0-3c110b33340mr1124425637.70.1783729317341; Fri, 10 Jul 2026
 17:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260710083913.30573-1-arighi@nvidia.com> <20260710083913.30573-2-arighi@nvidia.com>
 <CANDhNCrR+jiW2QEDE9yhbuFEp2nfnWh2Vf-_GT9NWhSP3oSE2Q@mail.gmail.com> <alFaVuDMuGNz8a-g@gpd4>
In-Reply-To: <alFaVuDMuGNz8a-g@gpd4>
From: John Stultz <jstultz@google.com>
Date: Fri, 10 Jul 2026 17:21:45 -0700
X-Gm-Features: AVVi8CdJTQK4Z2g5HHWOFnRwUmzBrXA2RCsSlGoZz5aBlRMOXJecQP96NNcQJoY
Message-ID: <CANDhNCoyO=KaOhQZDy4drXpyeCbwt9src3cpXe+1EFJgEpPN2w@mail.gmail.com>
Subject: Re: [PATCH 01/10] sched/core: Drop mutex locks before proxy rescheduling
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Christian Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, 
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>, 
	Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 1:47=E2=80=AFPM Andrea Righi <arighi@nvidia.com> wr=
ote:
> Inspecting the proxy chain is not strictly required. A BPF scheduler can =
just
> accept a blocked donor, enqueue it on its current CPU and let the core
> proxy-exec path resolve and "virtually" migrate it as needed to the owner=
's CPU.
>
> The motivation for providing a scx_bpf_task_proxy_cpu() kfunc is purely f=
or
> optimization reasons. By knowing the owner's CPU, a scheduler could make =
more
> informed admission decisions. For example, it can inspect the task curren=
tly
> running on the target CPU, determine whether the donor should take preced=
ence
> over the running task and kick that CPU to trigger a preemption. Without =
this
> information, the scheduler can only enqueue the donor and wait until the =
task
> running on the owner's CPU releases it (potentially adding up to one time=
 slice
> of latency).

So... I suspect I'm missing a subtlety of scx, but in the non-scx
case, if a blocked task is important enough to be selected on the
current cpu, the find_proxy_task() logic will walk the chain and do
the proxy-migration if needed and mark resched, so then that cpu can
evaluate which of the currently running task or the migrated donor is
important enough to run.

I worry the difficulty (with my poor understanding of the
optimization) is that it seems like its evaluting the preemption on
admission (I assume this means the point when we keep the blocked_on
task on the rq? I may be totally off base here), is that if a very
important task was breifly running at that moment, you might not allow
the blocked_on task to be enqueued. And at that point the donor is
effectively sleeping and no proxying can happen until it wakes (which
may be only when the lock owner eventually runs and releases the
lock).  In this way the optimization might make a call in that instant
that results in *many* time slices of latency (particularly if there
are lots other unimportant tasks on that cpu).

By letting the proxy logic handle the proxy migration and
rescheduling, the blocked_on tasks are just in the same pool of
selectable tasks on that cpu and the scheduler on that cpu gets to
decide what is the most important thing to run next.

Now, I can see the benefit of potentially saving the resched kick on
the target cpu when we do a proxy-migration - it is an interesting
idea I should think more on to see how we might do that better in the
core logic.

> That said, I don't see a correctness dependency on exposing this informat=
ion.
> If the latency-policy use case is not strong enough to justify the API, I=
'm
> happy to drop the query kfuncs and this preparatory lock-scope change for=
 now,
> the blocked-donor admission support can stand on its own.

Yeah. If that's the case I wonder if it might be worth waiting a bit
on these optimizations until after the rest of the core proxy logic
makes it upstream and settles a bit?

It might also help make sure the demand for this
optimization/interface is strong before we start adding interfaces
prematurely.

Really, I'd like it to all be transparent to the class schedulers, but
given the complexities, just having the ability for the scx bpf
schedulers to disable keeping blocked_on tasks on the rq (effectively
disabling scx proxy donation) seems like a good initial step.

Again, I am really excited about your work here! I've sadly really not
had any time since Dec to look into sched_ext details, and I've had to
tell a few folks who are interested in both sched_ext and proxy_exec
that they should turn proxy_exec off if they want to use sched_ext.
So I'm very eager to have a better answer there!

Thanks for all your great work here!
-john
