Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39493019C5
	for <sched-ext@lists.linux.dev>; Thu, 26 Feb 2026 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772087238; cv=none; b=EjjQwkYa82+kt8QpWEmsKiH4fi+d+pjlGkilusUH23nCkQnr/BTXL1SE41iAqnofyquAj5ZLxZLYEqleQBPg2M444u/bL5YNVYP27CFPN9VW3XCQxt5XlciydX8d/CDtSjKuJKUY8cqeLyMTdF5GOuaUO47S/Hnp3I6iNjCEJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772087238; c=relaxed/simple;
	bh=V/URV8nKD7ZsszJAD7IBD0z782oGqCPtdF1UfqDk2r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KX2n/zkwWwxgrhEfcf+VhHM/Bosgiwupl8+zx+y8tiCj6L48bgkFn8Sp86mj/DeAGgn+z7dZu02Z0zmQtM9xLZtKDZyjA8bVojWU1/1LOpA5got9kPyZbgEglBDerF0um/Y/5JcqE4YY40OIhQEZg62AdqiX8uuvEWmgqKXAaRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZA8GZN7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZA8GZN7"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6e191c4b8fso155614a12.0
        for <sched-ext@lists.linux.dev>; Wed, 25 Feb 2026 22:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772087237; x=1772692037; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAnOeScQcMvaXcoHPMASVO+b/3J2w21IHASqSSqMjxk=;
        b=aZA8GZN7SkY2AQa6H2JbEEv/Ns+tO2mcs1j1I+XoDBzAufFl3BcC1ZPcroGuLAxVpQ
         uBmRMr+XL8BAEMQyV5dsrfaoEAGP5F6ksDYwtQKqII2CvB8vInwhvWz2cwaGhJs6JgcV
         i0Q5FZ3GqoMoTxSBxTRtrPA7LOdQQbwGxorTtWwCS3Vrl6IdqKNELyPL2rlgVO5Lci8J
         fBj5+4lCtuJEScUcXD3m8jEbXLuU1IsoXTKgb4JlcwtvXMsVjFRIrI2NWHYPlrtwt3Le
         /QS+b4V7+OvAoPZAwbSjnasDTiUmiWHL2VdHDrEtjTH8xfL0DZnbyyMfzw/wRtjAxANY
         /vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772087237; x=1772692037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAnOeScQcMvaXcoHPMASVO+b/3J2w21IHASqSSqMjxk=;
        b=cPF5Q0YPHEVz9RQW1cidG2zZR2+U2WhoUeOeI6iPBZH0hb3ZnRk1iYEjNbEK7CezEv
         6ui2Q8cfAT/rlb6SI5LtxPz8a2nole8w3C0lRR72yr4/R7sm5mJfoPY8DSKAwyb/h9VI
         zgyrCUishsgtsq0uGr9YBUJOerWMq4sI2knahNOKb1gwbGBAq3G9iYNAwNcEWcpnAiXC
         Ro3qRbj5p4TGTDtXx6oxWXo5LoZmoLupumRpLAZrnWnuAAinxbM7fkqUI0HMXi/lHsPu
         AJpdLHqCvRWoDKDRbn9Q32nPism6RXJJaAFpY+3lE35hVoAoSGvbCcqCMSjY7gv8RoDi
         pT6A==
X-Forwarded-Encrypted: i=1; AJvYcCWUqqwgZmGnCE0b9A6bPnrPIRRIQUPYpCJ7nuUBW+YUB897Gksj+KJmnSC0uiH0GlNI6fMaXBU+S6E=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw487nOwVPwmwJUklk8EDn80XJdLvX4KTcmqYGCTiPXu39JNLv1
	CoSxD2UnLA/BgH3mSuNkK7DpzrEfm4OmJah+AzlL59nChuGuG17tr6OI
X-Gm-Gg: ATEYQzxzVV4Y1+Ru8YwXP0/3Q3286UN2eXdKxIyoFG9PRm0Tss0tfMqHwDsg0zJtUYO
	f3LJlftcI3S16zy8K6kz1KaBy7XAjkEgjwkOYzkvr5IxNb3D2G7l8b6M/Zv4ww8u8Pei/2Fe03S
	ddP+7sOIAAxdbSg+brNVZZ7yEivX7F3KqwO3qjYgTQDIZ1Hwuj02PxStGF9rJJilAGptsw0cvxD
	Yr/HO09T2l4WN5hLhDPpXfdpksF1svj64Y3WoC70zZZtwbNA2gfYPp4GH5UUCcNhGpfHKWcce5e
	CrtD4717Hk/5xfjbP7Zs4inNCzt35Id5vDcfSYn0DTVNtvPVKiRXnegU1tHJRhRPIJLcRk79Cm+
	llxqFRcQgumX7Pg3BSahbkGGAc/AHvavYWZO0r2ya6+IEXel3ZqcRmTJxWoCQGqIfskBI3g/GWD
	iqfy9Tyw49bjKHzQTvxCSIPqbxhaOkVXiG6npWM/udnaZ3U1RDpJdrsdR/aMG3
X-Received: by 2002:a17:90b:3c04:b0:356:2c7b:c010 with SMTP id 98e67ed59e1d1-35928a916bamr2602236a91.11.1772087236962;
        Wed, 25 Feb 2026 22:27:16 -0800 (PST)
Received: from eric-acer (36-225-69-192.dynamic-ip.hinet.net. [36.225.69.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359019780bfsm4876566a91.8.2026.02.25.22.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 22:27:16 -0800 (PST)
Date: Thu, 26 Feb 2026 14:27:13 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, sched-ext@lists.linux.dev, 
	void@manifault.com, changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] sched_ext: Prevent null deref in scx_dsq_move()
Message-ID: <hu2vijz3uetqpsj4lxc2d24fph6uo6sawishzzewwn3fcsjyk6@c4sd2zsj4272>
References: <20260225181624.427916-1-yphbchou0911@gmail.com>
 <aZ89Tyy-oQ7skH7z@slm.duckdns.org>
 <aZ9Cd1uNC5M88jdP@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ9Cd1uNC5M88jdP@gpd4>

On Wed, Feb 25, 2026 at 07:41:59PM +0100, Andrea Righi wrote:
> > But sch is from src_dsq->sched. Can you describe a scenario where that could
> > be NULL or do you have repro?
> 
> Yeah, scx_dsq_move can only be invoked from scx_bpf_dsq_move() or
> scx_bpf_dsq_move_vtime(), which in turn may only be called from a BPF
> scheduler callback.
> 
> If the scheduler is inactive, this condition should theoretically never
> occur. Even during teardown, all tasks are migrated and no CPU can still be
> executing a BPF callback by the time scx_root is set back to NULL. So, I
> don't see how sch can be NULL at this point, unless we have a reproducer...
> 
> Thanks,
> -Andrea

I added this purely from a defensive programming perspective, missing
the fact that the teardown phase guarantees all tasks are migrated
before scx_root is cleared.

I don't have a reproducer. Since the architecture prevents this
scenario, the check is indeed unnecessary.

Please drop this patch.
Thanks for the detailed explanation.

Thanks,
Cheng-Yang
