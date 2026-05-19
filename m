Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3463D967D
	for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176632; cv=none; b=acyNkqDJ1/8UIj8wP8T5KEhjrk7RQe0rHC3D4gxtxlp6SesLF0mwa5r6d/X5UB4cU7JR6cy0OZ4uXQtl+ydz19uzOmNI8vxHCLPyNsNDgC3m/jIvc4m5Tf79IkAsbPLAIh+qa50ltwOtkFQKlppV5yW9R+Bdm5UwMPKZCce38/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176632; c=relaxed/simple;
	bh=Ma73bIKtXamBlWaM/VDHafxoPoVAW+jzx6syH3yqYyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdi2VKHMKJsCVyIsM7mEc4fAKcUsBDSzALgeqQzQMi4VCNih9/xmw5O70tbS7Ta8Ip8c9dM75tRF68dvxzGrQkcjjU61RpKBkhx7sFWD2MpwYlbT+vmpgWaN1KKEbwpp4qJ5W24VTRuOFhKwkT0p5suRph5U/FuH80KgtZ7t+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L43oZxof; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L43oZxof"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36974221f93so1514684a91.2
        for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 00:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779176630; x=1779781430; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OYHCHqqXvael8k8ZlnLK0HvHIXLjQQYj+ItChZNwZ6U=;
        b=L43oZxofCx03xzllTE26wO2gvaKd/k9xH86sHorqd6X3Dpy0f4E10T92/ujOkN2y/+
         3lG1cRM1IjSYqAycJgyhHzl2Z9EwbDpaLxmoA9dyyGiLDt8Wywtfn216Jr+D8YAH+oF/
         2r4fO5V0ampQ/V5OvSJcCKBISCOuFq71+xB5mC7Ta0PgU6jGQSjNRD4ibbXHhXFm8hI0
         lTWSu6KRPJ/7QFVlbF616mGTfcPuUNJmVtFzWEn3Tm/bGD4D3Fye7HuxFK42965U77Us
         Xa+9fJ8k5WB0/tc5VAm9ZGtF3gnlFmCQSj/BavdUpvG2aEEOdUA39TodpR7kBkdRhgkC
         Bz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779176630; x=1779781430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYHCHqqXvael8k8ZlnLK0HvHIXLjQQYj+ItChZNwZ6U=;
        b=aJctzRJkaBXyb0oPNVi8t4tpg702cYR3EFdRrpHikPjy/EjqMn/24qx3e0eqEKRoHo
         p4L3svjZdErlLK1unPC6tShzjuyHCjgBsIS8eAXq4iWNjvlu8EXowSzlTBluplH3oOtR
         JTJhr13FSyoDjavKBXQHM7aEXBnR2U32/PblBhax9ihFo7elzzbNQh5DHYMWkS5We4dQ
         QqJ1ok8r+3E3cRn2qOg89/39fDCLY5gfIogr1ddj/NjHx+HIlRtZa6bbGoCdC1ouSaJB
         RLJkkEp0q7d2DGYYWowoHHAOtdHutz09oCsgp3i6PxLcGwDpFHGQmpgyiW+QKMh4oGHT
         bBHw==
X-Gm-Message-State: AOJu0YzjIUcI0WG8jYc7uKW+xuZzOyHuXU9tJUdSgktrket/BpdO9bzQ
	NYVq5VHp7CSnlzD6ADLwllmEf7eIRCPAGhqaK/ZwNQTk6JVs205jWO26
X-Gm-Gg: Acq92OH8BDv3CAswYLsYuvtGtsv4wfGMdAYlJDwYeH5mUR+p8y3GPpTv0F8v9GnhQhM
	asWVmxa/yGKeTRU4PrCdliZeOhaaaRttL3C7vLjFHCt+lbX0bvaQCfGoDio28pM/YOaPM5/2+1Y
	KFTusEbUNA+cdKTf6dOOSRhKqSLogdDXsfMNmrmuBqjycMQcfhe1cHX2wSVLdMWRKyV7ISZVrxV
	Pa1FPOPhK13izxMIH01GkqEz30tnulKxz0QJfoPEm5j8ZYM8dFRZnti5r9GQpnrdY9YXg7v399B
	Tzey/fF4iqtIRY7OUpx6vn/lgRdJ/6m7/Jvq4bd7S2JntMErIVmSQwlege7sokCVQUxtpFeJPOl
	x0uS1oWy/P3Jk+maxgBriZ/TmnfrC6/g5CY/BmDFHHh44orGJDxL+ZEQXbUva0ZwR26Jm51O0fe
	0bgdMKIx9hHm2wuTgRAOhxRvDByznqUhab/NyhuVhbQDTJbu6l4aqyRzSQOOg0nMA8g6ILxHc9x
	pBd3g==
X-Received: by 2002:a17:90b:2742:b0:368:cefe:ddd0 with SMTP id 98e67ed59e1d1-36951b82f8fmr19049211a91.15.1779176630003;
        Tue, 19 May 2026 00:43:50 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-116-93.dynamic-ip.hinet.net. [36.225.116.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369512424c2sm13554811a91.4.2026.05.19.00.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:43:49 -0700 (PDT)
Date: Tue, 19 May 2026 15:43:45 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Message-ID: <20260519152904.G1f99@cchengyang.duckdns.org>
References: <20260518131311.1170786-1-yphbchou0911@gmail.com>
 <20260518131311.1170786-3-yphbchou0911@gmail.com>
 <agtoyycMdwatAiFc@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agtoyycMdwatAiFc@slm.duckdns.org>

Hi Tejun,

On Mon, May 18, 2026 at 09:30:19AM -1000, Tejun Heo wrote:
> On Mon, May 18, 2026 at 09:11:49PM +0800, Cheng-Yang Chou wrote:
> > +bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask)
> >  {
> > -	return handle_lockup(-1, "RCU CPU stall detected!");
> > +	int exit_cpu = cpumask_empty(stalled_mask) ? -1 : (int)cpumask_first(stalled_mask);
> > +
> > +	return handle_lockup(exit_cpu, "RCU CPU stall on CPUs (%*pbl)",
> > +			     cpumask_pr_args(stalled_mask));
> 
> Wouldn't you want to pipe this down so that you can prioritize all stalled
> CPUs when dumping?

Ahh yes, will add stall_cpus to scx_exit_info, store the full mask
there, and update scx_dump_state() to dump all stalled CPUs first.

Thanks.

-- 
Cheers,
Cheng-Yang
