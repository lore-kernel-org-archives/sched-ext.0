Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380C1E4AB
	for <sched-ext@lists.linux.dev>; Sat,  6 Dec 2025 04:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764996590; cv=none; b=WN/vF/nMZpZMlJhLTPUU9ircaNWE7vS67C7oPHm7tw8y3oy2BcQg9nMpTSUIylI72sFlLzArqSYj4EMYc05vAhta8wpAxlLyGFyLorXpbky02kt7NmGtFFcNtAmo5E5WeSgh7YmWOeIff5DsT99yHexPKKcY2eF824I8k0Gub8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764996590; c=relaxed/simple;
	bh=PVla2HWFHCubLU+BnMAWsZCs6vSlO4ARtlc5O9GBLqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKIBAW2FSeagwvEfeaqHHy9bjTTRVEqRbEAvibRfo9rAxN2tJqfQITD3aQLDnI2dOWdsmzYCg6lt+WG3TFbOcjde+6Cp3DZ7dJwosGA0faTzl+4AMesgZng4tuGmuY+GRh+vCYpNHmXpCPAS7YEh834KkC5aCj5X1xkd6vIaIJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtxOSxp2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtxOSxp2"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7277324054so391051266b.0
        for <sched-ext@lists.linux.dev>; Fri, 05 Dec 2025 20:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764996587; x=1765601387; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uyIpOopV3j2L3uNFBG5S4/Ap/3aZr4ESjaTqSj0xBw=;
        b=dtxOSxp2N2EiPJEFSwafKcjXnBwWX5fimDjLWUJTGBvF+ZTgTSNo8lngQPr6AuO9Iz
         aw0taBi5FHsN/COdbNPlhS6e90RZ9WP3xyCUYcNBCIoDg8r32luoxI2WoiNlVGET7h9p
         HSpBAQMTltPY+NYhWEjbFNLcHLHr4G3Dc9cEacg4OORySpBu6iLBirhDev3Q+9yoSpoP
         UjTs42W4sLmBIuBoLKCWcL3gwRN6EQjRPn+b12gJKox0fw1RvAZWq9+X++d9E8f4/ib2
         objS5YwUWABi7SAT3MNUA1MCjAKVrK1GdpsA0nCW4h0X+nvaJARX9+3NHY39Tci4GJxL
         ctFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764996587; x=1765601387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4uyIpOopV3j2L3uNFBG5S4/Ap/3aZr4ESjaTqSj0xBw=;
        b=Gqxxsso28rju/4/qo4iHb+mPP9FAqn8llcRqrBcghjQdjt0uUzY+V3n7/vLr4SCTkF
         Qn+l1B3gu0zLgBpxzWzBx3AWGzWWlgWd0ezAOorRYk7JEySk8HCaRU50xHNQWR2dR16y
         zogzVe8wSEZdb9sDpW2XgZe6NGy7aG3kKshLxEmVHHz2Vqzl60oqkkXKFoAG4JZZbNur
         Lg+38x4bKmusSw7HPWYjpaKmurYoAUl4eLSJCsz3u6whkhnVYsRWkWM3ITm5DqIBjy+j
         l9YU/EJcdSQDkEphAHaDNfb2Q6F4pT3xl8i7XGBgDaMZWDAX/NV2PCUZTQVBrIMTVVtK
         4H1A==
X-Forwarded-Encrypted: i=1; AJvYcCU97h4afTH8BO15c1cqtvpl+oTL08yNyerDrmsEdMxC6pTQXU+wFA0F6370fgMP9PCHfBg7Obo/iSw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzen1cuLoH/MD75TX+/NAw9QnOYb1gEJNFpnJ0l7L6/es7M3QQl
	3xTAZ2ga11UvfUT8z+p8YrcYr044GWdAvLkzilDhN7+PT0czZRWjE6LXE+3FwHs8GJpMO3F6ycL
	0NC5FJ7Py/GK8OfF9jaD4su5ANgkjqCVqBIwR5fM=
X-Gm-Gg: ASbGncuanENowsyumxytDp2VN8xyuOc5rfjIKfgmpHtecd0HaAvx/SbhCn48x2YnvUX
	6m31FVEE45varkzliktF2dpc4rSQFdiILrfIWkeA2qGOScFN4A7Hn20lcPAGK+dvIZG3sC62Hbo
	F5+/HMvnqERkWnb17WwwyxW5qiGaiJ0gxqpECg9oupb88fo0DEfXu59VuXTsqG545M0byKOyuVg
	Iip2oJB//WcUiEn8vjvohff3w02yhMs0yN78rhS00LBZiYdBeHIi7O9SkwRg6XyNpQJgvHOIEb2
	Kg7J5Abm6HJtjyYUURW3fd85
X-Google-Smtp-Source: AGHT+IFUxoHcbWsXRPteuEjWOcF0rt7a8AIUU498nWX6dys9F2sUNUTu7ZPgus1K0tQfHHT7y64QfFvybT1nVUWXk3g=
X-Received: by 2002:a17:907:7b9e:b0:b73:8d2e:2d38 with SMTP id
 a640c23a62f3a-b7a2455ea9fmr136923466b.50.1764996587195; Fri, 05 Dec 2025
 20:49:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251206001451.1418225-1-jstultz@google.com> <20251206024724.GA71744@joelbox2>
In-Reply-To: <20251206024724.GA71744@joelbox2>
From: John Stultz <jstultz@google.com>
Date: Fri, 5 Dec 2025 20:49:34 -0800
X-Gm-Features: AWmQ_blOWNKcOQryVZfQiL6yZ2Z36Q0EPxj1Rovi7-Rkt_4lC0yFg6Y5YqVy8ms
Message-ID: <CANDhNCoe21MYZUmOoa7G0ecU9SJKTFtEp-LjOJXAsCj-ZpQb6Q@mail.gmail.com>
Subject: Re: [RFC][PATCH] sched/ext: Split curr|donor references properly
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Qais Yousef <qyousef@layalina.io>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 6:47=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.co=
m> wrote:
> On Sat, Dec 06, 2025 at 12:14:45AM +0000, John Stultz wrote:
> > With proxy-exec, we want to do the accounting against the donor
> > most of the time. Without proxy-exec, there should be no
> > difference as the rq->donor and rq->curr are the same.
> >
> > So rework the logic to reference the rq->donor where appropriate.
> >
> > Also add donor info to scx_dump_state()
> >
> > Since CONFIG_SCHED_PROXY_EXEC currently depends on
> > !CONFIG_SCHED_CLASS_EXT, this should have no effect
> > (other then the extra donor output in scx_dump_state),
> > but this is one step needed to eventually remove that
> > constraint for proxy-exec.
> >
> > Just wanted to send this out for early review prior to LPC.
> >
> > Feedback or thoughts would be greatly appreciated!
>
> Hi John,
>
> I'm wondering if this will work well for BPF tasks because my understandi=
ng
> is that some scheduler BPF programs also monitor runtime statistics. If t=
hey are unaware of proxy execution, how will it work?

Good question! Be sure to come to my LPC talk on this next week! :)
https://lpc.events/event/19/contributions/2032/

> I don't see any code in the patch that passes the donor information to th=
e
> BPF ops, for instance. I would really like the SCX folks to chime in befo=
re
> we can move this patch forward. Thanks for marking it as an RFC.

Oh yes, this RFC is intended to just be something to open initial
discussion for the session next week. I'm very much hoping to get
further thoughts on it, in person, next week.

> We need to get a handle on how a scheduler BPF program will pass informat=
ion
> about the donor to the currently executing task. If we can make this happ=
en
> transparently, that's ideal. Otherwise, we may have to pass both the dono=
r
> task and the currently executing task to the BPF ops.

So, one thing about proxy-exec is the class schedulers are pretty much
are to keep their existing behavior. Its just the core scheduler may
not actually run what they pick.

That's ok, as the task they pick becomes the rq->donor that we want to
use for pretty much all the scheduling accounting (the exception being
the cputime accounting necessary for cputimers on the running task to
behave sanely as well as top output - as you have helped identify
earlier).  So this patch is just shifting the class scheduler to
utilize the donor pointer instead of curr, so we are consistent in the
proxy case.

As for the concern about communicating the split context (rq->donor vs
rq->curr) to the bpf program, to my understanding, the DSQ abstraction
seems to make that unnecessary. It provides a general enough interface
for the bpf logic, that it seems we only have to worry about the split
context on the the sched/ext.c logic side as it processes the DSQ.
That said, I'm no sched_ext expert, so I'm hoping at LPC we can find
any edge cases that do need to be dealt with.

Now, some of the sched/ext.c logic does seem to want to know if idle
is running, so that's the only case where I've left rq->curr. But I
believe the switching to donor that this patch does, should be ok,
since without proxy-exec rq->donor=3D=3Drq->cur.

Elsewhere there are outstanding issues, as  proxy-exec needing to
briefly schedule idle (see proxy_resched_idle()), in order to get the
current task off the cpu, and this seems to cause confusion around
SCX_ENQ_LAST logic (since proxy-exec may briefly switch to idle even
if there's a runnable task).  So these items do need to get resolved
before we remove the Kconfig exclusivity between proxy-exec and
sched_ext. But again, I'm looking forward to next week to try to hear
what folks think the best approach will be.

Thanks again for the thought here! Always appreciate your feedback!
-john
