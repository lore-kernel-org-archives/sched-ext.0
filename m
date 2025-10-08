Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4502F3609
	for <sched-ext@lists.linux.dev>; Wed,  8 Oct 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936978; cv=none; b=F+PFrzeDXBxtrAMPc8DssXRXhauM23uYBU7hJ+kfSTqoa/feg6ePHmIXoes/faPL8Ziuq5rXeW+1yqtuHOG14jFvUB94okTSpi46eJW5nsf4eCphicFl/7FTwNvWL1UaWpZKu2fQw/ZBhENX/XMlERtisNFasd5mwSco902KA0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936978; c=relaxed/simple;
	bh=2siM9yREqhk1evwBBV05rvjedon6J208mF1lxh+zAWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ToRhopvNU/d6vxZjXHnVX4Bao1DbqyJSVCogRhYLIcFJTPLKN5o+yWU96GpFWUd10m4hQrSVXMjDd+Z4wZQ7AnQvDOs0IzZ7fXJPLmU9V1rz6LL8HZf8xCE9r6gyYutzpMxQwzGQPXjFb33NPU1ubsvaT7FwB2ZboALD1aFM3V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ypixQkvX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypixQkvX"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb78ead12so1375736566b.1
        for <sched-ext@lists.linux.dev>; Wed, 08 Oct 2025 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759936975; x=1760541775; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u8IL1MJVZcL+yeXHblmq6i6BaDGI2XMDGXwWjrVz72g=;
        b=ypixQkvXyVV9PQA5ziFU/cdjIOS3s8Rjnc2CmC2tk5u7VzQispBsvyFRo1/mFagQhf
         Z9mEoeAcXFzEbWOowDj0iCHd/b2nqVn8b7e8aF+IO11pLF6u5pZinFfPCR4T5Sfu8Y2V
         1onQRi4pQyF/Mp060uEoDtzKLXVKJAZc5pEK6EZU2DtnrvGQF7lRgwp++zj2yWpfq7qZ
         mERgRjTKplpLij/XzAUMX4CMEib1txb9JSWbA82JuzYR0bGG9+5LoUtLEjHupqClqOPN
         eC1EDdjTsfHBlVwC89ZKxs8QHO2ERuWBmSkFrG1pv3CwUCKbvbFoWUhPugWLjCGxFweI
         CR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936975; x=1760541775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8IL1MJVZcL+yeXHblmq6i6BaDGI2XMDGXwWjrVz72g=;
        b=vXrz3v3XyBd0+clzCe3mliDjozGeazeAwL3qh5DvIdaHEnzFETJeFFW7YkZfJtsXQN
         BHaFBey/Em7RIf5kkcdBX95QhoWvI09/liHleIxVUAuAXK7e6hh7C7ef1DGSYGMYWLUu
         LBOaZNNDmM11BsXNnRRuxcgF5WmjIsMnhShvSxwu5YHvA/NKlYC4eqAOB5lt7QHlGgnl
         /Eq9cY8Eu98ozYil+YEZ9Eid/bhNghG4NKeiLe4HGUYFtyeWK2YE+vnon2eaCEBhMEE0
         jekNw1MMOX6z5o5yvV4QxMrs0MOzyJgyNbtSet98PeLIevAy6StK8laqAl15C3tyXSFA
         wxcA==
X-Forwarded-Encrypted: i=1; AJvYcCX15nqhaCryjnztgd437K+sm107oWTWOKmO11B3qVx6I1ru12faKq0eR8HJ98iYwvZk3U6mFyNz1bY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwUuSRcHcUXMy7U8Yj23/6UhnmMLV7o/MfVaW8rl+NWaUUdylqi
	59Xq78khH1EtEuB+ko//V5uUUTn9439lmsAhRnExu42+tUDkdHrV+LCaqZ8VYOX80RWuBZKwV2o
	GsIJ77Ym/NgdLa1iKewFNh82AIJ1NKTnh+1UdN2vg+A==
X-Gm-Gg: ASbGncvzrW/Gt4BHvii6jIBGeK6IPkN+D+Xv1P+CXTPm+dNqIgCj9nfsfFs5gmvpg5G
	BkCWbulaWmRn7JXQpIgeJeL0CAFy4Nf8ma0seUY3rXt0JFUyjktyr+a5PY6t8QuTRHuKOYoiDSc
	cO6JA14IMYcWPpzB1WKL3OPC50vCcrSPCEW4qInhitLLOVLvr3vFRu96RX4bU+108jjMZEzwrDR
	e3B62Vso8GJSnZvjr166djYKS3T3gE7/IyDEbhiUvnTC19SlyTXrOIjtxMN9HNX
X-Google-Smtp-Source: AGHT+IEv9slRsfR5X3TXspH/uXKr0CnvgtVOqHiGOTJdOEngGu5NvMTv0CV3ST5SsNBcsjOejLZBA905vSFz/HXp7oo=
X-Received: by 2002:a17:907:9404:b0:b07:c1df:875 with SMTP id
 a640c23a62f3a-b50acc2f5camr471007566b.56.1759936975069; Wed, 08 Oct 2025
 08:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251006104652.630431579@infradead.org> <20251006105453.648473106@infradead.org>
 <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com> <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 8 Oct 2025 17:22:42 +0200
X-Gm-Features: AS18NWCMZ89A2Uc8OjuCKIj0t-GYofpct9xdmPVvK_SHfZZWp3n4tWEOwjGeIvE
Message-ID: <CAKfTPtDG9Fz8o1TVPe3w2eNA+Smhmq2utSA_c6X4GJJgt_dAJA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, longman@redhat.com, 
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev, 
	liuwenfang@honor.com, tglx@linutronix.de, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 15:58, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 08, 2025 at 03:16:58PM +0200, Vincent Guittot wrote:
>
> > > +static struct task_struct *
> > > +fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
> > >  {
> > > -       return pick_next_task_fair(rq, prev, NULL);
> >
> > The special case of a NULL rf pointer is used to skip
> > sched_balance_newidle() at the end of pick_next_task_fair() in the
> > pick_next_task() slo path when prev_balance has already it. This means
> > that it will be called twice if prev is not a fair task.
>
> Oh right. I suppose we can simply remove balance_fair.

That was the option that I also had in mind but this will change from
current behavior and I'm afraid that sched_ext people will complain.
Currently, if prev is sched_ext, we don't call higher class.balance()
which includes the fair class balance_fair->sched_balance_newidle.  If
we now always call sched_balance_newidle() at the end
pick_next_task_fair(), we will try to pull a fair task at each
schedule between sched_ext tasks

>
> > While reviewing this series, I also noticed an older issue that we
> > have with check pelt lost idle time [1]
> > [1] https://lore.kernel.org/all/20251008131214.3759798-1-vincent.guittot@linaro.org/
>
> Let me go have a look.
