Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91856303C93
	for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969547; cv=none; b=dPagIt9YwML4tljtf/CJ4QXpFUf68zhPM5YDb+mWpwou1hLHfx8eNYBXIQMQBVmq+ldY1Vm418QXEKNq16C4kE/G01VTJEd8bXQj3sxcsSXW9PF2p/mVu1sMmlJohhysrn6Ma5PjH17KZ4SqJwW41tehBCssmXt4bla1aV33FYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969547; c=relaxed/simple;
	bh=XTmyJMnTaGQvMndSexCb1z6HpLrVTTo7/egeZXdgM08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ShZ1wHCtnBbFAzWj3PXMjaF6wOq4EIcyd7wKZhITWjjhhD5EJWC4LjAhZPIVNKu8tjkYLjSymahCSHIgbL3YmlRqnnCmPBZj4jtVJ3aewFXbNNEUVdpKBIc1kpuibFMNE6UkNTqudjFH88dRRATswt97KhRZFocpP4dfKCMnpJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxKnVNEW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxKnVNEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760969543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7m1GlhRfmho7liEla+/1yigGXVY8Z7LQaPA9s5+XnW4=;
	b=UxKnVNEW0jgk81rZD1qIIqUBZ9AIdXQyPxxI/yRafGe1mr4fahvTbNnc9109vboIj+CEOl
	uT9N/IkZiGf+fNdeRe/vtNA91OYUlQHQtjdpKthK5FWOK3eW72AhXo6o1Zolwd5qGGIZ5V
	pfQ4I67dwUnlL3AdK4NC5y6l/lwvXfs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-4I9HmieRO4y5z_dlP2Qz_Q-1; Mon, 20 Oct 2025 10:12:22 -0400
X-MC-Unique: 4I9HmieRO4y5z_dlP2Qz_Q-1
X-Mimecast-MFC-AGG-ID: 4I9HmieRO4y5z_dlP2Qz_Q_1760969541
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-471125c8bc1so52158295e9.3
        for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 07:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969539; x=1761574339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m1GlhRfmho7liEla+/1yigGXVY8Z7LQaPA9s5+XnW4=;
        b=g6dU1tjxtUWAyR1MkSfdNlIYrz/gO4yZH1rTMUl0YxEYQ/oY9VbgZm2jGjChkWdlOF
         d3krLHkWk8j1oECynWz6EaZItC0DA0iPnMkj9332SgOpL4aEpqeEsutawrXcMvjbdKWT
         X/PnVJKSFg7hvoBWoac8xHoB9p3dloZbu+hEwcsAG4iMdM7PD+rN8rYm+4bqFR/QUY7s
         1cHg5miBZXczTkrpnKT8bJMpfxQjmQKXmNkPudA8PdKWKNhf9WKp7igiveCJgo5kvcJz
         qmrJfKh+2o+4ACeXvGY3Ydqj4GdLDP+Wt3c3Cu0r67d+xK7uLyHuCcv8RZQQ+3G2jikJ
         WQDg==
X-Forwarded-Encrypted: i=1; AJvYcCUb4MZiOj+FLeBHkEVu1dsHAg8Z4tXPJW/6TKVCYDH5y2925Y4NVgltNp3zWAbgFMZ2QQ02LCxwHQI=@lists.linux.dev
X-Gm-Message-State: AOJu0YyaPb7+FzcmrPDhsenyBKnhxxOBJ0mbMISSOMO+xI1ngAQYzt29
	n3g3nsN186g/scDkgUAwlAJAxZGumP3HtpEFlVhZeoI2R2wHwkT+ULv/6pe/Unbp+wdd03j+oTG
	RXpVsEMxYEMKFlmXZHx+m6qfzRhpVPWzw249yYCsyWzuD9ugsCjRMCoUIMMjajA==
X-Gm-Gg: ASbGncuWD5JSF9BEo9qKAZ1vLgoXZw7B1A9dgUBsET9jHLzY6BZs1r5RkHHF7GpjB9r
	kMEZwR995LXzTuhU6qVuIhfJ0D7x6hxVD9EM6bN0LJvEsCxL9MU8Rx0t0xg5WoZUZvfRly/WCQL
	kenPgGtGThA4zHVNdjB8FrIe5qfD6FKNg+u5DLwDa+O5Mc+4FNUqhYKdLV6+OU8RBp3H5NU9ZbB
	PTxdA81ur3/lyh0QfTGeQjjX4sOMa0FeukQlXknnPbon+vo9DgWWBmgiguXvd9KW0Fei/hVJG4F
	Cnh/beP9KlVPwrsLF0E9ShB0BMUOAX597R5vWDjubkfJ6K6qmkMx+tdypxnbECvVToMwPSRkNi4
	8VmqA0h2v+qOSixMhuknNRgCruSOdgQ==
X-Received: by 2002:a05:600c:3b8d:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-47117917572mr120147065e9.32.1760969538611;
        Mon, 20 Oct 2025 07:12:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUFlFwDhK5O8LnMIOdT/gwVFGKlVMOVfS2OH7HmR0uwDj9gtAHpXIdIfbbitn2vkRwOsYp+A==
X-Received: by 2002:a05:600c:3b8d:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-47117917572mr120146715e9.32.1760969538203;
        Mon, 20 Oct 2025 07:12:18 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.131.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b988dsm15921167f8f.35.2025.10.20.07.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:12:17 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:12:14 +0200
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <aPZDPsJaZ9g4jz0g@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-5-arighi@nvidia.com>
 <aPYFv6YcxqWez8aK@jlelli-thinkpadt14gen4.remote.csb>
 <aPY7O7NNs2KyKpb-@gpd4>
 <aPZBPQpRHm977Fno@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aPZBPQpRHm977Fno@gpd4>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QmMbdb9SjuIvGqBtFi2jw0g1vZleKxy5V0ik1p3z4hA_1760969541
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 20/10/25 16:03, Andrea Righi wrote:
> On Mon, Oct 20, 2025 at 03:38:12PM +0200, Andrea Righi wrote:
> > On Mon, Oct 20, 2025 at 11:49:51AM +0200, Juri Lelli wrote:
> > > Hi!
> > > 
> > > On 17/10/25 11:25, Andrea Righi wrote:
> > > > From: Joel Fernandes <joelagnelf@nvidia.com>
> > > > 
> > > > Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > > root domain containing cpu_active() CPUs. So in this case, don't mess
> > > > with accounting and we can retry later. Without this patch, we see
> > > > crashes with sched_ext selftest's hotplug test due to divide by zero.
> > > > 
> > > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > > ---
> > > >  kernel/sched/deadline.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > > index 4aefb34a1d38b..f2f5b1aea8e2b 100644
> > > > --- a/kernel/sched/deadline.c
> > > > +++ b/kernel/sched/deadline.c
> > > > @@ -1665,7 +1665,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
> > > >  	cpus = dl_bw_cpus(cpu);
> > > >  	cap = dl_bw_capacity(cpu);
> > > >  
> > > > -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> > > > +	/*
> > > > +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > > +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> > > > +	 * with accounting and we can retry later.
> > > 
> > > Later when? It seems a little vague. :)
> > 
> > Yeah, this comment is actually incorrect, we're not "retrying later"
> > anymore (we used to do that in a previous version), now the params are
> > applied via:
> > 
> >   ext.c:handle_hotplug() -> dl_server_on() -> dl_server_apply_params()
> > 
> > Or via scx_enable() when an scx scheduler is loaded. So, I'm wondering if
> > this condition is still needed. Will do some tests.
> 
> Looks like I can't reproduce the error with the hotplug kselftest anymore
> (and it was happening pretty quickly).
> 
> Then I guess we can drop this patch or maybe add a WARN_ON_ONCE(!cpus) just
> to safe?

WARN_ON_ONCE() works for me.

Thanks!

