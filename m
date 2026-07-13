Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A441CB5F
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951690; cv=pass; b=NxugWTy6Ld/l5RctqkocJKUd63C6ZC7SaHB1Q0WeysaWZCYJfu1uk3l3foU1tXoYykNu2s6D+tUxx9/15DCIILPPhQF4vVHdIQm4rG2BkctNm0yucJ1JcOtWZXlLqosA8R9uh5CTVF8UtVrUwQaKvB2xPyPr6pG0YS/5Aa57y8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951690; c=relaxed/simple;
	bh=vqIlEswSbjH4NuGZq6lHoJhIaehD2d6A+4RCBsh341k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdUGLkIxw+kx8RUI3J4fQQGey6PjHCv6su8Gh4hoVxNgQkY2zXHUm+chNC617f3lQTl4s+4Mmlyklwbgc29DQWSgKwABasajI04J0Dt0wp/Px3JgoWd367as1IT412b3AKra8GjPlPt6SUjBrMbDFN/Hn9Iz9/Kq1CJVCMcNuao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDGvXlf6; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDGvXlf6"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c10ed63c0so365281cf.1
        for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 07:08:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783951687; cv=none;
        d=google.com; s=arc-20260327;
        b=PCeoYURvQLsgOheMUxg3UZc1EjZNXVdQP0DPuyx3Nh/0ZV4djLlFshOM5Bp0xL+Z2u
         d1g4T18tiswO9gwv90I07U6Lkgrje1d4B31lXBY/g9vEFucnm3nsSNm+QBqb3H/LkYHg
         uPAfBdBxvKlpIMadkDyA/oMK/ajJ8VhJBcTcKW+1Cf2tCUacnU1oHetjWU4rXenENV9v
         luNCbILZt0I3J0Pc9me/qdbDzDlBdizcPCv3IBUFx+ERwcRAXB+kQDVNArNiRLI2BFoF
         0sGDrYxuKvGKTXGpRYyLdhkBKvliClFlE8IzjPdfm5JJoG5vnRq4SOUYVHWhDsouS67e
         pdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P/B4jzAbemKAfn1pqP8eoojQzyZ93X8qz1xTXY8DGb8=;
        fh=VTjxwLnJpsfpzEUTcH0ztgK/27VhIJOdAntISuWc05I=;
        b=C+gSFY6ICpRR/vFZrawGailUJOhouIEzRMtx/SOp1gk89bZnfP1jJNSa01rPslpp18
         XjDwAL8XZzO4Zjp+ODCDeJVRIHzbciFRF7YiE+QLDqQsMsPFP0AhQNGdFCrKj3ucU5aW
         v74K9y2VfDt3VPT/G3zYZVf2T9ExiJtQLjaOUZr4SN4nLJonil8TdZ87tbY+TK+O18cR
         vlzi+Llpl4U+x/LfdZh07Wk/7qq9+8kJJ68jMRqZbPgDw6vg/H55ABPtK+eNkylz0wuS
         7c4gvxWTNS7ECA3wzaYl1EVXkrfJzuh/D6ujeGL0u7wE1HR8xIZM5lnnoY+Ui2SkDw8h
         KJZw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783951687; x=1784556487; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P/B4jzAbemKAfn1pqP8eoojQzyZ93X8qz1xTXY8DGb8=;
        b=NDGvXlf6VV5PatA2K35ZQhL7/PGjfbXF+DlK9/HEY1f0NBuIO3BI344IgUVyr0SqfW
         Gy6DBvKdI0h+GJXUPEw/yBpOWjC9GLeU9CafirWv7yO0UHYbuWUQQ+Po4S+rD84d6D/U
         zzQ1i7Xu/dAWRyNllUNeXMMpRfr6hI/1UnhMQ7Dsbg9BddyBI4Nbm4D4+ordVJ4N/ryw
         k3sU+GDRs8yyeT1l5nWJVwA3bgVByI140J9U504rD+g5to9B3zCg9AfcB8D9qVlkaxFF
         H62gaBHLWhXmxejJ9vDOVpIw8oU/0vGgnacNdvJmt6smo9/eVCbATYQep6vajAc05WVi
         uxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951687; x=1784556487;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/B4jzAbemKAfn1pqP8eoojQzyZ93X8qz1xTXY8DGb8=;
        b=Mzx2BJ7sNTshSkUmZd1VqHUWqOQ673XCL4FlirKbDuv/8L90JPP+dSN6R74aE8dHQG
         ntfgr9AztNImm5TeDSDPMOT4pJjlcGwiow8sRSUfgJHn3Uko17GbQPAXdGWpVwaaZzMM
         w21EF2DQc/RYp1woYId7u/AylGGFgQ7QqHYDq3rWJ9i6EVw/ODgllF7SsXJO65zf4E67
         wfiecUS5Gb/hsE+T81UlA8iVrkYG9kk3e5iKiZfzfLAEz4aKNe7Ps5RZI/SqQYFOdk+d
         vVgNHpLOI1+OA79EAqdRyVpP+HDFkL+/Gs+i3n+j286BOk/fiJJBK8A5f2OD02J8i7CA
         Fkgg==
X-Forwarded-Encrypted: i=1; AHgh+Rq13nlNaJ7ph83lsaKJgZov6xa4CB/y/btJwM7hXHYeZJZYysCRagq2dAOoUGcVs7BsU7ENpvIAaME=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7UF9FbsZ/JLbkxH/n2AHxLeRNeEiahCEKpBzn1lPfFwxFa5zx
	mNcvjPEqGu0FNA2HYbRoJCJHYzp4ENHmtLifveoui25Ni7kD0QshnJknqdmavT0G75pEdpmVRzi
	M9RsQiatZ76mnugITbVL7fwB612vTZeSv9jVDZUEBsLh+H/dB4EHYrgKc
X-Gm-Gg: AfdE7cl1c9zMC/M5mqNHRoRsf68LfsaRA8MwrkRVnK6tav9x1r1PNtljbTYO1Igjv24
	cW0YFKnzKIc4PabxhTZOWidBqzDHyI6RtauzuNtKNEZ8e5/70KkXRunknQaCQf/O8uaUenjTRn4
	jovcQ53rK8nTE7oMsPDJjSXz3EFZmJRmReCsnv4q6OP5JyX0hCekc0+HVMHgxndlBhjzdRIk4Jg
	RA7LZ4r1/1Jcd3EErL2xvHRMQP49S+TAOLaOb6Aixpci0VyjVK6V/k8032vmt0ijahqxkwVUXFl
	72QTCA==
X-Received: by 2002:ac8:7d03:0:b0:51c:104c:100c with SMTP id
 d75a77b69052e-51d71546a1cmr3059641cf.2.1783951686232; Mon, 13 Jul 2026
 07:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260712174619.3553231-1-tj@kernel.org> <20260712174619.3553231-3-tj@kernel.org>
 <20260713105655.GC276793@cmpxchg.org>
In-Reply-To: <20260713105655.GC276793@cmpxchg.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 13 Jul 2026 07:07:55 -0700
X-Gm-Features: AUfX_mySUXx60Yrl5QJFzFOTYBVkvBAoiyE97eRZFZR4z-qTHxpoqiaNZ1I-MdA
Message-ID: <CAJuCfpEocgh+s_R_C6K25ESaSub=-vx6ZwqE-5HJddfBPMt7NA@mail.gmail.com>
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

On Mon, Jul 13, 2026 at 3:56=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Sun, Jul 12, 2026 at 07:46:19AM -1000, Tejun Heo wrote:
> > psi_schedule_rtpoll_work() is called locklessly from the scheduler hotp=
ath
> > and can race psi_trigger_destroy() taking down the last rtpoll trigger =
under
> > rtpoll_trigger_lock:
> >
> >   psi_schedule_rtpoll_work()        psi_trigger_destroy()
> >
> >   rcu_read_lock();
> >   task =3D rcu_dereference(rtpoll_task);
> >                                     rcu_assign_pointer(rtpoll_task, NUL=
L);
> >                                     timer_delete(&rtpoll_timer);
> >   mod_timer(&rtpoll_timer, ...);
> >   rcu_read_unlock();
> >                                     synchronize_rcu();
> >                                     kthread_stop(task_to_destroy);
> >
> > The group can then be freed with the re-armed timer still pending, and
> > poll_timer_fn() runs on freed memory.
> >
> > 461daba06bdc ("psi: eliminate kthread_worker from psi trigger schedulin=
g
> > mechanism") deleted the timer synchronously after the synchronize_rcu()=
,
> > which prevented this but raced trigger creation instead: the deletion c=
ould
> > cancel the timer that a new trigger set armed during the grace period a=
nd,
> > as creation also reinitialized the timer at the time, corrupt it.
> > 8f91efd870ea ("psi: Fix race between psi_trigger_create/destroy") moved=
 the
> > initialization into group_init() and the deletion into the locked secti=
on,
> > trading the creation races for the window above.
> >
> > Neither placement in the destruction path works. A pending timer firing
> > while the group is alive is harmless though. poll_timer_fn() just wakes=
 the
> > rtpoll waitqueue and doesn't re-arm itself. Bind the timer to the group=
's
> > lifetime instead and shut it down in psi_cgroup_free(). Nothing can arm=
 it
> > by then. timer_shutdown_sync() because the timer is never armed again.
> >
> > Fixes: 8f91efd870ea ("psi: Fix race between psi_trigger_create/destroy"=
)
> > Cc: stable@vger.kernel.org # v5.10+
> > Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/20260711000434.36C4A1F000E9@smtp.ke=
rnel.org/
> > Signed-off-by: Tejun Heo <tj@kernel.org>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Both these patches look good to me, but Suren can you please also take
> a look?

Yes, I'm on it. Need some time to remind myself of all the details of
the implementation.
