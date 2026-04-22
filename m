Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFAC1A3164
	for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874442; cv=none; b=H9r4bYoOJlUeGQazmW/opHyAzTAcMEkRPjKqlIcVYMShJb3llFWkMNQBo1ugVpyBNijqpc/CAv/hzQvTTo9kK71LFr4kadx3HvLSa+Bg4RFgxitr+LiIbc0ycEsfe6B3oHXGpxyZsmOpL8SsnYSUSb7LtozL1W2Iv+nuAGMgMSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874442; c=relaxed/simple;
	bh=NLWsA0yi+o2QQuOo2RuruqjskQFGSIWyp2acUHvZGBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhIbj4iSvk3az7fOBii5l/LCKPnKp/+iDOhS9odekgsNfa4ATE0pEkFegfMAQ6bSo7Ruh+Jnt4m1rPILiHHMpDdCNeA5GPQeJPTGSv9dTAah2/f/34PeROGICB3VcNQlAlW1UkYRrKq3+hgBT8a/cclVxKVnjoCc7Cicmuq4DA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Byzt/Jry; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byzt/Jry"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so3605047a91.0
        for <sched-ext@lists.linux.dev>; Wed, 22 Apr 2026 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776874441; x=1777479241; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-description:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9HLvC+H7u5a1yeHTO01Idv0eCZF9BVv1f8N9iZOJd14=;
        b=Byzt/JryD+yfbr2wauCC07wHtk4OqcguJO2OiXZX4+qTClS6kpA83QwUDrJzDPS1wV
         5K/RahkFMaP5V0DedvNEqB8sX/fSSV9VTeGQbkv2L5RIEscdb2nVafRDrBuFmFgP5bfi
         3AKXgY8xAcSEPnZZ70Fyk+mjSI0Kaz91LNdjf2u4ZQ+6qZ/xFLzl45elHowG/ERPoL7v
         ZtJ/wDGKNzXxB/UqYp1g2nwZ8BS7pq6l4uZgEwtYogJ7RV6cMoVpZ5rslhuVuqDaEnZV
         GTSd7nZ94hpFYqCaI8B0eZP1pqxL4Hdb8vUTrPdCzUYkB/Z1Fo9UuwzqLvbYVKJ989fv
         V33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776874441; x=1777479241;
        h=in-reply-to:content-disposition:content-description:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HLvC+H7u5a1yeHTO01Idv0eCZF9BVv1f8N9iZOJd14=;
        b=JxFoT80un+K/8srsORHvF4fqqya7+y6M6gwrELdp3gplOy+qU88l6s3yZfHius2cqb
         NV3FPS4O63vUOGn+lJ91LSbIo/mfWeLakL8zCQBUW0xnM5XOYMgzZJAjBFxwyapBvKFR
         Ckh5DVmLd7gDTpu09R7t6ocHJDYc4bdtON6m58wGtCJIRM7Vf13BUlcQLK80aEBOpOV6
         Z2V7BhCNSlWRtyrafNtLR1gQZ20e73NNTNK97nf7AKQXH0+re/UGofR6HUjPYLtd2EoY
         5HeTBYOvuoUMXlehiYizX88RnOUEwemc9IyCMd/LntUzGNMEXY/ZUnqlPAW9DcfH2g6S
         4s6w==
X-Forwarded-Encrypted: i=1; AFNElJ9wZTCavXj/IUowBAa3iHZ8Atecq3rvXLLB39ZWFmiE257aN/hd1eXckVuBoR1DBjlw5ucrq2NIJmA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5sorOpLHx/GjI3M6boggua4STQuJrI/EbkmQZbqFjmJL8Fh/s
	v4LcgH1nrYYtk5pIH2QtLz+W+02DP6WrcWuDhW9TRrQCcbf07u5wfAG6
X-Gm-Gg: AeBDieurLVtUlmkfbS+bOSd76CRWH6trIl+qTsT6YodOIYBWBy6zo9ngU1HouMQr9BH
	EqSzWdxDOyf6QI+M8+m8g8lSuVJpm34z6PZas7sP46BcNKxcvzLlu4P3Qk5YTtgfnCCo5emuy/w
	bhYO4jwXPOsnU5G8TQLacSVk+Q+tJntSoibNaYfZr5oOMxAD1Iu5Ijsmo3sSLQImxHcvAxcoKfA
	JDzDxa0a8zjpSHAP1D0cFoUu60uLnUMPlCyORMEqPP0Sn2W3dTDH0Kf2jQG/Hs1m5sMOvWP7xnL
	O5puENDJB9eHD2AhtYf0SWobadYLJbCDc1n11yd955aNOknZcLufRZkI/ZNgJYNCTGKWud+GXpO
	nHGbA/dRgUuKySmhPCJjE3FeE4NxnveUYxLcuIOfNq8weoHJsJ8PTJjfjyRFKxDPgfLw3EGvdnl
	x7NdG7sZt1bKgT8dWV+Hg9ASZvrfVtEAh6IO4lDGNpMN1ZCXVMF549L3VAu8sOv/jsV7mf7yPmO
	B5jHCsfC8q9mcKE
X-Received: by 2002:a17:90b:5107:b0:35e:3aec:718b with SMTP id 98e67ed59e1d1-3614046e12amr21732095a91.15.1776874440826;
        Wed, 22 Apr 2026 09:14:00 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-97-241.dynamic-ip.hinet.net. [36.225.97.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361419739dfsm18390059a91.13.2026.04.22.09.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:14:00 -0700 (PDT)
Date: Thu, 23 Apr 2026 00:13:57 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, sched-ext@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] man7, man2: document SCHED_EXT policy
Message-ID: <20260423000434.G45a2@cchengyang.duckdns.org>
References: <20260412181743.276652-1-yphbchou0911@gmail.com>
 <aejvcpOKmAxCnJQV@devuan>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: 
Content-Disposition: inline
In-Reply-To: <aejvcpOKmAxCnJQV@devuan>

Hi Alejandro,

On Wed, Apr 22, 2026 at 06:02:49PM +0200, Alejandro Colomar wrote:
> > diff --git a/man/man2/sched_setattr.2 b/man/man2/sched_setattr.2
> > index 80a0ac726dcf..d60678f00e72 100644
> > --- a/man/man2/sched_setattr.2
> > +++ b/man/man2/sched_setattr.2
> > @@ -81,6 +81,10 @@ a deadline scheduling policy;
> >  see
> >  .BR sched (7)
> >  for details.
> > +.TP 14
> > +.B SCHED_EXT
> > +for extensible scheduling policies implemented via BPF
> > +(see \fBsched_ext\fR(7)).
> 
> Please follow the style within that manual page.  We avoid \f unless
> truly necessary.

Ack! This is my first time contributing here, so I'm still catching up
on the specific style rules.
> 
> >  .P
> >  The
> >  .I attr
> > @@ -95,7 +99,8 @@ struct sched_attr {
> >      u32 sched_policy;      /* Policy (SCHED_*) */
> >      u64 sched_flags;       /* Flags */
> >      s32 sched_nice;        /* Nice value (SCHED_OTHER,
> > -                              SCHED_BATCH) */
> > +                              SCHED_BATCH,
> > +                              SCHED_EXT) */
> 
> Why break the line?
> 
> >      u32 sched_priority;    /* Static priority (SCHED_FIFO,
> >                                SCHED_RR) */
> >      /* For SCHED_DEADLINE */
> > @@ -218,8 +223,10 @@ This field specifies the nice value to be set when specifying
> >  .I sched_policy
> >  as
> >  .B SCHED_OTHER
> > +,
> 
> What's the reason for this weird formatting of the source code?  At this
> point I wonder if this was generated by AI.

Yes, I used AI for the formatting, which I should disclose it, hence the
weird layout. Apologies for that. I believe the content is solid, but the
style needs adjusting. I'll send a v2. Thanks.

> Please take into account 'CONTRIBUTING.d/ai'.
> 
> > +.BR SCHED_BATCH ,
> >  or
> > -.BR SCHED_BATCH .
> > +.BR SCHED_EXT .
> >  The nice value is a number in the range \-20 (high priority)
> >  to +19 (low priority);
> >  see
> > diff --git a/man/man2/sched_setscheduler.2 b/man/man2/sched_setscheduler.2
> > index b4c35543e5bf..825eb7290ee7 100644
> > --- a/man/man2/sched_setscheduler.2
> > +++ b/man/man2/sched_setscheduler.2
> > @@ -67,6 +67,10 @@ and
> >  for running
> >  .I very
> >  low priority background jobs.
> > +.TP
> > +.B SCHED_EXT
> > +for extensible scheduling policies implemented via BPF
> > +(see \fBsched_ext\fR(7)).
> 
> Please check formatting.

Ack.

> >  .P
> >  For each of the above policies,
> >  .I param\->sched_priority
> > diff --git a/man/man7/sched.7 b/man/man7/sched.7
> > index 00926cd34ecf..2e73a4c716b9 100644
> > --- a/man/man7/sched.7
> > +++ b/man/man7/sched.7
> > @@ -116,6 +116,13 @@ and
> >  .BR sched_get_priority_max (2)
> >  to find the range of priorities supported for a particular policy.
> >  .P
> > +Since Linux 6.12, there is an extensible BPF scheduling policy
> > +.RB ( SCHED_EXT ),
> > +which allows for custom scheduling algorithms to be implemented as BPF
> > +programs.
> > +See
> > +.BR sched_ext (7).
> > +.P
> >  Conceptually,
> >  the scheduler maintains a list of runnable threads for each possible
> >  .I sched_priority
> > @@ -529,6 +536,12 @@ priority (lower even than a +19 nice value with the
> >  or
> >  .B SCHED_BATCH
> >  policies).
> > +.SS SCHED_EXT: Extensible BPF Scheduling
> > +Tasks with this policy are managed by an extensible scheduler class,
> > +which allows for custom scheduling algorithms to be implemented as
> > +BPF programs.
> > +See
> > +.BR sched_ext (7).
> >  .\"
> >  .SS Resetting scheduling policy for child processes
> >  Each thread has a reset-on-fork scheduling flag.
> > diff --git a/man/man7/sched_ext.7 b/man/man7/sched_ext.7
> > new file mode 100644
> > index 000000000000..7ea467e18b84
> > --- /dev/null
> > +++ b/man/man7/sched_ext.7
> > @@ -0,0 +1,100 @@
> > +.TH SCHED_EXT 7 2024-04-13 "Linux" "Linux Programmer's Manual"
> > +.SH NAME
> > +sched_ext \- Extensible BPF Scheduler Class
> > +.SH SYNOPSIS
> > +.B #include <linux/sched.h>
> > +.PP
> 
> The use of P and PP seems very inconsistent.
> 

Ack.

-- 
Cheers,
Cheng-Yang
