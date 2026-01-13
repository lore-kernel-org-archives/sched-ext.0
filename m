Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE7D30EF87
	for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340637; cv=none; b=TXpbzZeH4o/TxMr7Ay0iPQhM+S1DCXQ4qxh98oYzDO2Ftm1LlsQMcm8nz1oaBzawQk7WF2I5HzUv+y5z9ULFGZL976KWpQhvhwqH0/8QWbG8g3is2VhqOSvw7q/2gaqIJm6jsDUltJZ46w1dyxCIT5jpAVsWtTxwQjpekKrEDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340637; c=relaxed/simple;
	bh=7bsUtiUgKGUde2s0C0zgl5rK6a734yalkgEEbvzprU8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dM7LKexbZnFo+kRvlPi4DRQxcqlathMbhXpIYm8ZHyF32VxjbuvtufcWsNVN5EqTRxu/M7C3JYM4NHw45OrT9ZMQ6GtTRqjWKX2+//Xxc3DQSXXKrpFSHFa0XJhfFJTSj85AMQud+e4jPdQPigDNfWQAr5g/nLOzlsFyt8AuB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/8Hs71j; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/8Hs71j"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34cf1e31f85so4729461a91.1
        for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 13:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768340635; x=1768945435; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PYn6o6R3QSwAggtOWvfLgCyBT+NI/AbWRIt35aBXUGU=;
        b=D/8Hs71jntv1v+NxX0yBlqs97ha7K/uCUdSv8q59jMrvGMmf0YD88JH7brY7gfXXv8
         2tY8I+/J2UwEI9pOaAiVENrJwULueT7mEBCQgMRUsAZPnoNg+y6nzhTlfsAQaqIsGNCe
         7Fni2cWPH54nFXoE9r1QXhLFQr2aenSQSc0bLyznmZOMfy3u9HmC+Y2kIWUHGjRpO9xE
         g0dKEH3KI3Jy5lBxSDjiQJZIkciBtGn0nU6q7WsWt7jUAHYyCal/1z6qV9ZYYntfvBuk
         Lt5klBR7pE3qQzHT6s430dASOcheUUdK7N4bin6hE3dO1UiR7TlR+I7wpqM+5Ev8m/Vv
         Rw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768340635; x=1768945435;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYn6o6R3QSwAggtOWvfLgCyBT+NI/AbWRIt35aBXUGU=;
        b=sL1i+Ffa0l5RRm5j98nI7LLVV/vmHFUXrJD9fPXYxiPKPCN5MhFLF5X2eQ1px+DBBJ
         w0JtHGDCN2Ufg2AOD5ma948GoAowBXkMlTdpIJOuLsR06c7YCXduEz+7OcU6+G/r2I51
         ZIjbi3UneEgGOGj1CJ/1Y7S54GcIewfI4tLMtke6W7ikEwrApxpoTGZWc6HxQJn5RgA8
         Bma6V7aucG4O6jjeOZNBCFOve/eX6KkKZEueoVMJAwAIJazNht3itjBUb5vAiNklsLqn
         DIzRGEMtoIQV3Nz+gVCi1zHpPjEn9A/wJyjOFuEijbexK7XvpAU1z2LXp4a227UE/fMg
         A8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCU0yoNXNSXC9e+nqDoO0I3TGfQLsl5gSgQyy1croy/o67qj68ThFWCUXrzExWebQDpLx1K57zhDhMU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw50cET7SPEkesuWhCh3FN2ZnYUDMeF+l9+z1XDiCGYj3Ad69jE
	B6j/8VBDEAD9bnzJ/xA12dj6KxgrkqXBMBF2a7EycSRvDvb9HbL4mnNn
X-Gm-Gg: AY/fxX75aHhvvBqWdfxTMWE+Tb27EtsrQeeSCQzd1Gk1GYFabCcWxn/EAsluK0p57Ll
	CzG13sK6XPAPSXyE288m++69R+ajT8h/cV2n/BkLIXUfoCwnQe3ChFq56cij1gnxFntUpZbgvEr
	oorIGeEYL9bj7j285Q/5QRKyVsF8BuQnc10k1ZG3N1mUF/lpKW9MecXxJdtLOxetmOS2e93yUkO
	k+K40VNM5R4UJfyyFlCY6+zak6Sza5q8XkQ16VJ+gxmE866rtANxLWJqRbycFbIlcScXwGKvhPL
	2uIpwITRHJATGW9KWMr/UvEiItY49thH5+XdRDL05c94QXPkwezjEB7OAUHwfYZVoPkPl3YIRM+
	85GggSyEYvGlw7mpRhWPioihFyg/hY+Aycyy7VxhrFqnY9cKCujSoJDvMlp5eKUABRSrH69NDPq
	NtMf0EVs4yek3qj/4qmGcxkKfLV1CzpunAfGV0A10D
X-Received: by 2002:a17:90b:2e8b:b0:343:7714:4caa with SMTP id 98e67ed59e1d1-35109086381mr473677a91.3.1768340635072;
        Tue, 13 Jan 2026 13:43:55 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-351068fe22esm364539a91.2.2026.01.13.13.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 13:43:54 -0800 (PST)
Message-ID: <6a9a60f292e3ce862accd782bd43f8dc2491bca4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 01/10] bpf: Refactor
 btf_kfunc_id_set_contains
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev
Date: Tue, 13 Jan 2026 13:43:51 -0800
In-Reply-To: <20260109184852.1089786-2-ihor.solodrai@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
	 <20260109184852.1089786-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-01-09 at 10:48 -0800, Ihor Solodrai wrote:
> btf_kfunc_id_set_contains() is called by fetch_kfunc_meta() in the BPF
> verifier to get the kfunc flags stored in the .BTF_ids ELF section.
> If it returns NULL instead of a valid pointer, it's interpreted as an
> illegal kfunc usage failing the verification.
>=20
> There are two potential reasons for btf_kfunc_id_set_contains() to
> return NULL:
>=20
>   1. Provided kfunc BTF id is not present in relevant kfunc id sets.
>   2. The kfunc is not allowed, as determined by the program type
>      specific filter [1].
>=20
> The filter functions accept a pointer to `struct bpf_prog`, so they
> might implicitly depend on earlier stages of verification, when
> bpf_prog members are set.
>=20
> For example, bpf_qdisc_kfunc_filter() in linux/net/sched/bpf_qdisc.c
> inspects prog->aux->st_ops [2], which is initialized in:
>=20
>     check_attach_btf_id() -> check_struct_ops_btf_id()
>=20
> So far this hasn't been an issue, because fetch_kfunc_meta() is the
> only caller of btf_kfunc_id_set_contains().
>=20
> However in subsequent patches of this series it is necessary to
> inspect kfunc flags earlier in BPF verifier, in the add_kfunc_call().
>=20
> To resolve this, refactor btf_kfunc_id_set_contains() into two
> interface functions:
>   * btf_kfunc_flags() that simply returns pointer to kfunc_flags
>     without applying the filters
>   * btf_kfunc_is_allowed() that both checks for kfunc_flags existence
>     (which is a requirement for a kfunc to be allowed) and applies the
>     prog filters
>=20
> See [3] for the previous version of this patch.
>=20
> [1] https://lore.kernel.org/all/20230519225157.760788-7-aditi.ghag@isoval=
ent.com/
> [2] https://lore.kernel.org/all/20250409214606.2000194-4-ameryhung@gmail.=
com/
> [3] https://lore.kernel.org/bpf/20251029190113.3323406-3-ihor.solodrai@li=
nux.dev/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -8715,6 +8730,26 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_pr=
og_type prog_type)
>  	}
>  }
> =20
> +bool btf_kfunc_is_allowed(const struct btf *btf,
> +			  u32 kfunc_btf_id,
> +			  const struct bpf_prog *prog)
> +{

Nit: I'd just add hook parameter to btf_kfunc_flags():

     u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const st=
ruct bpf_prog *prog,
                          enum btf_kfunc_hook *hook)

     and allow passing NULL there, thus avoiding duplicating logic for comm=
on hook.

> +	enum bpf_prog_type prog_type =3D resolve_prog_type(prog);
> +	enum btf_kfunc_hook hook;
> +	u32 *kfunc_flags;
> +
> +	kfunc_flags =3D btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_COMMON, k=
func_btf_id);
> +	if (kfunc_flags && __btf_kfunc_is_allowed(btf, BTF_KFUNC_HOOK_COMMON, k=
func_btf_id, prog))
> +		return true;
> +
> +	hook =3D bpf_prog_type_to_kfunc_hook(prog_type);
> +	kfunc_flags =3D btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
> +	if (kfunc_flags && __btf_kfunc_is_allowed(btf, hook, kfunc_btf_id, prog=
))
> +		return true;
> +
> +	return false;
> +}
> +
>  /* Caution:
>   * Reference to the module (obtained using btf_try_get_module) correspon=
ding to
>   * the struct btf *MUST* be held when calling this function from verifie=
r

[...]
