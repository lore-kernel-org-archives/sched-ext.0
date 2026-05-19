Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD342D5925
	for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214955; cv=none; b=BEB9T+R1qXFlwRzPuFG//sKecIfNcufXQSELTWbJ1RKlIOtxz/BBW7SEX1TDT/hyuAiatFzitMeJuU3/hKnhNK69cn3RGSuYIiiG3e1QJ8w0WqLmL0P01oTiAa4+bwuLryiT4A3Se6BnewIIizmxi3xQSp7fXFC16XtYqMuPGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214955; c=relaxed/simple;
	bh=/iZEIInf+h07QsZt9LdbOhTRLtwkJCA5Nww+jvwEjz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFEQ9NIuAYJQcAB4Nn2iHF83uPuUtNoi+X9EYv8kFfRBcwPyGGiZiGFF8DseuxfJnHkFAqdfQ3QYFgSRD+zda9p8pe6SQfzz4ciKDOn/wStAGcWQDNFiWDDTmDg6RyzLvb/r1dvfZepZJPRxsipPeYrigbiC8Vh7U0iULnKYq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hn256KXH; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn256KXH"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8383fb7143aso1756967b3a.3
        for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 11:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214953; x=1779819753; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=djwlqTMl8+NOKghG5Z1Hqhs/9/X6wY6hcEaIBs4ftFI=;
        b=Hn256KXHfDAVIoMoQAe0tQCmJxIgP4tfRXqMobpz9ZNgIJ/Ika3Ng4R4FeiMetii2h
         iAuHFhLJMd6EEMQBT4N9y9JdlrEncO8uoD15C76gx3Tb5DmNKprUBGpM4R4Dqm/FPpD2
         rOHcVsKVenYQRBp2qGXXIdSjxfWSgKJt535lfZjowhsrrIyNylWKCIPamH9oTgwJpbL7
         lhlj3xwR7yPZT109aKJVu22ynFQDXcJ3ns19RRcHNn/KOPUg4a+1R442/SJY/MFip647
         HUDHDjZRccHcOfBohcpF4K7zlE3LuFarZrD/Melo041pWZGehX4O0YnwXLShgSRM743W
         vY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214953; x=1779819753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djwlqTMl8+NOKghG5Z1Hqhs/9/X6wY6hcEaIBs4ftFI=;
        b=aPX/4m4WMDSXcgPulXvCW4s60fHzHI/5VJJpuaGYXgxDVII4hGe8iTVRuN9E1cH8yv
         Nh1pyPcsI5uRAZiRS8COIEYw6Zd+Qf0K+Zr7RNZpndhyb4Y8p26Zi7UcqQAQop37fmBS
         hBK9ifkZmNmxr+VHYIEqaB09aTfZVw+xAXDFZrgIAhMY01pPtuJulw5ypG+DXY4MnR9G
         ZrGXUq2Bib2g1Vq9cAG8ELh6p42nCuAOk4XGXFiENm4JkFjqz9LyXcTyN3spBIdb/lhr
         kxUglmUOj1msmNDoe0m42xjFDhyFWlgGabb3dY+UWt+3wnCdT/qCEnA/v9HwJT78jDFz
         Lr/g==
X-Gm-Message-State: AOJu0YzRLTRXoWcsnrM8FibGacEkE+lkh8zXE2c1EVOAUGzFMCA95+IV
	aI6mzjasvz6YyeyBx9ZDnt47tzdNTCcFSS5TRnbVLb7JJui8yHNF6CNo
X-Gm-Gg: Acq92OF8owobHbkby7/R0nrOf+SaCANd5NQJ3iHFJQkaI12ExukH4Qo8z1MELBd+R6z
	iWWakhzeE0aip9sdxuVXAG1Gd8dL80i+voOabK1iTOQsfP2nBIsVN3Gwrk1NF1/NSQiC+FZUQL5
	dr8W37Wxp93lh5jPanIMbNjSvwa47ab5lxZegxwjlF++i4dbtAX1hGIcn+VF1ET3PA/nBTJTzjz
	fKe7sY/53qyyezdpQ5CVtY35G3R9WXf4y6+Oa6r0MOWy7pU/HgSvWVTrV3osBZ698dQ2BFjzlKS
	dcbg3NigGCFEBOJ1606gLxfc8SOs6/0MftGfmP0qwzQuAo2Zcun/fGj9sbKiPYscI52TAX57M59
	weNiD5iudc9fHIN69toKSl6K6yqSTRC7I37dnfj5HIxLUkmF4ud+BXNW877DzACjgxS001AfmqP
	dgCmCt1pFO5L1OyycIpywCSbkFERN3sbgUiUeu0njFNbzbe9YInP242zrEb2W96lQughU3x8rzt
	EMLHkwrkDjOmfG7
X-Received: by 2002:a05:6a00:1f09:b0:835:41f3:f43e with SMTP id d2e1a72fcca58-83f33c45c8cmr21236031b3a.16.1779214952946;
        Tue, 19 May 2026 11:22:32 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-116-93.dynamic-ip.hinet.net. [36.225.116.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5ce1fsm18712359b3a.35.2026.05.19.11.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:22:32 -0700 (PDT)
Date: Wed, 20 May 2026 02:22:29 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Message-ID: <20260520020904.G8ffa@cchengyang.duckdns.org>
References: <20260519171745.1551340-3-yphbchou0911@gmail.com>
 <20260519175231.520A0C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519175231.520A0C2BCB3@smtp.kernel.org>

On Tue, May 19, 2026 at 05:52:29PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Dynamic memory allocation (`GFP_ATOMIC`) in the RCU stall detector path can cause a hard deadlock, masking the system hang instead of reporting it.
> --
> 
> commit ffd18e78b03bfaba9705c61803e8bd0bb6325d38
> Author: Cheng-Yang Chou <yphbchou0911@gmail.com>
> 
> sched_ext, rcu: Upgrade RCU stall paths to report cpumask of stalled CPUs
> 
> This commit updates the RCU stall paths to capture all stalled CPUs in a
> cpumask rather than just the detecting CPU. The cpumask is passed through
> the stall handlers and dumped first during a sched_ext state dump to avoid
> losing the stalled CPUs to truncation.
> 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index 82cada459e5d0..b8f4ca984c1c9 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> 
> [ ... ]
> 
> > @@ -659,23 +662,28 @@ static void synchronize_rcu_expedited_wait(void)
> >  
> >  	for (;;) {
> >  		unsigned long j;
> > +		cpumask_var_t stalled_mask;
> > +		bool have_mask;
> >  
> >  		if (synchronize_rcu_expedited_wait_once(jiffies_stall))
> >  			return;
> >  		if (rcu_stall_is_suppressed())
> >  			continue;
> >  
> > +		have_mask = zalloc_cpumask_var(&stalled_mask, GFP_ATOMIC | __GFP_NOWARN);
> > +
> 
> [Severity: High]
> Could this allocation cause a hard deadlock during an RCU stall?
> 
> If CONFIG_CPUMASK_OFFSTACK=y is set, zalloc_cpumask_var() performs a dynamic
> memory allocation via kmalloc(). If the stalled CPU is stuck holding a memory
> allocator lock (such as zone->lock or the SLUB list_lock), the detecting CPU
> will deadlock trying to acquire it.
> 
> Additionally, GFP_ATOMIC includes __GFP_KSWAPD_RECLAIM, which can wake up
> kswapd and acquire scheduler locks (pi_lock, rq->lock). If the stalled
> CPU holds one of these scheduler locks, it could also deadlock here.
> 
> This would completely prevent the RCU stall warning from being printed
> and mask the root cause of the hang. Would it be safer to use a
> statically preallocated cpumask for stall reporting?

I think the concern is valid, will fix this by pre-allocating static
cpumask in rcu_init() and clearing at the start of each stall report.

> 
> >  		nbcon_cpu_emergency_enter();
> >  
> >  		j = jiffies;
> 
> [ ... ]
> 
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index b67532cb87705..90d6eaf1b8415 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> 
> [ ... ]
> 
> > @@ -645,6 +647,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
> >  	if (rcu_stall_is_suppressed())
> >  		return;
> >  
> > +	have_mask = zalloc_cpumask_var(&stalled_mask, GFP_ATOMIC | __GFP_NOWARN);
> > +
> 
> [Severity: High]
> Can this dynamic allocation also trigger a hard deadlock?
> 
> print_other_cpu_stall() executes in a critical diagnostic context with
> IRQs disabled (enforced by lockdep_assert_irqs_disabled()). Similar to
> the issue in synchronize_rcu_expedited_wait(), allocating memory here
> might deadlock if the stalled CPU holds a lock required by the memory
> allocator or scheduler.
> 

Ditto.


> >  	nbcon_cpu_emergency_enter();
> >  
> >  	/*
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260519171745.1551340-1-yphbchou0911@gmail.com?part=2

-- 
Cheers,
Cheng-Yang
