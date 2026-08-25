Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E9254AFF
	for <sched-ext@lists.linux.dev>; Tue, 25 Aug 2026 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787637531; cv=none; b=nt/p5UXxkuBffwjMt5C2ZEMve/YanGy5+Ezm0crO4z1zwKJ2dm0/HtsaMrkL0M17oGTfujEpd3jSaTtCnjSBC6VcUyUnoOtZBVVabz2Lr4NJ7xA5/wE9Wt6ArSStw5n+ahh6Aa+vtMh/Tb3engwGZjhUUOft/YOP0gnYzqsHkH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787637531; c=relaxed/simple;
	bh=H83Fxfz2dB8BdSPl5QQrocsEZCPtOzm6OGAVxSluGeY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HL5RnH++nzGsIRAS3xlBmPBP21logL2kprA21Qpax5BIDZE9GxIGZ+YiQW4sRq6KlTBZDd0ZFBI7SJJXN6/GwgVBwTY7h+9K57fpB9vJMFITcyxppiZCKa5E9H1+2OaPvFLiJUcSdzoBQFDdEN/Vj2/XWdRfOdu8uuqKHzQLd2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQKSVSqY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQKSVSqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF201F000E9;
	Tue, 25 Aug 2026 05:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787637530;
	bh=XSGl1SabFukx/ZdX78MJzWJIavrIGxtje1sO2UEdzrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VQKSVSqY1e7SieisKzJQk2mk5qcAeSjbe0+BRvWo66eUF3r/QbL9ameXTa373hHbt
	 vecQ9yQRoImi2YwMQy2zzlR86/pa8ANtOXynXGxwgxxSE3mSIm/9ApfQJe7VjRcnTz
	 IG9fpicdCjF236EsPwW/kNYCVdrr6bcw6XxZUBhZPePyggnvlFYNL8FGlOV0uPnhsr
	 OlM9FDDk+K2FStYaTQHskW0YvTVpPvnNjvqhY4GBj77I7QGfker+aeJA6WU3Fic6yy
	 yzF3+wsrm2L/LlLywBgGOVxbNc/krNqZgjhpOA/LiHWRU6zj5oIUXMR+6NKYrTWmwp
	 AvyhMEm7XaiyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Fix missing @slice and @vtime descriptions
 in finish_dispatch() kernel-doc
Reply-To: sashiko-reviews@lists.linux.dev
To: luoliang@kylinos.cn
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260825055053.2295139-1-luoliang@kylinos.cn>
References: <20260825055053.2295139-1-luoliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 05:58:49 +0000
Message-Id: <20260825055849.ECF201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Adding kernel-doc descriptions for non-existent parameters `@slice`=
 and `@vtime` causes an "Excess function parameter" kernel-doc warning.
--

--- Patch [1]: [PATCH] sched_ext: Fix missing @slice and @vtime description=
s in finish_dispatch() kernel-doc ---
commit 41530400fea7676e4713b34dcf07ebfd18e9b839
Author: Liang Luo <luoliang@kylinos.cn>

sched_ext: Fix missing @slice and @vtime descriptions in finish_dispatch() =
kernel-doc

This commit attempts to fix kernel-doc warnings by adding slice and vtime
parameter descriptions to the finish_dispatch() comment block.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 18183062f751c..84b2bb05ab90b 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -2664,6 +2664,8 @@ static void dispatch_to_local_dsq(struct scx_sched =
*sch, struct rq *rq,
>   * @p: task to finish dispatching
>   * @qseq_at_dispatch: qseq when @p started getting dispatched
>   * @dsq_id: destination DSQ ID
> + * @slice: slice carried by the insert verdict, 0 keeps the current value
> + * @vtime: vtime carried by the insert verdict, committed on PRIQ inserts

[Severity: Low]
Will this trigger "Excess function parameter" kernel-doc warnings?

Looking at the code, finish_dispatch() does not appear to have slice or vti=
me
parameters in its signature:

static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
                            struct task_struct *p,
                            unsigned long qseq_at_dispatch,
                            u64 dsq_id, u64 enq_flags)

>   * @enq_flags: %SCX_ENQ_*
>   *
>   * Dispatching to local DSQs may need to wait for queueing to complete or

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825055053.2295=
139-1-luoliang@kylinos.cn?part=3D1
