Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7130DD30
	for <sched-ext@lists.linux.dev>; Thu, 18 Jun 2026 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765770; cv=none; b=sHSMD9BF38sYz9utrW4bsJmwtAKZ9gFrXLBAxTS8jNV1hewP/XADEocPFYiuVtUjM2/VT1KHMwdT8hjhH9kzbjmxXYADFlS9vB4Ds3DBxuR72a7q7AjD2GGvQ0dcCU7f0YYA3ntG+28tN4N+KEKkRx960vggKLqANGPt5XZSJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765770; c=relaxed/simple;
	bh=Ge51/Fa247w4qatZwAwqghySFPUWr0IpTDx18YkSsDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKfQY2znY+XUocc7RzHWDt07YADTT6sMLe/wthYONMsGymeJukkFID5DcgaqyOKrky4diB5PfZq1xDWk7vwXPDgwXX5y8UU7tenEktMKLMIN1dGMWhdTHUvjtTb0NhB4WIemdaXYIHkPf92FXplAsLW4vTdgj+VCAbqIjPPJSMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=caxZvHUI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="caxZvHUI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so5340095e9.1
        for <sched-ext@lists.linux.dev>; Wed, 17 Jun 2026 23:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1781765767; x=1782370567; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mqo0Z4bbyEL/S2Ts4wZccNyu0EnvuTridAOzOQ1Lq70=;
        b=caxZvHUIKCgTCeXsXaHJK6g/CXi2Dg6R+T0ZqhMNJhk3+69AqsgerjMspSCp0U6djw
         JjJvRe/9nl/NWqGgrkX8BzeDJ4BgS9ba7qjEIEzuWnsAN/9+T/5ErWwyuLrBEdPeT65M
         +QeV/Uy2nmMA+m9wi6xmXxbG7W7mhZR74Twe0irytkUJEuU989EPJhBKiRMV8Y4VamkX
         FGZXwI+7bxVrpUaeixAb4JH3ybaZOb4D9IOFL3D2m1PleAUQfbDgxmorKYcaC6vd1hpY
         UNY8YUisU2gChxhg1+MQHFHpI73/1GX96cTXBuokIyMK27rVtDLi//FZVjRw2a+FTeFo
         YTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781765767; x=1782370567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mqo0Z4bbyEL/S2Ts4wZccNyu0EnvuTridAOzOQ1Lq70=;
        b=EGNLA3swXV5sMALLe7G3aVTklrYXns8r3NtWQSqfsZCUwP3iFI0B8RgwLcGnIw+VyF
         edurCQpi0qPGNv6FeUHn5WVWR1qA5YzkT+sr+laJ+2PijpvL1P5u7nvKzXLYgbhUfdI6
         +4vq7hFX5foK+3mTMBkYCAo4hMlbwzppDAVWUMnS9BUKAFdBjAg8a1O/8Ko33kHrbYvr
         Nxn0S9SBHV58nffeD164nPI0Iw/vlGjtkkkWYndB/NLNXTVmKeaQuNa+2x5atJp9GHXa
         GhqWN0plOn8wAG5oeEFy3sJzpub3RGqP8lNdOSIv34cdXkqx0Z/i4M+2FetCa9x9dQGS
         wtMg==
X-Forwarded-Encrypted: i=1; AFNElJ/caEAlkkOc/EXskzCuQ1Ez0RqcbsrOFOQ3nugUKVlPBbxzcdYAKg4hPEal1eC5dbOQ2eqWN5l4/wU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxiFdQB0FpB5G+nPVz8wsceYGkHv24cx9ps6IeSh9yHD+ruvvh4
	cP+86l5RMzxApgnCDHZRkqHk1RxYV1b6suW8WpI4shBEHrTmrGkMh7mtKCjc/vca0Ss=
X-Gm-Gg: Acq92OFrhJ88OboIPOqJDYhwQXtuZiueaNF2LB+wQWlXG8qFNx4JJV4y3cCKKyADl4N
	XRdA6II6FS3tmQMmt1/scpWDDEAK/me9hsNuo9RTzbD4hs7X+6u8fNOS9g8cECJg+IkZqq8LqC5
	WRsfsNrOYMvwLDHnj3evY3kdu810Q1v80BcaNa3hQ/4A29jlry3CXQp3stbd+mue4n3l837+LsD
	I4HOckRy8G36ogjp7pfDWml5BbC2GEnPCTxITirb0zbk+FbAW9IOE68VsHg8Ti7HPImgasck33D
	IaJOIGZbDIwbrM3ySYudYn7iH4z/m4KWy9VcdkWXoQcBYCjYlk6wjNezx9Y3lZxDvMmy8MF1pbc
	bwOYF5reU2r4KEs/EcFWrrGVNq2t0YjcLnQqYEMo+156b9B8z5ZHg0vhYypOWfeN6B5giRE2/gS
	6uNqV4pBIYJgZJMo4/Hpk=
X-Received: by 2002:a05:600c:c494:b0:490:e190:38f3 with SMTP id 5b1f17b1804b1-492341275ccmr101004155e9.21.1781765767044;
        Wed, 17 Jun 2026 23:56:07 -0700 (PDT)
Received: from localhost ([104.28.20.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-462e7fc53fasm9610061f8f.33.2026.06.17.23.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 23:56:06 -0700 (PDT)
Date: Thu, 18 Jun 2026 07:56:05 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: sched_ext/lavd hard lockup in old call_rcu_tasks_generic
 needadjust path
Message-ID: <ajOWZ3JvlmihMNAH@matt-Precision-5490>
References: <20260609104733.1184001-1-mfleming@cloudflare.com>
 <2179fc11-3bd5-4d2e-9ad8-609e3356ec09@paulmck-laptop>
 <aiqxpzgl2YVVSARw@matt-Precision-5490>
 <1ad83f53-7897-40bc-a503-5a71031aa27f@paulmck-laptop>
 <aivaGbCzC4oaD05n@matt-Precision-5490>
 <3bbd4298-eb01-4784-bee5-caab3d3647b9@paulmck-laptop>
 <ajErr_GEejCD7n47@matt-Precision-5490>
 <35337ded-add4-4689-8f61-73f583a69b36@paulmck-laptop>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35337ded-add4-4689-8f61-73f583a69b36@paulmck-laptop>

On Tue, Jun 16, 2026 at 08:24:55PM -0700, Paul E. McKenney wrote:
> On Tue, Jun 16, 2026 at 11:56:19AM +0100, Matt Fleming wrote:
> > 
> > What about something like this?
> 
> Not bad, actually.
> 
> But we are going to have to similarly bypass call_rcu_tasks_generic()
> soon enough, though only when interrupts are disabled at the time
> of the call.  One complication is that it would need to interact
> with rcu_barrier_tasks_generic(), which would need to remove any
> pending callbacks from bypassed call_rcu_tasks_generic() invocations,
> as in llist_del_all() and enqueue the callbacks.  A well-placed
> raw_spin_trylock_rcu_node(rtpcp) should suffice for the serialization.
> The trick is that rcu_barrier_tasks_generic() is not obligated to
> wait on later calls to call_rcu_tasks_generic().
> 
> Is this something that you would be interested in digging into?

Sure, I'll take a look.

Thanks,
Matt
