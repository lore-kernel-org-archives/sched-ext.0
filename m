Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D463264F4
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362994; cv=none; b=isaJ6z5cjMie1OgQne6ERyCRM8NSojescNxvVYWf0I7n0WNyrdZ2Hywyt+IGnmgev1AcHU7GUDlfXYuHhKj/9acKXVGoLp+ILgjEceVSIbTsz9+58mwuqN2yvcH0qnshwXJ2qWYl1hoD6skRrHYsdZ6pasZ71R9V1+7FjJhiJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362994; c=relaxed/simple;
	bh=mmULvUuKrPnKvWEZawRe8RX1kO2oep14pfV0IVrHAo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBUeInPv8Q9qXMno+vl+B66xV6dYr4yDWurDr/xCZdSmKvi+oIqn+NGy0UWnSgBGJPwCyfgYNeiCIk6hnrqC1bWjFjGGGTXGepkTDiyeEIaG6uPKoUgl0PUUKxRLlMS/7XBg0bOPSCJc0fwzSxvn6Es515l6vFUYlBcf2/dsvDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bof+Eabb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bof+Eabb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad21f437eeso6690835ad.0
        for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776362992; x=1776967792; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6OK03PX0h3tG83iks1r+wGD2/ZrEzb1T+pdJSDsB8lA=;
        b=bof+EabbSbbavyAs2wFu0FkeTPLFbo5Dwamv1okTWufr8jxesu+c5NXuHjmVBjj4CJ
         T3KKkTHScq3rGs2BRi9Q2y6iz464fCzhkqIpNZxyWoCs4WTMerI+DWYCQCeOxGa008pb
         XhWrC64gFG448552DMeJJgINfkNURGLImI5lqIKTbIWx6hEpKqgreu1wvyFao8fynvTb
         meg5E3eOVmwdadzgx8L9j8yM1jA9a9g90BVUT+mYANBDg2hV+vkm5D+qXPAGGzyNbtQw
         L/KpUo4ji2hpuv1Q+GJsxus5sWNpO4xr5Tz0KMHPsC3NiXwQtHj78iHRKyOPHZSrwBH8
         RWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776362992; x=1776967792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OK03PX0h3tG83iks1r+wGD2/ZrEzb1T+pdJSDsB8lA=;
        b=UUFP/w1Gu6mFZU08QfN6zKf5k/M+OZpSJQNfrBXd6Wb1ZkAutq9aVZVtQ+t9erC3n7
         iM2D3I93vZG1r0V1DvgLYJ2813v8Ps6AKjhGPzILoeheWB9440TdW7mtnhKERxxA9y//
         F4LuYFwyM2z7V84jdcjlQ12bwd6XAKgIOP8dRsUx15Wj/EFQLpWlB+PayswjXDIYmqYr
         TMoCj3Cwm5sUxRUWqK1D05tLFIRbYAMkFuytlBcMZ7injB6cczHasi5AABxfnmVMIDYS
         pBAr9jcwQN+HMzy/9PfJRBcC/A214Lricf/gc5sIOqkeK9ppyqndwOeCW+3wodjY8arS
         8hQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9nl1/exTJcGNIq+bIJ4L34fp+Poh3q3z6eJ9m7Qu+aL0VNSHqE1B5AqMswhYklNOo9bKIAMOOyCsk=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf8YMxtavl6yMCgkx8+lOo2OlmSci5fI1XwOtX83RPx8qcnyb7
	Ch5mtvCviwlTIGutZxogFdxUg5THQMYlbVRSaPxrVWHE9/K7X6F9SY4k
X-Gm-Gg: AeBDievTACsAjr636fgyeV2rxW9y0S7UFA6l9Yz1PwMdxCVIyCb/YbTMBQDojPTERHt
	Y4J+Z4u9jS8iW/d19hvgd6DcIn/1uKntrgTLHNMcR9zmio+jxWXKEg7wetCCOmHaboaZCReQ5Zc
	5qRXYCG8Ad3z5wxKwlIlphh2q0OctFxR3XcP5Sms/67n/GJnjVKX+TI0/p1kbdwiLFQ8YiZ2OEs
	20Oi1kZvwNMjNIYLdOyQ9fv47peKCqxM0euhku5R4xeuYm50jZNFEHlPrH7NV24QJV5dzNzPyKn
	YJxdeUoL187AGvoVI4w650XjbYA9IVwkW2IQ4WJs68Hc9LrXuUI0DjMczKeQVnS/mBLZuzX67BC
	tQOLgUVXWDahU8tVywSMpM++TZ4qyK0R98LvAX7aLpNodd1tupzPkzztrUhqhgNCu1fzJU8qhdB
	V2JrGH+Xx1ZatzarYWMGHyAjVEs23cf43R88c1K4zzvu4+TvDFSdCCdYTCfrXH3EtfYk4Z3Yw+g
	BefYEjfVi3f
X-Received: by 2002:a17:902:d2ca:b0:2b0:506b:e6f8 with SMTP id d9443c01a7336-2b5f83b6fb8mr2735475ad.5.1776362992179;
        Thu, 16 Apr 2026 11:09:52 -0700 (PDT)
Received: from eric-acer (36-225-123-187.dynamic-ip.hinet.net. [36.225.123.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b478291498sm61927705ad.57.2026.04.16.11.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:09:51 -0700 (PDT)
Date: Fri, 17 Apr 2026 02:09:49 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, sched-ext@lists.linux.dev, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Prevent RB-tree corruption in
 scx_bpf_task_set_dsq_vtime()
Message-ID: <eil4aqkypndb3baws375muahkrpjkax3r4xzrb3fc7mavlsghy@nhq77wmdnz7r>
References: <20260415193459.933175-1-yphbchou0911@gmail.com>
 <aeEi0X4Fn70bUgva@slm.duckdns.org>
 <aeEjvvOdQBNPdHA4@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeEjvvOdQBNPdHA4@gpd4>

Hi Tejun, Andrea,

On Thu, Apr 16, 2026 at 08:00:30PM +0200, Andrea Righi wrote:
> On Thu, Apr 16, 2026 at 07:56:33AM -1000, Tejun Heo wrote:
> > On Thu, Apr 16, 2026 at 03:32:44AM +0800, Cheng-Yang Chou wrote:
> > > scx_bpf_task_set_dsq_vtime() allows modifying a task's dsq_vtime without
> > > checking if it is already enqueued on SCX_DSQ_PRIQ. Since dsq_vtime is
> > > the rb-tree sorting key, mutating it in-place violates the BST invariant
> > > and corrupts the tree structure.
> > > 
> > > In ops.dispatch():
> > > 	p = scx_bpf_dsq_peek(PRIO_DSQ); // Get a task already in the DSQ
> > > 	if (p) {
> > > 		// This illegally returns %true
> > > 		scx_bpf_task_set_dsq_vtime(p, 0xFFFFFFFFFFFFFFFF);
> > > 	}
> > > 
> > > Fix this by adding a check for the SCX_TASK_DSQ_ON_PRIQ flag. Disallow
> > > vtime modification and trigger scx_error() if the task is already queued
> > > on a priority DSQ.
> > 
> > If the user updates the vtime after inserting, the tree looks wrong but it
> > won't cause crashes or anything. Later insertions might get confused in
> > terms of ordering but it's a rather obvious user-shotting-their-own-foot, so
> > I'm more inclined to leave it as-is.
> 
> I agree. This looks like intentionally breaking the tree. If users do so, they
> can keep the pieces. :)

Ah, I see. I was just experimenting with some scheduler API combinations.
Indeed, users shouldn't do this if they want their scheduler to work
correctly.

Thanks for the explanation!

-- 
Thanks,
Cheng-Yang
