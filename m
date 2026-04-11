Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F5623EABC
	for <sched-ext@lists.linux.dev>; Sat, 11 Apr 2026 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775888264; cv=none; b=AedVfD4x41VSeHl5InTQRoOhQRAhBB8G9GxiE9x5G6pvPhtyksXVAxQyghKsRl5sqPec6B8huVLwbxQ071soKsQ4UKtI4MgqJ8tFQrNueszs8lO4C2OTS9VoUTktdvrGWjJzHseaYQFo3Dn1WJW8sXdXA6XFxHpFogBb3WLCZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775888264; c=relaxed/simple;
	bh=/XRcoEm8DPKrBfCWvs/eD+KvfVzqsIPAFY59M6wcMyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbeR6gIbZsj0tcE+cEf9pe2rncCWva0fDjjouCiFUqK6p0Y2yU3oyw2Spfrl7vf7oleGQBqPpQVT0rEKpPP9m8QQ0ZnbXjnvle9hUo77YZu0aSQt+0f+iL1J95I7WFPsHy6cWSRATKa8W+CfmZwGEHmrg/I1uc7ksUdMgWvApI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4rKGFVJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4rKGFVJ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so2601706a91.3
        for <sched-ext@lists.linux.dev>; Fri, 10 Apr 2026 23:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775888263; x=1776493063; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kPOOsWz5/na6EyvTMEvK39flDLz5JLKCa693ceIl+nw=;
        b=I4rKGFVJ6q7gNsGqLyO1+PwdaweJ7Wl8yE51R7cQMj3TzQNoUcXva41Hrlv+Yg6vl9
         iI4ocfl613REpSyXf7Z1GgDWlIPr78BSIEiEERZNerqlaBlLLxBpoM4mB0zRdrmVD8Bz
         DcZcWTOsIYkslihxOOvQji/4f1nbd0ZoYjGvd7ne10hhOUXu3L3E1kAWkwq+VE6frJPv
         QWF0FvcBMPqOdy9VCMlQYISPcUyaWTHfvmAn25yb0QjGN2Xv6TtxNoOsW56OwOTIfwMj
         bnzvWVj0k3LWzy8WVFrjMwT/g5pbKC959AQLDSyFJZPegFmqgOS8RfaKUPCM08Ze8+Zf
         UsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775888263; x=1776493063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPOOsWz5/na6EyvTMEvK39flDLz5JLKCa693ceIl+nw=;
        b=mUpwIeuvNhiqspGh28nakCHel+b8COYObmdQ+yYHOjeG5xOu50D/MxZb1eXk8NRITk
         XjvDbiv3W90N5IYNRtEBjjFWn5ZOYiO//vznga0wi7mmoPLZOLw7WeAHwLcAepucxHz4
         pDe8pkWRJvJOwhfd3rlAiglD5V7SjMnp+xGH1biepMjzY5zj12nbQvHhqFJBsReDC9sy
         Kao1y68F4nxRY69VzDy+jA4Dk2jTe/Yi2Mbd9Ro9FfwcYjltffNOE0dcdMWWAlfZiGHM
         Pa46zxnNW13UQabLtWEGdpP+nOti1olEEw1r9Z3YZ12FPn+uUDbOTM2EsJ3ikSisXDnt
         wVcw==
X-Forwarded-Encrypted: i=1; AJvYcCU0ghQ1rt/XHUBM9vFMtzTyJ3gRepUTQWDhj0oBq+tC3UkVleuNd8Y+qi9K37AU1WAyPZxxRXk1xfw=@lists.linux.dev
X-Gm-Message-State: AOJu0YypKVOUxoDWqY/jGQTlH1HfgFQEtkNIjSV5vz7F72XsyRI1QLk9
	mtEZj0lBj9l3xKoubkGpcnnCPxcHYzdAqrdTiMfq+tKyT4tG8R1hKquJ
X-Gm-Gg: AeBDievL5lb+2mnOegb2hpKq/pcAqeFLTZDG4FKiJppU5aaYDhy8PbDa3+XnZww8usU
	ELqxkkv+aB78X0ZyWDpniHkLEonBa7Ztxk80unLRYRZO+i/uEBLJh1NKDFRGqMPGGBvgIyEagfn
	Ut9GVOJ9eehuIauu3HMQWrk7w3G5LEy1u47IFV5mFlKJnoEQQ0rQcuS6/p69A5vu/O/WRpDrvCu
	C2deE7gGAZvXCGWGIJmDbTYdRriLvfNr25k0/ZOf+nTCaqrdaT5drB0Fq9PtmRyfjr0lnIFWO5E
	6t/5jDWODQCOvggFKh9s4gUXX7WIBZsSrVgExxAYUSlruvY0Wcf/DDYI5loZ0Z3GTLN9m3UMW/g
	Ph9yYsWJnrzV3z58SFnEUlvbc6hHls+qpTrVKK47u6kkCye3bN8gyUshZGEzAjxKgpLyQCLKBZN
	HQjppVkjOBUNv/xUv02lElzMsbvJ/Y
X-Received: by 2002:a17:90b:3dcb:b0:35b:e4d7:9694 with SMTP id 98e67ed59e1d1-35e4286b542mr6096456a91.19.1775888262703;
        Fri, 10 Apr 2026 23:17:42 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:f9ee:2f06:c88b:ecc9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e3517f2a0sm11526596a91.17.2026.04.10.23.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 23:17:42 -0700 (PDT)
Date: Sat, 11 Apr 2026 14:17:37 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, sched-ext@lists.linux.dev, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Juntong Deng <juntong.deng@outlook.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.1] sched_ext: Add verifier-time kfunc
 context filter
Message-ID: <aa6dotiucffrhwylwuwezvmtkew5ekzcnpt2eb4vvf2yquame4@ewd3arfzvozy>
References: <20260410063046.3556100-1-tj@kernel.org>
 <adk3PF5tJOwJbeop@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adk3PF5tJOwJbeop@gpd4>

Hi Tejun, Andrea,

On Fri, Apr 10, 2026 at 07:45:32PM +0200, Andrea Righi wrote:
> On Thu, Apr 09, 2026 at 08:30:36PM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > This moves enforcement of SCX context-sensitive kfunc restrictions from
> > runtime kf_mask checks to BPF verifier-time filtering, using the BPF core's
> > struct_ops context information.
> > 
> > This is based on work by Juntong Deng and Cheng-Yang Chou:
> > 
> >   https://lore.kernel.org/r/20260406154834.1920962-1-yphbchou0911@gmail.com
> > 
> > I ended up redoing the series. The number of changes needed and the
> > difficulty of validating each one made iterating through review emails
> > impractical:
> > 
> >  - Pre-existing call-site bugs needed fixing first. ops.cgroup_move() was
> >    mislabeled as SCX_KF_UNLOCKED when sched_move_task() actually holds the
> >    rq lock, and set_cpus_allowed_scx() passed rq=NULL to SCX_CALL_OP_TASK
> >    despite holding the rq lock. These had to be sorted out before the
> >    runtime-to-verifier conversion could be validated.
> > 
> >  - The macro-based kfunc ID deduplication (SCX_KFUNCS_*) made it hard to
> >    verify that the new code produced the same accept/reject verdicts as
> >    the old.
> > 
> >  - No systematic validation of the full (kfunc, caller) verdict matrix
> >    existed, so it wasn't clear whether the conversion was correct.
> > 
> > This series takes a different approach: first fix the call-site bugs that
> > made the conversion harder than it needed to be, then do the conversion in
> > small isolated steps, and verify the full verdict matrix at each stage.
> 
> Thanks Tejun, Juntong and Cheng-Yang for working on this!
> 
> I've done some basic smoke tests with this and everything seems to work fine so
> far. I'm planning to run more extensive performance tests, last time that I
> tried to brutally comment out scx_kf_allowed() I was getting some small but
> consistent performance improvements, so I'm expecting to notice something
> similar with this one. Will keep you informed.
> 

Thanks Tejun for the rework. The original patchset was indeed hard to
review and maintain, which is a great learning point for me moving forward.

Thanks also to Andrea for the guidance, and to Juntong for letting me
pick up his work.

Regarding selftests: do we need to add any for this series?
It was brought up during the review of Juntong's v3 patch,
but I haven't seen any further responses regarding this on my v4 patchset.

Happy to help if anything is missing!

-- 
Thanks,
Cheng-Yang
