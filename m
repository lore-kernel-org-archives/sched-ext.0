Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4D23504B
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817193; cv=none; b=mmPJhOMWZmIj6HJpz7QO4tkqKIPuyOBFlMqTncJnHXNLIJXeE+RaWXKH1Pajm9hAqREOU95UdUcnSeXcK/sDgASQTcsrobhH0XwBPEue5vKI5YtLIHPIhWbyfKjeNHib9xc0WsrTgjCBpxfCfLASipAHere/hberR0sISviYMko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817193; c=relaxed/simple;
	bh=VCB2ZMxLVCEaLhJ0PJgWPd2j0GgeMo+gFkURpClM/7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQqY+7/3gIIQVDgsJgBG4W6nx1xVgU120W1oNlSqD/0nIS697bbQ+X/KiqqmRt5YbblASIaU4uw/0ltfoA+f9SuBijv7LZy9WnRd6YQnPrv+ZBvQXXQfkXo6V3OQiZzT+brsIWWElmzaKLQD1Gm6G2eR+/ewPducT1OpusUpt4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=S7ZZGywC; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="S7ZZGywC"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7815092cd0bso34371677b3.2
        for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 15:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1762817190; x=1763421990; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KipecrXhqUgdfrMDxFBmzG4ENSV0qjCiG+IUf6NbfOU=;
        b=S7ZZGywCeK2kznLwaq4kmy8YXGsk1UVX4LgU6vlAM9sZ2hFTydWYMsnDVBcrFdQFU2
         yroMg05NTm0j3CNMSIY/1+NNZA+3rsHMJaAFGceKH6mNNrJ2t/cpEki2oqW2b/fNda+I
         eW8c0BJuu7wjnIupzWCsY+vIps3bQsAUk28ktizYTUTIpkHDwII5nW4W354hq2Q25EaR
         L9Lxx3OaSwA4Q5Eu6QDFv7hgonaV5DKquwAZjvqXxL05Nm+UlZcH+5UzZFIeExAkE4FM
         NlUSp+1yd5arNgoRGP4DdRbw3ELuKAFEWjMPdLfoL2XGGo2PEEns418+0XkppqZUI9YD
         Duyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762817190; x=1763421990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KipecrXhqUgdfrMDxFBmzG4ENSV0qjCiG+IUf6NbfOU=;
        b=Is2rZKVVcPlytp1oKf33CL6vEm/eaizteXRN51KngMvPjiPfQ20lD/c3q9CFg+Pn4X
         2t5gl/x30CAsGDzTTcXrumY8H1r1lzUw76HMbic/gk9fCeVkgBxpwAlhQNMGKmj4qJrf
         7a3Oay6b3baG6RSRQd0mRHM7qEyaxLcM/cbp1QdWFJ5wpIor1MwYES2z9C42t7PwgRFE
         M+p5n8A4RyYlWYmr0QZYibNvHyheQ2XbMNOVS+uEDwrIV18UCr6fvop9yzbIe/+f3w0Z
         C5eQ6F0zjVO8X65f5C2Y8pYAV4+RCU+P+QAhyfSypVEa9GTXUBFxqnlIeQy//qeQDQZb
         8/bw==
X-Forwarded-Encrypted: i=1; AJvYcCX+FNEp31S4iWS0sVaJltps+0o224bAlATfqAkjr1bcYQB9aqmGjC9sjS64jVABeBcI/px/6yq9ayg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzix2z+M3iKtM2X0xlYaZZygtLaes4SQ9rpU+DruixVYzaIl6a2
	6DFM26kImMu6zJVDwF1R1jQzY3I4tYBwCa4RU31cRIBM9iKz3TfEKAYM0I6cYMc8sAuF9hnc2lu
	UufQyXn9m0FBSyRHK4JM0o0HpQ89biNXi2rQZ/DP7cw9dXTBOFmhb
X-Gm-Gg: ASbGncttKlJqdpXerPrsNT9L+kFR7vHicZJXjZ1FV2ZykP3iPVr3WkO68Q8JwpscXWY
	Wwh1vFXMloDFe8eJ//BLhCE7RWNodd2l/IrvNSpVX7dMM4gUW4dHD3IKs8tdEoB4J3AoR3JOpGy
	50aw2jtZFbMaSUYH6d3XrrNMFhfgta46jQ7pya2NKdTcCdF/dG0Ot9aqg1qBoSvwtItOoF5EpNX
	eKOC4CX/IrD+ffXgOCgfvexBxatZXEvMLEXkd2jP7yJH7wtLbFGs0ifZ3yThca/OgSsal9yqQ==
X-Google-Smtp-Source: AGHT+IHXBlAUFCR85xg+f0kdLjBezojNFyqd6xRE/D47CmRf5ykj9eoFr7t1LpF96qjxOpV6+cmjH5ejJYIsrZgrwxA=
X-Received: by 2002:a05:690c:6011:b0:786:4fd5:e5db with SMTP id
 00721157ae682-787d543a779mr176879927b3.49.1762817190409; Mon, 10 Nov 2025
 15:26:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251110205636.405592-1-tj@kernel.org> <20251110205636.405592-5-tj@kernel.org>
 <CABFh=a6rP08+vsK11Ubi5qv2o2yOYFSoiMMM8ZahSVy=LzXpow@mail.gmail.com> <aRJgTTiAnHzrMN8y@slm.duckdns.org>
In-Reply-To: <aRJgTTiAnHzrMN8y@slm.duckdns.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 10 Nov 2025 18:26:19 -0500
X-Gm-Features: AWmQ_bn0JzQ8IqDTywdTWUHBnmbWv0P-aVwCXoPIRl2avHsOVuwvIbUg5a73Ys0
Message-ID: <CABFh=a6GNZSzrLzyonv5aYn8Rh06YquVoGHJfJnYL8rMOymZ+Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] sched_ext: Use per-CPU DSQs instead of per-node
 global DSQs in bypass mode
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrea Righi <arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

On Mon, Nov 10, 2025 at 4:59=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Emil.
>
> On Mon, Nov 10, 2025 at 04:43:23PM -0500, Emil Tsalapatis wrote:
> > > @@ -1298,7 +1298,7 @@ static void do_enqueue_task(struct rq *rq, stru=
ct task_struct *p, u64 enq_flags,
> > >
> > >         if (scx_rq_bypassing(rq)) {
> > >                 __scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
> >
> > Nit: The bypass label has a single statement, and there is no fallthrou=
gh to it.
> > Can we just add the logic here:
> >
> > dsq =3D &task_rq(p)->scx.bypass_dsq;
> > goto enqueue;
> >
> > and remove the new label?
> >
> > > -               goto global;
> > > +               goto bypass;
> > >         }
> > >
> > >         if (p->scx.ddsp_dsq_id !=3D SCX_DSQ_INVALID)
> > > @@ -1356,6 +1356,9 @@ static void do_enqueue_task(struct rq *rq, stru=
ct task_struct *p, u64 enq_flags,
> > >  global:
> > >         dsq =3D find_global_dsq(sch, p);
> > >         goto enqueue;
> > > +bypass:
> > > +       dsq =3D &task_rq(p)->scx.bypass_dsq;
> >
> > Nit: If we keep the bypass label, we can remove the goto since the
> > label is right below. Otherwise, we could remove it
>
> This is really subjective but I like the fact that the local, global and
> bypass labels look symmetric. It doesn't make any different to compilers =
and
> I think keeping them so is less likely to trip up people.
>

Ack, makes total sense.

> Thanks.
>
> --
> tejun
