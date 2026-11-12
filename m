Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794466948;
	b=XYth5/jdbRSu3M0ghd+Ok+b8rUP5SMI1SZlmWhLRrhaYVGE6NFw8U02/9K9zeGbdkmUR
	 C15d4HrT3h6bX+fAH39F9vRhI0wvUxQmu9zxtwsmlgDq5ZGZxKoVop+1uwFZrWJknCIeO
	 y5Y5DH1VQcMuw0vw5aAXv3EeiJh255qX0AvW24yk8R97d1GCVvmsQu+pOfVrqbEJFZhQX
	 Vf6y2B4gP1MaWOlICofWMEmiCvKADb9h4igGNwBH6ex/rJh4Rj/F07Ct33y743i/lqRV+
	 PzBJN+H3f8p11+lI9IuFtdnjRioGEcbIHn2aL4Ce9Y6KM9XPTvS1stOq0HEdDwkmRVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=zj4daZqcOfrk9MLreCDoKv45VzLcW0kMVsw4yuRmjFc=;
	b=v/xonvRuEaASpqUIkgjJFxJLEuWPm+fKmMtIXBjrJhNhT8JKFlGAHVWVXaQjA2C7+x2z
	 DMbSCKAHNvF27LpuC7HALF8OXsvNZB8JvxFxy4P7VekEYp7YxcrkOhEm76bUyfKn4b1V/
	 wCIasqv9FpjgLNpYUmG+BPdxvyEhHVv9XCJ5ryRPtF1mSzWzqDehw6jn/8mNyljdCVul+
	 LXXerRRO4/8HngvlPVkm4nOjc5SB2spG3Uy+JtsbPv8AS31/ciivbu+EZAXYM32szVTXk
	 pAup5JdIchUrzHUzQWjceOHYW/80wpc+ULdsbCnuglbN4bcpN3Gnv1T3QMgMmd509vw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yGYOqUAP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2F606A323
	for <sched-ext@lists.linux.dev>; Thu, 12 Nov 2026 07:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAC2F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yGYOqUAP
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so6171350a12.0
        for <sched-ext@lists.linux.dev>; Wed, 11 Nov 2026 23:02:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794466946; cv=none;
        d=google.com; s=arc-20260327;
        b=KkwPgoibVH5Iwe1gFMsxdqWnOQ5v4lA71kUg87y4Fq4f1175VpMD1gfOE+9NUpSLnN
         /LIH8QEBH1nUM662k/9ByRR2mvJCtmpw1z2CUqDDg6eW0+sz1zdVW5sBA8uFpl8Go2HD
         r/PpNJ5s+7M5e1aA/jas1fgf/4bxJXhHj0izkswOYfNS57s1rtb73DKSVAadIj8Ikm6h
         MgKjV7EMvhUiT6wxdVK3GDOBp0+WXaZBXI0dpT2LPRKfQNj6engaDauPqnV09aS5tGSE
         qhrZhECC7AfnyVaQWmAZRDeZ/OgtbMSe1sabk8V5cXnA8Wz0eeu0XRchSj+JczJ8n5pG
         umeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zj4daZqcOfrk9MLreCDoKv45VzLcW0kMVsw4yuRmjFc=;
        fh=lplwhuwgeLJbT9ZO1s+kGgAPmDc62uGRGI7+MS1YQsU=;
        b=GMDAjZbgY1dwthN/j7ziazrWw6s0Qbxqsp2M1jqT/N1ZItpdp450cpIZyzCpDuITb2
         zeILlw3j3hNUGT7SL/nyCFIg+KMiUI/mF6GQQRsSDlcuoIJMxN9iP3S2VT/m+qJdptZI
         HUhlhoT3s8w08gR1GiiAzBFLStI09aMMn6pY3RnSHa7/yPHuVe/x1AqS2YDMsihX2CPJ
         9863jkT6AHDqNDgqtvHo3NDOI/yi86nKAh18rkWviqRlP2JuLG+Z9uT+CUja4ZpIcTcY
         fuQ/IoKhVZEN+SVeUImkrJoaMBQjxNaq3ZUxxOEnvQCNmF5b15mv1OxeD1HGzZEiRIe0
         vQxQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794466946; x=1795071746; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zj4daZqcOfrk9MLreCDoKv45VzLcW0kMVsw4yuRmjFc=;
        b=yGYOqUAPkn6hPvPb//BosM3mrvmePBcjQzx1MtLdqOHLvUVKcuGzIzfoO0p6+VVktt
         Pwwuu90AZ5O+n2DmjiKsM57zxE+nu3wLjUBSUcmP10a0GpVpqxlO1Iorj28l9N4khnLn
         RRmeNBQHfb34S0QdWJjsK/sSYCLzMLJLPBZeOfdSLeQbp3BvQhcYG6e8bDe7QiSd7Qn4
         6I5S/D+F5MXfm5cAm5JA0jZThtaCqNkL7Hq58P0bPHgkH9eQsqLqIXC8aMKJfOS8RmJc
         Edu2zyfUl99S5lAW0rfaJZoH7NgCHqsTGQusMIFV552qBDkA29jng6dR0pUTWuG1uQXC
         OfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466946; x=1795071746;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zj4daZqcOfrk9MLreCDoKv45VzLcW0kMVsw4yuRmjFc=;
        b=Gdxt20N6OaJBewZwRLrCmyiwPl1tesISty8hHZHjzkTu62eeYkjK4gp03/FwHAM9U1
         rNTDjf2/PfoAu5jMqwZrxUUcx8TcgUWZRqqsN7+J6fohGRrh1dSbwS6nJYSHa0Nnk2Ag
         0nbFCsr7TN4qzrtcP67rhF9gGFG44Pguv+MLl1R9EmQRJkqzM2Pp9p2W/NIqQ6sQ48Of
         O4K8dlHsNnUyRKQVtWAeLmvd3f/+stD8Ij9v/Cpk1HOpE1pln9oNIGUTrUwE/EH59B4B
         4kkQpZ/eJnxaknFcVjJlmzeV0Ch8fw8cB03KmYGm0cF3jC+ZAqVhGMeTeFR0zaI35HYb
         YPWQ==
X-Forwarded-Encrypted: i=1; AL+hErFNwt4+0JDN2KefZNFRCXVLT+lPBWiuCI0wUML5QvQggbBnaTeMBNLXYNX7pZRZxezH9W2FCMl7qxU=@lists.linux.dev
X-Gm-Message-State: APuU4Z8qnKTOrd53fCLqSVrSfadiZqxnn8zY2c0aUdvwffb98chzxgvz
	xeAugamgTCosEbVp4EwHbkf32FFUQ7+vrsqqA29d+QZOMSdj+MVQfcUsiT4bD+iTfRissA8iDY3
	2fcJZCdmLcCLWTO9f9Bb9YVlhs3xI0P5Pe5pZ6cs/Kg==
X-Gm-Gg: AYBFou0XR60zYYIk5yAG8pxnvDVaZyvJM+wynJc8xUUkvCwdawj+xlsi16YqApfS0Xf
	lY3CPXyfupURzJcUJidAIFsdonRbQMhJwqTxtT9nVb3N43mfjAMpp4k1LaNjqVFQwULxLmcYNcm
	Kvpcpv56YBSjgA21YHudPnESTOUdQncVQgKzRlB7O+oiTbH9zKDWYYbyYv3yWqdOoZENPeAZINH
	FycPvz1vCDy49F/0sD4Javhf1sFqcP4mMV3Q+0IynoFHZPRNITt8pmQi1cyh794BUdSPPC9MxLI
	wlzIdLcKZ9bILQwKw0CNtOSONd1eW3ivwH04WAu3uvp3giZMKrwywg6ChQI9+ytlFIaM0231ux6
	VBHtmV05KFx6LqnX4/wBjLVP2kvlnGgX+K0EaVqT261eNWue8o2xVCZ2NrgIFxwgCP+y9Aw==
X-Received: by 2002:a05:6402:28c4:b0:6b4:602d:f1f7 with SMTP id
 4fb4d7f45d1cf-6b7773f4731mr3380483a12.20.1794466945804; Wed, 11 Nov 2026
 23:02:25 -0800 (PST)
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
 <20261106151947.3991524-3-vincent.guittot@linaro.org> <au38gSTzmvPKmqWT@scheduler.schedules>
 <CAKfTPtDXo8_3tfXt=UH+BKyO1rJCWjRAVXjO5nFVHO1NBd8LyA@mail.gmail.com>
 <20261109154536.GK1779021@noisy.programming.kicks-ass.net>
 <CAKfTPtAL9T0bGZdhkodC49DtNUFKJgEn9f5wLNBe_rGxzJEN0w@mail.gmail.com> <20261111090354.GG2668564@noisy.programming.kicks-ass.net>
In-Reply-To: <20261111090354.GG2668564@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Nov 2026 08:02:13 +0100
X-Gm-Features: AclHuK9sTnZDoWNK1z60y7C5PPNcVNuqCH5Q2WF5qMfYgWqlwEG8DadJrWu2JO4
Message-ID: <CAKfTPtBeEQU-7R0wPZeQXF6RdC_kDkbmbCcRBj_WZUCksU5gqg@mail.gmail.com>
Subject: Re: [PATCH 02/20 v3] sched/eevdf: Reset lag at wakeup when prev CPU
 has been idle
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kayra Cizmeci <kayracizmeci@gmail.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 10:03, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 09, 2026 at 05:27:57PM +0100, Vincent Guittot wrote:
> > On Mon, 9 Nov 2026 at 16:45, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Nov 09, 2026 at 04:27:14PM +0100, Vincent Guittot wrote:
> > > > On Fri, 6 Nov 2026 at 17:22, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> > > > >
> > > > > On Fri, Nov 06, 2026 at 04:19:29PM +0100, Vincent Guittot wrote:
> > > > > > @@ -8376,6 +8383,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> > > > > >
> > > > > >       dequeue_hierarchy(p, flags);
> > > > > >
> > > > > > +     if (!(flags & DEQUEUE_SAVE) && !cfs_rq->h_nr_queued)
> > > > > > +             cfs_rq->idle_seq++;
> > > > >
> > > > > This needs WRITE_ONCE, no?  3/20 uses READ_ONCE().
> > > >
> > > > I hesistated to make it WRITE_ONCE but i concluded that it was not
> > > > strictly necessary because the READ_ONCE is only used to compare the
> > > > value but not use it for any computation or sync so if the compiler
> > > > wants to do any kind of optimization what we really care is : is it
> > > > equal or not ? so any intermediate value that we would read would be
> > > > ok
> > >
> > > Right, so without WRITE_ONCE() the compiler is allowed to write the word
> > > in random order byte writes. When comparing only cares about equality,
> > > any intermediate messed up state is not equal. And since we were
> > > incrementing, we're not supposed to be equal to any previous snapshot.
> > >
> > > Therefore all is well.
> > >
> > > That said; we should either document the above reasoning, or just do
> > > WRITE_ONCE() and get all the sanitizers off our back, because I'm
> > > certain that KCSAN is going to complain about this.
> >
> > I agree that it needs at least a comment. I can use WRITE_ONCE but I
> > remember seeing somethign about its cost. But does it worth having
> > sanitizers complaining ... I will run some tests and use WRITE_ONCE if
> > I don't see difference
>
> Mostly it doesn't actually cost anything. The thing with WRITE_ONCE() is
> that the compiler cannot elide or merge the stores, it is forced to
> actually emit the store. But here we need a store anyway.
>
> So the worst WRITE_ONCE() does it get in the way of compiler
> optimizations, but I don't think any of them are relevant here.

Ack
