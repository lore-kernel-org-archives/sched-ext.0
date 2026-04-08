Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5403D75C9
	for <sched-ext@lists.linux.dev>; Wed,  8 Apr 2026 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674495; cv=none; b=SF6c7ufCbtUL44q6NZU0WMfpUghmlqvoukE8CEbKVoCypgaog75y1U3M6UDwElRwIbCkYLH8Er3Ip9/kGKjLDKuLuJ4eRWLPCUk8Pn2q+bKtJvV6t93wpdswTDdjeejzaJgEk73D3SA0tNRCl2Oky915kmSnYCHuqNjwe3QJMEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674495; c=relaxed/simple;
	bh=korFRWosMo+b4UqgtesTu2THTOv1ipq4dhrj4savmqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwNYkF2fnsggGfwBsO+M1u/jSiE9cQGmJqCiK08H7hgHcOlPlnNIdizjelqBOTJ1e7tY5iLZwHh9DR9bKcZyoAoRNL8BkEg2ays6eyYwqdLN/iGfCPI4y/hilCJnuv1r8pZ1bCOz3ER3QYEiZWiYn4J0Wcm23xEZmaFA5ehPFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buGbljHo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buGbljHo"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2adff872068so676755ad.1
        for <sched-ext@lists.linux.dev>; Wed, 08 Apr 2026 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775674493; x=1776279293; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=39kDhOCSRZ9smKhtXJB6LH42nit4N0sD8uI7tQaXfhM=;
        b=buGbljHoYd4XBrZjRmtcj50Ns1ew/MIgAVcKCm5z/CM1AVhCkjjQx6Czv/OctN3inT
         CLFqoULOpQai7E3R/qlvIZTbTT049TMeQJm1oN0vl4vkmB3gn1XYZOEaTI4WyR1XXHic
         VZvXFzSbVHkheo/G17DJyg0Xk22Oh9oNmVoDhbS+inkGMQXrzqBTVcCMoU7v8rDzo5n2
         t/wTZpngZMRFz8ZiJbkZFKLremyC+f0qCyedeA0zVB4IdJMLD3QRK876733qR2a0BdD7
         OJdJhui6Y3afQJSTyeZIdicsinW90klosY0Tkt0aTRq74jLVKTCZnhlkrZnGu9skIq+C
         Qw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775674493; x=1776279293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39kDhOCSRZ9smKhtXJB6LH42nit4N0sD8uI7tQaXfhM=;
        b=BJlQoKi508az/Yg9bStYxHLLwdy3fHCPGQGAPN7bntMcPv5Kppb2tJEujOr9+jdvMU
         7bbpMMD87Hnqgku3jDVmgheZN2bRF+Hoh3yZK5+Qd4h+A3qlCM05pBcnOjtGwWt0qpGZ
         k6ny9wD1Q1nePxzDwiQHwc8tceKUnW/0DTzta5h+sQylYZ0nN75fZ07lfJ8FNGfeC/tr
         G4632FNHs0ZMKQXkmiDxOJq6B6EW7VcV+W2uH6d119XwZx6Tv2CpL7l3FYUXp/PD54J1
         I2wSl7gCOOwvGwnqkd2Lz2l//AKdI7lABL7lWD1ltPN61//EP2s3RmHn+EXytvQtbLTq
         OOxw==
X-Forwarded-Encrypted: i=1; AJvYcCWbUO1Ti/8YS+5pRgNmNTFWFyWg668tcbKwkUkz4CplU61Wz3LFJGD1Goojx4ec9g5DfzVgEm2L2NQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyNnRLsZHUaJ3SzyCLgO+IRE7s1uyO41clGbSjKYEE5Xd8vGJ10
	keppAF5NDyPcFwc54s0kMyI9/EUzRpbTdLvhYR0d2bFlvO2yXId5D7iG
X-Gm-Gg: AeBDietMXHxV/w2htPSm78XqA5nEQfKVsGJo9ssan3oDXHNljmpy8RjNtjaeKUTm75X
	LoBBR/xvhfYCq0D3d5IlJIgMtDS9rWoMpRelDui1KyX8mueyko83trBirpPt4zv1zUOiKU/ubBH
	7HimJQ2ELATquALKBVy8i4+uz8bmoq1jqn2PPtv+TMgZptql2o69lFdtBPMyUlyHSjmCnErEdOM
	5FURFvD4L7mlppeAF0m2IQxXSujCMbMxjHOVB6fT+rz+BDzufRgIE5wSZHOgTvfpKDnsYOJN3xQ
	NCz+5Dmx1/aiSDWKJg0WnlWjlg/C/UwOhTDI//lSe6AWpK9CV3OvEc0vRwgsWRCw+VaR5wbcJWS
	DIAysRlpVZTqbBOMjKAze4DVZvFAlJxgsQUTwBQP/k7HrXyKXJffIxbW8KN78+uWfRcNrm4q+Zg
	aRDLUjjRXbFAUkdrQ4bq4iO00j7llu4MNSJtQfQLT5KxoxGJsmDZgXPsUa1mFwH7o=
X-Received: by 2002:a17:902:8c97:b0:2b2:497e:3f60 with SMTP id d9443c01a7336-2b2c7413feemr4012565ad.33.1775674493195;
        Wed, 08 Apr 2026 11:54:53 -0700 (PDT)
Received: from eric-acer (36-225-116-228.dynamic-ip.hinet.net. [36.225.116.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274979d5csm210859635ad.38.2026.04.08.11.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:54:52 -0700 (PDT)
Date: Thu, 9 Apr 2026 02:54:48 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: KobaK <kobak@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] sched/ext: fix cpumask leak in scx_init() error path
Message-ID: <auwthfgycbxkhqps2nzvcvqmuc7kpufxtbs7nstkkvwbexmpjd@6a2kqjtlnnt3>
References: <20260408172312.2178104-1-kobak@nvidia.com>
 <adaRm4qj6TbbAR7t@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaRm4qj6TbbAR7t@gpd4>

Hi Andrea, Koba,

On Wed, Apr 08, 2026 at 07:34:19PM +0200, Andrea Righi wrote:
> > +++ b/kernel/sched/ext.c
> > @@ -9662,9 +9662,14 @@ static int __init scx_init(void)
> >  		return ret;
> >  	}
> >  
> > -	if (!alloc_cpumask_var(&scx_bypass_lb_donee_cpumask, GFP_KERNEL) ||
> > -	    !alloc_cpumask_var(&scx_bypass_lb_resched_cpumask, GFP_KERNEL)) {
> > -		pr_err("sched_ext: Failed to allocate cpumasks\n");
> > +	if (!alloc_cpumask_var(&scx_bypass_lb_donee_cpumask, GFP_KERNEL)) {
> > +		pr_err("sched_ext: Failed to allocate donee cpumask\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	if (!alloc_cpumask_var(&scx_bypass_lb_resched_cpumask, GFP_KERNEL)) {
> > +		pr_err("sched_ext: Failed to allocate resched cpumask\n");
> > +		free_cpumask_var(scx_bypass_lb_donee_cpumask);
> 
> We should probably do a proper teardown of the other stuff as well at some point
> (sysfs group, kset, PM notifier, etc.), but this looks good to me.
> 
> >  		return -ENOMEM;
> >  	}

Should kset_unregister() also be called in these error paths?

scx_kset is allocated earlier in scx_init() and none of the failure
paths after that call kset_unregister()

	scx_kset = kset_create_and_add("sched_ext", &scx_uevent_ops, kernel_kobj);
	...
	ret = sysfs_create_group(&scx_kset->kobj, &scx_global_attr_group);
	if (ret < 0) {
		pr_err("sched_ext: Failed to add global attributes\n");
+		kset_unregister(scx_kset);
		return ret;	/* scx_kset leaked */
	}

    if (!alloc_cpumask_var(&scx_bypass_lb_donee_cpumask, GFP_KERNEL)) {
		pr_err("sched_ext: Failed to allocate donee cpumask\n");
+		kset_unregister(scx_kset);
		return -ENOMEM;	/* scx_kset leaked */
	}

	if (!alloc_cpumask_var(&scx_bypass_lb_resched_cpumask, GFP_KERNEL)) {
		pr_err("sched_ext: Failed to allocate resched cpumask\n");
		free_cpumask_var(scx_bypass_lb_donee_cpumask);
+		kset_unregister(scx_kset);
		return -ENOMEM;	/* scx_kset leaked */
	}
-- 
Thanks,
Cheng-Yang
