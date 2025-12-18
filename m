Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D32285C80
	for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766092520; cv=none; b=ALBjtLVZliL1ySciiR7EHxbPUjSnweS/sE739Pynhm56DQTVVY6I+gYU5B1AwJ5E9LIysCVvOo8+CMXc7rH1QZGpDtPXmrpVEXeRNn6PFkUJsMEaBD0aJ1ykIOVJAHHkyqJc9TZYsoluXwec6oI4yhqO6YQd1Ojdk3T/mJAQ7qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766092520; c=relaxed/simple;
	bh=+u/ndDGOy2lwYXuLEGONv5mRvTF27BKeHvqNtnHgUXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLerFU6D6f1oxbzAoZLxL2rSy3JtrrEd3bhVbqJiSu4YylVyndlWF/K2r32iFa9YmkCopgbewN1R2y4jiJmrx8PMRBC+3vFVcjSjJeo/Mi0we9qFEwmdbzQ2QjB8T+Gv8YxNvTyBEfmMrP0m490vbvDE5NPtNvaeYzhOyJG34eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwDlmyQV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwDlmyQV"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34abc7da414so999636a91.0
        for <sched-ext@lists.linux.dev>; Thu, 18 Dec 2025 13:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766092512; x=1766697312; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeHvMoDV0MwvWoUgAdr9jy+27FmRxctXzz6auzWCwT0=;
        b=BwDlmyQV+dkrEllCgL/mhE55tI2uno3/v5igHdf4C5mTSk99cLvYyX6FqC8EpqhGcj
         tByuM2w0k7wtU2mO5vZQJ+6FscohxD21QVvVMd/yiKyu+A/MzvCNo4xDt7VsEFdvCPm5
         k+tj1+dPxW4urersNnYSExMvbSo+f7HWoltnTJYuncyJPtjghfVpbNLdDtDcUCGCiZX1
         zbL8igcEbOV/K/IKnpGRzy98pJ+z/eiFhhAhjyRXmIARcb6QCfY3KhSNwe99nowPup55
         rbbrJvxQwK+wEoIhpYXyYTQ1o9nsH6jl/uMSrXcpO4dPIslxhzFEx5Vw/gWCt3GyWke5
         ySmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766092512; x=1766697312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KeHvMoDV0MwvWoUgAdr9jy+27FmRxctXzz6auzWCwT0=;
        b=rXM2t0HIvHd48jeE2Q42ICip9MYyo+cd7p1nPJw1vUSf7pXgO+mz58Ed3ylvQbgscF
         d4fKmFNjnjn1wUhSBqKBpnkuMt2gmhcbNydkW8Crn/qM3YTY41558AzOg/KrvMF4cbGw
         XEQ8D/uaIqDZVCe3MUnz9LZ5xqesVOxKar2WoCG9xvbwBQuuT5Xl7ywVWKS2RchGBNm/
         Mt4e4mbkGEs5cAGrMgRPwbOrZ+cXejyGFv3QjFhNTCBH7D8kedyVoJOwdurbzrF8IUzy
         NzaOJ7/4klTZiWcLMV2NeT5hKB2vTtvV8uHbLrtu7NlE4wNgALYDtomQyJ98yVoDQ1rl
         kqIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwsaRPGlG0PiwKu1uFkvpPl8N3fgp15L78HzoWMsm8B6HdulJQr8wkiFtNNEBgMlcw/TOM7KodY60=@lists.linux.dev
X-Gm-Message-State: AOJu0YyfZTBV+5AxqUESPLYAjYejF4FC9OE5pLfgqccziB5Qee/500Qz
	p8EXmOBiiCsNCLILFCBDR/JNuwV6qbZyVbT173Xuhp2jXFqyVtIntr4TRam7QnN58pb+mi5VmGn
	NwdC3kXhy5NlBebACKRRk2jMvCx/cR4Q=
X-Gm-Gg: AY/fxX5PaXIbiswW1giLJiGgf2LjPdsy0JYyy7CiJrTuaZMJ1dS3d7iFA8ePjz7rsKW
	jWOLW3R6J1n1HilRaDtGCXLmyc+iA3XIEWs6LSHmX/6w6UseR0yXlikRuyiVQHj+GDlqHcTGyRy
	pmcsnM8AQlhx7ZoYJmwamDgjwLr5wIJL2Ki1FOIotrLxctiVkZBw9cUd6RcQBFdmC5r1t6vLg14
	OqJ9yeyLFHPHZQ3csqChbdlEA0uyODVjWRMW4V5LjuBYzgosOEioX7GWXQb35H85qInIJUiTFhk
	2OxetmUnWQE=
X-Google-Smtp-Source: AGHT+IEm3NVQEyLOx1ZLRWTiMXhCy/qfbgPRFyUTvXpjkk44dBjMEz9r6YNUjYCIBztbo3i6KidyFHyedRAP9nmcsxQ=
X-Received: by 2002:a17:90b:56cc:b0:34a:a1dd:1f2a with SMTP id
 98e67ed59e1d1-34e921ad800mr512802a91.20.1766092512329; Thu, 18 Dec 2025
 13:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
 <20251218003314.260269-9-ihor.solodrai@linux.dev> <914f4a97-f053-4979-b63a-9b7a7f72369a@linux.dev>
In-Reply-To: <914f4a97-f053-4979-b63a-9b7a7f72369a@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 13:15:00 -0800
X-Gm-Features: AQt7F2rLX8p5L_SWnAJnu2v6iF529lekiXcU8Qp40l-At9Q7hbzFSO_mSE-UP_c
Message-ID: <CAEf4BzZA4czi1KEOrW9tn8v18LZN4FAqzrHyB_78VatEZhb+Fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 8/8] resolve_btfids: Change in-place update
 with raw binary output
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrea Righi <arighi@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Bill Wendling <morbo@google.com>, Changwoo Min <changwoo@igalia.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, David Vernet <void@manifault.com>, 
	Donglin Peng <dolinux.peng@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nsc@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Tejun Heo <tj@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	dwarves@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 9:54=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 12/17/25 4:33 PM, Ihor Solodrai wrote:
> > [...]
> > diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > index 840a55de42da..b8569d450ed9 100644
> > --- a/scripts/Makefile.btf
> > +++ b/scripts/Makefile.btf
> > @@ -1,5 +1,10 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > +gen-btf-y                            =3D
> > +gen-btf-$(CONFIG_DEBUG_INFO_BTF)     =3D $(srctree)/scripts/gen-btf.sh
> > +
> > +export GEN_BTF :=3D $(gen-btf-y)
> > +
>
> Ugh... GEN_BTF is not used anywhere in v4.
> Looks like I forgot a `git add` at some point.
>
> I'll wait a bit before sending a v5, in case there is more feedback.

It all looks good to me, so don't wait for any more feedback from my
side. If Eduard doesn't find anything in patch #8, please send new
revision, thanks!

>
> >  pahole-ver :=3D $(CONFIG_PAHOLE_VERSION)
> >  pahole-flags-y :=3D
> >
> > @@ -18,13 +23,15 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)  =
=3D -j$(JOBS) --btf_features=3Denc
> >
> >  pahole-flags-$(call test-ge, $(pahole-ver), 130) +=3D --btf_features=
=3Dattributes
> >
> > -ifneq ($(KBUILD_EXTMOD),)
> > -module-pahole-flags-$(call test-ge, $(pahole-ver), 128) +=3D --btf_fea=
tures=3Ddistilled_base
> > -endif
> > -
> >  endif
> >
> >  [...]
>
