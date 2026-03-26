Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2FE3A5437
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560586; cv=pass; b=LExGE+TMQJXQCU3GIojVS88eHdaQckDVnZWqZcJ4Gk3AoQrrPoJV9SY2Ztd5MN9nXAZJMlI5AWYtXLki6QOXDN79ShRWWZHmru/ZAlqW6YzcmuHQDeni3N5E50fudT6l1bcLLNiMseZ97tmjdohq7ILesumVwJBhfPBSe3AlMC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560586; c=relaxed/simple;
	bh=qI9exwAmkDBjRH01c19fBBH57sSxNQDiBbwoNFgsSto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jr8Z6qNZH4bapGZ1b99Y79gE6/TJlFDpArHHfDWwzHYh+rRhQ7uzct3Oami3uFrGjWQgTjxlEKu3meUq29TqIrNS3LE+1PCm3ON8S9/qql+LEvlLhQarPnoG2OiHYu0gG8y2hvGXfx9sjJhzC1s38klTsiiBndYSyAt1JDUXBiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXv4b440; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXv4b440"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c766a95a72dso1044529a12.1
        for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 14:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774560583; cv=none;
        d=google.com; s=arc-20240605;
        b=f/5U4TrnGFUQmlAESlS1wco0l+g1zyq7qV7KFJhsN7yLMIFT9da6R80vrI17xkpiAM
         d29NIh7DNrxoIGNOnuG8LrBWorKL5KuOqZQMveqfsPka828LNM0KiPUnXzZRBOWqhl6+
         oSHyueQ+5PZIpRH53h6NJfBKzqS68RyB6UWNFiSdanNKzKLLnc8CIUp1nst3VsZ5e4OY
         oI/Jsq/SjmjX2NU0JvmO3/w0/ZxLtGS1BH/dW3lul+6TL7XdylixrrXVDadJqmHKfv6u
         76M4Q7AzvXDPWZc3PqITXOAFQsWOAU8ktY6tLl9KVYaDCfxhSZ09EQ0V+4MA2QpSU2WJ
         cLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3QATeCF9NkbK+B+zyLGqij20iEocr3QZWaHD6xlU47E=;
        fh=Vvg/KBAc2UdgtcgY2vMpt25mDM97W5PY3Jxm/jLQUGE=;
        b=QRGRDoH5+dMHOhpuMhFZwRdnoZ3/ogyXeHZ0SMApDDljw7I6ZjdW1l1oklB6zVk5XJ
         Ey0+juZ4gfjYgdOXtGA/5iVS+K1W/0zLpLFFMpOPvsljhKbe3GFwVJwZtixNfpMeZ8xk
         uvQwDeoxuTWe7na+vGwLihOtTBis1zjiILDFUwzmtSqMjTWY6s4d9vkFa3uYZcXjRtH9
         G/oImt9e/2rW188m9PS42ESQ2pDZVHTj7lYAM6qZjm3c/G667fz4p7p7X4aHuOmz34UP
         C0dMqJK4+I1oNX8xF3N6l7Rguae1iYVZFpN/emahohxKQIfCIWvBBC8tbWDTSl3mrN1z
         bqkA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774560583; x=1775165383; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QATeCF9NkbK+B+zyLGqij20iEocr3QZWaHD6xlU47E=;
        b=lXv4b440ZQTJ7JDwEw/mH24jrX7QgSl4LjTnFTk6qHsgyEQA/DNPogmQRx3K6d9QMa
         28EnccUUOilvicV0i/XoZVPxHMre1OHyDt2Ye78MLhpbCU0r9pDLh7hM1/C9CtJVaOW5
         x6ew7ECAawezILBPXIc5T6oA/3Q3WJy5QMv5R/H9iH1JV7DwnPOQO9orPWf81dL80HXf
         rZ7Vcg3ScK8m5k/B+NwjXaFb5EWX9z5c4Ed6wOZFLie64eTA14cvZcoAp2qKvtEBw2UN
         eaFwh/Iu6vHpdxf1qfgkSUF5SX7cBXckcHWLOfE4yvsqsinLt+WF+UXLnp/35GBK76AK
         sCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774560583; x=1775165383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3QATeCF9NkbK+B+zyLGqij20iEocr3QZWaHD6xlU47E=;
        b=WTWe2C1bzlluHZVgrRGTvTxLNmJakA1COMGPZq5NnagjziLJfYmtcyC7/CNpyFhWAR
         yun2X071Cy0y1/MSh+n9lQCpHxX7oEtXkX9O+u1ngmw9QaTLl+mBvied/Aoz5IQzvJQe
         OgP+CwOIUJVpkMzquXiGQ+XP9Vyhis4zV9ayRzCWC3+aBc7Glc5D16X5LCBsFZSWch+O
         D0W476Jslt3ajWDsSh2G7L6sX2YXqegOzQgenlckPbtMgNirVnS3cVngYnNEL3N5Gnfr
         1Wl1RLMtvOTb4yWRVz97CemkCjbHbbh0/8Jb52HeH440HUOgw7G3PuwlpdHQps9gImwT
         1haA==
X-Forwarded-Encrypted: i=1; AJvYcCVVd1l7mLcSGym/wug/uBXF3LMlKnfV/o3F11EFysOtKEgFiIY1MB4GpUes3z1kBpxEuog3DZk2534=@lists.linux.dev
X-Gm-Message-State: AOJu0YyKIJ5vYjhaxXwFF6iBIeeqxfl7v1ey3vt0RPEcFT2dckdc0IYK
	QQjeUTvMIlR8c2XY6+h2qy3J8aOi4DB3JZaTmP6HSwuTum3AGf2G2fv1JcoPcFuN/g2/IIiYXwM
	CcPtqy28yGGsVhgf9RHKxluqEq764wvE=
X-Gm-Gg: ATEYQzzb/GqWYI/nZeDW9xQjS+K5DxHBggl45iB2EnliEqkTrRGISAkK4z8PcFIbyeK
	LUnLM6oN4P+6cK1pQL64o0NO2yeKxq7asys3oC+U2mk315NlhV7I0J3OpsmOOnVDiIPuEKAonUA
	6hjh3IIMzn2ti+WKg0ngfsviMcCa4gkwUZ2FZVa20sV7M2kYM+uvpMwMIItZWSJfXoo3uABYFj0
	x/CqWFzOlojHtWawELSgfkcKt8+fjBw/BAv1MiYJAZY1qETLMoOMCygSVSgwB4XqA/nRU0vdYvF
	EohpDTGXCKRfSWNR07y/RJ9hq/D17Y3d7g==
X-Received: by 2002:a05:6a20:918c:b0:398:7d6e:27f4 with SMTP id
 adf61e73a8af0-39c877ea44amr236776637.1.1774560583359; Thu, 26 Mar 2026
 14:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260326204335.3756885-1-suzhidao@xiaomi.com>
In-Reply-To: <20260326204335.3756885-1-suzhidao@xiaomi.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 26 Mar 2026 14:29:31 -0700
X-Gm-Features: AQROBzDHSCVfkJYst2_nm2hm-Lt62FEoPxrr-U4kjkt2KElJQNQYMKfuKmX7V6w
Message-ID: <CAEf4Bzb4EQVSTguMjmd=sYXYFxmyqYnGxBdRfg6dMnRoSYwORQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: resolve versioned kfuncs by exact name before
 essential-name lookup
To: zhidao su <soolaugust@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	sched-ext@lists.linux.dev, zhidao su <suzhidao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:43=E2=80=AFPM zhidao su <soolaugust@gmail.com> wr=
ote:
>
> Some kfuncs use KF_IMPLICIT_ARGS and export both a base name (where
> the verifier strips the implicit aux parameter from the prototype) and
> a versioned name with additional user-visible parameters (e.g.
> scx_bpf_dsq_move_to_local vs scx_bpf_dsq_move_to_local___v2).
>
> When a BPF program declares a weak __ksym with a flavor suffix such as
> func___v2, libbpf strips the suffix to obtain the essential name and
> looks up the base entry first.  For KF_IMPLICIT_ARGS kfuncs the base
> entry has fewer parameters (aux was stripped); the prototype
> compatibility check against the versioned declaration (which has the
> extra user parameter) then fails, and libbpf leaves the weak symbol
> unresolved even though a perfectly-matching versioned kernel entry exists=
.
>
> Fix by trying an exact-name lookup first when the symbol has an
> essential name (i.e. it has a flavor suffix).  If the exact name is
> found in kernel BTF and its prototype is compatible, use it directly.
> Only fall through to the essential-name lookup when the exact name is
> absent or incompatible.
>
> Signed-off-by: zhidao su <suzhidao@xiaomi.com>
> ---
>  tools/lib/bpf/libbpf.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>

libbpf doesn't support (yet) matching triple-underscore-suffixed
kfuncs on the kernel side. We plan to support that, but it should be
done differently.

For now, as a work around, if you need libbpf to match
scx_bpf_dsq_move_to_local___v2, you can add yet another triple
underscore: scx_bpf_dsq_move_to_local___v2___andimeanit

pw-bot: cr


> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0be7017800fe..80e495aebe68 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8630,6 +8630,40 @@ static int bpf_object__resolve_ksym_func_btf_id(st=
ruct bpf_object *obj,
>
>         local_func_proto_id =3D ext->ksym.type_id;
>
> +       /*
> +        * For kfuncs with a flavor suffix (e.g. "func___v2"), first try =
the
> +        * exact name.  If the exact name exists in kernel BTF and its
> +        * prototype is compatible, use it directly.  This is necessary f=
or
> +        * KF_IMPLICIT_ARGS kfuncs that export both a base name (with the
> +        * implicit aux parameter stripped) and a versioned name with ext=
ra
> +        * parameters: the essential-name lookup would find the base entr=
y
> +        * (fewer params) and fail the compat check, leaving the weak sym=
bol
> +        * unresolved even though the versioned kernel entry is a perfect
> +        * match.
> +        */
> +       if (ext->essent_name) {
> +               struct module_btf *exact_mod_btf =3D NULL;
> +               struct btf *exact_btf =3D NULL;
> +               int exact_id;
> +
> +               exact_id =3D find_ksym_btf_id(obj, ext->name, BTF_KIND_FU=
NC,
> +                                           &exact_btf, &exact_mod_btf);
> +               if (exact_id >=3D 0) {
> +                       kern_func =3D btf__type_by_id(exact_btf, exact_id=
);
> +                       kfunc_proto_id =3D kern_func->type;
> +                       ret =3D bpf_core_types_are_compat(obj->btf,
> +                                                       local_func_proto_=
id,
> +                                                       exact_btf,
> +                                                       kfunc_proto_id);
> +                       if (ret > 0) {
> +                               kern_btf =3D exact_btf;
> +                               mod_btf =3D exact_mod_btf;
> +                               kfunc_id =3D exact_id;
> +                               goto found;
> +                       }
> +               }
> +       }
> +
>         kfunc_id =3D find_ksym_btf_id(obj, ext->essent_name ?: ext->name,=
 BTF_KIND_FUNC, &kern_btf,
>                                     &mod_btf);
>         if (kfunc_id < 0) {
> @@ -8655,6 +8689,7 @@ static int bpf_object__resolve_ksym_func_btf_id(str=
uct bpf_object *obj,
>                 return -EINVAL;
>         }
>
> +found:
>         /* set index for module BTF fd in fd_array, if unset */
>         if (mod_btf && !mod_btf->fd_array_idx) {
>                 /* insn->off is s16 */
> --
> 2.43.0
>
