Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524FF3BE14A
	for <sched-ext@lists.linux.dev>; Mon,  9 Mar 2026 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074631; cv=pass; b=TDn9roYUQmCdO0n7SGgly3vYCCen7jCnzzBnCQ52NivdNX/dQEhNmHAwsQI6EmRz/aZdxxthwktIVgMYwoDtQzZwPfQ/l7IKTi45wshJ9gM5qZxBVHfX/Kpx8FKTJ8/RN37IXZn86HyUyRksBeSFoxt3QKrNnrBbbHXRm6XOT38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074631; c=relaxed/simple;
	bh=AkNgp1eLlxvEHqjLOIKt78ShAP+kfaM9ulUs6EDX/Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6h95JnzL+SsnTzkuhXBOMOdzJCFmLeD6fuGOfhSJ5Ih/LcCfampebtf9nhxykSAMufs9L+R1WfToB4gjzsN4MQVuO7Niia3A+DOGDrZJ9l2+tVndi9a73e5LdUxKv+zQK7Qw6HFNu97DZ+OcMGckT1sr43HhKzFFToOKn2b4/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTZb0XH+; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTZb0XH+"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439baf33150so6354674f8f.0
        for <sched-ext@lists.linux.dev>; Mon, 09 Mar 2026 09:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773074629; cv=none;
        d=google.com; s=arc-20240605;
        b=dk/yyoGArLN5q3wAPHTtX5ZCVYrFnJV+9ly4AAF90gfSNgKpKLhm/WZqjPktginR0m
         Qz6nG/I0ms8/EYEYzckHORCsnXfE8Pd/txw1FBz/NlMbaNR91zUv1C2Dq0a9Xz1QYI0O
         ACxPRKvAuF2djIlHVjRo6CGvKN0/oQBIGPQHFiiCN3X6iryETipISmG8x5IN33VFURIg
         mmwifrstZzTD/pCFHNnwM37mG+ahCTyadc5/zSnVnNDhYmrzh5fIrA7sWVj5z2j9lV20
         oDzmM88Ufzo+ZTu6UcSx0qsxHDMqdr2NlYZtQZQ8LkOI7F+X2eU0GopcYhbWnbacAnbv
         xoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e4EhVoj49ZUMnMW1q1OJFdF+yBsMfqNiDQfLN/Qthj0=;
        fh=X007lXZJMvd+j9sNB3D+ENyVu7wdeVA3QvdEFsbU0pI=;
        b=Iat2SMAw8eWEwzveeH1rU3eKiee7Zvkdu3XX876ZrY3TkzVlA6RPmpxbAuBjmBVNyG
         z6P9d0uzoL6TMUs6SSF2+HXvsuFIp8m6RsDn5hZQZ/3aCphbvq4aeZpBsZVUJ440lzLw
         7VWEaMv3wbnhtTy0oZNKpob3PEAtfnOfujNo7RUBO/fihZg87G1HzCUU8SDLPeYLbnri
         nxecCupIXSTHMqOKBwAP2vXtkhMSE1RYluX3L+yA3MgWUKdPXPIvDOlalBTUNXJN/kdE
         ikTzVxueKhKtsl2XfeLC+Cz6OzU/TB7aoxW71ei/2N2t9OIO3Ch4V8sNpCrGCDMuyLB0
         qo3A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773074629; x=1773679429; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4EhVoj49ZUMnMW1q1OJFdF+yBsMfqNiDQfLN/Qthj0=;
        b=UTZb0XH+EtZiMYpo6AjUTP3R94pOxteYmAb7LfR5v9LqSILOR/+hi8D70bJMoy9hnb
         iLuNhAiC4cwbsGvXZXFRKrsUe+Q8lXgvNKyWAvoXf5dBis7frOxTodx/1qOpSruIhpPi
         7ZQE6Ai6Bi3OOAtcCkQT8pIo6DTeJ07VLHxWkcrgAYw51jCFVfWVtBMg0uUgArHvmV1q
         q7RSwxy62pOrmfKPhTa0Ok4gltkvkuaxC2xM+NbKcKcWfNSOaDD6ZJx0UOuV4Cktlb/A
         r8AFd4zi+9jIRqb96j7Vlb5jTMa2cwXiZTQuM8iHJxo5DsUr2VVSXgAXzCP015tsQAFr
         dN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773074629; x=1773679429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e4EhVoj49ZUMnMW1q1OJFdF+yBsMfqNiDQfLN/Qthj0=;
        b=EMiHEVRn65Sy0pkhHEbbhZyt1Kf+Pgelsaz1NnSo/ce5/xeQw2ePtN2CrYK54fbKVn
         smZJa1o/G4zqh+gnuIfAJraJ5HvayD6GiHcF42qE3hPEYWIWcriDqn51vJDnsSGpG1F5
         Xgxl13DJdcYN2Flo4gG7/Fd7d5nMHPBZDlmsKnid5Op0c5K+s4yr0uW6tvBVGk+jvpDW
         EckhyvL+7I1Mqprir82NVePajnWeW1Xxr29PGiQv/wls1aXmN+uYrdU+PsZIfoi8PzyL
         6oomtKfGpJGXs8V6Cy7e+RZv/a2HTLdKGMPcTMCy2fl4eQvJpb3IIejYt6hpQMllLxDe
         QkbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrq7hn+82G5X7d6m/3nvatJ2Sm0nN200zy4Y3sRisRTVuZq8To2kvcK5sf77NmiSEFtsuB/Ce+MFw=@lists.linux.dev
X-Gm-Message-State: AOJu0YzR5K+8lsfMMDnA99rvhT16k+NkQzYrYMbf10thd7GwOWfl1pEy
	5KHbpGSqEk1/i3UhEvvmV6zoAmUIZSAzzsvgb2K+mxD+EWMPjDbFPM+W/1L4vDtloSX2aoq3DFI
	iHh3gVL1FLeEzNcqovoNPeqNr3TQnK74a7Q==
X-Gm-Gg: ATEYQzz103dTGPmo/8726sP0ECULXSfkpVr8bTgaf/i1BzhLanXIcmZN14qCQWJORNu
	yRk2K/LIh1W/IDnABEiBdyODYFVwOEt4uRidtljcLk328qqehmWIk1tgcun/2JZcATaiBLrBike
	57FaBt91WHhVTKHUlA/t5Q/NtG9ZfDvdgX0AnVTvCcQZ9qxemm+9uZKFvDqi7bHyOW9eNKfdJoI
	Yt6UlpHqfttQV18ItaEtruj4MXa7nPFKt0+XNWGxJ9aVHYSxmqrZBNjRmpr4PKzNzfkIsw1NlQA
	3DLY1o0VvBS+b4TnVJBVmnVVf9VYu8Sy/nwumIbERMEYS+FIka+NLkkrK31yGtC/x1SQL/CeOpv
	wC+U3NIy0ZK4ZRs/+e+vRctQgzA==
X-Received: by 2002:a5d:5f82:0:b0:439:ddc0:4bef with SMTP id
 ffacd0b85a97d-439eff2fbd3mr537205f8f.8.1773074628559; Mon, 09 Mar 2026
 09:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309022847.106150-1-zhaomzhao@126.com> <20260309022847.106150-3-zhaomzhao@126.com>
 <DGYECIPVC266.25320R7256YJT@etsalapatis.com>
In-Reply-To: <DGYECIPVC266.25320R7256YJT@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Mar 2026 09:43:36 -0700
X-Gm-Features: AaiRm50Dkzn77wqhRT6cnmHBFSFIlO8rogOJoWrV3he1NEuRyNufB70yN3teypA
Message-ID: <CAADnVQKdrt3fRcfBrJqSfPP9ALVD59cAQFuDANQG+_=0XDEq5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tools/sched_ext: scx_sdt: Fix BPF verifier
 rejection on older LLVMs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Zhao Mengmeng <zhaomzhao@126.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, sched-ext@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, zhaomengmeng@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 9:40=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> On Sun Mar 8, 2026 at 10:28 PM EDT, Zhao Mengmeng wrote:
> > From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> >
> > Under Clang 17/18, when running scx_sdt scheduler, it fails with:
> >
> > libbpf: prog 'sdt_init_task': BPF program load failed: -EACCES
> > libbpf: prog 'sdt_init_task': -- BEGIN PROG LOAD LOG --
> > ...
> > ; desc =3D desc_find_empty(alloc->root, &idx); @ scx_sdt.bpf.c:479
> > 43: (79) r8 =3D *(u64 *)(r6 +32)        ; frame1: R6=3Dmap_value(map=3D=
scx_sdt.bss,ks=3D4,vs=3D200,off=3D120) R8=3Dscalar()
> > ; for (level =3D zero; level < SDT_TASK_LEVELS && can_loop; level++) { =
@ scx_sdt.bpf.c:407
> > 44: (e5) may_goto pc+51
> > ; idx |=3D pos; @ scx_sdt.bpf.c:418
> > 96: (bf) r7 =3D r2                      ; frame1: R2=3D0 R7=3D0
> > 97: (bf) r1 =3D r10                     ; frame1: R1=3Dfp0 R10=3Dfp0
> > ;  @ scx_sdt.bpf.c:0
> > 98: (07) r1 +=3D -56                    ; frame1: R1=3Dfp-56
> > ; bpf_for(u, 0, SDT_TASK_LEVELS) { @ scx_sdt.bpf.c:447
> > 99: (b4) w2 =3D 0                       ; frame1: R2=3D0
> > 100: (b4) w3 =3D 3                      ; frame1: R3=3D3
> > 101: (85) call bpf_iter_num_new#82234         ; frame1: R0=3Dscalar() f=
p-56=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D0)
> > 102: (18) r9 =3D 0x1ffffffffffffff8     ; frame1: R9=3D0x1fffffffffffff=
f8
> > 104: (bf) r1 =3D r10                    ; frame1: R1=3Dfp0 R10=3Dfp0
> > ;  @ scx_sdt.bpf.c:0
> > 105: (07) r1 +=3D -56                   ; frame1: R1=3Dfp-56
> > ; bpf_for(u, 0, SDT_TASK_LEVELS) { @ scx_sdt.bpf.c:447
> > 106: (85) call bpf_iter_num_next#82235        ; frame1: R0=3D0 fp-56=3D=
iter_num(ref_id=3D2,state=3Ddrained,depth=3D0)
> > 107: (15) if r0 =3D=3D 0x0 goto pc+29     ; frame1: R0=3D0
> > ; if (tmp->nr_free > 0) @ scx_sdt.bpf.c:456
> > 137: (bf) r1 =3D r10                    ; frame1: R1=3Dfp0 R10=3Dfp0
> > ; bpf_for(u, 0, SDT_TASK_LEVELS) { @ scx_sdt.bpf.c:447
> > 138: (07) r1 +=3D -56                   ; frame1: R1=3Dfp-56
> > 139: (85) call bpf_iter_num_destroy#82232     ; frame1:
> > 140: (b7) r9 =3D 0                      ; frame1: R9=3D0
> > ; if (unlikely(desc =3D=3D NULL)) { @ scx_sdt.bpf.c:480
> > 141: (15) if r8 =3D=3D 0x0 goto pc+15     ; frame1: R8=3Dscalar(umin=3D=
1)
> > ; chunk =3D desc->chunk; @ scx_sdt.bpf.c:485
> > 142: (79) r4 =3D *(u64 *)(r8 +72)
> > R8 invalid mem access 'scalar'
> >
> > The reason is these older compilers lacks native support for
> > __BPF_FEATURE_ADDR_SPACE_CAST, __arena macro is defined as empty.
> >
> > Fix it by adding cast_kern when dereferencing variables with __arena ta=
g.
> >
>
> I am not sure if we want to support older Clang versions at this point.
> This issue is fixed for Clang 19, and adding the macros back in makes it
> confusing for those who use the code as a starting point. And while
> it would be nice to support older Clang versions, we already don't
> handle Clang 15/16 that don't have arena support. So it's not
> unreasonable if we say Clang 17/18 are also incompatible with this
> example.

+1
People should upgrade their compilers.
