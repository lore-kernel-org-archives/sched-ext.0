Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D6931B132
	for <sched-ext@lists.linux.dev>; Fri,  7 Nov 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523592; cv=none; b=WAiM0awYCvOws3Z9K1eKQNoBU1zFflgnkFEtBwywryYyEp0Vki7Xjz7Wcyissfh6xmQR8n+6LwOqzLya+bgjykE01lhpbeNxTipjFFOuQ+5ewcOPGFJONDX886fVX6xGTU7g2sYlDW82bkT8bwVhqRD6V/bQ15cKvr7ASMKg7n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523592; c=relaxed/simple;
	bh=kxMIDSfnPpf8djuYkxMRQ5vJUJ7jfPruX9KKD/WvQKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SOBr+XgIrNd1x0d/DbfMfuJRa4CBXg5a7ONt7CQ28nx8tKSDHTspCraD6Xgd/qbNLI0H+n0Otw3b6i+gDNoW1vMK+KxtWP2HustXOW6OeE9mX26y2lt4OXI5BUunX2DG2pcAibk3aQIByTwPP0mvz9YhZD6K3UMDwkoO7DQ2yT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ch7RaJmO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ch7RaJmO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762523589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9/c4QtcuY4C0Ku7AdMAA0akvvVLyJC2D5AYMWNX6jI=;
	b=Ch7RaJmO7Z0Weykq3aN1uyr8LNqKPWG5OtrUuz0y2Ew0paqzbuJhlBtHwGu7ZAOnYeDFhi
	vf5w1Sh7A+weD+cuUk0QfEYrBoYocX1OE9xZk+Tl/MxDQGod6BLpIObwhNp/bSIHafpZlS
	yHdIxFRfCRJC1URYxwMa5knusBx6K6o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-joP8cwB3O96fPVN7r2FS7A-1; Fri, 07 Nov 2025 08:53:06 -0500
X-MC-Unique: joP8cwB3O96fPVN7r2FS7A-1
X-Mimecast-MFC-AGG-ID: joP8cwB3O96fPVN7r2FS7A_1762523585
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4776b0ada3dso5776725e9.0
        for <sched-ext@lists.linux.dev>; Fri, 07 Nov 2025 05:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523585; x=1763128385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9/c4QtcuY4C0Ku7AdMAA0akvvVLyJC2D5AYMWNX6jI=;
        b=X6lnNI/kt66s3wZcHRb2HKJfLNP71R188TzBSnl2moHTkWr+2d2dnW6L61/rvD/QRz
         eVV+fhyE4Ci2O1HwDovdcQ/JAO/xOrOx+T0fTfNNhJHPKs49gMmEMU2MpLoHUqXyMFxA
         Ed9e0IR17vuOWfRamzTeZ65w44ZEVnRFTJVccZeuTc3Ou1mrmrB7LMM3bwiVIdiS0ZRH
         UOS2ZPoW0+ZEWcao82J45K3M9l1kv9AZyskEVgyHy4iSSBYmOFkzdcFaJULqkeuu55uI
         DGjrqBcO9crs3Dm8ckp8o/G7PxR9bpbYLd33lkQr7SlIUHjDteEh9IEL1c608tvl6U9W
         4/ag==
X-Forwarded-Encrypted: i=1; AJvYcCWg/MFdy1vtN5XFc6TU0w5UZr5xgZ6v4rLvydRyiKyU2ilorxRJZvowG2hHd5EuiGQ2bLbljp7WZsw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxO7f93qcj5AHb3V3n+1OYpIadPn3IEVyzzB1ULx6ojgOtMPd0W
	KruIDuXAF31CVf9dOJDGgCjFTF+GVONrF5GCcGiFORo3InmFOL2j/chR/Jzn9ZKdbkJGtGax1ro
	W5ZcWpG5K+y2yMRz82fsVavIXDe08+2EswunzqGtqhgGI1+mDpSbFYftNNULADQ==
X-Gm-Gg: ASbGncu/pX5U89Kb//PExBF73T8sbVXK+YzAwon1Red+s0k5s68iAdqeLAfmWqe5qYC
	BnHp9XetB2PEpQO0ZetM6pwBRU70F1WD3DKzapPfOVPoOFIASWOxaaOPfpZWzhY/mqYEX+GtT1t
	kqyfP9ZZONAu7m1ZekmYYZMLpw5oDwJIx+nhOKjLl9GJuqP4qyG23x+ASDqt54Sx4a1FWuD/gl1
	yngLDwxu5XsVCqKFfRuUHVMbGQ8lt4KCI4b0Eqy4uHmuMMFsm7qt9cgJ7+UdRJ6fOdMOxrv8de5
	kfoMo+FM3d67WtVp05EKBahwNnPeAGATIXPZB+AZDepCOL+2yKJn3T+yhIpd2RpbmT/OslLvLNR
	hgz26bP3MEQjl3h8ddoztRMpwaSaRzg==
X-Received: by 2002:a05:600c:4251:b0:475:de06:dbaf with SMTP id 5b1f17b1804b1-4776dcd61dfmr10469065e9.17.1762523585206;
        Fri, 07 Nov 2025 05:53:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENPFcHgZiedoxSNj/gTHG7HP1mQbGAIXAVzUnhmQo6HdEVRWpGRzBdctMGVXrL+4rI+OT13Q==
X-Received: by 2002:a05:600c:4251:b0:475:de06:dbaf with SMTP id 5b1f17b1804b1-4776dcd61dfmr10468765e9.17.1762523584724;
        Fri, 07 Nov 2025 05:53:04 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcd51dfsm49260135e9.5.2025.11.07.05.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:53:03 -0800 (PST)
Date: Fri, 7 Nov 2025 14:53:01 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] sched/deadline: Add support to initialize and
 remove dl_server bandwidth
Message-ID: <aQ35vUAOD6CflvCA@jlelli-thinkpadt14gen4.remote.csb>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-5-arighi@nvidia.com>
 <aQxvIBIwOCDDu60b@jlelli-thinkpadt14gen4.remote.csb>
 <aQzWM4vv30etfhok@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aQzWM4vv30etfhok@gpd4>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pTbdwxnGHwJrwOGK41HbYksE8aAyN0hBtEoOAwnk6YA_1762523585
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 06/11/25 18:09, Andrea Righi wrote:
> On Thu, Nov 06, 2025 at 10:49:20AM +0100, Juri Lelli wrote:
> > Hi,
> > 
> > On 29/10/25 20:08, Andrea Righi wrote:
> > > During switching from sched_ext to fair tasks and vice-versa, we need
> > > support for intializing and removing the bandwidth contribution of
> > > either DL server.
> > 
> > My first and more general/design question is do we strictly need this
> > automagic bandwidth management. We seem to agree [1] that we want to
> > move towards explicit dl-server(s) and tasks bandwidth handling, so we
> > might want to consider leaving the burden completely to whomever might
> > be configuring the system.
> 
> I think we decided to take this approach because, once a sched_ext
> scheduler is loaded and all tasks are moved to the ext class, the fair
> class becomes "empty", but the fair dl-server would still keep its
> bandwidth reserved, so somehow we need to release that reservation,
> right?

Right. I was just alluding to the fact that keeping the "empty"
fair_server reservations is not wrong, but indeed sub-optimal. I didn't
want to block this series if we don't get the automagical removal right,
so wondered if it could be left for later (as we will still have a
manual way to remove the empty reservations anyway :).

...

> > > +
> > > +		hrtimer_cancel(&dl_se->inactive_timer);
> > 
> > I am not sure we actually need to force cancel the timer (but still
> > contradicting myself every time I go back at staring at code :). The way
> > I believe this should work 'in theory' is
> > 
> >  - we remove a server (either automagic or user sets runtime to 0 -
> >    which is probably to fix/look at in current implementation as well
> >    btw)
> >  - current bandwidth is retained and only freed (and server reset) at
> >    0-lag (when inactive_timer fires)
> >  - if server is activated back before 0-lag it will use it's current
> >    parameters
> >  - after 0-lag it's a new instance with new parameters
> 
> Hm... that means just setting the runtime to 0 IIUC. I think I tried that
> approach in the past, but I was seeing some inconsistencies with the
> total_bw kselftest, starting/stopping an scx scheduler multiple times
> seemed to gradually consume all the available bandwidth.
> 
> But I can give it another try, maybe that behavior was caused by other
> issues, since we've fixed quite a few things since then.

Or maybe it could be inactive_timer/dl_non_contending handling that
still has some problems.

Anyway, I noticed that it is still possible to write runtime values of
fair_server while/after scx_server took over. Those values get
overridden when scx_server switches off. Guess we want to prevent writes
while scx_server has full control?

