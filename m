Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187011D432D
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856332; cv=none; b=Lqy+TBxnAilk+UmG3XCr4vC8GwzsWyv32P2k1NR5fV2IPwYMwaY2o3i5GMFCx5sY5XwKHsUtBoGk9PKZJ6vy0ollHevYvyePQDXlmcS9Rupae3sir2Dgnu+2lcONZtslkaZLpG8BdlORrtopOk1bx7/Uj5WWghpmfcFYXCW1Skc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856332; c=relaxed/simple;
	bh=jGRdwrk0WiFSH1LDOpIbZJ7IaN2969IhOnXv8zywGVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cj+rN3ncXVl9A/lrbHZmI4XJ+pHwwWuzUIr+DVEWIElEAE4O0hs0Jb8H22HIK3J9jwB8V028lyLF1L+nbIIkVBfWqOs7haCJKiO8/LBCgungydl56SWKOaA/WJ1cp9vXiKiRJOHPtjOdq5A1sclM2SfHzM+YYMu2FDT+rELc9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3IUhfCl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3IUhfCl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759856330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VI49gLtrLPJJ2pYL6x4CUqavDWlalTmVp/UAdCT3bf8=;
	b=X3IUhfClXM97pZQeLbFqBybkdZbBHtc9m8LXq4WXaapBJhPVi3igONAbzX46OR0wIKmQGe
	CkL5uFdXmCcO13BY5A2VbybEL0O7eZuIYT5JsKUls1wXbdOWy6kOuhpdiwl+sKcafsHnkq
	7WcwSDU0VKaQ8WNoV8R1qT4cm7v0SHg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-4HrkvmqHNaetDikLfqq5ug-1; Tue, 07 Oct 2025 12:58:48 -0400
X-MC-Unique: 4HrkvmqHNaetDikLfqq5ug-1
X-Mimecast-MFC-AGG-ID: 4HrkvmqHNaetDikLfqq5ug_1759856327
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e2d845ebeso34838015e9.1
        for <sched-ext@lists.linux.dev>; Tue, 07 Oct 2025 09:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759856327; x=1760461127;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VI49gLtrLPJJ2pYL6x4CUqavDWlalTmVp/UAdCT3bf8=;
        b=e5TWLyK2zYUAIa9aokXOfxtG08eekxgGeDjUEL/FwKFfAXnFyykEnpsqZ00+dZ/xP3
         w7Ia8SmNqcMosbPCne3GWh+n+Dms8ZxhBKWdvt/Ks2stb+RjQL3GoWILvcViN60XH+e7
         HMDt6wTw23Be/7mXgZKupuVgycmz5gTVuggW+GcJmh0gCpAuuljVvLJ17UyC1ZMNpE+F
         xM7XXkkp6olfTZQCN1geKygE65F+9lmXppgXLL2ARAeOvAX0iO4ekGw2IShmsxWcfDjr
         NhL8eWLBuGoYPwLAGy2NeJLZR9zrtxBTu1PF+j+Gy+Idd3XBOSUY07kIj0b6RknwuiZh
         nQ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBSfP9CPA9fwmt85zQoaQJQ00FDg0eJcm7GWnCSHl5D3AtNlDuX3Cl6CKqY/mfVoLlr1h5Zx35Od0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxH9wiiApP8rMnInEY1TWanI/PeughL6ePXtzOlcWML/6G2fyJD
	zAZwop0zvvP9PXRANhGaswbFq+ZW1a3LPDsLx3plgg3SFZP45eHs+t2T56cVPZtIEr6bbzatRIK
	kmo5JMusmf3ge06PvpMDMcV65i2UYATru9LPoTypv49rIbzslLwKyshoQ5EpMxw==
X-Gm-Gg: ASbGncvRWEOdi5BcEddQe+XpwSLur/bMILgZBamxxE1Fbp4fM6bWhaKY24Mjia+x8y7
	/YDPMrRYk4dmaI1FEiJT8L/AcXJu7m/2NvLY50VN1MWB/btnQg2PKjMI8lWbF/8y9CHyjqyu6XH
	4YiCzqfOivVnt+IdS2G3JTc6tzVZZA/vSU8R/g8HYf1YjuAwyb03BPdKKc4DDxIaaxhWsOPmx03
	XyP0C/fKPPx6NWbEJXiJvjX7qwUpZTyLa6CDCWF63htgcO0Lle5M9id3ZPq5YhkloFpN90TwLRv
	G0+CW02TgYsYRlKFEKIDH/Qy6O6ofO/Ha97LAW0D1AwLoMnFC09Y2EP2n33D6a3amAr/63l6+7V
	jPVamyAGjlXzamkatLzag939Wfdk2QE4=
X-Received: by 2002:a05:600c:1384:b0:46e:3cd9:e56f with SMTP id 5b1f17b1804b1-46fa9a89286mr2689895e9.6.1759856327263;
        Tue, 07 Oct 2025 09:58:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwECPkX1ww7TuvN8jwk7t/3HaNmLFBxphplQDqgkXaFZv+r5HSiHGWEg5jQHe1bx3Y1Vl/Hw==
X-Received: by 2002:a05:600c:1384:b0:46e:3cd9:e56f with SMTP id 5b1f17b1804b1-46fa9a89286mr2689785e9.6.1759856326877;
        Tue, 07 Oct 2025 09:58:46 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa2d67e97sm21615545e9.1.2025.10.07.09.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:58:46 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 cgroups@vger.kernel.org, sched-ext@lists.linux.dev, liuwenfang@honor.com,
 tglx@linutronix.de
Subject: Re: [PATCH 01/12] sched: Employ sched_change guards
In-Reply-To: <20251006104526.613879143@infradead.org>
References: <20251006104402.946760805@infradead.org>
 <20251006104526.613879143@infradead.org>
Date: Tue, 07 Oct 2025 18:58:44 +0200
Message-ID: <xhsmhecrehcmz.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8dpnVjPUJwHO2VXzsdQhquID-libr7YUzcS0Fcc_do0_1759856327
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 06/10/25 12:44, Peter Zijlstra wrote:
> @@ -7391,52 +7391,42 @@ void rt_mutex_setprio(struct task_struct
>       if (prev_class != next_class && p->se.sched_delayed)
>               dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
>
> -	queued = task_on_rq_queued(p);
> -	running = task_current_donor(rq, p);


I'm not sure how that plays with sched_ext, but for the "standard" change
pattern such as this one & the others in core.c, that becomes a
task_current() per sched_change_begin(). I'm guessing we want to make
sched_change_begin() use task_current_donor() instead?

