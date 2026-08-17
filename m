Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE44456E17
	for <sched-ext@lists.linux.dev>; Mon, 17 Aug 2026 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986912; cv=fail; b=IUuxOuNvXsGvVHgDTbLXUSmuXsGyA48+WX6gXDHEQdvmby9Ej6SfxfPVU8+0Irk22OkJL+KGV4kl5OT/93H5/zkeF/DHJ+s4iKWJOoKeX41ewpQqmmHX95E4NQrd6uPozd3MUIq+/rDwEJzP1KEzWDniBjb7l1HUolPYs4RqjGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986912; c=relaxed/simple;
	bh=unEk75h4RazW61+CTbm2OkL2vcW2H4HQkbdjsMJg7J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRgLSDMAMqlgwkLcXf1j8b88QH73HQokWN5BkPrbfu3xCr0cEXoJC3C4iI1MZjkgdBhqHab6QQqMdcjBJl/kogMnBPrahdbJncr3ED5MPCutmoq5hPR2/1OZFdz6OBWuGBMOkQOCgr/dKMc/XDIcvG0HW1VwjFZX/R1t/uliLzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dYHCFhF9; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dYHCFhF9"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFYv6g366792
	for <sched-ext@lists.linux.dev>; Mon, 17 Aug 2026 10:15:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=njvrH7x9GyJo7i1wnbi3Q46/eHKvNpCFfvtLC
	nuO51Y=; b=dYHCFhF9ZhRPYIkTaIZmQc0ZglDsa4tQXTidjHGegc8Gw5Cpb3CC5
	jZ4EuhP48kQfwBiMyKsfxMUgn43+xOFIUAhe62uOGQQS3MuGbjQyN9z0ujdg16Kn
	b0QQWNAnd129mksesLlQ6reh6gJUneiPcWKWY6nhA92yfZohTJZVymfiZNk+FI49
	0xb1/Cci7Kca6EYtez1nlz/oJlFCUHx/7eaxoJCLZmm0Ox+4amX8PpFd2XAn7MWX
	IKu3bfuMqtfOxX+y1dWa8ae+IvocL++PENBgLG67Al4wzPJnPnRlLpzXKlxLm7gm
	r7s8fUI/gYuAX69o4wWb0DSA3/kYuZM1w==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g38rhy8qf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Mon, 17 Aug 2026 10:15:09 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4b28deb7ee3so731257b6e.0
        for <sched-ext@lists.linux.dev>; Mon, 17 Aug 2026 10:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786986909; cv=none;
        d=google.com; s=arc-20260327;
        b=MM1hXBuhHaz/BRvZvbo4oaye/RUNwt1buSVXkRQYmS5K2AbMvQSPkD2CIbbJlzA8n2
         EGhztmDiJv3jqxtodEZ/1IFCdHLjGmAndU1Tx+AVB8n83aSDesW9INigWHS5DqEoWoSH
         Ffta/D0QteC76l4drg+hiDU7gdx9+aDKvrY7JCi3sJlAAAzcCCTUWHh9sNJW0F9mpR2n
         rOFU7XbLYgta4du5+QDD2QSSdKfrdyWmeEjoYbIvJrhujgkT37eiPFDAdWntautw2Rds
         Fi+ldQbuIJVEEl3z33cQn9UiA4kVosV2zCq6UyntTd7ZNEpQ8BR07HTuuQNZbYc8aXUc
         KydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=KoTFa2IJT7Dn6m6sQQ51SO0r0kVa/rVmT5mp9uvRqLo=;
        fh=LWyttUZApqRNnc7VSQ2EnwMawyDtdF8rqYF9cis8IdA=;
        b=X3g/ugpEBqQaNOBrhAuEGWf33dBq5/6Tkq2kO1O2mGUqeFtLFpu4ysnMNJOIcGkMxr
         XjaB+crlKFp98EXXcYjePz+MJX980/XOQUFbut/JBJZTU/ZhHDXFHW48mzTAK9ssen+Q
         LjVqHYfdTkXmvp5uii6EFb7mh0UN8LudKlwdX0HITm3S6MUDYEeqFHjCaYQN/qWt/yk/
         vgOu1LpVnt9GPK8N+hBrUzqjLUDxZwKB4aKqkl+a7AazfDcKfj1m7rZVO3qz1Egtf6NK
         7xcTb+UIVsiIs2teq5hQAt2q1FfPCJ9E0KV0ch0ooDQwCSM1qDfOymohWVFQsFRrbqTd
         Rajg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986909; x=1787591709;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoTFa2IJT7Dn6m6sQQ51SO0r0kVa/rVmT5mp9uvRqLo=;
        b=nwEYDMn/tfGuCan+aXt9jHIcH5Ny5lNNkblOyx8uYrlczEWzdNBk7rxivGUV9iD+wQ
         mkOrND6Im0Q4DEz/SJsKKbIiwU4O7K6szfl5b5iZQGqytmhGcAC343nmIOH8qCThu3AG
         y/yazyqzwxRy3hHvo61BSJVT/SDlIhoQgiLTMKVStiaGZ1hZHlE2rDNd3HQSbJeMrwuZ
         6tnvKmqGx6uQc4Vweby+0lNmMrpXcWXrcIHEO46kS/3wCsmGsHXt2/YrVj/AOInNRTJN
         SRWZ6svPCtk7Q5lT7ODTlzuEnGWT02m9BWB9/LvYjBRfeQDf97Xdr5rEyIB9xnMi4ICa
         UG1g==
X-Forwarded-Encrypted: i=1; AHgh+RrLRGkSKkMUHZqCMOK+F2K5SbUw5fCpEAmDUv+E2hWQiBo+NupsIsXSfW1gVQVVeX0demkHg71171M=@lists.linux.dev
X-Gm-Message-State: AOJu0YyNTw4cLuRpoCKAt3bQHMx3AKOopt1WXNp9bKwIPx/F1YYRlLnE
	mx3wQxHqtOnq+6CNeY1Flu883GQPiVHGdpT2WTAhOCY5Dkj/+RxlKt03gl4nPgE3qbol2iX+J2g
	BULiLtT6gxwMOsa9JL+WbMjON0OE/pN2jI6hMswB32Wm+d65uCo6ND4/h2Arik5N40wH6N3Eqo1
	IR6Dsec/3oCDIuD/n8I2yuQXL4lzQFzF1LqGY=
X-Gm-Gg: AR+sD13BiPGYeR8p7BGLZg/vzWYGSNqrbHAd0RUpC+pvQCoDbSBOKnSmL5ZdlN/3WSI
	SNb0nKRzjVyvJjFzH+/icRDrpG+zvgF0FXgd+x1BZOXErtNkMUOKHPD8iPrtVyCKJgAmxK99Fpb
	Y5E9zWJIEsonFtgBa1WD1J4g9VnEix3lESCsXHjTukcQ+K5tqqKRl0SQb+ry5Rke1mQlxy2MyfD
	jtx27QCrRg6622H
X-Received: by 2002:a05:6808:3502:b0:489:a387:1e29 with SMTP id 5614622812f47-4b297a4b8a8mr2209407b6e.20.1786986908699;
        Mon, 17 Aug 2026 10:15:08 -0700 (PDT)
X-Received: by 2002:a05:6808:3502:b0:489:a387:1e29 with SMTP id
 5614622812f47-4b297a4b8a8mr2209358b6e.20.1786986908219; Mon, 17 Aug 2026
 10:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260803001807.646357-1-changwoo@igalia.com> <c9f8616b-15df-4c5a-8184-bf4d63813afb@iogearbox.net>
 <75bbbff2-5ea5-493d-b543-ce40d968f3cb@igalia.com>
In-Reply-To: <75bbbff2-5ea5-493d-b543-ce40d968f3cb@igalia.com>
From: Emil Tsalapatis <etsal@meta.com>
Date: Mon, 17 Aug 2026 10:14:57 -0700
X-Gm-Features: AcwNN1WgYsoY-VjTAIHqOFfCfsXsbtxggdrhdfKy9FCfC4rkn4z_jRHt57GCGQ8
Message-ID: <CAMe2y=Gm9K3cwsM7Sff3ZaKani3z4tVUQv9u1KzbetJF8OrW=g@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Remove duplicate copies of the arena
 spinlock qnodes
To: Changwoo Min <changwoo@igalia.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, sched-ext@lists.linux.dev,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEzMiBTYWx0ZWRfXz/l9Pkd3DnEQ
 wQiiFQr/ndQKYJEJwgR6n6HfsgQnEmrnTfRAt8L+o2tOFcvOOuJqFltCoPcbEl7Dkg9/DVzyjLN
 tYKkSG/BFXzH0rUc4XRQW+GwZwok1tG3fe4N+RI2B0/paFXVKZI0JJw1MrjGYPEXePW+1bOTSKR
 aVFG8AcHQsfZP9n4dv1Zf75t68Lr4D/o3WCevcy6N72J7mjzuJpvbkSwpn5ZpMVS2YELJZuVzeC
 EAEKZ4omlG8zcf9lQGEXZMeE5HuWCBaL97cadYb9u0mYUTLAjsyupoJr8/FKLfaz8ESztCZZLX2
 FNK7drdA7ZRBPYFoLm4JDOXYa9GUmfDmYkwFsJ3R/d6e5PfqQtppDiczkKJCpfSqwIVrVK6LHuv
 DJ8IVAl+spVKsarCFub8JKwqIwVAErvtS0IxCtLkyrrD0GwhweW4/kbHbSCHso0yoGhCktiKSMh
 ADfT7isZ76MlsupgXWQ==
X-Proofpoint-ORIG-GUID: J8cJ9k0kquoNi7SzmxknnNRWLtF_kGat
X-Authority-Analysis: v=2.4 cv=coyrVV4i c=1 sm=1 tr=0 ts=6a83419d cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=V2sgnzSHAAAA:8 a=CWErhr8FAAAA:8 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22 a=Z31ocT7rh6aUJxSkT1EX:22 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEzMiBTYWx0ZWRfX71EOIEUZbjNV
 WtGDMmBVlBps/J0lsuJ7EuqJrCZ/EpH5btlI3sJQ7gv1IwBkuhrdctrBcT9E0+Cneo+x9qVjSqE
 Xs+Ypu8lRvw140649Jy9kPsfKltQ2/Y=
X-Proofpoint-GUID: J8cJ9k0kquoNi7SzmxknnNRWLtF_kGat
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01

On Mon, Aug 17, 2026 at 9:02=E2=80=AFAM Changwoo Min <changwoo@igalia.com> =
wrote:
>
> >
> Hi Daniel,
>
> On 8/17/26 6:05 PM, Daniel Borkmann wrote:
> > On 8/3/26 2:18 AM, Changwoo Min wrote:
> >> bpf_arena_spin_lock.h defines its 64KB qnodes array in the header, so
> >> every translation unit including it emits a copy. __weak makes them all
> >> resolve to one instance, but bpftool gen object merges only the symbols
> >> and concatenates each input's .addr_space.1 bytes, leaving the surplus
> >> copies unreferenced in the linked object.
> >>
> >> libarena links ten such units, so nine copies were dead weight (bytes):
> >>
> >>    object                             before       after
> >>    -----------------------------------------------------
> >>    .addr_space.1 in libarena.bpf.o    676200       86376
> >>    libarena.skel.h                   2100123      892371
> >>    libarena_asan.skel.h              2641124     1466477
> >>
> >> Declare qnodes in the header and let each program define it once:
> >> libarena in src/common.bpf.c, and the arena_spin_lock test beside the
> >> lock it guards.
> >>
> >> Tested with test_progs -t arena_spin_lock and -t libarena.
> >>
> >> Signed-off-by: Changwoo Min <changwoo@igalia.com>

Hi Changwoo,

Sorry for the late reply, for the next version feel free to add:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> > This doesn't apply cleanly, could you respin against latest bpf-next?
>
> Sure. I will send the v2 rebased on the HEAD of the the bpf-next tree soo=
n.
>
> Regards.
> Changwoo Min
>
> >
> > Thanks,
> > Daniel
> >
>
>
