Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE2739526F
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346817; cv=none; b=VDr3kuiupvfpko9/p6V9IbQeuZJX/uLNsyAHepAzSJ93DiDubbVkWGXBTdAAqsGSlE3V4kM5RfxB6Kaa/gy7TYzLQKzRQSeotnepnX+kcOhcPhzlgd7SRE0GWfFv+HvP+NzL2aAkarMoz47Wzy7IPbuU0AA+2rBMY2XBTYPYBEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346817; c=relaxed/simple;
	bh=d63X+oFfSjcaBWqshGJfwLycLFMBJZRpHEnPMCuCVxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bADqEM7CoIkVu2+6IDZhn/c4Lh5DYCum3b1OMm/IWpWb2VsZLb9cMrEdM/zutcrBPE6VG7f0tNUBp6FBkR1bl6dpiNTlfkbWkhumltdA2FUJYwyMIn0ZzGNvs4AP61CGqGpEwoAS0Tph9t0w8tmPELM9Veq2hcYC49tPmRjNgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbqEAVXe; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbqEAVXe"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-83d5bbef760so2473973b3a.1
        for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779346816; x=1779951616; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hhUj3jZkDnmmSfY0KCk0TW5FKcGtMJ1hBup3liDLW4=;
        b=AbqEAVXeLobOAI4zPIbhiNaON6UJmnFa+fatt5CWyHeciv29rt+RJS44HezWSpm8Lz
         z4DRAY7iHrra6yviXdybV+Boo7CU5ePpZlzAWnBNfSf2PhQTK39lSijTsISs1L2rHeub
         cXsCWxmKEoi9Bj+yoJfnru9mq0CTDlEBPSjt4jt6iNL5LShMlMPZ6yERxfrvTVX8k1b2
         n0bof/xj6Uva+EUsQAXw5x/8Qn0+ZSOlNAtEs3GdwtYBkZJR15Sh/BUfbUrnnoHhm7iP
         g9caKolANkQV+CnoqZqxcxmqMgKvKqCPLfpTCEC4nJprpUGyyQ42TvqgonXkDWIQKCpV
         47qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779346816; x=1779951616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hhUj3jZkDnmmSfY0KCk0TW5FKcGtMJ1hBup3liDLW4=;
        b=KpsdOskBDgcZxmhZuN797eYVPz+PHGlwInYshNfv1fX3IF7f+w4SFMyOgVfeWz8gKX
         FEQjH1TlFrkRY7UUIkR+hCshK9YIbWKxWwDQEEsFqdfHD2KGYNVUyrhFGVZe6ayvoYvm
         ZjOiSOdmUDli1+o5l6dM69nqrm0/5yxUtc6R+iTFJgUu4De31klDURrnLQ9MosITuxj0
         MocZTMr8aqgThbUat7R8Tv+GmnpikSuU2waaB3OsOfmy3WBDZmZWkyzpiMATvuC05QzP
         ZnNbUb7cjzKT/C3jCHNpC2HkhKl1QuK35GO8YBklNpZ1ZIBC6BqulQtv4CizGgTjbFCG
         HYMg==
X-Gm-Message-State: AOJu0YzVPGrtil/4LXrM12DlGrNLXtup4bjLx7cEl3nK4yRJqyS3kMI4
	T26IjCMvAHgp1yuGm3cMsfHASSVJRtZwwTvh4rbISYSEHOFyhVS2974b
X-Gm-Gg: Acq92OHrxjB2qAWuoY2FxU4BjYWVqn0I/ZD8v3f2Jk4eLgRN1c+fDgS/2Sv8fLBPrbm
	vckGYOHxGkHsbNi1LU/cjbsDWsOVtZdSOUTSPlA3DIrlf5RmBKeYpshWzi34QUsg5VfQqrgvrF8
	NuIrH1/UB+0XSr0eMqurJzM9JomSYiqEpEvF4r4sVNVsP6DwnWXbIjdMRYeOxvgFl6v7xZz6PTv
	s7Mwl6WvoH9EhioD5kf8Tyv9eVWLpj7qi7KlXKXlESexj7cZGXVP83xnDhZAS0ws2krjZn8VM7s
	a7YDxmlbuHN4C8Z+TIepM75hgdBL/M5kNARY48N9l7CsVsbXYVLZS8Q3KtFqYrF3zheaHdBnLcA
	L2uekQrgQdrylD3xoF2bvF4f4a8O3dzFL33UJJD2MkvzP+4aclCPFVQ9Qif1K1LEjR5s8qfoSDX
	CevQImKqmWz3c3B8Cgf0f2dO5k61MZ3D601NchJBatQAkgcsKlzdEBXhrMKJ4IjzXgZ3dMwJqWl
	a7i/Zio
X-Received: by 2002:a05:6a00:92a4:b0:834:e882:3280 with SMTP id d2e1a72fcca58-8414adf6975mr1742050b3a.31.1779346815565;
        Thu, 21 May 2026 00:00:15 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-109-223.dynamic-ip.hinet.net. [36.225.109.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841549fb065sm234017b3a.14.2026.05.21.00.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 00:00:15 -0700 (PDT)
Date: Thu, 21 May 2026 15:00:11 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, rcu@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Message-ID: <20260521143042.G853f@cchengyang.duckdns.org>
References: <20260519171745.1551340-1-yphbchou0911@gmail.com>
 <20260519171745.1551340-3-yphbchou0911@gmail.com>
 <e17e4c18-33a3-47dd-a866-e1e381b0c496@paulmck-laptop>
 <20260520222617.G302e@cchengyang.duckdns.org>
 <41dacbf1-8255-4101-b6bf-636fd7d81efa@paulmck-laptop>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41dacbf1-8255-4101-b6bf-636fd7d81efa@paulmck-laptop>

Hi Paul,

On Wed, May 20, 2026 at 09:35:35AM -0700, Paul E. McKenney wrote:
[...]
> > > > +		free_cpumask_var(stalled_mask);
> > > 
> > > And free_cpumask_var() is happy to ignore a NULL pointer, so it is OK to
> > > invoke it on the pointer passed to a failing call to zalloc_cpumask_var().
> > 
> > One question here: Sashiko flagged that the GFP_ATOMIC allocation
> > risks deadlock if the stalled CPU holds a scheduler or allocator lock.
> 
> That sounds like a bug in either the combination of GFP_ flags used or in
> the memory allocator itself.  It should be possible to allocate so that
> you either get memory or get a NULL pointer, without risk of deadlock.
> 
> What am I missing here?
> 

Ah, you are right here, thanks for the correction.

> > Rather than keeping dynamic allocation with cpumask_available() guards,
> > I was planning to pre-allocate rcu_stall_cpumask and rcu_exp_stall_cpumask
> > in rcu_init() with GFP_KERNEL and clear them at the start of each stall
> > event. That would eliminate have_mask, cpumask_available(), and
> > free_cpumask_var() from the stall paths entirely.
> 
> Please note that rcu_init() runs when there is only one CPU online that
> is running with interrupts disabled.  So the fact that GFP_KERNEL works
> in that environment is because the memory allocator is interpreting it
> specially (see GFP_BOOT_MASK).
> 
> Does static allocation work?
> 

Yes, static allocation works. Declaring:

	static struct cpumask rcu_stall_cpumask;
	static struct cpumask rcu_exp_stall_cpumask;

and calling cpumask_clear() at the start of each stall event removes all
allocation, NULL checks, cpumask_available() guards, and free calls from
the stall paths. No boot-time failure path to worry about either.

> > Does that direction work for you, or would you prefer the dynamic
> > allocation path with proper cpumask_available() guards?
> 
> On the one hand, memory is getting expensive.  On the other hand, cpumasks
> are not *that* big.  I prefer dynamic allocation, but am not inalterably
> opposed to static (or, *almost* equivalently, boot-time) allocation.
> 
> The "*almost*" refers to the fact that boot-time allocation can fail.
> Usually, the system fails to boot in that situation, but some sort of
> check would be good.

Given that static allocation avoids the failure check concern and
simplifies the stall paths, I will use static allocation for v5.

Thanks!

-- 
Cheers,
Cheng-Yang
