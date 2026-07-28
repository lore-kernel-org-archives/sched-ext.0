Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D6E3B777F
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 06:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220088; cv=none; b=krhuj7lBObMyg1nj0sxUS5Ni6ZAJDWfeyN3sO/nND7J6OY5jljzIAkjjHis51kULCf3seoP0XLJ9XAD7KZpB9oAEWmoJZK/NO/BlcTaDC0VwRiB8rTdk+PT9bdkPjGGmWt9cZ4mH9ldNOgMHvpqtl+BOT/Pp6D6sgUIPOxlxYQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220088; c=relaxed/simple;
	bh=hs9eUs6VlOfsMQKvYRHLH/Exluv9x8aqRHpbON5bCvA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hQKXFr6V5CoJ2/d2gzuZZnTQ3UlE+r0r4qluJNUBh9HSI+NHTGg3lsv5VhZw8ar0i3CFU9MrsPLYV7POne6afYl5YKg73wExTfwMQYsFQrYBK7Ob+a2uNd/KPNyvP2MdUDtnrOFGcxbO9gDPEVrYB2ne3GbInYUVd013qVpqDgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS2Tae24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS2Tae24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E041F000E9;
	Tue, 28 Jul 2026 06:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785220087;
	bh=40DLUk0mIpkb54GfuPCM4mhMKsKaMyxVP0srQIrjdmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PS2Tae24sFPVSG3AYPVY6J4yp7iK8P0k96IkMozEtrzXWmrUIMX/gF03ccmHK3xj2
	 PtpU70tWc9Mm4yb9vP80zkQDYaPy54IGYHysKcMzeilePhJeuW5tsCRAy9k5nTq7A0
	 53IixB+pg08KFvU0hdOHswUQ+h4VbBtCNctqLc2b8KVgaRzKV3VBXgHkhmVqBcD16/
	 DbSxkuv8PQeObJcV/K3QK1RuaUXVS0fRBcXwxLvcyiOo856uI+ATb7FTrb60DyfhSj
	 6rm6Ca/01JMPPTsbKVlT3M95KF7bSNEzBLb9h4XAYR1CIdE6NCvruyer4iXBu1IEnD
	 poUjDS9tPDYXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Set errno on ENABLING -> ENABLED transition
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: luoliang@kylinos.cn
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260728060955.4102964-1-luoliang@kylinos.cn>
References: <20260728060955.4102964-1-luoliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 06:28:06 +0000
Message-Id: <20260728062807.17E041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `scx_error()` calls in `scx_sub_enable_workfn()` error pat=
hs cause silent failures, leaving the sub-scheduler orphaned and returning =
a false success to userspace.
--

--- Patch [1]: [PATCH] sched_ext: Set errno on ENABLING -> ENABLED transiti=
on failure ---
commit 23b2e75396f348a4f6a2b8cadd57f78dd5b36fcb
Author: Liang Luo <luoliang@kylinos.cn>

sched_ext: Set errno on ENABLING -> ENABLED transition failure
   =20
This commit fixes an issue in scx_root_enable_workfn() where a failure
during the ENABLING to ENABLED transition would jump to err_disable without
setting a return value. It sets ret to -EBUSY so the fallback reports a real
errno instead of a meaningless message.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 691d53fe0f648..84322adb69c80 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -7323,6 +7323,7 @@ static void scx_root_enable_workfn(struct kthread_w=
ork *work)
> =20
>  	if (!scx_tryset_enable_state(SCX_ENABLED, SCX_ENABLING)) {
>  		WARN_ON_ONCE(atomic_read(&sch->exit_kind) =3D=3D SCX_EXIT_NONE);
> +		ret =3D -EBUSY;
>  		goto err_disable;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but since this patch improves error reporting
in scx_root_enable_workfn(), does scx_sub_enable_workfn() suffer from a
similar silent failure problem?

Unlike scx_root_enable_workfn(), the err_disable label in
scx_sub_enable_workfn() lacks a catch-all scx_error() call. If an error
path jumps there without already invoking scx_error(), it appears to
result in a silent failure.

For example, if scx_arena_pool_init() fails:

kernel/sched/ext/ext.c:scx_sub_enable_workfn() {
    ...
    ret =3D scx_arena_pool_init(sch);
    if (ret)
        goto err_disable;
    ...
}

Or if __scx_init_task() fails:

kernel/sched/ext/ext.c:scx_sub_enable_workfn() {
    ...
        ret =3D __scx_init_task(sch, p, false);
        if (ret)
            goto abort;
    ...
}

Both paths eventually reach err_disable, which just unlocks the mutex,
flushes the disable work, and returns success (cmd->ret =3D 0). Since
scx_error() was never called, sch->exit_kind remains SCX_EXIT_NONE,
scx_flush_disable_work() does nothing, and the subsystem is left in a
broken state while userspace is told the operation succeeded.

Would it be beneficial to also ensure scx_sub_enable_workfn() properly
reports these errors, perhaps by adding a catch-all scx_error() call there
too?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728060955.4102=
964-1-luoliang@kylinos.cn?part=3D1
