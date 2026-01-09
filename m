Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096B427CB35
	for <sched-ext@lists.linux.dev>; Fri,  9 Jan 2026 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767991665; cv=none; b=MilaWBmYQk9c0nmm0reh7VOKwuSr6lFWN7gIBkZh+TOf/Iswj/GH0+IeEd6CJ1WQoHR6X4Y2wG4rkjxTmUoahjmZ9QTVZKH95L/oJPb1pXcB8Tdd7NmCBk5WGWSQ79+MNy/nib7YR0jkUbE3f98CqfAQF+ciAd0VOS7LmlafUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767991665; c=relaxed/simple;
	bh=CKV38SzVlF2d1rURig5UXmlSxJit+yDiumkwA8mKHKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEibJZTVN4p74I/nKwyB0iLQl3E6EcIjunE/Fs5Wcf6XSJnsXnJMyFbkCgXv5r1iRgbZhq88Tw75QCDyYRnJGl9CCe3vvAl/AlBXaMS/NVIkH94gvYJ5pv1OeanN4YLNABzdJ8SwL/Z9NAgyajBzWSyq6RaSh2NBpNXcVl+S8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4lUeLbQ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4lUeLbQ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-432d2c96215so1694238f8f.3
        for <sched-ext@lists.linux.dev>; Fri, 09 Jan 2026 12:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767991662; x=1768596462; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5DkWe8BK5oL6p5BAqhKcrcL+HSx/OZlEGaRXpxjMqM=;
        b=e4lUeLbQaR9VZ49xGUbxsBX/xA6E2f+06ZRW4pQmmIKpFOMV9i69R4nkAuIj9+n9zW
         ga/rG0fF7yyXc74ikF5jNl3LVfXz8WAzhDRne0KZmFnly+T818AICp9OuQLMQK5LEECH
         hXnpEYK9059fspd5PcOIPjM2i8a603oLZes5G3PvqXzmXQFJFjD86gFTnGMEdPMQAYFP
         e7dPTmZ6kFfUs3Un/cxPMbJ83b6XQB9f/aHI2i2E+lRvgpOge+QFxzt7Wunbz1yO5JHp
         4FpQiClJFv8IPiSwmI/J50lTLuQ9Kes1aqys+ymZRIdFLF6x58+RA8muHWgQvdn3Z/29
         V5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767991662; x=1768596462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N5DkWe8BK5oL6p5BAqhKcrcL+HSx/OZlEGaRXpxjMqM=;
        b=eBYKPy16MD7sdvg0Q+aWQQHzP0xAjBUHFRPPnHuNX38M5l7uQ5BPCqd/9w6hvdf1z1
         Dxn4dY4+4GdslXlT9NTUuSuUKSgPdnnjZ6Gb5TEFoekfhgEFuIBnC7L3UVeNjOnR1MM+
         CSYt5VmWaBjbR7wrLEsnALvcli2um7BpXmdWHOU9GKnq16R3rb141dPMdhmeVNNhzcwG
         lmP7wA2UlkAn7VjmD5hOkQDhUaNM8OKUuShjLZ7gYZMmWVDpzevNCeyr/CsPuwFbkkpA
         sJfyzNSRiYmjEfjQ0wXu2EadVQ0TXX7BhhHGiEMq2rSlY1KrESUUGaiWYjSivsjQ6yOb
         phHg==
X-Forwarded-Encrypted: i=1; AJvYcCWEUkU1aUx8uGjBHyyQdC6n2ogsVw3IjxrNsWimmQggAROLGA9pNnM96ddPNwE0yyf68NnoIQxXPSk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5hTkgNcdjndvAkX8aj0mVG2CElI/1s3VZofnHuAd4X1ry+78f
	BO5GSmhoQSxm8/VIxcuqV6Vd9/dwCw+vuz81ssj+3+m2i1+WAcM+Rb4FWP5nS/yy04vHWU2zn1q
	dBf37/iMqTDCu6zVly3WrUPBp+ScXt8w=
X-Gm-Gg: AY/fxX7GB9DOd5ToVt3gVfC5LA+QXDN8owE8D3QMrpeiG7+ORReOwXVb4GG/zA4jPc2
	E6ku8UwQ4YQtM8dqrm9BBgQ4yEn7Axd8WXYkOMm/2wAonwdbhtlAO17uZdYlWM26XvKVhAyDoil
	X98b8/FKAB6SkddAQz5cQRPrVviSbnIcb4Ycl/3mPKl5GSYgfrnSwpH/SgQxL9fxTH2C2Kvtt8N
	2g+8svZ71W1veEkWUS7rNf57JTCd/WjQUhZdF2rcniTOIoZpfSijDyIjEFCfRWAKUtW+bbLoT1r
	LCxNvmb38vht1cnYnOo/+bHvZIfi
X-Google-Smtp-Source: AGHT+IHdRKNK84BvX/aCBc8Btep0njI4c23O6CoinWvyMnx6DkJfIxAwEbl0kb24cRMMwbjEKTdgmU4n2r2OqzVXXSk=
X-Received: by 2002:a05:6000:401e:b0:42b:41d3:daf1 with SMTP id
 ffacd0b85a97d-432c37c881cmr13219905f8f.38.1767991662165; Fri, 09 Jan 2026
 12:47:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-9-ihor.solodrai@linux.dev> <CAADnVQJDv80_T+1jz=7_8y+8hRTjMqqkm38in2er8iRU-p9W+g@mail.gmail.com>
 <b099a95e-5e69-4eeb-a2c9-9a52b8042a85@linux.dev>
In-Reply-To: <b099a95e-5e69-4eeb-a2c9-9a52b8042a85@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 12:47:30 -0800
X-Gm-Features: AZwV_QjBGwB1G6T0jt0mlsOuxSvnjBYFN-lMj3ADwkO59Yhgq5O_-D2dT5zsknc
Message-ID: <CAADnVQ+_AmiwuupkVJTGyKY3KOp68GLuivs2LMEr0M_yaHPUUg@mail.gmail.com>
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

On Fri, Jan 9, 2026 at 12:02=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 1/9/26 11:58 AM, Alexei Starovoitov wrote:
> > On Fri, Jan 9, 2026 at 10:50=E2=80=AFAM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> +__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *tas=
k, struct bpf_task_work *tw,
> >> +                                             void *map__map, bpf_task=
_work_callback_t callback,
> >> +                                             struct bpf_prog_aux *aux=
)
> >> +{
> >> +       return bpf_task_work_schedule(task, tw, map__map, callback, au=
x, TWA_SIGNAL);
> >> +}
> >> +
> >>  __bpf_kfunc int bpf_task_work_schedule_signal_impl(struct task_struct=
 *task,
> >>                                                    struct bpf_task_wor=
k *tw, void *map__map,
> >>                                                    bpf_task_work_callb=
ack_t callback,
> >>                                                    void *aux__prog)
> >>  {
> >> -       return bpf_task_work_schedule(task, tw, map__map, callback, au=
x__prog, TWA_SIGNAL);
> >> +       return bpf_task_work_schedule_signal(task, tw, map__map, callb=
ack, aux__prog);
> >>  }
> >
> > I thought we decided that _impl() will not be marked as __bpf_kfunc
> > and will not be in BTF_ID(func, _impl).
> > We can mark it as __weak noinline and it will be in kallsyms.
> > That's all we need for the verifier and resolve_btfid, no?
> >
> > Sorry, it's been a long time. I must have forgotten something.
>
> For the *generated* _impl kfuncs there is no decl tags and the ids are
> absent from BTF_ID sets, yes.
>
> However for the "legacy" cases it must be there for backwards
> compatibility, as well as relevant verifier checks.

I see.
I feel bpf_task_work_schedule_resume() is ok to break, since it's so new.
We can remove bpf_task_work_schedule_[resume|singal]_impl()
to avoid carrying forward forever.

bpf_stream_vprintk_impl() is not that clear. I would remove it too.
