Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C28395AF5
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955989; cv=pass; b=XZ8fdRNjV5EF2RhrkNQLytFTT3B4T6oDvVcMRIl6Y6DK+ZlJWFCn5mt0K41BQCO4uGJTTtpo5cp7Z6GFJMPDJbf6v1vF0bmzRf7w8f/rX7UzZD2OYd8X7N6J8N62DMwx70M1V0G5lIpRyIsBxMx6RO1bHT1Mcq8OkCEhtSLF0QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955989; c=relaxed/simple;
	bh=cztgTTQFKjXX5TAy7SRyfnZPJ0Acz6gWoCC/Gtf5ItY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Odwk6Pz9nNzbxsGuPsfNYtzNpsHWkYyLGV4N2Dd7bkvNiS0a3H6ip4NKI5owTl+IO9x6xsOUlAxcZ4sse95owW9A4TCqwS9Bfl1lVH0zgqpCeQtJWvo79j0AGiAAFIYj+QJnkgj++t+MKLHJrU5HNngPIvHhX1yMCKN6PuRtp7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqQ+CwvY; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqQ+CwvY"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69a45011a92so5846a12.0
        for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 08:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783955986; cv=none;
        d=google.com; s=arc-20260327;
        b=VqYSp1BZ0HGTY1/CLtlkyUmdOlbIpe4HF1RXv68rofxEB5PRmdZY3hJwQZXmJOTvP6
         YUAVlTqfXAfBbDb1eB1BvO9VyIDS8kfhMp6eb/aaFySBT1+56+moWIT7e8hkr3059L0f
         x+/wKh1YR/BQg/XCphsmIs/8NCx9N9xE4bApnI6QWBg4MnrVu3wC6QanzGb93ejW2Fdm
         +WsdKGEZBj1tMmoktvEZD7E2QKtCYJUT7ciXQPe1PuPSQ3d/EwqHEZ1pzEgRomX6vJfe
         5JJFQVs3i8bYguLW04Vy+Rh5xklPBRxW00KsanI4tsuDcSgjL0dSLg/8bKyF+Pfevwin
         Af/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PlW85ZthPVYK+ZqbEqZBFSpb5hf+319IJ7QsaNTPeyE=;
        fh=l4FCuzwwRGItQvp7JkhwLnbM3nqvpGkaO2JuMBxEelA=;
        b=LUc6tMO861ULh3rqX3vvg5pZ+yP1Ooq5MVZr6CTaf0+E7HXNev9WICgpwrq+H6sqMh
         aTVwgEE+GJ6zmhNzmgmV5HUuq6zOX3OE1AcK8YWFqrz3CFxk2O6Qm40a5+EiqrJ6A3Vr
         o9OcGpqxPtVL+uC0nq57b+WGI+PXdMYZgSlU5xlEBna0bFlB++aRHILvpmfN126YRokv
         XU6zy+LRh32ZHrjJCNzymIWpeeQr21E+R5GVYrLuIMr+EG5KWLhLkd7xVBdETk/9JUbj
         hPquWzykzuYlhyb+Mvd5sJNIfnhBGiUSLwnEvy5uDGsRLZAsCMyGmOmcAaOD4Shqc6kP
         hCrQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783955986; x=1784560786; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PlW85ZthPVYK+ZqbEqZBFSpb5hf+319IJ7QsaNTPeyE=;
        b=pqQ+CwvY1bME/mjz9EyMvwbxsTeGF8+DaoZEdXuVtn2mRxRr3+/szDLa2P9/toEY8B
         4iQv+lWzQpgrq/zsX4tKUYRk+unP0xUKl2HnBmU2XEuaNa1tXJeN3PwAK92uMwScbkZg
         yV+ZVm1J/exDTUCDWafWYYwI2SHBjB2FwrRwqyBMysOWJ6I6P7fGz7y0dsAdmVYJVxc4
         ACuKuyEn2k5EuLRNvo1BsO6Fx9mcrauURYYp7wPeKREnZSREO66LjQOuMtCrl/aSoVw0
         Xrl6H5ta2Y+t4uiVUXp7Z64b2rdETpAoQRuUEnf5cvWEgy4d3O7Ya3OoM5pBob8NLDl5
         vVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783955986; x=1784560786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PlW85ZthPVYK+ZqbEqZBFSpb5hf+319IJ7QsaNTPeyE=;
        b=fn2VAOlEyHJRk0j6+rOYzqQblkkQe1e7jRgJyNhOT/jKyM35wBRDaijIyFwt+l8CDU
         YW4ft7PXTF3Y7rxSlg2GBNX9xvpCHbA+hEEiFJVtw5USXVFoeCvAV4wUCsrNdDBZl0n5
         tPK/hQqtYMwlc6e3Sz1Z7QMuQtoS2qgitdFoDiRohxzcIoMjGHA3PUrQyODRcTsPx/Um
         4iB8ZAr/oS3K7/1w82h/uNdFy2scS2AOY9b8wGQIPsloWhfvpJhubMDXjJXbNDh0iBoh
         NbAUGlSgtWxbH3VPvkkbts714wwAxZ6JSOtY7SDFaRELky5e2cfTmCeWQxzrccYSL18X
         A+gg==
X-Forwarded-Encrypted: i=1; AHgh+RrsE2gar9UnkKMIZvG6YlC1WkXFbuol3mIIoWFD/u4DMm14eKF04iBG+J1dQU4BaaBBgp8uEqrgllE=@lists.linux.dev
X-Gm-Message-State: AOJu0YzvFgb7VrA4TUZ3WgjKxjaSgjqfxyUo3V5vcft9ih98JPowNKrZ
	yUTM1M0wj0RKKz9Q4K2xgXY09yRih8neO8jhwa0ix/cUDMI4lakZTqlZRaZ6q/lsuITJxcIzTrn
	QJ4xlp+o1eWe9SDcz9VovScjlU/jEBuFAHafwNTyO
X-Gm-Gg: AfdE7ckmgv2aINXPkEpCMFby0FyhqT7bEVY6lUpZemAWDkpEuaxsn+8tAUm6EWUc6rS
	P5RUuahcru2fmlValcJt34q8ZVQdhjUFnnjjmVvQMeZYtlLPhhagCaWWeXlyU3GV7ycPQ7fJMCG
	XLcBq3hYKqSWNYymZVxwWegpXNyGhkRX7gm2x4ccHtQCDV+42VmMRy529m5TPpCSAX5i41Yfidw
	TiygDOqPYJLMlAnOJW1eXLWUW4jY5KgGG+z++s724NjMxMnYNJ9Ww349ew2Ujk6HP80xiU=
X-Received: by 2002:a05:6402:14da:b0:69c:3005:12aa with SMTP id
 4fb4d7f45d1cf-69ccf0cfb26mr24416a12.6.1783955985293; Mon, 13 Jul 2026
 08:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260712174619.3553231-1-tj@kernel.org> <20260712174619.3553231-3-tj@kernel.org>
 <20260713105655.GC276793@cmpxchg.org> <CAJuCfpEocgh+s_R_C6K25ESaSub=-vx6ZwqE-5HJddfBPMt7NA@mail.gmail.com>
In-Reply-To: <CAJuCfpEocgh+s_R_C6K25ESaSub=-vx6ZwqE-5HJddfBPMt7NA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 13 Jul 2026 08:19:32 -0700
X-Gm-Features: AUfX_mxGk_ykJQVoQ6GijNCWPdkmagBjFjBbdAci75lut8r9PEZbC2gUZjRpWQw
Message-ID: <CAJuCfpFcqmWnaUe4d8q1UNRpww6QLh40MX-C3-ajgDRjzBLM9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/psi: Shut down rtpoll_timer in psi_cgroup_free()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>, Matt Fleming <matt@readmodwrite.com>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Peter Zijlstra <peterz@infradead.org>, 
	Edward Adam Davis <eadavis@qq.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>, "ziwei . dai" <ziwei.dai@unisoc.com>, 
	"ke . wang" <ke.wang@unisoc.com>, Matt Fleming <mfleming@cloudflare.com>, sched-ext@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@cloudflare.com, Sashiko AI <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 7:07=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Jul 13, 2026 at 3:56=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Sun, Jul 12, 2026 at 07:46:19AM -1000, Tejun Heo wrote:
> > > psi_schedule_rtpoll_work() is called locklessly from the scheduler ho=
tpath
> > > and can race psi_trigger_destroy() taking down the last rtpoll trigge=
r under
> > > rtpoll_trigger_lock:
> > >
> > >   psi_schedule_rtpoll_work()        psi_trigger_destroy()
> > >
> > >   rcu_read_lock();
> > >   task =3D rcu_dereference(rtpoll_task);
> > >                                     rcu_assign_pointer(rtpoll_task, N=
ULL);
> > >                                     timer_delete(&rtpoll_timer);
> > >   mod_timer(&rtpoll_timer, ...);
> > >   rcu_read_unlock();
> > >                                     synchronize_rcu();
> > >                                     kthread_stop(task_to_destroy);
> > >
> > > The group can then be freed with the re-armed timer still pending, an=
d
> > > poll_timer_fn() runs on freed memory.
> > >
> > > 461daba06bdc ("psi: eliminate kthread_worker from psi trigger schedul=
ing
> > > mechanism") deleted the timer synchronously after the synchronize_rcu=
(),
> > > which prevented this but raced trigger creation instead: the deletion=
 could
> > > cancel the timer that a new trigger set armed during the grace period=
 and,
> > > as creation also reinitialized the timer at the time, corrupt it.
> > > 8f91efd870ea ("psi: Fix race between psi_trigger_create/destroy") mov=
ed the
> > > initialization into group_init() and the deletion into the locked sec=
tion,
> > > trading the creation races for the window above.
> > >
> > > Neither placement in the destruction path works. A pending timer firi=
ng
> > > while the group is alive is harmless though. poll_timer_fn() just wak=
es the
> > > rtpoll waitqueue and doesn't re-arm itself. Bind the timer to the gro=
up's
> > > lifetime instead and shut it down in psi_cgroup_free(). Nothing can a=
rm it
> > > by then. timer_shutdown_sync() because the timer is never armed again=
.
> > >
> > > Fixes: 8f91efd870ea ("psi: Fix race between psi_trigger_create/destro=
y")
> > > Cc: stable@vger.kernel.org # v5.10+
> > > Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> > > Closes: https://lore.kernel.org/all/20260711000434.36C4A1F000E9@smtp.=
kernel.org/
> > > Signed-off-by: Tejun Heo <tj@kernel.org>
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Suren Baghdasaryan <surenb@google.com>


> >
> > Both these patches look good to me, but Suren can you please also take
> > a look?
>
> Yes, I'm on it. Need some time to remind myself of all the details of
> the implementation.
