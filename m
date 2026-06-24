Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EEE3C10B0
	for <sched-ext@lists.linux.dev>; Wed, 24 Jun 2026 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311239; cv=none; b=mkXI96RlOLUaNl1VQpQSlt7wO7Bga33Dz9TYutNmz/vG1HVGsKNxCbq5a6h0rRz3z/kSXv+uWRwJ0cSnXRake7lWDHFOztxDb1bV64OQSzhifqmeSsLPpXs0gLuOUatZo8Z1LmpPDaBgHWrFoAP9fzb4HdPJTxxkPFnEZFhKX6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311239; c=relaxed/simple;
	bh=bWBKhTvENMGyZeJKlPNYJGpyYAYnSBL7qBytJhw0xKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C+85TaEen+f4Upwgz0FNdTWuokNXNZ6wEJUF10o2m1hNV08vBh9WD/bCTKdoJwrZkrR0xEj/gWZOfzuQJ8INcrpLOUYRyBhatHLZp6mWC+SKO2ykmuBchC74Etcz7vBN1Z6xuJqchp+cHLnJpNNZQctCQQsaVB4XZifsFzLxMq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIkLlHXX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIkLlHXX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32061F00A3A;
	Wed, 24 Jun 2026 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782311237;
	bh=d8wB0ihyA0YdY6yKehBkymeG744RqgWrjkKM8qy5GFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kIkLlHXXkiiyOlfjI9fJt8V0rvHOzSpplQx+AlHwleXkUsYRCxTvbQz3rcanGHLa9
	 GQsRZ4nq66W0TOF2jRe6JNVUgaMl3HBwwWhLB8xdAHoXlRPFGK7VtFFjWx6wUNYDP/
	 k/KeWn3kuoeUUmTsOwFQhw2jdESoSIes0Xn/OtXjupkutmB8gWdeR60c8rOxfk76xU
	 9lj/HpczSyCRONaz6aAOhw4sgIUnkVByhTEQewPG/8IiPJeZ8Oga1CvtEEhaP2DTuo
	 51wXutiJVuRsYNebcFc4cCsOgtWmivNy2hVSKo4ifjHRMiReL+8wF5aXc/yOTU+aMc
	 A8+s6yXfGV1RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260623142650.265721-2-bigeasy@linutronix.de>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 14:27:17 +0000
Message-Id: <20260624142717.B32061F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Using guard(preempt) instead of guard(preempt_notrace) risks infin=
ite tracing recursion.
- [Low] Missing semicolons after function/macro calls in the fallback imple=
mentation of WARN_ON_DEFERRED.
- [Low] Undeclared dependency on <linux/cleanup.h> and <linux/preempt.h> fo=
r guard(preempt).
--

commit 2038be49d63c72765117592b09ef0f46f0eef9d8
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

bug: Provide WARN_ON.*DEFERRED() macros for console deferred output

This commit introduces a deferred version of the WARN_ON() macro to delay
flushing the console until a later context. It implements WARN_ON_DEFERRED
and WARN_ON_ONCE_DEFERRED using printk_deferred_enter/exit() and extends
__report_bug() to handle the deferred case.

> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index 09e8eccee8ed9..1e3ff00f709b8 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h

[ ... ]

> @@ -159,6 +180,19 @@ extern __printf(1, 2) void __warn_printk(const char =
*fmt, ...);
>  })
>  #endif
> =20
> +#ifndef WARN_ON_DEFERRED
> +#define WARN_ON_DEFERRED(condition) ({					\
> +	int __ret_warn_on =3D !!(condition);				\
> +	if (unlikely(__ret_warn_on)) {					\
> +		guard(preempt)();					\

[Severity: High]
Does this risk infinite recursion if WARN_ON_DEFERRED() is called from a
tracing context?

guard(preempt) expands to preempt_disable(), which is a traceable function.=
 If
a deferred warning occurs in traced code, disabling preemption will re-trig=
ger
the tracer, which may again trigger the warning.

Should this use guard(preempt_notrace)() to match the preempt_disable_notra=
ce()
used in __report_bug()?

[Severity: Low]
Does this introduce an undeclared dependency on <linux/cleanup.h> and
<linux/preempt.h> for guard()?

Using WARN_ON_DEFERRED() in a file that does not indirectly include these
headers might lead to build failures on architectures using this fallback m=
acro.

> +		printk_deferred_enter()					\
> +		__WARN();						\
> +		printk_deferred_exit()					\

[Severity: Low]
Are there missing semicolons after the printk_deferred_enter() and
printk_deferred_exit() calls?

This looks like it will cause a syntax error on architectures that do not
define __WARN_FLAGS and rely on this fallback macro.

> +	}								\
> +	unlikely(__ret_warn_on);					\
> +})
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623142650.2657=
21-1-bigeasy@linutronix.de?part=3D1
