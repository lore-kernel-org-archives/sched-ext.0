Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039072;
	b=fv7xR5EEh7MUPF+yRqwfVzSDtgfgwB8bzjIxJvhdPJDR0zvD+goCDmUQqs9gC7CHiuJz
	 1R+q5pvzQfSkvRr7SvQjiqgepHkJNTuYToLuk72+wVyS+WsvQLkwI3TBUhZcrbGDU9xkB
	 bZgYo7WMrhYQMT8BolYXIJdJ0OUYOusy5OiPMoCsGz5whIEVpbhBIyLl1QALmBNycrHTF
	 5gDoicGu6ZBSWkxYIwmLjj9TGzsa1aYPqEUWPLaZi6V6OLxLEK++Vcl1blymzgNp5Mx7u
	 Di+V/Aw2k3IxJ90Ji1zzw8vbK3qUzA1PsCwA6MJHGhlK7Q/2G1G58qmAilNr/zA4fNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=/vgfXNH0IHzSBw/JekYvCw/wkmdl1JVA/UJoPFTrVO8=;
	b=aPBL7YbBwfNiRZxoC9RP432kl8EvPFPZRBLgpE+PRptjc0KjWl5wxbIoWcEIl5rQRiKo
	 91aLyz7psRNLdJ+8cABv8Ce1xr4hlp+LVODTliqmnhxETarJWxSAsqBkCcYXvXiTXyv+0
	 A9Ub/cmynqPf31tXbyPH7+GZnZjWjIpt+p4ZGEwYWVJGFqI7WzzKXj1iIlo8KwFHOsdlL
	 dcAxwmrJD80kYynLwAkuzOHaAzWIkVguCV1PXktamWUQ8psbkXb9jxa0uHY1FLRMtgMLZ
	 achOVir9BJ2oU8WQ7bcRL20rjeVKSC306JE/8VZRsmX3d1rBVJohR/YSnGITpBb4W0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QTu1DM+A;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581A606A33A
	for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 21:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8581A606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QTu1DM+A
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9d7791b00so16541115ad.0
        for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 13:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795039072; x=1795643872; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/vgfXNH0IHzSBw/JekYvCw/wkmdl1JVA/UJoPFTrVO8=;
        b=QTu1DM+Az9c79UUUMuNbqvKL/Rrbmh/ddxVqkh1JOqoXBec4eL6H4kHjq8TVt3w/r9
         FzvumFM8E3YBGMBouLSlzkx4lD3Awrzdy5Oesiu8yiR7GjTJXnyqYjc5XjiWe2L5z+3T
         h4DD0zlGEdCHxk8g+zGqZo2mmmFkg7lDmwOO4a/xKdHMxDRD2MsclVbZoNQmt8VWUyOp
         zNJr707Ke7n2V68frNnIU3lGMOmrlgNZEBxCn2wcIUHaDxQh38D0vSsKJ10AFykYFdBf
         oUGk0wtvyy7hlpubY+mP0QOBZhavTz07OcPy/cTd97qfiv9KUccCa6hcNPDg4XDxQqcF
         Dx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795039072; x=1795643872;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vgfXNH0IHzSBw/JekYvCw/wkmdl1JVA/UJoPFTrVO8=;
        b=TmxR6CutDR+9Wz2UHRr4OMXDquFbdPOYtGtOzSN7M35Fs5bakFgTnloElaeiANsEc0
         mElQtHiLcrtzFjx4eWS3h8dWNJto3EsZY/e81eMAtEkjbzdOk+7VpbPEWWU7WpZSrI1q
         lOZ0MjfqsM5/bi4uAPWcnXIm7FjQ5vpdQA9UJ+YHFL6vqcTGOaZ8XFSOGRwSEzy8lL2f
         6mWSpX/hKvClC/PbdPeBxu0X2ec3FIRCkIFALULDsO/3aVfgEu3C73liBP5XNy6nFY1f
         IrWTSYXjRtL7bSrcYu7EEpqBbc5sBYThSCienRcc0CuCXkKhvLmnRiKICEsfpWXQp7d7
         KxXg==
X-Forwarded-Encrypted: i=1; AL+hErGDNq7z7auzAnZQZrV3cgnrmtVI/envu7JQm2smvf4WH55qKZYyIVime7m6brtnhvhvr/xrplAX09c=@lists.linux.dev
X-Gm-Message-State: APuU4Z9UeM0+77XRekcKkRXLmXFOWbz4vJ1MQedyzJ+zNvIHSAFvGhE+
	M0QhiKYpeXQaP5CKhZ2lRHASSLo5F7PvmuTJr6D6aQDnhaPAei/UNYvS
X-Gm-Gg: AZFdTZf4n3Jed9xfk2hRmJkrWWNUhZ7EKWVr4+ypipB4mlTxNH4SGcj4OzDms+i5qyR
	YQrrmKzYyK9bGXI9c6JNnnBtxudMpKVhhsrV268ASoPmqQVSCDnWWCniPoh/5GYdlr7NQFa/6ZO
	DGGzSham3TA872HFWY59r3wWbGxb5uww+2AWifL2NohGZAWkIsQEPUIH1pojbQYbXkyuraw9s2P
	vJaJ0XtWjofmHb/X2XU2TYQhUxnq5dsAphMOLbM9pn+rRfDvjLR2unvb1Jna4uzgbSopO5U2o0f
	aSr2moAGcVPTgGQH9vjPkr3mTCym/aWBvkDw4Vkxf7yJ7WIcGRohgZlfizM14k3paUeWZbGKEKz
	IUWyf+dZnQB2fUFvAYZex6mFcAIPLySxXlYDEzuRDpPGiJwMeXpgdI2VC1mRkOSOM9hUYujIupB
	p6nxXl+AddCtsgULojfkC9JdrdspE9fG/EG8JmXo8BtkffJDST/R2/2UY6feuVBTzVO+su15Htc
	B7byiGO0QmQsuQVPEoAggZfsECPWAbhVEul2L4zlf+nMYe6JLsLVzRoo7IIieMUTIFJzRtgDlm1
	RBZkXV/MZlWiGVHtDXU95mvRYMGq4Og7FM1rchv4KyvweXO5ZL/eNI/4
X-Received: by 2002:a17:902:c945:b0:2ed:56ee:af84 with SMTP id d9443c01a7336-2eff75693c0mr37754565ad.62.1795039071872;
        Wed, 18 Nov 2026 13:57:51 -0800 (PST)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff622c0a5sm20012695ad.50.2026.11.18.13.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:57:51 -0800 (PST)
Message-ID: <cfb47f547888b0f70200c0cd5eecff2f20592f29.camel@gmail.com>
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
Date: Wed, 18 Nov 2026 14:57:49 -0700
In-Reply-To: <dfba2231-4cf4-4bb2-90b9-6261b7567895@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
	 <df72a9ab1ebcebff573485a808e45cd493665e75.camel@gmail.com>
	 <08d6be6e9e0dcf6570ecd83671e9dbe63a417607.camel@gmail.com>
	 <dfba2231-4cf4-4bb2-90b9-6261b7567895@linux.dev>
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

On Wed, 2026-11-18 at 14:48 -0700, Ihor Solodrai wrote:
> On 2026-11-18 2:42 p.m., Eduard Zingerman wrote:
> > On Wed, 2026-11-18 at 14:12 -0700, Eduard Zingerman wrote:
> > > On Tue, 2026-11-17 at 12:21 -0700, Ihor Solodrai wrote:
> >=20
> > ...
> >=20
> > > > resolve_btfids fails the build if two of bpf_foo and its flavors ha=
ve
> > > > compatible prototypes, unless both have foo's exact prototype
> > > > (aliases), so the fallback finds at most one match.=C2=A0 This ensu=
res at
> > >=20
> > > Why is an exception for kfuncs with identical prototypes necessary?
> >=20
> > Ok, my helpful assistant points out the following use case:
> >=20
> > On kernel side:
> >=20
> > =C2=A0=C2=A0 __bpf_kfunc bool foo(struct task_struct *p, u64 flags);
> > =C2=A0=C2=A0 __bpf_kfunc bool foo___v2(struct task_struct *p, u64 flags=
);
> >=20
> >=20
> > On BPF side:
> >=20
> >=20
> > =C2=A0=C2=A0 extern bool foo(struct task_struct *p, u64 flags) __ksym;
> > =C2=A0=C2=A0 extern bool foo___v2___compat(struct task_struct *p, u64 f=
lags) __ksym;
> >=20
> > =C2=A0=C2=A0 /* Resolves to the kernel's foo(). */
> > =C2=A0=C2=A0 foo(p, 0);
> >=20
> > =C2=A0=C2=A0 /* libbpf strips ___compat; resolves to the kernel's foo__=
_v2().
> > =C2=A0=C2=A0=C2=A0 * workaround used before this series.
> > =C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0 foo___v2___compat(p, 0);
> >=20
> > New mechanics adds an obligation on the kernel side to maintain that
> > foo and foo___v2___compat are semantically identical, despite being
> > physically different functions. (Does it?)
>=20
> Yes. I just replied with exactly same example (it's used in sched-ext).
>=20
> >=20
> > Would it be possible to use some kind of annotation, e.g.:
> > - __alias(foo___v2) (an ELF symbol alias), or
> > - __kfunc_alias(foo___v2)
> > =C2=A0=C2=A0 (resolving to some sort of btf_decl_tag for resolve_btfids=
 to act upon).
> > And avoid allowing functions with compatible prototypes w/o exceptions.
> >=20
> > ?
>=20
> My intuition is that it's possible, but it'd be more complicated.
> The question is why?

Is it a requirement now for foo() and foo___v2___compat()
to be semantically identical? If it is, the alias mechanics forgoes
this requirement.

> libbpf side might become marginally simpler, but we'd add complexity
> on the kernel side, no?

On kernel side or on resolve_btfids side?
