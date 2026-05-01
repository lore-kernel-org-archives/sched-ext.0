Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE5F3E2769
	for <sched-ext@lists.linux.dev>; Fri,  1 May 2026 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777652411; cv=none; b=DgYciBQ2XyUOUBCnDSFj6v2BmkFAuG6j4GTK98PXwQ80YuZ2cBan55aQ0OXR2/uC7ES7TaSMD0DKye131pWuDE1EorLwF9FNDOWN+V+G3t+2rSYkbZokm0i/owMKMKBzUExCoIIsFMAPZm9OSyWcnGJHsZy74M1D8w0PtSTkzX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777652411; c=relaxed/simple;
	bh=pFHhAGjrWqlE3zlouvyixgqPtCaNd1s68oDlvq1IYa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpN3Fxa4QKJaqqWH35flDGLlEglb9Cbne99xegklJ/QH+9IlDPbmYSPH8mELiRK48cflRiA4WukpEQciVT2QTiVqxnDuhK2OjmsjwnFr6kuYvya+vGEppjEAPF/QgIv+yrIjDuA3JdpxxtLGs+A0N9vFD0geZlaCOVJU+irzmIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJrisgTb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJrisgTb"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so2401705a91.0
        for <sched-ext@lists.linux.dev>; Fri, 01 May 2026 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777652397; x=1778257197; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OartFn9vmQoF2kzuRmda/6if5JbGEfaXSR/oNU+kPz0=;
        b=JJrisgTbZ8rmewG+r9iVr8XhLBk7U9m+5YD3FleLPusBJbsh7jLKptseeohpXF8kYF
         9eRn8O97PRvKoSf+T3BxZwmVOAVx6Fg1VkKUdnBEggiixg/9k0YHpOcWPSfsa16GQ0rH
         wPPc0WlNlHeCvC7QXFx5fbiJhzz8waI9kpfUtIlvC+P6FNUa7aIXtH48xaup1WWg/i1q
         DBHjYFqI6iMp3ye2YBGClRLw2Nz6lDAkYFH2MMqavBvkNjW1lQJZlWBA7T431Rt/pEV3
         g9knulsoWAiWYFLWtGjrLJSzGWoutvqx9mr2oIfUrTzVWRgVadaRHL7CnVDfDCAnDmnm
         3n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777652397; x=1778257197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OartFn9vmQoF2kzuRmda/6if5JbGEfaXSR/oNU+kPz0=;
        b=BJ6ADVy4aOXdNqkWjrBUvg6qlTQEnuhKUqrF6l/0xx/kb103IYuz37md3kPcPro69j
         XV64VcprJE5plvz7y9fTUy83GYZ/1xUKMf6G+LVmPPbjn5cqoAuE3CzpAWHn7lOqGAxP
         QFQZ/yvm8+rSj3kvVfyWxeMdAXJXuUqKI+4o/5IwE49KvXZXKKLWg4kJpCk6/fgAIUG9
         mLnW/z+MTudry0RGZ58hC5ZYSRmY+ZBT4qkCxWsjD0CywNbIn+UQ+fZDGMRiAXxG9apy
         qBEseULbzQSeUGmFe39lzN1eKFmWncci7ugH7s02d6a7FDZAeBIATRsT/quqt++EwFno
         7DEw==
X-Forwarded-Encrypted: i=1; AFNElJ/j4LgBPyuXK404foFvv7s/D8mIqjak342ZAEpKEGYqeOEifA+6KMb23O9XTxk8rDBpAFCcGMTVNdg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzKkoyY+cLSP8tSPCdHJY+PtZWoX68UewvBvxKztpv8F3cLB0iJ
	IrD47RGsTACiuFNFq5O6a33G776rqWGMWAVqgdR3A3Bn2UndoBVHdBpd
X-Gm-Gg: AeBDieuA0hUl6ViRDg0GSBi/phvSpA/W8KYoCXH4g9VaIC1FSJAPlDd9LI1jnwrpovA
	uwEpTBGhZSH42aT3zPhYx24tXMfhZs/0/9a4+9vN8Y9HgvjcPZsdcSFJo+bm1eHYFXXfnWsgg2y
	sjOjkIeS+X0UttBH//2zkvIx3dpZO/zDs0bYvagpUtkm9QlSH7s/IPRwesLlLDYR6PGuyqDVaUh
	YbBJKsGHTVyuV8zNmVjVChNVaBM5l1JsYR3AL7E4v/8K/5TXFqM+XLkXll1zQRUIAwwU4RpsU4T
	YRwBRYZsGQfZ9GgKhaA5JyfQLxPo/ESkRrPFEcVWS0dnCVcSn6474Lg+2uEjgViKbgPV1dDSM1X
	r1fyCAGdZ3Ulr5EEwMqaEI22G/bDapzrE61SA33ZYUseEfaCqrNp2hzL/3pGoVwAL4ujIsRRSQs
	jb+JuDF5OnsZF2SNZOB8wI8ABnbSEcQm7SZA5DcaK0rpy/RZ2g/Nf7jwIdTX+NFPmsH/IMN+lEf
	tVtbNltBpMJPGwB
X-Received: by 2002:a17:90b:1dca:b0:35f:b293:7ac6 with SMTP id 98e67ed59e1d1-364c2fe3ec9mr8416481a91.6.1777652396759;
        Fri, 01 May 2026 09:19:56 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-77-225.dynamic-ip.hinet.net. [36.225.77.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7ebe8sm31062495ad.2.2026.05.01.09.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 09:19:56 -0700 (PDT)
Date: Sat, 2 May 2026 00:19:52 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
Message-ID: <20260502000039.Ga94c@cchengyang.duckdns.org>
References: <20260319083518.94673-1-arighi@nvidia.com>
 <DH6OUDJUQNA3.6L4YXJMME4KI@google.com>
 <abxl-xw7nt1jp5qT@gpd4>
 <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com>
 <acHJED4iAeytdC2l@slm.duckdns.org>
 <20260422142633.G7180@cchengyang.duckdns.org>
 <DI0KLDKWJBOI.2LVQ249QGVJI8@google.com>
 <20260426093756.Gd781@cchengyang.duckdns.org>
 <DI3TFV6PNXZ7.3OR8GY5SBIEZ7@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DI3TFV6PNXZ7.3OR8GY5SBIEZ7@google.com>

Hi Kuba,

On Mon, Apr 27, 2026 at 09:06:21AM +0000, Kuba Piecuch wrote:
> > On Thu, Apr 23, 2026 at 01:32:20PM +0000, Kuba Piecuch wrote:
> >> > On Mon, Mar 23, 2026 at 01:13:20PM -1000, Tejun Heo wrote:
> >> >> > The simple way to do this is to do scx_bpf_dsq_insert() at the very beginning,
> >> >> > once we know which task we would like to dispatch, and cancel the pending
> >> >> > dispatch via scx_bpf_dispatch_cancel() if any of the pre-dispatch checks fail
> >> >> > on the BPF side. This way, the "critical section" includes BPF-side checks, and
> >> >> > SCX will ignore the dispatch if there was a dequeue/enqueue racing with the
> >> >> > critical section.
> >> >> > 
> >> >> > With this solution, we can throw an error if task_can_run_on_remote_rq() is
> >> >> > false, because we know that there was no racing cpumask change (if there was,
> >> >> > it would have been caught earlier, in finish_dispatch()).
> >> >> 
> >> >> Yeah, I think this makes more sense. qseq is already there to provide
> >> >> protection against these events. It's just that the capturing of qseq is too
> >> >> late. If insert/cancel is too ugly, we can introduce another kfunc to
> >> >> capture the qseq - scx_bpf_dsq_insert_begin() or something like that - and
> >> >> stash it in a per-cpu variable. That way, qseq would be cover the "current"
> >> >> queued instance and the existing qseq mechanism would be able to reliably
> >> >> ignore the ones that lost race to dequeue.
> >> >
> >> > Since this has been stale for a while, I prepared a patch to implement
> >> > scx_bpf_dsq_insert_begin() as suggested.
> >> 
> >> Thanks for creating the patch. A couple of thoughts:
> >> 
> >> 1. Do we have a use case that requires dsq_insert_begin() that isn't
> >>    satisfied using the "insert and then cancel if needed" approach?
> >
> > IIUC, yes. scx_bpf_dispatch_cancel() is only registered in 
> > scx_kfunc_ids_dispatch, so it is only callable from ops.dispatch().
> > dsq_insert_begin(), on the other hand, is available from both
> > ops.enqueue() and ops.dispatch() (SCX_KF_ENQUEUE | SCX_KF_DISPATCH).
> > Since there is nothing to cancel in ops.enqueue(), the insert-and-cancel
> > approach simply doesn't work there.
> 
> Wouldn't the natural thing then be to extend scx_bpf_dispatch_cancel() to
> work for direct dispatch? Instead of introducing a whole new mechanism, let's
> extend the one we have by functionality that it (arguably) should have had
> from the beginning.

I see. You're right that dispatch_cancel() could be extended to work in
the enqueue context.

I'm happy to go either direction, your approach or Tejun's suggestion.
Tejun, Andrea, sched-ext folks, thoughts?

> 
> >
> >> 
> >> 2. Do we want to restrict ourselves through the one qseq slot provided by
> >>    dsq_insert_begin()? The most flexible approach IMO would be to simply
> >>    allow BPF to read the qseq directly via a kfunc and then supply it to
> >>    dsq_insert() later. With this, we can have multiple qseqs saved at the
> >>    same time, and we can even pass them between CPUs, e.g. if one CPU
> >>    dequeues a task for a sibling CPU, but we want the checks to be made inside
> >>    the sibling's ops.dispatch() (I just made this use case it up, it may not
> >>    be practical.)
> >>    That said, exposing an internal thing like qseq to BPF may be a step too far.
> >
> > In Tejun's reply back in [1], he suggested dsq_insert_begin() precisely
> > to avoid promoting qseq into the BPF ABI — which matches your own concern.
> > The single per-CPU slot is sufficient for the one-task-per-iteration
> > dispatch loops used by existing schedulers (e.g., scx_central).
> > If a concrete cross-CPU use case materializes later, we can always extend
> > dsq_insert() to accept an explicit qseq without breaking the current,
> > simpler path.
> >
> > [1]: https://lore.kernel.org/all/acHJED4iAeytdC2l@slm.duckdns.org/
> >
> 
> Well, Tejun doesn't explicitly say there that he's against exposing qseq, but
> I won't be surprised if he is.
> 
> FWIW, ghOSt (our Google-internal BPF scheduling solution) uses exactly this
> approach to guard the dispatch path against racing dequeues/enqueues.
> Every task has a seqnum that gets incremented on each "event" pertaining to
> the task. In the dispatch path, the BPF scheduler reads the task seqnum,
> does whatever checks it needs to do, and passes the seqnum to ghOSt at the end.
> 
> Admittedly, what works downstream doesn't have to work upstream, but I still
> wanted to provide this data point :-)

The ghOSt data point is appreciated. If a concrete use case emerges where
the single-slot approach falls short, extending dsq_insert() to accept an
explicit qseq seems like a natural next step.

Tejun, Andrea, sched-ext folks, any preferences?

-- 
Cheers,
Cheng-Yang
