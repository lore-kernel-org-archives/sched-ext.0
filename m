Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A672D7398
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 00:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789432759; cv=pass; b=Pir6r1gp+Rk42j1m/8vkmQo2caTEf28BjU1/SgM0DnzEQWPuEyzJ64jPcwYPaIvCD1KqYrBTocl96HZGOh3pF7xbnQv7E1jM8mLGJfwH1VnaZyK1w/jRKMn4no+kP3HPnbhhwVBVykUfFMCN8k5OZ7KEj7UnEoB/0sS47xRUlZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789432759; c=relaxed/simple;
	bh=BaMmrTOGqMeTWU4cHIgEhE8sDQ/KoVQiVvTC0uPQTBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCIXZbN/DQB+lUZqHkKYnA7DQfTEJBANUpDmmYiCvvP+MnQTY2te0A2lEY+wpbe3yesyYb3kiTQDIbdJeu4aa6CEojgz5xubED3B7ede3C1YRULP4SsU3XqXTNSIXTHno4yO8KFaXESnD6AeMereuw/oQoCaYEurVulDbOz/wlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQgTTJYA; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQgTTJYA"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6b1334a3b16so2770054eaf.1
        for <sched-ext@lists.linux.dev>; Mon, 14 Sep 2026 17:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789432755; cv=none;
        d=google.com; s=arc-20260327;
        b=fmvhT9pWRjRaJOu+tWc1aunm7MznYflTQNiN1vkoNrY7KR2OdWg5FrxxY1HOhdik+Q
         hiwFIVAoMWwl4Q7St3+Z2XyBA4DG/2djYU4H9WcwjCd3L5dYzP4Dn1LRhdDF1B83AgWG
         VPkmYPNOJC3tzZxchGKr0B9MlRQCings6GdIYKMDGKcaYHNl+VSH0A5tktP7cSxkmO1n
         tNr7NLHMVqrGlZolFJATKkgDoWHtH9nQe/XJ6mpXNdWIdv+d1VAPi4xKET53VyOOgEj/
         P/zu8she/PNLdk3n7WRfpSP/eMt/yNrlfvxS9Ozm5YOUnRraYN8efPvvgll0vckQDhBo
         w/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=acTxuAJD7BV/aV4sehYd/xwIkSac/YA3bN2NNfcEwh4=;
        fh=xoGerofDTz/yUokr0U2gIueM6SX+x7NRT5gSnhPsaD8=;
        b=B7rMrMyZMEfPJnPjxDs9aRm5QW0aIyw7H52CqZVBGdyiO5w2pWgPEVBKBN9nKutzli
         sWmygrtVTos+yx14oiwygWrjSdJYW7heuVQ40n0NjxoKvDuh3y3QNHCTF+e5Klyqc3+H
         VvQJNh9SHd8f/nbmnO+1PY9Z+GybCSEjUTJ/6dYLCJu46C26wIvDzZgD3g3O9ib4fIte
         XDTPMAytu65vDalRwM4138ngMIs4D/vaEAUJHLE6f8GY7teP1Abth8S4XHr+vL6TnRLV
         R8ueVZ1B3Y7/EA1zKlVwcJwLVquBLi1FEE3jQ5yFY8yzjxk4/RZ2n2oVq2T4r2UmUT7x
         IPwA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789432755; x=1790037555; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=acTxuAJD7BV/aV4sehYd/xwIkSac/YA3bN2NNfcEwh4=;
        b=NQgTTJYA8emrAMFSnoKfeI+qaSsqJURNpTp90Cio/XQSLJbsBfTK1DjwB+D4dP0U6a
         xezatZCthH2jv4MzQQuu3JiwWng8Z+2YI7JPXnxzLjC1BmChKYHNwmtIfj7TmB7SdQrv
         UZt9XmvdYWwB/PfrPzx4ttoeNPGbNZ55TaGtpZouOJjZ9BqXBcgsAbS2Fal9GPUZtDtp
         Ww+F7v4zZX5zt0tJE09QRFXn6ahBeonwGvXuSIqUuUjllG+bM6ifBM0a+hlxD7+4e4u1
         /74pqs7HGXmyKgQ/LZ1ev6NLn/lrfymMGcYv1Yk/WapVFxJ9hTJtxlOhRVYSwVn3Txte
         C8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789432755; x=1790037555;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=acTxuAJD7BV/aV4sehYd/xwIkSac/YA3bN2NNfcEwh4=;
        b=opv4PHklHwDds/uRu883Fg/wOB1pvHOHCVhDF1CIGO7OeJD2Wk3oM4FkMpaak2TxCD
         CZ5qY/7JdiplKcgxxDO5OOn+sYRPvaXu++gZ/lInack3Wzgd+emkWMq5H0fVV1fMeuIW
         i0syH4c4vDP3Qb2d6XDZvRKjw2RSElUUSHZwCwoVnFrct9O1OF/8J3VKU8vC3vM0qqAq
         la5JGNb0d4lXM7GKB1j9Ag0DZxngMPiVIJDfcLbvzFBxzOr1WdFv9k1eEEzU9YtSimbY
         5HGJIhlXPnHhIGVbJ7mHTmN+kWoXYa8clCb1xy8zhHWySbGJgsYpH3bSXz0QZszT89p3
         vKtA==
X-Forwarded-Encrypted: i=1; AKwUvBxpLt1G93R8IvIasWXaEyGjOXmQGsU2kxgzbvMjPU8gr6B7/Bu/hjmy25vgXGLH0LowuzdbDrUzRGw=@lists.linux.dev
X-Gm-Message-State: AFuF++kgzh/QVlRXHouDWl3BL6X1ekefYAhOfaaS8upzrADUz/Ff8kHF
	Sp8LMkdl+0itvZzgh8PoC+T+n3dvgY+ba1X6k/E2MUSPRry5bPc0EHAPfuOBXGY6F8rR8JUjLK+
	yKXcsEgrRIy265AT340Gm7BF6X+vYxJutwwDn
X-Gm-Gg: AYBFou2essIwEC8ITL4EXlN2+NNYPqYewPq+kVqCdpJP4SCbGmMXGAZM5x6KpGE14HM
	HxcYBsu3Aq+hUG81R43Us2btnXs3WhY7y5R0VDzdAdFB+PVmY7l5V9mrho20Prm/PYrERpchrD5
	qXYVftF4pKgvsv2x3zfhbLPc1R37mX9el7Hny3eaoKRaeH6S0Tpfv16TiQsdgTXL9yvZ7dGCAHP
	96WRgqwG5HTJwmuioiRgt+JoiY9v46lIL673MUwiO9p6Yb2EIO2ZgeX01Mr5NYwKDqw/WRRi6OA
	6pMKxdn53yu+SOmfZ/2d7p5kxO4nhckg+/WRdWHYCroqlx1hP4prlFmX9XagHTXWGQ==
X-Received: by 2002:a05:6820:4b87:b0:6b7:83d6:2924 with SMTP id
 006d021491bc7-6c542342787mr2847248eaf.39.1789432755522; Mon, 14 Sep 2026
 17:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <86d966ec88bbf27d21b2bb4e18c8aa00@kernel.org>
In-Reply-To: <86d966ec88bbf27d21b2bb4e18c8aa00@kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 14 Sep 2026 17:39:04 -0700
X-Gm-Features: AcwNN1WwzbGgP9OStftE8DTtFg0Y2xPQZsTNxTjlp_yK5QH7a8LBh2qdmMY2Tp4
Message-ID: <CAMB2axMJ6NJUtDc4xhUbSaqUsRyNXfyWTNTR7SCYyRwiBdoLAg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Keep generic __uninit kfunc arguments live
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 4:43=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Stack liveness models a kfunc's __uninit pointer argument as a pure write=
:
> whatever the buffer holds before the call is dead, and 2cb27158adb3 ("bpf=
:
> poison dead stack slots") poisons those slots at every checkpoint the pat=
h
> visits before the call. Argument validation disagrees. Only dynptr argume=
nts
> honor __uninit. A generic fixed-size buffer goes through check_mem_reg(),
> whose read pass requires every byte readable. The two rules meet at the c=
all
> and the poisoned buffer is rejected with "slot poisoned by dead code
> elimination", even when the program initialized it.
>
> Every kfunc with a generic __uninit output argument is affected,
> bpf_ksock_create() through err__uninit and sched_ext's scx_bpf_cid_topo()
> through its output struct. The rejection needs the buffer's slots to be
> allocated and dead at a checkpoint, for example on the second iteration o=
f a
> loop around the call. Before e566701b9b0c ("bpf: Check fixed-size mem arg=
s
> of helpers and kfuncs the same way") kfunc arguments could read poisoned
> slots, so the call passed, but the slots stayed poisoned and the program'=
s
> next read of the buffer was rejected instead.
>
> Restrict the liveness write-only exception to dynptr arguments, where
> validation accepts uninitialized output. A generic __uninit buffer stays
> live and is never poisoned, and validation keeps requiring it to be
> initialized. Add a selftest with a scalar output buffer and a checkpoint
> between its initialization and the call.

I don=E2=80=99t think restricting the liveness exception to dynptrs is the
right fix. The fact that generic argument validation does not honor
__uninit appears to be the underlying bug.

A generic __uninit argument should behave like a helper output buffer:
generate MEM_UNINIT | MEM_WRITE, validate it as write-only, and mark
the written range initialized after the kfunc call.

With that handling, bpf_kfunc_stack_access_bytes() should continue
returning -size for generic __uninit arguments. The current change
instead makes their previous contents live and requires callers to
initialize an argument explicitly declared uninitialized.

>
> Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/bpf/verifier.c                                      |    3
>  tools/testing/selftests/bpf/prog_tests/verifier.c          |    2
>  tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c  |   45 ++++++=
+++++++
>  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c       |    9 ++
>  tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h |    1
>  5 files changed, 59 insertions(+), 1 deletion(-)
>
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12755,7 +12755,8 @@ out:
>         /* KF_ITER_NEW kfuncs initialize the iterator state at arg 0 */
>         if (arg =3D=3D 0 && meta.kfunc_flags & KF_ITER_NEW)
>                 return -size;
> -       if (is_kfunc_arg_uninit(btf, &args[arg]))
> +       /* only dynptr validation accepts an uninitialized __uninit argum=
ent */
> +       if (is_kfunc_arg_dynptr(btf, &args[arg]) && is_kfunc_arg_uninit(b=
tf, &args[arg]))
>                 return -size;
>         return size;
>  }
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -53,6 +53,7 @@
>  #include "verifier_iterating_callbacks.skel.h"
>  #include "verifier_jeq_infer_not_null.skel.h"
>  #include "verifier_jit_convergence.skel.h"
> +#include "verifier_kfunc_uninit.skel.h"
>  #include "verifier_ld_ind.skel.h"
>  #include "verifier_ldsx.skel.h"
>  #include "verifier_leak_ptr.skel.h"
> @@ -214,6 +215,7 @@ void test_verifier_int_ptr(void)
>  void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_c=
allbacks); }
>  void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_n=
ot_null); }
>  void test_verifier_jit_convergence(void)      { RUN(verifier_jit_converg=
ence); }
> +void test_verifier_kfunc_uninit(void)         { RUN_TESTS(verifier_kfunc=
_uninit); }
>  void test_verifier_load_acquire(void)         { RUN(verifier_load_acquir=
e); }
>  void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
>  void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Tejun Heo <tj@kernel.org> */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "../test_kmods/bpf_testmod_kfunc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +/* keep the BTF FUNC record for the inline assembly reference */
> +void __kfunc_btf_root(void)
> +{
> +       bpf_kfunc_call_test_uninit(0);
> +}
> +
> +SEC("tc")
> +__success __retval(42)
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void uninit_scalar_struct(void)
> +{
> +       /* dead before the call, so poisoned at the checkpoint */
> +       asm volatile (
> +       "*(u64 *)(r10 - 16) =3D 0;"
> +       "*(u64 *)(r10 - 8) =3D 0;"
> +       "goto +0;"
> +       "r1 =3D r10;"
> +       "r1 +=3D -16;"
> +       "call %[bpf_kfunc_call_test_uninit];"
> +       "r1 =3D *(u32 *)(r10 - 16);"
> +       "if r1 !=3D 1 goto 1f;"
> +       "r1 =3D *(u32 *)(r10 - 12);"
> +       "if r1 !=3D 2 goto 1f;"
> +       "r1 =3D *(u32 *)(r10 - 8);"
> +       "if r1 !=3D 3 goto 1f;"
> +       "r1 =3D *(u32 *)(r10 - 4);"
> +       "if r1 !=3D 4 goto 1f;"
> +       "r0 =3D 42;"
> +       "exit;"
> +"1:"
> +       "r0 =3D 0;"
> +       "exit;"
> +       :: __imm(bpf_kfunc_call_test_uninit)
> +       : __clobber_all);
> +}
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -1087,6 +1087,14 @@ __bpf_kfunc void bpf_kfunc_call_test_pas
>  {
>  }
>
> +__bpf_kfunc void bpf_kfunc_call_test_uninit(struct prog_test_pass1 *out_=
_uninit)
> +{
> +       out__uninit->x0 =3D 1;
> +       out__uninit->x1 =3D 2;
> +       out__uninit->x2 =3D 3;
> +       out__uninit->x3 =3D 4;
> +}
> +
>  __bpf_kfunc void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
>  {
>  }
> @@ -1493,6 +1501,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_int_me
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass_ctx)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass1)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_uninit)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail1)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail2)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> @@ -160,6 +160,7 @@ __u64 bpf_kfunc_call_stack_arg_big(__u64
>  void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
>  void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
>  void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
> +void bpf_kfunc_call_test_uninit(struct prog_test_pass1 *out__uninit) __k=
sym;
>  void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
>
>  void bpf_kfunc_call_test_destructive(void) __ksym;
