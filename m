Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8113DD857
	for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177796; cv=none; b=VlSnXxAliTIpK8ZdJQSX/7yUnEcUnBji3B2uDDC5khJXiNpL7rbr9IdiQth3hy7s0FoeDUbtuGq0SO0WAPt87Jaxslb09O9Xh4LbBVmDGm76K5FwgX1pygyaiw2tb4GIcAzc/M/5i60Wlx+HVQjffX7m8WgT8i5lbRvZ6wSqnN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177796; c=relaxed/simple;
	bh=LUHLBLA+t+dlz3Pkv1Lh9An71O0/RK94P+VoQ+FOVkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6IG879I3DVSqJkb5VdBZkYP0bMkcM6G20y6mCzlcbtIa3OWcBwqjjlKQ0dGus9cnlQXvW/BtAkJOBjdvfmFJ3faRvi34zKittpgIlaaB5R7gxlnMQArYRN+G7+dQDbYD8DnpvSLkV4eOOSFA0jsZK0jVzMluHvyR2HULtCJL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1MB7crQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1MB7crQ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c7ffe8eeaf2so1339573a12.0
        for <sched-ext@lists.linux.dev>; Tue, 19 May 2026 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779177795; x=1779782595; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FzTmNwB8gsREOlS6zByQH9A1MxUASfb5z5mhpssClQs=;
        b=Q1MB7crQguYJ2g1tEnPUZTGS9aV85RjUW3MKmjlEd2oJA62ZTT4dzvOhP4T/UORBOL
         2J8RGCWhomCfwDVqhAYAYWkDrJvAh98nbEW+MgNBc23qteDdhMR+8Mh85IDwdX4uUg0l
         LNtGH5YS9rcAcbJM8PgBKvsEZnEELpdGqlr5nefAob2Wt+/L6X+weaazzOU5iPeUKzVC
         EkN9C6RrOmeNCq2o1QC5tpOb5s4SGf2Owca/881OHW7fA4T1SDfAXVfQkLoYLhHgWglw
         eL/lg7o/AsgcPkvIQHbFy0hQIpipP0sMlQxF75m2300kyJ3Iv1qXsFo8dV9lkTT7ePmq
         2YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177795; x=1779782595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzTmNwB8gsREOlS6zByQH9A1MxUASfb5z5mhpssClQs=;
        b=SzjaQ9PUKcUQADzRXgtfKJmWWbO5efxbUPD3b7LYb3FHhwfcZPcX5sP76vyTAZVbcN
         +/aNUN692h+OI/1EA3QokQvREWtydgiUr0StI9YYpjB2rDmQoWdyjkjUEn0jm0vxdTue
         Sc0E3Ngray48MHKZ1/QLteN8rZZhGYvk2VwMCBQ6vHxR2PNZ9/OG0A1fzf1D/s84ZqX8
         XxSPJdxF8Z+jtrbNwWim/xP//eVrrnI+QFFlfzPdv9JzZkJEEB2FZc9RXvto1+l0iNZc
         Cjh6g0hkaWvsMHtprLs+yHvLv4ckt+JPuYe6qemove3FHdXWTN78fFZ/ybhI8dhfwlRX
         oRqQ==
X-Gm-Message-State: AOJu0Yw6LSQTK6xd9YDHA5hfqWf2GZccKUs6QGpMxQzUP069BFFJnsy0
	zvgX713iEYj153KbslUBJJ/RdbrFYc5vYtmE+MIjQ63hRgS0DXjC0iwAj9z/qA==
X-Gm-Gg: Acq92OEj9Zs3h9uvms4NQfUBSX+TmAguvxxYIS6quUcKUWasNbRUPFq1kLSH19XAwYh
	1lOe+2fl6rxpx9KThlKyqlaHuVT75ksiup16FmfBa8iRBh9gV+cApql/xjeBXAq2dbtTECzxkTQ
	/tTCIQChoVRl/Br8c6b/WXomtUQZ21vpuSRZccZ1hKJHR3cOSmxF6q6i/9fIHAzgBEz2UpMP+vE
	Tjc5/Kk5ZkZXrvXYUpkf6E7InvgzFnjenr5N+AwySjBUyDYfa5JAa1BYexTVsWzIR2sD11Y22Q5
	G12yYdU622qA55P3I/kTTx1dgDfOjimT21dZI/uLqiYzIz0s0eFFA5YSVH7U1GDZs3QeoQO/QjX
	62Cu0TPTKiwggI5v3JEmh6x2Qeyxzfdx7fCPO7j738bKBlQOSIgCi236SYzzC5Esniu2tWDP9ni
	TyTOyH4lalN8GPX8FaGYqPDEsKJTjV6gD6Tl8zPQj17V9i0kiwctmLbvxKmIdUpci5AN6bgvJuy
	O7f0njF6KIZDmDj
X-Received: by 2002:a17:902:7892:b0:2bd:63dc:b7ad with SMTP id d9443c01a7336-2bd7e86c6b1mr144453945ad.2.1779177794505;
        Tue, 19 May 2026 01:03:14 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-116-93.dynamic-ip.hinet.net. [36.225.116.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11d6easm191361105ad.72.2026.05.19.01.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:03:14 -0700 (PDT)
Date: Tue, 19 May 2026 16:03:10 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Message-ID: <20260519160158.Gad1f@cchengyang.duckdns.org>
References: <20260518131311.1170786-1-yphbchou0911@gmail.com>
 <20260518131311.1170786-3-yphbchou0911@gmail.com>
 <agtoyycMdwatAiFc@slm.duckdns.org>
 <20260519152904.G1f99@cchengyang.duckdns.org>
 <agwW2PET7rOcL_87@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agwW2PET7rOcL_87@slm.duckdns.org>

Hi Tejun,

On Mon, May 18, 2026 at 09:52:56PM -1000, Tejun Heo wrote:
> On Tue, May 19, 2026 at 03:43:45PM +0800, Cheng-Yang Chou wrote:
> > Hi Tejun,
> > 
> > On Mon, May 18, 2026 at 09:30:19AM -1000, Tejun Heo wrote:
> > > On Mon, May 18, 2026 at 09:11:49PM +0800, Cheng-Yang Chou wrote:
> > > > +bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask)
> > > >  {
> > > > -	return handle_lockup(-1, "RCU CPU stall detected!");
> > > > +	int exit_cpu = cpumask_empty(stalled_mask) ? -1 : (int)cpumask_first(stalled_mask);
> > > > +
> > > > +	return handle_lockup(exit_cpu, "RCU CPU stall on CPUs (%*pbl)",
> > > > +			     cpumask_pr_args(stalled_mask));
> > > 
> > > Wouldn't you want to pipe this down so that you can prioritize all stalled
> > > CPUs when dumping?
> > 
> > Ahh yes, will add stall_cpus to scx_exit_info, store the full mask
> > there, and update scx_dump_state() to dump all stalled CPUs first.
> 
> I'm not sure I'd add it to scx_exit_info as that's public interface. Just
> pipe it to dump?
> 

Ok, just pipe it to dump, will send a v4 patch soon.
Thanks.

-- 
Cheers,
Cheng-Yang
