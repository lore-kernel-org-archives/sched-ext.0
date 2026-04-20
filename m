Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39879261B9B
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698646; cv=none; b=Bh4foLLRKj4DvQfdd3X+KLWglHpfLDCk0Nx0lBTnxOjO+OZvslb2ZlBxf76JK/QcWBtGTlpkgIzl1XmgCUXxFOo35tCn8mY/avKKWeVkDAufBV7KujMrZftmtyQGRuO0QoQxnBDjxRAryD5eM0wwK3K2rLVcH4TV52ZdcoHoZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698646; c=relaxed/simple;
	bh=S5ZP4RbMxM5WJDgdmDHDvSdDK9OgbnZ11vn0p8wmHXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ50YVdMFOEX++wh0JF/cdYFaB7CGc3GUT3nmuNsyGmwtFG7/yL+RgNNFToIsncxh5iRrlPXRoHRJCTbJbihFavzVQuEAbaBGBgcAfTtIWsGeJjGb8E9I68ywc7lxnXboQjObI6YH+mlCAC29u5x+KQTuoF8DuLgfLbe95H62yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swT+H9jE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swT+H9jE"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad21f437eeso20503105ad.0
        for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776698643; x=1777303443; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tmRpKCBUo7FLADDjqyGs2hf+SqfD75sYa7V2NFI99Rs=;
        b=swT+H9jE7w+ekqTNl/gYAQFhIgvTlF4jO6qghZwdmCBtiiqwJy3CVP+Vhl8tf/QyyU
         gVlbWOC8D6QuhaEdfmP/J/HhA8t7kvV6MC4KX3ljQdxjJCIYBIHmhepfCCLA7WpzlZrc
         j62vmLAK482/BFdnEzJD1KnTutrWtsg7QUgUE1BUnqc560TogBh18dULe/VCZD7c3dbI
         jfSwj4yWB6fAuxyMEcq+aEHzmxZKyZ6wlJxUrgwt79xOLI+GFVwZZc32T25abKRpTGu2
         7MKKedSM00d5WfbpxEtFO+HMzyuCGlSe+zAgTAgedt0+fSVxYj48IatWgyw01j76eHL9
         thFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776698643; x=1777303443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmRpKCBUo7FLADDjqyGs2hf+SqfD75sYa7V2NFI99Rs=;
        b=hzGpPzHbBCB174Af+QcaacTh51Jl9c3oHQKnLnvef15Xczn36QyHcWCYfINXSdcp7V
         NsJ7smHmP53cBzAAgt7lYK0PGF9/WGlHfwozCSVBye9FGVo+WgCGnYQMEIehdxkRPKKL
         9tCYH8mLY5U0DE05TUcVEyj+jKs5o8gISNhNUME+DBX6qstrlsSt+eSGCtYAcNaB3+2e
         ZJW+1gfZ+v0xYI5oMcQ0fcfI3JfrjGc4+GduNkW6fAR5gGZD1w3/Q8k4GSwcuQjTfyCD
         ByfUlcl0gFjyTzLbWGlk2gpILV9f5c76TRcS+sVv4JRc3ZL8Ikhnw82bIU1PPwfNdQiX
         nC5w==
X-Forwarded-Encrypted: i=1; AFNElJ+FFhJXa8XDtu2U0tyD2RR6RWGu9I+WOqgBSJ5D4QymhkfIe4YX9a2uIKSagdu287GgoOeEzyGPtO0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwvdpVmUtjGZO0hmxu10ionjajYgM5lmCnWU9qUn0+2Hyxt1r1u
	pj+JGMPULKS2lQNaPiTGegb7yd7fFFrbfrvCLcUn8t3B1flR0L0B87Cl
X-Gm-Gg: AeBDieu5aCC34I+zytel/ohqhUbApRW6dNcJkhZYgqxaCv0UDI2kzg/yjMrFLYH9kA3
	OVJ3foXGJJmU4DaWeMtcEkYGWCFgh7nPE7RBFiMBj3+ZUvgV1dI4xIdUFd+iwF+hzX8swiXG4lC
	BhtbhiaRqS5IjIWiY2P+AeH4nWm13JgDLbIuLpISqyVKzkRUuppgoq4g0fephWOinZKYpv8CO94
	aahekJHpoYkGI30cF9anp4hF1aMzfzUnKc7SUFjRUirLXjU4G1LiN8iOMwY+oiT0ha63B7C8O+a
	za6phNltCg1lJJDZGTogexQzGFdMSBj0nZTmbjH1UtPmFG9P0VflC4AXLN7VNTpQgnBIel8+UGx
	k5/ZkZWRhk2aNtBNM4D6VunlAZH3kZ5qI0Strvv4/u0NVAGwasZoIW3/dW1/M5VGFMyc5r4ytc+
	4456vqt0TO9Ij7Zd37VN4o4TNwELzR/fropNss/5W0FccIi9jZ5Q18JhAmLK3yDd9Q1oytRTHsu
	FyEbBSNPuiFkhdWolCJQP7GGFE=
X-Received: by 2002:a17:902:b405:b0:2b0:b7c6:4ae7 with SMTP id d9443c01a7336-2b5f9dba8d3mr75052525ad.1.1776698643309;
        Mon, 20 Apr 2026 08:24:03 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-97-241.dynamic-ip.hinet.net. [36.225.97.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9fedf0sm127474425ad.6.2026.04.20.08.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 08:24:03 -0700 (PDT)
Date: Mon, 20 Apr 2026 23:23:59 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] sched_ext: Documentation: add note about multiple
 ops.enqueue() calls in a row
Message-ID: <20260420232245.Gc8ef@cchengyang.duckdns.org>
References: <20260420143939.3636883-1-jpiecuch@google.com>
 <20260420230420.G737d@cchengyang.duckdns.org>
 <DHY3280DLSAP.3PP7V3KZK618F@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHY3280DLSAP.3PP7V3KZK618F@google.com>

Hi Kuba,

On Mon, Apr 20, 2026 at 03:21:59PM +0000, Kuba Piecuch wrote:
> Hi Cheng-Yang,
> 
> On Mon Apr 20, 2026 at 3:12 PM UTC, Cheng-Yang Chou wrote:
> > Hi Kuba,
> >
> > On Mon, Apr 20, 2026 at 02:39:39PM +0000, Kuba Piecuch wrote:
> >> Commit 84b1a0ea0b7c
> >> ("sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs")
> >> introduced the possibility of ops.enqueue() being called multiple times
> >> in a row for the same task without intervening calls to ops.dequeue().
> >> AFAIK this was not possible before that commit.
> >   ^^^^^
> > Nit: Do we really need this line in the commit message?
> > Perhaps we can just drop this?
> 
> I put it there just in case someone was actually aware of a scenario before
> that commit where we can have multiple ops.enqueue() calls in a row.

I see, thanks!

> 
> Regarding removing the line: yeah, I guess it's a bit redundant.
> I'll send a v2.
> 
> >
> >> Document this behavior as it may be surprising to some.
> >> 
> >> Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
> >> ---
> >>  Documentation/scheduler/sched-ext.rst | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >> 
> >> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> >> index 03d595d178ea..fba09aa1cd4e 100644
> >> --- a/Documentation/scheduler/sched-ext.rst
> >> +++ b/Documentation/scheduler/sched-ext.rst
> >> @@ -339,6 +339,11 @@ The following briefly shows how a waking task is scheduled and executed.
> >>       leaves (e.g., when ``ops.dispatch()`` moves it to a terminal DSQ, or
> >>       on property change / sleep).
> >>  
> >> +   Note that ``ops.enqueue()`` can be called multiple times in a row without
> >> +   an intervening call to ``ops.dequeue()``. This can happen, for example,
> >> +   when a task on a user-created DSQ is re-enqueued using
> >> +   ``scx_bpf_dsq_reenq()``. The task stays in BPF custody the entire time.
> >> +
> >
> > Thanks for adding and clarifying this. ^v^
> >
> > Acked-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> >
> 
> Thanks,
> Kuba

-- 
Cheers,
Cheng-Yang
