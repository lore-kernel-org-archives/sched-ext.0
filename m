Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2197F27FD51
	for <sched-ext@lists.linux.dev>; Wed,  8 Apr 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657828; cv=none; b=tUqzpw1RUjQqdmxa3qvV/bTVtzJSzWrsCDuMhuub9ltIQwWqQog77rcc++jxSCSYTcid85FDOvWhcBVgm86Fl3+c5BSfqSHtNzt7XPbE/bAsughfv+GNUFHtXZx9G0O++wJrBmQNqlBc3WqGaU57Wiq/F+b3K5d3b0OkGCZp8is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657828; c=relaxed/simple;
	bh=nSI338Ccn8ILyzTjAkaW21CrjBT7dTNzQLbIMCA+rCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IhR5l/d+0EqT2LfA/nMS5IMP/oRYLR0tjBbyEKOurG+/XQ4AL8XzrCcJlAjK00iZoqMQGQz2llN+YEjf2hm+Otvs/y50q4wx+depkv7maMcJqMfjqm1UaGR0v/hoqnhx2UtPpZr9iW0kVDN76xLmFKlA6kRNUWItvYQPP7SR/w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vceEvTUL; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vceEvTUL"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b9ca1ef3403so315915866b.1
        for <sched-ext@lists.linux.dev>; Wed, 08 Apr 2026 07:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775657825; x=1776262625; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Upw3TvEeXMqMSg5wbe3ZInJcp8Ry8VNUQGJklwbJAiU=;
        b=vceEvTULuo7RvSHnIvVvlmhQEXDLf6YKnN/eHpxGLdoH9ZwO50Db3k5kOxXgrrPtTv
         kj8iX9ll377UsX6K+EJgoUcl9fmoboUTnKmrzcekyvU90H/+huWJMiJRZ11pFJIBHfib
         hhRaj4l+gj1HTdZskSTePnUqEb9+7TkUp4QqOQFTO1+LHo9iOEBG5Kg3ezCAZ5wrALQY
         Uyhk8NXKyw/eSL3Uog9Vvoxqu3dDysEOpl4U432v+l1K/WwbhDpSfK0gUVxzwmVth/UF
         ExBoGHzxJVl5W1Vlfoj6CxD+d6e90RQYcfze3hThmcyHPE/IAPy9t79Wbb63XDoJq6Av
         4niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775657825; x=1776262625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Upw3TvEeXMqMSg5wbe3ZInJcp8Ry8VNUQGJklwbJAiU=;
        b=Nc3sCLxxanA8yIWoZNEJpU82XeqLxDbO/n+APHYVrJrGLWlaUhr2aG+Itu4MlyLlik
         3x4iOElw2EMFjav8HerhmfVHislw12usn3VAWyawBuEh1/1UB0bOg6bZmJ+T6sGvmQXq
         EC16NtcPjHAQRUzz1dYKRRpTcJLfoeG/lXpNjzrF7qCtF4NtP6J3s2u0RpFGlLvyn4wN
         u6IIp1T5WM/RBt/lLj/CF+glmnbT88/nk5ydNoktRIE+U93Kn7KPuzUVb0sRTjxM7dko
         jOhgwc9SNF71/E88oGiP0UHSeWTSqV8+0CxK9luXGFdmmdu2z4MTJunyfB9uh+7IDo1g
         P/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY0tKLeJwVDZEiT+O9FyvfDoTyMNFVl5vZ5gdt/whIGF1GFcjYFvqzTJ5QRD4gLs22NyyjfEjviDs=@lists.linux.dev
X-Gm-Message-State: AOJu0YyL/AqHWBkA2A6Clpt0bik5UIodkmcd4FE5lvpFtDV8DuoSngBu
	q7MI2Y5q3mxjKmy+sTDuRpXV2DfDGAS0oHxFFIDk6J+nhq8fKHh3aaS0sUhxUUZo6j2FweUP/2g
	aTh/G2ZlLfLUi4Q==
X-Received: from ejcdm17.prod.google.com ([2002:a17:907:9491:b0:b9c:3a86:44b2])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c011:b0:b98:8365:be with SMTP id a640c23a62f3a-b9c6795190cmr995024666b.25.1775657824169;
 Wed, 08 Apr 2026 07:17:04 -0700 (PDT)
Date: Wed, 08 Apr 2026 14:17:03 +0000
In-Reply-To: <adZc8caEfOZw8TLE@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <adUxZ5Qp_vH6cBZj@gpd4> <20260408091821.91063-1-jpiecuch@google.com>
 <adY76wiI82pUBYkr@gpd4> <DHNS3RWRB1C5.29B8SXO481CHK@google.com> <adZc8caEfOZw8TLE@gpd4>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DHNU5YSWABWC.2B8Q38OKJGVDR@google.com>
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Documentation: Add missing
 calls to quiescent(), runnable()
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Christian Loehle <christian.loehle@arm.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed Apr 8, 2026 at 1:49 PM UTC, Andrea Righi wrote:
> On Wed, Apr 08, 2026 at 12:40:09PM +0000, Kuba Piecuch wrote:
>> Hi Andrea,
>> 
>> On Wed Apr 8, 2026 at 11:28 AM UTC, Andrea Righi wrote:
>> ...
>> >
>> > Looks good, but I noticed another issue, should we also change the condition up
>> > above as following?
>> >
>> >  Documentation/scheduler/sched-ext.rst | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
>> > index 29d36e248f58b..99df4cc982375 100644
>> > --- a/Documentation/scheduler/sched-ext.rst
>> > +++ b/Documentation/scheduler/sched-ext.rst
>> > @@ -423,7 +423,7 @@ by a sched_ext scheduler:
>> >          ops.runnable();         /* Task becomes ready to run */
>> >  
>> >          while (task_is_runnable(task)) {
>> > -            if (task is not in a DSQ && task->scx.slice == 0) {
>> > +            if (task is not in a DSQ || task->scx.slice == 0) {
>> >                  ops.enqueue();  /* Task can be added to a DSQ */
>> >  
>> >                  /* Task property change (i.e., affinity, nice, etc.)? */
>> >
>> > Because we trigger ops.enqueue() when the task expired its time slice or it
>> > becomes runnable and has not been added to a DSQ.
>> >
>> > This also represents correctly the sched_change() scenario: a task being
>> > re-enqueued after sched_change() still has its time slice > 0, but we need to
>> > call ops.enqueue() for it.
>> 
>> I agree that the condition should be changed, but I'm not sure that this is
>> what it should look like.
>> 
>> Is the "task is not in a DSQ" part of the condition there to handle direct
>> dispatch? Apart from direct dispatch from ops.select_cpu(), I wasn't able to
>> come up with a situation where we would reach this condition with the task
>> present on some DSQ.
>
> The intent is to represent the direct dispatch from ops.select_cpu(), since in
> that case ops.enqueue() is skipped.
>
> Honestly I think if we change the && to || in that condition, everything should
> be pretty accurate.

In the case of direct dispatch from ops.select_cpu() we don't invoke
ops.dispatch() and ops.dequeue() before ops.running(), right? The current
pseudocode calls them unconditionally.

Another inaccuracy not related to direct dispatch: property changes can occur
while a task is running, while the psedocode only allows for property changes
while a task is queued.

There's also preemption by a higher sched class, which is not covered in the
loop condition (task_is_runnable(task) && task->scx.slice > 0), unless we take
task_is_runnable() to return false if there's a higher-priority sched class
with runnable tasks on the CPU, though that would be in conflict with the
actual implementation of task_is_runnable() in include/linux/sched.h.

>
>> 
>> A more general comment about the pseudocode: I think it can be useful to
>> introduce someone new to the general flow of the callbacks in sched_ext,
>> but the documentation should be clear that this is a simplified view that
>> makes assumptions about the behavior of the BPF scheduler itself (flags like
>> SCX_OPS_ENQ_LAST, whether the scheduler uses direct dispatch), as well as
>> the overall system (Can sched_ext be preempted by a higher-priority sched
>> class? Can scheduling properties of a task be changed while it's running?)
>> Without stating these assumptions clearly, we risk leaving the reader falsely
>> believing they have a complete understanding.
>
> Of course this schema is not a complete representation of the entire sched_ext
> state machine, if we put everything it'd become too big and complex. I think we
> should just cover the most common use cases here. Maybe we can clarify this in
> the description before this diagram.

Let's agree on what inaccuracies need to be fixed and I'll send a v2 with fixes
and attach an appropriate disclaimer to the pseudocode.


