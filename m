Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9F36B07E
	for <sched-ext@lists.linux.dev>; Fri,  8 May 2026 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234073; cv=none; b=bEMB5Jy6nnXU7K0ymOKLuhVZPam4qddFsK9N3RG1Jut3VCh6qZP/IuTUFb/I5Y4xY4b1iOAxyl0R8k+0b7RDQi3nqiTkw97XMliwgUN+v7Mf5BQd5FKZdEYbCzc/GHfHMCliuQ3UlcRec82+8/VD5n0wCy9MbOHEr1CNwf7lS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234073; c=relaxed/simple;
	bh=bJyeaH6AaUEx49FVPOPG5g1oDvzUeoLeiu9SaZ775U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVeDVWaXZKfJH/4B+Pzf6cM+kwMKROPNnQfc5yg0xO4M5JS235va5cJeRL9n/iBS47NX1dTzFCFTk6E1OFM/qjQNRJ9HthEJEcXAOM5UZrvvI7ZIgR2LsrmZC46u2JSeO+snaJK19zzCbRqpUhWoXg1fy8XbKRqoZtkzc3CZ5dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg6BF8OG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg6BF8OG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bab2548e8bso8705995ad.0
        for <sched-ext@lists.linux.dev>; Fri, 08 May 2026 02:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778234071; x=1778838871; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xxKMfEAkM+PXxNqp6tfRMAw25EfrnzTHmTHIrXxEjAs=;
        b=Tg6BF8OG+R8w68scABCt9vpqT5ybQhZhClZtj/3ZH8MKWOyL9y9FCBox7KtUVQvBi1
         c+MBb5qonchvBD7HWCwCH93L3x1P/fbEF1aBGNNAvoM9VSQ8SW0U5fjQvv+LYlLjH7sJ
         FlA3I81h/fIq7a9R5V6nwLiQaT/ckKVL8RXIZilKqrlFXHoYKhNVZmIUjHqygRsTweEC
         jPlEoV+2etGn3c6PVX7qWNhGI2h64dOA7cHKvnwcO8KXNGPK/AGaWXbGUJIt0f9DaZyB
         tHWnpCPpy9sUsNDRWZsPK2D2f5gBeANTX3JDt5rUxhXha+/isYK+GQ9/jYdbkGOsA5+a
         AeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778234071; x=1778838871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxKMfEAkM+PXxNqp6tfRMAw25EfrnzTHmTHIrXxEjAs=;
        b=mjOaUP1OHK+m3NMYmG6OSUfiuhK179tCOPQWr8aYxWW0P0x8raiqroT3Srpk4Cp5QA
         1E7raDbmlCGGb+DqaadZgOWxKWa6LrKbO53IdigFj+eNJHscoT5G5ft6U437/VkQWw44
         PPwvjGDkxtZAcY8zThNWuoju8T1BVdHyAVfiKyghklwwMmA8uyn0gRQUN9MNPidXE6YZ
         hyy1zgIoMOALLlb0eHH4I7AosYGhHDMk1dzjpFn/EogXeTL4g/gNR/cEf3GXSkv/EH4A
         BJsWP/rwO5M1nP5LEZHd0y9S7k9iBPgMtKUmDN1KjzCS6Zp+7GPbc7qo2t+dbJ2EX0a0
         B8yQ==
X-Gm-Message-State: AOJu0YxsaudqXAYDPTcx6AiApwh/jpN5jkmFajwHiYOLvMw/8HFmyZSa
	zyKvUCtHHHqy0axqM70zIkbLkA1oCoaiWd+H2TodOqPsJ5EgJ88YdDrI
X-Gm-Gg: Acq92OGFvSmATSW2aYnf6LBq58KeDAMUBbB7PpqF+aon7s/errWmL5RtMfqiS6wNOzp
	En4sx1RBI7DfN+1ydRnsMdIOOXJNrDI5+kTt+gL/JQD3iQkqTR+fQxCl73JgR04EkVQfgfZD3gz
	qYb2KrJOgq/a7kHH1GqRpWYwRJpv2qgwg1hJ77MaBgVe45VbrFKn7r7kd63foAsIRuOOT6JDQEu
	2ewSCZEOH+HQDmNKgUET+KzryfLAyiQtX0wF/SHCRTa4wEViZo9th0+ga5ZOkdEKIp7AYr+jHCd
	wHKb051qaenzdwgHS9sIGqmnzZhEr5DmOASGWOOgWkHAZiblccqXcqssf72ek0zKB8IPtt8metE
	yW5oFpPJ8fZS3MeRtg5AXWIfFNZgMVCvMbBu30Q9ChU+ffUBx+asArR7IsbsfFcgQket/1oNtvH
	gB1EZreCmtR4jLAksjBcwz+9InEYzSrLLH6tOLj97PssBbogu0BdcTEVSJ4YNXO3D/Lbonx/nY+
	Z3zJw==
X-Received: by 2002:a17:903:4b0d:b0:2ba:4086:ecb1 with SMTP id d9443c01a7336-2ba798cc557mr129527535ad.34.1778234071358;
        Fri, 08 May 2026 02:54:31 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-99-238.dynamic-ip.hinet.net. [36.225.99.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eac6bcsm15187685ad.70.2026.05.08.02.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:54:31 -0700 (PDT)
Date: Fri, 8 May 2026 17:54:27 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.2] selftests/sched_ext: Fix
 select_cpu_dfl link leak on early return
Message-ID: <20260508175350.G4a3f@cchengyang.duckdns.org>
References: <20260508065514.1723906-1-yphbchou0911@gmail.com>
 <af2aD8-tFi_yhPOV@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af2aD8-tFi_yhPOV@gpd4>

Hi Andrea,

On Fri, May 08, 2026 at 10:08:47AM +0200, Andrea Righi wrote:
> Hi Cheng-Yang,
> 
> On Fri, May 08, 2026 at 02:55:12PM +0800, Cheng-Yang Chou wrote:
> > If run() exits early via SCX_EQ/SCX_ASSERT (which calls return
> > directly), bpf_link__destroy() is never reached and the BPF
> > scheduler stays loaded. All subsequent tests then fail to attach
> > because SCX is not in the DISABLED state.
> > 
> > Move bpf_link into a context struct so cleanup() always destroys
> > it, regardless of how run() exits. Also skip waitpid() for children
> > where fork() returned -1, avoiding waitpid(-1,...) accidentally
> > reaping an unrelated child and triggering the early return path.
> > 
> > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> 
> Looks good to me.
> 
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> 
> I think other selftests may need a similar change to prevent potential cascading
> failures.

Thanks for the review!

Sure, I'll scan through the other selftests to see if the same
cleanup can be applied. Thanks!

> 
> Thanks,
> -Andrea
> 
> > ---
> > I was hitting this error when testing the defer SCX bandwidth patchset,
> > though I think it shouldn't hit the bug under regular testing. Tested
> > this on the for-next branch and everything still looks fine.
> > 
> >  .../selftests/sched_ext/select_cpu_dfl.c      | 54 +++++++++++++------
> >  1 file changed, 38 insertions(+), 16 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl.c b/tools/testing/selftests/sched_ext/select_cpu_dfl.c
> > index 5b6e045e1109..7e342c0cec65 100644
> > --- a/tools/testing/selftests/sched_ext/select_cpu_dfl.c
> > +++ b/tools/testing/selftests/sched_ext/select_cpu_dfl.c
> > @@ -6,6 +6,7 @@
> >   */
> >  #include <bpf/bpf.h>
> >  #include <scx/common.h>
> > +#include <stdlib.h>
> >  #include <sys/wait.h>
> >  #include <unistd.h>
> >  #include "select_cpu_dfl.bpf.skel.h"
> > @@ -13,29 +14,44 @@
> >  
> >  #define NUM_CHILDREN 1028
> >  
> > +struct select_cpu_dfl_ctx {
> > +	struct select_cpu_dfl	*skel;
> > +	struct bpf_link		*link;
> > +};
> > +
> >  static enum scx_test_status setup(void **ctx)
> >  {
> > -	struct select_cpu_dfl *skel;
> > +	struct select_cpu_dfl_ctx *tctx;
> > +
> > +	tctx = malloc(sizeof(*tctx));
> > +	SCX_FAIL_IF(!tctx, "Failed to allocate test context");
> > +	tctx->link = NULL;
> >  
> > -	skel = select_cpu_dfl__open();
> > -	SCX_FAIL_IF(!skel, "Failed to open");
> > -	SCX_ENUM_INIT(skel);
> > -	SCX_FAIL_IF(select_cpu_dfl__load(skel), "Failed to load skel");
> > +	tctx->skel = select_cpu_dfl__open();
> > +	if (!tctx->skel) {
> > +		free(tctx);
> > +		SCX_FAIL("Failed to open");
> > +	}
> > +	SCX_ENUM_INIT(tctx->skel);
> > +	if (select_cpu_dfl__load(tctx->skel)) {
> > +		select_cpu_dfl__destroy(tctx->skel);
> > +		free(tctx);
> > +		SCX_FAIL("Failed to load skel");
> > +	}
> >  
> > -	*ctx = skel;
> > +	*ctx = tctx;
> >  
> >  	return SCX_TEST_PASS;
> >  }
> >  
> >  static enum scx_test_status run(void *ctx)
> >  {
> > -	struct select_cpu_dfl *skel = ctx;
> > -	struct bpf_link *link;
> > +	struct select_cpu_dfl_ctx *tctx = ctx;
> >  	pid_t pids[NUM_CHILDREN];
> > -	int i, status;
> > +	int i, status, nforked = 0;
> >  
> > -	link = bpf_map__attach_struct_ops(skel->maps.select_cpu_dfl_ops);
> > -	SCX_FAIL_IF(!link, "Failed to attach scheduler");
> > +	tctx->link = bpf_map__attach_struct_ops(tctx->skel->maps.select_cpu_dfl_ops);
> > +	SCX_FAIL_IF(!tctx->link, "Failed to attach scheduler");
> >  
> >  	for (i = 0; i < NUM_CHILDREN; i++) {
> >  		pids[i] = fork();
> > @@ -43,25 +59,31 @@ static enum scx_test_status run(void *ctx)
> >  			sleep(1);
> >  			exit(0);
> >  		}
> > +		if (pids[i] > 0)
> > +			nforked++;
> >  	}
> >  
> >  	for (i = 0; i < NUM_CHILDREN; i++) {
> > +		if (pids[i] <= 0)
> > +			continue;
> >  		SCX_EQ(waitpid(pids[i], &status, 0), pids[i]);
> >  		SCX_EQ(status, 0);
> >  	}
> >  
> > -	SCX_ASSERT(!skel->bss->saw_local);
> > -
> > -	bpf_link__destroy(link);
> > +	SCX_GT(nforked, 0);
> > +	SCX_ASSERT(!tctx->skel->bss->saw_local);
> >  
> >  	return SCX_TEST_PASS;
> >  }
> >  
> >  static void cleanup(void *ctx)
> >  {
> > -	struct select_cpu_dfl *skel = ctx;
> > +	struct select_cpu_dfl_ctx *tctx = ctx;
> >  
> > -	select_cpu_dfl__destroy(skel);
> > +	if (tctx->link)
> > +		bpf_link__destroy(tctx->link);
> > +	select_cpu_dfl__destroy(tctx->skel);
> > +	free(tctx);
> >  }
> >  
> >  struct scx_test select_cpu_dfl = {
> > -- 
> > 2.48.1
> > 

-- 
Cheers,
Cheng-Yang
