Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F718FDBE
	for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768868675; cv=none; b=Hk0il1gyhHWvLrM20DvKPx/dB3DygYiX7ReQSShZGj/FUMXrNGyWHsljvxYeFi0iP3oQ6BrRYwRYZ5kEzrJCtIorjksrB9VP4UCXr5ip8NjRbg3gH21ulx3rkxZFB413zToNVW+gAcOUefQOI2Q3uNm3R01glxPP6OLwIncx98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768868675; c=relaxed/simple;
	bh=w2H1YPVYtudUWltYXZ41qh5f0rKjF7tgzBkZiRvPNNw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cJ9tkoToUKL+bAvd8g4YWOYxDYI1rcmX13jIDh1ywxj21O3MLJCt93oWQRZu1hGzr+KVRwBdG8bkOGBVImzAMmCK5r/xFKBRI8QSRMZxx1Zp5l7NMgqtJRD9tQOPc2IWgrjKRFUiCTtThC6M9hJTWdZOe+zSNBDnkF1IlfftDt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJ3bqLgs; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ3bqLgs"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b6bfb0004aso6633689eec.0
        for <sched-ext@lists.linux.dev>; Mon, 19 Jan 2026 16:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768868673; x=1769473473; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ugODr4tJzWtUG5ArCmSAiLBMI2Kv5mSCkYy+oirIgik=;
        b=CJ3bqLgsh7n9yIXnhk9+7cJXKR26A7ZjIYElpvTMXJS9VlZm7ckgA6OkAu/LKs+NVx
         26OiLLLdi3CXt1ho6yHNR+53kYG0E6vFun9tEBvuDAnDlzr17+4uppsDHPUtHv8B0ATH
         7QA551PGFS+kfMO9eogceIP+WxoA5ENrdK9CAohfBiV249zxo/ctYasF83FDIXaXVXBY
         NQRWyYKjy88R7W6TVirKheVQFGsWa0OINjyDCwDYnhC9rT5BsLGnLyGWVDlXqR8W85ka
         nrjk7C9u7Mgs/bltY9xa+mYh5StIcm6/Gmxki6/supcPRM5Tts4AY3vyj/PkYsP5dad2
         AFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768868673; x=1769473473;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugODr4tJzWtUG5ArCmSAiLBMI2Kv5mSCkYy+oirIgik=;
        b=axOw40uS/MVRAKhrjlh31sf2mUtADLj+egCcZ4mqClWTotZBXvVE1VDi74zcqjvLyn
         h0K81iJm/o9P1Szm0zECmhzY/DqbJuwrJGL89JzY7Sy3n2idRUu6sXDA8HNFOi5lJ5r2
         SXJ85F4MdEhR6LCE4K4F8BHqs+V/qprVMEW2ltBSGILIKQ4RKrkMq+PsSzJoEKAauZe5
         +eFWiPHT1qpWslYhEOXHNB0+oRLOhbQKC2x7Wvoeh8JeZO7WItaCC8Ek0uLDSim1jYvV
         y/vSyOAlhSMj6NtM7CwljwnZB2Hjn4uSyM+rjB5maRQYWChRwxixHrPl2FT5u5fe1mb8
         eTHA==
X-Forwarded-Encrypted: i=1; AJvYcCXLP2/LsE1jaLzBxK7hHdt8PxOaAGNm/DBWttAcPfvM5xnloenN1+4DWavq0vJ7o7twSNkXHfL+dIs=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzsfl5wGVOaqEgevBwnpPn/4wHXEMCepcR3c15fWALxASdTOyg3
	0ZqNvBqoo8bkGawIVO1ureQ6dbedMFcFKjuY/bVYrGaCeg4jwAGb12go
X-Gm-Gg: AZuq6aLJ7iz+zEG+OFvVU4D6JA44Zepqsg4WTx1lYJjOAcBWgrzMnHcCcCrwjT6BFgW
	wTlmf5TH3OHtQ/tJQI9PLFbXu97CMaEH+9CnMzUOgzsYgd9AS/eNky81dVkY6we3ahNRWoXlOkh
	qEzmO6cRTSsVuxnrLyKy7K0ZHC6B4m8Rld8BTZTRyL0Hojy1wrwDaN75aE4jTfc3Cj0EJh98SHz
	XDEA/QxteyPsg7vCJlwljNDdAxzoYqAeHqbboSrpBr1IfArFSq16b9SMmaqhfuy9cantHXTE95m
	j09XyEcDMSdYBq4p3veTZFtzTo8DmsBba+fvc6LpZsMXcPLEveckKDXA6OGOqVdzeIAeO+BBQ9Q
	Szk2UPScWT4GSPFbpM5B/w/+HJLk0sVnEFTqzB/Wd8UHRlk3OVHBEiVHhX8Ykw0pEWJt4pl3GsS
	DW20PzRoFra7ytkQ2+rXDmMjfB0tVilhqwl2sjYuiNRHBr6LZXGqGH/UabnOE/CuUWwpR3zf6zH
	nh8
X-Received: by 2002:a05:7300:a507:b0:2ae:5664:8110 with SMTP id 5a478bee46e88-2b6b414aba3mr7857799eec.38.1768868673097;
        Mon, 19 Jan 2026 16:24:33 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c122bsm14877286eec.5.2026.01.19.16.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 16:24:32 -0800 (PST)
Message-ID: <c3a04c5063cc9b68f9719c27ab1acb01b199ca3b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 05/13] resolve_btfids: Support for
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Mykyta Yatsenko <yatsenko@meta.com>,  Tejun Heo
 <tj@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires
	 <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, Amery Hung	
 <ameryhung@gmail.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 16:24:30 -0800
In-Reply-To: <aff3f58f-aa81-44a3-ae5f-078befeceb39@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-6-ihor.solodrai@linux.dev>
	 <CAEf4BzbG=GMh0-1tT_2gdMtc-ZuV3X7hgoJZpt1RLCYgPMM3oQ@mail.gmail.com>
	 <aff3f58f-aa81-44a3-ae5f-078befeceb39@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-01-16 at 22:36 -0800, Ihor Solodrai wrote:

[...]

> > > +static int collect_decl_tags(struct btf2btf_context *ctx)
> > > +{
> > > +       const u32 type_cnt =3D btf__type_cnt(ctx->btf);
> > > +       struct btf *btf =3D ctx->btf;
> > > +       const struct btf_type *t;
> > > +       u32 *tags, *tmp;
> > > +       u32 nr_tags =3D 0;
> > > +
> > > +       tags =3D malloc(type_cnt * sizeof(u32));
> >=20
> > waste of memory, really, see below
> >=20
> > > +       if (!tags)
> > > +               return -ENOMEM;
> > > +
> > > +       for (u32 id =3D 1; id < type_cnt; id++) {
> > > +               t =3D btf__type_by_id(btf, id);
> > > +               if (!btf_is_decl_tag(t))
> > > +                       continue;
> > > +               tags[nr_tags++] =3D id;
> > > +       }
> > > +
> > > +       if (nr_tags =3D=3D 0) {
> > > +               ctx->decl_tags =3D NULL;
> > > +               free(tags);
> > > +               return 0;
> > > +       }
> > > +
> > > +       tmp =3D realloc(tags, nr_tags * sizeof(u32));
> > > +       if (!tmp) {
> > > +               free(tags);
> > > +               return -ENOMEM;
> > > +       }
> >=20
> > This is an interesting realloc() usage pattern, it's quite
> > unconventional to preallocate too much memory, and then shrink (in C
> > world)
> >=20
> > check libbpf's libbpf_add_mem(), that's a generic "primitive" inside
> > the libbpf. Do not reuse it as is, but it should give you an idea of a
> > common pattern: you start with NULL (empty data), when you need to add
> > a new element, you calculate a new array size which normally would be
> > some minimal value (to avoid going through 1 -> 2 -> 4 -> 8, many
> > small and wasteful steps; normally we just jump straight to 16 or so)
> > or some factor of previous size (doesn't have to be 2x,
> > libbpf_add_mem() expands by 25%, for instance).
> >=20
> > This is a super common approach in C. Please utilize it here as well.
>=20
> Hi Andrii, thanks for taking a quick look.
>=20
> I am aware of the typical size doubling (or whatever the multiplier
> is) pattern for growing arrays. Amortized cost and all that.
>=20
> I don't know if this pre-alloc + shrink is common, but I did use it in
> pahole before [1], for example.
>=20
> The chain of thought that makes me like it is:
>   * if we knew the array size beforehand, we'd simply pre-allocate it
>   * here we don't, but we do know an upper limit (and it's not crazy)
>   * if we pre-allocate to upper limit, we can use the array without
>     worrying about the bounds checks and growing on every use
>   * if we care (we might not), we can shrink to the actual size
>=20
> The dynamic array approach is certainly more generic, and helpers can
> be written to make it easy. But in cases like this - collect something
> once and then use - over-pre-allocating makes more sense to me.
>=20
> Re waste we are talking <1Mb (~100k types * 4), so it's whatever.
>=20
> In any case it's not super important, so I don't mind changing this if
> you insist. Being conventional has it's benefits too.
>=20
> [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encod=
er.c?h=3Dv1.31#n2182

In my test kernel there are ~70K types and ~300 decl tags.
Allocating an array of 70K elements to store 300 seem to be quite an overki=
ll.
I'd move to what Andrii suggests just to reduce the surprise factor for the=
 reader.

[...]
