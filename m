Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85461F8755
	for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 02:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768877612; cv=none; b=IGy2CRaLlyLzpUrGidMx3GpTMJ8Num2pTE5au/rC+TfOmJV5XuPyIK+4PikJMaCU9dKfcZaEjytZDDyiSiV47vL2n75dQQDnn2q3lLQ54f5iSIHxTlFiNQgUsKS6o/K4DM1HKG3IVC/LdB9RyDxKSCvX+JicDNzGABRFDGxSPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768877612; c=relaxed/simple;
	bh=If41zOkOP0scm5TZMIBjYL64Hb+I+qeK3M1HiwITHfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZQ1sbXoDXtR4xOb0sbFRc9oP8hfsNlicUU7O9FwYfpienp5szh8Uc2Y/9haob/Yh3QSUqMXkcaELloR7YBQRtFp+sYXuoNwdKKWM00md4A5wj1GgV8YNGMAjJRbj3en0L9kwm1nW4WF9sRJmV2iepzgcvCLFJX/sr+xh3Rkee8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOh8mHdP; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOh8mHdP"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-11f1fb91996so11244679c88.1
        for <sched-ext@lists.linux.dev>; Mon, 19 Jan 2026 18:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768877610; x=1769482410; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3odNBdrf6aEyMBCFvJIVDjybvUoKRUaMAkhxu2qWeKU=;
        b=kOh8mHdPiw+EDnYhOEqYeiV4OPPTDKxAx7Q6hv8Q5+q1RCSePMEmIZT+gyMpxkPP1v
         IR01VeaU60Q+Gfm0MwPOYfJwzB47rzJiSPWaXtn3YINtS67y7qq5yELJgcEtZyU//x6v
         vPcfjFfa8p8dzfwMGg55YuJHcVhpXazelhZ7LUezy3arOVdMnZ24pYj/SOIPZuDpRl0j
         shkw7iuvi37iy7gw3shDXFVGjEdrA9hjm4L5f3MjjYo8zi/LWGYCVzPtu46HlGNSGTa5
         VpyzteNe4JbEwy/TRME8nhXh5gtBcgd8qUPTECkolabTD8/WRM1hwMx+vCUadS6hbmiy
         LuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768877610; x=1769482410;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3odNBdrf6aEyMBCFvJIVDjybvUoKRUaMAkhxu2qWeKU=;
        b=Pdc0IZaUAIqmphCblavfX76WGwE5fcXnu4W/e0vkhDBXgeRTrhy7iae4eYVoXpysdc
         /j5ZY8OKpG4GqnCph9NC0IZ/OEbYJUjpB1+/QUVqCi8QQmdUugTpgzoGVKBLVTapnSP1
         e5q+sbT85X9JCxKDd4i+oKqSEQdzoRU5O0eCs7hKKfWE0xZkcNyvh6JDzTqqANIrVIb7
         nmkI2SAV/u6RCELe1ElMnqcQoNXZHXVIF7OWsTNQDV9gJEeQosruN9LIXc11H+MC1Hno
         7EY2bH+UdFSz5hUMexpHVlwhTcQTqR9oHpxHp7D+QH9b4hOziIrMswUt09FShTyIaL4g
         XJgg==
X-Forwarded-Encrypted: i=1; AJvYcCVS64e7Bgu6yh+DPKnKiV77sJXy+QnjD3YrFbUOI3oEF/uP8y+K8kQR1MOTH8DTEt4JGqsT2pO32KE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyc5fnjVVsmZmRdH9Ck8CMdGrbgZJHD8yIs0OLY8zZd8Hq4KKTh
	coEN8Y9gcz10buvJGxR5djAXyugRg3EyqLUdjPx3fs13hs/HvvbKDRf8
X-Gm-Gg: AY/fxX6XWuGcEQQ7eZYJmMXu1IMWu597C3jMlFTK/ZvptfbmybwiK0CRdfqwLJUJQX6
	mGj9Qax3OHI49Ou2o9DW14pYfbA5wcYUTnRNCZBd9lxms+6Ib9P73nNjOWc5JL/U6Bprm8w9bTW
	ZuE/Siy4/QFYO132u8zwja0rraxkLlAm8qu+mOYAeIP3LalPfrwHt/rFQbWHisK+99j9aIQi4Ca
	VJNuUjogPfWoGd3NuEEV2AGkQMxrLRuxisX4QtoPChUzsUZ4QlRw9NcfFUdyRsP5O5mneiKzyus
	xMmDlWlLQ4HHO/+4aSMMJm+JLF5pN7mraaMfCGgtAivHoNV3Yz+WhxR38Yo15JeNG7JKfZY3Kdc
	JlXH3VhQ/Ru5p1m70qFVuxKuvLAiR9oQTws5e7Q9Qv3nSb8nWyR5zoZ9bBMSN2PTBlAVdadyQ6O
	xhRWkN7jymiX59JBAjOEMNju4RlB6hT3zlnIAYCG6ckeFZbBnxVearH5mSlMSvi/5fWw==
X-Received: by 2002:a05:7022:6084:b0:11b:9386:a3bf with SMTP id a92af1059eb24-1244b394b96mr9022978c88.42.1768870562325;
        Mon, 19 Jan 2026 16:56:02 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad740c5sm19462181c88.8.2026.01.19.16.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 16:56:01 -0800 (PST)
Message-ID: <c370026bdcb3c2684a5c5c5a9e173f8c3e2189e5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 05/13] resolve_btfids: Support for
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 16:55:59 -0800
In-Reply-To: <20260116201700.864797-6-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-6-ihor.solodrai@linux.dev>
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
> Implement BTF modifications in resolve_btfids to support BPF kernel
> functions with implicit arguments.
>=20
> For a kfunc marked with KF_IMPLICIT_ARGS flag, a new function
> prototype is added to BTF that does not have implicit arguments. The
> kfunc's prototype is then updated to a new one in BTF. This prototype
> is the intended interface for the BPF programs.
>=20
> A <func_name>_impl function is added to BTF to make the original kfunc
> prototype searchable for the BPF verifier. If a <func_name>_impl
> function already exists in BTF, its interpreted as a legacy case, and
> this step is skipped.
>=20
> Whether an argument is implicit is determined by its type:
> currently only `struct bpf_prog_aux *` is supported.
>=20
> As a result, the BTF associated with kfunc is changed from
>=20
>     __bpf_kfunc bpf_foo(int arg1, struct bpf_prog_aux *aux);
>=20
> into
>=20
>     bpf_foo_impl(int arg1, struct bpf_prog_aux *aux);
>     __bpf_kfunc bpf_foo(int arg1);
>=20
> For more context see previous discussions and patches [1][2].
>=20
> [1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@=
linux.dev/
> [2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@li=
nux.dev/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Patch logic looks good to me, modulo LLM's memory management concern
and nit from Andrii.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -837,6 +854,369 @@ static int dump_raw_btf(struct btf *btf, const char=
 *out_path)
>  	return 0;
>  }
> =20
> +static const struct btf_type *btf_type_skip_qualifiers(const struct btf =
*btf, s32 type_id)
> +{
> +	const struct btf_type *t =3D btf__type_by_id(btf, type_id);
> +
> +	while (btf_is_mod(t))
> +		t =3D btf__type_by_id(btf, t->type);
> +
> +	return t;
> +}
> +
> +static const struct btf_decl_tag *btf_type_decl_tag(const struct btf_typ=
e *t)
> +{
> +	return (const struct btf_decl_tag *)(t + 1);
> +}

Nit: there is a utility function btf_decl_tag() in bpf/btf.h
     which does exactly the same.

[...]
