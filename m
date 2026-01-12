Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37C2BEC55
	for <sched-ext@lists.linux.dev>; Mon, 12 Jan 2026 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768257810; cv=none; b=BGWAVxFVjUevrPE4OtIGT0o0IEdE6Uolk8qySyPxqdMVUKZw8Tt8CsRrvFnF5JADuIBQmU6RW6s1PuIPHCvi3edCsO43Dgg1V1kKiXS2H1vi0okL7fQSif3docptl4DtcR8NvyUznmMogPfEX6aNyup/tsUzzqP04d/9qrM6mr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768257810; c=relaxed/simple;
	bh=0Ga4046PoD1QjORJ8x9YGyeaqSw2W7pHCfFHrwB+sqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgvTs3FVDPrDNEu6DPNsDkxEW+ZWkNSOelpd+Vq4r/FuDO7ufqvHPt386NChTkOaPIqdDlc4zmoeG/0VmklmS7ciXNt5zn+F40sHnabZu5ycu5bcW8EI0atqiX3lSZPFZaZPMqHVshDvAkIxV+YrM0yedZOyXbz92BeZ6Z7nr9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZjL+hHv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZjL+hHv"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c565b888dso5856349a91.0
        for <sched-ext@lists.linux.dev>; Mon, 12 Jan 2026 14:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768257808; x=1768862608; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGobhM5gknftRAivxeGEAO6mhAVtTPpcYFMxFViT17s=;
        b=VZjL+hHvKZaszsv/Em5O+DaqMz94MSVushTv8+llnRfyV++jdRXc8ECOYvN01jAekG
         Jgy1WBSUQZ5DyKz3+i1TyUpw6QSt9AASI3RKF/Aw2opvYg50YJY7wIMTKNe1g7Uvhzhp
         ajPb6ZJqaVpoqbjgrJ8z3kP2HJXQ0rGiU5fiMXkNIWBQl7sDnV3mXwf0AqzEQ+4NfxSW
         xXbpCGzsCegeFVHl81+Jn5/lvqrlKlGcEO+/sYOtpX9G2m7FPqFk0vnA7zEwfgPNCFJG
         yoony1twZroeqfTaTRkg7Nie69ooeMLkJj3Z1lYWBfcbb+8Q+kOE8uBHnzpK7ztwzeei
         Q6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768257808; x=1768862608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PGobhM5gknftRAivxeGEAO6mhAVtTPpcYFMxFViT17s=;
        b=tJs5SRKLmmj2SRKOcRbOnYP7ABS9PAOGpGDOnQSQiaP4b/ggltpPxwoC12kq/sfiTj
         zCFDzbLXh0SfkfU9QoZcYAWmcuHQf5/gNHesmGZSwdyttxqKdrB1rE7Xbbt1Xa+9CZ7Z
         mU6x/TlJvY1I9HBRVcxClrlrI41mTBcjmpUwTELvHPWpOxuB5+3X38HahnyP7FMuH73L
         Oq802/eLZ7UrbU4IIPmcamnmVZ1ZSCFlg37dNqvlwInSKJxw/EGjhXLc5ieR7vm3c96P
         S36w/V3aDAP8YAPPGFd1D0aeVne20b+BN1F4Pn38K5HsplCLd0kuZlYhvwWqp9hYrHJh
         QX6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqoQ4Ol5Um4DvJff8yOC5xg567TjdaASPvt+HX6/uhyB1qt5WMiV5Z86XIW81obll0SRP/Nou81Hk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyu4yLYBQHDPh6rZOipblqAS30F9tQwFuv2lVzCjJIHCALg07ac
	OiIcytUfeNq+lA4rQcM6JAj4tlUQbqC2fo8YAjEtGxaH0209CdQ4gLrwckhLeC8u5k1OsW28FF+
	OQRMDwAm4VV86naWPDnkBVPtf5tQ1jtA=
X-Gm-Gg: AY/fxX5IAj0tuMFiCc4e2iitMpv+3B23Z0ZEdleDlctJaQg2Fx2u4DJWMmvpWr7rahG
	XYlSulP5iadRmuSN3ZjHc/2Rrar6bP6AFaRKtvDYXa7wNM+qb6S6aaS+0ahh0dDG77dXo2Vxtk3
	tEKEP8w++J29Vy+vVm8H9cLl5sZdQQ9o2FBcNhtU98dABURXGma47B27fnNueCMeNJPjKPzhA1P
	UQeZBpx+/dvLDyK4H4R0AuXhcoP1aoBNEq3elcjGT3B/uTfAAeE4Icdd//olT+9IC6IrlRVy1pE
	1CepPSB9eb0=
X-Google-Smtp-Source: AGHT+IHUazrPlEet43khWdyf1XxNCYUu5w5+tqtqvaSnOm9KMVvJkpgW6G3rA/Hm6dlK5sFlWJd5odNJwJX0gdLy7xE=
X-Received: by 2002:a17:90b:38cd:b0:340:ad5e:cb with SMTP id
 98e67ed59e1d1-34f68b8325amr16854677a91.8.1768257808289; Mon, 12 Jan 2026
 14:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-9-ihor.solodrai@linux.dev> <CAADnVQJDv80_T+1jz=7_8y+8hRTjMqqkm38in2er8iRU-p9W+g@mail.gmail.com>
 <b099a95e-5e69-4eeb-a2c9-9a52b8042a85@linux.dev> <CAADnVQ+_AmiwuupkVJTGyKY3KOp68GLuivs2LMEr0M_yaHPUUg@mail.gmail.com>
 <0c4d84ab-1725-45bc-9c1c-8bdc1f5fc032@linux.dev> <CAADnVQ+k-nbq-2PGRSPJDRZ3G9sp9zu3Owqsj7zqO_G+3OQEww@mail.gmail.com>
 <f0e63b55-65c3-4367-b3da-275df18147a1@linux.dev> <3a697699-ffcb-4e2f-a7a4-9e3f571aa402@linux.dev>
In-Reply-To: <3a697699-ffcb-4e2f-a7a4-9e3f571aa402@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Jan 2026 14:43:15 -0800
X-Gm-Features: AZwV_QjU-ODZg1GeGIyYt8QDqUW_SFHA2LTq3XVJjopePVE88KAjYA43jKP0aL4
Message-ID: <CAEf4BzbgPfRm9BX=TsZm-TsHFAHcwhPY4vTt=9OT-uhWqf8tqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 08/10] bpf: Add bpf_task_work_schedule_*
 kfuncs with KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 10:54=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> On 1/9/26 1:56 PM, Ihor Solodrai wrote:
> > On 1/9/26 1:49 PM, Alexei Starovoitov wrote:
> >> On Fri, Jan 9, 2026 at 1:39=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>>
> >>> [...]
> >>>
> >>>> I feel bpf_task_work_schedule_resume() is ok to break, since it's so=
 new.
> >>>> We can remove bpf_task_work_schedule_[resume|singal]_impl()
> >>>> to avoid carrying forward forever.
> >>>>
> >>>> bpf_stream_vprintk_impl() is not that clear. I would remove it too.
> >>>
> >>> That leaves only bpf_wq_set_callback_impl(). Can we break that too?
> >>
> >> Sounds like Benjamin is ok removing it.
> >> So I think we can indeed remove them all.
> >>
> >>> Then there won't be legacy cases at all. It was introduced in v6.16
> >>> along the with __prog suffix [1][2].
> >>>
> >>> If we go this route, we could clean up __prog support/docs too.
> >>>
> >>> I think it's worth it to make an "all or nothing" decision here:
> >>> either break all 4 existing kfuncs, or backwards-support all of them.
> >>
> >> I don't see why "all or nothing" is a good thing.
> >> It won't be "all" anyway.
> >> We have bpf_rbtree_add_impl(), bpf_list_push_front_impl(), etc.
> >> And those we cannot remove. sched-ext is using them.
> >> Another few categories are bpf_obj_new_impl(), bpf_obj_drop_impl().
> >> There are not __prog type, but conceptually the same thing and
> >> KF_IMPLICIT_ARGS should support them too eventually.
> >
> > I was thinking we could remove/simplify code relevant to backwards
> > compat of existing _impl kfuncs. But you're right, if we start using
> > implicit args for other types/kfuncs, the "legacy" case still has to
> > work.
> >
> > Ok, in the next revision I'll remove all the __prog users, but leave
> > the "legacy" case support in place for future use.
>
> I just had an off-list chat with Andrii, and we agreed that leaving
> the existing _impl kfuncs supported may be a good idea.
>
> It doesn't cost us much: we keep the mechanism for legacy functions
> anyways, so supporting bpf_wq_set_callback_impl() and co only requires
> keeping definitions in the kernel.
>
> The only benefit of *removing* these _impl functions is that we could
> clean up __prog support.
>
> But having backwards compat seems like a better deal.
> What do you think?
>

I think that bit of __prog clean up might be worth doing after all.
The biggest difference for users if we remove _impl stuff from new
kernels would be an extra explicit xxx_impl kfunc declaration (it
won't come from vmlinux.h anymore) and then the following call pattern
(which probably will be hidden in the macro anyways):

if (xxx_impl)
    xxx_impl(..., NULL);
else
    xxx(...);


This will work on old and new kernels alike, so ok, let's just drop
all the _impl stuff. Can't do that for bpf_obj_new_impl() because
that's already used more widely, but for task_work, wq, stream -- they
are all fresh and not yet properly used in production.


>
> >
> >>
> >>
> >>> git tag --contains bc049387b41f | grep -v rc
> >>> v6.16
> >>> v6.17
> >>> v6.18
> >>>
> >>> [1] https://lore.kernel.org/all/20250513142812.1021591-1-memxor@gmail=
.com/
> >>> [2] https://lore.kernel.org/all/20240420-bpf_wq-v2-13-6c986a5a741f@ke=
rnel.org/
> >>>
> >>>
> >
>
