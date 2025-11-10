Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8592DEA80
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809713; cv=none; b=BtwPQH6k1eimFHgceveTH+8uNGR/DDS6utnAhBk934ffeEVnOgwfcTLyRiL/sH2woiSfySgFftjfLEjDx6zoV875yYZSYyB0VCIVN6bc8yWwhAFcF6SrSteQjHPtVzmjhphPM/UVlBcYxwOCQN37Hwua4jbKqOFN/ZtebOlayfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809713; c=relaxed/simple;
	bh=lT0bETKBrtamVm1uBBj/h7Vn58enr7FjC9rwg4SQvGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qk71k7yzWdkfV767yHNKwgt8ZfmRwVtrNh62X1FEqaeEUQS9E+0xulQAwP78XzeB1LXxCtDZQNALYqv/d47X8OVUGXVZ/b7BmtsAtftpnWEbQFCQ1W83y2r36w8EncXoFE9FVLyXI/hPS+gDxQRDyFJuSwNtKwL6rRRAqm2vSTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=CDisdVcH; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="CDisdVcH"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63e2cc1ac4aso3159209d50.2
        for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 13:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1762809710; x=1763414510; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sesGHprX+1WlbXXlnwmIK+NqQik2TI8q+6Ij8J/CIOg=;
        b=CDisdVcHDWIyeYhatJCssM50OzJqKYadLrIY8VY2JcGU6pfvlckPbSgb5FRBUmZj5m
         RDjFHsWP8z/XBOjMh+QViNs9mriCvwFkQ2QQkFKtoLF5FxbbYHTWHzO3ZrCElDmev37C
         OwnZo5u/43YEFFtLoHmBBEfYm1HD+QX+ryGY/lRY+gsxRzHCwihqv9X3fr/ggTJk6Dj3
         4yQmFjokn1FuLexbgldna/3IE8DAcjkGK90JWjcdS+WOewluUvuery8m39iHpSfch4Qy
         eSZepXYBzfXZEe8SBpGY98Gs4wUPHmAZAfSMLG4ykeUp/SGyHWD+xlPa3mRht0VjS9WL
         31Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762809710; x=1763414510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sesGHprX+1WlbXXlnwmIK+NqQik2TI8q+6Ij8J/CIOg=;
        b=H4TfcoPgEE6zJEEca4Ygf3PfIY1NOZASbbHR6dSyKHXoeVNQ4JP6mtjsq2hOUSp6L5
         LWTX2tLq4BesDqzKcwEt6n3JQRj6tscpSnkLCrIq6nHgzPZyhaHhpb5EQtI6nBSf2RfG
         8DlL3WnadRIQSaw5deipr5P5IjBbSb5ySltCjFfwL2OBGd2PZ6Yr9P3uydvj7je9npun
         VON2FojV/brkd99wK2qZk+25HIl6MnDcJQCXvAIm5w0gSGATrUHpSUjmPmU52AVz4QdL
         d6tL1r/9Q6m6O0p8lglZrgaGBY38Mv94id+W08rLH81qdm5yu4ZTocYNq/LyteVvWwBC
         ThQA==
X-Forwarded-Encrypted: i=1; AJvYcCUue0ZX8PPB7xqlTdtTsFuM6K3WQmNZKrDBx1ECvurzc7Ba1DeVTroxd9LCdO4Ze3CtZ+0TuhgKXwk=@lists.linux.dev
X-Gm-Message-State: AOJu0YymPvmCxo3I66J+EEqysr2YEyQCRwDk2903AeI4vSb1RnpXELqV
	7EEMkP35axpKA97kjXHEZE4XppceQ+wxAF+iaGNqwWunXcA6gwYmYpc9C5sNWncR2pZt6m2p/3Y
	WRCprYeAr9f2S9ldbfJTBOwW/7GyJtHJ90WBspZScjA==
X-Gm-Gg: ASbGncvetHdunVIH2YklXtsE6Rpeh/vtDhWQPbTVTqLE9ArF8hHIYS0EdNmjlNsguQ1
	arIZqkGvCp09qpDLpx8AX4+H1IC9tY1ge3m3Z/zH8g/A2RvPszp5PJpcigpPPToFtjfHCs/LUTk
	Tpr6SbBE+Tr6qju74k1QXFJoy8JDg1uk5jC5TxdDUdjNzxYuerLED2QM1nbyFKAKwgyoj0Vnnxk
	IX6BNB6nSctr4/jaoSGiFoR6ktrKQ1VDTmYAVyUmnm2Y+vKlPFKJxBmR5v6LnI=
X-Google-Smtp-Source: AGHT+IFMWauJYg/+Hxf6FOiIbgd7lsrxFeiDNEwY8YbAc/vKRrFFeNS0GHTj94ZvI8kEc8OUG+156cOYC9eXjYym2+k=
X-Received: by 2002:a05:690c:4d09:b0:787:cad1:bdbd with SMTP id
 00721157ae682-787d5473907mr104028257b3.65.1762809710480; Mon, 10 Nov 2025
 13:21:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251110205636.405592-1-tj@kernel.org> <20251110205636.405592-2-tj@kernel.org>
In-Reply-To: <20251110205636.405592-2-tj@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 10 Nov 2025 16:21:38 -0500
X-Gm-Features: AWmQ_blAi8FOoVppDnM5enbLhfoiA5Nt_BRDMI3YlXMQjTOkmLWDkjIHUFecRoA
Message-ID: <CABFh=a5Y8b9Ke2e=Cjdirjzz95bNEJf1SjEOtT3OVG8ZPPBk3w@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] sched_ext: Don't set ddsp_dsq_id during
 select_cpu in bypass mode
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:56=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> In the default CPU selection path used during bypass mode, select_task_rq=
_scx()
> sets p->scx.ddsp_dsq_id to SCX_DSQ_LOCAL to emulate direct dispatch. Howe=
ver,
> do_enqueue_task() ignores ddsp_dsq_id in bypass mode and queues to the gl=
obal
> DSQ instead, rendering the setting unnecessary.
>
> Don't set ddsp_dsq_id from bypass. Just return the selected CPU, which ha=
s the
> effect of waking up the picked idle CPU. Later patches will implement per=
-CPU
> bypass DSQs to resolve this issue in a more proper way.
>
> v2: Removed incorrect bug fix claim about dangling ddsp_dsq_id triggering
>     WARN_ON_ONCE(). dispatch_enqueue() always clears ddsp_dsq_id even in =
bypass
>     mode (Andrea).
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Andrea Righi <andrea.righi@linux.dev>
> ---

Reviewed-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

>  kernel/sched/ext.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 652a364e9e4c..cf8d86a2585c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2521,12 +2521,8 @@ static int select_task_rq_scx(struct task_struct *=
p, int prev_cpu, int wake_flag
>                 s32 cpu;
>
>                 cpu =3D scx_select_cpu_dfl(p, prev_cpu, wake_flags, NULL,=
 0);
> -               if (cpu >=3D 0) {
> -                       refill_task_slice_dfl(sch, p);
> -                       p->scx.ddsp_dsq_id =3D SCX_DSQ_LOCAL;
> -               } else {
> +               if (cpu < 0)
>                         cpu =3D prev_cpu;
> -               }
>                 p->scx.selected_cpu =3D cpu;
>
>                 if (rq_bypass)
> --
> 2.51.2
>
>
