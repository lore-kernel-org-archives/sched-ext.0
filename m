Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795042799;
	b=bIsz39cSF7ZD5lSDOFbcTVlzThjDcpI3Lkp0wdKpYPrvjd2jpowY4R4dH3hfgscVB4d3
	 SK22ioBgGR8+i+Fkt98WLMahfJ/CBdlviXDKq10Q0TXZ+kmwjk7HeFvvT3i4nLBMgYi4v
	 jh7lmImMO0wAOmGqdvywAVCDpsYHLOlTkS16LkCTmMCZkAgX4q0sYv+XVk9mTgjVorkA5
	 y/G77+UTeZvRm6AXcfBqGY1ytksBfD5DepE/5prIqbUID6tCYwpSPjKyfPHlKuQvV/7Nm
	 kcJ3sOhjGN9Y1SyJ1qLpmOGRJgHMYg40j0s1VaEr4cODBfZCgI7Df9Jk6D8NozwuEJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795042799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=LBiQjXroGIgbRFbCXNC43q/C52U0JtTLkOoI/rutDOc=;
	b=1HSDUoukciZgBj9P5Xg0ieu2Ib+OETxe/NmR+hIKxs/WJQUKUET5+s9Y+4lgK9PROtir
	 s7hv3ZTgJBv03OgSo7k9p6rqFUx6JkBAJF7il78F6eco8EhTTe1yh+qvJ3YV2FJPhIeke
	 Ch3Vsr+ZTSZalCymJmzinGaZdaPNgH7YOoDadb1T1/8ezsNgLXCVtjs5CwyteS7323K3V
	 fuacOAnBEhKJPP1MfE76Iof6g8tl8XyCSCKxNCTqcIYouk8qs9PFhw20v/tlF87SJwtTT
	 xskAuSjoXMhKDpwfQOUGttnvAe4Sjvj4+pf1gfA+/T3LUECduUNL3POYuIde78jIoww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xJUTj3Pz;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CCC606A334
	for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 22:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65CCC606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xJUTj3Pz
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b3fb193c03so97777a91.2
        for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 14:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795042799; x=1795647599; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LBiQjXroGIgbRFbCXNC43q/C52U0JtTLkOoI/rutDOc=;
        b=xJUTj3PzDBCDQqFpJCOv70L+1BHrOqKw30xl7cUvezXRFS/v4Al5pzDnXZKRme2wUk
         xWzH2ibEY8IL0F6m+hd9dOh2mv3yz0ozKemAHicbRybkAbOluy6IfhvAg3HRi4nhMyo/
         9HDEBfZJl2xiHNt9n/6v7As+M66WO9hArhX9O2+sscmgnLcaSUCqbQDsPJx/qMpAeJk7
         rYeCQYIN8eXoA1Xb/Gdjhc1IbOfGXyjEomroepmaZWk+QdAVAhzFz54WgFtMzsJjDdSJ
         ercSDBogNRKLVxDuLlH/dyG3Z1wpwIGTQeqfh+mtaV82skGc7mCuPmt6P9WSBsVhC5WV
         wLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795042799; x=1795647599;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LBiQjXroGIgbRFbCXNC43q/C52U0JtTLkOoI/rutDOc=;
        b=fB1jpRvm+DM8cuEiwSxCwWyyNMXbuJ77lsTB9Kjrt6DFAEHx6tHnGvv5xUvFNdghGh
         LhtNUJ13rze1HDKx3Zm5deQurJIOzP1QNrO7z+r/8Q1O8jNPAcWaTpQY2BB1qOAINMho
         ajsiqzBx7w1u/d51XAr56669guxbWp3g/OtPfIUjkMJZSOFDwezJjc/iS3xjNsBQ9O2v
         8fnnHia7TmRPZCCzXMEe+M2LMXpg7aBZwaOaIwhhdtPqiyin304Ajnf8S8Af7w7LldFp
         h8HEsgs0j4ablc87VdhY8Qw1XGWbN5wpkzPQ1Q9cA8u7StcpkkLVdajuz9M5ZLS7IDSX
         UR+Q==
X-Forwarded-Encrypted: i=1; AL+hErFFE247Ao5dK7NzAGw6DFbvA2k8ltXWk6pKdydRK0RWUuAr8SFxvewkPUDsfaqgxQspw+3C3/D0OKw=@lists.linux.dev
X-Gm-Message-State: APuU4Z8MN/bqw1yjmD78Mez0wWlQUHaCH1LUJtTKbdhL+BaGl5C/5f1+
	BfYV+9NUSNafBUIRa3+xPizzLzOFqr/jEW5UiolzsoK/mXqObEGKqRdc
X-Gm-Gg: AZFdTZedPl897Fl5uPGr7fQ130vXN6tNVU0Jgyb6tE2w8jtBQZZ0I15WxsfIRWOt3vg
	SLfdPXXdz4MTqE54G2AxiaQu5+8KPVuRiAWHPQ14UP36JhDoZZMRXRzMFz0swh7ZlBxG0fs05Ae
	e81By+tIuzvn+XgEtXPJWTnx6H/id0Ni3RBVAZXGsyp++ESDbn3lnLI/x7cr55k73wgOBlmQlSw
	JnsBmG27QPvsv7a7d05N85v49WxfhnpmpetxxGg7W7iw4Fd7gUgK7CVj5zrTISktV0eJqvPeoiS
	HsCkzBL2E0AixEIVEeXgQvd6ImwRbrQeBql+ExyMQqFFwd8IViDrgDXVVRw2jgElZhV+qG3B4c/
	1FOKkx9eDmmGSOpPaTU3YEJfSRX3InOKhQGzGS8UMMnVLhbMQGh2v31DX0H6MPBJYIJbqf8iz3o
	YU3W77poeamOa8eZqy6uapTzNzOaWk2OwuqY6tKoXV32ugxk3HYTwlaws5AwedT/SlM/asbNX2Z
	lF2Tcu0oT5AyDviIsTZjY0lFCSVE+qc6HWBYf/4y0ljpaDKL5bZKzHCj86VBSzGbzKJdVBIfnm6
	u3WPfhoUbfQms+74bZffp5YtWLGo3hO41UVaezfnXtYP9Dp0nzQNV4k6
X-Received: by 2002:a17:90a:e7cf:b0:3ac:8dfe:8ec9 with SMTP id 98e67ed59e1d1-3b3d07d45ffmr3520075a91.47.1795042798682;
        Wed, 18 Nov 2026 14:59:58 -0800 (PST)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde534de506sm595959a12.27.2026.11.18.14.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 14:59:57 -0800 (PST)
Message-ID: <a838d40d84ccf3115faac3d3b7b4d91b923b03ff.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] resolve_btfids: Reject kfunc families
 that libbpf can't disambiguate
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu
 <song@kernel.org>,  Tejun Heo <tj@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Date: Wed, 18 Nov 2026 15:59:56 -0700
In-Reply-To: <20261117192153.3384031-4-ihor.solodrai@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
	 <20261117192153.3384031-4-ihor.solodrai@linux.dev>
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
> Kfuncs sharing an essential name, foo and foo___<flavor>, form a family.
> When resolving a kfunc foo, libbpf binds the kernel's foo if the
> prototypes are compatible, and otherwise the only family member whose
> prototype passes bpf_core_types_are_compat() against the declaration.
> That is only safe if no declaration can be compatible with two members
> at once.
>=20
> bpf_core_types_are_compat() compares prototypes kind by kind, so it
> acts as an equivalence and a pairwise check is enough. Run it on every
> pair of family members after dedup, using libbpf's own function, and
> fail the build if any pair is compatible. A foo___<flavor> with the
> same deduplicated FUNC_PROTO as foo is an alias and is allowed: libbpf
> binds foo first, so the alias is never picked in its place. There is
> only one foo: btf_check_kfunc_name() refuses to register a module kfunc
> named like a function in vmlinux or in another module. Dedup compares
> parameter names too, so an alias has to copy the signature verbatim.
>=20
> Recognize family members by their bpf_kfunc decl tags rather than by
> the BTF ID sets. The tags are what libbpf filters candidates on, and for
> a module they also cover the vmlinux kfuncs in base BTF, so module
> kfuncs get checked against vmlinux kfuncs of the same family.
>=20
> The bpf_kfunc_flavor family in bpf_testmod passes: ___v1 differs in
> arity and ___v2 is an alias.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> =C2=A0tools/bpf/resolve_btfids/btf_colors.c |=C2=A0 11 +++
> =C2=A0tools/bpf/resolve_btfids/btf_colors.h |=C2=A0=C2=A0 3 +
> =C2=A0tools/bpf/resolve_btfids/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 134 ++++++++++++++++++++++++++
> =C2=A03 files changed, 148 insertions(+)
>=20
> diff --git a/tools/bpf/resolve_btfids/btf_colors.c b/tools/bpf/resolve_bt=
fids/btf_colors.c
> index 5d307d70e7f2..91c10106319e 100644
> --- a/tools/bpf/resolve_btfids/btf_colors.c
> +++ b/tools/bpf/resolve_btfids/btf_colors.c
> @@ -13,6 +13,17 @@ void btf_sha256(const void *data, size_t len,
> =C2=A0	libbpf_sha256(data, len, out);
> =C2=A0}
> =C2=A0
> +size_t btf_essential_name_len(const char *name)
> +{
> +	return bpf_core_essential_name_len(name);
> +}
> +
> +int btf_types_are_compat(const struct btf *btf1, __u32 id1,
> +			 const struct btf *btf2, __u32 id2)
> +{
> +	return bpf_core_types_are_compat(btf1, id1, btf2, id2);
> +}

Can main.c include bpf/relo_core.h instead of this symbol-laundering scheme=
?
Or just define two extern prototypes?

...
