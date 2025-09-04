Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E68299AB4
	for <sched-ext@lists.linux.dev>; Thu,  4 Sep 2025 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970255; cv=none; b=ltIGTvzVlzZj6y7ZVLk1TagXwSzRmK/admU5lHflB1iVjccg9sFcvxRVUqpcAibbBCQnH+ZzSzJU2x/n6f9LvfLpwlvW9cxPphHBZ1jlW1Sw/fvyWKtKFnifFdlVw8s0fl4DwmDMdga4eMatahIWTB1xBp7Nb5x1w1hxZ9DUZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970255; c=relaxed/simple;
	bh=oIckBVKRKgmc03f98rn0emLj9a37R8lZrEevCLloEgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=c4gQFZLO4yfb8D2O0MmNukY+tTtZNAVRA4hI7EfoSjh73Mp4+2NKjcjXPi6ViFJnoKN8zTqiCjjobQ1S8900nKczAlBPK0ZTs1QUL8SsCjyUlOurx+oJYUmtVev/VQHWh74By5kevsO1mm4bwChbcX5uundcXlq4VHCRR+8UfKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9Mmvq9p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9Mmvq9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756970252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8hHca6nrr4DSD1i4RnW4HNPHcBb/x8yT/5uh6e1tr0=;
	b=H9Mmvq9pnJ5Yfmr80sFuvZUSEdGTvHlwJz15alG09ev2iPm7csu9gJCEcAVQ9isArjo+9y
	txrFk3tpwAlRLClvtzDG9vIPDZ9DGJCc0cl0vCcM6Rg/pSzRAabbx9YmveSAlrErkEXqQb
	osmC1fIuQVJsdA2O4r5wyHWVmlGqLxk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-x6rxxHw4Msm6oFnKQQ_Tvw-1; Thu, 04 Sep 2025 03:17:29 -0400
X-MC-Unique: x6rxxHw4Msm6oFnKQQ_Tvw-1
X-Mimecast-MFC-AGG-ID: x6rxxHw4Msm6oFnKQQ_Tvw_1756970248
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b99c18484so2643925e9.1
        for <sched-ext@lists.linux.dev>; Thu, 04 Sep 2025 00:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756970248; x=1757575048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8hHca6nrr4DSD1i4RnW4HNPHcBb/x8yT/5uh6e1tr0=;
        b=LrXRgPqQX6y8/AgKOowLkFPswd693wzo2vKN0EAXXxxwwao5xt6hil+IHiJH09Ejy3
         EZ6/NZf0IoqFXOQ5ys9NZfqxzcDVmIQrWduCiPZLGUeh/DRSkOpoDW7y+RdtE9Ej61J8
         Ec5MxxzHt6OalH+Y3rYE4VYn4x6HMUyLA+woQvC3GTcnEiw/s04Wu5lj+m3qqG8YPkRm
         CuQpm/+cjq7lgJ7XrX+fPmDOEdWqSYril2O//WO7qWTH5GA/dZ9SltY9mI8sra8oX0QW
         /c+bldwLu78qEqUEHV4xmvcsEjyQAtui5S6AEccNfZ21fCaCTKPQuaRiaRRdjnr5s8au
         muBA==
X-Forwarded-Encrypted: i=1; AJvYcCU1hMIhe5K2inFs2jf8/CBlWAvjUSzYFtJIc5HNNWsOUm8+TUuzPdQWIyzK8xWhLxggOxRVIsKnp7s=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2qoNsaNcTyUV08ndFBun2ya6gDjcfzqyoA1ygO5CQrCfdCRSw
	eoG2KjgbsR4CaUzUqjZ2C4VLLwefMHSKfCGOFvACTK7mv0H+bV1jaazaYQF39uBaP435DoFEk6P
	P1hynMHUPqA5PsG6EvI91JLkX3h77Ocx9ssrn2IsvkPfs2NarTVSG8VUzAXLiXw==
X-Gm-Gg: ASbGncusVDiUH3RsrhZEpBnjN0bBjmTeKAcOEizyuuwUp9Bn8SfWNOiyZJqeNyJneqW
	DOr1oMkLuzjxyimwWu1ERgUG4vpzvUKIEZc0ku40hYSiEb0AXCxQtlri1IOl6t7n6RNeETWAit2
	rMr1j0RZv0c127y4Bsv+rNUKrxt1dIHzAl1WAnbyyQHLLcuQ8JIfNCckJVzYMVYF1REipf3GSoI
	FRImKBFmksBsqhlz/t1UDuiKnO5BX3KFwTQMNW9pr8ZXTY8jkr8xUk/nGM6uRrbw4to9FYmxjGS
	ksC3rlyaTn++pc4b0IhjhsW4P030sekyexdSrrf9roliCBX0oq2TJHlVZ3booErcyaZzbUw=
X-Received: by 2002:a05:600c:4694:b0:459:443e:b177 with SMTP id 5b1f17b1804b1-45b8557a72cmr141027085e9.25.1756970248432;
        Thu, 04 Sep 2025 00:17:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxlNaYXu+Ti5TyjToAfM/VPhoLNPClSOiPQxxxvQ/mXgMA1LuzTwi9Jqs2HyOXrR/sPrrxEg==
X-Received: by 2002:a05:600c:4694:b0:459:443e:b177 with SMTP id 5b1f17b1804b1-45b8557a72cmr141026695e9.25.1756970247956;
        Thu, 04 Sep 2025 00:17:27 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd2304e16sm7685035e9.7.2025.09.04.00.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 00:17:27 -0700 (PDT)
Date: Thu, 4 Sep 2025 09:17:24 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>
Subject: Re: [PATCH 05/16] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <aLk9BNnFYZ3bhVAE@jlelli-thinkpadt14gen4.remote.csb>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-6-arighi@nvidia.com>
 <aLhWh9_bJ5oKlQ3O@jlelli-thinkpadt14gen4.remote.csb>
 <20250903200520.GN4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250903200520.GN4067720@noisy.programming.kicks-ass.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8rkhCHb8fh3Etp3djZ3UaIA1H7EbpD55lE9aGxKyUE8_1756970248
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 03/09/25 22:05, Peter Zijlstra wrote:
> On Wed, Sep 03, 2025 at 04:53:59PM +0200, Juri Lelli wrote:
> > Hi,
> > 
> > On 03/09/25 11:33, Andrea Righi wrote:
> > > From: Joel Fernandes <joelagnelf@nvidia.com>
> > > 
> > > Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > root domain containing cpu_active() CPUs. So in this case, don't mess
> > > with accounting and we can retry later. Without this patch, we see
> > > crashes with sched_ext selftest's hotplug test due to divide by zero.
> > > 
> > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > ---
> > >  kernel/sched/deadline.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > index 3c478a1b2890d..753e50b1e86fc 100644
> > > --- a/kernel/sched/deadline.c
> > > +++ b/kernel/sched/deadline.c
> > > @@ -1689,7 +1689,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
> > >  	cpus = dl_bw_cpus(cpu);
> > >  	cap = dl_bw_capacity(cpu);
> > >  
> > > -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> > > +	/*
> > > +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> > > +	 * with accounting and we can retry later.
> > > +	 */
> > > +	if (!cpus || __dl_overflow(dl_b, cap, old_bw, new_bw))
> > >  		return -EBUSY;
> > >  
> > >  	if (init) {
> > 
> > Yuri is proposing to ignore dl-servers bandwidth contribution from
> > admission control (as they essentially operate on the remaining
> > bandwidth portion not available to RT/DEADLINE tasks):
> > 
> > https://lore.kernel.org/lkml/20250903114448.664452-1-yurand2000@gmail.com/
> > 
> > His patch should make this patch not required. Would you be able and
> > willing to test this assumption?
> > 
> > I don't believe Peter already expressed his opinion on what Yuri is
> > proposing, so this might be moot. 
> 
> Urgh, yeah, I don't like that at all. That reasoning makes no sense what
> so ever. That 5% is not lost time, that 5% is being very optimistic and
> 'models' otherwise unaccountable time like IRQ and random overheads.

But, wait. For dealing with IRQs and random overheads we usually say
'inflate your reservations', e.g. add a 3-5% to your runtime so that it
is sound against reality. And that gets included already in the 95%
default max cap and schedulability tests.

I believe what Yuri is saying is that dl-servers are different, because
they are only a safety net and don't provide any guarantees. With RT
throttling we used to run non-RT on the remaining 5% (from 95%) and with
Yuri's change we are going to go back at doing the same, but with
dl-server(s). If we don't do that we are somewhat going to pay overheads
twice, first we must inflate real reservations or your tasks gets
prematurely throttled, second we remove 5% of overall bandwidth if
dl-servers are accounted for with the rest of real reservation.

What do you think? :)

