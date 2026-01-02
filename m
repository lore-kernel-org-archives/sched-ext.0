Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6D2BD035
	for <sched-ext@lists.linux.dev>; Fri,  2 Jan 2026 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767370758; cv=pass; b=ihw230dRvhFF+F3uttgoqBkOkckKJZMa6nuDUDNhfBYyREodcLR3FqY/v7Rqy38iVxOANwjSPqtsmIxq7iyYRs73x2uIvFj4y/oM3e47AOHoSowKNTStmpY5DcBijB2tbPPutOt8SGyk0CUvPF2SXASMCH/ARQZ/4hggouvdVNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767370758; c=relaxed/simple;
	bh=3zUPHsmFXLRLRWZxrqxoS8IggoZhxzhMACoAYfeLcu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPml78x2CrnnhBsz2YMLHi/QsjspVe9Fkp6SBq5ZUVnknUx6bqxYDDTTAf1aQAvA6jV12ONTWG1/VsqmXSitmbMJnFJeE/wuCkFXJa+ZkwO42Fpn9hjhJhY0x+3U1BmB9oacIXRoGKEG+THvMEQb96SxqfOIIis8xnnuAGtprFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WkpXpzvg; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WkpXpzvg"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0a8c2e822so32218315ad.1
        for <sched-ext@lists.linux.dev>; Fri, 02 Jan 2026 08:19:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767370756; cv=none;
        d=google.com; s=arc-20240605;
        b=FMBFYVCW6IK10hAO1pOlCHHKDHCNoNs0munXnKifnfcloO2yEDtddt7WjkfjgyaQlN
         RcZq8iR9qyOruHHgy+NQWYqjtChjMJ7LJPpEOThs0S9K9MJcJ8onyS/DdkecBTie/WNz
         qgTbVhBzrJ/2VqlPwFqBmK9pzsVKtXoj64pK33YINUk9IK62VSmHPtdtDYz/iwniTjRs
         //mEo/O5kGLJ4NDkOdNM85Qsko6M0/sLQrTVVAS5RhJ4QYYPB0nDPnngZOvPEDLi2RNm
         iisBVW49yb2AlNOE1QOxK0sviG36PK+FX+MwkIirIZnprqcAubiPNL5aJZ2j+Kc1Z6bg
         M/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FPr557U2HvOHmBjLr/Ni2LmdX/a30qSDiDUWeBgkK/Y=;
        fh=lVFeAIHOs7NC7I9VQ/HMLD4O4uttrVVFSdT6kKl8xnE=;
        b=BepYVtM8mGjNvq+A50IZMWimeLBe1GS6gbJEdHKVegTZe+wOnypy9FNTvlWTgYIubO
         wcUIRUBE22AG918LUwKBS30GQktEllzRgjtBq8UA2K/cIoyCdcSShKcVsnTaZGU14T8G
         BPUQyPzMezUd8ISN/Cvzlb/YIC1lvxtGyTfLrvwsHIwawW2pFhdC16G/n7TjmZbXcNkf
         YigFJ7tqOCbmIph4SPit7puGPBJJhu2y7P7MGFxSI6HSQiUMLk/BA8Kr0RlW17T4a0Xo
         NIbJp8/hQ+zIW/fHySn9F2CsKwBTbPCiHx165m5B8u/IDZEeXhEal1yYY5xPcyQxyFyM
         xaHA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767370756; x=1767975556; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPr557U2HvOHmBjLr/Ni2LmdX/a30qSDiDUWeBgkK/Y=;
        b=WkpXpzvgz/oQHF52ItgnxaIwzz2qpbjVFotFkU2TWbSwpuUbEPYMr9X0eTD8PBRiw8
         4BRfkjFZfhMbLem9LpRIASOYD3PZd5JMnrBtPKEsBr3+9vbjeqrU7/7gmm0kSjUGLLma
         RVQUbGQB4FfYwaZnKEpXDnzpH4ShVo3apykomrgqxgZjUvpuG0G4obHc+z6v1cPAfs4s
         DHWmUG2BA0pmzz3YWlvzyAjWIvOO+EAdrQCeiK1TSpHZMm33GdSPk6tWTw+FUcGapoU7
         Wt4VHdkhKwsg/J1gc5ZMooOCpK6lAI+abifBTEWVDAmdenN0hup7jPmOP5vJKU6uedaZ
         fakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767370756; x=1767975556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FPr557U2HvOHmBjLr/Ni2LmdX/a30qSDiDUWeBgkK/Y=;
        b=bz5NPkfctY+KP/omFeD5JtJH2YNoKb9ss6AjrjMnbho6levjXgbJqntUC3Hfdjo6rO
         zhw5s8QxilZ1qYzo7GVMUuG2pnGQwKPd0DhNKUQ8M/v900OqAAcuV3aaW+bmxjHTPYEH
         A/8qprRTqiVq+LrX4z1oJqntNhS/tGhX7k+rWYhaebg1I91hKZzrn8kezJ9k1BGAyqy0
         +9vZaNkGnJDAge27u9mjwt628N6REAAW15jiZgFeukxC5UB5kj1PvZJD7RZcD21xiAhN
         VGKJzT3cYO1x1DuB9+/D2NOvKT6fxwBeOZydNhFGkZxiQWjAuXsDpwO2GFGBgTUpvVuf
         RsrA==
X-Forwarded-Encrypted: i=1; AJvYcCVcR4zjQJ8D1BtsYrRUIkV098k9tYMqgy4Kqym3zJzBd25TCJN2GbY973UXoo8jRcftfrRj5aOwA3U=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzt4FbhTXEckJOt+1eOCL8732omBWqs+9hCakvoQWLYEKtA1X3h
	alerNnk0A/G/imyLRGi4nVCiNb0uO/hu0AuVd4ubxqao+llXuy61fca97tExr6s7lH9Iv0j72h+
	RQHzmrp/6eVecIlyRbboQfoq6oBZfqb6DLAA3JnBqCw==
X-Gm-Gg: AY/fxX5HftwfoWTjbyb3RwrMQgr8eTI0GnaSKqSzRJqF+/vYURShT5vVknA3QXUB6Ll
	qIlsWsU+4vj5h3soHARYkQJ3lPFiSLsWlnxXr5SKYmYY6jDttb5wi74fvIQ9xs9OUl2/sMdFO38
	H+VFM5PzsdsnJoolwCIpHwIe7XnyIkpeFs6GG25PdjsxTopXAA6Ghiljf7VwFgmkquzUiIVX/gi
	0LGgwwAg+FvhtiUvMDBmPwB/kMywEtjIAgp2cxhdIQKCBT+de3TmqW2fVwMVpGMS2Eu3F0W
X-Google-Smtp-Source: AGHT+IF/IKaol6q06drc0jUZGfDObMCMgUc7sJGF0Pzcwx7Y3zyiL6BNsG9paslEQz3RmfOfMLaSPRZ7OEsv3ldvgtU=
X-Received: by 2002:a05:7022:6194:b0:11d:faef:21c2 with SMTP id
 a92af1059eb24-121722b44b3mr21225084c88.2.1767370755580; Fri, 02 Jan 2026
 08:19:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251231173633.3981832-6-csander@purestorage.com>
 <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
 <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com>
 <CAADnVQKXUUNn=P=2-UECF1X7SR+oqm4xsr-2trpgTy1q+0c5FQ@mail.gmail.com>
 <CADUfDZq5Bf8mVD9o=VHsUqYgqyMJx82_fhy73ZzkvawQi2Ko2g@mail.gmail.com> <CAADnVQJ0Xhmx0ZyTKbWqaiiX7QwghMznzjDL1CNmraXM4d+T7A@mail.gmail.com>
In-Reply-To: <CAADnVQJ0Xhmx0ZyTKbWqaiiX7QwghMznzjDL1CNmraXM4d+T7A@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 2 Jan 2026 11:19:02 -0500
X-Gm-Features: AQt7F2oEXplVk5UGATVc_njCcDbZ0oTjVxxZL8Y_v3dZVS7iVDarJ5ogQAkD16Y
Message-ID: <CADUfDZppy2CQjZ9La=RcBL5XeKY66Eq7Rr1JD6byuip_GPrMEg@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "D. Wythe" <alibuda@linux.alibaba.com>, 
	Dust Li <dust.li@linux.alibaba.com>, sidraya@linux.ibm.com, wenjia@linux.ibm.com, 
	mjambigi@linux.ibm.com, Tony Lu <tonylu@linux.alibaba.com>, guwen@linux.alibaba.com, 
	Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, sched-ext@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 6:10=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 31, 2025 at 4:28=E2=80=AFPM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Wed, Dec 31, 2025 at 10:13=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Dec 31, 2025 at 10:09=E2=80=AFAM Caleb Sander Mateos
> > > <csander@purestorage.com> wrote:
> > > >
> > > > On Wed, Dec 31, 2025 at 10:04=E2=80=AFAM <bot+bpf-ci@kernel.org> wr=
ote:
> > > > >
> > > > > > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod=
.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > > > > index 90c4b1a51de6..5e460b1dbdb6 100644
> > > > > > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > > > > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > > >
> > > > > [ ... ]
> > > > >
> > > > > > @@ -1275,7 +1275,7 @@ bpf_testmod_ops__test_return_ref_kptr(int=
 dummy, struct task_struct *task__ref,
> > > > > >       return NULL;
> > > > > >  }
> > > > > >
> > > > > > -static struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > > > > > +static const struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > > > > >       .test_1 =3D bpf_testmod_test_1,
> > > > > >       .test_2 =3D bpf_testmod_test_2,
> > > > >
> > > > > Is it safe to make __bpf_testmod_ops const here? In bpf_testmod_i=
nit(),
> > > > > this struct is modified at runtime:
> > > > >
> > > > >     tramp =3D (void **)&__bpf_testmod_ops.tramp_1;
> > > > >     while (tramp <=3D (void **)&__bpf_testmod_ops.tramp_40)
> > > > >         *tramp++ =3D bpf_testmod_tramp;
> > > > >
> > > > > Writing to a const-qualified object is undefined behavior and may=
 cause a
> > > > > protection fault when the compiler places this in read-only memor=
y. Would
> > > > > the module fail to load on systems where .rodata is actually read=
-only?
> > > >
> > > > Yup, that's indeed the bug caught by KASAN. Missed this mutation at
> > > > init time, I'll leave __bpf_testmod_ops as mutable.
> > >
> > > No. You're missing the point. The whole patch set is no go.
> > > The pointer to cfi stub can be updated just as well.
> >
> > Do you mean the BPF core code would modify the struct pointed to by
> > cfi_stubs? Or some BPF struct_ops implementation (like this one in
> > bpf_testmod.c) would modify it? If you're talking about the BPF core
> > code, could you point out where this happens? I couldn't find it when
> > looking through the handful of uses of cfi_stubs (see patch 1/5). Or
> > are you talking about some hypothetical future code that would write
> > through the cfi_stubs pointer? If you're talking about a struct_ops
> > implementation, I certainly agree it could modify the struct pointed
> > to by cfi_stubs (before calling register_bpf_struct_ops()). But then
> > the struct_ops implementation doesn't have to declare the global
> > variable as const. A non-const pointer is allowed anywhere a const
> > pointer is expected.
>
> You're saying that void const * cfi_stubs; pointing to non-const
> __bpf_testmod_ops is somehow ok? No. This right into undefined behavior.
> Not going to allow that.

How is that undefined behavior? Wouldn't the following be UB by the
same reasoning?

void takes_const(const int *x);

void f(void)
{
        int not_const =3D 123;
        takes_const(&not_const);
}

A const-qualified pointer type just prevents that pointer from being
used to mutate the memory it points to. It doesn't guarantee that the
memory it points to is marked readonly.
