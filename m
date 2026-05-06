Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460DE3FBEDF
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062699; cv=none; b=QYqEU8hy7B114NOhPLA+USUknCLBpATyCGuHdw/UMp4ISTQ5xVLwp25Euwd68mmPb15tgV/an+axoyEt0ZPd8iIrPUj07fjAnUOVn62TMDR3zAvqw+pg3K/s/3a0K6OkJLZRriMz01n4q3wWdWgzVdAimxXdH90rac91cAFs85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062699; c=relaxed/simple;
	bh=11SWNtf3rfJVUf5eCd4VWE6+WLjXa5rsIqGFz+UaHxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSsJMk0iwX4gqnbJg8+nRQToPy16FXJwF8b9YoS+4c42mAilIPi+yHmuSViO0K+D2MnQRXqrC9Lh6lwKmviTgStp74ncash3xDTyfVCCai+s3BQuyZ0hO6uKKpkNlZqi+3PBcj8MC3KweUC7SbJlnbm9vC+d9yhJ7BdKmepoEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sk8iTg+q; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sk8iTg+q"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8028fa6039so2150653a12.2
        for <sched-ext@lists.linux.dev>; Wed, 06 May 2026 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778062696; x=1778667496; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mDZ4pUw0CX7S4gau2UFJHmOf0T1JHQBK6QOlQZ991TU=;
        b=sk8iTg+qadG4LU3t82o6zZhNZKhH9/zpQGdcvSu/shj0ZL1xCg79rPnDEFMWJvNZqg
         Qg6NZpsSboA8ZpN76Vl2Zs4XIyIqYhIDptRo2kvfU44mA+/ooXNRWaDHSgiGgvxH3/Of
         g/PotMXexcuJbTe9bH0hLs4Xg1eRxRO+p81hduK72qRjrBSckVm4hdxl1c68eba3vYSg
         YfZEBzAe+2Bldf/e5hmh9E56l9TtWEIOHpkZdPZuQqQ0h29Lpzx2eHLNROeRQP4DkEKK
         TUcfgLc5Z/q2F39mVSk9A4UV1lRvtnPw0GKVWzMrTtVEuGL8B55h5fXBY0R0euqeuhpv
         0ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778062696; x=1778667496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDZ4pUw0CX7S4gau2UFJHmOf0T1JHQBK6QOlQZ991TU=;
        b=CMopZfkoLtP76HECYxlx71dLBsxsBcAoBS65z777jsHU0GwrWmeZr32unbOTyNxcsF
         ez3N8rxGi976EVQ2f8FxGxpNio8cuu84LJ0nZC7z6DTBEd5Zx/Hfs1rAKoecEddsfOU3
         tJkRxrCfMKTlPTOfVDfp2Kkpxsg1hX4PrEJ8/Z2mwW1mTR6FhjxMzfBScoCfbIAC7yIZ
         pBYDM1+ecs399AeDqTOVWKG3oKO48DY9BBCuq6KcuozjeMbITOJ7pM2Fq4e6JVxUIsWW
         siheDXANTtyuHW6MlPlSlZGNlyGq1NNCorUZWByRpgwwA5ga8YN8JobOZ9UMANUcLw9X
         ocLw==
X-Forwarded-Encrypted: i=1; AFNElJ8QYi9Bbz475ciAG3LVqlR2zqax2mTtgbB2z9B16TSgQH81kpA6+9A7o8obmFMJu6OXPtfl+TRd4Mw=@lists.linux.dev
X-Gm-Message-State: AOJu0YwVgNguJUcP+xWMa/h6mKICht36bAzhJzKabnih56gp5DSm9vcV
	FNyx/jgg3CRtZLLU9x2Wm8kX33Z0PypDmO7DfTtlZ3Fk1OQwF6gJ1JBL
X-Gm-Gg: AeBDietie2OPf8RcxrUo8oVzb8ALqVIvC6EFERCsxJ7+G/1Iam2FUQZdFTIXgkVH5a4
	9uu7Brs8K9zptJPbup9To/gqAyTXM7d4ghENlORva/1Gf8t3K1wDatqJy8NohSbqDwGBaaBRYel
	XixZyBaMBFkdzBL+HuyRUnCRvyOnIF4U5j7AU4DB5tcKAEFwRDcD6l6509zbYlg2hWWRMmMHeVs
	wycts0aPz/X5yDOohlRBYxkEADvJ6dAK1eVON/100nrktCcVPEADvRXqNnmrusBgTf9M/q+D4HD
	tP2mSfEyg2M9y2iP7r3EQn9wXBXDC8pf57cdfLhktHzP7jxfGYRI61isexNTziNMPyzsYuR7xDE
	PkK5MomSqlagArg7m8ISzO6+m/J8n+vwnnNt5KWoQEo5Mr0fHsfvju1U8ZmGOQ3E0kIQp5Yu/Yn
	BHiEa97xqUito8OkcjVaSbbRGifnieMUrGsqEg/6Lxv3rNCnKWYkTo5n7KnhOGwsDkRpwV4BcWm
	rhjCOczcqfWo/Ts
X-Received: by 2002:a05:6a20:549d:b0:3a0:b781:4c78 with SMTP id adf61e73a8af0-3aa5a8fa74emr3005470637.15.1778062695961;
        Wed, 06 May 2026 03:18:15 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-99-238.dynamic-ip.hinet.net. [36.225.99.238])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8242cc1768sm1804956a12.32.2026.05.06.03.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 03:18:15 -0700 (PDT)
Date: Wed, 6 May 2026 18:18:11 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, sched-ext@lists.linux.dev, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, rcu@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Message-ID: <20260506181409.Gc6e5@cchengyang.duckdns.org>
References: <20260504161543.674488-1-yphbchou0911@gmail.com>
 <20260504161543.674488-3-yphbchou0911@gmail.com>
 <c402160a-dbc6-4292-a684-395a80d677d4@paulmck-laptop>
 <20260505154006.G743b@cchengyang.duckdns.org>
 <afmrgVdEHKF0FbNs@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afmrgVdEHKF0FbNs@slm.duckdns.org>

Hi Tejun,

On Mon, May 04, 2026 at 10:34:09PM -1000, Tejun Heo wrote:
> On Tue, May 05, 2026 at 04:20:25PM +0800, Cheng-Yang Chou wrote:
> ...
> > > There might be more than one stalled CPU.  You could pass in a cpumask_t
> > > or similar to print all of them, or take the first or the last or
> > > some such.
> > 
> > sched_ext's exit_info carries a single s32 exit_cpu, so we can only
> > record one CPU. Would taking the first stalled CPU be acceptable as a 
> > best-effort hint, or would you prefer we pass -1 and skip the CPU field
> > entirely for the RCU stall paths?
> 
> We carry only one cpu in exit_info but we can easily dump the cpumask and
> prioritize dumping all the cpus in the mask.

To confirm: are you suggesting scx_rcu_cpu_stall() take a cpumask, use
cpumask_first() for exit_cpu, and dump the full mask in the exit message?

Thanks.

-- 
Cheers,
Cheng-Yang
