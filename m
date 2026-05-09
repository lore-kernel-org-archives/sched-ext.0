Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ADB383C6F
	for <sched-ext@lists.linux.dev>; Sat,  9 May 2026 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778311120; cv=none; b=ZQHHptoZDr4S8Nq5zzcDsGyte0/Wn5GDMWxb6vIwOonAauHI0Lrc/SwlAq8hVIo0Fy2eORoW1azxfIcYL6ohpI/ZvV6xLmm9zTANr3HivOrt+OTU3sMA+WXpax3FKkkVPG3g/z37gzBultl/AhVGTjTvJ4Xb7Tvey54Y2isGHWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778311120; c=relaxed/simple;
	bh=o7CPCGXOj2haokXsQESfPJhyteLvwzZMKjC6vcdU+L8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gK31qQqhgkdbDSFGvpJTEovKFmDWnPKgrcT+SCqBQYDsU8Ijhk4gETBk0A8YGOsH/OGbWNuu7mGzqoVNR5k3I4K5aklBOrX1Z7BgP/crAqXLR+SeHENmBS1Y7ydJ7zWYicqlBp1aFb6JQg6QxAuYfo8VNcyIRLZOS+Up/BgAMl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXURPV2O; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXURPV2O"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b8704795d25so235924466b.2
        for <sched-ext@lists.linux.dev>; Sat, 09 May 2026 00:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778311116; x=1778915916; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWPmLPcUZniG40mmE6xEF7MYszlEp9VqvWN3AMo3/Bg=;
        b=DXURPV2OtbqVFBE4VHc8aeCBBsNYTuXqxPRvZmT4pP9hwjTtcDq/ZVcp95hdKvncx3
         52faBFFT7G/7BJ+8cycyL+Us2qAFiZSWmw/QmvxpBF/4MXBzagOuMLiAQJDCzvk6YpJ0
         cqVc8Xd4op0bqZVJjs+pLaF6bN4jMdO0gBWS3AKROSQXwyF4jsJGeA3m/4TpvNTKq3bn
         jqXnP7wZMbOq+D4/A3vFvQnSA4qJ0WUWcDVG51RXdXSr8vDQmugWbyS6d0e3FeJA+U4J
         9ImdC7ojnYHdtDcCO/chwsTEo5/ewVTYyxEVzW7/gwjFZGsfbxNb/WqOvy0AVlSHHSap
         yrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778311116; x=1778915916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWPmLPcUZniG40mmE6xEF7MYszlEp9VqvWN3AMo3/Bg=;
        b=eZnHkshaQcUDOUsvf17mwhCU57wVl1KT5SA5nc6BqeKUvrsdoDuVLw+sz36tKyYPP/
         2FhQlrE7TmUSs6LasAMK1jvUSKRgxbC6G2lAHUaLtineHWciKtqiu9j5qNhrx3oDdYYL
         lPc1pfzRWjR5FVtg4ZKY4LoYaaf+i/G95kZ+RYoqfmSrHBsGTi/aqT5BDSW7L5au0rTW
         IeZcLbWseCgQHmS0w7W6flNwg+pye66QjrXllVblEbUpCXSdbrTOthQHuov2ipWPeuyF
         AMTEmGL481+tKCC+HOjhABLG/6hdr/NJLr+AdilnuGm+DSPBhPoqprD7G3r2mZFoDPzM
         fHZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kMYQYL0YWkV7axci5lAgAC3Pe4eNtRK8sUSMWe1yoxoKY7UNDNzt29FovE7RbtS8kFNkL0/By6qc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzwKGN3JebbCIok0NodaGFzBT1vQJhSAhR9h1DOq80wd/lAnNPM
	qp8nRaGIEms0oTWsKqd0J9HGEOrlNzIsMo5kmdCYmKyMNw+q2Xi2GNUInPLm8Mw2lqFeg+32lGl
	kcnnl0oRayOWopX6omw==
X-Received: from ejcbu12.prod.google.com ([2002:a17:907:930c:b0:bca:912a:8b1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3e93:b0:ba3:a8ef:3597 with SMTP id a640c23a62f3a-bc56c72d655mr930748266b.25.1778311115972;
 Sat, 09 May 2026 00:18:35 -0700 (PDT)
Date: Sat, 9 May 2026 07:18:34 +0000
In-Reply-To: <20260508200157.kWPZI3p3@linutronix.de>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260508-put-task-struct-many-v1-1-8341c18141a6@google.com> <20260508200157.kWPZI3p3@linutronix.de>
Message-ID: <af7fym1VhjYMw_h4@google.com>
Subject: Re: [PATCH] sched/task: always defer 'struct task_struct' destruction
 via RCU
From: Alice Ryhl <aliceryhl@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Andrea Righi <arighi@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
	Changwoo Min <changwoo@igalia.com>, Clark Williams <clrkwllms@kernel.org>, 
	David Vernet <void@manifault.com>, Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, io-uring@vger.kernel.org, rcu@vger.kernel.org, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Fri, May 08, 2026 at 10:01:57PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-05-08 14:02:45 [+0000], Alice Ryhl wrote:
> > The sched/task.h header file currently exposes a tryget_task_struct()
> > function, but it is very risky to use it: If the last refcount of the
> > task is dropped using put_task_struct_many(), then the task is freed
> > right away without an RCU grace period.
> > 
> > This means that if the kernel contains a code path anywhere such that
> > the last refcount of a task may be dropped with put_task_struct_many(),
> > and it also contains a code path anywhere that tries to stash a task
> > pointer under rcu and use tryget_task_struct() on it, then if they ever
> > execute on the same 'struct task_struct', it results in a
> > use-after-free.
> 
> If the counter dropped to 0 then tryget_task_struct() won't increment
> it.

Yes. If the 'struct task_struct' hasn't been freed yet. What is the
scenario where it might be zero, but you are certain it is not yet
freed? If not rcu, then I guess this applies only to those cases where
__put_task_struct() itself removes the task from the relevant collection
when 'users' hits zero.

If tryget_task_struct() can only safely be used in that scenario, then I
think that's worth at least a comment in the header file, because at
first glance it's a surprising limitation.

> There is also task_struct::rcu_users which holds one `usage' on it
> and this RCU grace period we care about.

Sure, but I guess my question is: why does tryget_task_struct() exist?
The 'rcu_users' field is not the reason because 'usage' can't be zero
when using that field.

Alice

> The only reason why there is a RCU free here is because of RT and it was
> limited to RT only. Then a PI case came up (on RT again) I asked
> repeatedly to have it unconditional on RT and !RT. Which then did
> happen.
> 
> I don't think I would mind to align the two code paths but not as a
> "this might be UAF if" but to do the same "thing". The important RCU
> grace period happens via put_task_struct_rcu_user().
> 
> Sebastian
