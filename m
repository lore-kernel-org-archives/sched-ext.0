Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8552FA0DB
	for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767204842; cv=none; b=PY1W3d4K/K81L3XDasc4I4/lJXSYEC8mUXqQr4ivy1yUWASxdhVAa58KcGKCK59WiOddUa9pQUGTPRGNUeD3dtArVSSscsmsOqSUQzoPPmhJsANa8vXuU0Yua/5NgbuydAXitBRqW+olyd8mm77JJ5skrntun2Lqc9l55e0M0HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767204842; c=relaxed/simple;
	bh=l0LRvl1kqcmBpJ+oiXL+hUtJD8MnLQw7yRd+cy/68MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzIzLYWgVIZVNNJkn/jfaWHeel5ooymMhfxobosUClQCIxvoMmbeIoi3NxrhubIwNd1sRWE5wgIR6Uo8TUVWGo25+l3PcuVN10F36qfmZ2tvuK9O0iyjNBnD6EVkVhp7UdQg/FQSyblA/n4wa5jupca6f6qRgy0cJymjDe7d16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK8Mv684; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK8Mv684"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso5461411f8f.2
        for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 10:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767204839; x=1767809639; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80wuQlyFH/FTtp28IkHfYhaeWqE7rS7z6vp3Trh+jc4=;
        b=GK8Mv684V4rlzt0A8YPEc//LttM5439+AddJ7nYor33hn42pOMk3IQ0XEDHq4+QAJ1
         pkZ4iKK8nKhx+wf8jrIxuAhmF6F8on82xBLZRBq4Mu5qad9/gldMRHmTiwvMe34wdPwH
         Aioo+Kskk4KOsTLi0/k4wZPOxPIN9PjQtdJlT8ZhXPPvo+T0L5Dsog2QZy8JjJvbPjlv
         4aI5pstZp9rxy1z7wK+SddeNTjWl3QWcA6pQhetUtsk7kgZuN3ny8ZWBT/u38VHzKaYf
         kK3j4wYAfdDiwiJ/WMRzTHHgyXa+aInv8y6b7bbtbJYxRxvfRKmEb/syB5Gzt5euZuK0
         gNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767204839; x=1767809639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=80wuQlyFH/FTtp28IkHfYhaeWqE7rS7z6vp3Trh+jc4=;
        b=KptJMIi3kOa6R0Fb94pvIoen2WKVeCaUM/J/wmmaplTuwiTiQqNdgGfjyl+TzDei2r
         t7aF3rslXngLHcWdl76dm0bkqa5vZ8gU7JyJkS/e8/GpC+QwhnWz61sv8E9w5MYljWxr
         lAk/UXP0Za4ZjxQlpPOZ6Bu0kDgG2Op+j2DFsSKvUTDA6F4JcMJnJ7n2KjQfcK7HIeMw
         QjpBlqi8wpigKSVTldPV8bdfUmdcUcyYjsxAJzxUSvqQV6Rqxlilr8WUwqjLZFHnChej
         AYwWf6JG5AuGMOQ9j1WCXjlIsl5p7f18bDWtRAR8q2d4sFySfvL6QKLAMZjAar7qog5i
         34PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsW4giV7jPFvwGMZNPnw0JDGRYI0kXqf1o4PBeC1zq+NmuKlpp8YRP6avedlEylVWxIt0XAa4Q0QQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyZPlvdIK4MWP/Mlbeb/HndjAIszmw8fD7m6nVKB6uquprYLZOF
	ZqHRiDidqXZUAQrGl6trFHdTv7bkkCv0y3YuUeLfLjECGyJQAxTmxQamsV/1pEnmIcKdi9W3wIR
	XM+KHxj0qBJ2L6Aia09ltK2rVnrq5cM8=
X-Gm-Gg: AY/fxX4G6uPoUMTiP3qxCXE2VpgfhapEU7BTOuiR3r+UO1JAVlqFIjH+EAsZThcNFN4
	0LYiVQeHuuIxelOxVEeM2ca+gBGc65TVB5RXXJF//b6myjwDqwtWNw67t6imprc4CKJpCX7brhm
	EA8/BCMgYl+AK7ZlOchU7r7+fZzbwIPlJse61/UHmPXrBWQKCMEGXDQOSqwbcw9DazDATmQ2x8r
	91uY71LwrefLFWFEaSbZO0NATrQySBCqqg8WA1YK6xVkyomjPLtmGXRp26+Ij1ag6cF0lulOBTa
	LnafcdEGfeXBxPTD5i2NJNML/f6h
X-Google-Smtp-Source: AGHT+IE7rn8UGO5FxmIqC7DPe8kHIdUtmNgCuEKioyalqiNjU4yifPpIQxEAl6/RRsYuU+/knbKXbX9dpW9nJ6ADD+Y=
X-Received: by 2002:a05:6000:611:b0:431:3ba:1188 with SMTP id
 ffacd0b85a97d-4324e4c70e5mr40336157f8f.3.1767204838828; Wed, 31 Dec 2025
 10:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251231173633.3981832-6-csander@purestorage.com>
 <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
 <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com>
In-Reply-To: <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 10:13:47 -0800
X-Gm-Features: AQt7F2oHF_qxr3_KPJ-VT5eeYhG4tvvvWKJxtIn11KSC3ODYIcBGmV1QpWm3ri0
Message-ID: <CAADnVQKXUUNn=P=2-UECF1X7SR+oqm4xsr-2trpgTy1q+0c5FQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
To: Caleb Sander Mateos <csander@purestorage.com>
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

On Wed, Dec 31, 2025 at 10:09=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Wed, Dec 31, 2025 at 10:04=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/t=
ools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > index 90c4b1a51de6..5e460b1dbdb6 100644
> > > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> >
> > [ ... ]
> >
> > > @@ -1275,7 +1275,7 @@ bpf_testmod_ops__test_return_ref_kptr(int dummy=
, struct task_struct *task__ref,
> > >       return NULL;
> > >  }
> > >
> > > -static struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > > +static const struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > >       .test_1 =3D bpf_testmod_test_1,
> > >       .test_2 =3D bpf_testmod_test_2,
> >
> > Is it safe to make __bpf_testmod_ops const here? In bpf_testmod_init(),
> > this struct is modified at runtime:
> >
> >     tramp =3D (void **)&__bpf_testmod_ops.tramp_1;
> >     while (tramp <=3D (void **)&__bpf_testmod_ops.tramp_40)
> >         *tramp++ =3D bpf_testmod_tramp;
> >
> > Writing to a const-qualified object is undefined behavior and may cause=
 a
> > protection fault when the compiler places this in read-only memory. Wou=
ld
> > the module fail to load on systems where .rodata is actually read-only?
>
> Yup, that's indeed the bug caught by KASAN. Missed this mutation at
> init time, I'll leave __bpf_testmod_ops as mutable.

No. You're missing the point. The whole patch set is no go.
The pointer to cfi stub can be updated just as well.
