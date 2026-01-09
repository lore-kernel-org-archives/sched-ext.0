Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB8233EAF8
	for <sched-ext@lists.linux.dev>; Fri,  9 Jan 2026 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767995410; cv=none; b=a02I+u2kcVQwgDE2pfafjFyam0nlhnJtXqgLJqxKOf/L88O3Fd9xM3F5d0y2XfDyzFAWRUBoRD1esIGehnAtsGol3XRdDZSuaaeeCKukyv58b5nXr4DcrVlp5yX30iHM1LN+UY2JJqr9ayMtDeoKt8+bYJ07KBY5EiK7YecH85M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767995410; c=relaxed/simple;
	bh=mBMSWquYxXBQQw52dfRLKavEQ3650dPnys2FBUwMDww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEEPTXPogBIgClL3F2/1crr57G1CerHlMEjXcQTcWrzdGSkxmBQwYmxfHhSBWIYnu23M9L7T/ngeZ5vpKWqPRaBaDeXYHZYxcxBcE/CNnTr/H2MKn5LiyDvGsU5d6XgseHQhwtKc3Uth8GDlAixcAbsxAkShfiAC+ynam+ZBPPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZgq2xM5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZgq2xM5"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-432d2c96215so1722618f8f.3
        for <sched-ext@lists.linux.dev>; Fri, 09 Jan 2026 13:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767995406; x=1768600206; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yl2jfUOFQFw9ZFM/F9NwPFBQh1GrXlHRzkKM76uazgM=;
        b=cZgq2xM5rfHAVJBBf0lc0I3X+H0DSH9VOSs9eEDODyKQwgzoTtckHchiaxWxS4XZD2
         iLIF2giNTBToyCbeM2xeYFQ6CdyJ6LQ24l10OyGGl/szKeZUkEBGPiLHRdmOmypc6m3r
         UY+DbNHOaIZDnPOkEtjZftLUHOGZmUIofVSugNW0l99AM5PiFXBHCmA65pSOqRFZwqB7
         laQAuJ1RR5lKV4p/I50ml0FUEv/DYjPDwNB3lgowRO2mCCwuSQP7AwvWUkG+29IX4cWD
         y1GeWO7yCjTdMrx2kgxiVdH6u8t8FaSpceq4vRtsq36PeoVI3QMiPKxayKzXdDrGaf9D
         FYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767995406; x=1768600206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yl2jfUOFQFw9ZFM/F9NwPFBQh1GrXlHRzkKM76uazgM=;
        b=LLRDav3UFMKvfOLjJiHChgfr3Xd0Vn0wzX1qbRsL6bipN8NpmTLAjCeQ4kxC0UKTLW
         DSya+zjh/uUBG32GiCIF+/v4oQVSSn36jFRVu5ZmmuBCg+umuJz10WcXeq4M/4SZyG9x
         nAj61A54hxHgscXMH09m47LUktGstmNNAEi2SVOWDfNBuaBSVpK5MXBD2mduF7qQ9klG
         TXfxjWqRxitHZydPhdk/orHmViUtkCzSs4orYEI3SYWV/07d6+ApEHbrAr5Qoj6VHtWK
         RKP5XeIvkBNJ1ikJ7ZsvMT0rkunGqCY/WlHb6d4jUksibtd0UnPnbAnD9NNKE7yuXJsk
         fImA==
X-Forwarded-Encrypted: i=1; AJvYcCVy6bBhOVkIb9340ceZDZuzqvLedaBCdFO67TMow0F/BZ7eJvBUzofb6hkAGzU6HVR+/mVgUTtvlvM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxDWIRvz9RamP9DqVtAOTR1WbB1k1icO+BtnjYubMkA9+dBYrzo
	VjnU30EakOujyt/Mk4VTR8Cz+2kfif5Yjga+yIPsrAheGSvO3jQF2OusHYKH39IIEH3OOqIIBcU
	m39hMHYuYrZwv+ZspqyT36rXqvkY3iUE=
X-Gm-Gg: AY/fxX6Bni2vAYkjzzc8uFmsRqRbV1doK/BdB5htAX+B6bUK/TbvWNYIMzT4F75BeSn
	IIks2d+1Dddbwh398Y12nahXK7ufNDpFbl+Gzxv4ueqZAomw9u+wln2JHFljrvAw4NUEj9WixBs
	HKvwcmB9Xr1FWvM3gQ1zV84Z0o2WsBl9gEFXroXsqzi/2oPMQhYVh7faZvoOs1dkb6fsUnCKuHD
	CDld1Kjv3mpFV1dtbaHmzSJpevsT03KPNJ96YAPbdUACgibMC8dLZqDu05a017z9j9GErsje1a3
	3lUyhx1J/XzlHGzEKMJiIm68LUuo
X-Google-Smtp-Source: AGHT+IEpNN2VtUtAub0I99rIc50Il63UXhoIXIO7xQkcbeKDdyOPhjh/6O//ElBqJPm/iBdeBYBhI/6PQzhggWV4zbA=
X-Received: by 2002:a5d:5d08:0:b0:430:f879:a0ee with SMTP id
 ffacd0b85a97d-432c378a075mr13975409f8f.5.1767995406380; Fri, 09 Jan 2026
 13:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-9-ihor.solodrai@linux.dev> <CAADnVQJDv80_T+1jz=7_8y+8hRTjMqqkm38in2er8iRU-p9W+g@mail.gmail.com>
 <b099a95e-5e69-4eeb-a2c9-9a52b8042a85@linux.dev> <CAADnVQ+_AmiwuupkVJTGyKY3KOp68GLuivs2LMEr0M_yaHPUUg@mail.gmail.com>
 <0c4d84ab-1725-45bc-9c1c-8bdc1f5fc032@linux.dev>
In-Reply-To: <0c4d84ab-1725-45bc-9c1c-8bdc1f5fc032@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 13:49:55 -0800
X-Gm-Features: AZwV_Qg2PKLZpr1E2blvwzcDGguOO_nPvhlw-fT8WZOdgqaH2F_J59Sj-VuHinQ
Message-ID: <CAADnVQ+k-nbq-2PGRSPJDRZ3G9sp9zu3Owqsj7zqO_G+3OQEww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 08/10] bpf: Add bpf_task_work_schedule_*
 kfuncs with KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 1:39=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 1/9/26 12:47 PM, Alexei Starovoitov wrote:
> > On Fri, Jan 9, 2026 at 12:02=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> On 1/9/26 11:58 AM, Alexei Starovoitov wrote:
> >>> On Fri, Jan 9, 2026 at 10:50=E2=80=AFAM Ihor Solodrai <ihor.solodrai@=
linux.dev> wrote:
> >>>>
> >>>> +__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *t=
ask, struct bpf_task_work *tw,
> >>>> +                                             void *map__map, bpf_ta=
sk_work_callback_t callback,
> >>>> +                                             struct bpf_prog_aux *a=
ux)
> >>>> +{
> >>>> +       return bpf_task_work_schedule(task, tw, map__map, callback, =
aux, TWA_SIGNAL);
> >>>> +}
> >>>> +
> >>>>  __bpf_kfunc int bpf_task_work_schedule_signal_impl(struct task_stru=
ct *task,
> >>>>                                                    struct bpf_task_w=
ork *tw, void *map__map,
> >>>>                                                    bpf_task_work_cal=
lback_t callback,
> >>>>                                                    void *aux__prog)
> >>>>  {
> >>>> -       return bpf_task_work_schedule(task, tw, map__map, callback, =
aux__prog, TWA_SIGNAL);
> >>>> +       return bpf_task_work_schedule_signal(task, tw, map__map, cal=
lback, aux__prog);
> >>>>  }
> >>>
> >>> I thought we decided that _impl() will not be marked as __bpf_kfunc
> >>> and will not be in BTF_ID(func, _impl).
> >>> We can mark it as __weak noinline and it will be in kallsyms.
> >>> That's all we need for the verifier and resolve_btfid, no?
> >>>
> >>> Sorry, it's been a long time. I must have forgotten something.
> >>
> >> For the *generated* _impl kfuncs there is no decl tags and the ids are
> >> absent from BTF_ID sets, yes.
> >>
> >> However for the "legacy" cases it must be there for backwards
> >> compatibility, as well as relevant verifier checks.
> >
> > I see.
> > I feel bpf_task_work_schedule_resume() is ok to break, since it's so ne=
w.
> > We can remove bpf_task_work_schedule_[resume|singal]_impl()
> > to avoid carrying forward forever.
> >
> > bpf_stream_vprintk_impl() is not that clear. I would remove it too.
>
> That leaves only bpf_wq_set_callback_impl(). Can we break that too?

Sounds like Benjamin is ok removing it.
So I think we can indeed remove them all.

> Then there won't be legacy cases at all. It was introduced in v6.16
> along the with __prog suffix [1][2].
>
> If we go this route, we could clean up __prog support/docs too.
>
> I think it's worth it to make an "all or nothing" decision here:
> either break all 4 existing kfuncs, or backwards-support all of them.

I don't see why "all or nothing" is a good thing.
It won't be "all" anyway.
We have bpf_rbtree_add_impl(), bpf_list_push_front_impl(), etc.
And those we cannot remove. sched-ext is using them.
Another few categories are bpf_obj_new_impl(), bpf_obj_drop_impl().
There are not __prog type, but conceptually the same thing and
KF_IMPLICIT_ARGS should support them too eventually.


> git tag --contains bc049387b41f | grep -v rc
> v6.16
> v6.17
> v6.18
>
> [1] https://lore.kernel.org/all/20250513142812.1021591-1-memxor@gmail.com=
/
> [2] https://lore.kernel.org/all/20240420-bpf_wq-v2-13-6c986a5a741f@kernel=
.org/
>
>
