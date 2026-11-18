Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041874;
	b=xWy/Em+CIlOeQzvludZCmcL0DB55Ep50Uj6aOzIvgabml8CDjC6qroC3ObiAvCpII+dJ
	 kcRra2Dw71xI+kK/vUo9DnK9BRyJgF7b29gHKkp9PYcJaoGjpFriPSUHf0QHjuxsyHYef
	 EPf69YP+mYjH3AJHupWPe2L5dDQBnA9I747QE/+9FtLf6YtWUdvzlvGSC12wqA8Tr3uLP
	 KAttj3MdRId2uqtADuphxRhweF9IAwyLonS72wBOhH5CbA4IDDUl/AChKMPzU9y0nuRkk
	 KLw+AgUh8+2AO/AQiYuWslRG/hqiYUvHZvh4ztHxdjjTUEEgqP18Wj/K9oOkkYWuThw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=xb8vaYkXb3WyePVM4A0uNn/vxbvhHtvysyg0tVAcvjw=;
	b=Cn/0m0J3rNFwGmIfLgVd9S8IDEfE4pNaliw8soT+D+69rYyBDqVW9Pv+j1ew37oLUIVG
	 5VukT3KtR2seWsawWgbA0k7zmXzqYvvZVM4UdunJWOrvjpg2MUX69SKBof9/2vuGJ/iVr
	 7Ra/fzFB9qjTlnlqCTvFe08UsQfXP/DNvvhSLvuPt0mCNfun2LQe5FQLQrA6VzNFXkMw/
	 MLk+5fn9y3IpXQrf6I4L5RBYzE/gvXEUuQXQxBt7n9I1KJFtzhcLETrDmPRaHRiscVhWb
	 cjwTf9Y7c3R9BOLSBKgB0ZDje1AEd+srD/aIu0SE8xCkhRbp2YAEG/9DQAm/W0mZq8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kOa2lLoH;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56B606A320
	for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 22:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED56B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kOa2lLoH
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so980487a91.1
        for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 14:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795041873; x=1795646673; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xb8vaYkXb3WyePVM4A0uNn/vxbvhHtvysyg0tVAcvjw=;
        b=kOa2lLoH1Eehr4W1Kc24zP1uWRkgKKqtwpnlcUMvkMwsEjpMtzXKrMfRtF0gVCvgBL
         GjfP4iJE+RujAi7KkLhPurtVCp3Z0m36QhqHn5j9cSNTCX2yhjKZTBdd4TYoAdj3maIl
         Tl61Tb1x9hyY+xoR3iOC/5aOcpnk1SrVhPSunJ2t/ML/J4sDoHdyWueToAWNwS9S8hgY
         hW8WN6eXpm3phF3N8aHg1VQn32RYBcd52UIj8BS5sV6k4lmkToW56sANjh02kFLXd+cY
         MI7rZf8HjwbB5hiYigJGyZzlr5juqo4PaM44ly53xT5v49Qxscl9R5hFMNzakeGdeoqJ
         vixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041873; x=1795646673;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xb8vaYkXb3WyePVM4A0uNn/vxbvhHtvysyg0tVAcvjw=;
        b=EBZulhpN/vK9yb0LQdq3RtZZAHnftAEsXjeqOWYlEyrO40YFxjg9qqnJruXHChNZ/T
         P634f+RBMpIWDB/Txg9ywtz1wDVlTNDtV+jluT57H63OVO6i637x2YOimGgVN+Up5yFP
         ylzgFkJRJR55/ivREBQevLC9X5fKJUAmEHbp5zVuy4B5+5EfR4RgfUBIYIWtzyIhO+//
         5DF1Eg4VSfyKUx/St3d46Kn6i7a0ux27YdeQrXYuSADB/D4I4v/AxCCYi/6lj6XiMdfx
         SlSDNjolScIgkqR/NigLOCRnpQM1rQaKyeD77mpMKiu9rpIquvsQmx6T4MSfkSg4hs0O
         kI1A==
X-Forwarded-Encrypted: i=1; AL+hErGsPpjtEfCoRcsWtdpoQrIyPcOObWq4IIl2JP2dc+DTXpewr44Yr4oAS8VC9UFCoaqQ1/ebnbtfTds=@lists.linux.dev
X-Gm-Message-State: APuU4Z/q2rabD6eaMFNdKfaEEVMsddEsFx/tMC+8VlcGhQdVJnTHGdgH
	6p32aYD2ZlrEMiM7tT8BYvBxDmt9f/MIqeEG8VzTC/B25ogr1y8lrIkb
X-Gm-Gg: AZFdTZeRiLRAEWK1S2t8UvmWVLW8uHHmoRn35bFKA5iIWdhlOvlIitRoX5CkziaXGrE
	jAuBw3KmxtgOwuwWZanj57wkKZ7fBU8g/yMKi6LOsgABV+PTI4GuIuEegDsXtZK4ABrgaA32GKw
	XTdJvBxzv2mYlXK9/8G4FMSSTGqst1dnbgndJBlt7+nA1leCfUhjjyPckq8imM2ogyBNswg0v1z
	ZL80cg3QgVM+pGo/mvRCTa3gRJ3qIKqT71gXQaU/UudXWhQO0q+l76Z2p6i3PeN/XXAwYsqKKzX
	3huykA2SvyoJu84NZBL7+jGl4lTa5j8690mIoh6ReS69jfE9/KcCByiNvA2Tpn1p7HcbIUKIiSM
	aL/aQN9iECHnUEgzwe6uKXciLDFfGOn+3W0NdfwYjwWPK5knQ7RD5FrLpjEGpImh/Uim4PqzRax
	bXyp8dynvQ/1R76Ub+cIqY/NkRbCNiEhGrWiMHOLOeFwBe0corvPvpTP+GUO1EQNWZWvwDNrmsF
	phjDSiaMS21h31enBCEkYHAs1yAi9l+aXqGgKif6722d8Y8UUi/8LpuGQZfJFdP3q5x/OWfc7ME
	0WGfVRPoOTB42SN6c9kuP5jit/3hdHLHmnx+w96Y8f+wV61b2P9p3uBW1Q==
X-Received: by 2002:a17:90b:2b4b:b0:3ac:8af9:4a73 with SMTP id 98e67ed59e1d1-3b3d07b90eamr3666378a91.28.1795041873232;
        Wed, 18 Nov 2026 14:44:33 -0800 (PST)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3fe09b6a2sm207669a91.7.2026.11.18.14.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 14:44:32 -0800 (PST)
Message-ID: <9e6ac7882314fdb1215dcebff1c35db72380ad0c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] libbpf: Fall back to kernel ___ flavors
 when resolving kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu
 <song@kernel.org>,  Tejun Heo <tj@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Date: Wed, 18 Nov 2026 15:44:31 -0700
In-Reply-To: <20261117192153.3384031-2-ihor.solodrai@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
	 <20261117192153.3384031-2-ihor.solodrai@linux.dev>
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

On Tue, 2026-11-17 at 12:21 -0700, Ihor Solodrai wrote:

...

> +/* id is a kfunc named <name>___<flavor>, where len is strlen(name) */
> +static bool btf_is_kfunc_flavor(const struct btf *btf, int id, const cha=
r *name, size_t len)
> +{
> +	const struct btf_type *t =3D btf__type_by_id(btf, id);
> +	const char *kname;
> +
> +	if (!btf_is_func(t))
> +		return false;
> +	kname =3D btf__name_by_offset(btf, t->name_off);
> +	if (strncmp(kname, name, len) !=3D 0)
> +		return false;
> +	/* kname is <name> itself, already tried by the exact lookup */
> +	if (kname[len] =3D=3D '\0')
> +		return false;
> +	if (bpf_core_essential_name_len(kname) !=3D len)
> +		return false;
> +	return btf_is_kfunc(btf, id);
> +}

Why is `btf_is_kfunc` filter necessary?
As far as I understand, main kfunc resolution logic does not check for it.
Having different rules for exact name matches and for flavoured matches
seem to be inconsistent for no good reason.

...

> @@ -9526,6 +9650,17 @@ static int bpf_object__resolve_ksym_func_btf_id(st=
ruct bpf_object *obj,
> =C2=A0
> =C2=A0	kfunc_id =3D find_ksym_btf_id(obj, ext->essent_name ?: ext->name, =
BTF_KIND_FUNC, &kern_btf,
> =C2=A0				=C2=A0=C2=A0=C2=A0 &mod_btf);
> +	if (need_kfunc_flavor(obj, ext, kern_btf, kfunc_id)) {
> +		ret =3D find_kfunc_flavor_btf_id(obj, ext, &kern_btf, &mod_btf);
> +		if (ret =3D=3D -ENOTUNIQ) {
> +			/* an error even if declared __weak: ambiguity isn't absence */
> +			pr_warn("extern (func ksym) '%s': more than one compatible kfunc flav=
or\n",
> +				ext->name);
> +			return ret;
> +		}
> +		if (ret && ret !=3D -ESRCH)
> +			kfunc_id =3D ret;
> +	}

Idk, I don't like that this is implemented as a special case:
- Check exact name match first.
- Check flavours in a separate loop.

It appears that having a single loop looking for name candidates is a
bit better from code structuring point of view.

> =C2=A0	if (kfunc_id < 0) {
> =C2=A0		if (kfunc_id =3D=3D -ESRCH && ext->is_weak)
> =C2=A0			return 0;

...
