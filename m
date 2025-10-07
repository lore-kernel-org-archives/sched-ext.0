Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DA62571BD
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832800; cv=none; b=qn4gdPlxKPjsEc7/YXujQ+ttDLiC0XKtju5xHkB8OIX1xWOsr0pRh9mdoAsYJYO8FEiBquPG6ctpd/i5hNf5tDVGbn+7sgWEmhGcrqtA0gFiGfnc5or4MZOQcTWqm4zThlh/p22+tdN/9SpPOX+qgzMrU4aXnK5cFB9lhnb174c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832800; c=relaxed/simple;
	bh=gbzDoxYv0MvSzWpS8VUWjtEE8E1Rv9qpr+KsA+B9NqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qBtHiCShsxg6tRIjxf3y8PoGAO2i3I/5eAkeHTQLWVhtpURaZ6GA5bqjrg4VngR5LSK3/8tgFgMy1C+GcGcVjCv6e1PcGgPx46ME2vWXIp1bwIjKcQcgQDX29krDzauHyDnzlccnC1kGzCLGCBR9evB0mwVKA+H/BUpeO8kDpx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWscjQ7K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWscjQ7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759832797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1oRiQ21RD56WeY2QvGAYtt4aZJ/FMR4+RaPEw0tI+EE=;
	b=SWscjQ7KQArvpzNf2mIfR+EQdUp5VHjsD7hk7x4nZ8XE4kLof/ppUNT5qMiMP+uC+JZ8mO
	XYP7823IJj7BMsXq0YhuKaJgnUQ+Kv5uEHJ0jTo/22rsaGOIDVEKL8uU0jiSpWWDN0uwjp
	UjwrM0y8pcGylDFvn86gPHizXASZljA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-48Ua-lNhNIWLW52V2rqqxQ-1; Tue, 07 Oct 2025 06:26:36 -0400
X-MC-Unique: 48Ua-lNhNIWLW52V2rqqxQ-1
X-Mimecast-MFC-AGG-ID: 48Ua-lNhNIWLW52V2rqqxQ_1759832795
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e3e177893so32923005e9.2
        for <sched-ext@lists.linux.dev>; Tue, 07 Oct 2025 03:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759832795; x=1760437595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oRiQ21RD56WeY2QvGAYtt4aZJ/FMR4+RaPEw0tI+EE=;
        b=CTBHV/ONbWRSP89NCjvwvQUiRxUZGDYOdmmS9+U/Mpiye2/1HpcAERl/hecew3ba3r
         DGKvnDFbgpiyzWzZtjwrZZmIsNGZwShFgYEaU+QU7w+JavPtG4BuH0yrCtFXT9+rtwzB
         mVEyLrEQImXe7I8SlJO7kDC8xI3J8yqHYDeo6x824wEFLgQ0AHpA4D3dYGCH4oY/B0SW
         iVzIQbPxbguXG6KY/TW2cEsrJKd78e++meMGfms2woTmvonY147llswhMniZm4AW7rdb
         LteqiGAM2QSb2I2bs6GPlvVUWRKggGzjaaIP0UAvi0qXmXEdyGCRhLw/A/ZKBLVhmsPu
         PmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJN109F5IUCgvroHDhzMLBctutvrTHNFfkquF6LigUX3NggxwNQ1J5BaLz0vNxioqndq8RViV0nEI=@lists.linux.dev
X-Gm-Message-State: AOJu0YwLj11Q/KW7wcLDONchfXRivFuyaH5ABgugGPBnaVLkVrsjL2Pf
	98M1BMQbTmsZ+GWWLOLPFrXAKpjk61Mq0nHo09kw+uxmKiPk1W+UgXAsnt8N9HMWnHL2aeaWBUx
	QC4Iuno8bzeQmBHCpIdMP+i42of88S+Ah8q1wtFRjCuIXbP/5El+x8wM1z62Lpw==
X-Gm-Gg: ASbGncsAZmAh1xonxPeSLFa4MvOk6hD5euTk5wOgU3+PHl1sx0FDrOcJDRkVatQW/NK
	RmS57UfMpqpoaUvaKfKxnoXfBEH8RO/yFOWX5W2I+bd1dhG3enwkPfQ86jlfPKRzy0dlUZaSgRN
	hBoBeWAVgLEyvjd8CH+FeORhd2iFXzhdBCUoBomtWT4OQj7/UnkNwJUSjdqtW3lfIgDsFudeI/n
	RoW5MDIzxFZCvhidUK3OndQsIjSS+ElasuP8Bj8lucfLNpw3WgHGpML0hWQXMCb//iqSf+eWGoS
	Kd2b0OenFQGDw0Ycx1n/otq5H5eC2oeM5AUsWP2rIQYCOzMP3QZJWmf1Z8nmoK694PJwzl8OIsT
	tmg==
X-Received: by 2002:a05:600c:548a:b0:46d:5189:3583 with SMTP id 5b1f17b1804b1-46e710b6231mr113836195e9.0.1759832794913;
        Tue, 07 Oct 2025 03:26:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpzj+r3TPYmWvbkiCjUYFasMEAw744DuMCfiYyedpCn/rb6hxGdhvFcG2MoVK74jPTRfi2Bg==
X-Received: by 2002:a05:600c:548a:b0:46d:5189:3583 with SMTP id 5b1f17b1804b1-46e710b6231mr113836035e9.0.1759832794472;
        Tue, 07 Oct 2025 03:26:34 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.135.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e674b6591sm265625615e9.4.2025.10.07.03.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 03:26:34 -0700 (PDT)
Date: Tue, 7 Oct 2025 12:26:31 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 1/3] sched: Detect per-class runqueue changes
Message-ID: <aOTq19a_OIONFmTs@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104652.630431579@infradead.org>
 <20251006105453.522934521@infradead.org>
 <aOTmg90J1Tdggm5z@jlelli-thinkpadt14gen4.remote.csb>
 <20251007101610.GD3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251007101610.GD3245006@noisy.programming.kicks-ass.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rqU6_w0_Wlgi-6WWSJRu__QNL00b1RCxgW_wYuRMTfM_1759832795
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 07/10/25 12:16, Peter Zijlstra wrote:
> On Tue, Oct 07, 2025 at 12:08:03PM +0200, Juri Lelli wrote:
> > Hi Peter,
> > 
> > On 06/10/25 12:46, Peter Zijlstra wrote:
> > > Have enqueue/dequeue set a per-class bit in rq->queue_mask. This then
> > > enables easy tracking of which runqueues are modified over a
> > > lock-break.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > 
> > Nice.
> > 
> > > @@ -12887,8 +12888,8 @@ static int sched_balance_newidle(struct
> > >  	if (this_rq->cfs.h_nr_queued && !pulled_task)
> > >  		pulled_task = 1;
> > >  
> > > -	/* Is there a task of a high priority class? */
> > > -	if (this_rq->nr_running != this_rq->cfs.h_nr_queued)
> > > +	/* If a higher prio class was modified, restart the pick */
> > > +	if (this_rq->queue_mask & ~((fair_sched_class.queue_mask << 1)-1))
> > >  		pulled_task = -1;
> > 
> > Does this however want a self-documenting inline helper or macro to make
> > it even more clear? If this is always going to be the only caller maybe
> > not so much.
> 
> There's another one in patch 3. I suppose we can do that. Maybe
> something like:
> 
> static inline bool rq_modified_above(struct rq *rq, struct sched_class *class)
> {
> 	unsigned int mask = class->queue_mask;
> 	return rq->queue_mask & ~((mask << 1) - 1);
> }
> 
> This then writes the above like:
> 
> 	if (rq_modified_above(this_rq, &fair_sched_class))
> 

Yeah. Maybe also add a "check rq::queue_mask comment for additional
details" or something like this.

Thanks!
Juri

