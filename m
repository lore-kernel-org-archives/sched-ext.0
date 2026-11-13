Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794560812;
	b=L/qaaNsUzFg1PfzNKG7HF+5LW2f7qzlsG7mvb+s95nc4FWulEl0jRFIBGROd55Uog2Ox
	 CxWVgMjAZWwNBjroHhkyYgq0KaMgky15hAlYpK346pCS90ziRupQNCE6alfvzXmRNpkat
	 mX8VlfQnz2SZ7OpBgHxMvUHAKTUOOzvqBwDiN3yh3Sy/cMWtIdfS8fVrIjkjVKgslW0RV
	 jw7G9y/LTWTHOgYH1CIV9lZMnpjOOPlgwNgdatRr2YvmErdEUwcOEU/kQeIEi/nQeHQPN
	 t/OpxhD7bjGCJtKsbP+6x7XpxRP21UGCRRVdDqdmOv30UB1NHbgriPteDPaWZyLcbjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560812;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=vtfYfPkpsM3aevCNl4mNbvXtj6ZUPVZ9KyzCjRAl4TM=;
	b=O+Re8p4bs8BWF4Wd4HWIrPQsV1YJAFME442qba1TbkLa/ZzjYXoZ8rIxitKXdCioil15
	 ND8NYCTtNMY9+D+96yg9DzNUo3ngIPAAQ29O84jEpw1fMaX42pfdi6cJjEMdOBvTkcZDT
	 QMV6kByIElzjT2ALFgTLRGD/HlJ4UzafyWU1YL5kNJSyzblsMMnpeWUrZFKYscteXX3TN
	 BkoBh3/F8KXx/feHa8Lld8BRKysIepT539GHR9O08/H/w3vwiSrkE/Ob5SGE6p1tytu3F
	 iRllTX4wUUrR0pZtaUNQ1WOdZVXD1nIo/i4iyhq5NwN2v+2Qy34uiJKi0e55+6DjEZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HTGM6MEJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A4606A321
	for <sched-ext@lists.linux.dev>; Fri, 13 Nov 2026 09:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C81A4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HTGM6MEJ
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4d427836e9so111271066b.1
        for <sched-ext@lists.linux.dev>; Fri, 13 Nov 2026 01:06:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794560810; cv=none;
        d=google.com; s=arc-20260327;
        b=q6hDs9Yjj82oqMwPKehiCufQnFsGrcahane5veyKFabJhAOxvHyZtkcRkWu91Dhv4V
         YLZOEPcRD3ntXvLtsSJdXM8SsqE/h/3ng+dH0pCsB+QYyfYRJMyYFZsporOS48D2hzDi
         vvf0P12ss2PGaLmD1duw5e/INuGrDGksBMExhmls5HH9x0zLv6X4pbNbStO7HBv3/MBN
         y8s/riuDRAS9neYfAje5mbxcso6qnZCCR36Cu7EXkMijJArGkjLnxLe9UGhuolQz0K82
         LxhfT0TJ9JHKj0bg9/E/ya7TO2M7hxtBXnB0cElkzDIs2oavBXADm/XHmSzTMQAAu4Oq
         370A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vtfYfPkpsM3aevCNl4mNbvXtj6ZUPVZ9KyzCjRAl4TM=;
        fh=jGRZUdy5UHFTk1pCu/q07g7wodMK8xPLXfxM5E9+xyI=;
        b=LvMDkWuYII9k9kqHtbgdH6499N37CBFQkD1ktLyJlrTUtEfHsrkHIuFqbNCmhk7ssE
         bikT2oKxEo/cZp88aFXfvfZRBoUTP8CHrNgZBkDfOYRXPlX2PRJGoft+O7GfQudUFs8M
         rkwWUyFGPnltk/A+WIWfgHV2hTeMyDGtjeoFf6saaCFUhLaKZCxBXgJ2zg+T+jP19eYf
         rOmb4E1NewdCB5/oPS5LtLgP44LouoTs/iUsEB0zQ/NYPS8ON+LsX4H6XzI9cSOdx4/9
         TGCPut9cKUUGciIU5AwigJn2ee6Yo4f/JJewktYi0sfJslsn9JJS1NI04iTD452dSnhJ
         SDYg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794560810; x=1795165610; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vtfYfPkpsM3aevCNl4mNbvXtj6ZUPVZ9KyzCjRAl4TM=;
        b=HTGM6MEJszLl4vSVbztRyz7cwkIkuCWHAT0VO+deq3IetlFrS0bwqI/fYuuzuyy2fj
         A/QiYil/94kRjnbeQgmKbNkqPQJv3yM8XKtk1LXspPvVmyPuxupKge5EOEAA+SArC4M4
         w/PU623RXtFRWRC3+06zPWRmEG7u3tNl4PKaHoipOV7hH6BQMaIzOtS7LBPgVcxWybRX
         hlTI500XRD8Dwag62s7gsydcFAelKEf7wBoA5k8/nM8Wwz75qk0oZUslYOhoeaOooEob
         FAOOB/NtgTPaW1MWQHWXzRNsn2qQ3sOFdKsUn3s7vGZzovJ7uK5hEZ9bSmz5f/CTN22h
         zbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794560810; x=1795165610;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vtfYfPkpsM3aevCNl4mNbvXtj6ZUPVZ9KyzCjRAl4TM=;
        b=M9RFfgDjjLXYGwEtAkEWjnNIwFKSoUONynNX8RxbdVR4G1lcC7Us5X2MfW9gOZHQuz
         37wa2Umj/7dlJJkPXa8AMPtoFwFf9tMGaeT/QShq+k0g5lii2/ItPc7lllRM0nnYyzJA
         DCYNEeggnw5Wd3AzS866klYYNmI9UJ0av9HNoUr1srQ28eCLqfCIlSjPCNw9YI+UNWij
         eu5yjfkaTgsoddlLl5PwQ8c0ZxFbBy6xdGwthkkgN4/OLdYiJyOwmiB6JNC5XaTbrw6A
         fyHEk8RmzJJWRfYEouG1hHdO6UxJz+WuqLB4Su8pqb/dzzZ26J4xLMJIbWmR0s64qW5F
         UqDQ==
X-Forwarded-Encrypted: i=1; AL+hErHApqx7yXOnF0xMuRSVzPI0z7Ju9iQzGCtvYKYpyoPgkRtexJVDXQareZBvF9Q92dg+N1jxkU3t7/A=@lists.linux.dev
X-Gm-Message-State: APuU4Z/9yzZ8JxxVCmfhV5oQeZMZBbC4gyqZrk1sm59dQeTVCrUveiF0
	4vVc7oMU5Zm3VQ/7zWBBAJgFxr50Itg7s6XXcYfZuxyKqjcWOoyzn9LnWN/ne+cA4pg6/JaRgYn
	R1qErcCccLs8NmbtqJfREBqxA8s/a1FPufhhQuv6DDA==
X-Gm-Gg: AYBFou1dCUX7XVDfI1xhe/fCoXF33mPBXw1ExcdqFhmevuSTs2TjPyXG8wUZ+mEgDHs
	aFO3KhwPMHfcRmSTmTVIEhV70QDBWUDPPNvXnFQQiaI8y29lWDb2xCZ2TqaUD7aZhZtyos8JvdY
	HILSicsHKreDSsHpvGmZm01S9tlvXtZgV+u42MGoBIlwxZuSW2/Jv5QM52XuvM0vPYaRY7Gqtpg
	MR/1A83J0lEgIlWAdeE6M4WpjL56rPGpqvrua9J7bLjzLOQ6qd/EPbG+H5HhwgeRZicS/wG7O2n
	ArG0/5878TDMcJiK3U+NedwqssI9Hy/AdOYM3CzwL+RXaquVwdIZ2RlFUyFVVjKWDaQNKQGveRl
	s221jT0eNvlcd06dIFUzl5+Cweg9g8smYTNRQ3hEO4PSbTphlJTuDZlsHgQ+H2FPW5XErHyo=
X-Received: by 2002:a17:907:930a:b0:c40:19dc:a24d with SMTP id
 a640c23a62f3a-c5096344fa5mr156377366b.9.1794560809980; Fri, 13 Nov 2026
 01:06:49 -0800 (PST)
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
 <20261106151947.3991524-9-vincent.guittot@linaro.org> <6033be91-bdb6-ce15-5b65-eef73256d175@open-hieco.net>
In-Reply-To: <6033be91-bdb6-ce15-5b65-eef73256d175@open-hieco.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 13 Nov 2026 10:06:37 +0100
X-Gm-Features: AclHuK-1b2VQHyP72RlSkoAcwpr-03tXyP2Sbt0wcavFo0b3c-Gjf1clcwW5VHA
Message-ID: <CAKfTPtCYEgz0cVWLWt+S6+2uwjwsM3xZmjg1oQG7u5CYD9muPA@mail.gmail.com>
Subject: Re: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
To: Li kunyu <likunyu@open-hieco.net>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, kayracizmeci@gmail.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 09:47, Li kunyu <likunyu@open-hieco.net> wrote:
>
> Hi,
>
> On 2026/11/6 23:19, Vincent Guittot wrote:
> > /*
> >   * select_task_rq_fair: Select a target runqueue for the task.
> >   * There are 2 ways to select the target runqueue:
> > @@ -10552,6 +10712,18 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
> >       cfs_rq->curr = NULL;
> >       if (se->on_rq)
> >               __enqueue_entity(cfs_rq, se);
> > +
> > +     if (next) {
> > +             /*
> > +              * The previous task might be eligible for being pushed on another cpu
> > +              * if it is still active.
> > +              */
> > +             if (next != prev)
> > +                     fair_add_pushable_prev(rq, prev, next);
> > +
> > +             if (next->sched_class != &fair_sched_class)
> > +                     fair_queue_push_tasks(rq);
> > +     }
>
> Regarding if (next->sched_class != &fair_sched_class) - would it be more
> semantically correct to change it to if (sched_class_above(next->sched_class,
> &fair_sched_class))? The current code migrates all CFS tasks on the current rq
> whenever the next task is not of the fair class; I think it would be more
> appropriate to do this only when the next task has a higher scheduling priority.

I'm not sure to get your point.

We want to look for a possibly better CPU for prev when it's put back
in the runnable list. If next is a fair task we queue the call back in
set_next_task_fair()  after having set next task but if next is not a
fair task, we queue the callback right now so it will be called after
swicthing to the not fair task.
That being said we can probably unconditionnaly queue it there

>
> I'm not sure whether my understanding is correct.
>
> --
> thanks,
> kunyu
