Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E862346E7A
	for <sched-ext@lists.linux.dev>; Wed,  2 Sep 2026 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336456; cv=pass; b=gPFD+aFfAZ0JcK0q/pk7+KJZoUkaMAwbSlO4ZfRwqd75DzucLSwFIKNoqakbgYs/xiKlVP0m3Fc94eAS3kF414OMRaoNffkR/89tVt8BjvSRBYWsfvUFNdWPok1c0QRTMmUKuInX/d1dJdlwIPKYWyOOjKPkRdq2noHsSJzsq88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336456; c=relaxed/simple;
	bh=oC/8q0+KfLxmwtogP5EgD4eiXYFi6/BEjEeEofZZqCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNpMN81rMu6Vp0o80nl0MUz2r+M8zMzTQwPa0H0bDNIkRlmuEdBfxvJqV43MFOoRRcHVYUXoxEjLqN/xAczIzUr776mb5yXT7wl2B/mYWK+8UIb92v6doOfuuZZrP2IzX2jU5Y4nEn2qAiUvvBHGKntnceyhZVCM+ridOwQm3Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8hBJ3lU; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8hBJ3lU"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5c2c46a428eso693754e0c.2
        for <sched-ext@lists.linux.dev>; Wed, 02 Sep 2026 01:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788336453; cv=none;
        d=google.com; s=arc-20260327;
        b=Yk7pDDufBqo3GgqgmeZnPJak5OZ+cKucLZqJAGAr3gWdarDXLhcPCVZPDsTGFnSedg
         1z7KV2O+2QaQhqF3JLIgPvNqoZTXkgkCFSnFsw98iIVXMUCogitgOyB8PQSitdXi7Bva
         KC+7oKEpFqA0jWo06y1IldOxwtoRh4MCG4T5WaeF9HqdPkKLuBIF7F/d5o0aAV7lnn0K
         J9PCO01BmWJybpGuMlIRb8VV2pyx4GF3rku63OPFx8FruAtK0ZKWwbfwzSjT6JjilibH
         admY6TR+qOyijx8o7xg51+mSJW3gr1rc9NnxHzcalsGBqwDyEy+h/wmJOGiZClA0NEod
         BdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oC/8q0+KfLxmwtogP5EgD4eiXYFi6/BEjEeEofZZqCU=;
        fh=cz5WrIj8NSssA1rRhAup7RZ7jQ4cF+UQuVz6iylskDs=;
        b=L198NTU3jDwyhKtoYRUGdbkbCn9hM7dXjcVwBayJUbCAYht6dF9zphdxT1xhmTzGR1
         nZGkCQLzw+11HJo+aTevDtm8DWXd7DpMiKU0RshH37tAAi0Qi/x7r1pjmI+OUq6hvnPJ
         AkzJgmnqniWD5n9ZESJhSnNofXmw1fV078z4fgY0T29/mn4FHkUHqPtzE/B0n1ptKuKk
         5WcMH30h6sMnV8b5zFvCX5hmDpcEuRTmHKUanD1ylyYZFITpOsTQWfY3al7ffGQWksRg
         XiewRz64OPxXUgiDDVcnjAOGvQPp6GeClGL0ahj+TGeNV7F8VJT4bqulOJ6PxFvHub4F
         wr/A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788336453; x=1788941253; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oC/8q0+KfLxmwtogP5EgD4eiXYFi6/BEjEeEofZZqCU=;
        b=D8hBJ3lUm+E4Nq07vFa5XXgW/UW4ndMC2m4OA7YJ9cIRa3Z1XXOIx+UtjytEj6Dn4F
         /kjdvRVlNyaX4HbauqPD63bI5LZdYl0mEFbu6R+8EKjlXNYS7SA3IgmeeSofqOXeTXrU
         c1XNJEwE7KiTB+MHUDzu/fwSWtVPb379e5ZvI1DC2jm6vKYGGGFC1O+PP0yx732wGCES
         huk/GKuzn59HUFaox9u4bDhgeSduC7YCuArgaPV0uH3WCWiRQWGB9CTKKpWinmRT/l9D
         Fd6iwikSVUNArCGW3jYKK5wMzLMnRGO/nYwDj47en4BxXAjgIMwTR2cie+6hK6bybKUU
         UnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788336453; x=1788941253;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oC/8q0+KfLxmwtogP5EgD4eiXYFi6/BEjEeEofZZqCU=;
        b=nzeeCxeHNJCqJxG1y6WfT0WbEGORa9TRYGGeYkSlrJa/mOcih9fyqSd5Dqmwydzhak
         iw8yejv1due5KsDUy3bx3fKqA5gb/Mzf4JzNOS9TZbWuzmdxQ9AE42Mr0IgEoV/bv3gB
         6ruZikiMQNlU1+DcLQZxCJ9upGiQp2++ckvyvaoeIAzEg2HBiDm+hIMnVL32aRZ5eXKm
         hcw0WaVDZXJ0LXv00E4NLjSIyIBhs3lqfThMYiB3fYDxr2R7AbxVfJ1+yNoXjbjxB1Oj
         yS4WrOrdNWe3xscP2UZOKyQOscv4A6nAxUDeow5nNFXONmUms1zzmY2PxKQWq5qWkBY3
         5UOw==
X-Forwarded-Encrypted: i=1; AKwUvByG7sfzCEDm0z5xPs+7YPn49pdPTbmuTFBT11AzcJw76Q1lRJDJEk3zOeyp3tDIbK+sFWj+alKjiWE=@lists.linux.dev
X-Gm-Message-State: AFuF++lrZ1L/EuT5wH7rMVUOg0cL88WCdsaqhkJB11AfEISrbe4UYjw0
	VltoMhPqC8pbSiwugcmEVHr2nBOyk5o///6b/y/ysxEMa+MHI/ua2OZovZzYGb4PfTB1QKYC2dw
	gSvYfNVhqjXhH5/KIobmz6bAiwVByHq5pD00lkv/x
X-Gm-Gg: AYBFou0lc4PqvVtTmvcbmdZx1SOlhRLMIDLPvqd9V1HYxmaMhemtg3tfkZzP6uz7tNI
	AeKECdlMEF+L0DBHD3wfX1ikBkvDho2lq3M23Bd26/ml8ya2QXv5sDfJWKZuhWgMeYPeRWNZaYL
	+FumZv5EIs4dt6B621tzliYhJ8efKgBOJN9UqfKiGxHpSeoCX5XM0mwj+UPLM9Z7rpH701SuRbN
	OGD87vk3d0BXALIg1Dan+6O/h/SFbRbGxdmiiB6mJt+nWGroRXOzw9aVlno0MpYdU6bONdizlbd
	CXOvndNRZOOgJVEU2nhXZID0B1/RWZ3CPrp8CagqnTUpHO8zfi4gG6gSeulsGK1O/dDArx4tPG4
	=
X-Received: by 2002:a05:6102:2c03:b0:785:8f76:654d with SMTP id
 ada2fe7eead31-78a1f4c036amr1080373137.13.1788336452487; Wed, 02 Sep 2026
 01:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260901152212.1691696-1-michalblk@google.com> <apb7OapVwIDZV3D4@gpd4>
In-Reply-To: <apb7OapVwIDZV3D4@gpd4>
From: =?UTF-8?B?TWljaGHFgiBCxYJhc3pjenlr?= <michalblk@google.com>
Date: Wed, 2 Sep 2026 10:07:20 +0200
X-Gm-Features: AcwNN1Vr6pBJpiqvmKdfqrS6i2-zQNc__YmHDkZwqP2cR0JjcyJ-U-b-wSM9V8I
Message-ID: <CAD=VTGdfHkt6QfEOOYWBkGaP5dM-eTCFtFA6z-ECyqm+UbXB=A@mail.gmail.com>
Subject: Re: [PATCH] sched_ext: Use atomic cpumask_clear_cpu in scx_idle_test_and_clear_cpu()
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

On Tue, Sep 1, 2026 at 6:20=E2=80=AFPM Andrea Righi <arighi@nvidia.com> wro=
te:
> I think the atomic clear makes sense here, but, as sashiko also pointed o=
ut, it
> does not fully address the race, because idle_smts is also modified by th=
e
> non-atomic cpumask_andnot() below and cpumask_or() in update_builtin_idle=
().
>
> > Fixes: 48849271e661 ("sched_ext: idle: Per-node idle cpumasks")
>
> And the race existed way before this commit, the idle SMT tracking has be=
en
> always documented as racy and self-correcting.
>
> This change may still be a best-effort improvement, but the commit messag=
e
> should describe it in this way. Did you notice any improvements/benefits =
with
> some workloads with this patch applied?

I was investigating an automated static analysis report from Sashiko
which flagged the use of __cpumask_clear_cpu() as a concurrency bug
that could lead to lost updates. I mistakenly assumed this specific
call was an isolated oversight and that the other surrounding cpumask_*
operations were properly atomic.

I hadn't initially realized that cpumask_andnot() and cpumask_or() are
also non-atomic bulk operations. After reading your explanation and
looking closer at the code, it's clear to me now that this non-atomic
handling was intentional to avoid lock overhead on the fast path.

Since my original intent was to fix what I incorrectly thought was a
strict logical bug, and not a profiled optimization, I think it makes
the most sense to just drop this patch. Making just this one operation
atomic while the rest of the mask is manipulated non-atomically would
just be inconsistent and add unnecessary overhead.

Thank you for taking the time to look at this and explain the
context to me.

Best,
Michal
