Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75DA29BDA5
	for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766087902; cv=none; b=pHxQ5MUZBhkgvbH3Zi6eAxSzUAHE/XS80vIpoT53uohSgvdZbaHHm+EsMlHpELPyNnLFdg0LHVh0pespandr6jPkXQQzGMXMRLQ9CaF6d3pw2PgN3wBjSFh426BIIjUfZWiNbHMuKmN6CpvR8DLPDOX40kUB2cXar2N9svz2Ob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766087902; c=relaxed/simple;
	bh=VeM3OJs75KWSs1s7ckUiCSzaCdotFMQP1yTobcW6rlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MR6ZoEUDBqyisq15qcXm3ZA4taUeoVuLNZaXWvZilJPlsFQFZa6cyyrU0180zlxLclpgKLyZvJG3pICRG7zNXd3qNlMpauThzHf/uHl3vseNdsk7UbxrF+MCyQ27+Q/LYzw18peD7HZJ80w4DV8pjb6y8uzRv8zeiViFB8QaiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er0R0yR5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er0R0yR5"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bfb84c2fe5eso425924a12.1
        for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 11:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766087900; x=1766692700; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jnOcnFnpSPGhMG5nqqe5zyzdTWJk6oajdNhIdN6DrQ=;
        b=Er0R0yR53LQq13JKlOQeCAF9kuKdGGJKVEu/BCxNXPvDfUilf9/DYsyc6nkyPQ5Jzp
         Md8LtR0oBxIIHVZMJcJvl8p7RRucDr9P5ZHLSSYMsFSPwD/7hOUa0mnIw8ihDUMd1Ahz
         X0ScKVje6MiMnQENNtiRhJ0OJeJZgRtXHwPXGiQDOQ3Qui30SsQOVDGUsxPT5BA2VIqL
         fBvdF665iaHpDyoyVIwu8PpnD9CP4GCu6zPACGtxAx0ZO58tE/ZUui0UeQ0TXez3/E2T
         CLmQkifjSws3b7Uo5Hjt2WQ4S2Vxzx5rDjfc1dS6ThOLhNJguUPH4ofuu2q6+vaz+UJp
         NTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766087900; x=1766692700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0jnOcnFnpSPGhMG5nqqe5zyzdTWJk6oajdNhIdN6DrQ=;
        b=tZMSDeLkDd9p8ehGg6GmVFsk7/65zUHHNrPUT/EOaIURaUyMsce8zDHqAhumi2T7aW
         aoEMBil02PnWdCHWMQGoRH9ouX6PUOnW78eUqG7SyU45emkDQn+91dn0MBEGFW9/LBxE
         hgjnvHhN3i9g0FLp2D8IXuR/yfXEyhur1+uk7KpEYd+wM4Tb78NOFxlHjVVTEVunOd14
         bhZi0tnQDnXZqUtt6H16tdJmLhYsLo/w+VUBCMeEwA3bff7q9B18wbpBwnd6idxr4zwp
         JbSgG9H/vZXEgfDCW4JL6jy+QIYJqFSXCWZkgJByvSyjs1yY7wzWuMuK8mNTIXnAPV4k
         3mtA==
X-Forwarded-Encrypted: i=1; AJvYcCV8EzzoB0RakB+Lynzcwlx0s5PHAPQCX2xoMTYXRXANcEPD5pzf48xe/dm8ofrQAe/UMApiVzayMoE=@lists.linux.dev
X-Gm-Message-State: AOJu0YzQVA8M1B5MlBudNMcjcj2VvERhJWG5FpEkChi3XNFy4dK7e6hS
	I0BFobdB5uhkOP8krMgwpGHQHNRnJDbl3Wyi9nT7rE1vGWHkhkp7IC9h9ESXy5oLRq30f5rXV3s
	WFFbWAa/ESeAsK2MBSY/kYv2N/PRADJs=
X-Gm-Gg: AY/fxX4d+PIV6DsU9HMN/77jX7XJDAR9z89X/tkUSXufNSyj/672D9CuOEPx9qUgEit
	4eCtMgAalBwLNNhB30dWu3TkW3xLKPxfM4B7M8zhoOXD6X1ft2gw1nBKUGtflKlE35vOocLtaOo
	liNkFpiY2D3Zu0xt/Lj4H0fUZrALhvE3LKxISrR7W9Ycg7XaHrFNopCyaCb7S76u9IvFZ0xZOyc
	8oA+wL3Izx3iOEjhVXq0+IdWxBbWZPoqiJn3zeSmG8hplsb0M71RAuEh3DelT6nhL0jxRyIR7FK
	zgqcv0zC8fA=
X-Google-Smtp-Source: AGHT+IFHsN1ggcHGGK017zsJZDYebTkWT4IUvNBSnL0IZX0twQMbqEdMVRFFDZiQhKCRPXJgR7+UNOnrSfcaOKCpzKE=
X-Received: by 2002:a17:90b:28cc:b0:34c:6a13:c3bc with SMTP id
 98e67ed59e1d1-34e71e0a19dmr3339305a91.9.1766087899778; Thu, 18 Dec 2025
 11:58:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251218003314.260269-4-ihor.solodrai@linux.dev>
 <106b6e71bce75b8f12a85f2f99e75129e67af7287f6d81fa912589ece14044f9@mail.kernel.org>
 <d9b9e129-349b-4510-bf33-01b831c2174b@linux.dev>
In-Reply-To: <d9b9e129-349b-4510-bf33-01b831c2174b@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 11:58:07 -0800
X-Gm-Features: AQt7F2p48Gmilc3nV7XwZv5cvWFMLs7_EpbDLoqocIvuXu77FjccU8vvsXHjSr4
Message-ID: <CAEf4BzZXzQ6fZetTA8Trwa_pu7o1AJuMyUuHbW9YXHYGQL-_HA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/8] resolve_btfids: Introduce enum btf_id_kind
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bot+bpf-ci@kernel.org, alan.maguire@oracle.com, ast@kernel.org, 
	arighi@nvidia.com, akpm@linux-foundation.org, andrii@kernel.org, 
	morbo@google.com, changwoo@igalia.com, daniel@iogearbox.net, 
	void@manifault.com, dolinux.peng@gmail.com, eddyz87@gmail.com, 
	haoluo@google.com, jolsa@kernel.org, john.fastabend@gmail.com, corbet@lwn.net, 
	justinstitt@google.com, kpsingh@kernel.org, martin.lau@linux.dev, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, nsc@kernel.org, 
	shuah@kernel.org, song@kernel.org, sdf@fomichev.me, tj@kernel.org, 
	yonghong.song@linux.dev, bpf@vger.kernel.org, dwarves@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, martin.lau@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 9:47=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 12/17/25 4:47 PM, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfid=
s/main.c
> >> index b4caae1170dd..da8c7d127632 100644
> >> --- a/tools/bpf/resolve_btfids/main.c
> >> +++ b/tools/bpf/resolve_btfids/main.c
> >
> > [ ... ]
> >
> >> @@ -260,22 +279,36 @@ static char *get_id(const char *prefix_end)
> >>      return id;
> >>  }
> >>
> >> -static struct btf_id *add_set(struct object *obj, char *name, bool is=
_set8)
> >> +static struct btf_id *add_set(struct object *obj, char *name, enum bt=
f_id_kind kind)
> >>  {
> >> +    int len =3D strlen(name);
> >> +    int prefixlen;
> >> +    char *id;
> >> +
> >>      /*
> >>       * __BTF_ID__set__name
> >>       * name =3D    ^
> >>       * id   =3D         ^
> >>       */
> >> -    char *id =3D name + (is_set8 ? sizeof(BTF_SET8 "__") : sizeof(BTF=
_SET "__")) - 1;
> >> -    int len =3D strlen(name);
> >> +    switch (kind) {
> >> +    case BTF_ID_KIND_SET:
> >> +            prefixlen =3D sizeof(BTF_SET "__") - 1;
> >> +            break;
> >> +    case BTF_ID_KIND_SET8:
> >> +            prefixlen =3D sizeof(BTF_SET8 "__") - 1;
> >> +            break;
> >> +    default:
> >> +            pr_err("Unexpected kind %d passed to %s() for symbol %s\n=
", kind, __func__, name);
> >> +            return NULL;
> >> +    }
> >> +
> >> +    id =3D name + prefixlen - 1;
> >
> > Is this off by one? The original code computed:
> >
> >     id =3D name + sizeof(BTF_SET "__") - 1
> >
> > For BTF_SET ("set"), this gives: name + sizeof("set__") - 1 =3D name + =
6 - 1 =3D name + 5
> >
> > The new code computes:
> >
> >     prefixlen =3D sizeof(BTF_SET "__") - 1 =3D 6 - 1 =3D 5
> >     id =3D name + prefixlen - 1 =3D name + 5 - 1 =3D name + 4
> >
> > The -1 appears to be applied twice now, once in the prefixlen assignmen=
t and
> > again when computing id. Should this line be:
> >
> >     id =3D name + prefixlen;
>
> Yes, this is an off-by-one bug.
>
> Good catch, Opus 4.5. Sonnet 4.5 missed this in v3.
>
> This was "harmless", since the names stored in the trees don't affect
> the output.  The comparison between the names still works, as they all
> simply got a "_" prefix.  But this only makes the bug sneaky, which is
> very bad.
>
> The suggested fix is meh though, IMO a better one is:

the bug is not in determining prefix length, but in using it to find
where id starts in the string, so the fix should be

id =3D name + prefixlen;

prefixlen is calculated correctly, IMO

>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index 3e88dc862d87..ffc15c249ed4 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -295,10 +295,10 @@ static struct btf_id *add_set(struct object *obj, c=
har *name, enum btf_id_kind k
>          */
>         switch (kind) {
>         case BTF_ID_KIND_SET:
> -               prefixlen =3D sizeof(BTF_SET "__") - 1;
> +               prefixlen =3D sizeof(BTF_SET "__");
>                 break;
>         case BTF_ID_KIND_SET8:
> -               prefixlen =3D sizeof(BTF_SET8 "__") - 1;
> +               prefixlen =3D sizeof(BTF_SET8 "__");
>                 break;
>         default:
>                 pr_err("Unexpected kind %d passed to %s() for symbol %s\n=
", kind, __func__, name);
>
> >
> >>      if (id >=3D name + len) {
> >>              pr_err("FAILED to parse set name: %s\n", name);
> >>              return NULL;
> >>      }
> >>
> >> -    return btf_id__add(&obj->sets, id, true);
> >> +    return btf_id__add_unique(&obj->sets, id, kind);
> >>  }
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/2032=
1956014
>
