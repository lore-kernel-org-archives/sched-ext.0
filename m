Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51736E49B
	for <sched-ext@lists.linux.dev>; Mon, 12 Jan 2026 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236970; cv=none; b=jQQbXZo4jaZwvwGsikVMs0AZAB3hvjqEztKyEkzWIf8mIR3iu9gEBpmnr/qeNKzZjHGpNobZhwZ8VVQCaWiarZcUKvGDYfS+AEUzPWP52/WPUZGsXPcCyghkbHXgWzjK7/ClOCfXN4QxdGgKQqrc6KE2B5gObIV/jQlyR8JQS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236970; c=relaxed/simple;
	bh=wC5EYvrli+B4rkBJk8LAcz/nVx1foABD/QgvBsjbnmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAtyk1WFh/kl/AHLfVSiHBhXxwyjbvSaGe00SZeKcSJPP1JYj61IlW9OPuDRBUzfb4iUJTka5fLYxd/ZJefjYHP/P5EQLKvtR+7j7Qt2/9M9LgYlzAfe6HiwPa93WNHz7lgt/lKBybiTWEJCeOT6ttivm2kpjJ0gh9AAxh6aIxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuIdDjb1; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuIdDjb1"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so4192433a12.0
        for <sched-ext@lists.linux.dev>; Mon, 12 Jan 2026 08:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768236969; x=1768841769; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze4qHmASAwrj5Onk0qJN7LV+EYaF4QvTW/sipsaAIXs=;
        b=kuIdDjb1zfborOkC0pbG0PGSxYpiHB1tTvjhazXQn8GAwqSzsH8iXthMgarLX0Se1M
         TWx6T6oomaP+QEBioDZNyKQmomNKgHlEYAy5MwUva1/E93VWI4VqC49AQR0aCPkazf9/
         bXF5P+2+t8kBX5U1Rq7yPz1nH/JfDCIN3LO2Ls/BzCp9t4MMmEntXBp1tGhN9ABkKIS5
         DzIgosGVnPc7KSoiW00bTzGh9rC+jsXYseMIQD5Gz6cYkxjhsJlLzHa0oT72BctXAL5z
         pMnCJeGkgCHhtwaqEED4hzy7qSh+k4l4E3L6Jm1qYO7f5zw8uuFoY2vkRjq2d7deLeOy
         Qwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768236969; x=1768841769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ze4qHmASAwrj5Onk0qJN7LV+EYaF4QvTW/sipsaAIXs=;
        b=vMvQMPZIuElzoJphlzszXOtXegzziwZiJajeHlw1GoEd7S1Zg17/5mzOfSfQb+BB7t
         GStzAephozxEL+N8JCgKH8ChYxU4OGhfgZ8uqGiQlwQWJ5h0ZHYigkd5U+wmYPbALeVA
         y3zfgZ2tU7awGT/+aQfvAs2ZMoWrAhLHxLC5SnYSfp99Ic+c/DowPswDtUKkEQxoPVDB
         AO+Umy7Cvh6mp2U2IfBe+Z2Mqce7Z0P/rpgouJBRowsm9PegIlXnm78Z1WdbRof9OBlB
         VGyfhzrNo/U9xY8uWiAa32QO89qd7iJ5JflO+64CEuDUWAU2HPtwiv9zoR6Cqg87ijFu
         T3tw==
X-Forwarded-Encrypted: i=1; AJvYcCUp7UfcoGweAU6+sNy/JUa8Yq6WAidLS5zIEputx4rkG+XnRDj8O/lg7SfsTye4IXTcSx7i9v0VmGs=@lists.linux.dev
X-Gm-Message-State: AOJu0YwgdrCytMIssPwn2fP+WZcvkBSa99CQYYfI6quqQwvChZgVw8Tp
	gzYMqsnL5AIzumnMP7vlSbb6iBpbLVGaCG5iPFE8H8HTykOYpBbc926i4jBBfxmB7857DLOSgNf
	KAp+AJdS/T7wb+Wwp5tKUHsEluHyklW4=
X-Gm-Gg: AY/fxX4rcYRbsj7+Oy8o+aAZUvcUdb3oKzCTkH2s1xH8Lmzx2hsFTpc+BHppTP7+75h
	AKSzqYQpsKqSjZr5WJ2JLFOrOYrIH8peQfM39PLlb/J+2Otpk59QTo+C1UwxRkFC8GeJYTuB1nH
	P9OBH7CFYCh4iqLAFELNr8uLomb2MiB3Rz8IPcv9TgzvtY2G8ExY2pCHIOksxWEQONz6oHCUN0F
	KWulCZvpLTC7s1noYabayv1jWk313AU+HnOzxgVC/RkSGILc+f0MuBOCz/0o0McEThft95mdWOn
	C3Q+o21EsM0=
X-Google-Smtp-Source: AGHT+IHrl/h2Ots2lgfpUAoGNkMmDwh476efMYwDJDQbJX4X9du6cARVeJ6bq2ED4dzJ/HJjrt1rMcohWTQdUM88iQ4=
X-Received: by 2002:a17:90b:4c43:b0:34a:b8fc:f1d8 with SMTP id
 98e67ed59e1d1-34f68ceadd1mr19111550a91.37.1768236968660; Mon, 12 Jan 2026
 08:56:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-6-ihor.solodrai@linux.dev> <CAEf4BzZfuqpdwghCZ_TJJyt3Dm=xCBJLz3H0bbtabgToNV7V+A@mail.gmail.com>
 <32fe65fa-ecfb-4cba-bd0c-61155bca637b@linux.dev>
In-Reply-To: <32fe65fa-ecfb-4cba-bd0c-61155bca637b@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Jan 2026 08:55:53 -0800
X-Gm-Features: AZwV_QgmknNkqO_SHLPrJvKc19a4KKDGobAbn9jxV56AYe0HDgtT9buX1KR3TPE
Message-ID: <CAEf4BzbbvZgam-3MBEh==T5Zb+TRKbqRwoFcObvD0B8vjXb2pA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 05/10] selftests/bpf: Add tests for KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 5:30=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 1/9/26 3:25 PM, Andrii Nakryiko wrote:
> > On Fri, Jan 9, 2026 at 10:49=E2=80=AFAM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >
> > [...]
> >
> >> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/to=
ols/testing/selftests/bpf/test_kmods/bpf_testmod.c
> >> index 1c41d03bd5a1..503451875d33 100644
> >> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> >> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> >> @@ -1136,6 +1136,10 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct s=
t_ops_args *args)
> >>  __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *arg=
s, u32 id);
> >>  __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args=
 *args, void *aux_prog);
> >>
> >> +__bpf_kfunc int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *au=
x);
> >> +__bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bp=
f_prog_aux *aux);
> >> +__bpf_kfunc int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, void=
 *aux__prog);
> >> +
> >>  BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
> >>  BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
> >>  BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
> >> @@ -1178,6 +1182,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epi=
logue, KF_SLEEPABLE)
> >>  BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10)
> >>  BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1)
> >>  BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_impl)
> >> +BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg, KF_IMPLICIT_ARGS)
> >> +BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy, KF_IMPLICIT_ARGS)
> >> +BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy_impl)
> >
> > (irrelevant, now that I saw patch #8 discussion, but for the future
> > the point will stand and we can decide how resolve_btfids handles this
> > upfront)
> >
> > I'm wondering, should we add KF_IMPLICIT_ARGS to legacy xxx_impl
> > kfuncs as well to explicitly mark them to resolve_btfids as legacy
> > implementations? And if we somehow find xxx_impl without it, then
> > resolve_btfids complains louds and fails, this should never happen?
>
> Eh... I don't like the idea of flagging both foo and foo_impl.
>
> If we use the same flag for legacy funcs, the flag becomes
> insufficient to determine whether a function is legacy or not: we also
> have to check the name (or something). This could be a different flag,
> but I don't like that either.
>
> For legacy kfuncs that we want to support, I don't think we have to
> enforce anything. We allow to use old API, and the new one if it's
> implemented.
>
> Are you suggesting to ban _impl suffix in names of new kfuncs?
> Fail build on accidental name collision?

This is super low probability, but yes, I was trying to avoid
accidental _impl-named functions to be reused. But as I said, I don't
believe this will happen in practice, so might as well just ignore
this, if you don't like KF_IMPLICIT_ARGS for legacy stuff.

>
> We could implement sanity checks like these as separate passes in
> resolve_btfids, for example.
>
> >
> >
> >
> >>  BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
> >>
> >>  static int bpf_testmod_ops_init(struct btf *btf)
> >> @@ -1669,6 +1676,25 @@ int bpf_kfunc_multi_st_ops_test_1_impl(struct s=
t_ops_args *args, void *aux__prog
> >>         return ret;
> >>  }
> >>
> >> +int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux)
> >> +{
> >> +       if (aux && a > 0)
> >> +               return a;
> >> +       return -EINVAL;
> >> +}
> >> +
> >> +int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *=
aux)
> >> +{
> >> +       if (aux)
> >> +               return a + b;
> >> +       return -EINVAL;
> >> +}
> >> +
> >> +int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, void *aux__prog)
> >> +{
> >> +       return bpf_kfunc_implicit_arg_legacy(a, b, aux__prog);
> >> +}
> >> +
> >>  static int multi_st_ops_reg(void *kdata, struct bpf_link *link)
> >>  {
> >>         struct bpf_testmod_multi_st_ops *st_ops =3D
> >> --
> >> 2.52.0
> >>
>
