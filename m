Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2423AF65F
	for <sched-ext@lists.linux.dev>; Mon, 27 Apr 2026 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280785; cv=none; b=hOJhupennK1nt8ZWQfzjJyCv2yaOP0hfITxcq3Ynz9hLl+vlACr2hj6Ye4lLaLAlLPzZtHGRp885tSeKb4NROrt4HEIHTABS5t4ZIw6Dfoti4t6tE7VV2kkGlhVOqNVaBacDnwlqzlSLvx204OaJhXjI0s6OOZoa3mhPsix0Vbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280785; c=relaxed/simple;
	bh=qapGThUHyVCSxW/eeLGXzH+oKrPRdyf0nmL4ia3jwUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kfki21YCJ3CRoyq9f/DRzXw+NA9XVgb7fbkf64bEmcHWMRNUBm9d6qGSxsiDZF16uNYwBEtFJ3y/+vYe8HRv4MS9Mt/3zvexdeehAPI3D98Uv2QNcAGLO1n/D3BdHhnSPOD5KVXd+DGcUXrE1yoF4hUQRuuLVKeBqd67Gq1CXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M913yQA6; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M913yQA6"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-488d3eec9bcso64645235e9.3
        for <sched-ext@lists.linux.dev>; Mon, 27 Apr 2026 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777280782; x=1777885582; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mx+V2poUP+0vkGaI+fENdAYbWJNUG6uIm2ffDmTQpX0=;
        b=M913yQA6CblUhEb3mo3k3dIDE3fOei8uqJzf6P0Cy7HLucgt4xtjpfcxdaea8jtR9h
         wYqn7IPLdbkqXk7Fp9TGOV/SPoRszVpHrkne64OZEq55xZZXDI6i1SlqFaiJGdbUd4Wb
         HvAm+pgIEV98VlVi9ivrCmzXU4VI0RxM0IyXExOEt/3u23oeo4kP3nRu8/Fts4y5scjJ
         Jdg31P3hq5KeyIpFYiXkEdW578hmaBKloLITxRsM1jSrBXzmpJ9CTzBKvxdhiUb8tayM
         5hzTruLBaofLtBiOx1yV34WUP1+hv8ZjpqJLaf83R+OQbAcjuOvHoId4AP/5kq/gnN9i
         6Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777280782; x=1777885582;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mx+V2poUP+0vkGaI+fENdAYbWJNUG6uIm2ffDmTQpX0=;
        b=Q0NcJ7+L5ezQHxwRrQqmjpG7XtZkyIaRDmkyQJwQTQknIUvHou7TQU2y0baaVmaUZ1
         6163P1M/O1Gjf5GNTpLJ+4ezMjrBO4hdfKI8tgczdDqyS7cZ2ndMxTnumKV3YwplXDuF
         9CXpbAXt260j0Gv7Nn9KnD/oIIy4fzX745t0PbMYsW+x3OxVzljqE1lK29X1E9nL4pQg
         i5XiKymMuc/MfxlKXFT2xRQnUoKxBxkOuON4cxGi1oZbDRwClNBGAgi69WGOChKnffkt
         nnpKKGCScVDj4I9Cfep2vUN3mmJvXQkT24kLfvO4NVM128FDCSnoH3UrWLq5vv+5V7tW
         quxw==
X-Forwarded-Encrypted: i=1; AFNElJ/l2XXgxiC71vcdFlpT60NK0Dyw49JlKeR5YSz72UNjx0tGNde5/Iz5zPcdMrQQSfhALCGzDyKhNpU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxndAz2VTrhYQwJfnna63X8sUUNHAdUQ3sqwysPmoTJlT2Y/hvO
	4hQq8951LasSdNaFcbjz+H4Aa+lQAglJIIQYpGmsg8AH252NtXd1AIFHeG1Zbbxlx/zHu7eqQYc
	jr68frjRX4lAjeA==
X-Received: from wmbjj12.prod.google.com ([2002:a05:600c:6a0c:b0:485:3f38:3dd2])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a305:b0:48a:53cb:85f4 with SMTP id 5b1f17b1804b1-48a53cb8734mr312053805e9.24.1777280782437;
 Mon, 27 Apr 2026 02:06:22 -0700 (PDT)
Date: Mon, 27 Apr 2026 09:06:21 +0000
In-Reply-To: <20260426093756.Gd781@cchengyang.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260319083518.94673-1-arighi@nvidia.com> <DH6OUDJUQNA3.6L4YXJMME4KI@google.com>
 <abxl-xw7nt1jp5qT@gpd4> <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com>
 <acHJED4iAeytdC2l@slm.duckdns.org> <20260422142633.G7180@cchengyang.duckdns.org>
 <DI0KLDKWJBOI.2LVQ249QGVJI8@google.com> <20260426093756.Gd781@cchengyang.duckdns.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DI3TFV6PNXZ7.3OR8GY5SBIEZ7@google.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
From: Kuba Piecuch <jpiecuch@google.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>, Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng-Yang,

On Sun Apr 26, 2026 at 1:47 AM UTC, Cheng-Yang Chou wrote:
> Hi Kuba,
>
> On Thu, Apr 23, 2026 at 01:32:20PM +0000, Kuba Piecuch wrote:
>> > On Mon, Mar 23, 2026 at 01:13:20PM -1000, Tejun Heo wrote:
>> >> > The simple way to do this is to do scx_bpf_dsq_insert() at the very=
 beginning,
>> >> > once we know which task we would like to dispatch, and cancel the p=
ending
>> >> > dispatch via scx_bpf_dispatch_cancel() if any of the pre-dispatch c=
hecks fail
>> >> > on the BPF side. This way, the "critical section" includes BPF-side=
 checks, and
>> >> > SCX will ignore the dispatch if there was a dequeue/enqueue racing =
with the
>> >> > critical section.
>> >> >=20
>> >> > With this solution, we can throw an error if task_can_run_on_remote=
_rq() is
>> >> > false, because we know that there was no racing cpumask change (if =
there was,
>> >> > it would have been caught earlier, in finish_dispatch()).
>> >>=20
>> >> Yeah, I think this makes more sense. qseq is already there to provide
>> >> protection against these events. It's just that the capturing of qseq=
 is too
>> >> late. If insert/cancel is too ugly, we can introduce another kfunc to
>> >> capture the qseq - scx_bpf_dsq_insert_begin() or something like that =
- and
>> >> stash it in a per-cpu variable. That way, qseq would be cover the "cu=
rrent"
>> >> queued instance and the existing qseq mechanism would be able to reli=
ably
>> >> ignore the ones that lost race to dequeue.
>> >
>> > Since this has been stale for a while, I prepared a patch to implement
>> > scx_bpf_dsq_insert_begin() as suggested.
>>=20
>> Thanks for creating the patch. A couple of thoughts:
>>=20
>> 1. Do we have a use case that requires dsq_insert_begin() that isn't
>>    satisfied using the "insert and then cancel if needed" approach?
>
> IIUC, yes. scx_bpf_dispatch_cancel() is only registered in=20
> scx_kfunc_ids_dispatch, so it is only callable from ops.dispatch().
> dsq_insert_begin(), on the other hand, is available from both
> ops.enqueue() and ops.dispatch() (SCX_KF_ENQUEUE | SCX_KF_DISPATCH).
> Since there is nothing to cancel in ops.enqueue(), the insert-and-cancel
> approach simply doesn't work there.

Wouldn't the natural thing then be to extend scx_bpf_dispatch_cancel() to
work for direct dispatch? Instead of introducing a whole new mechanism, let=
's
extend the one we have by functionality that it (arguably) should have had
from the beginning.

>
>>=20
>> 2. Do we want to restrict ourselves through the one qseq slot provided b=
y
>>    dsq_insert_begin()? The most flexible approach IMO would be to simply
>>    allow BPF to read the qseq directly via a kfunc and then supply it to
>>    dsq_insert() later. With this, we can have multiple qseqs saved at th=
e
>>    same time, and we can even pass them between CPUs, e.g. if one CPU
>>    dequeues a task for a sibling CPU, but we want the checks to be made =
inside
>>    the sibling's ops.dispatch() (I just made this use case it up, it may=
 not
>>    be practical.)
>>    That said, exposing an internal thing like qseq to BPF may be a step =
too far.
>
> In Tejun's reply back in [1], he suggested dsq_insert_begin() precisely
> to avoid promoting qseq into the BPF ABI =E2=80=94 which matches your own=
 concern.
> The single per-CPU slot is sufficient for the one-task-per-iteration
> dispatch loops used by existing schedulers (e.g., scx_central).
> If a concrete cross-CPU use case materializes later, we can always extend
> dsq_insert() to accept an explicit qseq without breaking the current,
> simpler path.
>
> [1]: https://lore.kernel.org/all/acHJED4iAeytdC2l@slm.duckdns.org/
>

Well, Tejun doesn't explicitly say there that he's against exposing qseq, b=
ut
I won't be surprised if he is.

FWIW, ghOSt (our Google-internal BPF scheduling solution) uses exactly this
approach to guard the dispatch path against racing dequeues/enqueues.
Every task has a seqnum that gets incremented on each "event" pertaining to
the task. In the dispatch path, the BPF scheduler reads the task seqnum,
does whatever checks it needs to do, and passes the seqnum to ghOSt at the =
end.

Admittedly, what works downstream doesn't have to work upstream, but I stil=
l
wanted to provide this data point :-)

Thanks,
Kuba

