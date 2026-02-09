Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F53A37D137
	for <sched-ext@lists.linux.dev>; Mon,  9 Feb 2026 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649246; cv=none; b=osYb0T6N5lmZH2IMKnICIsXySGIB8XBJCpRmGoPPO2NMdYgh4J0dz+nVxWoj/mSMlL5brYO/ktQvBnAlsCJdN2a2jHcpmCBc4hb3CGO2HU4s7m2fUpsrbaCeB6XXYoLmhp4c1ojHt00NavxNnVOIz9s+xVl5cVID4c3ns6bNIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649246; c=relaxed/simple;
	bh=O4shWqKXzcWWKTCr6etm5XcHELbovLpL+BIkZlkRTtw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=b4ygKS4PC4AGGOKeVKCnhoa4q/GQkhhoYcV3Hjv2eyA1Qe6Hp/JICB+B3iRXAVORovponU/r87NDvOS8CbHwFMJgtz3cUkDSeeBOdgFB+3Ir24pcZsGhGuQ09kx2fAevIOFJ4sV5OlUDlloXfXideL6/j4nL+Kshyc4N5CKh1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=y/0rYQDy; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="y/0rYQDy"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8ca3807494eso292561585a.2
        for <sched-ext@lists.linux.dev>; Mon, 09 Feb 2026 07:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770649244; x=1771254044; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daPkR9K0b30BNvvBLDLeYFMEB45NhHLdGDd7ogPZInU=;
        b=y/0rYQDysMa1TrlcrLgahl70wube9qMbuhd9tXBwBsyq4EVsRRvWn0RgxSIyBG/QRF
         q9nt5pRhumVp+6ucpmb83WD9kq/mPixsIaLmLNDaeCqKfo7bOHFhaCLe0LizG6i0Cj0P
         qkWJ6rb3tcWqA7arVoCJqfOUU0ALsZDbcs5dCxYGvzn224j39NuNKVZ4WosDAxT4qJrt
         0RQry/tQgdg0KCOCQPLWViz7a6vZijGhSeykuc77MA79TSyJLkfhLVyt3C89jKavrbdT
         b65Y67s39sSLyMbfEHe44kano4JxzMPTPsTeKcvVByieMO+hzdn5P0ml3LK2QqT0rgMf
         dgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770649244; x=1771254044;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=daPkR9K0b30BNvvBLDLeYFMEB45NhHLdGDd7ogPZInU=;
        b=Q/ogp3uBfdCWjvpsE1BWIjNkNqR8M6TMqZ9Fm02bu0OEoCeN3ZPKLvEz65Z21qpkG4
         mPv9rNjwK8uHK/8uJOYzi1OaOcwxQ2afBqTXYdkpUk2UF4e+u5ltciFOMebfQTSU0fXK
         6sv0YaBuWt+zuYQK1G6Vr76+G4jrihxxnZI46YnG1EN7PYdDjX5PKtZecItvNihu4zwr
         SOgqbc8WpewJ4IKEO5MaOSR/bmSVaTD2wTKRjRkrEhM+gP8G8tbNCiN/wrvR3O1Eo2Yt
         9vmsYMTY/Sk7fc6cuBKzXsIKUNBbExQgGrKmUN6ZJMmFewj1l/6B9JfwpEf4gw682//O
         nK0A==
X-Forwarded-Encrypted: i=1; AJvYcCWXhwEFI7r5vSu4zviulWS/O4fF+2nL/bl6W2+LZK7xsWBg2uSzaZ4XyB+1ISkyeRk0Oq6Lq8DNdVQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YwgmexbT6GSJGRBe9Gr2XvdKrOm8nyAhNe8BlOwOqTyTf+Flddb
	xAVpyDsOW1j/airT1QJnJ8sKV+bZzar7SldCdj6k/fWiIs7h2Vi1G60TjDBO+dIg7HA=
X-Gm-Gg: AZuq6aIRjkmrzvGP9m0k6fLJzQFfcNIuPOzyVEyL6KldGoHvcS/MxPUsxIqqyV4YWTW
	ehBNL9yfKmZyBC7SUZGVfWC3ZxHFjIZthW/AHUofbU925MwRZ8TaHTDYI5X9NmOi/IvEq7CtGPD
	YNIwMxTbY/daDd/aWSOdYScVxJmqihBuXIEM/4Plr3ChDzi1rD/59mRS3HJh2VBUk6YdeS+Ljdm
	MRgxCKWY9vJrDA+KCPmYmGuhyKdubD0i0XPh60hNgEuFOP6IkJhuUBOur2+xn/OONe3Nhn3WtNG
	INseNk+ls8a0svOXFScAGyPV0MP2KqQTEgBJp7aVauPT2UMusWndccsaNzJ3Vab5wBaejbTaXBf
	aqMm6p1wWled/MB/RR24JbLq6PHOphRSNrv3Abjk09IK5aYReYkQcpM0sa+UEG+bB3CmEph7KU7
	yZUgBOQMgpEoY=
X-Received: by 2002:a05:620a:7014:b0:8c3:650d:577e with SMTP id af79cd13be357-8caeeb51224mr1498903885a.4.1770649243828;
        Mon, 09 Feb 2026 07:00:43 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9a1654dsm829433685a.31.2026.02.09.07.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 07:00:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Feb 2026 10:00:40 -0500
Message-Id: <DGAIRREHTBTV.E8XTJPHQUAN8@etsalapatis.com>
Cc: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Changwoo Min" <changwoo@igalia.com>, "Kuba Piecuch" <jpiecuch@google.com>,
 "Christian Loehle" <christian.loehle@arm.com>, "Daniel Hodges"
 <hodgesd@meta.com>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrea Righi" <arighi@nvidia.com>
X-Mailer: aerc 0.20.1
References: <20260206135742.2339918-1-arighi@nvidia.com>
 <20260206135742.2339918-3-arighi@nvidia.com>
 <DG85HO9OMIUH.278JKOJEN6QPL@etsalapatis.com> <aYcC_aKj_tO62rXZ@gpd4>
 <DG9BLVVE2TJQ.381PKRLX41AM2@etsalapatis.com> <aYhRKbkHf-or9lNO@gpd4>
 <aYhkv2K99aqiuwr5@gpd4> <aYiVv998mfMGVMCq@gpd4>
 <DG9RY7Y4VMWB.2IL8Y6Z4P5IA8@etsalapatis.com> <aYjtOQP0tmGIqoOM@gpd4>
 <aYm00oHl3BRWNFFA@gpd4>
In-Reply-To: <aYm00oHl3BRWNFFA@gpd4>

On Mon Feb 9, 2026 at 5:20 AM EST, Andrea Righi wrote:
> On Sun, Feb 08, 2026 at 09:08:38PM +0100, Andrea Righi wrote:
>> On Sun, Feb 08, 2026 at 12:59:36PM -0500, Emil Tsalapatis wrote:
>> > On Sun Feb 8, 2026 at 8:55 AM EST, Andrea Righi wrote:
>> > > On Sun, Feb 08, 2026 at 11:26:13AM +0100, Andrea Righi wrote:
>> > >> On Sun, Feb 08, 2026 at 10:02:41AM +0100, Andrea Righi wrote:
>> > >> ...
>> > >> > > >> >  - From ops.select_cpu():
>> > >> > > >> >      - scenario 0 (local DSQ): tasks dispatched to the loc=
al DSQ bypass
>> > >> > > >> >        the BPF scheduler entirely; they never enter BPF cu=
stody, so
>> > >> > > >> >        ops.dequeue() is not called,
>> > >> > > >> >      - scenario 1 (global DSQ): tasks dispatched to SCX_DS=
Q_GLOBAL also
>> > >> > > >> >        bypass the BPF scheduler, like the local DSQ; ops.d=
equeue() is
>> > >> > > >> >        not called,
>> > >> > > >> >      - scenario 2 (user DSQ): tasks enter BPF scheduler cu=
stody with full
>> > >> > > >> >        enqueue/dequeue lifecycle tracking and state machin=
e validation
>> > >> > > >> >        (expects 1:1 enqueue/dequeue pairing).
>> > >> > > >>=20
>> > >> > > >> Could you add a note here about why there's no equivalent to=
 scenario 6?
>> > >> > > >> The differentiating factor between that and scenario 2 (nont=
erminal queue) is=20
>> > >> > > >> that scx_dsq_insert_commit() is called regardless of whether=
 the queue is terminal.
>> > >> > > >> And this makes sense since for non-DSQ queues the BPF schedu=
ler can do its
>> > >> > > >> own tracking of enqueue/dequeue (plus it does not make too m=
uch sense to
>> > >> > > >> do BPF-internal enqueueing in select_cpu).
>> > >> > > >>=20
>> > >> > > >> What do you think? If the above makes sense, maybe we should=
 spell it out=20
>> > >> > > >> in the documentation too. Maybe also add it makes no sense t=
o enqueue
>> > >> > > >> in an internal BPF structure from select_cpu - the task is n=
ot yet
>> > >> > > >> enqueued, and would have to go through enqueue anyway.
>> > >> > > >
>> > >> > > > Oh, I just didn't think about it, we can definitely add to op=
s.select_cpu()
>> > >> > > > a scenario equivalent to scenario 6 (push task to the BPF que=
ue).
>> > >> > > >
>> > >> > > > From a practical standpoint the benefits are questionable, bu=
t in the scope
>> > >> > > > of the kselftest I think it makes sense to better validate th=
e entire state
>> > >> > > > machine in all cases. I'll add this scenario as well.
>> > >> > > >
>> > >> > >=20
>> > >> > > That makes sense! Let's add it for completeness. Even if it doe=
sn't make
>> > >> > > sense right now that may change in the future. For example, if =
we end
>> > >> > > up finding a good reason to add the task into an internal struc=
ture from
>> > >> > > .select_cpu(), we may allow the task to be explicitly marked as=
 being in
>> > >> > > the BPF scheduler's custody from a kfunc. Right now we can't do=
 that
>> > >> > > from select_cpu() unless we direct dispatch IIUC.
>> > >> >=20
>> > >> > Ok, I'll send a new patch later with the new scenario included. I=
t should
>> > >> > work already (if done properly in the test case), I think we don'=
t need to
>> > >> > change anything in the kernel.
>> > >>=20
>> > >> Actually I take that back. The internal BPF queue from ops.select_c=
pu()
>> > >> scenario is a bit tricky, because when we return from ops.select_cp=
u()
>> > >> without p->scx.ddsp_dsq_id being set, we don't know if the schedule=
r added
>> > >> the task to an internal BPF queue or simply did nothing.
>> > >>=20
>> > >> We need to add some special logic here, preferably without introduc=
ing
>> > >> overhead just to handle this particular (really uncommon) case. I'l=
l take a
>> > >> look.
>> > >
>> > > The more I think about this, the more it feels wrong to consider a t=
ask as
>> > > being "in BPF scheduler custody" if it is stored in a BPF internal d=
ata
>> > > structure from ops.select_cpu().
>> > >
>> > > At the point where ops.select_cpu() runs, the task has not yet enter=
ed the
>> > > BPF scheduler's queues. While it is technically possible to stash th=
e task
>> > > in some BPF-managed structure from there, doing so should not imply =
full
>> > > scheduler custody.
>> > >
>> > > In particular, we should not trigger ops.dequeue(), because the task=
 has
>> > > not reached the "enqueue" stage of its lifecycle. ops.select_cpu() i=
s
>> > > effectively a pre-enqueue hook, primarily intended as a fast path to=
 bypass
>> > > the scheduler altogether. As such, triggering ops.dequeue() in this =
case
>> > > would not make sense IMHO.
>> > >
>> > > I think it would make more sense to document this behavior explicitl=
y and
>> > > leave the kselftest as is.
>> > >
>> > > Thoughts?
>> >=20
>> > I am going back and forth on this but I think the problem is that the =
enqueue()=20
>> > and dequeue() BPF callbacks we have are not actually symmetrical?=20
>> >=20
>> > 1) ops.enqueue() is "sched-ext specific work for the scheduler core's =
enqueue
>> > method". This is independent on whether the task ends up in BPF custod=
y or not.
>> > It could be in a terminal DSQ, a non-terminal DSQ, or a BPF data struc=
ture.
>> >=20
>> > 2) ops.dequeue() is "remove task from BPF custody". E.g., it is used b=
y the
>> > BPF scheduler to signal whether it should keep a task within its
>> > internal tracking structures.
>> >=20
>> > So the edge case of ops.select_cpu() placing the task in BPF custody i=
s
>> > currently valid. The way I see it, we have two choices in terms of
>> > semantics:
>> >=20
>> > 1) ops.dequeue() must be the equivalent of ops.enqueue(). If the BPF
>> > scheduler writer decides to place a task into BPF custody during the
>> > ops.select_cpu() that's on them. ops.select_cpu() is supposed to be a
>> > pure function providing a hint, anyway. Using it to place a task into
>> > BPF is a bit of an abuse even if allowed.
>> >=20
>> > 2) We interpret ops.dequeue() to mean "dequeue from the BPF scheduler"=
.
>> > In that case we allow the edge case and interpret ops.dequeue() as "th=
e
>> > function that must be called to clear the NEEDS_DEQ/IN_BPF flag", not =
as
>> > the complement of ops.enqueue(). In most cases both will be true, and =
in
>> > the cases where not then it's up to the scheduler writer to understand
>> > the nuance.
>> >=20
>> > I think while 2) is cleaner, it is more involved and honestly kinda
>> > speculative. However, I think it's fair game since once we settle on
>> > the semantics it will be more difficult to change them. Which one do y=
ou=20
>> > think makes more sense?
>>=20
>> Yeah, I'm also going back and forth on this.
>>=20
>> Honestly from a pure theoretical perspective, option (1) feels cleaner t=
o
>> me: when ops.select_cpu() runs, the task has not entered the BPF schedul=
er
>> yet. If we trigger ops.dequeue() in this case, we end up with tasks that
>> are "leaving" the scheduler without ever having entered it, which feels
>> like a violation of the lifecycle model.
>>=20
>> However, from a practical perspective, it's probably more convenient to
>> trigger ops.dequeue() also for tasks that are stored in BPF data structu=
res
>> or user DSQs from ops.select_cpu() as well. If we don't allow that, we
>> can't just silently ignore the behavior and it's also pretty hard to
>> reliably detect and trigger an error for this kind of "abuse" at runtime=
.
>> That means it could easily turn into a source of subtle bugs in the futu=
re,
>> and I don't think documentation alone would be sufficient to prevent tha=
t
>> (the "don't do that" rules are always fragile).
>>=20
>> Therefore, at the moment I'm more inclined to go with option (2), as it
>> provides better robustness and gives schedulers more flexibility.
>
> I'm running into a number of headaches and corner cases if we go with
> option (2)... One of them is the following.
>
> Assume we push tasks into a BPF queue from ops.select_cpu() and pop them
> from ops.dispatch(). The following scenario can happen:
>
>   CPU0                                         CPU1
>   ----                                         ----
>   ops.select_cpu()
>     bpf_map_push_elem(&queue, &pid, 0)
>                                                ops.dispatch()
> 					         bpf_map_pop_elem(&queue, &pid)
> 						 scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | dst_cpu)
> 						   =3D=3D> ops.dequeue() is not triggered!
>     p->scx.flags |=3D SCX_TASK_IN_BPF
>
> To fix this, we would need to always set SCX_TASK_IN_BPF before calling
> ops.select_cpu(), and then clear it again if the task is directly
> dispatched to a terminal DSQ from ops.select_cpu().
>
> However, doing so introduces further problems. In particular, we may end =
up
> triggering spurious ops.dequeue() callbacks, which means we would then ne=
ed
> to distinguish whether a task entered BPF custody via ops.select_cpu() or
> via ops.enqueue(), and handle the two cases differently. Which is also ra=
cy
> and leads to additional locking and complexity.
>
> At that point, it starts to feel like we're over-complicating the design =
to
> support a scenario that is both uncommon and of questionable practical
> value.
>
> Given that, I'd suggest proceeding incrementally: for now, we go with
> option (1), which looks doable without major changes and it probably fixe=
s
> the ops.dequeue() semantics for the majority of use cases (which is alrea=
dy
> a significant improvement over the current state). Once that is in place,
> we can revisit the "store tasks in internal BPF data structures from
> ops.select_cpu()" scenario and see if it's worth supporting it in a clean=
er
> way. WDYT?
>

I agree with going with option 1.=20

For the select_cpu() edge case, how about introducing an explicit=20
kfunc scx_place_in_bpf_custody() later? Placing a task in BPF custody=20
during select_cpu() is already pretty niche, so we can assume the=20
scheduler writer knows what they're doing. In that case, let's let=20
_them_ decide when in select_cpu() the task is considered "in BPF".=20
They can also do their own locking to avoid races with locking on=20
the task context. This keeps the state machine clean for the average
scheduler while still handling the edge case. DYT that would work?


> Thanks,
> -Andrea

