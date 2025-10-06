Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2F23BCEE
	for <sched-ext@lists.linux.dev>; Mon,  6 Oct 2025 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772109; cv=none; b=LwmetVGRgDuRzJSEyUnL9bzsutZ820h7a7GWYfZq64pbi8YC/5MkF7VMNIWSAAhsFVfLJEX1d5wolBYYUZYOfE1dJ5WY1AjXOG/bJEJK2bSosunEPE1dlvs4s40sSiZiU1bM71nkRIeZ5lD76BMNZdmtWaQW+YUQjsxUunBjbIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772109; c=relaxed/simple;
	bh=7G7lEHsdRFuPWTJ+Bg1G2NIO8iAqFG5hf7M2mDU7cUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXsTehB6zB6INg/9qwvfAU6voaHN6F3envegscx4pNQoqMPKNqpAWODEdRbXcwn2ATo5dBLER3CwzBkoeYVznEOY4dhn/uVQyZ4jXqD8BzsvlRmi1Ias8FuZ9Ucxe3slZP2Aj0ZPwo7ZdcC5jNExTDAx9WiQP7AzrOdeQlyntGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6s4eEZE; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6s4eEZE"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b553412a19bso3770882a12.1
        for <sched-ext@lists.linux.dev>; Mon, 06 Oct 2025 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759772107; x=1760376907; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3SYJP5oOId3gJHWkwqUX6EUfjqic+Th68f73mKwYp6Y=;
        b=L6s4eEZE30FRfoRfCNJucQimODeCNg3fCUq/Ub18/ULBcZtsakvLGSHYiS4YbEtOXm
         kFiJHF3Gdr007rZP29AhcGE6e1S/yZRELQmaVCi2K6dBjLKwdo+42ZL/1u4752Cp1no1
         2e+2W888HCdCTv6X5Zcw7zQ1O87eC1mhZsD3Gu4n4PW0ef/jKAx25M9OiyawQUIiJGBj
         /I7qlhPB2pA2gU6zGs0EydJJ3XfNO+o2XmeAtwFaJUfjUzfQm25dNeuvfZoZrd9T7smB
         13aE7z+8t/z5ig0hkhlv/0PkYTnLdI90khs7OprpPnK+ESmKYR+otYvpa/IIi/4D6LpD
         hOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772107; x=1760376907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SYJP5oOId3gJHWkwqUX6EUfjqic+Th68f73mKwYp6Y=;
        b=R4zy9gEwzIBY6KNlhSvBXlBnZkvxcpsaqDifL3mCAFufOwUIN0ZcuktEpy0ksITmi+
         QQWHCJgSDqiLJoxgwsfkFz74HS1E0D8I9gFKAPRbY/aX3+q5wJCErG6R0vvNR3XhwOum
         lXpiwKLAWCp+ve8iwEFfjWvFjcuBxjzQCdXH58AK3Wf3xfylwYb7zk6dctfKXz/TUC75
         BH/bvlsNB4sR35RYuKprZEIIGDGzVr9BCsDdkG6ztFdZl4xapIXFMjiPZctFgZNw9fSF
         Ah6aZA8/36gQV1rMZbNvgWjKrFKO0FyyU2s3Qk3FBiTZuuixHSEx4ZpCbcxiEHOyWAjr
         Uftw==
X-Forwarded-Encrypted: i=1; AJvYcCUngWkfV+g9QF0NhXJQl/c0JY36Pqjmhe8/BJC9w1QiJpE0XATEa/im9USCe6u2BG2ZS0edc1dKjG8=@lists.linux.dev
X-Gm-Message-State: AOJu0YwkMnrJwQYZcQF0aRFfFKOV2UxooO6ZBTmAe5bH3H2Ac+cxj1q7
	pdqUCTE5Sr/WtFQerebdG3j2Vgommokh1bpIsTFZaHmNKOJWDnFzmY/C7QZQTecZnUdzSLc83Ql
	OyOi+np2ZxyYV4D1b6bvDqgoh1P2UGMc=
X-Gm-Gg: ASbGnctsZGUPmBxPMmgJH82uhklv0GZlzOWUnpIZNmD/6hUC0VCwvwwICzWTqST2Lzq
	EWk6eiloGlYF+h4PiJnY7AlR4Wj3L93tHo7wavg52Y9tLElbtVsiXrARqHmEcC+yHV72N31slPy
	cuCHkXokCp+dIePr324GMHrj000u0uNsbijszkO3IKsZ0RKy16TjqgspfvzvdjjxNiFcmqx4K0T
	xHQQAgzxNY/bEj++qcUHd9rmSnUwRW7jE/Gc/kXC6Nj6TKo6oOX8A0Md2/oAlkt0tPWwu31
X-Google-Smtp-Source: AGHT+IF7t/5uimt4spMXHcCSvFX3PWO+3xbZeZW/6BTEqZvA6CGHFJvw6CuEVbkxxqCTitoWh5b/CNIY1RkDf+GFkFE=
X-Received: by 2002:a17:902:ccca:b0:27f:1c1a:ee57 with SMTP id
 d9443c01a7336-28e9a574b8emr150187535ad.16.1759772107216; Mon, 06 Oct 2025
 10:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251006170403.3584204-1-rrnewton@gmail.com> <cbc8d5bc-4ae7-4b61-81f4-9629857736f3@arm.com>
In-Reply-To: <cbc8d5bc-4ae7-4b61-81f4-9629857736f3@arm.com>
Reply-To: rrnewton@gmail.com
From: Ryan Newton <rrnewton@gmail.com>
Date: Mon, 6 Oct 2025 13:34:40 -0400
X-Gm-Features: AS18NWAICzboon-dCcAZVmLAwb0KjDAxIb0J9x4vN2jrS0oGI-oB8eLAAivDRiA
Message-ID: <CACYs5AbjoLKSv7SasUyJH=j6XF+3Zuyp_0CJUrnsA=8XDDW6bw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] sched_ext: lockless peek operation for DSQs
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, tj@kernel.org, 
	arighi@nvidia.com, newton@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Christian,

Sure, the lavd with peek is here:
https://github.com/sched-ext/scx/pull/2675

Beerland with peek is here:
https://github.com/sched-ext/scx/commit/c2a0f185051c06cc1ebae1dc40e5fe2bd30=
22c1e

The qmap one was not a meaningful change to the scheduler but just
extra peeks thrown in with debug prints.

Cheers,
  -Ryan

P.S. Good catch on the two newlines being split into the wrong diff.
Argh, I was playing with Sapling's `sl absorb` and I swear it said it
amended the earlier commit. Apologies for not catching it. FWIW here's
a tip with that correction:
  https://github.com/rrnewton/linux/commit/db426f852813e2b6deeae0869d20df1b=
ea647a07




On Mon, Oct 6, 2025 at 1:20=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 10/6/25 18:04, Ryan Newton wrote:
> > This allows sched_ext schedulers an inexpensive operation to peek
> > at the first element in a queue (DSQ), without creating an iterator
> > and acquiring the lock on that queue.
> >
> > Note that manual testing has thus far included a modified version of th=
e
> > example qmap scheduler that exercises peek, as well as a modified
> > modified LAVD (from the SCX repo) that exercises peek. The attached tes=
t
> > passes >1000 stress tests when run in concurrent VMs, and when run
> > sequentially on the host kernel. Presently, tested on the below
> > workstation and server processors.
> > - AMD Ryzen Threadripper PRO 7975WX 32-Cores
> > - AMD EPYC 9D64 88-Core Processor
>
> Is the adapted qmap and lavd available somewhere?
>
> >
> > Initial experiments indicate a substantial speedup (on schbench) when
> > running an SCX scheduler with per-cpu DSQs and peeking each queue to
> > retrieve the task with the minimum vruntime across all the CPUs.
> >
> > ---
> > Changes in v3:
> >  - inline helpers and simplify
> >  - coding style tweaks
> >
> > Changes in v2:
> >  - make peek() only work for user DSQs and error otherwise
> >  - added a stress test component to the selftest that performs many pee=
ks
> >  - responded to review comments from tj@kernel.org and arighi@nvidia.co=
m
> >  - link: https://lore.kernel.org/lkml/20251003195408.675527-1-rrnewton@=
gmail.com/
> >
> > v1 link: https://lore.kernel.org/lkml/20251002025722.3420916-1-rrnewton=
@gmail.com/
> >
> > Ryan Newton (2):
> >   sched_ext: Add lockless peek operation for DSQs
> >   sched_ext: Add a selftest for scx_bpf_dsq_peek
> >
> >  include/linux/sched/ext.h                     |   1 +
> >  kernel/sched/ext.c                            |  56 +++-
> >  tools/sched_ext/include/scx/common.bpf.h      |   1 +
> >  tools/sched_ext/include/scx/compat.bpf.h      |  19 ++
> >  tools/testing/selftests/sched_ext/Makefile    |   1 +
> >  .../selftests/sched_ext/peek_dsq.bpf.c        | 265 ++++++++++++++++++
> >  tools/testing/selftests/sched_ext/peek_dsq.c  | 230 +++++++++++++++
> >  7 files changed, 571 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
> >  create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c
> >
>
