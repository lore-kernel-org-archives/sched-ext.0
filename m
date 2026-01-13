Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D92F0673
	for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336781; cv=none; b=c6J2/pmN7lQJcuUx/P9s2O55EUxMFpaIRXRvzlFE4Ifk5ASOLn+Tg/EQdRHVyKPPgL9iATORIsud9e/DurC9JN3IzQweF2HgagmF4i9GSoToTZHUEuXHu9JgS100rAGwfeq/2IjgCXHe37GYk3KoBMaF2Z+azn+bbE0v6mfqehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336781; c=relaxed/simple;
	bh=5G/+O4AfoFl7Mun62PXu7YMTfSDOOK90wf7hCG0XoWM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ej1AP3Ue1ZPy+0nsXXCEIKq1wo82w48l60r09YFUr34LtPRELQXy+nUaJo0kcld6PjJA3tA77GLohXW1JeOwTddbbqbWL+RSp6cIwVmesFTo1jQm1y9EyeUixr6nayVVwaRkpSKKwo2QHjfFgWH0npvVl0LdZvj8OpliWaYGIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPraaTrs; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPraaTrs"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a12ebe4b74so75610785ad.0
        for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 12:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768336779; x=1768941579; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vuKJVwdXdLFoBFmdbdguCpeTwBYgUktjFchgdX5Irfo=;
        b=YPraaTrshW9/pwa+Abx3NYpNZPoFY3AMk+tVxjXB8khXBxkFlaJpZ4VtsgYcILId+X
         5teoLmEmVabjnwmaqDBES8Eeefx8HTXk//yS4z+7ZV3rp7jYsYeIiTKmeu/96S/MG3hr
         GE/Y66aOiA6G4ApB1/HJJcwPTI4zRDEpBWzlSM7bIAF4WM33IsX68aMVqKcq7gcPNqa8
         KQsrMuLm6aC/MvFMwSaP8tBilUE3tp5+iFWr0ItGURzLqbf4vXCjPL85K5MQlKejkIev
         rrXAm66hNKmJIcs97iHWUuPRH+BW9RFrHkX05kSQzKP6Cp0MqYGsvcaNcB2uTys+l6jp
         d7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768336779; x=1768941579;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuKJVwdXdLFoBFmdbdguCpeTwBYgUktjFchgdX5Irfo=;
        b=rhDh9aQZxjXN6IWA9QPe0xkpSFgbn3m/zXt27Ln8OxYqWFBBA5mo22v2dJoio8Poog
         FxRhkk/8Jc3yYt+8tfKHS7bDOzFwVPWa5w3QYloZyw20+LFPkkgD+mS2JKBmxDvdzjEk
         qlHP0fnWcN61KmiDWzUgHeO4eR6rp2PzXgz+Yvq3J/cjBYpmcaXm+C/IwUqp1x9E7/P+
         mcJGIAL0aVZ3ZpLzhpYTQ7bXcrtIE70IAK6zZVmulvcy6uxSQKDCj/DBRldQgOCKJnlB
         l6Gbhuvl88twOoaqQ0hp++kVAoOnCazBKCMrkCoZT5qri7wswbI4Q4wRy97JA64SJM68
         ECOA==
X-Forwarded-Encrypted: i=1; AJvYcCWdF4iyMDA6OkGqrUmQHGRHWKlmIDA2MbFgjn+nNzMsMDdk+u+sIQjUshKuNubhqR/YyO5MLK4YRtI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzk0X/+laeF1OpTqrqvJidxWC+gYu21knlwm1SvjpsE36VBCHSf
	J4YRPX9g9HAvBSPW31o8PiI7yiFCQHuDmgPfnySwK8fBRsXajBO1jQzf
X-Gm-Gg: AY/fxX6SZtVH2KcF8lmRVGtUhs3WOas0fyQUHjxWjQY7INCidsnPKL9spzHsiUnd/xE
	1jr+Ox7Wi6Fl7JX2zRYQ96+G1IdjJ6Dqdu0Ex5/LLrW3hpfBIimtxX5MUX7bOr1EV3aiT8xzDKQ
	MLNzDI+GAOe2B0n+5my5hWJwihWw367d4qaQP9Hh+4UPXFLKEgfzDPaAKue69nI450vwFQF8/I5
	aveO4Iu7QLiM5J8ps/GaPgP0LfxcZx8BEtYSY+izDMXX27FIhtlUdz3lOpvqdxMjZhm3K22+gQU
	rnsZmjNKtZfYU71A4PCgrauMR2DeCUtxuKr0denweEAYSaG2VfCgG6QseE+vCvDGoF351wSPVVX
	+ye20nmYOeAlmsMPMOGXu6a4Kz5KMqzTTz2VMbi2pOIvwFP/P88psqeoDAGRuLfwacPMEXVvzyP
	Gq43LaK3D2CN7Ri+aelivNX/DH1HHY+kRDvxH9Rw2V
X-Received: by 2002:a17:902:f651:b0:2a3:bf5f:926c with SMTP id d9443c01a7336-2a599e3434fmr3125395ad.39.1768336778822;
        Tue, 13 Jan 2026 12:39:38 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28f6cdsm20541766a12.6.2026.01.13.12.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:39:38 -0800 (PST)
Message-ID: <952853dd064d5303a7e7ec8e58028e9ee88f2fad.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Verifier support for
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev
Date: Tue, 13 Jan 2026 12:39:35 -0800
In-Reply-To: <20260109184852.1089786-4-ihor.solodrai@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
	 <20260109184852.1089786-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-01-09 at 10:48 -0800, Ihor Solodrai wrote:
> A kernel function bpf_foo marked with KF_IMPLICIT_ARGS flag is
> expected to have two associated types in BTF:
>   * `bpf_foo` with a function prototype that omits implicit arguments
>   * `bpf_foo_impl` with a function prototype that matches the kernel
>      declaration of `bpf_foo`, but doesn't have a ksym associated with
>      its name
>=20
> In order to support kfuncs with implicit arguments, the verifier has
> to know how to resolve a call of `bpf_foo` to the correct BTF function
> prototype and address.
>=20
> To implement this, in add_kfunc_call() kfunc flags are checked for
> KF_IMPLICIT_ARGS. For such kfuncs a BTF func prototype is adjusted to
> the one found for `bpf_foo_impl` (func_name + "_impl" suffix, by
> convention) function in BTF.
>=20
> This effectively changes the signature of the `bpf_foo` kfunc in the
> context of verification: from one without implicit args to the one
> with full argument list.
>=20
> Whether a kfunc argument is implicit or not is determined by
> is_kfunc_arg_implicit(). The values of implicit arguments by design
> are provided by the verifier, and so they can only be of particular
> types. In this patch the only allowed implicit arg type is a pointer
> to struct bpf_prog_aux. The __prog args (usually void *) are also
> considered implicit for backwards compatibility.
>=20
> In order to enable the verifier to correctly set an implicit
> bpf_prog_aux arg value at runtime, is_kfunc_arg_prog() is extended to
> check for the arg type. At a point when prog arg is determined in
> check_kfunc_args() the kfunc with implicit args already has a
> prototype with full argument list, so the existing value patch
> mechanism just works.
>=20
> If a new kfunc with KF_IMPLICIT_ARG is declared for an existing kfunc
> that uses a __prog argument (a legacy case), the prototype
> substitution works in exactly the same way, assuming the kfunc follows
> the _impl naming convention. The difference is only in how _impl
> prototype is added to the BTF, which is not the verifier's
> concern. See a subsequent resolve_btfids patch for details.
>=20
> In check_kfunc_call() reset the subreg_def of registers holding
> implicit arguments to correctly track zero extensions.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Overall lgtm.

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c

[...]

> @@ -14303,6 +14358,17 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  	for (i =3D 0; i < nargs; i++) {
>  		u32 regno =3D i + 1;
> =20
> +		/*
> +		 * Implicit kfunc arguments are set after main verification pass.
> +		 * For correct tracking of zero-extensions we have to reset subreg_def=
 for such
> +		 * args. Otherwise mark_btf_func_reg_size() will be inspecting subreg_=
def of regs
> +		 * from an earlier (irrelevant) point in the program, which may lead t=
o an error
> +		 * in opt_subreg_zext_lo32_rnd_hi32().
> +		 */
> +		if (unlikely(KF_IMPLICIT_ARGS & meta.kfunc_flags
> +				&& is_kfunc_arg_implicit(desc_btf, &args[i])))
> +			regs[regno].subreg_def =3D DEF_NOT_SUBREG;
> +

Did you try doing this in `mark_reg_not_init()`?
This function is called for R1-R5 some time prior this hunk.
What I don't like from structural point of view is:
- `is_kfunc_arg_implicit()` depends on KF_IMPLICIT_ARGS, but that
  check is done externally. Hence, the naming is misleading or 'meta'
  should be passed to `is_kfunc_arg_implicit()`.
- doing DEF_NOT_SUBREG logically has not much to do with implicit args,
  so it is a bit confusing that is pre-conditioned like that.

>  		t =3D btf_type_skip_modifiers(desc_btf, args[i].type, NULL);
>  		if (btf_type_is_ptr(t))
>  			mark_btf_func_reg_size(env, regno, sizeof(void *));
