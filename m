Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9861D5147
	for <sched-ext@lists.linux.dev>; Thu,  9 Oct 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994280; cv=none; b=trRr5QP/fWueRdm1JSB48QANEgsHd9VTqSQcd/b0bBEfErxwMm57JhDhJFHpnLJ3ccYCsAz/DYP8malfOKD9T5z0GffC7ghKO3r94QI5oR12Crek0+dazX6WN/pCDvwUJdoFDzoCvSBTDH2WKc/4naYqFTswxLtXBBDnUp4CV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994280; c=relaxed/simple;
	bh=MzaggMkgox+f14ZSjk/4xD4ogb/SfsQXZLmM6Zz0BCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfHAHqd/ytOcvK8GyW8Y/FXNAI9ztuuCwLrCHKv4uwoMxFEYwAXI4nNO0bfcgnHbme6R2pCDJnnRXXk2N9w5vvth0emm9U4eGFm8cwC2nkpy9+mljaVdnNDBcumuHzn6RR/2l2pGcPLL6UTaBZhb8cAGmhub5OAKXZw+0oJ1Z30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DNlbfZ3u; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DNlbfZ3u"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-26a0a694ea8so4747735ad.3
        for <sched-ext@lists.linux.dev>; Thu, 09 Oct 2025 00:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759994278; x=1760599078; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KnDpl448KmBm7jRg+IaWZK8mGbwV+iXH8p9YGyGuQWE=;
        b=DNlbfZ3u9QnCkqNU/+OIIBcc9aGeAduWKEY39awtBaWRcJDyCDaw3vJ4zN2dbjEtot
         19ockFj7BhuLR14zLV58DDMDqStz959a+eyr/3O+gQNog1M3atgImMb/SNZOzxlKzlG+
         vSj1cOsB6PBjppKg7HZ4kOKrkR6f7gPMwreLwSG9qk4bIG1dZqnyUTrkGyAsm2ZfvLi2
         0m9/w/MQ/sstnPByefB6TygtSu9MG/Iga0Is36Ls95FKEuW/XHFo/yMZUW82MdJ6uEsz
         n6Gj28TcyJQ0sP4cYG4N17A65gqmXoO8DsVOQex8V2TBfp1hs9WmOW/lSwENzwwDVWok
         1kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759994278; x=1760599078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnDpl448KmBm7jRg+IaWZK8mGbwV+iXH8p9YGyGuQWE=;
        b=ucCxwyy9RVLt1hwleeylCksRfHYFJ7DE4rqG5g3F5AxhAL07MIJu9/58gxV5LEfMGn
         Xqgxzq+Bja5PPcOk9Xv/69VrvtFYIT3xQ7G3DeuMc78Zhp5YeUlli06eU6OEuC/ODFuN
         h5e16B3ODHaQ2muLckqP7zprVJvM3QqRKAHePTo848HjaopFJDlNbiwCHN4FCcxnf2V8
         PAA4Yoa2Kd5pIynlsfjANwJes9Q6x6dnCIaLJwQOit274+CN1JYggJa7YN33r+VAZZB9
         kQAXzeqa2gtlaPQXKA9icD2EpI3p7OJxWTptPiWsLb4QAJVcvqcsFsDndoGLkspovkiz
         A59g==
X-Forwarded-Encrypted: i=1; AJvYcCWdIIlSX7qDMmyZlcL+QLs0V4sU8QcGml7n0MuI8CfZuQKIg18Comdo74J58P/X0sLTJpQLhq/PVfo=@lists.linux.dev
X-Gm-Message-State: AOJu0YxFOFnjCZqDWi5ZO2oBnUFgpTa60uEsD78LpQD2fuhc1mIsJrSf
	2dhrHAZBc5Vdz8MGzxi9/KnkNsXbuY+/Tgli7EDGcidmIFbyvSVP1A+JmzoKU9ZYyxwuvRLbomv
	kRJB6Jy+LM7JhHpEAaO2i2pXwgDw4rbND0XQxgEp04A==
X-Gm-Gg: ASbGncunzz70eb78CrpPc9g5QVPldkQPUuOw445JKzKvpNsaMWWifbAaLcK3p2IQdKh
	bYEca3lOpNui82IfaBX474TT0UWvW94Als0PkmT6sW1iSNdxktduzPxTNnAVeE/DnsXRMjq1Ycq
	Q4jBCWVNTL+k7thTVtleqEPONBdZ02jEeqMyhEdRGam9Z+t2t0DIkIPwmAVavmYUB0tDnoHrJTL
	XCqgCL5P5Veqdb6TbuXEa0mWRgJDbLGhGEKQK2sZkOh4SzdtK1bgaZueUZDdO8N
X-Google-Smtp-Source: AGHT+IFn9r8crdkPQsk70/0LPQo6O8jmgoxx0cOasKw14vHSrY8R2tzadEUxcInhoqfSRDPYYjYKGZ+AUFL0QoR/aCs=
X-Received: by 2002:a17:902:ce81:b0:250:b622:c750 with SMTP id
 d9443c01a7336-290272d7330mr91020805ad.27.1759994278066; Thu, 09 Oct 2025
 00:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251006104652.630431579@infradead.org> <20251006105453.648473106@infradead.org>
 <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com>
 <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
 <CAKfTPtDG9Fz8o1TVPe3w2eNA+Smhmq2utSA_c6X4GJJgt_dAJA@mail.gmail.com> <aObK2MfxPyFcovwr@slm.duckdns.org>
In-Reply-To: <aObK2MfxPyFcovwr@slm.duckdns.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 9 Oct 2025 09:17:44 +0200
X-Gm-Features: AS18NWCFFG2jZlx24PTDm78yxWfINpT0vMvRGNXbx1D6IurrdBPCv36qDUVfa-g
Message-ID: <CAKfTPtApJuw=Ad8aX=p3VLvMojyoxVBVRbMG80ADXR-NVL0PTw@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, longman@redhat.com, 
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev, 
	liuwenfang@honor.com, tglx@linutronix.de, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 22:34, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Oct 08, 2025 at 05:22:42PM +0200, Vincent Guittot wrote:
> > On Wed, 8 Oct 2025 at 15:58, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Wed, Oct 08, 2025 at 03:16:58PM +0200, Vincent Guittot wrote:
> > >
> > > > > +static struct task_struct *
> > > > > +fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
> > > > >  {
> > > > > -       return pick_next_task_fair(rq, prev, NULL);
> > > >
> > > > The special case of a NULL rf pointer is used to skip
> > > > sched_balance_newidle() at the end of pick_next_task_fair() in the
> > > > pick_next_task() slo path when prev_balance has already it. This means
> > > > that it will be called twice if prev is not a fair task.
> > >
> > > Oh right. I suppose we can simply remove balance_fair.
> >
> > That was the option that I also had in mind but this will change from
> > current behavior and I'm afraid that sched_ext people will complain.
> > Currently, if prev is sched_ext, we don't call higher class.balance()
> > which includes the fair class balance_fair->sched_balance_newidle.  If
> > we now always call sched_balance_newidle() at the end
> > pick_next_task_fair(), we will try to pull a fair task at each
> > schedule between sched_ext tasks
>
> If we pass in @prev into pick(), can't pick() decide whether to newidle
> balance or not based on that?

The problem is that with dl_server, you can has a prev of a lower prio
but still want to run a newidle balance :
-cfs task preempted by dl server
-cfs task migrates to another cpu
-we want to run newidle balance when cpu become idle

>
> Thanks.
>
> --
> tejun
