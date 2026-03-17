Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4129B3F87E3
	for <sched-ext@lists.linux.dev>; Tue, 17 Mar 2026 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774014; cv=none; b=uZuqQtJToQgS7Lt42FPPoynF9JRVVt85l75nwPFA5VTOroR8Xj/iaS9v/KTtGd71ks57W6N5EApywRx51dAd05l22xytEAS4LNT1cQ9KoOuPrszYaliCxuVdPKwyIWoHZrh5XMRP0Ka9QWCfLKktGmJZH9O47gWBu+1kyp8kkNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774014; c=relaxed/simple;
	bh=+CgfJ9RBiuV2rPgLoIQ+yE+aU4+Tze5Fjgl1DQgK4BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ic9rSh0GBzN1S/Nxqph9KZJoBcxjjSN5HgcA47H2LafB8lGc3w/tUaCnOQaEMeicT0DeuWMRz5UoocTJusxTSPm1oQNr4WSDj41hNELgFBPYf29xLJB+gM6eaSahxog04GVrkQr87s3+4DnXY+PNn6JdDDnwC9DvNy8cFd2zrpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLL0FmiO; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLL0FmiO"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso12597a91.0
        for <sched-ext@lists.linux.dev>; Tue, 17 Mar 2026 12:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773774008; x=1774378808; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fstb2u/6CRJ4AK8KVrZwe5DLGJL0ghEqvXfcPF0Fsdg=;
        b=YLL0FmiOdQQ9qKJqa5ASpkuQTazqicI34Zh13D84LcXkeQwzmLDIL1V5pQelsJ8c8u
         515EQW86oRcTHgjFV0sFPU5fSYIg7mX6wXN83zUTJ3C6ofaIrejWJmuUsi1qzr8lpAPe
         7W0OeK7WZArkHftWE3NCRPVDnOcikxIO8KZ5mEkouSLcj/IrwTEgDmMUce8JLh+W0q4v
         OGaFXhOVWhruP9BELddR6EP6jUG7pDx7vZ3cDML5TX8SSX2OUqYtqM9CcN/o0LFVNmij
         TPywYcC3wN8hTWtN9nM2GcMlC9pjpLy1lip+pi/M9OsuSPR2f9Bf/NbA2yhCZM9UBrlj
         Yi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773774009; x=1774378809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fstb2u/6CRJ4AK8KVrZwe5DLGJL0ghEqvXfcPF0Fsdg=;
        b=LutLd5R/g8lWVGMP3Z9qQIFBggjx5FN3/s8RiFKy1gUu1dk8kpDM+emLsazImgZH7i
         cNbmSlUrBTJDD0EBU/pF3vUzfMRzWQb+v/TJO+6avooGkjFPz0OgDHIiE6eMw+Q/HnA8
         5iwUa8Ku14U0Mf2WTVRBOg2fAujx5J+9XY/bQXSu+W813tM3O4ZcpFC5rxlAmbrYHlEn
         JjFsyzNzKG9BI2HPAJdRkiObUtN8sHNvjtVtWfaXHS1J5CDs33tll/HYIf32EiMgO+85
         lfL44vG49Y5+/sUIMMOhY2VM34mAnOGsb4XGGkj3/wYTygV6AfdSQXImaOPzRRMct2dT
         mgaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7upuqcq3kn3kWx7YfbI/Iytu4aRPqOxv6IAz0lsqEAB+S8FaL8nDOgBXWFNWctpsGygsre4dCCug=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywebq58qM9Fu7QiduTD5jrr5ejU1YLUg5hDUbq40R7lxM5229rL
	EyMQm6Y88g9ZxA49yXkzEYs0PCQimZwnOV0zKjlDmeQYx4/OqM18nWM2
X-Gm-Gg: ATEYQzwQ+8bNwLpC5/uPCiUuMb+0IhbTRH5i4JPLXNOP6biziB1U/PRrtB1A2bg2nMC
	F0EBnGGFtD8sRXp7y/sQI/gcpmxcXuOF3OLwh0yX+0bvfr/+8ilZfnbwTZeglAIOJmtzG7xU4y6
	wnW/DT5XM5ELWri2en2QbhY64A4/5FvPvnWuf5sgvJ0q2GqPs+fKLETrlEVDgRQEknBa92XlzTt
	m2d1Sz91pNjC77D4cSpKoQKCnOJQEliDwiBPWpsqAfo2Ex8PIF6c3QCDty9ttNu4lBE3otnhb3p
	ZGeRx0Bgxf0nI5JCj/E6chjsKbTOi1GGTGp7n/O5INjCmVSFIbbTOwrv83kisfM2hQiU8ODNLoK
	8uJp2WTWX/3dINHtL52/DBD3MWq1WtHQgGVw9jkUrA9chwzlhxh09a7BBQdvrKXORBxpMZStEyf
	rYczuqKT/Oe1CGLVzY8qd1Cr0FA/ZXij7aiGydRvT3/K0o58wmhJU06Q2Ryw==
X-Received: by 2002:a17:90b:390b:b0:35b:947d:9fca with SMTP id 98e67ed59e1d1-35bb9f2fbc8mr384665a91.19.1773774008234;
        Tue, 17 Mar 2026 12:00:08 -0700 (PDT)
Received: from eric-acer (36-225-83-37.dynamic-ip.hinet.net. [36.225.83.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35badbcdaa6sm3823328a91.15.2026.03.17.12.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 12:00:07 -0700 (PDT)
Date: Wed, 18 Mar 2026 03:00:03 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, sched-ext@lists.linux.dev, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, 
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 1/2] sched_ext: Cache per-node NUMA distance order in
 scx_idle_init_masks()
Message-ID: <ua4ra252uzkhot5sj5t7oetld6wdn2pyjihwo25n5bkjxrkefm@qwaru4uuwr24>
References: <20260315181017.1377138-1-yphbchou0911@gmail.com>
 <20260315181017.1377138-2-yphbchou0911@gmail.com>
 <abgnBgO83uXd7Xq-@gpd4>
 <bwbqaaeptqcjfuotszesmckmkept2o5exdkbn67nx7uz6bwilh@mlrjlhh4ovzi>
 <abmQRgwQZhZk9-_S@slm.duckdns.org>
 <abmXJGGsb9dnpPzS@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abmXJGGsb9dnpPzS@gpd4>

Hi Tejun, Andrea,

On Tue, Mar 17, 2026 at 07:02:12PM +0100, Andrea Righi wrote:
> On Tue, Mar 17, 2026 at 07:32:54AM -1000, Tejun Heo wrote:
> > On Tue, Mar 17, 2026 at 11:04:11PM +0800, Cheng-Yang Chou wrote:
> > > Hi Andrea,
> > > 
> > > On Mon, Mar 16, 2026 at 04:51:34PM +0100, Andrea Righi wrote:
> > > > Hi Cheng-Yang,
> > > > 
> > > > this has been sitting in my TODO list for a while, so thanks for looking
> > > > at it. :)
> > > > 
> > > > Comments below.
> > > > 
> > > > On Mon, Mar 16, 2026 at 02:10:14AM +0800, Cheng-Yang Chou wrote:
> > > > > Add scx_numa_node_order[] and scx_numa_node_order_cnt[], per-node
> > > > > arrays that store NUMA nodes sorted by increasing distance from each
> > > > > node. They are allocated and populated once during boot in
> > > > > scx_idle_init_masks() using the existing for_each_node_numadist()
> > > > > O(N^2) traversal, so the cost is paid only at init time.
> > 
> > Wasn't the conclusion that given the low numa node count, O(N^2) doesn't
> > matter for now here although I can see node count becoming high enough with
> > AMD fake LLC NUMA enabled on an actual large NUMA machines. But if we decide
> > that's an actual problem, shouldn't it be addressed in the topology code
> > rather than from sched_ext side?
> 
> Yes, that was the conclusion from the previous discussion on this topic.
> Honestly I've never seen NUMA system where the O(N^2) could be an issue.
> One thing that I like about this change is the removal of
> preempt_disable/enable() when we iterate nodes.
> 
> However, speaking of performance, the O(N^2) bitmask iteration on a single
> nodemask_t is probably more efficient than the O(N) iteration through the
> scx_numa_node_order[] array (it should be more cache friendly). Ideally we
> should run some tests on those big Intel NUMA machines that were showing
> the bad regressions with the single global idle cpumasks, but I don't think
> I have access to them anymore...
> 
> So, thinking more about this, I'm still conflicted if we should apply this
> change or not, especially because we don't have any performance number...

Since I don't have access to large bare-metal NUMA machines to properly
benchmark the cache-friendly hypothesis versus the O(N^2) overhead, and
considering the architectural concerns Tejun mentioned earlier, I agree
it's best to just drop this patch for now.

Thanks both for the detailed review and insights!

-- 
Thanks,
Cheng-Yang
