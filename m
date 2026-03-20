Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BE2DC76A
	for <sched-ext@lists.linux.dev>; Fri, 20 Mar 2026 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998304; cv=none; b=mNU4zHQu/kYfHULW2lVO91xQc7+Jk8HG588NJIqgB8YYShW/wiIuiV1b61vKGr7QwYY71L3WVspmtvOHNQD2JAsqRMuijNl0l6tMXukfxGfFhN98FyEzLYGUPy6aT05HNfRDPLQyzVAaMzbx57gMoTm9xevYl5EntfET+vVUIMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998304; c=relaxed/simple;
	bh=HINz8feOpsFhiodrZC++xNu2OiZ1aBWqnsN2/OzOSGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M8fEu76oECNm6JI8TGHuBQDAj/kN1CPToVE8zX5oTCowGiRn6oG+eKl7qIXCgfz2BZg6b+grm6ZFi4xcNa/IDCi/SADjBluaG4TPi9fZx63F+pc4UEqsB8VblKfKAj0QL/8e/Rfa+qCrnQ392BOXvi4ActlmnsV53resBZp/oWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PvpS5oLw; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PvpS5oLw"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4852d27f473so7868755e9.1
        for <sched-ext@lists.linux.dev>; Fri, 20 Mar 2026 02:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773998301; x=1774603101; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQdO70cAPWqKek1gtlbRcpkyz/EKyI3Kx/evAQw8zDs=;
        b=PvpS5oLwSoAfLvsj2wSONku6VkJOAiSDoItwSa5vhqMQC/qd1fkseD2At9w8loPkci
         Q96DMIRiGy9/kjy+hDBpTrik8gqT2/bj1CqtgznBz6JfpDHKcDrvemMHcgHjwhlgf5I4
         s06KOyUOKxweGasnXuKz+Cy/ciwgMaixbJBKGfnhovDFsUtHCfdKg5RRqD57+qWc95OY
         vUJa8rmgAXmaUKji6eFwr2x2chwp6Ojc+ZSA0OZervfd+TEsysAMx4kdU4PD1iEzMOgh
         psyCpt57ItX9P9jf8fY/kOfoYU4+B3HpJfjsWOpLh+ApG3omiMkeupn6ucHRjIp1scSj
         v5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773998301; x=1774603101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQdO70cAPWqKek1gtlbRcpkyz/EKyI3Kx/evAQw8zDs=;
        b=l0EsP4wgEXDQY5BJpyzp7+rYQ2a1o86IhkXxJjXiAAcLBNMT3wLhEKF1wRnQ+1O75D
         4ur3bsllmhTmSzfRPFnNiyqyZH4J2KtdUZ1hGWkeolLATTgW7rdXdcuQAEu/raSszgu4
         fGIH49t+nblQOMAn0889EL78uhOxCMLNBwSEcs4MrH5GVhcb7N6ZmvNnc7kFF7VGvWFd
         LCCVcLWhoDSBp6Jt9YP46GxKP9cPBeYGLaGEGMJciPt9HxzdI57fBpjdaHs/T3Pju+kA
         BG9yUKy9pwxJcplAw5dc5meSrURn+2vPI29gOrz/j3bQl/tVyjUCOrNnqErDzi4b9zVJ
         QpXA==
X-Forwarded-Encrypted: i=1; AJvYcCUVA9IkdwhaM4Nm0Qnp0jKlZIZPGr0E7ngmj6z5+EIUQB4WCYf12uRS8dqr93GcOdfrDl86Wlz1b4k=@lists.linux.dev
X-Gm-Message-State: AOJu0YxTS0YewOWaYhr+DJ06uUBQfhY6p93t+9WVTM0SX9Br8Jtp1SuF
	T6hG/y0H7u3co/RfBo47WI3ci1031fbI2wt4/ZJ2y5XVi0AUV+GkkHvzncE/kRDfFHz9vU7/IH2
	aJcMMOVaOJbU+Ng==
X-Received: from wmjt15.prod.google.com ([2002:a7b:c3cf:0:b0:487:c1:68c5])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3d97:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-486febb5989mr33327835e9.4.1773998301204;
 Fri, 20 Mar 2026 02:18:21 -0700 (PDT)
Date: Fri, 20 Mar 2026 09:18:20 +0000
In-Reply-To: <abxl-xw7nt1jp5qT@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260319083518.94673-1-arighi@nvidia.com> <DH6OUDJUQNA3.6L4YXJMME4KI@google.com>
 <abxl-xw7nt1jp5qT@gpd4>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Christian Loehle <christian.loehle@arm.com>, Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu Mar 19, 2026 at 9:09 PM UTC, Andrea Righi wrote:
> On Thu, Mar 19, 2026 at 10:31:30AM +0000, Kuba Piecuch wrote:
>> On Thu Mar 19, 2026 at 8:35 AM UTC, Andrea Righi wrote:
>> > @@ -2537,9 +2546,26 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
>> >  	}
>> >  
>> >  	if (src_rq != dst_rq &&
>> > -	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
>> > -		dispatch_enqueue(sch, rq, find_global_dsq(sch, task_cpu(p)), p,
>> > -				 enq_flags | SCX_ENQ_CLEAR_OPSS | SCX_ENQ_GDSQ_FALLBACK);
>> > +	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, false))) {
>> > +		/*
>> > +		 * Affinity changed after dispatch decision and the task
>> > +		 * can't run anymore on the destination rq.
>> 
>> More of a nitpick, but this doesn't necessarily mean that the affinity changed.
>> The scheduler could have also issued an invalid dispatch to a CPU outside of
>> the task's cpumask (e.g. due to a bug), in which case the task won't be
>> re-enqueued if we simply drop the dispatch, correct?
>
> That's right, the scheduler could have issues an invalid dispatch and in
> that case we would just drop the task on the floor, which is not really
> nice, it'd be better to immediately error in this case. And we don't need
> the global DSQ fallback, since we're erroring anyway.
>
> I need to rethink this part...

The fundamental problem here is differentiating between buggy dispatches that
should have never been issued and dispatches that were valid at the moment
the BPF scheduler was preparing the task for dispatch, but became invalid due
to racing cpumask changes.

The crucial observation is that SCX will only detect racing dequeues/enqueues
if they race with the window between scx_bpf_dsq_insert() and finish_dispatch().
That's because scx_bpf_dsq_insert() stores a snapshot of the task's current
qseq value, which is compared in finish_dispatch().

The BPF-side cpumask checks traditionally happen outside of this window, making
finish_dispatch() incapable of detecting cpumask changes that raced with the
BPF-side check but happened strictly before scx_bpf_dsq_insert().

To resolve this, we need to extend the race detection window so that it
includes the BPF-side checks.

The simple way to do this is to do scx_bpf_dsq_insert() at the very beginning,
once we know which task we would like to dispatch, and cancel the pending
dispatch via scx_bpf_dispatch_cancel() if any of the pre-dispatch checks fail
on the BPF side. This way, the "critical section" includes BPF-side checks, and
SCX will ignore the dispatch if there was a dequeue/enqueue racing with the
critical section.

With this solution, we can throw an error if task_can_run_on_remote_rq() is
false, because we know that there was no racing cpumask change (if there was,
it would have been caught earlier, in finish_dispatch()).

