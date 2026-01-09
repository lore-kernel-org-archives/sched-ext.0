Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CB52DF134
	for <sched-ext@lists.linux.dev>; Fri,  9 Jan 2026 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767988706; cv=none; b=GpOmMtt2mhRnoc6YBugX2YzjueFvjZO/m5f3Wwjud1AWBCmvRXaBNkiYDrM62okJ/+8KFSu4wHU5afrEls7bG0VR1N/WJuxL/hZrBgOvAX99eZ1Ddmq7q0awm1+npPmKejDQy+0xkrK0mYxzgCQP0n4eFp7FbZVhcsy0SGmRa8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767988706; c=relaxed/simple;
	bh=N4mI29kLpsMIsx6SXly8DxbxF9Em3XWcDPorGzytv50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVhUIzRJFGRkvc0EYiiXejsxDFYfHPAUYXU/oxjanhuWHyI5g2VD4rgMQ3xqs6mVKDyVn8F6zDt+HoPpsrQq0vq4biplOgCKFf6ZHqdW3bURgd5+KmFuPqCrpwIVzfP/qFdmOnEP/PN6E45Gs7satPCv+Wmko/b1YsTjBkxzMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/losa0g; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/losa0g"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4327555464cso2715455f8f.1
        for <sched-ext@lists.linux.dev>; Fri, 09 Jan 2026 11:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767988703; x=1768593503; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QMmqijmW5OEj9rhjII4BzCWp+Fe1yVoyJR9EVAR0Ao=;
        b=M/losa0gtVdpnHe1+LhHe2mibkxPpgjNgfujDp71wZ0x6DuazGHdTA06hlsurxMZwX
         eJnNZYT4OusNlKdbKlCBJzRCmZU+xsBFmDzS/tcnDuhuk8u12Y+3B0rohpw0PSwWdlMR
         xwm1Ryi7BdS9bvVnWcikjdvIzJENJX4Fot3Jis+TmOCmEWmC7BNybyt4acO4/PRMo5Be
         K3YcKJU0Do5CHg1mRdN2cXn2EUwYY7L0U+2idqz4ij/JGJzJ0ZkBYNEJQ42OTt7zhNz0
         3pm/K61lQhCNarWqs+GBIQlrCgLiyikkNijOrSWU1CNNuaZSmpjK1JQPZYM26H+EIXm6
         lZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767988703; x=1768593503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5QMmqijmW5OEj9rhjII4BzCWp+Fe1yVoyJR9EVAR0Ao=;
        b=Svgd7GHCmQo+8yDXaUhYJQj8o7eBStMh2ogZNcfRi+yte3qNjUCy2BJtwJAqsbTyW/
         zLfouQlmRtHls3ZuohsmX9PtZyNqCo/iizJN4jMXx4hKflney4WkYJ6uwWnFwx9NYsD8
         +g0XOptbXd0yRHIP8QytvK0k0DwXML4R+qMTiWzdngdNzbXyOUXxSG1ddwSWdELVIEoC
         oK5mSXDcwMSm2PsEAAvn2Yxhtv6490Nt1Qs+dCt0+yU8sAUfzogpXLoFysFu6A7i+VGS
         IEEoEVANnicyrj6dwjXSAFb1cvcExJJJlQnr3R3ov0/1KBF6OVwSEvPz4PufQ5WHpb6A
         q03Q==
X-Forwarded-Encrypted: i=1; AJvYcCUb1PNd9ttifYeG9WoFs/pWWN38UwbSuJkpDOXYSbawCNkJzOKwINP1zSQSl9ndoqe/8fHRUkXeHpk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxi3WQqnHRVFqH77t2baoffi+vCeEL2HHUXbgcjVL/K5U3MGJMO
	NZVdj9+LLxkR8SLGWKHpsvtvMJTJBGPBTeIwq5Fw/WUKZuz3x71y7ZfhlOin6Qs6Udnm0tmPjFW
	alyW9qz04KpIWW+08Zfm4l7WDO9wVbAw=
X-Gm-Gg: AY/fxX7+DoTRgWKZMLEpF0phuIfgMGxUj2xz0FoGUJAe+4irr3S1xyhBDS9EkN756w6
	5/pPkfhwWUJr96yTquvSCCbxa061KgRuKEw0lw255ZzGHFWs5K6mAlktCL+rAExFsjAbqT5W/V/
	69oQT3tZT2+LO60VT0Lm7NUzSES6IaNY6xGaSRmlZzUV+GbgnQ5tYDnBy9vDQLm7m4OSEo2gvT6
	5rNWf14DVgxkEx/ncDLdTnkQUgDCGFKiK/goYuIVuhPvM37H9/9xc9FHlNa8alL95/DiaieG5cB
	6O98jquSZf4QaImHLvs5VEGSE1p9siTy6uHwDw0=
X-Google-Smtp-Source: AGHT+IH31/5/AxLt/GFD0JXqk5ipU8sqfkp5h+qHZjIKs/6CrSBkE8wuiyerR6wM7rrW0+Av3p0KHNxlHiPDHCtG/oI=
X-Received: by 2002:a05:6000:2882:b0:42b:55a1:214c with SMTP id
 ffacd0b85a97d-432c37c1462mr11155555f8f.55.1767988703249; Fri, 09 Jan 2026
 11:58:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev> <20260109184852.1089786-9-ihor.solodrai@linux.dev>
In-Reply-To: <20260109184852.1089786-9-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 11:58:11 -0800
X-Gm-Features: AZwV_QhLHY-bzxGEAgmV-qRTyW82SDVPwuXlSXHHrs1ojOutmV1JrhtE-366It8
Message-ID: <CAADnVQJDv80_T+1jz=7_8y+8hRTjMqqkm38in2er8iRU-p9W+g@mail.gmail.com>
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

On Fri, Jan 9, 2026 at 10:50=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> +__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, =
struct bpf_task_work *tw,
> +                                             void *map__map, bpf_task_wo=
rk_callback_t callback,
> +                                             struct bpf_prog_aux *aux)
> +{
> +       return bpf_task_work_schedule(task, tw, map__map, callback, aux, =
TWA_SIGNAL);
> +}
> +
>  __bpf_kfunc int bpf_task_work_schedule_signal_impl(struct task_struct *t=
ask,
>                                                    struct bpf_task_work *=
tw, void *map__map,
>                                                    bpf_task_work_callback=
_t callback,
>                                                    void *aux__prog)
>  {
> -       return bpf_task_work_schedule(task, tw, map__map, callback, aux__=
prog, TWA_SIGNAL);
> +       return bpf_task_work_schedule_signal(task, tw, map__map, callback=
, aux__prog);
>  }

I thought we decided that _impl() will not be marked as __bpf_kfunc
and will not be in BTF_ID(func, _impl).
We can mark it as __weak noinline and it will be in kallsyms.
That's all we need for the verifier and resolve_btfid, no?

Sorry, it's been a long time. I must have forgotten something.
