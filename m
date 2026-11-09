Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233755;
	b=LRU3VZKRkqb99qa4EoFzzaTUC+/XaGJ8kszTGQ3Mou0igMCidKRhGMgQ4m9GlPl1ioj6
	 a6FbZpyUo6YdK5iDNbpi6O0fgLIrtml49OEu4GxZ1tKrYiRB2cHizMGS60lPTVF9GPwdx
	 xgaz1Lus9netVPRPvB8/axE6pFAJcbQ13LJlQn5kpfRtS7cI4xOS3pIOzGlTRQiqNp1G5
	 OCP+jl1Rv6djHOUCjkxzdPNBMTLby9dlFJjlbzz7Cj5cIeSg/D1kqgVZ4modrnRS66ota
	 Cg9uFKBW/6Z+11ZS4ZBScjG0+UW09Qzbc9rLNq+52T/oFNluhQfhYppIq4dxbnac4yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BRzYSlxPXB9SayIbet1ssxpRWLhzXzCtSQdIz3Apaiw=;
	b=ThNp4EH2YPEmm1E2mzVQzEtrnoLTASNLpc+10eZf0f9ss5kHQArHGVeXRxHlKCbdc+8m
	 UpcOXslK4/pGDWM+Ay8TL6qr1zkl56BTCoQwtCFbV7dPRum1moGYiOvXtPKoQnqpyVA54
	 H/yaFuK7BVljsxUfNu/ju7/BCvYvmRDp13kLu1HGlHd41+vz31F5Gz5sOcJTJVCc4/QDD
	 Uw8286ezXVxwTHgtPqExuzAksr/e2K9Wtzgacca6AjVwYNhU48mJmpsoGGYCQ66wDZNvF
	 ieZP5JpltQlDM1yrgn67aJ0CHnhw3ieiZikaIkF4uW8WxclkEWYlg+6S3h/wJPOxj5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O2CyRDxl;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A8606A321
	for <sched-ext@lists.linux.dev>; Mon,  9 Nov 2026 14:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF8A8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O2CyRDxl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4aa3a2a5a15so853665e9.2
        for <sched-ext@lists.linux.dev>; Mon, 09 Nov 2026 06:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794233753; x=1794838553; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BRzYSlxPXB9SayIbet1ssxpRWLhzXzCtSQdIz3Apaiw=;
        b=O2CyRDxlt9xD4lKqiWqPd8DJUnaOcswRTSHB4uYaqnsMnjo43FYZj563yiHQPDDKK8
         JuuXBWUvtrIiBrDlfBrYVy6N5f/GwjCLHFw5mQVgMbmqpc+5+V0sO8AhOnNryWbdtZM9
         sZu2OKCDZDW3rrT9G4KAjKIPSJ26FSdHPvmSAe3nDKjzH9ZqVx+YQUvEwKzyESpJeso9
         Oi+KHF5nQSXHo6KE9/3sr0ZNi7DUDoqDYU0LoQxwvSZQuqiepHjYUUEh3C+p/ec2SHpm
         b6UPS99X8ooROT6nGJ2rbY3IvEDD7Z1S79kWs4JJTnAZpP5theEtpRRR8TSu4mltA9y2
         XD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794233753; x=1794838553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BRzYSlxPXB9SayIbet1ssxpRWLhzXzCtSQdIz3Apaiw=;
        b=IOzOvWsIJP5kIFBHSkLsBkesLNZekiPGQ8qvTOZZsgljezGwxRy/j5fvnG7pyxvVo9
         OGvY0hiCGy8P4ODO5CtZWLnQ4JCZafqXkln12ShO74hHDPXd1JLkSKnzn1YvioG0kvYW
         lmsLWx4ONiuz7yxbvl/cm6UVy6eZ+qVUl2j1j7+Jervu6bSCpZa1PG/Ej26wAcayuCMb
         atWsFCpGGTC+baZqFLy4/UYE5Ii4U8ICLNR/AFeE/+vgalnWnzNkg0WZq8SPetTqwNhb
         il1N85r85KurElz2XLh0Q4qW0hauPXDXr1IFXBsOFPeSVZjoo15cxNu1fXM4zZzMj2P0
         UG1Q==
X-Forwarded-Encrypted: i=1; AL+hErF5ZfD8jzBvqPKL/KgLfA37wHk6d388xQXvdRtC6eGOb1eCTkEPyJVuOKIQquACixwHzwTh/ivj9Ns=@lists.linux.dev
X-Gm-Message-State: APuU4Z+1dWddHjdDjcJwtrR66TBDm8ZCmCHtQu6TH6Rg8pgrZtwTd9MK
	FA6vuI6neQisLZHHdnHVuRpscoDixU7V+EODwUQ+er5iIav/YSGIrAPq
X-Gm-Gg: AYBFou1EU+Ha+UH+Ae/XoylroS1GiPPy3Uzvk2LUmMYsE/XNEG+uWhp4Xp/pLn61V3x
	lEeQM8cKZMpv1ga0EFGIVTFa/EhfRhj5VK9Tdmy6sxG2059xVUbQ6qc1l33tgAN88toCdeyL0+j
	woru9Cn+icKHITxP2336so6AtV2bIaUllYQiuxZC0ysABoNp+prY186Qyg5YtFQdMEboNwFk0D5
	48RHGXRFsXmedUHeOGqON2jmbmaT/YeSeuKOeq9HX03b7cJ0YE/Mcpdp31KzG7Lb+Q2Z38t5b6P
	pvU1MFlrospvUt06SwtHFrEWremc9LGl9Hr8VqePvMpMOSPXPMg9YU+oIqqIJrCq3uSoM7X6JL0
	nTksiCnrXK2fBMaC2Ofrz5w6fHAZqv4NsHG+Nk5P7CRDaNYjZ807x7X0JM/uHyqauXdz/vh0a0Q
	6IJ/KzhMYfCZ+aPy51qBnND8YPCtgVJ1h73oU9DypKAka3Wjxq8vh/gH7LnhaBNJ0A8rJCKXJLf
	RvzdwYqDj08Njg4BOv+LHHCAxKJ/SXRM6L3+nLQDPDFLjPFvYaks8bSj+gGx1raFSaVeOOisH0R
	A1CVYg5+vdsTIodfHXYrBC64LiPpm/Qk6c7VhgzDGRq8PF5AaYTb844gJ9qYK3RsZFwLNWZJ7yl
	e
X-Received: by 2002:a5d:6f04:0:b0:48a:f5c5:d067 with SMTP id ffacd0b85a97d-495810d5813mr7394605f8f.2.1794233753069;
        Mon, 09 Nov 2026 06:15:53 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-495966f36besm9520949f8f.14.2026.11.09.06.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:15:52 -0800 (PST)
Date: Mon, 9 Nov 2026 17:15:48 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, 
	tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 06/20 v3] sched/eevdf: Add min slice check when selecting
 CPU
Message-ID: <avHR3lIV2TB9SWSZ@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-7-vincent.guittot@linaro.org>
 <au7SabL5pfbsApyB@scheduler.schedules>
 <20261109135553.GC2668564@noisy.programming.kicks-ass.net>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109135553.GC2668564@noisy.programming.kicks-ass.net>

On Mon, Nov 09, 2026 at 02:55:53PM +0100, Peter Zijlstra wrote:
> On Sat, Nov 07, 2026 at 11:57:12AM +0300, Kayra Cizmeci wrote:
> 
> > (My editor got crazy, so I had to copy this diff :<)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 262626455497..8b0dd858f332 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8876,10 +8876,8 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
> >  
> >  static inline bool choose_sched_slice_rq(struct rq *rq, struct task_struct *p)
> >  {
> > -	if (p->se.slice < get_rq_min_slice(rq))
> > -		return true;
> > -
> > -	return false;
> > +	return p->se.slice < get_rq_min_slice(rq) &&
> > +		READ_ONCE(rq->curr)->sched_class == &fair_sched_class;
> >  }
> 
> that wants to be rcu_dereference_all() or somesuch, rather than
> READ_ONCE().

Ah, my bad :-).

> 
> The think I noticed is that it will only select one slice_cpu; it will
> not consider another once its has found one.
> 
> This means it picks the oldest option, rather than the most recent one.

So you mean by the time CPU loop ends, the CPU that we selected
might not be a good option anymore.

> And given this is all racy as heck, the most recent one might in fact be
> the better choice. It will have had less time to go stale.
> 

Makes sense to me. So then we gonna overwrite slice_cpu everytime we
find a new one?


Cheers,

Kayra
