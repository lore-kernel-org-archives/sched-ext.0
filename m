Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9F629E0FD
	for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952474; cv=none; b=sdPrK+l6oBif1jpGnyA0DGsCne+wUE0SifxWci2TdCyi2kqGKtiLoGwMzzhQdIPBNryH0YtuLlWzAwUY6/6Wf5+n+IE/7QrYUuJSbm+67pHOmhXKquZARi5CQidcq+EGNuErvp992KYCnNLgi5hhDzluLdmL0od0vHORziYm5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952474; c=relaxed/simple;
	bh=dFyf69AmPulWJCNb9/HhNO+93AFGf8+/y+hPagOet7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SoDes6JWAkgigUhPjhHTh+6TQhaDsJVRjDkWgCY9q1AzEYsQYG4Q9R+oaAZ0XveoLHnTHmMNubkyocQ85CkJM7tJSd7qtyyejkIr07p/1N0PZGDSEl+ux1CvUaIyZ/2jrSY08oexl6BuVN1LTaGRPsdlzV0EM7wCA6vo+cXwnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHVVIlVT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHVVIlVT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760952470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySlbD9JSQ2a30ZVs+aOpmM6Ago5zTLOLY/6GRotx8qU=;
	b=bHVVIlVT8TbnsG9JO6VZCD1FcjhN78t/dEEyra0l29we2FVS92qdWQxzh6zHe+TnpD1yp4
	lb5Xnkb9YxAYX0gSSZVEhmLm4DQR2wPjGZurkgZVtTSP3wuv3hgV2OYvPQRnD1TPyFJsV9
	Hd42CLmwngkyQX8Tjp+k7WVzVQSMaEc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-kE-Su2ggNFWEhs1tqqqjrg-1; Mon, 20 Oct 2025 05:27:47 -0400
X-MC-Unique: kE-Su2ggNFWEhs1tqqqjrg-1
X-Mimecast-MFC-AGG-ID: kE-Su2ggNFWEhs1tqqqjrg_1760952467
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47113dcc1e0so35155895e9.3
        for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 02:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760952466; x=1761557266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySlbD9JSQ2a30ZVs+aOpmM6Ago5zTLOLY/6GRotx8qU=;
        b=h68I5OTxzgm2A8BW13iRn2IDiKxBvhJvtz+QTgkRF2SBkoAf/1QNh/UzFHzs6j3s2U
         JOuFQHHOikN27Mg8BBbjokxA+dVJFqSqxIlwTvVzXViKQ3Y54dJqoJwJv08OQ70z5UKE
         7yYTCaXEgIxU2WWyAMxjI+gNiUilaUsDW4SiwtyNtmjObqAyHpG9sx0aHtvqBef4fJZE
         E2s7x1I/FGLsC8AhbEOBIzXxS+jq9qJP80UDo6sDpCztaghZDT9Zj9/ctCbL3dortQNT
         hdtzn5/FkWgn3k7xCvL++FoEz8JjVOpSMkHDq/BlkFqC1pMWishLARjzOrHKctrVgwoW
         6GMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPtZtpZqScpntxJi8EoQb2nQx/HJ3/CFxef7o4by/gxEISGO9hhVIL2+jmMOyu49G75cEusXfPBg0=@lists.linux.dev
X-Gm-Message-State: AOJu0YyhAqxwR5y5CtkITR0bwLh7Ih3cmomimVzkTkppuXPPEGSGjY9s
	GBLdOtAU3oXIfT84HTSKyVVnuYYYmAybhWJ6Cw+cjCKErCLjKUxK7U/SR0hjU/Bx6Me3u3cLVGz
	rX9Wo6XqwTGX/XnoF+oOw7eYE8GpII82Lxu/hVnAy7pGYQ4j1yGgh8lvUJEIkBQ==
X-Gm-Gg: ASbGncv6gK7wGRa5haZg9TTAKGsc/sg0xqMa90iighz7ocRUynMjTCv4uWobPaXSB5d
	X0KHmyipw+16uYKTG1y+LrKMsw4dSGLYV8bnuUo4pBlAEj9QK0OZxPy+6Mb4dYuwALlzNMkoDV6
	iOAnqtp0xbFb6qj/SzG4fRSYDYZoiNYSKXLpKh7JQc8I0whkKasOOK8yQtqGcAVanenQQ9FH6Am
	RlU6v61sGuTYnAlCGkmjXHCf2JCVUAG23RY9IwZa236zCk++DwrxYHzSUNAre8/nQ6B4jTeLdxw
	xNoiALYl+7N8vTixDZMd3Zasdk82L/R+Kr7n4R0dsvQ93x2bpuvO0IRtstYsJ4xN6WYFrod+ww2
	6rYc4LzlMBKb6lDS7Qhr8t2NX61vuWTE=
X-Received: by 2002:a05:600c:458b:b0:471:1702:f41a with SMTP id 5b1f17b1804b1-47117919f1bmr98968405e9.33.1760952466518;
        Mon, 20 Oct 2025 02:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUyEeSf/+w1j3kQT+cNvPNRS6yAgY56mxs7wWlFlz2eV2bpnVw6cx7RlqWm7oJTUSvZbsr8Q==
X-Received: by 2002:a05:600c:458b:b0:471:1702:f41a with SMTP id 5b1f17b1804b1-47117919f1bmr98968095e9.33.1760952466107;
        Mon, 20 Oct 2025 02:27:46 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d382fesm130481475e9.10.2025.10.20.02.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:27:45 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:27:43 +0200
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
Subject: Re: [PATCH 02/14] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aPYAjzEB0n0O0LPY@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-3-arighi@nvidia.com>
 <aPX86h9lSEZh0YP2@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aPX86h9lSEZh0YP2@jlelli-thinkpadt14gen4.remote.csb>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WCFgC15vE1LqpiO-t30cv7jds_WUApneYAvn17mJzbU_1760952467
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 20/10/25 11:12, Juri Lelli wrote:
> Hi!
> 
> On 17/10/25 11:25, Andrea Righi wrote:
> > From: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > Currently the DL server interface for applying parameters checks
> > CFS-internals to identify if the server is active. This is error-prone
> > and makes it difficult when adding new servers in the future.
> > 
> > Fix it, by using dl_server_active() which is also used by the DL server
> > code to determine if the DL server was started.
> > 
> > Acked-by: Tejun Heo <tj@kernel.org>
> > Reviewed-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> >  kernel/sched/debug.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > index 6cf9be6eea49a..e71f6618c1a6a 100644
> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
> > @@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  		return err;
> >  
> >  	scoped_guard (rq_lock_irqsave, rq) {
> > +		bool is_active;
> > +
> >  		runtime  = rq->fair_server.dl_runtime;
> >  		period = rq->fair_server.dl_period;
> >  
> > @@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  			return  -EINVAL;
> >  		}
> >  
> > -		update_rq_clock(rq);
> > -		dl_server_stop(&rq->fair_server);
> > +		is_active = dl_server_active(&rq->fair_server);
> > +		if (is_active) {
> > +			update_rq_clock(rq);
> > +			dl_server_stop(&rq->fair_server);
> > +		}
> 
> Won't this reintroduce what bb4700adc3abe ("sched/deadline: Always stop
> dl-server before changing parameters") fixed?

Ah, OK. It looks like it doesn't, as dl_server_active() is the correct
thing to use/check. Also in case the server was not active is should be
enqueued in defer mode, so no need to have an updated clock just yet.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

