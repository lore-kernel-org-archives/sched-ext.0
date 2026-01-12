Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32EC36E47D
	for <sched-ext@lists.linux.dev>; Mon, 12 Jan 2026 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236721; cv=none; b=CKhCm/CdR86cQPbPsI7eS40u9ZX1yHfs/0tA6QMCiQ9WEQ26AZGs+69g2/Qe6UaJVqYYpLrZ65bc5TRSYBDw2rq3Eymc6T/48yFjTLqQR0Bd1WJTQZzBZyg67Sgc5sSTlvVpB9rzT7hN3lR7pOYaJJ2GVvEYTHewnOsC0q+dmlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236721; c=relaxed/simple;
	bh=oPWEAISgUGdw2XwaK6Mfd29eUN8CUkv+wYN3SSiDp4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8KvHLpNJG1dJzf7WN59g0ETja4SpnbsKw5KX8G58knPMFcKDZHnyDgCFmQUsiqf77T9c5PzUIX+0SswZaw8EiGiDXjSjWYbFYrKArAc0YGcMtEyJBdwEkQcc2u/W7XdJy7Ip07XiVMs3vz5M0OdT8NvwFXgmjzx627663msgDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpT4GiTt; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpT4GiTt"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c2dd0c24e5cso2806167a12.3
        for <sched-ext@lists.linux.dev>; Mon, 12 Jan 2026 08:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768236716; x=1768841516; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOeoOwMHmDzbGFKbniEOK8z4y4bC2uWodfWgqo8H1Yw=;
        b=GpT4GiTtzYrRn1bZcFNlroQ9EC19PvwFo604hT2oaFwuB72R0Ei0WNfKiE3Jny1CVI
         kBIjFrtyXiFBODDnbmjDq3fTwffkbZcWn/TddfOxe3/D+XbnOoURIbbw2JRD1MsY2fVw
         XJ1MPYTDqknN6lMnLqNQpIT1n/KnuO7ggp+KJlLYugXdNiej7tjZDVgoCKQs3VBiGafM
         ZH4THL3IZs+e4fZTe8DvZW/IM8zqxRDasTUfsDHAq/Lzk2eQJP9ZMK2Bb0+RXvwwn1im
         /PT3M0UmwYUGCZ/ehUgpUvHGPn1/9e6ActCR2E7Ac88c/YNpwrtb5aAP+qT+x3TsAcVR
         lT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768236716; x=1768841516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NOeoOwMHmDzbGFKbniEOK8z4y4bC2uWodfWgqo8H1Yw=;
        b=E15lGhzTNBVqVLIgfVP4m/KKgpqDcBjKZOrS3nNDZc70hiG81IkVBMW/4ELUpa1LfK
         K1YSnUGgSK25xPp/xJMxJUUq6rXq8PMA73tALoV1sY4fC12MPWL/pWcYTMP0w3JcyfZh
         XqinsjNad7kuICl9WxURjyMPQQKv+kyYQoj/QAAClYH/aN9nDSSQ+6iU6o9WSAJwAZ3F
         blnRtRH9NCcg421zlBxo9O1dPCtZAdHO6bsjTI9sVojUAqBMamhYTxzlIyK9YtR6jhhf
         1Xt68XaLoHxiaEYBmc4KGTo5W7I0/sICYYVL96AIJp896cZprNZGSfT5qNfN6LK6QZ+3
         wyMg==
X-Forwarded-Encrypted: i=1; AJvYcCXyePIILbz/t0eSWXP3cVMnzaVW/ryUb5RRXnj1IzSy98QPkKEvvss7SEvxhVC/mIyWYWZHoPGzOT8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzjsLt1YzUy+JC2DYJ9G8GEPIrl87VrxviVib0awQ8D3YzNMpy1
	ARRI8Qmt/eVSIFW3XJb7oGB3cIcjwmGM/VIcEqftj140RP10Hd6cpyU7EXd9/bWQWFPx2fvcnjA
	BViZMAXZznk8FDOgNA5RmiHBNb7XFHUU=
X-Gm-Gg: AY/fxX6f0Qc3RdeTi4JHabzThQRmDAL6B9Rl4CA4J5Ii2Y+qBPv9cOvxdkd1AX1j5Qe
	SICC0LeK0tdflrq3YHav9Vo8FYs6aTySIFDug4c4+9W/s4RgaAjBAAxMjTMjzfNxIPfCeVcxMNb
	fdBZZdT8HIXNhHDYfTfTdOhHMM7rx1AXco3YrdWzdStQyTXqsoClm3J5PLUCEEJ8hIqQ00R0Z7I
	Ga35ftj6dJClz5WqdO2wnRhI8g03te8czhasNx+36pLkqsFE2cuRjC/nQyTXLKGaR3AI74342Jv
	b/ttJlTuFs4=
X-Google-Smtp-Source: AGHT+IHpcL/jrMfaVKYVv2Vmo4D4Rsx+43kF3ghLcsFje4ny2P6YGshIuc0++jR6THqTUOsnyix/wK3BvYdpoDPAuLM=
X-Received: by 2002:a17:90b:4a03:b0:34c:7183:e290 with SMTP id
 98e67ed59e1d1-34f68cb9059mr15734618a91.31.1768236716105; Mon, 12 Jan 2026
 08:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-5-ihor.solodrai@linux.dev> <CAEf4BzYcZ5pLCvfn8uWiKCjpBXBw9dxR_WZnKxVz1Bhf96xOGg@mail.gmail.com>
 <2ea17ba8-3248-4a01-8fed-183ce66aa39c@linux.dev>
In-Reply-To: <2ea17ba8-3248-4a01-8fed-183ce66aa39c@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Jan 2026 08:51:43 -0800
X-Gm-Features: AZwV_Qg0FelBjTSuRjxLeKGaPcvF08JVWSwy_aAsOkGDzWQ7k8l8Eu_znO2CnnE
Message-ID: <CAEf4BzYuchyyw9M6eQo0Gou=09PcM-o_Ay7D8DM1gDitiG6Tbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 04/10] resolve_btfids: Support for KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 5:15=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 1/9/26 3:25 PM, Andrii Nakryiko wrote:
> > On Fri, Jan 9, 2026 at 10:49=E2=80=AFAM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> Implement BTF modifications in resolve_btfids to support BPF kernel
> >> functions with implicit arguments.
> >>
> >> For a kfunc marked with KF_IMPLICIT_ARGS flag, a new function
> >> prototype is added to BTF that does not have implicit arguments. The
> >> kfunc's prototype is then updated to a new one in BTF. This prototype
> >> is the intended interface for the BPF programs.
> >>
> >> A <func_name>_impl function is added to BTF to make the original kfunc
> >> prototype searchable for the BPF verifier. If a <func_name>_impl
> >> function already exists in BTF, its interpreted as a legacy case, and
> >> this step is skipped.
> >>
> >> Whether an argument is implicit is determined by its type:
> >> currently only `struct bpf_prog_aux *` is supported.
> >>
> >> As a result, the BTF associated with kfunc is changed from
> >>
> >>     __bpf_kfunc bpf_foo(int arg1, struct bpf_prog_aux *aux);
> >>
> >> into
> >>
> >>     bpf_foo_impl(int arg1, struct bpf_prog_aux *aux);
> >>     __bpf_kfunc bpf_foo(int arg1);
> >>
> >> For more context see previous discussions and patches [1][2].
> >>
> >> [1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38=
c9@linux.dev/
> >> [2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai=
@linux.dev/
> >>
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >> ---
> >>  tools/bpf/resolve_btfids/main.c | 282 +++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 282 insertions(+)
> >>
> >> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfid=
s/main.c
> >> index df39982f51df..b361e726fa36 100644
> >> --- a/tools/bpf/resolve_btfids/main.c
> >> +++ b/tools/bpf/resolve_btfids/main.c
> >> @@ -152,6 +152,18 @@ struct object {
> >>         int nr_typedefs;
> >>  };
> >>
> >> +#define KF_IMPLICIT_ARGS (1 << 16)
> >> +#define KF_IMPL_SUFFIX "_impl"
> >> +#define MAX_BPF_FUNC_REG_ARGS 5
> >> +#define MAX_KFUNCS 256
> >> +#define MAX_DECL_TAGS (MAX_KFUNCS * 4)
> >
> > can't we get that from include/linux/bpf.h? seems like
> > resolve_btfids's main.c include internal headers just fine, so why
> > duplicate definitions?
>
> Hi Andrii, thank you for a quick review.
>
> Including internal include/linux/btf.h directly doesn't work, which is
> probably expected.
>
> resolve_btfids is currently built with:
>
> HOSTCFLAGS_resolve_btfids +=3D -g \
>           -I$(srctree)/tools/include \
>           -I$(srctree)/tools/include/uapi \

so I don't know if that will solve the issue, but I don't think it
makes sense to build resolve_btfids using tools' version of includes.
tools/include is mostly for perf's benefit (maybe so that they don't
accidentally take some kernel-internal dependency, not sure). But
resolve_btfids is built for the kernel during the kernel build, we
should have access to full kernel headers. Try changing this and see
if build errors go away?

>           -I$(LIBBPF_INCLUDE) \
>           -I$(SUBCMD_INCLUDE) \
>           $(LIBELF_FLAGS) \
>           -Wall -Werror
>
> If I add -I$(srctree)/include option and then
>
>     #include <linux/btf.h>
>
> A bunch of build errors happen.
>
> AFAIU we'd have to create a stripped copy of relevant headers in
> tools/include first.  Is that what you're suggesting?

see above, the opposite -- just use -I$(srctree)/include directly

[...]

> >> +               addr =3D id->addr[0];
> >> +               off =3D addr - obj->efile.idlist_addr;
> >> +               set8 =3D data->d_buf + off;
> >> +
> >> +               for (i =3D 0; i < set8->cnt; i++) {
> >> +                       if (set8->pairs[i].flags & flags) {
> >
> > invert condition and continue, reduce nesting?
> >
> >> +                               if (nr_kfuncs >=3D kfunc_ids_sz) {
> >
> > it's silly to set static limits like this: we are not in NMI, you have
> > memory allocator, use it
>
> I kinda like that btf2btf_context is stack allocated, but I see your
> point. It's not necessary to set hard limits in resolve_btfids.
>

I don't think we'll notice the performance difference. We had similar
statically-sized things for BTF processing in pahole, and very quickly
ran into limitations and had to change them to dynamically allocated.
Let's not do this again. realloc() is a bit more annoying to use, but
no big deal, it's C after all.

> >
> >> +                                       pr_err("ERROR: resolve_btfids:=
 too many kfuncs with flags %u - limit %d\n",
> >> +                                              flags, kfunc_ids_sz);
> >> +                                       return -E2BIG;
> >> +                               }
> >> +                               kfunc_ids[nr_kfuncs++] =3D set8->pairs=
[i].id;

[...]

> >> +               err =3D btf__add_decl_tag(btf, tag_name, new_func_id, =
-1);
> >
> > decl_tag can apply to arguments as well (that -1 will be actually >=3D
> > 0), we should copy those as well, no?
>
> I think you're right. Technically decl_tags can point to parameters as
> well.  Is this actually used in kernel BTF?

I don't remember, but it doesn't matter. We have to clone them as well.

>
> For the type tags we don't have to do anything though, because the
> param type should point to the top type tag, right?

Yeah, type tags are part of type chains, if we reuse types, we'll be
reusing type_tags.

>
> >
> >> +               if (err < 0) {
> >> +                       pr_err("ERROR: resolve_btfids: failed to add d=
ecl tag %s for %s\n",
> >> +                              tag_name, tmp_name);
> >> +                       return -EINVAL;
> >> +               }
> >> +       }
> >> +

[...]
