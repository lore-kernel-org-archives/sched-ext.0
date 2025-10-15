Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066F221CC6A
	for <sched-ext@lists.linux.dev>; Wed, 15 Oct 2025 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537159; cv=none; b=dmx/Oi94bTufLzQ9p6WlrfeGwVVc740+PYN1AeGwNwbgv+JhQLbCTjNYYZqck8vluHTwVEsuwVTJknmCs0qIbuIKYNOR4pJXIsCRfoO5ucrqF+yTfntYikXKMLVZ0Hrsqe5W2OTcNMSLVeZvcKomlExDq/v4q8+sKQGuN4t0KyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537159; c=relaxed/simple;
	bh=LyufV/Oxmd5czwod8MbqOItND5kZumwbyc5sLHjKcZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uU8SIIPv0VBzBjm7FoXQUFAWbbm6mt873IgGulRitRbbeapqZi1b21mG4TIJf9MXwng+99k1QSe7C1RDvpxkR3e/hui3mMJeLVAOR6IBJoVqrt/CAPw3V3SVfFLJ+7ZMGJQTd4QGFKF41KJEZFeUSLiiaMXLukdOJ18kLofuBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyRtorRv; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyRtorRv"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b62e7221351so5424479a12.1
        for <sched-ext@lists.linux.dev>; Wed, 15 Oct 2025 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760537157; x=1761141957; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Izxb3W52HRiZqSQiVAIiwV9HWtk23rrXM2SEP63D5wg=;
        b=fyRtorRvRYjzrbbNy4o5TsybGpYUQgY7XKVyPa0sjtcSF1MNvtJZthFIr4O6FNEoTU
         bIXHwdWiB98oQ8Uh14wpkQcn+LAltXJt6f6/M9ygN5NugXvULPZyNQ+A5Bq3xkMMsvzh
         6eZVmJypAVemaIRISO7x8NO34sdI3zaye3aWU4vh0RO1C6hhhb8pK31B6f7bEbxL7/M4
         lPm4rS2mTaz4icphfuB3Gr4fiaL9nAuXNGKtDctad+bmDZEFplk2H8C53hGXOAnVBoCi
         UBuEBpGAES7ioykt6K/BUvL8zszTIsq74I1Hm0dkbo92cbc5hTNrWyB+19I4W7T2WDMm
         SeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537157; x=1761141957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Izxb3W52HRiZqSQiVAIiwV9HWtk23rrXM2SEP63D5wg=;
        b=rtwLpgXP46vI4vENNhFXBQfGEK9rqQbZXyulFLgh9dq1ZxUygsSNECejEhXWdKRwM1
         UMvl47jZniFNKwOKkObhXmp5zTsxbUZT1jplDFvSxGMi0bMjp3QvnH5py8LEu+wjTFFN
         N5Qos+IwF8kXwQi4Yv+FcR8YMF1sZEfEfPIc2qrhdttqauta0BCAz4DW7MSpeeK3F44H
         c6B4YamRwpeM5Tb/FndYiHSUDQwRjLNQ2W0LDww9uQhk4EHtbkuyRouWyw5n4k2Apvq4
         c39pfwKODexT3SW63Cl6aIzZnL9bMGzAArLUIAmlQBV4dw/1Sct6tGn6zaZbrXSUdUwD
         IwSA==
X-Forwarded-Encrypted: i=1; AJvYcCVg9z8pBSF+R8mVD94+sc41cdJ/uah9eRhXTqr2RNUWc1CW7fimL0KKRaEhL1NARj5xjdULEQdCR6M=@lists.linux.dev
X-Gm-Message-State: AOJu0YzrvHfCelVnb34OgKDkX539FNmjiokHPTw+84PJHIpiJEnsm6OK
	p9xelv1KrazU9s8zPaKsTaTXtEpzt2kv2hT6MxXesEqWmNn6gYZ1fvLskHmQY/LXuKWt4O4TB4m
	7qLjeqfvzjblw0rt37R6GjoMj9TEkH3GYpSF7emc=
X-Gm-Gg: ASbGncuyS3GXSj5fKy5Ka9FPLwkZDx0lSbjQ6Dy/pTWX9r/zj4/QRC4mHFkjkviDPVk
	jcrVKjr2yAiKWDDboa7ZERw/OZwlb1JaOV/NxZk8+Dk9ayQUR1lTuFq6XJ4QjKHAVD77I5qdCwV
	o6H/FxPgOVflHLIWutRiu3DnVr9yc/WkI76ROS1Uy1+FnbBnpwMruarQFpLiDq7++fdz++I+GuZ
	T80nd/5k4mHOBOfW+PzVwx/+zHETxBOCYQnyzT5vHxW9OApWyWi2fST
X-Google-Smtp-Source: AGHT+IH80BdRo+6CXpDD4C5IS3FGJwcCjZorcKzoOP4xMkMEbleLUevb8W36dulFWLdsi+QxlI8j9qgAZsAP3mY+ua0=
X-Received: by 2002:a17:903:1b0b:b0:25c:d4b6:f117 with SMTP id
 d9443c01a7336-290272c1ab0mr388440805ad.35.1760537156603; Wed, 15 Oct 2025
 07:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251015015712.3996346-1-rrnewton@gmail.com> <20251015015712.3996346-2-rrnewton@gmail.com>
 <a469d0fb-62f2-4286-901f-b7a634d3e0c4@arm.com>
In-Reply-To: <a469d0fb-62f2-4286-901f-b7a634d3e0c4@arm.com>
Reply-To: rrnewton@gmail.com
From: Ryan Newton <rrnewton@gmail.com>
Date: Wed, 15 Oct 2025 10:05:28 -0400
X-Gm-Features: AS18NWDd9xa7otKnSJo4hIQc7ltt0-qgZkcRUOmzit0PnMit8CE93FLvuAfl8oA
Message-ID: <CACYs5Aax6X_8hrYtjC4yAMy5K6e3CwxSjEiW3mK8wfePq3oyBg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched_ext: Add lockless peek operation for DSQs
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, tj@kernel.org, 
	arighi@nvidia.com, newton@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:46=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
> > +/**
> > + * scx_bpf_dsq_peek - Lockless peek at the first element.
> > + * @dsq_id: DSQ to examine.
> > + *
> > + * Read the first element in the DSQ. This is semantically equivalent =
to using
> > + * the DSQ iterator, but is lockfree.
> > + *
> > + * Returns the pointer, or NULL indicates an empty queue OR internal e=
rror.
> > + */
> > +__bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
> > +{
>
> Obviously there's no guarantee that scx_bpf_dsq_peek() will return the ta=
sk you're gonna
> get when moving a task to another DSQ or a local one. It's pretty obvious=
 from the kernel
> perspective, but I wonder if it's worth documenting here too.

Hello Christian, thanks for looking at the patches.

Absolutely, whenever using a lockless operation you have to watch out
for TOCTOU bugs. In the schedulers we've experimented with, doing a
sweep of peeks just gives you a higher chance of getting what you're
looking for when you subsequently lock the remote DSQ for
popping/stealing a task. I can add a reminder in the comment on the
function.

> > +/*
> > + * v6.19: Introduce lockless peek API for user DSQs.
> > + *
> > + * Preserve the following macro until v6.21.
> > + */
> > +static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id=
)
> > +{
> > +     struct task_struct *p =3D NULL;
> > +     struct bpf_iter_scx_dsq it;
> > +
> > +     if (bpf_ksym_exists(scx_bpf_dsq_peek))
> > +             return scx_bpf_dsq_peek(dsq_id);
> > +     if (!bpf_iter_scx_dsq_new(&it, dsq_id, 0))
> > +             p =3D bpf_iter_scx_dsq_next(&it);
> > +     bpf_iter_scx_dsq_destroy(&it);
> > +     return p;
> > +}
> > +
> I think there's an argument to be made for this to just return NULL on
> !bpf_ksym_exists(scx_bpf_dsq_peek), the caller needs to handle that anywa=
y
> and at least it's guaranteed to be lockfree then?
> I don't have a strong leaning either way, probably is fine if documented.

We went back and forth on this patch a lot, and did explore versions
where peek is "best effort" and its semantics allow it to return NULL
for any reason. But that provides much less information to the caller,
because now NULL is supposed to indicate that the queue was empty at a
point in time. For that reason we ended up with this version where
peek provides both positive info (something is/was there) and negative
(nothing is/was there).

Best,
 -Ryan
