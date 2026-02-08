Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7192E7648
	for <sched-ext@lists.linux.dev>; Sun,  8 Feb 2026 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770573579; cv=none; b=k0xeHaaTdNTYEKVfhSSNmcMMhfqyv2PzadrrqRM6x74Qxg4+bpw+6NOvuo0eMj0/VdLQqOcWnsxpZkZXHYgj27kjyLuqjt21jxNFY/7kMznbC2lMEP44aRiaMAjrxRr5o7zUWrz0nVvDy3Rxu0EPa97JtSY7j96m+C5j5n94YcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770573579; c=relaxed/simple;
	bh=zMcfca0X5VThFA9j0nAmI4dEJJ0zfPZ6AWVf8vT0QBo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=gPG6Mx5ddhDLmL+KKpVOaM2leCbEJdPxKDZCRUTXEowRKZpvqRkrUmw8F+HwffoV6ytsS8vkPxebVIv3QJqTPo9KG6LBBgPTTooXPCgOjzlNl1rp4uRqYSpnZtRU0+nb2jgVSM6Il2d1Y9F6uPOyX3Ha8hKjsMoLkeCaXxIrjco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=gEFKaLyO; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="gEFKaLyO"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c70ce93afaso394618485a.0
        for <sched-ext@lists.linux.dev>; Sun, 08 Feb 2026 09:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770573578; x=1771178378; darn=lists.linux.dev;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+LW08Zb0i/6FTaN/ZmjBAf4wAOOpN1TIoml3WmBDAM=;
        b=gEFKaLyON4znzGPXcgskXRDmkPwkxdw84DBHVHdZkdhU/dgYw2opWDOyjtjBxtwD8P
         OfYZSqbtAoTEku7Bjt/tfgqpKSKdYq7X7FNtRPntoe45lLbVdnxvGmDpRC404eE9vDr7
         to9XHhVCbfvfdzwynHzPFH3rlpLqhXNMgyKqazfwmtR+pmtKQin4CQyx2NCN1hRNi+NZ
         1JOihX9vmNraDVcpq1vSLi1/Ax6KExyFOpSGLyd6Y2qKcilQbLeQt1ZcGjoNutIF8vmL
         MLB4crHXxScgP+1gDa5L6CZJPHD2DUqb7izEZ93HA7ZvpGjK80lowz/JsnQjc4frAe0J
         nvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770573578; x=1771178378;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+LW08Zb0i/6FTaN/ZmjBAf4wAOOpN1TIoml3WmBDAM=;
        b=EaUtT9XQWCHJn7MSFtMSmL2x8EcPGjn19vZzicWhgbVUQ60EoL4UvRuAUZS47z9bwf
         K6zuuacdjx6F15xqds3QinFjlbep7bpUNJVIFfBhIjiz62terkYgpEDMfzHi2q/ux6wY
         KNdfSS1PFxzDsOT7K8A4w8+jXjeAaTd8YUNwb7wvmttfeF9sJlcCT+AK6Sj0Ko4+IzMJ
         R4zqOIBZKGL0Zk+D64ZnI023Bx1azFDSZN0dqLNgbhbGDGHnXU7lhjiZaS8eVE0m9McU
         BurVcb2f8EMyhzR5qxNcM36Kf9MkDe4G0jNb5Rqqk6PNrpAL5sIMCWMAvY9vQn78//eA
         1ziw==
X-Forwarded-Encrypted: i=1; AJvYcCVmpoLenY6eS5F2l8fxPnOupMIPw1DJjwHrbrVqSYS7zLU1Y2QdwJ+G+zeBnJVM/yqGk24oYPGN3Rg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzlgZdGmaigNvpPcV8F+D67otbWgaB/6iVmijcX37mlA3RBR4hp
	tDtMzeVVaIkvR34Jv7YsYevYea/K5YZQa+IMWikQu1R924MukS5jlzf+9/vH/iObWus=
X-Gm-Gg: AZuq6aIwsnQo90wxYllC1Q7WJIjqLvUW+kRnG2qw9pU5NIlnstghLSFBKi+MYS+KI7F
	ph21f3zdMJ6lVsrhFu/FBMDSCWZ0xsZt+85Sk5RIKnF9iLBeF7pB9bnOAY9QXJjfZWvGzMlHdwl
	7hpbP4mugh56vmUiIoJxFJW13Dy8dk97JRQkMrAc8xipSaYJRD3qjvside4w+AGhJHBBinLzYRr
	KG7pVhf9pwCX+1MkarjEszWG4+9dtiXTN0xkNruXgCXLVLEShgG3raDpogqQGThrlXiU6uhGdrb
	2KW9NpqrR28QKm2O/QhD8dMwDFev6VKCAEX3zlCP7mMwJXe2BrO+WEM5LNMjxaPn/6glA8D4nf2
	PysaR9OwYG9PnSh6g1+S4mmCKnTlcGLvK5OKj7MAYm4Q+Dtl7xeKg/QftqIPRviKzHY9aF5lI2N
	Ym7dm7wk1zkqk=
X-Received: by 2002:a05:620a:2a07:b0:8c9:ea6f:6a4a with SMTP id af79cd13be357-8caf2594195mr1190220285a.78.1770573577818;
        Sun, 08 Feb 2026 09:59:37 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf3c740sm61559046d6.11.2026.02.08.09.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 09:59:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Feb 2026 12:59:36 -0500
Message-Id: <DG9RY7Y4VMWB.2IL8Y6Z4P5IA8@etsalapatis.com>
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add test to validate
 ops.dequeue() semantics
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrea Righi" <arighi@nvidia.com>
Cc: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>,
 "Changwoo Min" <changwoo@igalia.com>, "Kuba Piecuch" <jpiecuch@google.com>,
 "Christian Loehle" <christian.loehle@arm.com>, "Daniel Hodges"
 <hodgesd@meta.com>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260206135742.2339918-1-arighi@nvidia.com>
 <20260206135742.2339918-3-arighi@nvidia.com>
 <DG85HO9OMIUH.278JKOJEN6QPL@etsalapatis.com> <aYcC_aKj_tO62rXZ@gpd4>
 <DG9BLVVE2TJQ.381PKRLX41AM2@etsalapatis.com> <aYhRKbkHf-or9lNO@gpd4>
 <aYhkv2K99aqiuwr5@gpd4> <aYiVv998mfMGVMCq@gpd4>
In-Reply-To: <aYiVv998mfMGVMCq@gpd4>

On Sun Feb 8, 2026 at 8:55 AM EST, Andrea Righi wrote:
> On Sun, Feb 08, 2026 at 11:26:13AM +0100, Andrea Righi wrote:
>> On Sun, Feb 08, 2026 at 10:02:41AM +0100, Andrea Righi wrote:
>> ...
>> > > >> >  - From ops.select_cpu():
>> > > >> >      - scenario 0 (local DSQ): tasks dispatched to the local DS=
Q bypass
>> > > >> >        the BPF scheduler entirely; they never enter BPF custody=
, so
>> > > >> >        ops.dequeue() is not called,
>> > > >> >      - scenario 1 (global DSQ): tasks dispatched to SCX_DSQ_GLO=
BAL also
>> > > >> >        bypass the BPF scheduler, like the local DSQ; ops.dequeu=
e() is
>> > > >> >        not called,
>> > > >> >      - scenario 2 (user DSQ): tasks enter BPF scheduler custody=
 with full
>> > > >> >        enqueue/dequeue lifecycle tracking and state machine val=
idation
>> > > >> >        (expects 1:1 enqueue/dequeue pairing).
>> > > >>=20
>> > > >> Could you add a note here about why there's no equivalent to scen=
ario 6?
>> > > >> The differentiating factor between that and scenario 2 (nontermin=
al queue) is=20
>> > > >> that scx_dsq_insert_commit() is called regardless of whether the =
queue is terminal.
>> > > >> And this makes sense since for non-DSQ queues the BPF scheduler c=
an do its
>> > > >> own tracking of enqueue/dequeue (plus it does not make too much s=
ense to
>> > > >> do BPF-internal enqueueing in select_cpu).
>> > > >>=20
>> > > >> What do you think? If the above makes sense, maybe we should spel=
l it out=20
>> > > >> in the documentation too. Maybe also add it makes no sense to enq=
ueue
>> > > >> in an internal BPF structure from select_cpu - the task is not ye=
t
>> > > >> enqueued, and would have to go through enqueue anyway.
>> > > >
>> > > > Oh, I just didn't think about it, we can definitely add to ops.sel=
ect_cpu()
>> > > > a scenario equivalent to scenario 6 (push task to the BPF queue).
>> > > >
>> > > > From a practical standpoint the benefits are questionable, but in =
the scope
>> > > > of the kselftest I think it makes sense to better validate the ent=
ire state
>> > > > machine in all cases. I'll add this scenario as well.
>> > > >
>> > >=20
>> > > That makes sense! Let's add it for completeness. Even if it doesn't =
make
>> > > sense right now that may change in the future. For example, if we en=
d
>> > > up finding a good reason to add the task into an internal structure =
from
>> > > .select_cpu(), we may allow the task to be explicitly marked as bein=
g in
>> > > the BPF scheduler's custody from a kfunc. Right now we can't do that
>> > > from select_cpu() unless we direct dispatch IIUC.
>> >=20
>> > Ok, I'll send a new patch later with the new scenario included. It sho=
uld
>> > work already (if done properly in the test case), I think we don't nee=
d to
>> > change anything in the kernel.
>>=20
>> Actually I take that back. The internal BPF queue from ops.select_cpu()
>> scenario is a bit tricky, because when we return from ops.select_cpu()
>> without p->scx.ddsp_dsq_id being set, we don't know if the scheduler add=
ed
>> the task to an internal BPF queue or simply did nothing.
>>=20
>> We need to add some special logic here, preferably without introducing
>> overhead just to handle this particular (really uncommon) case. I'll tak=
e a
>> look.
>
> The more I think about this, the more it feels wrong to consider a task a=
s
> being "in BPF scheduler custody" if it is stored in a BPF internal data
> structure from ops.select_cpu().
>
> At the point where ops.select_cpu() runs, the task has not yet entered th=
e
> BPF scheduler's queues. While it is technically possible to stash the tas=
k
> in some BPF-managed structure from there, doing so should not imply full
> scheduler custody.
>
> In particular, we should not trigger ops.dequeue(), because the task has
> not reached the "enqueue" stage of its lifecycle. ops.select_cpu() is
> effectively a pre-enqueue hook, primarily intended as a fast path to bypa=
ss
> the scheduler altogether. As such, triggering ops.dequeue() in this case
> would not make sense IMHO.
>
> I think it would make more sense to document this behavior explicitly and
> leave the kselftest as is.
>
> Thoughts?

I am going back and forth on this but I think the problem is that the enque=
ue()=20
and dequeue() BPF callbacks we have are not actually symmetrical?=20

1) ops.enqueue() is "sched-ext specific work for the scheduler core's enque=
ue
method". This is independent on whether the task ends up in BPF custody or =
not.
It could be in a terminal DSQ, a non-terminal DSQ, or a BPF data structure.

2) ops.dequeue() is "remove task from BPF custody". E.g., it is used by the
BPF scheduler to signal whether it should keep a task within its
internal tracking structures.

So the edge case of ops.select_cpu() placing the task in BPF custody is
currently valid. The way I see it, we have two choices in terms of
semantics:

1) ops.dequeue() must be the equivalent of ops.enqueue(). If the BPF
scheduler writer decides to place a task into BPF custody during the
ops.select_cpu() that's on them. ops.select_cpu() is supposed to be a
pure function providing a hint, anyway. Using it to place a task into
BPF is a bit of an abuse even if allowed.

2) We interpret ops.dequeue() to mean "dequeue from the BPF scheduler".
In that case we allow the edge case and interpret ops.dequeue() as "the
function that must be called to clear the NEEDS_DEQ/IN_BPF flag", not as
the complement of ops.enqueue(). In most cases both will be true, and in
the cases where not then it's up to the scheduler writer to understand
the nuance.

I think while 2) is cleaner, it is more involved and honestly kinda
speculative. However, I think it's fair game since once we settle on
the semantics it will be more difficult to change them. Which one do you=20
think makes more sense?

>
> Thanks,
> -Andrea

