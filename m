Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538B32DC764
	for <sched-ext@lists.linux.dev>; Wed, 14 Jan 2026 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354514; cv=none; b=u35eK2Iuy6nqFSseZPiIX/D73dVmBd/gh+3zIFHd8NeXiiUU151fcYXtmf7sJDcdx/dWqdD2qZEfl6c/nQs1UncYw9kVvXuNlPBcwW8n/xFX/dEIoSdj/KfziAY2eh1bIjVgzuc3y8P+fduHaXTrHCi4bjZQChfS025t0a35c+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354514; c=relaxed/simple;
	bh=0PILchQj3J76ZAr261KJtaEQ2QxT7WEQn+1Ge6Oxu6A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZVzY3OVgVpe5mMpTbZPCZuiDqsXTOAvuQKH6kjuofFO/2FPbACe6uEP4a8YQO6pf/6VObW1Walat2L1AvNNVmejTKo0iOSj5l0q+dGA8qWCmGnbYKxn+iRXeTNm2ZSYJl+444bkwEjzj/qG4I6yL1lZxNobeJxtRscUtV7UrGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0LIhJax; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0LIhJax"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29f1bc40b35so88884925ad.2
        for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 17:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768354512; x=1768959312; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ieZaHREaNUdn6zv47XqVz3diRO7gdSg8y8kBpzF75Sk=;
        b=P0LIhJaxZ+5dXT5veWJuVuqgPUVQraSkIwQkPFu6PoGCC/Wl2HQvlkguFr2Vg9YquS
         Ti/WXPFwd63nxb/SDBAZ/JGhXT+6m4AFFOKA2kF7wpLy9DRh/N7lF44FyLqLoqO1wnn6
         ic9Rn9pLXeXpCNIbcgnJs5V2ROCcEAYjGHlgEOg6a5eiKL2CBP1KQ4KlCVkmcTkIgghY
         AKmqE32Irj03Aszng+IrlLNcfSGY5ASOEMQBpvh0OTu7acfhkXHrKr5+XjvfE/F0pP7/
         kdenPwtBQdMottS6lfJ7aohKDMl1Cv87MesVkgvXf22R0oWb5pe21s3dYXTWUzEoBPLW
         MYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768354512; x=1768959312;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieZaHREaNUdn6zv47XqVz3diRO7gdSg8y8kBpzF75Sk=;
        b=ZinkDSuaSjTY9KCacyuU3p5JqYIVyi7j1n0HTpw+PvkzFneo/vYVASrB/e68tpoXbG
         OjyFHGaCoeFrRBGqsTxDgIfRxPwAv6zuzt/gTjPyvMdHtIyzLUG1NBa+rH//BZSTF3pX
         siamMBvFCKqdlvaEozEZE+gEV/4rPYCjwt/VqCxhXxjCNoS3/njpoSNReztnfSi7/nc4
         eB9r5CNk3fnBdln6UE0Sh7rn/jYfQWwEd3SzG/7r1Lik7lpXwTovmx/zuvguzxRsW5bw
         +HtJkHVZ+xa9qfoNxtc2JEYkWBhjTz98UUAAt52EjMC2ZhoDKB58ZkA3eUItv77KLzYF
         3pXw==
X-Forwarded-Encrypted: i=1; AJvYcCVxoAsP61xfjNMVTst4puI6BFy7aaHE86X1ei0nmfTao52FkxiGh/V6U+WORVU60rUXR4+m9iSL01U=@lists.linux.dev
X-Gm-Message-State: AOJu0YwpjqSRy/ILeL5WHnhUakeMoSXf9pFkB/tuW21FvQkRQh0eJPHf
	W55ub1Coj8RJyU3N5szEZQbcSRXRRfhkEZ1kwb61Tl2nUglQLJX1kBNN
X-Gm-Gg: AY/fxX5R8bn4NvmHakvow8ZOHcXmJ+h2ivYojtQpMO5pR1xyN7KCnZnxkbVvzkqETgN
	6SrIySRvzpCQR/7u9UI5g1zaAQiL0b87i5mGhXcDePLe3OZMDf4G+rXOshLmlR7iv6nqnyH6SWo
	zRv65yjC5pgUCpzqbubfoSC8MImqCkGNmgh+BjtZ4OwhTCPhZuZ25e1UVILuIczFd32/t+/Vfh+
	fUc1IlIdr4qosqnqreP8v0oVg/H293kqMeYQVnG2HSrTqpHtZCJwUS8HTdj/PJG2FCKyWRIvFd0
	20sz/srXY7KpyIP3bK6qE9ebpT9VF/gVt8F9a126wi0Kvma3w9cXu74YYDDDYYGMhydSkJaHD8d
	5l8S1oJHPXjre+JDH8m31f6PBuGkfQTaKBND4xlp6y+7bF75CqDgZL4IdG/5IvDuAxgymA740+C
	I7noO+AJHcZpL46BPGjIL4pE2GGMqcFATn4AL3MX3Q
X-Received: by 2002:a17:902:d58a:b0:2a1:5d2:2e45 with SMTP id d9443c01a7336-2a599e7cc41mr11109465ad.59.1768354512488;
        Tue, 13 Jan 2026 17:35:12 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd492fsm89974945ad.98.2026.01.13.17.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 17:35:12 -0800 (PST)
Message-ID: <b4a760ef828d40dac7ea6074d39452bb0dc82caa.camel@gmail.com>
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
Date: Tue, 13 Jan 2026 17:35:09 -0800
In-Reply-To: <c7e2a776-52f9-46ad-8422-3a9202bbd9f1@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
	 <20260109184852.1089786-4-ihor.solodrai@linux.dev>
	 <952853dd064d5303a7e7ec8e58028e9ee88f2fad.camel@gmail.com>
	 <93ecdc25-aa5e-485b-8ff4-a9db3b585861@linux.dev>
	 <c7e2a776-52f9-46ad-8422-3a9202bbd9f1@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Tue, 2026-01-13 at 15:48 -0800, Ihor Solodrai wrote:

[...]

> A follow up after a chat with Eduard.
>=20
> This change in check_kfunc_call() appears to be working:
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 092003cc7841..ff743335111c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13958,8 +13958,11 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                 regs =3D branch->frame[branch->curframe]->regs;
> =20
>                 /* Clear r0-r5 registers in forked state */
> -               for (i =3D 0; i < CALLER_SAVED_REGS; i++)
> -                       mark_reg_not_init(env, regs, caller_saved[i]);
> +               for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
> +                       u32 regno =3D caller_saved[i];
> +                       mark_reg_not_init(env, regs, regno);
> +                       regs[regno].subreg_def =3D DEF_NOT_SUBREG;
> +               }
> =20
>                 mark_reg_unknown(env, regs, BPF_REG_0);
>                 err =3D __mark_reg_s32_range(env, regs, BPF_REG_0, -MAX_E=
RRNO, -1);
>=20
> https://github.com/kernel-patches/bpf/actions/runs/20975419422
>=20
> Apparently, doing .subreg_def =3D DEF_NOT_SUBREG in mark_reg_not_init()
> breaks zero-extension tracking somewhere else.  But this is not
> directly relevant to the series.
>=20
> Eduard, Alexei, any concerns with this diff? Should I send a separate
> patch?

Imo this is acceptable to land this series but follow up investigation
is definitely needed. Either there is a bug and mark_reg_not_init() is
called in a context where upper 32-bits are still significant, or zero
extension related code can be improved to avoid patching in some cases.

Additional context for other reviewers, Ihor did two experiments:
- added '.subreg_def =3D DEF_NOT_SUBREG' to mark_reg_not_init(),
  which resulted in selftests failure;
- added '.subreg_def =3D DEF_NOT_SUBREG' as above, which worked fine.

Meaning that code in check_kfunc_call() is not a culprit.
