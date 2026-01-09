Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCBA33A703
	for <sched-ext@lists.linux.dev>; Fri,  9 Jan 2026 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768001134; cv=none; b=FcilOkLdSTh7KZKJEwfD7uObRMm+LMoQxwkka+hntMU7aYXvIBUrpBCIkgFT7a/kuvX/St6EYB/jDoD0qtZdfgDecwy8rM874lC9woT6I3umZFwkZKF3fmOVUGvEN18jTOGrEtLNcJ2zIpvXkkVZONa8U6/JLZSwl9P/KwPm2YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768001134; c=relaxed/simple;
	bh=u7obPu1pBmzU0WGrbzd5pVmCa0nTdZyqTHXFpTUeBuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0y/mDWA+HdpwwcZgYCXoW0P4Wz1jyPmgwUcnJSH687sDpuYSa2qrZQwQcTKzHR4VV6utzvpJrqEItZtdLnPJX+doYfFuA2KEtdXKEsy81sscLB855LlA6e6bSAt/Y+t+EELobvbpYiUfHCNkjwuWSn5xpQ7WxxUVbI74ap24CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGsYi4sO; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGsYi4sO"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so1005625a12.0
        for <sched-ext@lists.linux.dev>; Fri, 09 Jan 2026 15:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768001130; x=1768605930; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCUQNo7mxSC8vkmePvOCKj2aGkP0nJSpQiMFJJI16iQ=;
        b=dGsYi4sOb3U5qqWFyxk3CvnavaBNVLP1luyvGaEnlfziL2BJkEFBDOFudwLFa8HiGI
         +fxqmQPFj1QrOGsfoBfxvobBOO2Ek7F1KioohfXYxaLs2XDdMYxEy7EdIFyk3un9b5af
         lncvTjrHnKH89V1hz+kNK1ug+pgLwXJlU0ceONKERftQCRocpQ/U+ZXE6iWTxBVqQ20b
         CxNvVZuQcUwJhuYxaDluLXG2byXdmUrOfteVmWXvHoM84psLHibEG26P9fSN+RpFT/LL
         DVKZf5TDQjncSQoLWiiTlwun29OOBIgtzMGloeGEXwDiUSuLo5+nIx6LW12qo8bnoq/w
         fG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768001130; x=1768605930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nCUQNo7mxSC8vkmePvOCKj2aGkP0nJSpQiMFJJI16iQ=;
        b=uYmkwPePMp1ddYh7O5pLSFTkjgBicp6wVpxXbwbu8hLXzpW7GtGn1h5QJR+TzVTWuj
         OGPQaAn/EVJqOiWNIjRElOmQa+y6cQFmgXJpQcQzu1K6XgKKez9JvEOBpc/AuehODFAF
         l1F0uIcPHx+udmfDk6Y+puBjfQmdOCVPu0B3j/bIAbUmdMd4JySA3hEKDkuon9TOSuYY
         rMLmQwlaJvse+AKLTHJOH2WJOLZgamxzAsFGcHk2goTxH2XL6IFL4PIPs058g/rI6Xkf
         OPmVHVPuUwO3OfTtZgG0Ny3P1ebA769siQ1xOR70eUtvnoD7CEqqfllSV/Pbwi0GD9tk
         UpdA==
X-Forwarded-Encrypted: i=1; AJvYcCXiUAuuNdSt9RJBqSSUqUp1iGmSdbGXc3DFXKoGn6yq+/jY4KfCpvHhKSszcdQZg7mDqYsoY6KWOGI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxpcHY+epBzBxcIgnqXzhhA+GwA1K404nxA64cQAHFtTi5a3OUS
	kwr6c8jPuIdhXasOk2i5CbTLh9SMMgQAAzcmvQZLdO7dzpRGz/xKT65v/+wYbKR/gRLNJbxVdml
	b8sHDZttlSlxbqUWdYuwkWrnYxlfE4ec=
X-Gm-Gg: AY/fxX4QVBfyzOFdKJfAc5pwKbKck2+d7/p8xdStWE5A/AZsMk0Ed3X2pZnjmXTQmBI
	bKp/3bIq7VKX3HMP3Xk1LQz+HSL9i6uZt5nwdDeOJtfDe+hXhXZ5jaCrsDvdt6cVYurUKLXqzX0
	MdUEoDpL9kZMlujf0Z+uKWzCakCpuE/40nNXsQ3lJNEvrBUH0KnhPF5I2JAEXCCKguYj/4+ZjHL
	ieAJNCjPrLpxuCJKuRGgJ6gCAQTw3KptH1f9W8eBnqAGD0MbCeOUpVAg7zrZwNvJLci++PM1+LE
	qVkrg6NH
X-Google-Smtp-Source: AGHT+IHfdl0DFFsHTVhHGn4++xm9XHvLJknpf551hc1xetbMq7EEy0O5Y6tQKD9GLsiH/IFDZTNgO/HkHtmxCHtZE78=
X-Received: by 2002:a05:6a20:a10c:b0:366:5d1a:c736 with SMTP id
 adf61e73a8af0-3898f88f211mr9018589637.9.1768001130450; Fri, 09 Jan 2026
 15:25:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev> <20260109184852.1089786-6-ihor.solodrai@linux.dev>
In-Reply-To: <20260109184852.1089786-6-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 15:25:16 -0800
X-Gm-Features: AQt7F2qzahhwWoxdH0F1ChmrKpOGZlbkzZ4pxxwq63_4u0Nd-h9NKx5gelr7ptA
Message-ID: <CAEf4BzZfuqpdwghCZ_TJJyt3Dm=xCBJLz3H0bbtabgToNV7V+A@mail.gmail.com>
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

On Fri, Jan 9, 2026 at 10:49=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> Add trivial end-to-end tests to validate that KF_IMPLICIT_ARGS flag is
> properly handled by both resolve_btfids and the verifier.
>
> Declare kfuncs in bpf_testmod. Check that bpf_prog_aux pointer is set
> in the kfunc implementation. Verify that calls with implicit args and
> a legacy case all work.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  .../bpf/prog_tests/kfunc_implicit_args.c      | 10 +++++
>  .../selftests/bpf/progs/kfunc_implicit_args.c | 41 +++++++++++++++++++
>  .../selftests/bpf/test_kmods/bpf_testmod.c    | 26 ++++++++++++
>  3 files changed, 77 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_implicit=
_args.c
>  create mode 100644 tools/testing/selftests/bpf/progs/kfunc_implicit_args=
.c
>

[...]

> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +extern int bpf_kfunc_implicit_arg(int a) __weak __ksym;
> +extern int bpf_kfunc_implicit_arg_impl(int a, void *aux__prog) __weak __=
ksym; // illegal

C++ comment

> +extern int bpf_kfunc_implicit_arg_legacy(int a, int b) __weak __ksym;
> +extern int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, void *aux__p=
rog) __weak __ksym;
> +
> +char _license[] SEC("license") =3D "GPL";
> +

[...]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 1c41d03bd5a1..503451875d33 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -1136,6 +1136,10 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_o=
ps_args *args)
>  __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, =
u32 id);
>  __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args *a=
rgs, void *aux_prog);
>
> +__bpf_kfunc int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux);
> +__bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_p=
rog_aux *aux);
> +__bpf_kfunc int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, void *a=
ux__prog);
> +
>  BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
> @@ -1178,6 +1182,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilog=
ue, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10)
>  BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1)
>  BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_impl)
> +BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy, KF_IMPLICIT_ARGS)
> +BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy_impl)

(irrelevant, now that I saw patch #8 discussion, but for the future
the point will stand and we can decide how resolve_btfids handles this
upfront)

I'm wondering, should we add KF_IMPLICIT_ARGS to legacy xxx_impl
kfuncs as well to explicitly mark them to resolve_btfids as legacy
implementations? And if we somehow find xxx_impl without it, then
resolve_btfids complains louds and fails, this should never happen?



>  BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
>
>  static int bpf_testmod_ops_init(struct btf *btf)
> @@ -1669,6 +1676,25 @@ int bpf_kfunc_multi_st_ops_test_1_impl(struct st_o=
ps_args *args, void *aux__prog
>         return ret;
>  }
>
> +int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux)
> +{
> +       if (aux && a > 0)
> +               return a;
> +       return -EINVAL;
> +}
> +
> +int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *aux=
)
> +{
> +       if (aux)
> +               return a + b;
> +       return -EINVAL;
> +}
> +
> +int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, void *aux__prog)
> +{
> +       return bpf_kfunc_implicit_arg_legacy(a, b, aux__prog);
> +}
> +
>  static int multi_st_ops_reg(void *kdata, struct bpf_link *link)
>  {
>         struct bpf_testmod_multi_st_ops *st_ops =3D
> --
> 2.52.0
>
