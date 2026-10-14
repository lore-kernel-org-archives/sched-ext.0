Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454F246D097
	for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962474; cv=pass; b=TG9ZZrCPbVJWgfm0zX2LzG6FptjBLenltGU0hs+MvoRDdG0Nf6A7iYcOKiXseknl3Xu6qr+lGem8IbY9fV2iu6C+ZZOdXeFlr4IoKq+1nkbZ9Vx52JUpVS5jpk8Va2jq75bkamnM+nRxd/9KRmK2Sbsc6H11bHihdQDE5y6JplY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962474; c=relaxed/simple;
	bh=YChBavy9/hT84sGYMDIbdBzY/1bKyPcMNTRHv9aVaiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyoajHIPmluaWj/LFXD8oi+7EfVM1F3ccFaFvhgpwAUfPg7zzQawyl3ngLxRO7aWiKfQdRBetyFWnY3av2Tk1LOCvdVjyHori42eumMlsuhu2jFRqaut/F13iw3D3Zw/OlqEYmSDv2hGc1QkgVmC2kqQ6RG+w/xTrBraJNmtbuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CS83zNVV; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CS83zNVV"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2e62319cfaso66704366b.2
        for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 00:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791962469; cv=none;
        d=google.com; s=arc-20260327;
        b=EgSifruEPcrm9wm2xJdO/hImFqS1jnpsshTEhDhZJjjzXQfuWq7VN1UWT/5+62Cw3E
         WCpa8osjNow98xyjai/I6dGJT1sqWGktZHJYqvAJyNNE3o1pgrLJoFJp9x6QT3AEuhqZ
         NLnXg7DmS6qAUGIDOmFrq3/s5CNToOq+S2Gl+I0zgVBh9NSFvHAkPe1WmTEY7d7uGS6W
         63b1fcUANL8zYrWY1C8FjU0E/UCmfh8MHRh5/e9oyjshO1BJFLOAA0WW1V4gEfHnkv+t
         AFz2BXp8kY49ZQ6SlIXCM0f0owq64I1xFNCb1gK9OAhfKlw6Zq/e1yVuf5rE6y++JnPS
         Hrig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CF+KclfBDMXfeuygyCssleqkU5i6V8LQfkd3LIo/AIg=;
        fh=fChW9TV/z2khYNJcYGW8GLr1t7QnPclznIashtrzyWs=;
        b=YF9/KWPMittyTWcW/vilTnslMS3dytRvQDuixI8KSa++0rfc3q74gJsB/ipfL4pfBf
         9rpMtJWU6oYEP9uY5GWgNU757mVOT46xDq3swp/qG0cDSFUspPIKGuXJ8VggGkI9DmLD
         k1RS7r8XsoXZ2H93ZjIBXFc+fMFmgWjxUpgLuaa5BDgH7ucBrmSaZ9iCrjYfrC1gJwbc
         O4qOl7txcIgnAUuvRZMslGDes/aqPYZvVKyyvLbyO/9NZ4/+gPG8nbRS1sJs2Cai2sit
         B9VxUgTVeEqRGTedmWuPWCjEITpdrUbdLONMWKD9r6CXTBuiLifdE5VwPb8uhA4YyP6E
         o1QQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791962469; x=1792567269; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CF+KclfBDMXfeuygyCssleqkU5i6V8LQfkd3LIo/AIg=;
        b=CS83zNVVEB5eR8jiyMGDKaDnBR9Oa4pAgnIm9+jZkg4UAZEa1jQi/mGadn85Dno5xS
         6v4z8roAZu04BdsXiCguj8oq5UxH4tIAg8VWBxGDjsfeYIfbD9SLBvS2cu22X28gfd8w
         SvvVgxWbqd/EBJxGjfl9Y8lXubIX0mcQlebCMxsCgca0z7pT00wpj/M7ATZENqCa704S
         Do1Di1jkNzaI+Nem5Oowng/jl4XCXVox0RMkYomrEkfBkE8GkCvu2Eio+xgAKvk+v1VO
         imDiRckr7AB3a3VWrV9K6GC7GkyXWEzgsRS1pdtZ/uyG+3/R+EQJRpfQXpnZEho7zwxn
         telw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962469; x=1792567269;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CF+KclfBDMXfeuygyCssleqkU5i6V8LQfkd3LIo/AIg=;
        b=mGgXkkfKZe8490auiHA7Cuz9GsxQ/zSxPXmLLOkyKTiR7mp+V5hC/7Dx6ND/nET89g
         E+uZlrIHcDjBBi5C7kxwiCJ7YfvBhyAkSqF6C7LgDg2IHGfLNJM/OTNevyYpzJcpwLre
         11D8VZctx2TtJsTpSlMhNovYtn86/xPTYq/kEpnd8gLUZFq5pZQlOez1O28l9JCuJdX2
         PxDZbajB3rIT18G4pWCfoGQRnUuw67A1K/CRpwISbNS+5e5yPrKA7uZmtnwm5hbwGMV0
         JKAR3aWHsR+VbNiMUTXO+SmOVr/Ug6+gBQ9b6jHuaaH3H/CsbbiDoizrhfIfzts5apwS
         EUMw==
X-Forwarded-Encrypted: i=1; AKwUvByj/8sdNfTKu3tyEWl1lPYOdrIZ6Bgdbf6MOGNUkuMa98SijXI5S3nsI1kDkQGm7q6Zz2K8ZLJUTjQ=@lists.linux.dev
X-Gm-Message-State: AFq9FYKB9s+3fKnkKBleHTs7DuMG1+rNhvhCeIRQX2mVPrkZRUmb42o1
	jHN6mtBflxEhSHs+ZXDQcRCymLFC+nOZkBjv74nCUkMwSYwho6Up++tBcEe50LmoWoBqHfL4vR4
	PJ/8OwEgRP+5PmTc8qLbAPTJ0fEyhXR5wdZReZhP+og==
X-Gm-Gg: AYBFou3v/dKtv3HvkYIGUCwbeu3z2/CFj5dy1xS94FuYPCiEKnBP+HTdMdQNOpuxkFj
	8BurYTB3+Z5aiDl8+/N2akUL6G+QvNqwvAhtrJfYPyM/YdhIrloZM1+cpQWtJ96ygMAXtGdC5NP
	jPJM8WOnyjIYt3Fj/vijC0MkubuuVlv+19oQLRMmxWtfgdkMTU7/uOUag0x2d8xIVWWyDpdVgAh
	AWu+/wW7i+rgkRWMHW90JlmOFRLyl4tGxleJfnwJpAkVaGEFNlPDy8CzYk/Eu1BZMhGq1zJBqxX
	cdIf02p/4N7Bzjr+MZp3kIrv93IlD+40r2iYyc+0ywoxQOBWOHneG/hJ3BSLRZQdsFYxf55nzGK
	saLxoRlCOZw4=
X-Received: by 2002:a17:907:e0db:20b0:c35:d50a:1356 with SMTP id
 a640c23a62f3a-c35d50a286cmr419508866b.42.1791962469352; Wed, 14 Oct 2026
 00:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org> <asWyZtW7zPVo3k-A@chenyu-dev>
 <CAKfTPtCyRiBbxT_bU8egEuXtRsOW6TGw3TczyObBLKsE99dMpQ@mail.gmail.com>
 <aspc8doovTKdBqPC@chenyu-dev> <CAKfTPtAy-n5_Dj-9x2qxcu=i7eo9DmZ2aaxig_nbyNDbP2m_Mw@mail.gmail.com>
 <as2-2b417B8ZaFdO@chenyu-dev>
In-Reply-To: <as2-2b417B8ZaFdO@chenyu-dev>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 14 Oct 2026 09:20:58 +0200
X-Gm-Features: AclHuK8pAU8JrMEVjSxceEUuYpPE0kaNBSBk1NHutmnkX7B9KN-NWtHcn7JJxf0
Message-ID: <CAKfTPtDB=-NwC=wpv3KiFXe4MwFTs5NTzNcYP00onx7OT967QQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] sched/fair: Add push task mechanism for fair
To: Chen Yu <yu.c.chen@intel.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, chen.yu@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Oct 2026 at 07:30, Chen Yu <yu.c.chen@intel.com> wrote:
>
> On Mon, Oct 12, 2026 at 11:18:04AM +0200, Vincent Guittot wrote:
> > On Sat, 10 Oct 2026 at 17:55, Chen Yu <yu.c.chen@intel.com> wrote:
> > >
> > > On Fri, Oct 09, 2026 at 04:31:40PM +0200, Vincent Guittot wrote:
> > > > On Wed, 7 Oct 2026 at 04:59, Chen Yu <yu.c.chen@intel.com> wrote:
> > >
> > > [ ... ]
> > >
> > > > > @@ -10414,6 +10441,15 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
> > > > >         if (select_flags & WF_TTWU)
> > > > >                 want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
> > > > >
> > > > > +       /*
> > > > > +        * Only a push triggered by cache aware scheduling will push the
> > > > > +        * task towards its preferred LLC. Pushes for other reasons, like short
> > > > > +        * slice task, uses the default push strategy.
> > > > > +        */
> > > > > +       push_cpu = -1;
> > > > > +       if (select_flags & WF_RQ_PUSH)
> > > > > +               push_cpu = check_pushable_cache_task(prev_cpu, p);
> > > >
> > > > Is there any reason that you do'nt want to migrate the task at wakeup too ?
> > > >
> > >
> > > The wakeup path seems to be too fast to aggregate the tasks, so that multiple
> > > CPUs try to migrate the task to the same LLC without synchronization - a task
> > > bouncing issue was observed when cache-aware migration was enabled in the wakeup
> > > path. We can double-check in the latest kernel to see if that is still the case,
> > > and to see if we can mitigate that.
> >
> > Yeah, the goal is to use the same select function for all events;
> > wakeup and push events should be seen as the same event
> >
> > Also you should separate the check for adding the task in the pushable
> > list in fair_check_pushable_task from the decision to select pref_cpu
> > in select_task_rq_fair. The check added in fair_check_pushable_task is
> > mainly used to decide if it worth going deeper in the decision with
> > select_task_rq_fair
> >
>
> Do you mean the check in fair_check_pushable_task() should be lightweight
> and let select_task_rq_fair() make the decision as to which CPU the task
> should be migrated to, because the former does not hold pi_lock and thus
> should be best-effort? OK, let me adjust the code.

Yes and fair_check_pushable_task can be called quite often

Vincent

>
> thanks,
> Chenyu
>
> > Vincent
> >
> > >
> > > thanks,
> > > Chenyu
