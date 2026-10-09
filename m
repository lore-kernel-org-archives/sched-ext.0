Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896004E36E1
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554793; cv=pass; b=jyfmtImnaoTUa6B5E40cRZydwqMWALhdf8T0fLAfAGJhCkmGoijmaIET9GTrfHka0ItikRQ7y4uhOHQC3YJxOkQJCNj0jCWJnWiOu1Ysq5tytTjQ67cNGYKfojeHdXlZG08rWW8/RoMF+SUv/J1KwFVKSHDTYY0IjuDqk4NUFNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554793; c=relaxed/simple;
	bh=GyiWe4iERIHzqUToTB83us7UkhnVWZQdkG38gBexcNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oO6Re2tY+/kKWgia0Mve32ujCj/fTTNeLh5oemUO/yy4RALms5+ck30rI/IEFte1iRU4hVFjt5sRy4XORfLkoajswRCM8CChV4OrgLx6OqIHR1k1lVaP+gSWVNXv/wyrZ975x+H4cNfZKKJ5HNNibmj/sxWmpAlPhjsEcZqs/Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I0ramlSn; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0ramlSn"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so6025556a12.2
        for <sched-ext@lists.linux.dev>; Fri, 09 Oct 2026 07:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791554787; cv=none;
        d=google.com; s=arc-20260327;
        b=SS1FJjZObn3jKvNaZUjdd1PsjmsL5xJMx2THDLP/AX8Cw6NQMgkOtndXHckoPWivoG
         fZjYOYk4ylXdBgiSe8g4QGdGmYWJa+TjgL5lXSclR6Xth3ic1L63yy/qBhfqTlg8ivK0
         6c1fa1pVBVub7Hx3oKq5DUPlRmg3dH3Dfk1lJUp7d/gBMHL41WWVLUuJGLTEgJ4noMVg
         QFAsQxhY3zW/CbZCc04Xu6Bj/iGlGpJc9oq4jKeVm/vUhM6ku+saem4OrodkTntgfNyh
         PURZKJN+NlQQOilF2sFdJWtCsgPnj3P45DN0fqDg7EaQAZrjrFc4p34vUsDJgKvF6cUU
         F77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3FaEcDATObijynFDqDaL/0W94AAQKaPSJm7mGfTHxe4=;
        fh=QOKl8Rc5VAdxXXz1OUaKZk1IRL1EGTpt0WkmrC175OI=;
        b=YQa/7eAIAS68nsyKjmVdV7rrYdbsCfdAh6CZzvE/XSNhilOwrenzVbmewBM3n8hXH7
         yxvVc+M0RH/WOWbMLBpd0oWzgDLJcH0ITiTNUGBjldHYcJB5UohzcfKNRC/zwEP7EKfO
         YMetL5e006V+EK2VVagVOrQ3ExYB1KIb8J3v3/D4szogs1zdgikdMOIxRMxoDwCk2j6O
         P0Wp+mIiyw+hDyAhY1W6zN1Yo+waqr3E1WgicMqn8GDOMpYnBNRgeH3Myl9rAA86wq2d
         KHUmkVI7AsZcumeePxH5cX/kv1dCwd+aGCx31hzNQleND1wjiJQB4RnObPPZgP4lq+eT
         L0nQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791554787; x=1792159587; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3FaEcDATObijynFDqDaL/0W94AAQKaPSJm7mGfTHxe4=;
        b=I0ramlSnzEqqtJ0A9hiiUD1pGIKm4dktTb0APK1ghKzIgMfm3n6Po4eTUxMiCSPmEC
         Ev66wBDPLdZAr3pfbt3pDsbryPKbT8FkIuyL0TUhXjbQ6fVnQfT3Q/16ceProe6uYvj/
         py0HbzO1stleW+oXRNiADMyedABho7UmIOLw0hwoKREOvbTAWjZLERK6/2zhI2YEq4yD
         KqUVsaynaZs1SUN40UF3PSNfgkjENgl3TDhxDOHv836J9QnV/VjJsVwDqCICQdKqFmp4
         99UYQwUJcGSjpaIRHycbDNTMETQNnvqd178cy/nUpIk8uNT4oUGcF8kUV8LKafUfAN3g
         zHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554787; x=1792159587;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3FaEcDATObijynFDqDaL/0W94AAQKaPSJm7mGfTHxe4=;
        b=dBy6jOnOMg+1qSZ2K199DfBbpuLevEMdbPzRzAnvAjUuuUlPPzbYxNETZGrggsNh56
         WQJKAo4U8qAOz7MASs/+cj/A+pxQvVfpdvkZxfAK6PQ+V3IPC6d80LCq//kvENJT3Abv
         9OC86Bcf0wG5LlaEucD3gkY226PkEi0GPgIP3EFFeJOq3c4Hwzec5xTRKDXQnY1lg2U6
         cJmuOZjCOlQeqEeFklTXaEH/SSx9edc7vt+eOoZrgfLurNbMqWUuxhQkOlPRemWoLlnf
         tK/MFH91qB39ctaYLit8PZTs1Xj5dJePxvQDu1CLeen2Up01SSUxXt6dBgZOS2lxrdg0
         H8tA==
X-Forwarded-Encrypted: i=1; AKwUvBzhWM+LAjl6w/fKqZrWx3QN/9NhTkVtKrDIQ665uL5lTWGWOo544M61lK+jg16FJUe0fFjNAAD4gHA=@lists.linux.dev
X-Gm-Message-State: AFq9FYL3OCCsY+O6rkaS04kje/Fa7kMxgvRTdoDSoOiPBKpinDtLAhVv
	SeZLBLiXEHucx+nipWa00Sv9GLTfVhTjsw3dh4VHjuLYDMUvFTUe4izHJhYoBAWChJq2Edhrjju
	FwudxE/UgGX69NB53BcCSUkjjtyZOw5b1hUBxdAb0aw==
X-Gm-Gg: AYBFou2GLF+OtVuvgGvI23lOEgApL9lO71eVOiWRfCmw5wWfvMDyOP4aQRmzqEbTZja
	aOyl12MLTUROE/ZEq1Vc20CFQJbETccXKCOXHndXq+fAeorV2CYyVk81IOXHim7ukEIu4ewJ63k
	XUBwMTxpZ/OuO3qsYqTQbqJuDlQTF85G0ldK1o7/CDD2ZkUVJgODYfBU1JnNLwpN3rBqA+nZs/Y
	v4AX+jOi8PVRjPQ4AsxBhw2n2J869zhmYMd6BWYl+KNNThEiEkvhZkFcd0ah0iTVV5fKIXB7b+p
	YEx6QtS2f3rmK1vDrUXcwO4+tagLGTWGUroyB2ayFXg6b7pOUnmeIUlMRlgKGn8GIgFgGie79rM
	haoyt2kH2Bkc=
X-Received: by 2002:a17:907:2d24:b0:c2d:bcf7:37f9 with SMTP id
 a640c23a62f3a-c31aa07a9d9mr224233766b.26.1791554786570; Fri, 09 Oct 2026
 07:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-12-vincent.guittot@linaro.org> <62547ac28298442a246abe0471647e36518a93cb.camel@linux.intel.com>
In-Reply-To: <62547ac28298442a246abe0471647e36518a93cb.camel@linux.intel.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 16:06:13 +0200
X-Gm-Features: AclHuK8OZXoY2HDF-7oweWSjqlOmblYb-OtXlDEjMe9WKYUdoHkKC6piT5Ymiy8
Message-ID: <CAKfTPtCGK1Rw_gMRjdQ3EJ80RJNe0eu0aK-+arhw6C0_Oe0ofw@mail.gmail.com>
Subject: Re: [PATCH 11/18 v2] sched/fair: Support not wakeup case in select_idle_sibling
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Oct 2026 at 19:55, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Fri, 2026-10-02 at 17:44 +0200, Vincent Guittot wrote:
> > With push callback mecanism, select_task_rq_fair can be called for a task
> > that is already enqueued. Task into account this case when choosing idle
> > CPU.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6ed3e5bb7fd6..38eb80dbd1a4 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7974,10 +7974,13 @@ static int choose_sched_idle_rq(struct rq *rq, struct task_struct *p)
> >       return sched_idle_rq(rq) && !task_has_idle_policy(p);
> >  }
> >
> > +static int idle_cpu_without(int cpu, struct task_struct *p);
> > +
> >  static int choose_idle_cpu(int cpu, struct task_struct *p)
> >  {
> >       return available_idle_cpu(cpu) ||
> > -            choose_sched_idle_rq(cpu_rq(cpu), p);
> > +            choose_sched_idle_rq(cpu_rq(cpu), p) ||
> > +            idle_cpu_without(cpu, p);
> >  }
> >
> >  static void
>
>
> Hi Vincent,
>
> One concern I have is that many CPUs will try to push
> their tasks onto the same idle CPU and causes over stacking.
>
> idle_cpu_without() doesn't check nr_running. Its comment says:
>
>          * rq->nr_running can't be used but an updated version without the
>          * impact of p on cpu must be used instead. The updated nr_running
>          * be computed and tested before calling idle_cpu_without().


Yes, I missed this part and will fix it

I'm going to merge the check of check nr_running in idle_cpu_without()



>
> and update_sg_wakeup_stats() does this:
>
>         if (!nr_running && idle_cpu_without(i, p))
>
> choose_idle_cpu() calls it without that test. So a CPU that runs its
> idle task but already has a queued task is now idle for every caller:
> the target, prev and recent_used_cpu checks, __select_idle_cpu(),
> select_idle_smt() and select_idle_capacity(). This affects wakeups
> too, not only pushes.
>
> For a wakeup to an idle CPU, the wakelist usually sets ttwu_pending,
> which idle_cpu_without() checks. A push enqueues the task directly, so
> after a push the destination stays idle for everyone until it
> schedules. If it wakes up from a deep idle state, this can take a
> while, and other CPUs can push or wake their tasks onto it in the
> meantime.
>
> The fixup below removes p from nr_running when p is queued on the CPU,
> and calls idle_cpu_without() only when nothing else is queued. The
> tick case that this patch is for still works: p is the only task, so
> its CPU is still idle without it.
>
> It is build tested only.
>
> Thanks,
> Tim
>
> ---
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3eb8a0170902..cb00f24a58fa 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7978,9 +7978,16 @@ static int idle_cpu_without(int cpu, struct task_struct *p);
>
>  static int choose_idle_cpu(int cpu, struct task_struct *p)
>  {
> +       struct rq *rq = cpu_rq(cpu);
> +       unsigned int nr_running = rq->nr_running;
> +
> +       /* idle_cpu_without() needs nr_running without p */
> +       if (task_cpu(p) == cpu && task_on_rq_queued(p))
> +               nr_running--;
> +
>         return available_idle_cpu(cpu) ||
> -              choose_sched_idle_rq(cpu_rq(cpu), p) ||
> -              idle_cpu_without(cpu, p);
> +              choose_sched_idle_rq(rq, p) ||
> +              (!nr_running && idle_cpu_without(cpu, p));
>  }
>
>  static void
>
>
