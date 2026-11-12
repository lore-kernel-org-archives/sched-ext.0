Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794468801;
	b=B9RHusvQ7IqVMq2sJJ6/YCb36S2lCFItK3XH3x95RtF8jFni+6AjQwVpdJnU2+ESF5+C
	 Pba7TTwLbyJWSWjAWjsRNB5U+NAu/hO45MMYbb0vBCzVCv76t05AKdJYHMVgp9emzyDv7
	 nfpc5A1AiHNq24k4KT/v8GU3g956764I8N05NhXeKnOacjuOW9QgSt1KjiRHc7h7Pe4ZA
	 xlAX6lVds2Ugp9ZupsFAVdv2HCB/qWT4BSw/4VNH2Dfj22lC3nMc5or8dwKR/hnIjMSoY
	 wOiNKU+12/KImPGH0bHHri8KqZDTYYoaF0jABEEAkuuR0jIG6i8/aT29NvtZcZsvAjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=1O8ABzkG8YTENTJXF3DXPni2PNJOE/E2+2rzStU6Ez8=;
	b=fgVn3ZuWQjS0TOcbyhLT9mmmlhMV7JQNgyibsHjJ3zipTpKbeI5e4bEf8csPsD1xjMyI
	 tgSODgjZljU4TdXhBcKlCjfnGcnXCC8cXy5UB7ydCUQ5tgTfxvRvko1I9PYIL4mRC+rKd
	 e+YssdkDu9iEOqRAafV5WdiLgvicPs54n4DJhR4bBRgng0ESxPR3q3Hh7axu/uPyccHe0
	 PWvC0ESCIASCs0kTrFA3hEN/ryjVKAAfsjicYs4PQoDNeLRTVP+1xsj7WtY4IDK7c1rV2
	 NWKXBU3hkdY+u1VxSYPfoSbtn9SSplkXUerHCyCLx3pgDTzovZVF8Ld4YCTldUYnQvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="waAr/R5/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303B606A321
	for <sched-ext@lists.linux.dev>; Thu, 12 Nov 2026 07:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A303B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=waAr/R5/
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b750e40ce2so628933a12.0
        for <sched-ext@lists.linux.dev>; Wed, 11 Nov 2026 23:33:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794468799; cv=none;
        d=google.com; s=arc-20260327;
        b=ElIS/bP1EkBoAvKPDwjaERNVG8ziJ5OTG0TEHoi+m+SlHUIdMP2ajiSyFfdulpWzxx
         GpoYwd6P+VMbO5B49clCXNL1vaD7gjfs2MIbKlUy/fRROP7T12XDZQG0UvQgoCBZC2jc
         Vb1BrAb/K4HAkLF8h8mH03FPHx1k10ipAkdkTBdT3Mkae98/kOOnURRyRabFOCnanBzK
         wWzvNqpDbabD8ey8DtqIPC2TIVZMcPknhESL8qGfcWkeUKz3COFTP8ETK1nSiVal+U6W
         Cr53nfh1mvtmrRNAgONeOaIZD5k/TSFlv/W1zIIORmnFMa0Nd/hourFSu5UVRaXkKQH7
         XGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1O8ABzkG8YTENTJXF3DXPni2PNJOE/E2+2rzStU6Ez8=;
        fh=Oh9NQcuizxG4FaFjgQdwCnB6mRxfx2x7oiyKb9xijg4=;
        b=MlkJ2KKcrrlU1NmoPBCllfcHOfglQOOKBafeSIY904TocubXBI9Kl8XrB0tg0GyzkC
         N32Ogm/MK8gEwDmor2H7g/PWBNasc8PHpesq3ZlkY+ycsSyQ2ex6ARiJ3w7IEmgfoKM3
         RfshJnFuBJTni4QNjMK4krDTtKJ9OkzXzytRxQ03yin2PHC55oM8S8Rnugm3E72iRnDj
         SzQb++CxNWkZbMrwbtneLPl7qFo3yelUBDYSW+Fbay94D/iIGyK9wJ7tPhySyVRxYh1n
         TqRAHDuI0ghowLfzfSYe33ddbM8tlfUSjFxzolp6JLlXt0bB8X10l+teEnaV3SPzg+8m
         6UqQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794468799; x=1795073599; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1O8ABzkG8YTENTJXF3DXPni2PNJOE/E2+2rzStU6Ez8=;
        b=waAr/R5/KLstGYIjbEyNGeCrnrzKXLBwBt656qyP6RnGiQiej4IRfcTjFHluUeKmEy
         4QBynXCRL9A8Py+93xEa2LTVbxutGEi0wLS9zzdgu+3C3jRg6R/947iVreKZt2S8vnIv
         QS35dftFjXmSiMLRQCgu47ob2ogjl72MNxKppP/wLtWV8VSKdUVeH1rJ0cgbdow9MCEc
         Jt1yTuaIWe0VldP0AuuVKffwz+0hBnentIBfyWms0Pcfi6tCPSihZTSrAVaEXPGZi2bm
         26RBoC/KMc9N5XUnVp58za8QVsyBFcOAnTkPyyBzNg9vyZtR6V8xE7jzm+VYFMq0dxUO
         iKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794468799; x=1795073599;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1O8ABzkG8YTENTJXF3DXPni2PNJOE/E2+2rzStU6Ez8=;
        b=zgKzkyJsygDfDbe8jlFrLvlViHzvbVri8uiECYykSEMN2IA0y6PwU2xYNSqVVM7+ql
         P61MJUH16H0PWMVEvlQIplCQ0EmxrUa60MAhAQQsdBifUqA1JuWyNbMErevlD4TPp5tp
         IS4BMMS9YGLRIraLUVvMqcDxbObjbLRJaUnCyp7JtzaZul7cYu/mRKrJIzVl3kQBBlg2
         j+eASQXsnU7gmr6b8NNdP3CKsRKwHhVAu53NRod+Awdl0k0Mo75TJvjm0ikCAk+UFCD1
         VzCygLr7YRw8dGa87m49Ss12YHKtB8hoQQ72fJI7lknz+XxwVWVFvTnkDB1B4UGJeWs3
         Vd4g==
X-Forwarded-Encrypted: i=1; AL+hErHgCm0P/NJ8VAj/COKd/dV3gYUfyrJSJzEG7aCAI6KlGjD8SsK+WqTrZG+fa++2fg2EVzL2nyPbcTk=@lists.linux.dev
X-Gm-Message-State: APuU4Z/tXCrzEiix009Hk6kYgTvV36KECBOICIZat+pEQ2otGnaHOZ/i
	ZN8Nn7evi7yDJwsGKB3CcNwQmwot3d5Bx7qmabCSiw/Cfo66S2d1TolP+SJDrf+lEVOzDdEEADf
	HoVVLwcXi6lePIV7+lt8jbHfl1C5CAc2yRkM2P0NzxZD9sQ71fvK4cbE=
X-Gm-Gg: AYBFou3+iSN9aWoMnVADNNLyXB8tw4DJHBLYNew2iVZ1lYVgIK5ajP5//Qw/FXTX1Mn
	tHQ4g5QX20sk92puq8GJYze1LOv4nWY7FQrzp75+Kn6w2/FtHd5/DxHq+DZrBwvDEjSKvCgY4nd
	kE2BN7JfJnSisnsj9wuY+Z1Pbo2wuKxApYIYdgcm8vPar2YXYPyY9tvh19QsjEK+Omwz5N2jr8i
	NDARwqDnWlYVjsiRbmwjEsJPy74ZyVhbXJSkAkjE8e3X/nQtsKApNuMWR6MjyLD5g2zBek3X7Nq
	iosaJs/XgxADf9mg9QhWKh4A/ydkzSIVWGKAc9m4vI47LiA0HskYzgYVR4wpmO7Rg5qUN1NBR1b
	Y+8VP6I0Eyzfptxtx58Btr8uaTXtmfqU2Bt5gXRHv1tkdpK/zYlkt7woAkgz77sUvKV0P3dFjo6
	EKflpZE7q3LhtPxIw=
X-Received: by 2002:a05:6402:1514:b0:6b5:e088:eb92 with SMTP id
 4fb4d7f45d1cf-6b7777064a4mr2609898a12.34.1794468798919; Wed, 11 Nov 2026
 23:33:18 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-3-vincent.guittot@linaro.org> <f0bdf36b-4453-4d2f-b82c-85d1d62c5f78@amd.com>
In-Reply-To: <f0bdf36b-4453-4d2f-b82c-85d1d62c5f78@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Nov 2026 08:33:05 +0100
X-Gm-Features: AclHuK92tODV1WML6aevk1idgLovQjoH53-Z16DSkLaGxCj8dkYMqR5c5OIoS3U
Message-ID: <CAKfTPtBT1anicEwxsFRNbO4FAmfmpAWT0q-EyHqW2EHgJeORUA@mail.gmail.com>
Subject: Re: [PATCH 02/20 v3] sched/eevdf: Reset lag at wakeup when prev CPU
 has been idle
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, 
	tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, kayracizmeci@gmail.com, 
	tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 11:04, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Vincent,
>
> On 11/6/2026 8:49 PM, Vincent Guittot wrote:
> > @@ -8376,6 +8383,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> >
> >       dequeue_hierarchy(p, flags);
> >
> > +     if (!(flags & DEQUEUE_SAVE) && !cfs_rq->h_nr_queued)
>
> Should this also consider DEQUEUE_CLASS which will move the task out
> of fair class and leave the rq idle? setscheduler just adds it with
> DEQUEUE_SAVE when moving classes.

Yes you're right, we have to update idle_seq when
DEQUEUE_SLEEP or DEQUEUE_CLASS

>
> > +             cfs_rq->idle_seq++;
> > +
> >       if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
> >               se->deadline -= se->vruntime;
> >               se->rel_deadline = 1;
>
> --
> Thanks and Regards,
> Prateek
>
