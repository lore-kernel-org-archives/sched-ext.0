Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFB0275AFB
	for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951144; cv=none; b=DzN4a66NKmJ3Exij6poXqAWfnQ+RrpJ/iDQPtwL3xCqbxhp7HFViX0cHzIFmKvePr1769OSet/rk9Fvi78Za6qsdYMSNUNRpIgfQhTIvhGYWk3Y3kZe/CcV1Ts0egVXXhe1kaVV13pNR/0xFnWFTu7x7dfELYlibWnbcSoOUfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951144; c=relaxed/simple;
	bh=jsXtsggAeyiDql3NH+l5Ml75IjPlBUWMT0Ppryu4IOs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ui9NE8QV9Ivw6wSSca1biGVMZvse95ngAhub5DeAkilpYRyHckIUscB1p5vaDYuPu68fvOp5y4jbd9Mqon7KG/Gne2hZnYrzBSVCpoORXOT66XxqSJRWzc8R3eYfyxZv9WTsgdUUGMP6SwQzrpcTK7GC7Jd/E2nLh+8dj5Xh9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZg/JXaL; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZg/JXaL"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48a5523fd53so17507135e9.3
        for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776951141; x=1777555941; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a/7W0TaHNw+5a6v8mLmrLJrhufHg8u0tXJKdz0acvqg=;
        b=PZg/JXaLArCTCvHJHo6QCPtLumJRhAFoJ6bQnzaKXEV56VF/2YlNMfS/uselw9/20e
         ZB1Jko/dqVqwrVcrcqz8GYiBBi1kjLuRSVRIsFl3BfnMu0VBSK9iH4zNl+cfNmC9Ktl5
         p37+Ly//HoRfndt7X6H/943DO2aj+KjmGu1razfhMZsqNhFnY7QDF5h3xpCPRtPCHMg0
         Ze/KlBBUtIyPGdPVhceTLItoG6UZ4t3CInhm/4DIKP4dMtgsnFZrYkA1g0RvsRN89jBH
         2IycK70bJ3aW3TCXMojz0bUJ7xNK49pdbUolA/M6aKNypuJLBgewgRMRRZj2MwqvGRnT
         brTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951141; x=1777555941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/7W0TaHNw+5a6v8mLmrLJrhufHg8u0tXJKdz0acvqg=;
        b=k7qifJdMeXK3Ww+IVPr9VM5bsuYJt567M6P7j2hR4FCrtm4junAQVWURQzgKDYjfZ+
         NuV5WCh9sQhGjxLwn/5jnEWMxF7KzAjuR9kC2VVhvE8VIZj6rJYM95bBdjraNffxQ+sA
         bQ36BskWd2/+qS9qXCLi9+uYh01rAWDd9pYk76dwktJxaCgzJ1lvWeSdmkEg9kJRDI32
         Se4B3bpybmtmslBATcteaIDdrC5Rhr9/aBtBD1Y3f8WJMPGTrBzLP3Js0ln5nY/xTsdM
         Ola0wFR0IQozrTSZh1sAvbemtMgvjHW2rmMjr4PpT3QeAs1oLoNZoiXkrxilsguQ2vfY
         yNXg==
X-Forwarded-Encrypted: i=1; AFNElJ8w7+tEQUYd4MYPaZ3n6AKUIMmk6CTDmf6cjAyEdWNiLieSuPVureQMXUHonry3993vIoZGUhWoFQU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5ZlXaahRxjgRDHv5MbeqW1/3jXRdcA4d6CblKD1DNKvqaHdGB
	rriAxdfPxsSD2JP2Qzub22P3JBfWWd2fjarUMUmMGGUrdaJaw0qQe9gUH26NTxol/uoA6d6XkmH
	+T5zJpn863xr30g==
X-Received: from wrub15.prod.google.com ([2002:a5d:4d8f:0:b0:43b:47ce:83d1])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:14:b0:488:9e43:9690 with SMTP id 5b1f17b1804b1-488fb7451f1mr298196035e9.10.1776951141512;
 Thu, 23 Apr 2026 06:32:21 -0700 (PDT)
Date: Thu, 23 Apr 2026 13:32:20 +0000
In-Reply-To: <20260422142633.G7180@cchengyang.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260319083518.94673-1-arighi@nvidia.com> <DH6OUDJUQNA3.6L4YXJMME4KI@google.com>
 <abxl-xw7nt1jp5qT@gpd4> <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com>
 <acHJED4iAeytdC2l@slm.duckdns.org> <20260422142633.G7180@cchengyang.duckdns.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DI0KLDKWJBOI.2LVQ249QGVJI8@google.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
From: Kuba Piecuch <jpiecuch@google.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, Andrea Righi <arighi@nvidia.com>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Cheng-Yang,

On Wed Apr 22, 2026 at 6:33 AM UTC, Cheng-Yang Chou wrote:
> Hi Tejun, Andrea, and Kuba
>
> On Mon, Mar 23, 2026 at 01:13:20PM -1000, Tejun Heo wrote:
>> > The simple way to do this is to do scx_bpf_dsq_insert() at the very beginning,
>> > once we know which task we would like to dispatch, and cancel the pending
>> > dispatch via scx_bpf_dispatch_cancel() if any of the pre-dispatch checks fail
>> > on the BPF side. This way, the "critical section" includes BPF-side checks, and
>> > SCX will ignore the dispatch if there was a dequeue/enqueue racing with the
>> > critical section.
>> > 
>> > With this solution, we can throw an error if task_can_run_on_remote_rq() is
>> > false, because we know that there was no racing cpumask change (if there was,
>> > it would have been caught earlier, in finish_dispatch()).
>> 
>> Yeah, I think this makes more sense. qseq is already there to provide
>> protection against these events. It's just that the capturing of qseq is too
>> late. If insert/cancel is too ugly, we can introduce another kfunc to
>> capture the qseq - scx_bpf_dsq_insert_begin() or something like that - and
>> stash it in a per-cpu variable. That way, qseq would be cover the "current"
>> queued instance and the existing qseq mechanism would be able to reliably
>> ignore the ones that lost race to dequeue.
>
> Since this has been stale for a while, I prepared a patch to implement
> scx_bpf_dsq_insert_begin() as suggested.
>
> Is anyone else working on this? If not, I'm happy to send the formal
> patch to fix this.

Thanks for creating the patch. A couple of thoughts:

1. Do we have a use case that requires dsq_insert_begin() that isn't
   satisfied using the "insert and then cancel if needed" approach?

2. Do we want to restrict ourselves through the one qseq slot provided by
   dsq_insert_begin()? The most flexible approach IMO would be to simply
   allow BPF to read the qseq directly via a kfunc and then supply it to
   dsq_insert() later. With this, we can have multiple qseqs saved at the
   same time, and we can even pass them between CPUs, e.g. if one CPU
   dequeues a task for a sibling CPU, but we want the checks to be made inside
   the sibling's ops.dispatch() (I just made this use case it up, it may not
   be practical.)
   That said, exposing an internal thing like qseq to BPF may be a step too far.
   Let me know what you think.

Thanks,
Kuba

