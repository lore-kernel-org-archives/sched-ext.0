Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638512;
	b=bQzFW2cwh1WT6OGLVrn9eDB7XdCwkK/2858QGp9JuWejW6WqsUCZd/OZ3Rg/r3z/yp/C
	 PseLKDNXORlu6QuOIuB+igwjzl7p609FBgEm7S0+M7xTkTjIJlB41wtHMulGI/46TbXQi
	 kEfF016QwD8JLC+3fgu7zI7M7e21E0oXAStgxSPqhzDN7coAdh3BhuHEHteTlQntIpjyR
	 bcML9sdJZfmoNYmYdtC4LgOxJxB71fZoKGza7daqe0QtkZNSnRYzmu6cnTIyJeHz5h7jD
	 MzSgQkt/n2Z5IdQk3oaWhRAIeIgvnSoxmN77s4ZNC5J2AHUUMdLINzqqtRdH30KjkxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=SisNFLl6/hL7hmRZwdbuXo3SaIIXW/p4Ajlw7Gvb2tI=;
	b=rh2X02+S5y8n80ZLuyjQcVv8kLu3bZ0wUl7/IYKoJWjeuB1HivzxZO/wRts4OWGJjN2B
	 vNYbvuT7kq623whcqoq3UKdw3hlvmCkYr3P5Oaj0lYbFK4l/khv9g9JQEGvMDKVD+hIDx
	 jhlhQau+2nMCyiVuyYZX8XNL8flNH85Urj46BHh3ha2+bV9WiKp2v7in01xhPVqsUAeO9
	 oObOt4e/1OBKaaAxcB+YOroH6VWJHNDkML3a66c18pJoO76pGOm9XWCyvsf8UBJsjItnF
	 pSAqyLiqy8p8OFjjl9gEonas+mEYplFTRCda8jDTLXHsO548KNXcjzcfZuFZxKekdYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="D2tB3D/F";
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB7606A31E
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 20:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ECB7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D2tB3D/F
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cddc597d062so3753195a12.3
        for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 12:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795638512; x=1796243312; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SisNFLl6/hL7hmRZwdbuXo3SaIIXW/p4Ajlw7Gvb2tI=;
        b=D2tB3D/F7N2dkvAr4wzbQHiJcdI3qb2nhXF/+Dc7JGMttTSIBMK1g7oRCQ67uRL45X
         /KgHDfnovi1YlVYCWFja96WR2zRgDnKw0cJaDOYSkpsnN/I/+1CE22Y7RKUtc+CJ/Dbk
         DtNF978NRYmU8ikDDNrCS5wpjrmj9Ruulr9RZyX9R884bQvZpuvK8N1gdgSqjjD7eVSI
         3xVVBj5VsSXuC5Pgn7RVSICDxWs0S24S1+/86JyCFo6P5O7Ym3+YqDmYwQ66i+hgskns
         Jd6cyKGRUmqvg/VqNL6GvHFdH4DML/0RKGp+BR43G59cTfb7R7YVspJNec9SJOtme9h9
         UWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638512; x=1796243312;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SisNFLl6/hL7hmRZwdbuXo3SaIIXW/p4Ajlw7Gvb2tI=;
        b=ltGJgwB65sa0XiQT2rUSb00C15HyErLnX+QEbOI4yucIBRtKnv990ibinYZ7fVvoa1
         zPmTUaHQWEFSU5s4USv+ZlBorrmhPKpL496saeJTuhd1dMkfqDABMr+AL0+2MlgdV0xh
         uymQpfrMKv+nDtm88Chl2iPb95TkOXUAPq6+OwjtiGWByBqzknZK1NfWjsHLao82q7KW
         0cCl4eak1TzT+zu7ko8YrRe/+/qdUEtI0NVoT7QQovJTANSQhBL8pHAKD+MSc+IEzFCI
         qflEqSsWlW7xjl+97oEyk1orp3Lxu5LpmRNL0n+P4e9Bt5ZXArr2Exfai28eKvogugbR
         od4Q==
X-Forwarded-Encrypted: i=1; AL+hErG6O3AX7INtYTd0CHwYGsxxnElZ+2ecespRrUF7OSOjd77tBUnNZg1lZR6H+MTME8rHV/niXHTKRRA=@lists.linux.dev
X-Gm-Message-State: APuU4Z81vS2aJ9ChAq0Xng6M8mSbHGS3TWeCepMl9tKQ6laquO9rWT7l
	RvReDrjv/dY0WpQ+cUZ5MOJgU6+W5dWKBq5mEKq3tx1bP2/BYNhr++sG
X-Gm-Gg: AZFdTZfH6VwoXx5mksBjv82SGWfY7Lw2+7Giib4Voo/H01wlfsqRf8iAGVOLvLEdawG
	PaJZhFOEzSr113IGw1+RW0miZZqe9c01srkv7COnLp3r8A4+R52fNJCLrdGW56TCk8LqzujwdJk
	3ofzpXTazaOnTktVkkiDzt23MRUDjOVmE7hbTkpeNhAXMDQXF5+SC7P9c1Ixf7S5s0YHXE+SLPh
	NZGiuTecIEdGYXWbsYxQtUWfH0uoRC5H6COjaB6un7l1uX02TZhvqnPi9z7nl7Gup2BOotxNIJ+
	TSRKJu2BxOGvjdsU4Dvhr7zpFBtBpmTz4SSqDXh3sPEgDpeIlufJQX19efNwGiTna8jCm6eE62O
	F0Pw9AogsGCYFaPXLViOca0fVh1uD/HYGYS1mmRhuSmrUNeU9zUh0taD0MUgBYiJ1CVvsH7Kw3m
	Hz3PfJp4jLSVQTL7H8U5f8z3/OHHsxhemFhlDqP7qseUJ2a73BfDY1QlKIjmH5FOm0OYCsofLZW
	1nr4a4FMpfdYni6GpPv/b0STeizV0D0Dj+VypvPFFdUoD+9qtzWXgsrQHc67XqeSEmLeyZH7Q5k
	JC50IM8QzCUPy4nq6cuqb59xyXuZCxBZFHqhLaDHFP1wdkZiSIq6nwqFgQ==
X-Received: by 2002:a17:90a:e7d0:b0:3b4:1877:8d31 with SMTP id 98e67ed59e1d1-3b41c97b893mr19440149a91.55.1795638511504;
        Wed, 25 Nov 2026 12:28:31 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b7a8c64sm13004232a91.3.2026.11.25.12.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:28:31 -0800 (PST)
Message-ID: <a5ece3a1e01d2557b4b39fc89670df677e4f3b0f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] libbpf: Resolve kfunc variants by
 prototype
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu
 <song@kernel.org>,  Tejun Heo <tj@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Date: Wed, 25 Nov 2026 13:28:29 -0700
In-Reply-To: <20261124224811.16134-4-ihor.solodrai@linux.dev>
References: <20261124224811.16134-1-ihor.solodrai@linux.dev>
	 <20261124224811.16134-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-24 at 15:48 -0700, Ihor Solodrai wrote:
> libbpf resolves a kfunc declaration by exact name, after dropping its
> last ___ suffix, and only then checks the prototype. The name alone
> picks the kernel function, so the kernel can't serve both prototypes of
> a changed kfunc. For example, vmlinux.h declares:
>=20
>   bool scx_bpf_dsq_move_to_local(u64 dsq_id);
>   bool scx_bpf_dsq_move_to_local___v2(u64 dsq_id, u64 enq_flags);
>=20
> libbpf resolves the second to scx_bpf_dsq_move_to_local() and rejects
> its prototype. Keeping the old prototype as ___v1 and giving the new
> one the unsuffixed name would break old declarations the same way.
>=20
> Select a kfunc in two steps instead:
>=20
>   1. Collect the functions in vmlinux and module BTFs with the same
>      essential name as the declaration, as CO-RE does for types. The
>      "bpf_kfunc" decl tag is ignored.
>=20
>   2. Resolve the candidate with a compatible prototype. If there is
>      none, a __weak kfunc stays unresolved. More than one is an error,
>      even for a __weak kfunc.
>=20
> The prototype check is stricter than bpf_core_types_are_compat(). It
> also compares the names of structs, unions and forward declarations,
> ignoring ___ suffixes. Members aren't compared. Typedefs and qualifiers
> are skipped. For example:
>=20
>   typedef struct foo foo_t;
>=20
>   void kfunc(struct foo *arg);
>   void kfunc(struct foo___local *arg);
>   void kfunc(foo_t *arg);
>=20
> are compatible, but not with:
>=20
>   void kfunc(struct bar *arg);
>=20
> So a declaration with an outdated struct name no longer resolves. For
> example, commit 8740156ad33b ("bpf: Require a BPF cpumask for
> bpf_cpumask_populate()") changed:
>=20
>   before: int bpf_cpumask_populate(struct cpumask *, void *, size_t);
>   after:  int bpf_cpumask_populate(struct bpf_cpumask *, void *, size_t);
>=20
> Each declaration now resolves only on a kernel with the same prototype.
> A stacked suffix, as in foo___v2___compat, no longer resolves foo___v2,
> because its essential name is foo___v2. compat.bpf.h now tries foo___v2
> first.
>=20
> Module BTFs are now loaded for every object with kfuncs: 0.5 and 1.4 ms
> for 8 and 32 small modules in a VM. Lookup cost per kfunc:
>=20
>                         before (hit / miss)   after
>   sorted, 23 modules    0.14 / 0.65 us        0.8 us
>   unsorted (v6.18)      0.1 / 0.5 ms          0.7 ms
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

I have no nits besides what Andrii points out.
I'm curious if you tried this one the BPF programs corpus shared by Alexei,
to check how many real world programs are broken by this change.

...

> +static __u16 kfunc_type_kind(const struct btf_type *t)
> +{
> +	if (btf_is_fwd(t))
> +		return btf_kflag(t) ? BTF_KIND_UNION : BTF_KIND_STRUCT;
> +	if (btf_is_enum64(t))
> +		return BTF_KIND_ENUM;
> +	return btf_kind(t);
> +}
> +
> +/*
> + * Return 1 if the types match, 0 if they don't, or -EINVAL if a type
> + * can't be looked up or the types nest deeper than depth.
> + */
> +static int kfunc_type_match(const struct btf *a, __u32 a_id,
> +			    const struct btf *b, __u32 b_id, int depth)
> +{
> +	const struct btf_type *at =3D skip_mods_and_typedefs(a, a_id, NULL);
> +	const struct btf_type *bt =3D skip_mods_and_typedefs(b, b_id, NULL);
> +	__u16 kind;
> +	int i, ret;
> +
> +	if (!at || !bt || !depth)
> +		return -EINVAL;
> +
> +	kind =3D kfunc_type_kind(at);
> +	if (kind !=3D kfunc_type_kind(bt))
> +		return 0;

This makes enums incompatible with int types, do we want an exception
for such a case?

> +
> +	switch (kind) {
> +	case BTF_KIND_STRUCT:
> +	case BTF_KIND_UNION: {
> +		const char *an =3D btf__name_by_offset(a, at->name_off);
> +		const char *bn =3D btf__name_by_offset(b, bt->name_off);
> +		size_t name_len =3D bpf_core_essential_name_len(an);
> +
> +		return name_len =3D=3D bpf_core_essential_name_len(bn) &&
> +		       strncmp(an, bn, name_len) =3D=3D 0;
> +	}
> +	case BTF_KIND_UNKN:
> +	case BTF_KIND_ENUM:
> +		return 1;
> +	case BTF_KIND_INT:
> +		return btf_int_offset(at) =3D=3D 0 && btf_int_offset(bt) =3D=3D 0;
> +	case BTF_KIND_PTR:
> +		return kfunc_type_match(a, at->type, b, bt->type, depth - 1);

This makes `int *` compatible with e.g. `char *`, do we care?

> +	case BTF_KIND_ARRAY:
> +		return kfunc_type_match(a, btf_array(at)->type, b, btf_array(bt)->type=
, depth - 1);
> +	case BTF_KIND_FUNC_PROTO:
> +		if (btf_vlen(at) !=3D btf_vlen(bt))
> +			return 0;
> +		for (i =3D 0; i < btf_vlen(at); i++) {
> +			ret =3D kfunc_type_match(a, btf_params(at)[i].type,
> +					       b, btf_params(bt)[i].type, depth - 1);
> +			if (ret <=3D 0)
> +				return ret;
> +		}
> +		return kfunc_type_match(a, at->type, b, bt->type, depth - 1);
> +	default:
> +		return 0;
> +	}
> +}

...
