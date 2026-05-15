Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6378F371045
	for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856664; cv=none; b=r1w6+r8l3Vqe77hTxoPKQNYA5NOPf2xm913h6mcQasHZQMhEBVxVfKFhCOVNIBbhMizi7EvhXVSJmC7OJ0CUw1huW7/b1EvGCIP+1sgT39khAdFsLcKvBI8UdclJLjrR8/WXGVpVzpcA/khfiXNa8RWM9/liTGgGt651ncVfEsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856664; c=relaxed/simple;
	bh=AjW8+aq8sHhIgv9LapcR1yUtsjO286mkSVVo4tF2b3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOyNgrL9c8lgVsjYR9TJQVjqT1/Ki5HR80vp9VtSCyHXAVJJOgUm0wR477q8LvLqyOD37GtnPL9SXBESNjmYLKqjSoUnuEdQtmAEYm8t3tWTM//Fi7RT4xSHF8B4TrxzT8dU7iQ9Tfs/x3xaj+Asng7nXEG4KW5QzIsf7X5HtxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n61S8OfX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n61S8OfX"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-365e20fe3b8so5601971a91.3
        for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778856663; x=1779461463; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kEDifam5yI6Em64zxXsitxd087MvN5wmox4QB6Aj4jA=;
        b=n61S8OfXHsFghatuESqVIRML/CJYfy5xZqzis75hdn99cFUQ2n2ondp66/nQpDMF71
         NrqAfcZVqJcGw7cvJvF9/GNaVtkdHmxuEvbGZeWH/Llnj/Z8uIUgl2u65H5Y/ZJ3N+y/
         DRJF4KMDfOw31dEfZlqow37FxqWPLq9StcFG7+6/gi3SfeWy7r6FW6eAXg6ItkZo+ksO
         nFvZHjFW8/90sCmysY9yEzC7MnMx7Q8nZBAkNTKgjS5aitfbTx8pB65/k0plc/5PRCA1
         A5WkGEv3cX6AtjZXFJd0xSi+1Cdv/iuvCNyYTNoIyUF1vmGelc8Bclooy4ecR4jw1/pI
         iSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778856663; x=1779461463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEDifam5yI6Em64zxXsitxd087MvN5wmox4QB6Aj4jA=;
        b=A7b7W6hIt70eOW0FZ33aZaxMB7J5WyodaTiq9OMGFISNDhKfZqgeanbmMII37V+YXX
         qfz9g/inmhl2qOUgBOHUvnXkjqw/H8aE5OrzzN0EwwtAB0BLnLWl6lwlJcWeYhm7al48
         92hwc7rxM6rABX0WFflMsCgz05GQaGDH4sNQopv6KM0NVNqw8tr/M7IAK8Gixvdo4+uk
         Hu0AQVNHsF3Tnn5ONkqeNFeIpgGSlr5wyKVzvb5T+eJjGVDWi1J6gCbZ1casiaqaQNaM
         nz+03ys2QEWph7sbt72WSF9/9T0U/e2egqk4PYtqP413GI9fY8oaDnoIsIyNb6qBViw2
         S9Rw==
X-Forwarded-Encrypted: i=1; AFNElJ9SSin06B/GzkXmdYgNgl5bUbTySB25DDk2iWzNqe6XZ9sY2tki13KT342nzfKU7erjGCKxxEuJjbs=@lists.linux.dev
X-Gm-Message-State: AOJu0YwhRqyvDw+pbjSaZrOHGTYxBGwugTOmyS/WckSYG4WmYGxOWou9
	glvsRL26dqyiNVxlww74IGzRw0HEiDdK3KwK6iS3kqqlR5aVWvYfKFQD
X-Gm-Gg: Acq92OEapE8JYKW9mD4hAMGYwaWYXz3PrA6ndlJ/gC348+rjqjlZ3qeE3E2ChboSGw7
	xOiZWzGz7S7k93kcISS2JWe2nD6JysfFe+uBKOQzZ66vsQMzuix8qjKnG8vgR3Y5SrAjZJTQK0U
	3kh/Bn65cAuopi8it0r7RXfswtTls6V39aY3QMR5LBesBRKWY3Xbn+8N1ob0YCng3VRNvoMVSYL
	w5rBjb5VSswhEjFCSYMdhQKTKN1BXeemwqocnpRR7dd+hy3nmgjaan1y0Y0cpbLnNC0HIn/pIE+
	ajsRTJpA4erRB7IqKpDlVIZx8c6XSlNv7SyYmlC8pyaRwtgkg5TKxxICrNZYALrzU4jrQ8nE0ZJ
	hKzr0Az2FHpPBQxfhAgl4cfBaP2HlLCz0hCp61tD5p6dF4l2v7FXtSxfLoiKSmMKlFGMpphUmFc
	cg7SCScNM7kFt5DZaya4xEn4J18T/E99GP3Wgt3uv2e8qqk2taO6g7fzE6ZPJ18jzgQYwrxGr77
	XM=
X-Received: by 2002:a17:90b:48cf:b0:368:b01c:85a0 with SMTP id 98e67ed59e1d1-36951b7213cmr4421153a91.14.1778856662517;
        Fri, 15 May 2026 07:51:02 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-72-95.dynamic-ip.hinet.net. [36.225.72.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36968dae27bsm699360a91.1.2026.05.15.07.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:51:02 -0700 (PDT)
Date: Fri, 15 May 2026 22:50:59 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, sched-ext@lists.linux.dev, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Kuba Piecuch <jpiecuch@google.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 1/2] sched_ext: Add dispatch transaction API
Message-ID: <20260515224002.G1a39@cchengyang.duckdns.org>
References: <20260509191223.168648-1-yphbchou0911@gmail.com>
 <20260509191223.168648-2-yphbchou0911@gmail.com>
 <af-l_M9p9npc9FUA@gpd4>
 <agCP-e9ZL8smNoNQ@slm.duckdns.org>
 <agCdBQXkDNO4CWoT@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agCdBQXkDNO4CWoT@gpd4>

Hi Andrea, Tejun,

On Sun, May 10, 2026 at 04:58:13PM +0200, Andrea Righi wrote:
> On Sun, May 10, 2026 at 04:02:33AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Sat, May 09, 2026 at 11:24:12PM +0200, Andrea Righi wrote:
> > > Why not passing slice to scx_bpf_dsq_insert_commit()? Is it because of the BPF
> > > args limitation? In that case we could introduce a struct similar to
> > > scx_bpf_dsq_insert_vtime_args.

Introduced scx_bpf_dsq_insert_commit_args wrapping dsq_id, slice and
enq_flags to stay within the BPF verifier's five-arg limit.

> > > 
> > > Speaking of vtime, we may also need a scx_bpf_dsq_insert_vtime_commit() that
> > > accepts dsq_vtime as well, otherwise how do we use priority DSQs with this new
> > > transaction variant?
> > 
> > Given that these are only meaningful when targeting local DSQs, I don't
> > think vtime interface is necessary. It'd probably be a good idea to
> > explicitly restrict usage to local DSQs.
> 
> Ack, it definitely makes sense to restrict this to local DSQs.

Restricted scx_bpf_dsq_insert_commit() to local DSQs at runtime,
targeting a non-local DSQ aborts the sched via scx_error()

> 
> > 
> > > > To support explicit token passing, rename scx_dsq_insert_commit() to
> > > > scx_dsq_insert_buf() and add a qseq parameter. All existing callers
> > > > preserve the original behavior.
> > > > 
> > > > This mechanism is intended for schedulers that do not implement
> > > > properly synchronized dequeue. A scheduler whose ops.dequeue()
> > > > synchronizes atomically with the dispatch path does not need this API.
> > > 
> > > I'm wondering if we should validate qseq also in mark_direct_dispatch(), it
> > > seems that we're not validating qseq in the direct dispatch path, or am I
> > > missing something?
> > 
> > In DD path, the task can't be lost and it'd be a bit silly to use this
> > interface. Again, probably good idea to at least start with just allowing in
> > dispatch path.

Restricted scx_bpf_dsq_insert_commit() to ops.dispatch() only by moviing
it from scx_kfunc_ids_enqueue_dispatch to scx_kfunc_ids_dispatch.

> 
> Also true. Thanks for clarifying.

And, added a comment to mark_direct_dispatch() explaining why qseq
validation is not needed.

Thanks!

-- 
Cheers,
Cheng-Yang
