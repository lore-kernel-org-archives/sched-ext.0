Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E03859EB
	for <sched-ext@lists.linux.dev>; Fri,  5 Jun 2026 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670012; cv=none; b=kD4JCJGFp/Ojj4fCgGaeUxzGGPzvWguVWEyosaRIO6PlkO/UdhYFev6W+IXVJmvKntx/IF5BHq0R91Z5/6wAACVTs260vRGtO6/hBUoYo+cZilWRQXkrls8UtaaqlGUS9+/SMZ4SnBkJNKNDRmEq2iadl7YFw7w9TU7KiK+QMYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670012; c=relaxed/simple;
	bh=lEPb8QCE5aw8R5/q3CiaERnDfjzcpKrKM4kCtHSpwBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF7ouD2+JP0RUru9Wv1RJzYCEKWr4+7puyG9Z2gPxdXgbl9IU6drxYREQn20AbyfG9G0PrtXYWHQ8wblworh9y5lrRqlFfW10B9CM4nIlhYewqm4064xfwqfIgE6ltS/T16uwGMA9RQe7uoenfFaOjM+mUkpfxCIkUXm+b+lJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXVynO7y; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXVynO7y"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137dd3af345so1874046c88.0
        for <sched-ext@lists.linux.dev>; Fri, 05 Jun 2026 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780670010; x=1781274810; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DYBmRS0ychjc3ot497BNA8iEuuGUaJ/uihQW0fCPGsE=;
        b=fXVynO7yixpqadOHK8GqJqzKkaGzCZXhxvk7EnWIKXGWN8gNLopfbruibWoUaV+TO9
         82Y+g2FOIZ0fWKW9jmTgbqMktvXcdCms2DH+Fm4HS2OnHisfTlq8e5RtX6t2MJfZqJlr
         /fQSQnE9tiOl5JyVtvF4nAe2qFH9ibwrZA3EGd23KUxCTG1P/7e95T03hnQvgrIpa0G+
         vXyJDftv77Cr9wcKkVJ5ah16XFoEFe6EqhlGBeE+Xg4G0lWGQkWidfH3tgXt+3G4VZ/T
         X34zM7kpvDc8WH6Z7E2Oad22nPoAzMgBogm3ulhHi9taQh7MTstAVJcEAu1nttAaKSYo
         cdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780670010; x=1781274810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYBmRS0ychjc3ot497BNA8iEuuGUaJ/uihQW0fCPGsE=;
        b=LDqnyO89JwFjhzb68LKCbaK82hywp+DF6mCWl9Tv2xMvNyN2qEuuycJ9hgKqO2Ut31
         muyGGyV/XRMpSQJwyUyFDc5iszTOjduOLfG2mXJsTRyEmG7CkAQOXca9Vvg8dWQbs5MI
         YpTSYPP/P8aMYbEOuPvjvTXUgJ/LakIm+nansulIR6M2J9tQa7WKzHV7oqQq7rFpkW2Z
         R3uDRbgCIt6jL3eSKLHIcsJ78/RAdmFTh4hJHftu8+R6II5eOm4gxDAtrpuCBjWSSFD7
         39+sQf99SdDau2OwkqJnnHLbhE0fMKhGSRGH3IoKvfth15b1y9HYjaG8xymaou6vB3pJ
         zwyQ==
X-Gm-Message-State: AOJu0Ywdi1TTzzjZibBpxmnvDgJ5qicqOO4bZW+1BBQR2sHI9ogpxzTW
	2YLPAxKIvsqGmxNz97u+vwYecEjcqxhvXovGUOl1Hno66j2RW8b2/pco
X-Gm-Gg: Acq92OFesVKWRIGlwD+8UrnnsSGTsJni4656j99PUlChxhXKEKp+zx+p8ye5ZDfADNT
	aHv795H+Y6Op1CXceIXM7/yIuaWrbJUmkBHoRTZg0QsSVBmdKAxKxwHNXWkA8w0h/0xznlCFoHK
	HpwwSS1SpWszuEBYkZMG9ksW7B+mtgfHOgEMnFLzZWjLw0FyVXjoZjCN/3r18SzOuJ5eHbEJS45
	dy8Vp8wrLFKzwYT/V9uWb9wrxvryumKKtS39rIt/zScodeqLkoE2+yULrwW2wVN67rpd84e2l58
	z+TWv5lKqyB5M8tsE6o1+K7ywE1+YKIioPbMuTZ1hk/Byaps80YtliyJtGRF7YL3pauIoFSCcHC
	FHchSEk4GDx4Mffx5cJMZJPvWXHwQPlPUQJvvALa20eHShwJEf4mfrU5hkSmmMzkPngg5ZfFsUA
	VRw3qzXLWujJduk2nM9fkrZC+CeW2VdfzmFtDm8t6SP8XgJaPI78cudOLRvgkPd4CQj+X2hdvRV
	IjlAvTl+1pYFOOGYjU=
X-Received: by 2002:a05:701b:271c:b0:134:ff2e:a71c with SMTP id a92af1059eb24-13806684f0amr886935c88.9.1780670010297;
        Fri, 05 Jun 2026 07:33:30 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-226-194-119.dynamic-ip.hinet.net. [36.226.194.119])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f54db05csm6106066c88.8.2026.06.05.07.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:33:29 -0700 (PDT)
Date: Fri, 5 Jun 2026 22:33:24 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, rcu@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Message-ID: <20260605223156.G3249@cchengyang.duckdns.org>
References: <20260531152646.1206799-1-yphbchou0911@gmail.com>
 <20260531152646.1206799-3-yphbchou0911@gmail.com>
 <14ffaa7d-1033-4cf7-af32-f1120f1f523a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ffaa7d-1033-4cf7-af32-f1120f1f523a@paulmck-laptop>

Hi Paul,

On Thu, Jun 04, 2026 at 10:57:38AM -0700, Paul E. McKenney wrote:
> On Sun, May 31, 2026 at 11:25:27PM +0800, Cheng-Yang Chou wrote:
> > scx_rcu_cpu_stall() previously recorded the detector CPU rather than the
> > stalled one, and the expedited grace period path had no stalled CPU to
> > report at all.
> > 
> > Thread a cpumask through panic_on_rcu_stall() and scx_rcu_cpu_stall()
> > to capture all stalled CPUs. Report cpumask_first() as exit_cpu and the
> > full CPU list in the exit message. Task-only stalls yield exit_cpu = -1.
> > 
> > Store the stall mask in scx_sched rather than scx_exit_info, keeping the
> > BPF-visible struct unchanged. scx_dump_state() reads sch->stall_cpus
> > directly and dumps all stalled CPUs first to avoid losing them to
> > truncation.
> > 
> > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> 
> From an RCU perspective:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thanks for your guidance and review! ^0^

-- 
Cheers,
Cheng-Yang
