Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC7175A87
	for <sched-ext@lists.linux.dev>; Thu,  4 Jun 2026 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539012; cv=none; b=iwYgbsw2y98HhC9tyn10IzJFqKPvGFC/OIOpUGWUSK0h/sfWVN2JHzImcAu42F+kNTuOHKBxQmK0jWOA4egFyO1pgd44mhNySbPDF6T6hvNHselkFuYiwJen3j2AA5FyIoTKcX7mc79fWhoFnTOic+5tHHSrOhhJ3kl+9H1r51s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539012; c=relaxed/simple;
	bh=W2LOOtFtfBzp4gEBkicWHsyJGX8we0gfhQoQN6Rws3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CBMXCTblK7uglbD7Mdqspl6ap5IXK0XSueEgSdESAOkk/uQqUFAvRGY6Qi+SFdYeUof5oMEfBRLd3n7zi/aidTlbrqaRK9TLpKxOGj8FDeH4zgP8KtqhqWnXqU9LhDPQgTbHNN6zawZDuezMc5oV3cEnZCWjVXhl39FtBWmhba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InIVX3uh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InIVX3uh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A771F00898;
	Thu,  4 Jun 2026 02:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539011;
	bh=T0rPkejHtSIxzTk/uZ5byqh3I9pZNQ65DkXcgcBqobg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=InIVX3uhaHP47mUQhXnxS48OEiYoblDSlsOtEOQDi2J3HTYn8z24wt+B4F/7WNVcn
	 EcpLHYUso5Hxj5bHFyl5treM+CnmXV/jjCAayrTLyt1hgygM88F8pG6LQCjVG2UwON
	 AoI+YjXOSFh2kAL4SlzyANQpqlijBYEPAFJn1xNOy9zhdArd6vFyI9kIjQESW/DQZF
	 SV6tJ9M54q8LYDoMJwu3F/yEuAWJMffaq+deg8DwjPJlocbkWm9QDs6+bJINZf14SA
	 7g9l0EPSuv39SsvrlWs6TxRiomni5gV9T6fEydsMzJajFNl0PWJZaSMhzmxdD8cZ6D
	 Hqk2D7BRhbQig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] sched_ext: Add scx_cmask_test() and
 scx_cmask_for_each_cid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260604020032.3536466-4-tj@kernel.org>
References: <20260604020032.3536466-4-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:10:10 +0000
Message-Id: <20260604021011.42A771F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `scx_cmask_for_each_cid` macro expands into two nested `for` l=
oops, breaking standard C iteration semantics for `break` statements. If a =
caller uses a `break` statement to terminate the iteration early, it will o=
nly exit the inner loop (terminating the scan for the current 64-bit word).=
 The outer loop will then increment, fetch the next word, and continue iter=
ating. This creates a trap where developers intending to completely abort t=
he loop will inadvertently only skip the rest of the current word and silen=
tly resume on the next one.
--

commit e9a4307d205f9de4f9da9f425dd9329d36d47094
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add scx_cmask_test() and scx_cmask_for_each_cid()

Adds a single-bit test and an iterator over set cids in an scx_cmask.
The iterator is bounded to the active span.

> diff --git a/kernel/sched/ext_cid.h b/kernel/sched/ext_cid.h
> index 46fd8eda04435..5745e5785e897 100644
> --- a/kernel/sched/ext_cid.h
> +++ b/kernel/sched/ext_cid.h

[ ... ]

> +/**
> + * scx_cmask_for_each_cid - iterate set cids in @m
> + * @cid: s32 loop var that receives each set cid in turn
> + * @m: cmask to iterate
> + *
> + * Visits set bits within @m's active range in ascending order. Scans on=
ly the
> + * words the active range spans, where head and tail padding is kept zer=
o, so
> + * no per-cid range check is needed.
> + */
> +#define scx_cmask_for_each_cid(cid, m)						\
> +	for (u64 __bs =3D (m)->base & ~63u, __wi =3D 0,				\
> +		     __nw =3D scx_cmask_nr_used_words(m);				\
> +	     __wi < __nw; __wi++)						\
> +		for (u64 __w =3D READ_ONCE((m)->bits[__wi]);			\
> +		     __w && ((cid) =3D __bs + __wi * 64 + __ffs64(__w), true);	\
> +		     __w &=3D __w - 1)

[Severity: High]
Since this macro expands into two nested for loops, what happens if a caller
uses a break statement to terminate the iteration early?

It appears a break will only exit the inner loop, terminating the scan for
the current 64-bit word. The outer loop will then increment, fetch the next
word, and continue iterating.

Could this create a trap where a standard break statement inadvertently ski=
ps
the rest of the current word but silently resumes yielding items on the next
word, violating standard C iteration semantics?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604020032.3536=
466-1-tj@kernel.org?part=3D3
