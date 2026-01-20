Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A92B9A4
	for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 02:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874439; cv=none; b=X/MyvVS8ZHm2Mu7Ad+t4p9NDALs3gKFvfYVjnpxdMExipAvAu/vMxSadwjDsQW2UErdSW08Ea+3RG0QyN5Rse9Q81VyZmOl0wOco9gGQ+jGjWQAFye44KFBak4ab+G9aox5CLeTJse7ulIDBIZWndOkeyfMKHzY9h5gy1LICbrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874439; c=relaxed/simple;
	bh=h1bzrV3t+W8hh2TRR/gZqlbk4hfM8u7QilZdJ5qMIjs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pWil6NgRFrNCR9zF+LUXiPwE05K4OePDt3+EcFvzZOLV6nwxF2Gq09updq6JC9uoOoR5hcKmg/ctflnuGNUJ/ZEcs3rZGaSnZ+HYA8gJ7fAch6n71PkWfo9g0y1JJ1ATjFinVY0pbTbYGSrtJqbOO+TKFxzO8cevCJ1bWN09+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqMekGBx; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqMekGBx"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-502acd495feso35798991cf.2
        for <sched-ext@lists.linux.dev>; Mon, 19 Jan 2026 18:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768874437; x=1769479237; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C5BHzdBy9bZIqFc6VCkjIoouQALwj1cU2ODrGGe4Wds=;
        b=nqMekGBxsaZBLD/qFrIAVOjCASwC9cVYPny/fb2TntziDK3lUxuZRqY5fJtdHxoI0b
         JVfth1PyrCfDZN8k/NmnhUpkUc0n/czZqqzMJFsD0VzRgJ0baft9Mwep8PMzRQT+O5AN
         IwCgsUqR+ZVB1K1xHkvm0DpQ2KOsIcRULK9fZYtfKLWmg/D27vRt8yW81tJ/8tkrqV+0
         PPZzJa8iRJsosyzYEyqCneRLeN0DNkTPVMk5LbUm8lhxVvo5vxkrtEZZHw3L1Ha/DkLH
         G6XYWyw6jFzvrm5lzKjeFn1RwRuy0kgJRafiy9DUegP4XFunvL5PqUVRU9mairod4paA
         uNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874437; x=1769479237;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5BHzdBy9bZIqFc6VCkjIoouQALwj1cU2ODrGGe4Wds=;
        b=C37s3b4cMsPUH9Wruv2VDZI+tsG5xNBYnb4MM+GDHWuXb0q0eklOfWM8YI8gQZ11Ux
         bBLcEIv5gkIZn4r6pICIUK10XTLU8kuDaVcHAVAKB/L/D8QRA1KozAaZUe3j3YEF8JT1
         zapEs77IGKJUGH0xWHe7B9SLRUYghvgbujSmfj4XV/xHr+Esr/7HILTOWZDepH+vOePm
         fGtOmuYh984yUU3kD24ZkThowlO6IdodDhEkibpQOYB3DG1L1Aa2QYP+/ZURVWFxQPIN
         HVoJsVrn7jeVfHQkHRPJdFJ4jwfeTq9Soba0NXOqh0enGssEdfvO15llZ2IHahbvkYMZ
         d42w==
X-Forwarded-Encrypted: i=1; AJvYcCWmcXDh1QUZ/U4194bFL4+X4XGBySdVPLTb14UJintSAwiXO70uIjyg4hRr2asgUYPsz3F991Ohzn0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxWHYS3LRCM8rQvCftE2I8O45U7JA/s1eq9oOFAaRLYuTp1qpKV
	hw2vh8L0natLMkDvCIxZ4RcB9XTRJNgdDLp24m8ygI/2XoS96A9jpC2j
X-Gm-Gg: AY/fxX6/S4tx5qVEqL1Mqv9XcK/GlzmkR2ZVGEPgxyXGveeXm8g/EEMXWaQzmLf9kWm
	3VhRMn3TwkoOoofsk0vuxPcHzK0foJpOzeq+vnsn22JduwxdmqvXuZdyVBSfbYn961dvhYsSYX6
	bzCUOdtp8vvvb5lgdHykEG17TI+GUPLBOJvcteWMZXS5VafkdL52WHGpSQoB2xx3rk9k3bqC5MF
	Pq/qZ+UzeETj/03D04oMdAenDDM7aF+rinYJ3dlIF0Uzje4AddJE+UCQpmcR7ri+3+cBU6ZjzYq
	IfpmxwJCzFLwosiPEOCB3Dh4jGPysClRfrFJgH+5goL1pDgEGJGN1HTtI0PYvnDc9I0KQ6gK8eD
	Cdts+5xCOgo4ROps+J2u7tSlo8EQeojiV0tDuVsyWmXPQpiKM37UUheYI2odN5NYdxNH4oC+jaS
	zlR5QKa1eisUpiRae8e+WuHCqFAn3oivBDdOF/dmPmL/EZak9gToC1ZZ/qbOEShc/qZmNTR+3B2
	xdb
X-Received: by 2002:a05:7300:6c89:b0:2ae:4f61:892e with SMTP id 5a478bee46e88-2b6b4eaddf6mr9036820eec.36.1768868006151;
        Mon, 19 Jan 2026 16:13:26 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm14832564eec.9.2026.01.19.16.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 16:13:25 -0800 (PST)
Message-ID: <c404446ab6d344338592dfa44f5a7e1b95492564.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/13] resolve_btfids: Introduce
 finalize_btf() step
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 16:13:23 -0800
In-Reply-To: <20260116201700.864797-5-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
> Since recently [1][2] resolve_btfids executes final adjustments to the
> kernel/module BTF before it's embedded into the target binary.
>=20
> To keep the implementation simple, a clear and stable "pipeline" of
> how BTF data flows through resolve_btfids would be helpful. Some BTF
> modifications may change the ids of the types, so it is important to
> maintain correct order of operations with respect to .BTF_ids
> resolution too.
>=20
> This patch refactors the BTF handling to establish the following
> sequence:
>   - load target ELF sections
>   - load .BTF_ids symbols
>     - this will be a dependency of btf2btf transformations in
>       subsequent patches
>   - load BTF and its base as is
>   - (*) btf2btf transformations will happen here
>   - finalize_btf(), introduced in this patch
>     - does distill base and sort BTF
>   - resolve and patch .BTF_ids
>=20
> This approach helps to avoid fixups in .BTF_ids data in case the ids
> change at any point of BTF processing, because symbol resolution
> happens on the finalized, ready to dump, BTF data.
>=20
> This also gives flexibility in BTF transformations, because they will
> happen on BTF that is not distilled and/or sorted yet, allowing to
> freely add, remove and modify BTF types.
>=20
> [1] https://lore.kernel.org/bpf/20251219181321.1283664-1-ihor.solodrai@li=
nux.dev/
> [2] https://lore.kernel.org/bpf/20260109130003.3313716-1-dolinux.peng@gma=
il.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -1099,12 +1116,22 @@ int main(int argc, const char **argv)
>  	if (obj.efile.idlist_shndx =3D=3D -1 ||
>  	    obj.efile.symbols_shndx =3D=3D -1) {
>  		pr_debug("Cannot find .BTF_ids or symbols sections, skip symbols resol=
ution\n");
> -		goto dump_btf;
> +		resolve_btfids =3D false;
>  	}
> =20
> -	if (symbols_collect(&obj))
> +	if (resolve_btfids)
> +		if (symbols_collect(&obj))
> +			goto out;

Nit: check obj.efile.idlist_shndx and obj.efile.symbols_shndx inside symbol=
s_collect()?
     To avoid resolve_btfids flag and the `goto dump_btf;` below.

> +
> +	if (load_btf(&obj))
>  		goto out;
> =20
> +	if (finalize_btf(&obj))
> +		goto out;
> +
> +	if (!resolve_btfids)
> +		goto dump_btf;
> +
>  	if (symbols_resolve(&obj))
>  		goto out;
> =20
