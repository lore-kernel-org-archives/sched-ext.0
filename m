Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AE3B52F8
	for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855826; cv=none; b=chdJfmgUtQBcfreR61EwVF2+bq7OGexScaFSuoYPtVvD1wXv6SLhIyMPamx0yM6iyF/D7lLFVIoZOsd/DiBr2SWgHrZY42Ku0gV13RxRkiHuBrU4+sdCN5RPm7IG6d+hDoXwqC6qE05gC/Not5vD7B5vuaS0gD36QyQaDeBBde8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855826; c=relaxed/simple;
	bh=CjU0358U1/5AHjAWR9xzLk+PuJeX9FPs8v8bXBKXxMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcHB0ThWByLbBlAl+jTkfkb1r76XVrMUInSrcnQ71smb+0zs1a1G7GmWP3jStb0QI4qNppJVYWohF7NApiIdxrg8J2crEJ4mPcOQ/ateaxrQtFUcJSNdt0nCeM/keBwrV1N7TwwDcNIAFr0e5PlEKUp0FNzLp6XT+1AzjM3Meds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtW6Pfp7; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtW6Pfp7"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-439e43d16bdso2046261fac.2
        for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778855824; x=1779460624; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A4ev7sq/U5mk25xsko5vJ4vo9GwfIgGj+iQH9gME8aY=;
        b=mtW6Pfp7AemvwFAs9bEU/k6uz8JqyPVjArDikZM68Xezx4vnglQQiE6mBkjvzYR9rV
         SZsyhyGA17H0GAxV4EdnPTyXtwaQWrsiE1/uGStxa+rBpvv06SZljlTLCqAQwAnIb31E
         lrO0sP1sGFPjAk1dcfUpIHV7uZ2q4QmdG7fs/vVhLR5rcY0+z0LXFB6vIvzPHn1I6QSM
         zmzoOwir05GOzjNy6nLrAnq6ioVRkhfmDCBrj0/JRIlyV9QdLet71Z5gdfsv/gWkyYnj
         45UNtP1VbIzsQMn+a3ze4dxMh2cDCB66bmwY6pxAMvuwAXu9KAoyIJ170t05clI7CQ2K
         WvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778855824; x=1779460624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4ev7sq/U5mk25xsko5vJ4vo9GwfIgGj+iQH9gME8aY=;
        b=rbcHmH5YCWEMnSx34uQnLIQUgNEDv7z1TWWufoYUpS9qJ9ABmRDvJxOQrZLJ3NWJlf
         apAoBieMFJHSVg0b1SDoXy/DcGSKFfBijyQ5vWQMKPSnLdUkm1PQVlX02lRWFBlcP69w
         OJupEXwyNHIjxHs5KCfND3v6d5Wz7ABXJ8e1thbzOS9OS2rw78Xfq7E1YGux9p1mFn3n
         Rz0FVQOInI/xrH3rX2gPqRWyFCta8fJqd3EvXdoXu4BboLVSQ99zy8JRVa9lgVFwz/uo
         T/zvGL3S+nYOFiapyBloe0dOIyvvwPgGlVKSAHOap0TxaOxy6s4ZIWAGAoNTF17QCe+2
         UGQQ==
X-Gm-Message-State: AOJu0YyD30nMNuFukyRCY1Agry87wC7TCs3CG+Rqhsvwf/l9HqajyDbd
	hbSvdQ6BY6ea+NfOI5kkVs6kQ/VU+fqTnpUffNXK3vgbsHukVc9SOc6O
X-Gm-Gg: Acq92OEQx1g+6qku6Pvs0TvccwUlOpLL95xiMP4AKacyXVYisBaAzsIpshEHSGIl6g+
	9XvVvIlIBGh++TGarYgNA8/xXKcdhuo3HJhiI7RjLy/IIwSI69klqTlXqIZ32MrzmXEoTl86I1w
	/TlndGdobcC0HpsvzKwTfZd4mU5ZYAEmV6qs18vp6JGx+HnaSCAOC2iXGIk5iXNZBbnnD9d2HAy
	bD/yc2xCsrA5GHFzAl916Ydbw7a8Jf/c006Ds66YOBgHVMLEYqOTKP27GUSh3ieacEjCKvcdMP8
	ZLbJYEMEGShdGc2ygnsEMuPOtlzXRGA6uQgvQbDNZ9/3/NQIJ24z1YAus7gQyFzzNxkV5aOASSQ
	9EFX6Hhqu/RnkARONWsKwScvkSTqV2Y8UUO0uizmuDZ+ggFwmv5MssXYauPV5lowMZDwcpGdUSO
	DWL0gbyvyWMzWzdq1Ezubb4mChwzXnRbbGE/9llZ9AI0l6DMZjeVGiOMJxsion8/kikYpzlVFd+
	oU=
X-Received: by 2002:a05:6870:3346:b0:42c:d8b:5aad with SMTP id 586e51a60fabf-43a2de94cfcmr2585936fac.33.1778855823543;
        Fri, 15 May 2026 07:37:03 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-72-95.dynamic-ip.hinet.net. [36.225.72.95])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc4dcb89sm4333601fac.12.2026.05.15.07.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:37:02 -0700 (PDT)
Date: Fri, 15 May 2026 22:36:58 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Kuba Piecuch <jpiecuch@google.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 1/2] sched_ext: Add dispatch transaction API
Message-ID: <20260515221149.Gaf09@cchengyang.duckdns.org>
References: <20260509191223.168648-1-yphbchou0911@gmail.com>
 <20260509191223.168648-2-yphbchou0911@gmail.com>
 <agCQ28NVEIaQDHPP@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agCQ28NVEIaQDHPP@slm.duckdns.org>

Hi Tejun,

On Sun, May 10, 2026 at 04:06:19AM -1000, Tejun Heo wrote:
> On Sun, May 10, 2026 at 03:11:56AM +0800, Cheng-Yang Chou wrote:
> > -static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
> > -				  u64 dsq_id, u64 enq_flags)
> > +static void scx_dsq_insert_buf(struct scx_sched *sch, struct task_struct *p,
> > +			       u64 dsq_id, u64 enq_flags, unsigned long qseq)
> 
> Please don't mix rename and functional changes in the same patch. Can we do
> scx_dsq_insert_stage() instead?

Seperated into its own commit using scx_diq_insert_stage() in v4.

> 
> > +/**
> > + * scx_bpf_dsq_insert_commit - Commit a dispatch transaction
> > + * @p: task_struct to insert
> > + * @dsq_id: DSQ to insert into
> > + * @enq_flags: SCX_ENQ_*
> > + * @token: token from scx_bpf_dsq_insert_begin()
> > + * @aux: implicit BPF argument
> > + *
> > + * Like scx_bpf_dsq_insert() with slice=0, but commits a dispatch transaction
> > + * begun with scx_bpf_dsq_insert_begin(). If @p was dequeued or claimed
> > + * between begin and commit, the dispatch is silently discarded. Use
> > + * scx_bpf_task_set_slice() to set a non-default slice.
> > + *
> > + * Returns %true if the entry was buffered for dispatch, %false on preamble
> > + * failure (e.g. @p is not owned by this scheduler). Note: stale token
> > + * detection fires asynchronously in finish_dispatch() after ops.dispatch()
> > + * returns. A %true return does not guarantee the task was actually dispatched.
> > + */
> 
> I think this needs more detailed documentation. It's difficult to tell what
> it provides and why one would want to use it from the above and it's a
> pretty subtle thing.

Expanded in v4, the kdoc now covers the race scenario where scx_bpf_dsq_insert()
misses pre-dispatch validity checks, the intended usage with ops.dequeue(),
and the caveat that a %true return doesn't guarantee actual dispatch.

Thanks.

-- 
Cheers,
Cheng-Yang
