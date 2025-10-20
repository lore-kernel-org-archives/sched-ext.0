Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3171248F7F
	for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969378; cv=none; b=PC2Ij0deUxygbac8URnPpmdYKXTuT9Zsjbee5PgN1bP9jIrtXD70zNy8/OPeKGCQoBUNJwW6P2r+s6zFS/JJ76yFCx85HAEqn3g129RDr9hAGp1BHb6BKnfVP2KJeD3mD2g0FwmBveoNM7dTJzLTZsKpGts246LJfJJsEPEztR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969378; c=relaxed/simple;
	bh=j/Pp8+a9LWec1g+KxozHCqh0X+tJ57lSb9FaEKyKHjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sE8AjoNmrB62Vk+3xJEk2KuvjseylG64yKbBI2r8zXfQt8h1BkzFvJvEz8gw2BSXCqNII3O94ocpi9qB3LmYUTBHn+C8I4Br3Xz8b3n5zdYBWv1VIXkDNZwzj6VysC6CSm/ysTk8VbjVpAg1efBZrf/AIy3GWhmblS++YsVJvK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBLRt8L1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBLRt8L1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760969375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XQFS0nziRWGUnVx3NjlDIpRK/8NuLJrpA5nzcrIPL+Y=;
	b=XBLRt8L10oXcdUWEYbpXf0u04wx0h3ciy4LRzvDEfl3rXyovPe0orTOlOkq6+rFRU4SlXP
	AS42ANm50+3xukApIkO4wXUDw78wVRF1FzYLYSA78cVJKn8EBeLjxm73Npr+dqVtpK3Eat
	wPCimZcVvzp12j9y6P1FdRUEXiAhD3U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-2rcPD4j8NnexU7Hftve1zQ-1; Mon, 20 Oct 2025 10:09:34 -0400
X-MC-Unique: 2rcPD4j8NnexU7Hftve1zQ-1
X-Mimecast-MFC-AGG-ID: 2rcPD4j8NnexU7Hftve1zQ_1760969373
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471125c8bc1so52132455e9.3
        for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 07:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969373; x=1761574173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQFS0nziRWGUnVx3NjlDIpRK/8NuLJrpA5nzcrIPL+Y=;
        b=D0fVgW9IiKz1k7AFTMBOxDLZDtXH/0Pf9/Xya5UkEGuqJ8+WW+5Y6SFXyz3m1tFN/g
         u9UH/n6AJQ5xju//KkcGjJqcolXaS9ASXuIZxc8s7BFHb5H8fZbs2lG0igxA+UPgBGcQ
         htCxSA3+duly8zv2yDyL7iSZWhRlZcqJ0ygohnzooasLIHROojMTdhCpvVjsyUp95wK4
         m47E+vPF4Khnmj047qcNnrBL34ZE8NJMiUODLZuaUMAG2D0wyHIkLgFxTwK9cEvEw6uN
         Z+gRTlzXjJmtO6YhdEEVe67EgYE1morJ0dN8p38xH3uUId4WCV59v4iC/+FxiNcLTxyL
         gbng==
X-Forwarded-Encrypted: i=1; AJvYcCXVWR6F9v5oB89f5UUUwbRrYe/1iPgdWL1VX+7lchBIeLb6LOvMSf1xy9fUbP0zxqAyegLJZcSDl0w=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2C1kXIgIFEUmqRJJoWWui3mQpkMP4If+trskzQmIR2RkrQC28
	tYYsGibpxkczcrcvzzA+65HFgy2wMMI6+UwYd69ZjowJn6ZbmZcfAJJDPrYUydI8W2dcG7Dqnzx
	9R7cNSvPCLsqDbDUg8E1anyvcJeFxiJ2kddJnj9mALTATfgSiD6VTdLIaZaC7MA==
X-Gm-Gg: ASbGncsa/1IUMOW0PQlOdqpWC+mjr7v5Yt0/1Pyu+O/eOcXpsJM3QweSVZRLLu0ZhzP
	TDHwyMBmS8jeNM2we78iv9k84ZTP6IBHfKQ1RtZQwSZbX3CvK3aH+dp48N6YAjVVDPRGXETur2S
	WARcN3oCJ/uyBbFTLaEfBnFoEspFNgnj3SOeljWGrH3zuTE+KyCsCijdxN7fBeCaiybr4mr1oN/
	Upzqt4bfRvUk1a/lawc9a3F/75DZ7wHtKv8eTVyf2R64UPoUhPSRLEsAAfE2duwdh3q5/FiBPcI
	+6OK+cM6vvOuWo/HgJqx2pF22xSCBOoxXGJjuInJ2tCAQp5nLAIO5kCy7ZnUwRjV7OVlnKX/OPZ
	CBpiLFNpoLg4KSIrD0+aC9NHxJya8Iw==
X-Received: by 2002:a05:600c:3149:b0:46e:4b8b:75f2 with SMTP id 5b1f17b1804b1-471178a7ea5mr86748955e9.16.1760969373336;
        Mon, 20 Oct 2025 07:09:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0mn7LBjNER9gtoWif8Bgg5J8Y0egN0uHFHsLZtoAR0dq+X1zkA1a8NQOlBpYb8JH2pb5i0w==
X-Received: by 2002:a05:600c:3149:b0:46e:4b8b:75f2 with SMTP id 5b1f17b1804b1-471178a7ea5mr86748665e9.16.1760969372894;
        Mon, 20 Oct 2025 07:09:32 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.131.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d38309sm149048465e9.9.2025.10.20.07.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:09:31 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:09:29 +0200
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
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 06/14] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aPZCmZF_K-vJOYKp@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-7-arighi@nvidia.com>
 <aPYj-iOdvgUYQFpn@jlelli-thinkpadt14gen4.remote.csb>
 <aPY-QOXV5USEHVIq@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aPY-QOXV5USEHVIq@gpd4>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2FFrF7COi_sJYuCnw3xzqG_nKCylG3FTL3N73VLdWqw_1760969373
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 20/10/25 15:50, Andrea Righi wrote:
> Hi Juri,
> 
> On Mon, Oct 20, 2025 at 01:58:50PM +0200, Juri Lelli wrote:
> > Hi!
> > 
> > On 17/10/25 11:25, Andrea Righi wrote:

...

> > > @@ -1487,6 +1499,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
> > >  	sub_nr_running(rq, 1);
> > >  
> > >  	dispatch_dequeue(rq, p);
> > > +
> > > +	/* Stop the server if this was the last task */
> > > +	if (rq->scx.nr_running == 0)
> > > +		dl_server_stop(&rq->ext_server);
> > > +
> > 
> > Do we want to use the delayed stop behavior for scx-server as we have
> > for fair-server? Wonder if it's a matter of removing this explicit stop
> > and wait for a full period to elapse as we do for fair. It should reduce
> > timer reprogramming overhead for scx as well.
> 
> So, IIUC we could just remove this explicit dl_server_stop() and the server
> would naturally stop at the end of its current deadline period, if there
> are still no runnable tasks, right?

Right, that is what I'd expect. But this part tricked me several times
already, so I am not 100% certain (Peter please keep me honest :).

> In that case it's worth a try.

