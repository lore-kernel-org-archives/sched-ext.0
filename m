Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40CB2253FB
	for <sched-ext@lists.linux.dev>; Wed,  3 Sep 2025 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912531; cv=none; b=UP36Bp6tDxlTcgZuxw5GoPDVfIe08MdjuAyuyKN4+ELVC1x+nt5ssIi3UgFk4hdORST4aAmfBiOe27kCdXNW0nk98EHkAZQiqMdJQlpdo9AkKo5UWu42kHeugAxgY5eocI6yvDKKcjkbszlyoWS8m+kTrt0S7zQFdCX8pq5SJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912531; c=relaxed/simple;
	bh=Qs0vM4WnRg1sWrSQDhD/dHdJLErkQzLDPp/S8NA9xJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dBFbW0z4wlceo3hPDkfvQKKe4ATBf9qo9z6ESZ4JNHe7lHwkkLaF5coJHNuFHYhzmOXdmHHUQZjGKwI4h+lJHf4SW1tjYgnNrk8o6T029TdZIxdfnJ+csS8xkbd53nAXwO/d0F8wQU03bCJ0gAriqLzhlqMXSpHk1voanaUIiMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZvLlBO26; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvLlBO26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756912529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qbSBenbpjTa++jsPneELJOEvjFDl0VlvYT1LTF09Ibk=;
	b=ZvLlBO26Erv76bUA97WyrguYQTUQ5hNr8XxH8tWqNP+wG1pbs679yejbWltl6BT2MOYw88
	X3H9tgJSp1pTkdiI0PdI8LPdu8DZTsWnIrSdqWZCWAq8tn1JSr8I+eHfylarn7mbpcSo+H
	Qbr7UufSdPup0BMmjBO7Y2jv4+rgIM4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-yjud8NFFM-2X0hy4K_XnSw-1; Wed, 03 Sep 2025 11:15:25 -0400
X-MC-Unique: yjud8NFFM-2X0hy4K_XnSw-1
X-Mimecast-MFC-AGG-ID: yjud8NFFM-2X0hy4K_XnSw_1756912521
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b8dde54c1so304165e9.1
        for <sched-ext@lists.linux.dev>; Wed, 03 Sep 2025 08:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912521; x=1757517321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbSBenbpjTa++jsPneELJOEvjFDl0VlvYT1LTF09Ibk=;
        b=Zs27u0b3OIBIMKuxsBMl4v5NShkr64pKFxO4ANt31O8dunvfTu7hVpvYTjReYjaVnn
         zREZ+6ZTm8ntc83l0NPUw0Bi2cfRip28wTLN7jAHRdjkxkHzNeZ7y+Wb9vwvadhoDb8h
         I/ChtwwSWcHzG3jhQzWuCQJQW/fkDIJY5sMJ3L4xbYj6TNMnxBbSSagRW8pePt3Ncf5K
         UVNd1dOasGaHps/qM/4JRiwNwFyNeBNx+hS5/4hyvYTAS2a28j9g4wabxR3+DRZEJmue
         jhKxjfYkOHDw1Tg2UKihNbI3F+uZ0a2aBhZmbtDAn+E2+sg4YUlfeI/71y1MciedRx5B
         kGAA==
X-Forwarded-Encrypted: i=1; AJvYcCXRiz3Z+yUQ/fZIMVnrD+nIl697kIzDzf3bvKE6ZE3LLUMan9Po6JrXM3vpWX93doxIUa+aljCr1LA=@lists.linux.dev
X-Gm-Message-State: AOJu0YwHw6krIQexa6QsePF/qfktoh4B0XC6F1KwUy9XCWSUvGe89EKZ
	H0C6fMS+x3CLrRqacHoh9GY/ThFghmQhP8VPOc6trjJal/AN2qiw3MCK0NtXcycBQlfb0gO/DS3
	qwPV4lADIvGQkRJLxgomMIk19ksCAmQ0vmaHN+u1x6NXrlPoGhjyugzQBD1uMOw==
X-Gm-Gg: ASbGncsoWPRnNO51mKYPnR6cGlsOqfEmRtzzS60TnlukJ2mUAM+o0NZsx+JWkfeVLDl
	/LNcuwdmQzzQvlkLSY/ICjYNe4f8ewZWFwEJeUSfGAnbj3x+3PEmpv2LzwIIxqqx7STw6BAsf3s
	ymG1isozMujFdzSr618bAfR3WjA2y7Y7bzIAH5KPlihweScY/qEKvmiJ+s6gC87zjndkSPrNC9R
	iXzBd/RdWpxMWKbnPjCXzL7ZkmfO+lLA09JeXokX0zlAaJKvzbLvzGIc5RszyeUymLiYwpW9+E+
	Ysgkl+BBTrlwqCQLP08di8clx5Dh3XYUwtucOgaB4HwbQ5rpbrR/6LkUByAgLpE3f9OZxMs=
X-Received: by 2002:a05:600c:1d04:b0:45b:82e8:c94b with SMTP id 5b1f17b1804b1-45c9ba76d74mr32283235e9.18.1756912521365;
        Wed, 03 Sep 2025 08:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhDv2jD1vUWaLSAILrInFOmf3ssm9G/W1i5T3Ku2qX4/HBVn1l3SPVtqllrd7Mm4c5Hxfjow==
X-Received: by 2002:a05:600c:1d04:b0:45b:82e8:c94b with SMTP id 5b1f17b1804b1-45c9ba76d74mr32282875e9.18.1756912520893;
        Wed, 03 Sep 2025 08:15:20 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8879cesm243996435e9.12.2025.09.03.08.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:15:20 -0700 (PDT)
Date: Wed, 3 Sep 2025 17:15:18 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <aLhbhv1oiwxQ2E6b@jlelli-thinkpadt14gen4.remote.csb>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-6-arighi@nvidia.com>
 <aLhWh9_bJ5oKlQ3O@jlelli-thinkpadt14gen4.remote.csb>
 <aLhafcdtmW6s-ydD@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aLhafcdtmW6s-ydD@gpd4>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8YnU-BSr3LK-D-W2v_xtcoIcZ4aWYjZFyu9NXhh1edA_1756912521
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 03/09/25 17:10, Andrea Righi wrote:
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
> 
> I'll run some tests with Yuri's patch applied and dropping this one (and we
> may also need to drop "[PATCH 10/16] sched/deadline: Account ext server
> bandwidth").

Please mind that Yuri's change is still under discussion! :))

I just wanted to mention it here as it might change how we account for
dl-servers if we decide to go that way.

Thanks,
Juri

