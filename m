Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039879;
	b=NBIpOVy/MJ2XPGps+JJeYLmVp2bNi+HivNhLOMTTbOmgZ7iLKW36QrhhlXCwn8W1/4pl
	 g8255RwGP9HLqXN667jFU6uVvxHu+jGggdfhrshm4fB4pTCOGhckE5O+Ltrr1M2ckaYU1
	 Gat9P5RHUhh71RSXevTjeCzb5uOPFPK5Zvs662HwLmvnVZ29XP2h/wzWmP3Izquo1X6Wh
	 os2PwtewuPg536j3UVCstjybWQkPXZ+ON2Ob+i9a61vFKNyzMcJRi+edGfZp8Gs4GRfnf
	 GjRXtbZYhQF7fDmup/8xIiRTl8/p647gFM4nnIjYEdMA/K1fvjUSFSHtQ76VvMptBrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=jJThRBoWZt30Dm2LuGj7j4AVYG9Ualp0wcqGHfqo2WI=;
	b=robOebnRXhp8vw0RCEI3Kb7jGIKskOJydvpCeHrpUc2sciHqt8/k6Y0qcu+dMnefqaAW
	 819XohEULOuTU4n8Ghr5zs+1AYXskHOStc4MvOSkozk+0JdY43YCxOJh6wh2v/+GJrD0X
	 meBIrqB61fZpXoIqIbLFQBpto0L2sMb1PxXsugx5pakjhPju8tFyUsInfWyaPnrTz4fAQ
	 bMwJY0z3EOaWCpQLGhomDl+Sw2BYUUx84la4LMD3jlvm9LyPu1PMGmXHTedc7j6fp+fx+
	 KJ0Vof76nrmrmiWuhV4zgzZMaFohk+vjOlU324P+uIAMeZrxP+2kJGvLI4qZlJG2rAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EB06n9uh;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE70D60A2601
	for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 22:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE70D60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EB06n9uh
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a070781f63so866871b3a.1
        for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 14:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795039878; x=1795644678; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jJThRBoWZt30Dm2LuGj7j4AVYG9Ualp0wcqGHfqo2WI=;
        b=EB06n9uhPSv9Le+YS7KxZMNdjgV+XAv2hxU9PzBDeBrRZLXHZRgwu1XcA/kKLqTkIh
         6znEjbSGHP+/QulV56lC7U9fwG7vbCSfRRI0IQ+4Dd+ikNa6WvZMTAEu8UZyaE74SfEs
         JHHh6tl+qznaujcg+Zcx4hJgWj24iiTlJVaHjPcRJT/mvUFBGYvBBwD5wtOzVnA/bqX5
         4cxmHJzVoS6b/rHRNpUoyvRlltSZf95bNjiuqW6Ia0vnezviAFLbE9GzyZlWkVqor/lK
         zScnpKP/+W2Sfkw/Gr4zOR275lb2JQRgEUkSpY9z+7CHb0SCSL0zGgXhxkLd3hxCJPUX
         tomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795039878; x=1795644678;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJThRBoWZt30Dm2LuGj7j4AVYG9Ualp0wcqGHfqo2WI=;
        b=spUILv+/wxN/5oBvQMnPiNpZOCNzyiglwxwJdP8evBNLwhLXU2NDp05hGXMJI1Z6rB
         rlAmlBGVV1hic9sRfsLGcpJ5Fm4LCogyOU+XuGqpbL6644QGaNZ7Yvotlp8bQLLDf8us
         3ddz/Ahe7IN1ESo2ILkVa6cfq4z5klV3GXXuFyWMDoKjB9Dqlnm2Np7u5CNn7MlpTypY
         lPRancIxu8J+kwrY1CClazVKymgjuLYaUDY7iqIv8jDGEmVU82V0VCSyPlIlouWHLVSw
         8MrEeSb10bO7kV8jfKv6KdSjWiTXbE3fl9q8i72+y8JwL2SABaJJr8lBk7BfIEKba2Kr
         J3lQ==
X-Forwarded-Encrypted: i=1; AL+hErGrCy41DcKnytyg4T9luw+UW46egJiH20FKDyhovtaUjBpgo3I61ZGVnNdJy5IkM7H651mQWENLm5w=@lists.linux.dev
X-Gm-Message-State: APuU4Z9wU7+r/fJ3K+wK7shJqkO8FYGHbNvOI8j2UICwD7WS+8nIAhrN
	QQmsXo5b20PPlwSmE3FKri5gcK3deZ8uPfBPUN41YU3/g50tNz08LBXE
X-Gm-Gg: AYBFou015NTGLMwIJ3uYuFCun8XqIZ3M9kLORk0eTiOF3bVm5cfNYgja4s1eh8ipryh
	yVIMllmJPZQzDE/mqtc40pT2K5pzY2lbGWafxy4B5cjaWlqUndS7ZOK7lMFXHW13nsuRzT0KzX7
	02yRQWL1t+PvO+80Nl3cmFHmqLTaSoG7nQ2TcRJ6AOnK0NVPQFW9T0vYv3u5UdlHp1AzMqaN41M
	nYCnK2EiDGqM51HdahtyUG6PTAvHfghQGQfchf70gMe4rFucs4w7wBIWzBvH6Z1RLJFqJtYNYuW
	RzXyEmaHEFQnCNoKA+x6c1biIp8L3Em8MrgttSVZ2omG5JIOX/6XDV4iU77jNURQ9eoyitaE0sH
	FUnwUtzkWJZnswS82EqEiKrtzla6Izxi3kR2x2vrLKI1hQ0neWpMKLa1z7P+b3oT0c+pvuzMR8C
	O4R3q43YgF+ohQ2NVRWl0J3xlZpZ60ngYN5igrQIFjfZqVMktZ3MhG36bAVWE74BA+jHg1DTYSQ
	Y4YxT0x02zjEJrodzstQTdvfzR8XSg7SqkewiYQssjr1LRxyLP1qbs5o4/1I8CcwQe4CimxOon8
	RNJKJUkrqSHw157gbL3Z3+h9tnWxMcuznLRmowSAPg7tgHhXUuosjwu0
X-Received: by 2002:a05:6a00:94c4:b0:878:3705:2515 with SMTP id d2e1a72fcca58-8c5d42f1a26mr3437425b3a.53.1795039877929;
        Wed, 18 Nov 2026 14:11:17 -0800 (PST)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cac8fe3csm1791387b3a.21.2026.11.18.14.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 14:11:17 -0800 (PST)
Message-ID: <d2f665211f7c294bf7a8f3897b247863090e4e19.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/4] libbpf: Support kernel-side kfunc
 flavors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu
 <song@kernel.org>,  Tejun Heo <tj@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Date: Wed, 18 Nov 2026 15:11:15 -0700
In-Reply-To: <6a1b6f05-448e-461c-bd79-0acd67fb7edc@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
	 <df72a9ab1ebcebff573485a808e45cd493665e75.camel@gmail.com>
	 <6a1b6f05-448e-461c-bd79-0acd67fb7edc@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-18 at 14:37 -0700, Ihor Solodrai wrote:
> On 2026-11-18 2:12 p.m., Eduard Zingerman wrote:
> > On Tue, 2026-11-17 at 12:21 -0700, Ihor Solodrai wrote:
> > > An incompatible change to a kfunc's prototype, such as an added
> > > parameter, breaks BPF programs built against the old one. libbpf
> > > ignores the ___<flavor> suffix of a kfunc declared in a BPF program,
> > > but makes an exact name look up on the kernel side, so the kernel
> > > can't keep the old prototype available under the kfunc's name.
> > >=20
> > > sched_ext ran into this. cded46d97159 ("sched_ext: Make
> > > scx_bpf_dsq_insert*() return bool") kept the old prototype as
> > > scx_bpf_dsq_insert___compat, expecting libbpf to bind old binaries to
> > > it, and broke them. 2dbbdeda77a6 ("sched_ext: Fix scx_bpf_dsq_insert(=
)
> > > backward binary compatibility") reversed the naming. A ___v2 kfunc
> > > declared as vmlinux.h spells it doesn't bind: 56bbc91219c0
> > > ("sched_ext: Fix scx_bpf_dsq_move_to_local___v2 compat detection")
> > > fixed a compat macro that silently dropped enq_flags because of this.
> >=20
> > Please prefer examples to prose in cover letters.
>=20
> The sched_ext story above narrates the commit history to illustrate
> the motivation for the feature.=C2=A0 Would you like to see code samples
> from there, or are you suggesting to drop the paragraph?
>=20
> The documentation patch includes code examples of the new binding
> rules, I didn't want to duplicate that in the cover.

There are two ways to act while reading the above paragraph:
- follow the referenced commits and reconstruct the issue (time consuming).
- ignore it (not helpful).

> > Also, please de-Claude the included prose.
>=20
> Please be more specific. Which "included prose"?

  sched_ext ran into this. cded46d97159 ... kept the old prototype as
  scx_bpf_dsq_insert___compat, expecting libbpf to bind old binaries to
  it, and broke them. 2dbbdeda77a6 ... reversed the naming. A ___v2
  kfunc declared as vmlinux.h spells it doesn't bind: 56bbc91219c0 ...
  fixed a compat macro that silently dropped enq_flags because of this.

This screams Claude from 1000 miles distance.
Maybe I have reading comprehension issues, but in order to decipher it
one has to:
- "kept old prototype" - figure out that two functions were declared
  "scx_bpf_dsq_insert" and "scx_bpf_dsq_insert___compat"
- "bind old binaries to it and broke them" - figure out that existing
  bpf programs referred to "scx_bpf_dsq_insert" and libbpf mechanics
  didn't work as expected.
- "reversed the naming" - like a new function became ___compat or what
  happened?
- "A ___v2 kfunc declared as vmlinux.h spells it ..."
  Now there is a ___v2 in the picture.
- "... doesn't bind" - figure out that this refers to libbpf mechanics.
- "fixed a compat macro that silently dropped enq_flags because of this."
  Incomprehensible w/o looking in the code.

> >=20
> > > With this series, if the kernel's bpf_foo kfunc is missing or its
> > > prototype is incompatible with the declaration, libbpf binds the
> > > bpf_foo___<flavor> that has a compatible prototype. So a changed kfun=
c
> > > can keep its name, and the old prototype stays available as foo___v1.
> > >=20
> > > resolve_btfids fails the build if two of bpf_foo and its flavors have
> > > compatible prototypes, unless both have foo's exact prototype
> > > (aliases), so the fallback finds at most one match.=C2=A0 This ensure=
s at
> >=20
> > Why is an exception for kfuncs with identical prototypes necessary?
>=20
> For example, when the void scx_bpf_dsq_insert() is deprecated, the
> kernel side can do this:
>=20
> =C2=A0=C2=A0 Today:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void scx_bpf_dsq_=
insert(...)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bool scx_bpf_dsq_insert___v2(...)
>=20
> =C2=A0=C2=A0 Later:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool scx_bpf_dsq_=
insert(...)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bool scx_bpf_dsq_insert___v2(...)=C2=A0 /* calls=20
> scx_bpf_dsq_insert() */
>=20
> Existing schedulers declare scx_bpf_dsq_insert___v2___compat.
>=20
> libbpf strips the last suffix, so the bpf progs still call
> scx_bpf_dsq_insert___v2(). The wrapper keeps them working during the
> transition, including with older libbpf.
>=20
> The exception allows to do this.
> Otherwise we break the ___v2___compat trick.

Thank you.

> >=20
> > > kernel / module build time that no ambigous kfunc flavors exist.
> > > Documentation/bpf/kfuncs.rst describes the rules.
> > >=20
> > > Compatibility is determined by bpf_core_types_are_compat(), the check
> > > libbpf already applies to kfuncs. Of the 70 same-name kfunc prototype
> > > changes between v6.6 and bpf-next, it finds 8 incompatible (arity,
> > > return kind, callback prototype). The other 62 (const, typedefs,
> > > parameter names, integer widths, pointee struct names, annotation
> > > suffixes) were made in place without breaking old callers.
> >=20
> > Do you mean that without this series programs referring old prototypes
> > are broken?
>=20
> Yes, if the kernel changed the prototype in place and the BPF program
> still expects the old one. For example, 8fe4dc4f6456 ("bpf: change
> prototype of bpf_session_{cookie,is_return}") added a ctx argument to
> bpf_session_is_return() in v7.0. libbpf can't resolve an object's old
> no-argument declaration on that kernel.
>=20
> This series alone doesn't fix this, but with it the kernel *can*
> provide bpf_session_is_return___v1(void) for the old callers.

Ok, this clarifies things, thank you.
