Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68144E73D6
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557258; cv=pass; b=E+l/oe0FCMIJvejoGIoaQF7bSgmNKshYQu08WwHz1shPcgEXQJRHfRnawFAGl+uVCRYXAW/EGehU8+deS0KwaWcLus3HUPAUhozP5YYhbGFyuK5gjXfabuvbvVD9KAEgEhl6cychB0XGm3bBjfsRZjpXQB80CuorOnHTyMo3NdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557258; c=relaxed/simple;
	bh=Blo9bZJVD6llKnlgZ8v9dI0/4WMj577+qqF42yQZww8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZ/tx7ux/OeJrHQ4f2N1oXwtt7vZW12GtCCixR/RKMSRyF1Hub2xNF8O2vMmuZra5NmocEdD/kpRLuifhGeEQbq7PXb8S+dXBRq0YEr4pLaSLaqk6mj7HmQfsfe+Vq50YVpcorrq5CEOAk7ihgSRxU77WJiIHI3dGbgNlQpHaMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MggnRDVc; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MggnRDVc"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b170129413so2159603a12.1
        for <sched-ext@lists.linux.dev>; Fri, 09 Oct 2026 07:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791557255; cv=none;
        d=google.com; s=arc-20260327;
        b=CunDgT3ibxdlrjhbdZTG5JaAckd/uSMtevIf7mLJItA9WI/YNm5O9lgqwxa8oPeQrw
         4B+AqA5y4s53OLVbkkrzfG6XE862GsJ4nTLz2adMLMMJrOqiwaAXD/IcFOvY8yS3JNzO
         sHkYwqhDRMZwwAWHHVTkGIEC/NZnBxmvINITLvuMMedAEFwfk6GeN+oci0xfhPFS3sqy
         lWxwUJ2plykX7FFXUVV7CUrpzFUl2zZ4gCgPuuA+HT6Mocsv3wl5ySxGFEYCsrYYbIEP
         U+G9g5N/qeEOz2WzeaIMg+ZFGtgJkYnD/s0K9IxfXKpnbUjQho798yzmTTxuzfbKq97H
         CIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fYrhqlvlDqZyhpHYosM1z+TE4xAbOSyFmrTsse4+jk4=;
        fh=zokDH3sNesGZtjXqrRb0B0Op9ZtC95HQScK2Zi6xhAM=;
        b=PlIWUC7BdgmsKnbWlGekXQkzUASLYp/jgaiGUSWQ+/KrBUtl2b0oi9q0Tj0ePlBbZc
         Am/wf84sfGnVBIZOl0A/o38tCHi5vGSl0pDwKB8emY4tk4+e+t/JtQ0dgjskF1Fp3N2H
         ESziRFdUKEyrmhyNW75CSBgHoyu6b1FWR1K2UiBCNvxJ10cKdgSlDpWivJajnlHHEIgX
         Wpx9wr/rDjdbXgEmYTuJRTu2ePUF6KKhu+nSMeOllgTO342ovDyOkgP/nkw6Auo5fPqz
         KPqtKM1qXH/nFOtp2QSAyuMII2CtkFL377R6vVDRepX1Bv7jxbl5IKMqlRwQutkdRhu7
         YaTg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791557255; x=1792162055; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fYrhqlvlDqZyhpHYosM1z+TE4xAbOSyFmrTsse4+jk4=;
        b=MggnRDVcP3B/OxXMPIoCuhYo35scGU6/2cBSoOpXEMj2nHmU98XVMB/+Mf27Qrt7/h
         aAJlQfe/L36xx5LJxBy0LBEDLprYq3tqMYEGh5+WDfHealDW1E/2Gnm+8+EyqSF1ibbw
         brdEgyXKn6t/6MrlVTg8d+rNfEUhsEq1oqaUwv6k8xOV6LjvRBu5krBPtoCxb/pGll29
         84BeQVuHy2HUiTDImUMfIZEBAGhI6wB5MnjPqUjxJj7zfh0GYNS1/vSm1TB+9xUaf/s+
         ugw7sm2rrUpmlvneae3so53rMCHsjRNHaWftN3k0Ln/okVQmO7xJ23z0gAN+2RRrP/MY
         2Qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791557255; x=1792162055;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fYrhqlvlDqZyhpHYosM1z+TE4xAbOSyFmrTsse4+jk4=;
        b=nGpXh23/7FvnGvE5RwrqryiG0jmi3z972Vf7yrdMM5ToUUt7CBa2kD3CYoQ2AZh4or
         TvTHTwoQYXR0+MQP1OxNbkPhqdHEliMmTQy4Ey+P5E9fzysBry/i//u/SU+KeFDLX5Lc
         l6j05imG9y2g9RVuFyH383wubeiOte3CeMmM4aGglH7bde2iz0X5MKB+J4a7V+SKTnXF
         riYQSl/d8pxKXuVnbphEfHP0//DEejgTXDXJm5gVV3gdTjazVdeEQqKFCw7q4cwoIRUQ
         ZRjh0pszYOU9RFKQ1lLFnpTI5UBdHIcRoB/Y2jxiKm9kcXLyhr5xIPeYjYRV7KE2NpAr
         VLlA==
X-Forwarded-Encrypted: i=1; AKwUvBx5nGpBir7V0Rh8Td8tXkQJg7b4OEmR+kl0j2v2WggXuGhg8+ugDjXfOlH+yo79YbL2dtHDEf77R3g=@lists.linux.dev
X-Gm-Message-State: AFq9FYIzjNpITckiWQd+8YLi6jWztMMjq99v9MlZFXq454zw146jdtPx
	ac7FBVfyUtxUG5sAPsTst2lavzmev4cMHwtqFSmAHyYRVEwIRDSMYt/kd9rSzUzrSWwalAbFcFp
	0Fl8g33Z9JymXZDQE5kGIZAHVKn2jsNRSQ07ozD/QXA==
X-Gm-Gg: AYBFou18HsC9w+U0fmWb6cFGlLe7Bl4RLELNpN/zK74gUZD5ckaR9bpiuB5/AGS8o57
	yOBu0a9Q5fTNEtvo3Ys8dQ53xhHYOOx/O/mE4Z4vJGnU5oxUJ59SVKvN4s6Pk8pLtPQXu6XP6g2
	tEYbKBwrIwMgDzRY1jpFJvtR9VHUWl9oipEZMr/caYQjbHL6hFZTzGb9vsv0NTg/8Ruz8iY08Z+
	5MYWmcaT+qv99IhtK5y/HSbrn5BBOEj9p5Ahcs6XF6GH1MErUX3nEyPE7Af1sYKtAgo9A9sVxEu
	fS7AqvdgUpk4Lo99U29CAS3F6U+JDVVqltFlq78xt3CPXmUzWorJfcRsdTLMo/+1H7cZMS+BbSs
	Tky3onttl5xU=
X-Received: by 2002:a05:6402:2489:b0:6ac:8dce:5a8a with SMTP id
 4fb4d7f45d1cf-6b17c25d1dbmr1911978a12.9.1791557255037; Fri, 09 Oct 2026
 07:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002154415.2270586-11-vincent.guittot@linaro.org>
 <20261009055318.29609-1-kayracizmeci@gmail.com> <CAKfTPtBvGYp2S4P-k_SsFAXMVSSQ6j4F4LO44uUoDo5ZaUe1Bg@mail.gmail.com>
In-Reply-To: <CAKfTPtBvGYp2S4P-k_SsFAXMVSSQ6j4F4LO44uUoDo5ZaUe1Bg@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 16:47:23 +0200
X-Gm-Features: AclHuK9iGeFj7ZuSh47IJz473HQO92ge7LwBJsa7yRJFssp2W5pUDwwA41CDc9g
Message-ID: <CAKfTPtCAbreGDhesDmFNvXEzjj+anmOH1=jqT-1B6Lfj0FfPqw@mail.gmail.com>
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

On Fri, 9 Oct 2026 at 16:04, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Fri, 9 Oct 2026 at 07:53, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> >
> > >       task_tick_cache(rq, curr);
> > >
> > > -     update_misfit_status(curr, rq);
> > > -     check_update_overutilized_status(task_rq(curr));
> > > +     if (!tick_pushable_task(curr, rq, rf)) {
> > > +             update_misfit_status(curr, rq);
> > > +             check_update_overutilized_status(task_rq(curr));
> > > +     }
> > >
> > >       task_tick_core(rq, curr);
> > >  }
> >
> > Hm.
> >
> > I think this mechanism added on here does not works.
>
> Ah yes, while factorizing the code, I removed this main diff between
> tick and put events

In fact this is on purpose.
fair_check_pushable_task() is the function that is called to decide
wether we try to push or not a task. In the case of short task, we
will not push a task that is already alone on the rq

>
> >
> > Before fair_check_pushable_task() is called, we check
> > if nr_running is bigger than 1. If it is we return false.
> > So when we enter fair_check_pushable_task(), nr_running is
> > equal or smaller than 1. We first run __check_pushable_fair_task()
> > but it doesn't really matters, since it's output
> > can only return false. Next block is skipped to since
> > next == NULL. When we're at the check_pushable_short_task(),
> > the h_nr_runnable check is always true on this path,
> > so we return false.
> >
> > It this intentional? Or am I missing something?
> >
> > Thanks,
> > Kayra
> >
