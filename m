Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE991449EB7
	for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793126; cv=pass; b=dyTz3C6b1Knv2o4Vkev/SilQ9EwBSFXV45NrAK3EquW7xt+atXbyZzqVjmLGoHGMiePpLFFRm4pakG+H7XC0RFEiLvaTyZKwCsgGrs8XPLwdSsEpxxzH+j63jgbRDv58VSom+WncF7si6YhWcPU1h2nhBpj2fRlu+1mKN4oL4nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793126; c=relaxed/simple;
	bh=+cgBnKpA956E9oC3dPcEvrFaJuDQAJAIwVEJgcDrCgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIe9H0VXRPDB4uG42LyKy27dhHHnEywPDAEl++18DEGUw10r2uEz94l5AoUoij9EuZnAYtx/VXFdAU4mcX620kE3V7yY67jS+YFb0rZhQ+jTk8Qt75ZM9Jl3Tdxu4x8YrI+NMPAnNU+8qtLv7LTq9eIIx1MkxjjKm8t6IB1Rv0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KPgPN4MZ; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPgPN4MZ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a601ba6870so2406688a12.0
        for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 01:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791793123; cv=none;
        d=google.com; s=arc-20260327;
        b=Mvf5MxzC7O3CGdZiARCsNDR56DFJZn6XpbX8UNt+Ug2EVrw7xVrLfK5fStvelZqtUx
         NwHPFOcbmDlS551N4GsFZ3UFo4oLUF3evdq8z92VRGUd9S3TNzcddi/e7A3FGG2tRH9X
         LnacM4K84kiH7kY6xB4XqSKYMjlTAnRf+YlB/qxmHyZMvTGjdiUvLK/8pR8d4Qs0PTJz
         41dCzO4ncjTUYTtPYvzl28mij2OUgba6JVBm0OmS3A/ATADZc91kVJHw0ho3RuyQZtVD
         xyoJZsA8ygOvtt0zr6VbYnUF6vDbtGyq3OZSP52bVuD/KgTsjiDKoLUraJUXhdojqQio
         YEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zSGc2gSvInI+9O2ij46iITf1yj50GR8jSWXc3T4EcG4=;
        fh=xtXcqMxdRJXCzCcg+xb9jNQP3CtZhcNLTEFBdeIh2BM=;
        b=lDvQ7MQDYbpvmluMKqBWNd0Oi/hk7pi5c0S+1dNS69P3ayVnZciMBHWQLkiIzaj+YW
         R4DvEXjfo7MA8nNC9jkUt8XZ7NMujKDkCq9lkHT6vU4ecd3NV3tp1c9GQpnExgVaKpFl
         ekaImwgKuMYASNKymK521uzQoxKEIqIKzCyoxG2nFIVTy4yRUnPmgwcmb8ia/uMiGiBF
         pV5KoKqfCMX4W7Dkjv/SuP5lcamun8WDgW0v67N5JypnyzeH54HuXnAvlSvIAkaQ2R7u
         4NN4DNL8YTk2e2hruF7B3j5FUtfynaWk2vWDwYv5iDoXm5f9BTkRXdBdlFcqoChmMfSm
         Umtw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791793123; x=1792397923; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zSGc2gSvInI+9O2ij46iITf1yj50GR8jSWXc3T4EcG4=;
        b=KPgPN4MZ+zdLgyNMFi+bxJy0w2tJfYn1mYNe9hg6UcfNd8/YxHnbVZj7teT/5lFkNm
         pcUZHtQWqL9uMO2EkFAuVH/ETjOn9bmWyL8QTAN97lOGar6Hg1DNI6XSL0KNbCSy9Wg9
         sJtVmVaACh90wHwvg4lT9Kb0b5xUfNEOJNaD7Y8aouV1zYQKaR/4ITAUZrdR4BbfztvS
         8AULFhPbLadGWDnBQocSc2RzT0CNaIkeQ6sKthJvamj9H45V51r4plgsba6iiENq0vGA
         X5Lel28xm+NFMAxMvethUAz9IqflL9+7x3L5piXawX4b9WJexmeY8dBpvp01HxkGVFTk
         l3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791793123; x=1792397923;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zSGc2gSvInI+9O2ij46iITf1yj50GR8jSWXc3T4EcG4=;
        b=K9noyN/dK8UsZFaVPEnI4OOTe69yUMsQ5HeXL8wFY97cSuFnLo7sFd9h5ymM06v3ii
         d4NkjVEntEouhSTL0qWJguVBWOav+GOYDJb2UetkJfoTZueX8LsKZC237jHeGHF7tpr1
         nUe/zN64YeyDh93d40HrlwiE/G49NbxCXWjyS9dtLAG9BDw3hTDzbnPBD0Y/64KII/Z1
         XgzwUEbJhE4OJr7DCn7u66gKL8QSMylhRlrpjUNt/iYiyOCE4w3HZsSFc0hUBqLw4/5g
         sgAMUI9MjG7K4IWsrnZzSpSJQxxnz9zz0E31ASvZCrcg90MEbUC1rN1lrMqxJj59lE8I
         Rgvw==
X-Forwarded-Encrypted: i=1; AKwUvBzCu94Wpt65TPMLiP7iYShIxPcX2t09HP17XgXh+6FfrlzG9jgekj1BP4PPEFjOaRAa8i/Q5Z4HO+8=@lists.linux.dev
X-Gm-Message-State: AFq9FYLDuW03LC9x4CDqkVfh2iq0gOTQvFercGD1t+wTgIsOrzCu8fEb
	7q73FIGTQ8pXokbxHMe+WpdW27XvLmXuKc7Jf+tEXm+F1zYa8pr8t8jfjLpYF/ClVQrOz3xbSEo
	bECZbB+JPIrUwSDLMzI/xJo23s9j5RPQTXkXJlMJoGQ==
X-Gm-Gg: AYBFou2SduDuok6+Xt3kruKkmAOywYShjrAHposPdNdl4gBBmNtQJV4YwEL2xm3kve0
	ZvGw7GxyhZNBCAt92y9jsW09XgW3o7yIVWBtBiHca5CDYl/AByNW/f8dsmPUv7VyZOWzl/0c7ep
	UgnkGaK3rz03dB+CtT7lwAMumkiMCtrwUgdFlG6m/uUUkLk5zShM1nV4jdugYUwcHFgXTweN3iQ
	qQrvSFz9S0Lg2nvTFNICH+T3mK23vqWkX/8IbFdrLKL54I/qPfJrpmnZRKOf1706t2XZR0envQO
	M0Vo9JdYxu9kAz/TTd7n55O1MxNlmWmLdiDyHRLZayOvG0S85XcuFrn8vbGDQj+sg1yagdbXkWs
	oQy4ghyRB/aTf
X-Received: by 2002:a17:907:d1a:b0:c2a:704c:8c8e with SMTP id
 a640c23a62f3a-c31a9fced4fmr940287766b.11.1791793122980; Mon, 12 Oct 2026
 01:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKfTPtCAbreGDhesDmFNvXEzjj+anmOH1=jqT-1B6Lfj0FfPqw@mail.gmail.com>
 <20261011174038.5334-1-kayracizmeci@gmail.com>
In-Reply-To: <20261011174038.5334-1-kayracizmeci@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 12 Oct 2026 10:18:30 +0200
X-Gm-Features: AclHuK-DP5qVnsuYOeIrtkpyOkecXNVv-1nV6z-W92W9g6i97Pk7RW1tEN3H67A
Message-ID: <CAKfTPtBDcfk+TEEjD07RBLpCAusKqa0K4AWuFrcCtdw9uGsXCQ@mail.gmail.com>
Subject: Re: [PATCH 10/18 v2] sched/fair: Add force push task mechanism for fair
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: arighi@nvidia.com, bsegall@google.com, changwoo@igalia.com, 
	christian.loehle@arm.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, pierre.gondois@arm.com, 
	qyousef@layalina.io, rafael@kernel.org, rostedt@goodmis.org, 
	sched-ext@lists.linux.dev, sshegde@linux.ibm.com, tj@kernel.org, 
	void@manifault.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 Oct 2026 at 19:40, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> > >
> > > On Fri, 9 Oct 2026 at 07:53, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> > > >
> > > > >       task_tick_cache(rq, curr);
> > > > >
> > > > > -     update_misfit_status(curr, rq);
> > > > > -     check_update_overutilized_status(task_rq(curr));
> > > > > +     if (!tick_pushable_task(curr, rq, rf)) {
> > > > > +             update_misfit_status(curr, rq);
> > > > > +             check_update_overutilized_status(task_rq(curr));
> > > > > +     }
> > > > >
> > > > >       task_tick_core(rq, curr);
> > > > >  }
> > > >
> > > > Hm.
> > > >
> > > > I think this mechanism added on here does not works.
> > >
> > > Ah yes, while factorizing the code, I removed this main diff between
> > > tick and put events
>
> > In fact this is on purpose.
> > fair_check_pushable_task() is the function that is called to decide
> > wether we try to push or not a task. In the case of short task, we
> > will not push a task that is already alone on the rq
>
> I'm confused. So, is the added tick push mechanism not working at all
> on purpose? For future use or something IDK.

The push mecanism part is generic and includes a push on put prev and
a push on tick when the task is alone and never put back in the
runnable list. For short slice tasks, we don't use the push on tick as
there is no reason to push a short slice task that is alone on the
cpu. The push on tick will be useful for other cases like misfit task,
EAS and cache aware. The latters are not part of this patch

>
> Before the fair_check_pushable_task call on tick_pushable_task():
>
> if (rq->nr_running > 1)
>         return false;
>
> So now at the rest of the function, nr_running have to be equal or smaller than 1.
>
> We call fair_check_pushable_task() with next = NULL.
>
> There are only 2 paths that can return true, one of them requires next to be true,
> so it never works. The other one:
>
> if (check_pushable_short_task(rq, p))
>         return true;
>
> And check_pushable_short_task() does this:
>
> if (cfs_rq->h_nr_runnable <= 1)
>         return false;
>
> As I know, h_nr_runnable should be smaller than (or equal maybe) to nr_running.
>
> nr_running can be 1 max, so if h_nr_runnable can't pass nr_running it will
> always be smaller or equal to 1.
>
> Maybe I'm missing something from the start :-)
>
> Thanks,
>
> Kayra
>
