Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6E169AD2
	for <sched-ext@lists.linux.dev>; Sun, 26 Apr 2026 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777168079; cv=none; b=SRYdm6hN0e83748hno5P3PHqvSJGcoDpg3e+lKg5TTGwpDdCU7HMe9S3MvQ2ld9iWE9+1gHUH+i9imexeqSrJxx4ebOIYGniuRw34HEFq5sAdeYACOCfdK1S2X/i3pl3TNvXtyORK0ipQRxcpaWE3/bEgPBr0fXG9pb7dyVy9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777168079; c=relaxed/simple;
	bh=QrvqSDc041TNuXNt3BBlwMz8vZoL2QGWRmws13hXG+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSNx++daRDgcvPADuUnN/hbQ8WtT/Io3Y+xsc9o8bmOpHBXhj7pPNOmZ63/ioGYsIFOxKGYfRmzcUY7CHdxyuIaVIi2OFaAuThDc3u+m/g0bkwzdPuGw1qY4toAfyCCUMZl2Ry0DKa69Hrvv/Wij8WUlwECKAtevULeGIvKDQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgKchmHK; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgKchmHK"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so5989859a91.2
        for <sched-ext@lists.linux.dev>; Sat, 25 Apr 2026 18:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777168077; x=1777772877; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RL7xdU0D39uNUreJOg8ut3Rg0sXkiiyngpi4Y/rXepg=;
        b=FgKchmHKj+jl4stIoafa/xweUtdRiByQVPzxbQmbD88KmskAE8d5W4hHWtJJVK7dLB
         amA4hGfHs2d+uMj/c0Jdf20uvfGkQcybRoGQzBkv6E51S/b73s+Fxu+/Di8RHPxWYMPR
         r/cRBYSn3g/K+uoQhbewsw3Vg7X6HNTQiyxbnkbteVIGy5uvYdIB+6tO96+Tp+caoncs
         /umnDLLh1qsgP9TDyA47YhAvsPmbgp3p/hkBe25+CR5jv17Am59GbmnF11v1pNOBwuCs
         QImwJIxFFT6H3td71khJPT3EDgbHHzzxEHLzv9S5o/v/+PTcxSL0brJ4vYCSg7zr/Qjw
         JbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777168077; x=1777772877;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RL7xdU0D39uNUreJOg8ut3Rg0sXkiiyngpi4Y/rXepg=;
        b=r8XmWev9MRlSq+u/2OoAV6ziwoRKSylAjuQY6P28j1aW8/l1V+9YCcj/3BhJavOXJ2
         FDu3GDIuwxxuiwrC9PABAs9f4NN8cMYeJlCL5nv6ZQvhQTIAapdMX0JWsugeg3MZXRfm
         TwkVvRI7vPPae5DcLEmoTFxPgePCSB9WgvTwzWfQowsbf+UH7egzRJiaBD7I11ywYif4
         7YmsKn8XYfMtegTUI4lxoAsYdDDyFF7iENugi3PbjjwyN5oUKwvv9RSIhQ8yFjc5Mbrm
         ZtD85LzMjW83o+Sjeo7VTIx4ubnhZ0N0qkPCKnIU8vuTlf517qMdQbLx9ch/55GOjzxM
         jFrw==
X-Forwarded-Encrypted: i=1; AFNElJ9e4MnKY1xMiFMslzFKronKr8TR3OYwBV5am2Rd8y9iLuR/4OPj83Idk4gXnuH/YSkfxesTM5TYcp0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxKsytlCyuErD9dEMlxupMeFsuXOMEARWmydVgH6jkPZ7bktG2L
	MzTEr9/UKeOF/jinOJZ7ANQIzizEo8laeAwrCBjQA0ngeBEKG33K3fOS
X-Gm-Gg: AeBDieuSgRHboWL2+vSCFVsf3X1OZnfmwXVw6tHr4EaPvX9Ek4j7eBvwTgijcwAmtjq
	NbZTDoUS6e58Uzm0tt6rh2RYbaIwKiocYQDLEAt+Uuic06x7a6dg0abcOxHcW31bt+jf4sOOZww
	FYXX0LLmchH/o1hQB2fLvEbNgRHMEGSHVkxW3Em6S6bwe2CC3A+8kD+n56NHpU/R312T1ETTMXm
	QZ6TNDza+kspbq9Lv0U6qB7N3N00ygojzbylLdPPDnySYzVKXjHSWsSjFxc5nUMyZfrIVmvCzuB
	7zcAN6e2pPGqQNbiOmkT8U1u4CWc5pXZt7p8h8IHv1of9TS0GKsX176OSdOWtQ0sO03K6BMwuNu
	EHzrL5pw1uxdoRFpK0J1osmncdL4g+5x48x3hLkdR59mptbTO8MXqkIagiTbFDKan9mcoQ+HzGM
	ooCC9DDNaqRTb46gVEMDN8Zj3BchX7q9id97TE9Oqx5749LDr/e0GCuJZ8+peo8cdaWSi8iwqxl
	1Vr11NKAyof7NPR
X-Received: by 2002:a17:90b:3504:b0:35f:bb33:d727 with SMTP id 98e67ed59e1d1-36140478be0mr37352571a91.20.1777168077417;
        Sat, 25 Apr 2026 18:47:57 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-83-234.dynamic-ip.hinet.net. [36.225.83.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141973c57sm27058415a91.14.2026.04.25.18.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 18:47:56 -0700 (PDT)
Date: Sun, 26 Apr 2026 09:47:53 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
Message-ID: <20260426093756.Gd781@cchengyang.duckdns.org>
References: <20260319083518.94673-1-arighi@nvidia.com>
 <DH6OUDJUQNA3.6L4YXJMME4KI@google.com>
 <abxl-xw7nt1jp5qT@gpd4>
 <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com>
 <acHJED4iAeytdC2l@slm.duckdns.org>
 <20260422142633.G7180@cchengyang.duckdns.org>
 <DI0KLDKWJBOI.2LVQ249QGVJI8@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DI0KLDKWJBOI.2LVQ249QGVJI8@google.com>

Hi Kuba,

On Thu, Apr 23, 2026 at 01:32:20PM +0000, Kuba Piecuch wrote:
> > On Mon, Mar 23, 2026 at 01:13:20PM -1000, Tejun Heo wrote:
> >> > The simple way to do this is to do scx_bpf_dsq_insert() at the very beginning,
> >> > once we know which task we would like to dispatch, and cancel the pending
> >> > dispatch via scx_bpf_dispatch_cancel() if any of the pre-dispatch checks fail
> >> > on the BPF side. This way, the "critical section" includes BPF-side checks, and
> >> > SCX will ignore the dispatch if there was a dequeue/enqueue racing with the
> >> > critical section.
> >> > 
> >> > With this solution, we can throw an error if task_can_run_on_remote_rq() is
> >> > false, because we know that there was no racing cpumask change (if there was,
> >> > it would have been caught earlier, in finish_dispatch()).
> >> 
> >> Yeah, I think this makes more sense. qseq is already there to provide
> >> protection against these events. It's just that the capturing of qseq is too
> >> late. If insert/cancel is too ugly, we can introduce another kfunc to
> >> capture the qseq - scx_bpf_dsq_insert_begin() or something like that - and
> >> stash it in a per-cpu variable. That way, qseq would be cover the "current"
> >> queued instance and the existing qseq mechanism would be able to reliably
> >> ignore the ones that lost race to dequeue.
> >
> > Since this has been stale for a while, I prepared a patch to implement
> > scx_bpf_dsq_insert_begin() as suggested.
> 
> Thanks for creating the patch. A couple of thoughts:
> 
> 1. Do we have a use case that requires dsq_insert_begin() that isn't
>    satisfied using the "insert and then cancel if needed" approach?

IIUC, yes. scx_bpf_dispatch_cancel() is only registered in 
scx_kfunc_ids_dispatch, so it is only callable from ops.dispatch().
dsq_insert_begin(), on the other hand, is available from both
ops.enqueue() and ops.dispatch() (SCX_KF_ENQUEUE | SCX_KF_DISPATCH).
Since there is nothing to cancel in ops.enqueue(), the insert-and-cancel
approach simply doesn't work there.

> 
> 2. Do we want to restrict ourselves through the one qseq slot provided by
>    dsq_insert_begin()? The most flexible approach IMO would be to simply
>    allow BPF to read the qseq directly via a kfunc and then supply it to
>    dsq_insert() later. With this, we can have multiple qseqs saved at the
>    same time, and we can even pass them between CPUs, e.g. if one CPU
>    dequeues a task for a sibling CPU, but we want the checks to be made inside
>    the sibling's ops.dispatch() (I just made this use case it up, it may not
>    be practical.)
>    That said, exposing an internal thing like qseq to BPF may be a step too far.

In Tejun's reply back in [1], he suggested dsq_insert_begin() precisely
to avoid promoting qseq into the BPF ABI — which matches your own concern.
The single per-CPU slot is sufficient for the one-task-per-iteration
dispatch loops used by existing schedulers (e.g., scx_central).
If a concrete cross-CPU use case materializes later, we can always extend
dsq_insert() to accept an explicit qseq without breaking the current,
simpler path.

[1]: https://lore.kernel.org/all/acHJED4iAeytdC2l@slm.duckdns.org/

>    Let me know what you think.
> 

Please correct me if I'm missing something, thanks! ^0^

-- 
Cheers,
Cheng-Yang
