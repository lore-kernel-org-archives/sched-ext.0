Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794240475;
	b=WELaJCha1YMFcKDBmrhxesWONCzvsQT5A+3h8dwivzOJmE4X26Hs6ENipO/FI6HZqFml
	 1D+0EA6r6X19udx6luGYqbDGUhdZ9pWoAJWQUTc0mom01WLAbLg+8Uo58BzHagf/EDMT1
	 cdCKArLQBbQ3yrCSVpNWH/DIzXMXla6axUZ8fK7FaK17CGwcebqIukUrjvFhgQ/ZT8EbD
	 R964GPBLg/ODV0yr5KlqfUbXOyJr7PQhu4plYxop9ILOL2SQkaKannYmv0JW2mIyC8TPl
	 m0WIzHJedWxZpKNtvSk/ajKUo+kKjxf2J0w/2IR84P7s3ue29rJqM3Z6l7knGRyoIbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=MbwONemvQTwiYEvnpJlP+l9rrcIEBnFd/b+PD1QFDBQ=;
	b=RkjiQmyjJ0/6DLoIEaxsqR5bjVW46atbwLXa57XKPEqlKCkWR+qS6lo41Y+6oa8SQftL
	 azQO0SwjapCKa4zy61K3gViZSyCdCz+HIjPZN1p4hNhZrF57Kwca3qiuM65dc0+fVxEcb
	 G/g1+n58NV/B+ZXJ+/BHX4FXEcV8HPttaxSw4VQIc9MPURKW1Vh20zNojoxgYBrYi5YlR
	 KTqWppgAxQZmNXs6mJ6MX5dlllAmTkxbTt9feva0ja9sYfMcAZTPteVsUsMm0rq3kl65m
	 0ZcX3vMKCOxX8gFpp6sOb2VnmDdRgx1nnLGHCVzjeE1csliiMOrBMw+n1aoHOkNyd1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JLFOL1Lh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03079606EE85
	for <sched-ext@lists.linux.dev>; Mon,  9 Nov 2026 16:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03079606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JLFOL1Lh
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1845408c88.0
        for <sched-ext@lists.linux.dev>; Mon, 09 Nov 2026 08:07:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794240474; cv=none;
        d=google.com; s=arc-20260327;
        b=ryIbT2eF5A5OcA6VLRaUwpKhzSq1Ip9Vu+/3qG16C5kiVm+5/ihQIgtltxpedRyeG2
         h1H7GGKk3WrBf9WPNtlJmlwhFOXhdJB3xVOR/jF6rX2MEBSDRvoYtypreUBIzmaijzlu
         VmMvUhvtuE7QAwLFigRuoyVv6Edz7qkX94WFKDgN4t8o2XX8cSIIa52uJiS94d/nyAbP
         yFgtKqDLbomAkTsHTaN+qDWd5aHcYcJ+B/ElOmEfhBoOCLPmnFSZVHbnTiiRbyN1Nu+m
         z48Hw1XAbJjIE5R7Yd6gm4TlLQnnqB3h+X5yzugq6kLZfmxiHdRlaRlfIKzn+H1yFf5e
         yKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MbwONemvQTwiYEvnpJlP+l9rrcIEBnFd/b+PD1QFDBQ=;
        fh=kvMa7wafbHqJq8ko1bpQ9G1HK1sEt7ZoNgWQGesf8KI=;
        b=p4RZwIqPjYyf4C0DsZL9nPnumVWDTCfpjVPAF0Mj6hynwABnHpSzs3jRInuH6EC+Vn
         uK0hBjCIfEn0nUDljB+0SEPiMpCCn4tJZuvA4fHdVDF9S6pigCrWkgiK67LQhvTOwsgA
         lATEXbEOtEWAeWHv9F8U5dspo+sfTs48UNfJ86shULFuL9TZL+kPibMzamKL9UgBQ7SH
         Al4vFWXx4eRkFrSKWoEdcAJSsXFpnCAdthXNPbK6KqbivwpmA8NhDhOH92b5yTk8T+mZ
         EeBYligltyVP3xAZnd6ICNfadPpkL4ZtY2lW0wV8E1paONeahkLWJOV1eu1taT7GncBz
         a2UQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794240474; x=1794845274; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MbwONemvQTwiYEvnpJlP+l9rrcIEBnFd/b+PD1QFDBQ=;
        b=JLFOL1LhLwM4qlRzyjUc8BhG013TGbfcK9oTreErBeLKxVelLgO2SlIBdpIfpcXScG
         6dWpY5A8GsVrqus5Yh1KH7PRRntlvcu7bfrsexLfoyexH5AtQhTnpRF0X+cd6ZADK23g
         KYEtt0FzrNU5PVgsPe6FSM14C8iQRBj0Du8aQYtl06ZUqHTZ9Vuyu46NHW1RXemD3Gm3
         KsMucQkbABswE1jVHwlyfw0+mzI0/rtQE5sN2vg+M2yd44O4Z6z5fWJF93TGoP9MjLdS
         p+iL4asm6ET4k/BkaNLIL9zZqgXSXr/JGblNU59Y151VzDO6jOWKZlJfiKK7asHo9eba
         zQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240474; x=1794845274;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MbwONemvQTwiYEvnpJlP+l9rrcIEBnFd/b+PD1QFDBQ=;
        b=zRPpDyFSDGM+ASAYqmOAfUxXp/T1jiNwuqH1yBsjilArGLQ/gAasG2khhrS4lZUV90
         7vdJoyr0/bC/eFe11/wzp+vx3tzuzgT+3kIU4C8ORU8z1PCp3g7pObJLw9UgDG1FZnnk
         kwq7J9Hf6X6fUcc9OgAman3GrTakZ5ls1LaPzshg+y9cV6xVwvR0yehfEUDaysw9fK6+
         ZARMDq5hvqltLUxzHLR6rqLJ1yHkHDZEVzgL2+3sF4WPZFeiU5iHuHgTG+1t9zwFiwxI
         xLytwgtjEOmvbUQC3FJH+2tueBpiGj9tfTyPacEC4FFxy191E9jDSRBpA5JwsqkqieRA
         zOJA==
X-Forwarded-Encrypted: i=1; AL+hErF9Nn1kILBMLRvPXvuvSqr1JWgrVkeZSPiHK5oMmycP55LpPYpXqmqF8bJvp3IDoeOpW93aZwWMJWU=@lists.linux.dev
X-Gm-Message-State: APuU4Z/h5xgjxI1k+pb3i5qJyH4qVEA69b+5cen3qRgV44vnz203y/4S
	T+/4XGE9dtQ3hzf4RMRa+GEWmAF9yHXVOa5IIC+1s3uBhHQ7wreWVDzkQ6tnXcf0eY673e98Xb0
	GL0YR2uBw24wbnDOGk4NHpJyPs8mAZHXv3lpzm0WmpA==
X-Gm-Gg: AYBFou2r0lT2CZcbHqPtlSTbhkdWciiWkf6HzoOGHgJmrGHpL+QLrcsrHFJhibK1722
	kN7iYhbRuo6FR6kALVgBYoHVDYMXVEnakf7gKI4m0VhSZBe/HWhUFzKvH9SSbulR4cJW8aGGt2X
	ntEN3/kftk3TXQWyygxz76AcbpejkXtrlqlQM4fpVUysFohmreEWMIyoOCA0+pMxnFe+0vD2TNy
	wNn+sdcf9JZFKrP67p3IaQZ93xrDzhNRUSl1pskL8Lk9Y34+/91qCKCCwmvkTb963KUNaxkRWDK
	8CBB6yQjZ/KaWPSAiTIzQRotjVAJiNtfW/yi1snobNu8W+DyaN20Hw9q+yHaLhRn+2sIK8NSZtZ
	GZlFKk0nuq/4V3hpZMSuK7cboHJDc4rv8jcHLUWHUxhhLRXbbYCHma8EAkC7VvoyRtMGHeUY=
X-Received: by 2002:a05:701b:4284:10b0:194:3a84:e67a with SMTP id
 a92af1059eb24-1b39ff06096mr7491026c88.41.1794240473701; Mon, 09 Nov 2026
 08:07:53 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-9-vincent.guittot@linaro.org> <20261109144350.GD2668564@noisy.programming.kicks-ass.net>
In-Reply-To: <20261109144350.GD2668564@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Nov 2026 17:07:31 +0100
X-Gm-Features: AclHuK8HkNgfirok1D7dYwfSows5oKF3C-rSYYm8dDteUYYcSG8yjSHtd3IxClM
Message-ID: <CAKfTPtDcu6HS-G75bG7xp10t-n-XceneFtqxa_cAd+B96zCJiw@mail.gmail.com>
Subject: Re: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, lukasz.luba@arm.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, kayracizmeci@gmail.com, 
	tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 15:43, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 06, 2026 at 04:19:35PM +0100, Vincent Guittot wrote:
> > +static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
> > +{
> > +     struct task_struct *p;
> > +
> > +     if (!has_pushable_tasks(rq))
> > +             return NULL;
> > +
> > +     p = plist_first_entry(&rq->cfs.pushable_tasks,
> > +                           struct task_struct, pushable_tasks);
> > +
> > +     WARN_ON_ONCE(rq->cpu != task_cpu(p));
> > +     WARN_ON_ONCE(task_current(rq, p));
> > +     WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
> > +     WARN_ON_ONCE(!task_on_rq_queued(p));
> > +
> > +     /*
> > +      * Remove task from the pushable list as we try only once after that
> > +      * the task has been put back in enqueued list.
> > +      */
> > +     plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +
> > +     return p;
> > +}
>
> This means a task will only be pushed once? After which it needs to be
> re-enqueued on the runqueue?

Yes, my goal is to keep the list small to avoid ending up with many
tasks to push. So I only check if prev could be pushed somewhere else

>
> So if it was found during migrate_disable(), its thereafter stuck? --
> this seems a little weird.

If a task is migrate disabled while we are about to look for a
possibly better CPU, it will have to wait until after the next time it
becomes current. This is a simple way to pace the number of tasks to
push in one callback
