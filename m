Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795569763;
	b=K2X8IEKftX8GIsaXsWYWHVVXvS+8pVxMWNx6FHBsOOXCZN+QRkVZDwtlPVxp38UUq6YF
	 dUMGDixeOSih7yzDlZlJjmFoZKr6XzdHLQIIoc7CJZpBnnFQy3Gs12uSczVzsSdNJsl2L
	 FPClr+/DdY/kiy9QKkhCZK/pkbfSSp+yvxU7FZK7eWr/SyBJ4q4bF3T/AEz7AijC2Z6PF
	 B0FzO0n9UhAgFb4tTT6JJNSR9+IZeF7laKzC4c5hO2LGW9qL/R6Kw4nS9/lBjdYGmdz2w
	 lAo7Yt+iZkH1FN25OW77dj3fhsK/QROeq7mcA2nlZ4R0rLnc5ARPd8GY0f9QN5nXETw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wBb700J2WtgcJintm9bPNjmRy+i5hU5JB5stZCw0Ctc=;
	b=l1a+0pzQAiJNLB7Jjds2CPPf5WidJqREo3M3DjGPZ7XJ67hW0fTCX4D8t/ClvTnGZQg8
	 ONV1hlq/K1ThQKWrtJkBmFiyL7eWjd4eX4uvDq73+5ZiicHqxcCzIeAMJ7WyngTosf1gU
	 HlNNRjtGWrYaB+Rx4qoa92jHh7jafPTKHSTiVxDf41LZ6H/j5C78lkwS/vXak7wu7zbTv
	 I2fLxypXBEu6Tb9r7U656XIuC7X0ohqt8VlS+mQhCowqE/NhM6k7b28PNxAkB7Yk4r3ty
	 5idIx1uss/oPpIYEx51ZOriDyjXTgcsw5OrHkX6xOgkzcZj01SVbCV3Gsj8C7iGCz1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tSJrapHb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB911606A31E
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 01:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB911606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tSJrapHb
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so53987575e9.1
        for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 17:22:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795569761; cv=none;
        d=google.com; s=arc-20260327;
        b=UGc/xPkjCCTWhK5fakkUecLCKiHI134VzYf4xCTFgWT4hfWyKX8mwqTsK34CPlylv3
         AL40obL4zVWj6gMK//jAznuVTSvBELkOdC3Siqgs53/RrM1GkqYxXg3SLiWew4RyF1nQ
         dqMU+IN1vzlEFyGH+QWV+kTtwjFRqYrZohpVM6J9ewd345DaXVqlWnVg+wUHNPBsqBVw
         jFxB+LYINw8m9RLqXr+s4q78T8KLLBiTi8HIhwGebXF6Z3kF7NYJmSh+Ey947P6G8l3x
         oNWh4C7RN2hjmUvGwQJwVcb8T44qzCrgxyEd6Lxkhxz7F/xBW/nGLZ2hw8h29DfnkCJz
         GbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wBb700J2WtgcJintm9bPNjmRy+i5hU5JB5stZCw0Ctc=;
        fh=TlFSJet7A6ARsTK+Sn203P/yPf7so0EaDAg9Fb6cvIs=;
        b=MxbXYIabCCIOZudQWqcz+ju7y5NHTFXPDF3lXnwjF+vF3B4syx0CNci3PEB/uINkpt
         DJ9Q9BQg6BZ/UxNxYDGW0Eu3nGzKjXst3Px08MKv8KngVZCYi8E8du5iyUwMspxzUa3d
         FDYV7tBTFAfxqdQSmspQ9S4yj4ipwDGpaSDfVeT98mV9ETdwl+lXJ+deFXjTsKv7SaJU
         l+wlVe898rKbMAGEspdSIUDGIDCKth9sw8+KmGXXHtTkb9tFBjuywFn9bP0Jv4On3LG4
         TfC/HTKmrhpyuLQwsM2deQMEGzn/L7R8MHZ0kNsz1yJebokVSg0NMl41K6EJY8PApgxt
         V3qg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795569761; x=1796174561; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wBb700J2WtgcJintm9bPNjmRy+i5hU5JB5stZCw0Ctc=;
        b=tSJrapHbQLGyV3pT+n1TmO0oY29Rc560BdGUEnM1KqtqKguBRLbalC2JDbE2HWcoj0
         x0ebIQCy+qE1kAsxwFf3WMnk0ts0OtpYWkKLhP5wadcinZ/HpTDD0xelpWYBINLCpeWL
         BA/NWpjG0QcPszMFQ7y2yX+KfOEFGk5GtgJwo3FYjPlCl/8PyG3SQDrGvwQq05p4HYzR
         s5uO6E6FgvlPUGHUPbgZ4HBmFlIG3qjutL/3wLTOa2h5UxEKcae11tYeWMbre3Y8rA/X
         Uwv6vuAuqcg1/kThcuCKAA7nYnVWTfQtE1W7WPXPcJY9zSLfOx/7eIj7JvKba4LZ/38u
         3TmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795569761; x=1796174561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wBb700J2WtgcJintm9bPNjmRy+i5hU5JB5stZCw0Ctc=;
        b=cy0uLL1151WtWF1aBi+BxY2HKV2Yj48aTv+NxK+UeTnLPc0BXySl5hJKUecyCNT27q
         aGCjqNrOdx1T9hwLrAK8qAGZk1o2MKE7oJbku+Xwc1U4ztoQGMjYXiWQy3/KvUlJ3ZG8
         f08TMnCYe6UMzbriwlUv1vupfHzZ7oZZlovgwvPXFdJT2uIbFk/37ywMsqoUcNxr8vR7
         cNV+OXHfUqQ8iPjxnbJ7qVzNMcE1vuvBdeqMup5IyxLrECy25oOEx/Co38pvPNaWvvz1
         XO5eerwVB8UFhmIr4cEOOPdkPpcQVikcmKaqNOClvL9rZy+szeJP+im4TQXRNwsukLTv
         tpwQ==
X-Forwarded-Encrypted: i=1; AL+hErFM01b1T3yBgriPjc851KIVc801Pj7tlTBO2e8u3YAdj8xQF8Led2ruJlQ6JxK/BrWRYPd2Gj+2aps=@lists.linux.dev
X-Gm-Message-State: APuU4Z/N+B10InhREURmBU+b9mngrx5GYGtHr2PNTv+w8Mg0c+v9v9qD
	XyodB5d5Ymb0zUMrF4sMoPA3EO5B0zsbNmoL1vsgTVHpTlw97crAYFc35e0rv6izJwNU3QfF4ll
	DyQJqoOy0r1/eZRdtIGJd2xNpWG3LGOs=
X-Gm-Gg: AZFdTZcar0+GEqxzJGmjjxW7YQsyIBM0ugD1vYNKAyhXLTPEtp7WGPiZJArIDvlSkle
	F1jckL2wGYg0Y7PyHfHEBD4BAl3h/s2KSRDTDCK4p1P09BSeaC0KC68EEoGZoWJESDA4fWffzoD
	rwslBaJrzn6scGpyn1VlME9pRFAC//3uJHg+1dt5tf/SEsOPPFZ5xrXKuZ7UgnVwgjH3INjhU6J
	ueteFiG+AumxC9+a0IG97g9ynLxK/gdyTxxF8UlJMW5wljbf2OzspNQ94Dye5g0pl3uFxO9jnqa
	hWj3YjfbsWhmCC/0x8/IwstKG6MyMC2re0lE1jROmiiNDywD+qh5NqSxtygLaWgeAlewhSrSBlD
	z6rQFZYnFk4UDnUgBNSn4N8RcE7H2kp43yVhAcy19AFURCowPx5OdDdqqVCeLmWIfJbE5C4+ZMh
	Lfa9U7iWZpLjn5vyw20A==
X-Received: by 2002:a05:600c:5493:b0:4a2:8c5:5e5 with SMTP id
 5b1f17b1804b1-4bb8881c734mr350939475e9.7.1795569760905; Tue, 24 Nov 2026
 17:22:40 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261124224811.16134-1-ihor.solodrai@linux.dev> <20261124224811.16134-4-ihor.solodrai@linux.dev>
In-Reply-To: <20261124224811.16134-4-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Nov 2026 17:22:29 -0800
X-Gm-Features: Aa3M54q8Trab9quQKhC5f2at7VXnaAA7kfZDQwmXG2hT5D3Ppp2dWKZ_6jwqsaA
Message-ID: <CAEf4Bzbb56=rgiOJMypPehsfWRfcCSb31_RaZfGAcw+eQUNjmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] libbpf: Resolve kfunc variants by prototype
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu <song@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 2:48=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> libbpf resolves a kfunc declaration by exact name, after dropping its
> last ___ suffix, and only then checks the prototype. The name alone
> picks the kernel function, so the kernel can't serve both prototypes of
> a changed kfunc. For example, vmlinux.h declares:
>
>   bool scx_bpf_dsq_move_to_local(u64 dsq_id);
>   bool scx_bpf_dsq_move_to_local___v2(u64 dsq_id, u64 enq_flags);
>
> libbpf resolves the second to scx_bpf_dsq_move_to_local() and rejects
> its prototype. Keeping the old prototype as ___v1 and giving the new
> one the unsuffixed name would break old declarations the same way.
>
> Select a kfunc in two steps instead:
>
>   1. Collect the functions in vmlinux and module BTFs with the same
>      essential name as the declaration, as CO-RE does for types. The
>      "bpf_kfunc" decl tag is ignored.
>
>   2. Resolve the candidate with a compatible prototype. If there is
>      none, a __weak kfunc stays unresolved. More than one is an error,
>      even for a __weak kfunc.
>
> The prototype check is stricter than bpf_core_types_are_compat(). It
> also compares the names of structs, unions and forward declarations,
> ignoring ___ suffixes. Members aren't compared. Typedefs and qualifiers
> are skipped. For example:
>
>   typedef struct foo foo_t;
>
>   void kfunc(struct foo *arg);
>   void kfunc(struct foo___local *arg);
>   void kfunc(foo_t *arg);
>
> are compatible, but not with:
>
>   void kfunc(struct bar *arg);
>
> So a declaration with an outdated struct name no longer resolves. For
> example, commit 8740156ad33b ("bpf: Require a BPF cpumask for
> bpf_cpumask_populate()") changed:
>
>   before: int bpf_cpumask_populate(struct cpumask *, void *, size_t);
>   after:  int bpf_cpumask_populate(struct bpf_cpumask *, void *, size_t);
>
> Each declaration now resolves only on a kernel with the same prototype.
> A stacked suffix, as in foo___v2___compat, no longer resolves foo___v2,
> because its essential name is foo___v2. compat.bpf.h now tries foo___v2
> first.
>
> Module BTFs are now loaded for every object with kfuncs: 0.5 and 1.4 ms
> for 8 and 32 small modules in a VM. Lookup cost per kfunc:
>
>                         before (hit / miss)   after
>   sorted, 23 modules    0.14 / 0.65 us        0.8 us
>   unsorted (v6.18)      0.1 / 0.5 ms          0.7 ms

for CO-RE relocations, when we search for candidate types, I think we
follow a different logic: if we find at least one candidate in vmlinux
BTF, we don't go searching for module BTF. See bpf_core_find_cands().
I think we should try doing the same here, instead of potentially
opening tons of irrelevant BTFs.

So far this logic worked adequately, I think for kfuncs it will be
good enough as well. We can still support case where module provides a
newer kfunc version, in this case we won't find any matching candidate
in vmlinux, then will continue looking for candidates across modules,
right?

pw-bot: cr


>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/lib/bpf/btf.c             |  99 +++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.c          | 112 ++++++++++++++++++++++----------
>  tools/lib/bpf/libbpf_internal.h |   2 +
>  tools/lib/bpf/libbpf_tools.h    |   2 +
>  4 files changed, 178 insertions(+), 37 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index a4bf01403a43..71cba0b9bbfe 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1140,7 +1140,7 @@ static void btf_check_sorted(struct btf *btf)
>  }
>
>  static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const =
char *name,
> -                                          __s32 start_id)
> +                                          size_t name_len, __s32 start_i=
d)
>  {
>         const struct btf_type *t;
>         const char *tname;
> @@ -1152,7 +1152,7 @@ static __s32 btf_find_type_by_name_bsearch(const st=
ruct btf *btf, const char *na
>                 m =3D l + (r - l) / 2;
>                 t =3D btf_type_by_id(btf, m);
>                 tname =3D btf__str_by_offset(btf, t->name_off);
> -               if (strcmp(tname, name) >=3D 0) {
> +               if (strncmp(tname, name, name_len) >=3D 0) {
>                         if (l =3D=3D r)
>                                 return r;
>                         r =3D m;
> @@ -1164,6 +1164,99 @@ static __s32 btf_find_type_by_name_bsearch(const s=
truct btf *btf, const char *na
>         return btf__type_cnt(btf);
>  }
>
> +/*
> + * Set [*start, *end) to the range of own type IDs that may match the
> + * first name_len bytes of name. For unsorted BTF, include all own type =
IDs.
> + */
> +void btf_name_prefix_range(const struct btf *btf, const char *name, size=
_t name_len,
> +                          __u32 *start, __u32 *end)
> +{
> +       __u32 i, n =3D btf__type_cnt(btf);
> +
> +       if (btf->named_start_id <=3D 0) {
> +               *start =3D btf->start_id;
> +               *end =3D n;
> +               return;
> +       }
> +       *start =3D btf_find_type_by_name_bsearch(btf, name, name_len, btf=
->named_start_id);
> +       for (i =3D *start; i < n; i++) {
> +               const struct btf_type *t =3D btf_type_by_id(btf, i);
> +               const char *tname =3D btf__str_by_offset(btf, t->name_off=
);
> +
> +               if (strncmp(tname, name, name_len) !=3D 0)
> +                       break;
> +       }
> +       *end =3D i;
> +}
> +
> +static __u16 kfunc_type_kind(const struct btf_type *t)
> +{
> +       if (btf_is_fwd(t))
> +               return btf_kflag(t) ? BTF_KIND_UNION : BTF_KIND_STRUCT;
> +       if (btf_is_enum64(t))
> +               return BTF_KIND_ENUM;
> +       return btf_kind(t);
> +}
> +
> +/*
> + * Return 1 if the types match, 0 if they don't, or -EINVAL if a type
> + * can't be looked up or the types nest deeper than depth.
> + */
> +static int kfunc_type_match(const struct btf *a, __u32 a_id,
> +                           const struct btf *b, __u32 b_id, int depth)
> +{
> +       const struct btf_type *at =3D skip_mods_and_typedefs(a, a_id, NUL=
L);
> +       const struct btf_type *bt =3D skip_mods_and_typedefs(b, b_id, NUL=
L);
> +       __u16 kind;
> +       int i, ret;
> +
> +       if (!at || !bt || !depth)
> +               return -EINVAL;
> +
> +       kind =3D kfunc_type_kind(at);
> +       if (kind !=3D kfunc_type_kind(bt))
> +               return 0;
> +
> +       switch (kind) {
> +       case BTF_KIND_STRUCT:
> +       case BTF_KIND_UNION: {
> +               const char *an =3D btf__name_by_offset(a, at->name_off);
> +               const char *bn =3D btf__name_by_offset(b, bt->name_off);
> +               size_t name_len =3D bpf_core_essential_name_len(an);
> +
> +               return name_len =3D=3D bpf_core_essential_name_len(bn) &&
> +                      strncmp(an, bn, name_len) =3D=3D 0;
> +       }
> +       case BTF_KIND_UNKN:
> +       case BTF_KIND_ENUM:
> +               return 1;
> +       case BTF_KIND_INT:
> +               return btf_int_offset(at) =3D=3D 0 && btf_int_offset(bt) =
=3D=3D 0;
> +       case BTF_KIND_PTR:
> +               return kfunc_type_match(a, at->type, b, bt->type, depth -=
 1);
> +       case BTF_KIND_ARRAY:
> +               return kfunc_type_match(a, btf_array(at)->type, b, btf_ar=
ray(bt)->type, depth - 1);
> +       case BTF_KIND_FUNC_PROTO:
> +               if (btf_vlen(at) !=3D btf_vlen(bt))
> +                       return 0;
> +               for (i =3D 0; i < btf_vlen(at); i++) {
> +                       ret =3D kfunc_type_match(a, btf_params(at)[i].typ=
e,
> +                                              b, btf_params(bt)[i].type,=
 depth - 1);
> +                       if (ret <=3D 0)
> +                               return ret;
> +               }
> +               return kfunc_type_match(a, at->type, b, bt->type, depth -=
 1);
> +       default:
> +               return 0;
> +       }
> +}
> +
> +int btf_kfunc_proto_match(const struct btf *a, __u32 a_id,
> +                         const struct btf *b, __u32 b_id)
> +{
> +       return kfunc_type_match(a, a_id, b, b_id, 32);
> +}
> +
>  static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
>                                    const char *type_name, __s32 kind)
>  {
> @@ -1185,7 +1278,7 @@ static __s32 btf_find_by_name_kind(const struct btf=
 *btf, int start_id,
>
>         if (btf->named_start_id > 0 && type_name[0]) {
>                 start_id =3D max(start_id, btf->named_start_id);
> -               id =3D btf_find_type_by_name_bsearch(btf, type_name, star=
t_id);
> +               id =3D btf_find_type_by_name_bsearch(btf, type_name, strl=
en(type_name), start_id);
>                 for (; id < nr_types; id++) {
>                         t =3D btf__type_by_id(btf, id);
>                         tname =3D btf__str_by_offset(btf, t->name_off);
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1efc0dd37b2e..dadf446daa0b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -641,7 +641,6 @@ struct extern_desc {
>         int btf_id;
>         int sec_btf_id;
>         char *name;
> -       char *essent_name;
>         bool is_set;
>         bool is_weak;
>         union {
> @@ -4446,7 +4445,6 @@ static int bpf_object__collect_externs(struct bpf_o=
bject *obj)
>         struct extern_desc *ext;
>         int i, n, off, dummy_var_btf_id;
>         const char *ext_name, *sec_name;
> -       size_t ext_essent_len;
>         Elf_Scn *scn;
>         Elf64_Shdr *sh;
>
> @@ -4498,14 +4496,6 @@ static int bpf_object__collect_externs(struct bpf_=
object *obj)
>                 ext->sym_idx =3D i;
>                 ext->is_weak =3D ELF64_ST_BIND(sym->st_info) =3D=3D STB_W=
EAK;
>
> -               ext_essent_len =3D bpf_core_essential_name_len(ext->name)=
;
> -               ext->essent_name =3D NULL;
> -               if (ext_essent_len !=3D strlen(ext->name)) {
> -                       ext->essent_name =3D strndup(ext->name, ext_essen=
t_len);
> -                       if (!ext->essent_name)
> -                               return -ENOMEM;
> -               }
> -
>                 ext->sec_btf_id =3D find_extern_sec_btf_id(obj->btf, ext-=
>btf_id);
>                 if (ext->sec_btf_id <=3D 0) {
>                         pr_warn("failed to find BTF for extern '%s' [%d] =
section: %d\n",
> @@ -9513,41 +9503,96 @@ static int bpf_object__resolve_ksym_var_btf_id(st=
ruct bpf_object *obj,
>         return 0;
>  }
>
> +/* t is a FUNC whose essential name is the first name_len bytes of name =
*/
> +static bool btf_is_kfunc_candidate(const struct btf *btf, const struct b=
tf_type *t,
> +                                  const char *name, size_t name_len)
> +{
> +       const char *tname;
> +
> +       if (!btf_is_func(t))
> +               return false;
> +       tname =3D btf__name_by_offset(btf, t->name_off);
> +       if (strncmp(tname, name, name_len) !=3D 0)
> +               return false;
> +       return bpf_core_essential_name_len(tname) =3D=3D name_len;
> +}
> +
> +/*
> + * Search vmlinux and module BTFs. Return:
> + *   - a BTF ID for a unique match;
> + *   - -ESRCH if the family is absent;
> + *   - -EINVAL if no candidate has a compatible prototype;
> + *   - -ENOTUNIQ if more than one candidate has a compatible prototype.
> + */
> +static int find_kfunc_btf_id(struct bpf_object *obj, const struct extern=
_desc *ext,
> +                            struct btf **res_btf, struct module_btf **re=
s_mod_btf)
> +{
> +       size_t name_len =3D bpf_core_essential_name_len(ext->name);
> +       int kfunc_id =3D 0, nr_cands =3D 0;
> +       size_t i;
> +
> +       for (i =3D 0; i <=3D obj->btf_module_cnt; i++) {
> +               struct module_btf *mod =3D i ? &obj->btf_modules[i - 1] :=
 NULL;
> +               struct btf *btf =3D mod ? mod->btf : obj->btf_vmlinux;
> +               __u32 id, end;
> +
> +               btf_name_prefix_range(btf, ext->name, name_len, &id, &end=
);
> +               for (; id < end; id++) {
> +                       const struct btf_type *t =3D btf__type_by_id(btf,=
 id);
> +
> +                       if (!btf_is_kfunc_candidate(btf, t, ext->name, na=
me_len))
> +                               continue;
> +                       nr_cands++;
> +                       if (btf_kfunc_proto_match(obj->btf, ext->ksym.typ=
e_id, btf, t->type) <=3D 0)
> +                               continue;
> +                       if (kfunc_id)
> +                               return -ENOTUNIQ;
> +                       kfunc_id =3D id;
> +                       *res_btf =3D btf;
> +                       *res_mod_btf =3D mod;
> +               }
> +       }
> +       if (!nr_cands)
> +               return -ESRCH;
> +       if (!kfunc_id)
> +               return -EINVAL;
> +       return kfunc_id;
> +}
> +
>  static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
>                                                 struct extern_desc *ext)
>  {
> -       int local_func_proto_id, kfunc_proto_id, kfunc_id;
>         struct module_btf *mod_btf =3D NULL;
>         const struct btf_type *kern_func;
>         struct btf *kern_btf =3D NULL;
> -       int ret;
> +       int kfunc_id, ret;
>
> -       local_func_proto_id =3D ext->ksym.type_id;
> +       ret =3D load_module_btfs(obj);
> +       if (ret)
> +               return ret;
>
> -       kfunc_id =3D find_ksym_btf_id(obj, ext->essent_name ?: ext->name,=
 BTF_KIND_FUNC, &kern_btf,
> -                                   &mod_btf);
> -       if (kfunc_id < 0) {
> -               if (kfunc_id =3D=3D -ESRCH && ext->is_weak)
> +       kfunc_id =3D find_kfunc_btf_id(obj, ext, &kern_btf, &mod_btf);
> +       if (kfunc_id =3D=3D -ESRCH) {
> +               if (ext->is_weak)
>                         return 0;
>                 pr_warn("extern (func ksym) '%s': not found in kernel or =
module BTFs\n",
>                         ext->name);
>                 return kfunc_id;
>         }
> -
> -       kern_func =3D btf__type_by_id(kern_btf, kfunc_id);
> -       kfunc_proto_id =3D kern_func->type;
> -
> -       ret =3D bpf_core_types_are_compat(obj->btf, local_func_proto_id,
> -                                       kern_btf, kfunc_proto_id);
> -       if (ret <=3D 0) {
> +       if (kfunc_id =3D=3D -EINVAL) {
>                 if (ext->is_weak)
>                         return 0;
> -
> -               pr_warn("extern (func ksym) '%s': func_proto [%d] incompa=
tible with %s [%d]\n",
> -                       ext->name, local_func_proto_id,
> -                       mod_btf ? mod_btf->name : "vmlinux", kfunc_proto_=
id);
> -               return -EINVAL;
> +               pr_warn("extern (func ksym) '%s': no compatible prototype=
 in kernel or module BTFs\n",
> +                       ext->name);
> +               return kfunc_id;
>         }
> +       /* an error even for a weak kfunc: ambiguity isn't absence */
> +       if (kfunc_id =3D=3D -ENOTUNIQ) {
> +               pr_warn("extern (func ksym) '%s': more than one compatibl=
e prototype in kernel or module BTFs\n",
> +                       ext->name);
> +               return kfunc_id;
> +       }
> +       kern_func =3D btf__type_by_id(kern_btf, kfunc_id);
>
>         /* set index for module BTF fd in fd_array, if unset */
>         if (mod_btf && !mod_btf->fd_array_idx) {
> @@ -9579,8 +9624,9 @@ static int bpf_object__resolve_ksym_func_btf_id(str=
uct bpf_object *obj,
>          * {kernel_btf_id, kernel_btf_obj_fd} -> fixup ld_imm64.
>          */
>         ext->ksym.kernel_btf_obj_fd =3D mod_btf ? mod_btf->fd : 0;
> -       pr_debug("extern (func ksym) '%s': resolved to %s [%d]\n",
> -                ext->name, mod_btf ? mod_btf->name : "vmlinux", kfunc_id=
);
> +       pr_debug("extern (func ksym) '%s': resolved to %s '%s' [%d]\n",
> +                ext->name, mod_btf ? mod_btf->name : "vmlinux",
> +                btf__name_by_offset(kern_btf, kern_func->name_off), kfun=
c_id);
>
>         return 0;
>  }
> @@ -10441,10 +10487,8 @@ void bpf_object__close(struct bpf_object *obj)
>         zfree(&obj->btf_custom_path);
>         zfree(&obj->kconfig);
>
> -       for (i =3D 0; i < obj->nr_extern; i++) {
> +       for (i =3D 0; i < obj->nr_extern; i++)
>                 zfree(&obj->externs[i].name);
> -               zfree(&obj->externs[i].essent_name);
> -       }
>
>         zfree(&obj->externs);
>         obj->nr_extern =3D 0;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 8e6f15e2f1bf..389c48548222 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -215,6 +215,8 @@ struct btf_type *btf_type_by_id(const struct btf *btf=
, __u32 type_id);
>  void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
>  int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **id=
_map,
>                  __u32 **str_map);
> +void btf_name_prefix_range(const struct btf *btf, const char *name, size=
_t name_len,
> +                          __u32 *start, __u32 *end);
>  bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_=
type *t);
>
>  static inline enum btf_func_linkage btf_func_linkage(const struct btf_ty=
pe *t)
> diff --git a/tools/lib/bpf/libbpf_tools.h b/tools/lib/bpf/libbpf_tools.h
> index 5c8d6d0d2fdd..cd9137376d44 100644
> --- a/tools/lib/bpf/libbpf_tools.h
> +++ b/tools/lib/bpf/libbpf_tools.h
> @@ -52,6 +52,8 @@ struct bpf_core_cand;
>  struct bpf_core_cand_list;
>
>  const struct btf_header *btf_header(const struct btf *btf);
> +int btf_kfunc_proto_match(const struct btf *a, __u32 a_id,
> +                         const struct btf *b, __u32 b_id);
>  const char *btf_kind_str(const struct btf_type *t);
>  const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u=
32 id, __u32 *res_id);
>
> --
> 2.56.0
>
>
