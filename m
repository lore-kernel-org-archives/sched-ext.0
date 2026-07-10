Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D94138237D
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783715687; cv=pass; b=NDJ3M3F4i9vsjJxe6jt8oiQ4ESZRI2raSlZ+BNMK9RYxFj3IbAcAY7iMZKdu5kg4FZ+3BRbl8Sz3NukbyxwEg9B0GV8VjshAuZbLw9RQDqadm28sScczkxAr+LRR3st4ih/4LBVcSJoH0AEEd6np8TDZidewu2zmosiZpDu4I3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783715687; c=relaxed/simple;
	bh=5Ef7X/Kg3mKH04Cd3UXn/P4r6Kfue0PWlaV33hXZ8w8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ji8ZAnS5Ka8KHRRsB2xIaNKpWoOe2DWiZqdbqy+vXfLlaQqLJcie4M0UOYz1DXyc0cxAnW4beFV0bH//FJkhjgMk8k1J9trrx1f4He+TNE5CoP/2llVLtCUvnEwoWpyh3me4i0tBZDixDlUQnwNC8IYQuzBZ/VbKn7jYdh6843g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnDKNkTM; arc=pass smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnDKNkTM"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-4730b8edae6so219702f8f.0
        for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 13:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783715685; cv=none;
        d=google.com; s=arc-20260327;
        b=BJtgaiUQkbBFR0M2TlbJZDBGomIPAbrqDad7J713AdVNmPos5YyTCXqopudPbjDylW
         mRZQCtLvsgeD0jc5xtyit4qqrMbQ9mzTd5ICFEN4TALhdSIWVjlUgl2Z1H6UUxUFTErI
         QVjy8ncMfmLlA1UaYr39+P9o0oGFmRh486GvCl9C4OMVNwUDXftsPsvtHyBOjvu6/BTp
         krcyXiFnFWmCmT538Z7IhVq2YvosPoRFgzr+gP9uLnp7UfGHB59X1aP1Gvz1yrnmrORQ
         gk0+7tyk875xOzMO/dHUyt/X6fYN9b9g5zyNvyFVZolAOrsi7mBtIfL8J6VEpIl1643m
         qLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Ef7X/Kg3mKH04Cd3UXn/P4r6Kfue0PWlaV33hXZ8w8=;
        fh=lvYlF7SCWdrgzzOLx/3DT+/xBhkaVGuhZ7yByJCyiPk=;
        b=Wg+/O7z21LsUU6asmWucHuXpgg2z4EJqyweTEkkNBHKjrhbNk33+pfMrjxor1ZY6tx
         Dis5kLoHpyhYrpHM5d+qQ7c/bN2z6P+afU1b/1XEjqol0MF7+BnmdGK73L4ZwLBw7L5I
         kX/Krn394I6pzWYvu8Uynp8+z02sBIXLONWarHdhlU5tFO9YjEmhpNXxATFAxyeagaHJ
         ote4EaYiMrEa1x9OWFWVKVhotvjUTb661ZXvIYnd5r9ZMD80BSaHTQAkULTvcbhAa6i9
         dm95gwLNbOAocbi3blTcQjgQbjr8LWf2yarpw+3KUdeupWCKDj7B6DAiSR5swztxT4yr
         ZO+g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783715685; x=1784320485; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Ef7X/Kg3mKH04Cd3UXn/P4r6Kfue0PWlaV33hXZ8w8=;
        b=KnDKNkTMonCxhSKRNEA7u3XPdQH20yoK49tKYxH/Q+oABGW9Ai7ms7/xx6GNywHNCo
         JWpQPmydyP3WGOnA+Ya1TEQ+UgMuDLp+HidAbBLiu3ay69H8ncabqOEP1DEuKUNN8RO1
         OxW2qrWc3cAJ67t0uwugBuLAlInspqZLcgLzh5OHj5ZFi7NEoAjBk+bCm6JxLAtg/Vno
         Q11/RxsURTkkGk41dyQmzHKh21e+t5kYdISmHSa3ST+bUSoDimfRJqQPYS4JAETiOuhG
         xiOt6ehO5S9mjEHtNTeJ4MZTrWGIJS8i6wI+yta2GOiXccwPgP5vhUethvpKXf8xwRLk
         m2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783715685; x=1784320485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Ef7X/Kg3mKH04Cd3UXn/P4r6Kfue0PWlaV33hXZ8w8=;
        b=CSs/2XKau2uLFDGKsmqv1ca1R3tc4UKWLtGVNmkkMsGTUJyhKP1BD6EB2aTxfeWzHX
         ZPaAkJmnFKD9x6u/blmzpQM8P7kbfYzgeWqRjtii8M2XocYjXs8lTtt5v91bEn7n+WdY
         2uzkBFb9TOkNBr/bIT2jJyq8KwITy84fcw6GQ6o/07mB7ZuT1I+IXJ/xiXkkO1blBDNK
         E7Snzo51S1UahTovFbMQaEWHUiz6PoG7V6E/xARsXJFFXuaV0VMHfI2EIAklkJv5BJ42
         tqv5t6APauH81CSRO5NQZiYcRos0I1unSEGlpDV0yiNqzVVf4RrsqgT+cF9cyhWouytm
         czfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqD9wjXUHo0fNdvFyxt3x5Api2t8vX6nxbzuC1baUywgnY0YSu/848Q17/namPQUzW8mUtpSSLD4I8=@lists.linux.dev
X-Gm-Message-State: AOJu0YxwTKKs79w7OB6Xw/e9i5ppT29RgODIASFnvEmFblPwiQfV+64Q
	w4/EYT6vkmq7+H7UdP3NS1pMEqHV+Ej8c4bmx8FQpq5y14HYVDXDyjyRrVGwC/QudlAfAj0IIEo
	U+UtJvkvb85BQYvumHC7GZ578cEJV1e+bditg
X-Gm-Gg: AfdE7ck+Wjyt6lMiRfIE3ZhfABYrWJWLc650T2UGyA/dPKBwv3fnyMCZKwMPlk2lmy6
	CEEc18OCKNXaSmxG2S8G9ZNVhY9RdqWldVrf4LWgduLxWVaN/cIMFcyt5WjRjErVR0VW2pykVNq
	gnmOi60TuRFJnKtiq4dPwgtOAlVXvOmSOILuf+5pyPE13GHXwBYLRv+Y0TqBRFs2scffTv7tBoG
	vZ+Ra9PmAFrLGbabCMCyeB0U3jWqz1cbsHBgqE+fa7bi3uunQNmOJNGDsxMQ8fYJ2xeArSXxU3U
	KwZ/uxqrAUV5efiszSbjZ+jjKAMP30lOaeJfszWxLpcacXc9T4ZCa8nUJ++EJ0EWEVQ4o7T/Vp4
	WRbYHpyvjvXzm2Jcm4wdwDJYuZdf4tFYzpGGdPiSxxXAvre+dzo3S3zkxRb0=
X-Received: by 2002:a05:6000:1acf:b0:472:c426:2ce9 with SMTP id
 ffacd0b85a97d-47f2dcac21amr295085f8f.12.1783715684524; Fri, 10 Jul 2026
 13:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
 <20260709182800.2037938-2-main.kalliope@gmail.com> <20260709183918.E42371F000E9@smtp.kernel.org>
 <DJV4TO9OH6AN.58C10SBPE8FF@gmail.com> <CAJZwKki8MwOmij3JZK=KnnO0hEUuxWA-iY=GK-TtvtVRvOkjOA@mail.gmail.com>
In-Reply-To: <CAJZwKki8MwOmij3JZK=KnnO0hEUuxWA-iY=GK-TtvtVRvOkjOA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 10 Jul 2026 22:34:08 +0200
X-Gm-Features: AUfX_mz3R7qvDlP1KDXkHw9pd93r-GN_7i72AGy5AR_OgDccKGsl_2fsjDQ_Wak
Message-ID: <CAP01T76KdhEsbZj8yZN-yg5ogx99Ud87qqrhOGXTrX1ALdAgyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Require a BPF cpumask for bpf_cpumask_populate()
To: Admin <main.kalliope@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Jul 2026 at 22:17, Admin <main.kalliope@gmail.com> wrote:
>
> On Fri, Jul 10, 2026 at 3:18=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> > Once this lands, please send a follow up to address this.
>
> Thanks. Patch 2/2 covers this, which updates the cpumask_common.h
> declaration to take struct bpf_cpumask *, drops
> the struct cpumask * casts from the existing populate tests, and adds
> the borrowed-destination rejection test.

Ah, my bad, makes sense. Let's just wait for others to ack it then.
