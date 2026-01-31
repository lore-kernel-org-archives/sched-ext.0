Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE312363C5D
	for <sched-ext@lists.linux.dev>; Sat, 31 Jan 2026 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769882011; cv=none; b=apu0xqw2KR+Hra8Y118SiY9Ka3QmvUW748/vP7ClwmigzMGNgGvDg2V3wB5fecyOUI0VGtfkV5pgqG4zcsErLttTUb5the6sVnE6TpT/Ot+vMkTK4xXS834SIOY5jq9x9lVVlSjmqGj9++NyeVUoEUPanoHNf4TvvQ4XAKteo8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769882011; c=relaxed/simple;
	bh=0irGEZ08+V/qRYUwn27aProVewgb11GukO6MAntRIcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VhXZs0eSp7c9VRy2ujMvGiZ8OODAMo1p4T+8glIXU4sFMdcjnwaJDmH6ooNBwX5T5m36z4L7/ktSZEhMYUlQe8LAXg6fKdZlr34PgLOXPYFkC8cxq697Yk0XmmbbdaY9EJrWRXjv4zl/Mfb04cpXljKsaH+wddelulUZgD7m0K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N2a0h+XU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2a0h+XU"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-480717a8e05so29700735e9.3
        for <sched-ext@lists.linux.dev>; Sat, 31 Jan 2026 09:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769882008; x=1770486808; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAEV9l2nl/oDQDI4VQvAn/MQQD4yxX75EO20H6p8bGQ=;
        b=N2a0h+XUakeFlywHwrkOEqGwQiDnZRULpD1kfeK/2EpoHe0rAhXrSddXMRKWT72ClS
         Ym1ceOkQpjrOm4/wYO0vTWO79uPDbxI2YDDMUeASy/rgaYbDWsPeU8+Du9mO8X6FgMz9
         u7n+888pil+t0DL/uAjTywr6lXAD4SXgZsELuJ0u5aQDsdC55XM1Y5ZSNosI4M4yg6B5
         Ng2RAibqMCYpwbN3FGO3ezM3KfieS3qpwpSAAUe/HqWXX7lUVUmuKdTQDXFEvtf9qYvf
         aOhgl3azoNCVeOBDqqT4zz4tx4MdPWBb/Ezn3fGApvViYNErqdSF2kd6sq22S+8nNKuy
         Pq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769882008; x=1770486808;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jAEV9l2nl/oDQDI4VQvAn/MQQD4yxX75EO20H6p8bGQ=;
        b=OAv3unRK49hjc1G6pHx4cGvMqg48CqgMzK8VQQE0J0EL27KGRcWy63WZyvgOzppj9y
         2o1Kq4mLrRUp1Ngt2fxz4iutmwhNwN1sZO4Aa0Rj1WQLb7gl3tHqKvDqCcJF3g1ikNJU
         +EnQzdE+AbiJCtsLhXdepGzrwmyVlwuPc/P+2XrsLe/y6HtyMgC5tF9c0F/sJvJGLvuB
         FXSxxJf7NnxFDheNYUpW2ij+qwiHzSqT4OKsEL7JiA3AbBeHbeIdjh9162ZSWpfa/LcO
         RJ7EAJrnk/jcz1hbKXBpn0nXEosojWmi4f2daWzRBVLoBM+W+AaZRvssNWIG776XVpsJ
         4LJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh+UUogiKolRE8spBSctC+Spp2qS6PddCCReQwh3lOZPK3Tn+q1RjuvtLOogBsakGLzSCKxtYh6OI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzoxLCZyHvLivp5ogiUxIG7yOjckqJid/jcx30FE0744j6XpUAb
	RQcKUJ6GEs1pT2nqzNVB9865tBABlwp4/Vv0rG/ix9KurSKMwQkDrttl76hJ+PdRFBXj1Tuvy83
	2S6jMrsN6G/Tn1g==
X-Received: from wmaj4.prod.google.com ([2002:a05:600c:6c04:b0:477:98b9:1e26])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45c5:b0:47d:403e:9cd5 with SMTP id 5b1f17b1804b1-482db45fcb4mr78570415e9.11.1769882008267;
 Sat, 31 Jan 2026 09:53:28 -0800 (PST)
Date: Sat, 31 Jan 2026 17:53:27 +0000
In-Reply-To: <aX3FG00RNMv8VnQQ@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260126084258.3798129-1-arighi@nvidia.com> <20260126084258.3798129-2-arighi@nvidia.com>
 <aXp9xSpYhaysBLQ2@slm.duckdns.org> <DG1WJEB6B0AC.151EBIUYXCR55@google.com> <aX3FG00RNMv8VnQQ@gpd4>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DG2YT5LJFC9T.AXB2OHJBQG4U@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat Jan 31, 2026 at 9:02 AM UTC, Andrea Righi wrote:
> On Fri, Jan 30, 2026 at 11:54:00AM +0000, Kuba Piecuch wrote:
>> Is "local" short for "local or global", i.e. not user-created?
>> Direct dispatching into the global DSQ also shouldn't trigger ops.dequeu=
e(),
>> since dispatch isn't necessary for the task to run. This follows from th=
e last
>> paragraph:
>>=20
>>   Note that, this way, whether ops.dequeue() needs to be called agrees w=
ith
>>   whether the task needs to be dispatched to run.
>>=20
>> I agree with your points, just wanted to clarify this one thing.
>
> I think this should be interpreted as local DSQs only
> (SCX_DSQ_LOCAL / SCX_DSQ_LOCAL_ON), not any built-in DSQ. SCX_DSQ_GLOBAL =
is
> essentially a built-in user DSQ, provided for convenience, it's not reall=
y
> a "direct dispatch" DSQ.

SCX_DSQ_GLOBAL is significantly different from user DSQs, because balance_o=
ne()
can pull tasks directly from SCX_DSQ_GLOBAL, while it cannot pull tasks fro=
m
user-created DSQs.

If a BPF scheduler puts a task onto SCX_DSQ_GLOBAL, then it _must_ be ok wi=
th
balance_one() coming along and pulling that task without the BPF scheduler'=
s
intervention, so in that way I believe SCX_DSQ_GLOBAL is semantically quite
similar to local DSQs.

>> Here's my attempt at documenting this behavior:
>>=20
>> After ops.enqueue() is called on a task, the task is owned by the BPF
>> scheduler, provided the task wasn't direct-dispatched to a local/global =
DSQ.
>> When a task is owned by the BPF scheduler, the scheduler needs to dispat=
ch the
>> task to a local/global DSQ in order for it to run.
>> When the BPF scheduler loses ownership of the task, either due to dispat=
ching it
>> to a local/global DSQ or due to external events (core-sched pick, CPU
>> migration, scheduling property changes), the BPF scheduler is notified t=
hrough
>> ops.dequeue() with appropriate flags (TBD).
>
> This looks good overall, except for the global DSQ part. Also, it might b=
e
> better to avoid the term =E2=80=9Cowned=E2=80=9D, internally the kernel a=
lready uses the
> concept of "task ownership" with a different meaning (see
> https://lore.kernel.org/all/aVHAZNbIJLLBHEXY@slm.duckdns.org), and reusin=
g
> it here could be misleading.
>
> With that in mind, I'd probably rephrase your documentation along these
> lines:
>
> After ops.enqueue() is called, the task is considered *enqueued* by the B=
PF
> scheduler, unless it is directly dispatched to a local DSQ (via
> SCX_DSQ_LOCAL or SCX_DSQ_LOCAL_ON).
>
> While a task is enqueued, the BPF scheduler must explicitly dispatch it t=
o
> a DSQ in order for it to run.
>
> When a task leaves the enqueued state (either because it is dispatched to=
 a
> non-local DSQ, or due to external events such as a core-sched pick, CPU

Shouldn't it be "dispatched to a local DSQ"?

> migration, or scheduling property changes), ops.dequeue() is invoked to
> notify the BPF scheduler, with flags indicating the reason for the dequeu=
e:
> regular dispatch dequeues have no flags set, whereas dequeues triggered b=
y
> scheduling property changes are reported with SCX_DEQ_SCHED_CHANGE.

Core-sched dequeues also have a dedicated flag, it should probably be inclu=
ded
here.

>
> What do you think?

I think using the term "enqueued" isn't very good either since it results i=
n
two ways in which a task can be considered enqueued:

1. Between ops.enqueue() and ops.dequeue()
2. Between enqueue_task_scx() and dequeue_task_scx()

The two are not equivalent, since a task that's running is not enqueued
according to 1. but is enqueued according to 2.

I would be ok with it if we change it to something unambiguous, e.g.
"BPF-enqueued", although that poses a risk of people getting lazy and using
"enqueued" anyway.

Some potential alternative terms: "resident"/"BPF-resident",
"managed"/"BPF-managed", "dispatchable", "pending dispatch",
or simply "pending".

Thanks,
Kuba

