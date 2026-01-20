Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861061E487
	for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873632; cv=none; b=X1qqQA/HgjPkNaSxDLNFYtFXmnZEldsFJlqfqWQb3EbZOLJkm/AnLCgNEIq5A1jszjnA/E2G7wzZi+ueMNPsTZIUDpvrxFXpahiYDyuxJxy2eH7WNFj/nXQLOTCGv7+NLXYLe8I7DTNz7N49xNljZ4vJxo37oz0jFKDq/LZRW2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873632; c=relaxed/simple;
	bh=DFMDqIBxWMeUoPAyaqN8hr45MYvMg+GV75NoJCt74uw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ymqvo5KjGtWLi+WStGXJ5v6HiaxDThoh7ETb2N0DkIfrPExZWekIonSKyQUbdzG5gkAWcwrfgWwOn5uMhPXaAhTkbA9vBvCm21fg4yGdTuzr4RD+GO1/xeGTBRHW0roFKOo7C3P6j9kclLopbWUY+qMvuVbuX4GGX7eFgjjtL3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rsm7QlaU; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rsm7QlaU"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1232d9f25e9so9485863c88.0
        for <sched-ext@lists.linux.dev>; Mon, 19 Jan 2026 17:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768873631; x=1769478431; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bs/xgeR13/qdRJT1LBeIlLMVbrV4KZcmi7z58cgPbxU=;
        b=Rsm7QlaUQbICyrWJFDGzU5PEllPtYanW6t29fwnng5Wli+mmMAjHkGviTUMiBzon5x
         sodhcdpndsxyUgc1VQzchTsldvIKfHSbaXYlWtfmyjsK2FA1r6iUuL6/O7q1O2rca3oG
         GnJqhQ2YZMub3ATb4Upj8qG1nN2MuA6sm8sPu2Uy6C6+hYQPIRGQcbFMirIL+/581HiX
         ioJ48477fshfSu7FbM+adnV31/1jBdtAHKFRYhtQwmFeYtKvtn958/QUsuzNEO8vOCic
         CAaiUCsgfftyhD3x1FF/FUTcYVr9o0hMju4yX8B90x0JSHcsJDzgemxlmJhaJrfxaGtx
         Uw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768873631; x=1769478431;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bs/xgeR13/qdRJT1LBeIlLMVbrV4KZcmi7z58cgPbxU=;
        b=RmFoengoWPhkzeoVe8HQgAO2RAfzv7TX6Nvo3D5GTyceP6sFfxZr4+G8PE0tQN/Fi5
         3fwvGXO1GKOBVGv2W8o33rCKnp3mL7FTeCIIfJO93BjlYRi9NXJgfjCC0SNVNWwwMpa9
         EM1d0nEBKEaO956VVkvQ3Vybs/FbOQPObbYF8W3UHompTjX6rODaAaTX+wqIclEa917V
         bzlMs8PW0F0bQMNwSrsgBZNx5sp2z/EF7h07aJOTAjZ9oec+to+KTNfT/NCO/FIBuFkt
         jU50+1BTUlepXZ8Br1pYicc/zhymrZQO8aYaRpSZodq6x69jOtGgbkm/IRS1go52VDV3
         Z5gA==
X-Forwarded-Encrypted: i=1; AJvYcCVGpSXSdXnbk9JSblahC+JbinQskdWpxSXsj2xbC4HodA9z1Fk/lqUqv/ER9fbvIl3p5rv2KsO86GQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YwXyyBTchQBasDPizWwkkvdFViwTU4dX6RLKJFjsjPzLUp6Z5yJ
	wxOyYptXLI9bvtRcT4762U5z+sr0Uo+a/hGIbGNtrmPZerhvePfbXpGS
X-Gm-Gg: AY/fxX6WdAc7q08EauH0VcM2D8P+tvfVuDiWPFOAj/hlBylDb7xIZY03kl/uH+lABB4
	QCpOv61Q1G9RQVL4s0q6tRMJILRHRpS4kLbzzKdvPHj9s1dnPOiJKH7e/n8pxtcngYxkDKznxh3
	BP7rew+LsSoFAMsQWojt5SNrtvoIIEGjh2y1ohBJap7GvTXBX75gGpia+Tr8y7Ed6iByhZ4X1QD
	xazVWeImKz3XELy2m5nWbKTd3ErTIrjqt+WgfjBUG+dv+TkTIyDAA4CdQgQn5GLVXG5QpeaPpNJ
	pADfKq/7WpdjG75jrGBboJHeBvJfRqFEWHzmwC1OrAaHUM6ohiO17CCumwd4In6Tjy2xXQi4C/V
	sfDuZ4IwQzBFLCGB/dBq6hRDrJ1FNLAEzQGMknsS2L+5/Wn4VYrMrRm3lzsn/66cQVBMWW1kHSS
	AuwTif1NJ6Z6D3kzf4A1NX2VoWAXzDsW1K7e0NG/EGpuoePikKtFq+tFC7uPUvoo5fEw==
X-Received: by 2002:a05:7300:dc85:b0:2ac:2480:f0ac with SMTP id 5a478bee46e88-2b6b40d991cmr8107963eec.23.1768867408672;
        Mon, 19 Jan 2026 16:03:28 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3679980sm15230498eec.31.2026.01.19.16.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 16:03:28 -0800 (PST)
Message-ID: <e2d174e79c4550fb7251f29351f1fe5afb812328.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/13] bpf: Verifier support for
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 16:03:25 -0800
In-Reply-To: <20260116201700.864797-4-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
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
> The values of implicit arguments by design are provided by the
> verifier, and so they can only be of particular types. In this patch
> the only allowed implicit arg type is a pointer to struct
> bpf_prog_aux.
>=20
> In order for the verifier to correctly set an implicit bpf_prog_aux
> arg value at runtime, is_kfunc_arg_prog() is extended to check for the
> arg type. At a point when prog arg is determined in check_kfunc_args()
> the kfunc with implicit args already has a prototype with full
> argument list, so the existing value patch mechanism just works.
>=20
> If a new kfunc with KF_IMPLICIT_ARG is declared for an existing kfunc
> that uses a __prog argument (a legacy case), the prototype
> substitution works in exactly the same way, assuming the kfunc follows
> the _impl naming convention. The difference is only in how _impl
> prototype is added to the BTF, which is not the verifier's
> concern. See a subsequent resolve_btfids patch for details.
>=20
> __prog suffix is still supported at this point, but will be removed in
> a subsequent patch, after current users are moved to KF_IMPLICIT_ARGS.
>=20
> Introduction of KF_IMPLICIT_ARGS revealed an issue with zero-extension
> tracking, because an explicit rX =3D 0 in place of the verifier-supplied
> argument is now absent if the arg is implicit (the BPF prog doesn't
> pass a dummy NULL anymore). To mitigate this, reset the subreg_def of
> all caller saved registers in check_kfunc_call() [1].
>=20
> [1] https://lore.kernel.org/bpf/b4a760ef828d40dac7ea6074d39452bb0dc82caa.=
camel@gmail.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -14177,8 +14223,12 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  		}
>  	}
> =20
> -	for (i =3D 0; i < CALLER_SAVED_REGS; i++)
> -		mark_reg_not_init(env, regs, caller_saved[i]);
> +	for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
> +		u32 regno =3D caller_saved[i];
> +
> +		mark_reg_not_init(env, regs, regno);
> +		regs[regno].subreg_def =3D DEF_NOT_SUBREG;
> +	}

But we still need to understand why .subreg_def assignment can't be
moved inside mark_reg_not_init().

[...]
