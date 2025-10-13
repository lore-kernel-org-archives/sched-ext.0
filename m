Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4824202F65
	for <sched-ext@lists.linux.dev>; Mon, 13 Oct 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760360809; cv=none; b=BUJZUp9CWFnGdj6sDHd2XHhltrEmyYQZt0ZBqYuwmYNInOhlsOmqPLf93slwE5Uk6dngr5wWqs3Y1FzgF2Ai7SbXKGfHn3C5IvsUtVsHzv9OI9P9dLpuDjC6v30Bd1fYZzp7OeffCb1+Tb97Kq3JLtX2wnsQOLTdT4Coqwk40mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760360809; c=relaxed/simple;
	bh=+JrAJiQnQesllvCVS422pN9G7kOwYoBJGo6cNnQcMxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5ExinxWwRyDuhNtN7VkLvi64rVaTjl5Zq39P2xESdfyBSr5lSTD5roFt6eNJJwH1LjHBxi3TX86dvNVehyL//nVltV+qj0wO9utWAp3Vw1IFnjfjw38emIcMFFv05wYkIqkAr61IcEYPHeO9QqLGKcLk9sDz0YeEESEpRjqbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lnuxlRf3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lnuxlRf3"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b48d8deafaeso910099366b.1
        for <sched-ext@lists.linux.dev>; Mon, 13 Oct 2025 06:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760360806; x=1760965606; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TubnhjRQIQK9VyxP1w8Jz/JseEsSrSwGf9ziOFfYLUk=;
        b=lnuxlRf3arpRYmD88vDsgHjRl9bOeAtQjzxb31mOQcyZNLe6OBshrvesWmWOvP9pd1
         Cy7oxG2SIjYs3yG5n7GJNYwvZ5aX/TJeCnGUm8Fw/cLc2cMCZRNc4tKUllIOkIfBpdrn
         fHHVzdHuqLBIonU1qmfyueOyqQcILkPL0ar6Txgb2mfFuAduyMaJ//blTahq5BQW9W/5
         ltClggryQLw5sz+PxgDcJ88+ZupWCS6PsR9V9gbk3k8KoMFNDYL2U35FrpL0vOX6Gxfb
         aaF4c6EurbkkxpM/ZB4GX90vuKLNtsbAAWwxzhfiDYzT282g56n907mf+Jg1hW6PYX8q
         oFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760360806; x=1760965606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TubnhjRQIQK9VyxP1w8Jz/JseEsSrSwGf9ziOFfYLUk=;
        b=civj+1sDZx9acqdMTyjd81CgQkNqsn4d4u/D9UQhIf1E4mcHEbtDW7Nl/+vtJYOWtP
         +Z3Tqi37UWJeq0b7b3LhV0V49mkBNrDdDN4lQ3X3RwSH5dS8kSs5JGf4oFwQ5/aYq30D
         gxv9WWuUblFAiS47Lbcua0owjvDdK+bnlXmiJlSHg1sjzlqmHJiC9Drd4ezRIz2Qo9/D
         SFv4nm0OZbNsUJIhyt4HDbYmmuErQ3+fEqvap9BANpZZ/LeL4a/yj3b5v1MSm9lyhTy5
         t6Y+JJrD3XumLb/xEH1QcMr01md78jSPQ+cJykLHa0iM8iLG2jSPqmlKvG2agDQ/7kqw
         4cmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRU1GOngDl+IE/8oiegSLXFfQb+cv38vxNPpDPxNzjVaTjuAteB7pq9dYxfjOxZ6lss7zILgs4ujE=@lists.linux.dev
X-Gm-Message-State: AOJu0YwbJaq9TFsNOBLwsApN978MyKMPRckebzunY97u9iNnJC+kShet
	otWkT2kNrrNop1tyARH+9bCpT3es/Rdpu1TrCQGxZrxcA+dcgaE09U5YanuRH7LwuO68K8b8r+Q
	0c3IsH4OfJeDLIcQVUthKpx0KifCm8C2XkMbaBhvl8Q==
X-Gm-Gg: ASbGncs5dSuG4fit8kAZ0C0rsDTI5Y1CXsOM1IdXCCxIcpQxLDakt7onYEUO82tuxbh
	DOjtW7rMhtl10AN+pbS9mBczfUQ3H/4itJLbVtXK6jy4PqPKeP0VETCTidpICbOcoS6tT3OjgUN
	+RJmaxVhZIDMSWZnl6RibKtugp9NE57JTB6p+k2bpzwhiBuPkcShLjWi5qeoW6nmydD9eigTmfV
	zF4SI0SpV4T6grF5qOgGvCnZuZw7SDwMzrLgRRzfQ3FhQVKuyVyolGEqvXKlMg=
X-Google-Smtp-Source: AGHT+IEJdl7nKyjjUWp7J9J4Bp6aSrz+/GMs1soPCOuRkAB+TSp97XKDTmI2RGo+buNVNeL9bBaZ2PquGW3ObBFY6yU=
X-Received: by 2002:a17:907:6d25:b0:b45:8370:ef10 with SMTP id
 a640c23a62f3a-b50aaa9c419mr2027646866b.22.1760360806112; Mon, 13 Oct 2025
 06:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251006104652.630431579@infradead.org> <20251006105453.648473106@infradead.org>
 <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com>
 <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
 <CAKfTPtDG9Fz8o1TVPe3w2eNA+Smhmq2utSA_c6X4GJJgt_dAJA@mail.gmail.com>
 <aObK2MfxPyFcovwr@slm.duckdns.org> <CAKfTPtApJuw=Ad8aX=p3VLvMojyoxVBVRbMG80ADXR-NVL0PTw@mail.gmail.com>
 <20251013110449.GJ4067720@noisy.programming.kicks-ass.net> <20251013110911.GF4068168@noisy.programming.kicks-ass.net>
In-Reply-To: <20251013110911.GF4068168@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 13 Oct 2025 15:06:33 +0200
X-Gm-Features: AS18NWAzGT3q8fm8LwBT4URFj98EAHmqBs8SLH_4hZU7YH6-erXmlA6fCUaV1_I
Message-ID: <CAKfTPtDGsS-+DZEemg6vqbQVV5Xds9TNVnOAOvyeNsw0Kn3Mzw@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, longman@redhat.com, 
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev, 
	liuwenfang@honor.com, tglx@linutronix.de, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 13:09, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 13, 2025 at 01:04:49PM +0200, Peter Zijlstra wrote:
>
> > Bah; so yeah, this new behaviour is better for indeed always calling
> > newidle when it is needed, but you're also right that in case of ext
> > this might not be ideal.
> >
> > So I have a pile of newidle hacks here:
> >
> >   https://lkml.kernel.org/r/20251010170937.GG4067720@noisy.programming.kicks-ass.net
> >
> > and while I don't particularly like NI_SPARE (the has_spare_tasks thing
> > is fickle); the idea seems to have some merit for this situation --
> > where we know we'll not be having fair tasks at all.
> >
> > I mean, we can always do something like this to sched_balance_newidle():
> >
> >       if (scx_switched_all())
> >               return 0;
> >
> > Not pretty, but should do the job.
>
> Oh, never mind, none of this is needed.
>
> __pick_next_task()
>
>         if (scx_enabled())
>           goto restart;
>
>         ...
> restart:
>         for_each_active_class(class) {
>                 ...
>         }
>
>
> And then we have next_active_class() skip fair_sched_class entirely when
> scx_switch_all().

Ah yes you're right. fair is not called in case of scx_switched_all()

>
> So in the common ext case, we'll not hit pick_next_task_fair() at all.
