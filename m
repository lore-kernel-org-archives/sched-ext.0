Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB9737C0FE
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327088; cv=pass; b=to289pQrhisKmtQckCZXFmgMtHgr7n3AQX3BN4qy0cgVb4yq5vUwLBCwgl4ShXWLliVGhsIq+yi0H9/riBBcCjehf9YjB9b6pScVN611pj5gSfYSRQflcRqO1rDsU9KU3lvv9uCQZ5gy+e6fPw90QMa9p7pnBkwHDzBQL9HnEqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327088; c=relaxed/simple;
	bh=dGB65gvZOZsPvqyMotEaPWbKX5wP30gWES9qBlnXrGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ply9/Dqg86QVQEtbyIGD5/g3+RRfVcvsCAivT1eTJ2P5uiICb8DyzJnhwgYApPdrHZUo2SUQVON+Uk+c2Qf2mvLww4awjECTkx6s51szdQYgz5ROSfKwrd/8GGvqR+KGD0j0qlcdxURN4fWWcA+EnluHKvBL5dBeUqQ32BFxwpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diVk+krU; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diVk+krU"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2adbfab4501so33489395ad.2
        for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 01:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776327087; cv=none;
        d=google.com; s=arc-20240605;
        b=J0GkvnCJ4IH7oz6Y3KYzaG6o1HIsiGYjmauylE8zuS0sUpQSyfhbciLx88tQd6Z6LW
         C+1FgoWo1OM61dW0FsBe7QuKj2JnJ+M+80ibMFHKjUxg7dtZXCL3pO2UZT9T33pYIDBi
         +xx9MlLldIOt2qtS372OSo+ckcHaE2ohKKQwViLw+bsbqv3aAJFIuK9z8G0jJl8gXDZx
         N3g8+HXrt9fLOAnzBpE71cU1RZXNWt8wMgqIjFtVO/n7gqX8pBw2WHrMrc7b9H4ieZxX
         t0aDf9hSp6reWB6BI0dBZUjGBuvW9T8krevDzaYM9wHGOa8LAHL3otR3zow/oIb1Ticq
         sLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dGB65gvZOZsPvqyMotEaPWbKX5wP30gWES9qBlnXrGw=;
        fh=yBAnk80tGgajAL/hj8Y7qM8zUSXmYt44QV107Oyay54=;
        b=JsMj47akACcozBhL0STShRlMn50QJkLgf0JiJIPRjH5bnSSKdPZwlQVMvqec2EFaUg
         R4Y1YIQvEYbEpX4Lr2ge31xXweRPGus85y5ezSk9W/4svN6sTT7FVTLCs+UZsXqFIVOA
         GqzQKxaKeALPBdHIypulySYfkH0PHOcJRNKNxItmAcFoqU9AqQoVqc3oDe+Abi3ekZhl
         kF0a2dHQ2/7n2T8Ikvyhp9oygr931EkkQGhPUm2RrLHDNPmzFcW0K3J3HIvl86NDVeB9
         7R6ItGTWPUnya288H0GHcu12zgmQ+d8FfD52Rq2uCd6m10MGFTeIMCrDEX0ob+Z5Zigf
         qPGQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776327087; x=1776931887; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGB65gvZOZsPvqyMotEaPWbKX5wP30gWES9qBlnXrGw=;
        b=diVk+krUhVZqdnBQ3DKyixgV7s4riV5vunAiHZOKx3moKqGDspQLLkw5aEYYdY262S
         K3GSyhFPgNvt+zrZ8Y/xeJrpmNoho9JHbUUIqrssjXAjFwQqHSC+50Rj1Rk6VlEp4Uj1
         1qPnXNk2ZKDH8X9Smikc6asK6JJXZBI3R7K9VYE/EhBWpu70/bre0uC/wNFxCVzMt+Sh
         +gl3mbIzK4RYwnPYViufd0TVmOizU1XCfP2l52Njyqj5lW5ZXw+Fxtik94plIn22rUj7
         KDoIozge1rvuEcZE15db9HNQwQy2clM4mQdKomY7ScEgRRWdGJWsWmAhhIQfZhqxLu3L
         Gx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776327087; x=1776931887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGB65gvZOZsPvqyMotEaPWbKX5wP30gWES9qBlnXrGw=;
        b=sp6PT5ecDqw8snQFuqRfAvD9AXeQs/jJDvS4gWGlSCm9AybCjIwS6ZnKPXiQYq3vle
         +Eh4IQgU8kJyqY1r92tvtmyE/GJGEAEDcr1mLWC+pSQy3YNypj5VxSB3GepnitMlHrtl
         yUxqguFgdVDRu+idku+okYmRkU7A6ZwXnyANiDQcrOqNpRo0Nvt0UZYTq+7JwJed3yWQ
         qG19CtKdqXudvf3DVTgUPEOJwNk3OPjDwGo4AilVz0Bt6EeXStC0C+V4gA6qP7scSQVd
         t822MLD120sSgr9FmOS49I+nhfc3dox/lpmgI9vdga7593p5B3U8OVnAf1WgSkBBvmnS
         Opwg==
X-Forwarded-Encrypted: i=1; AFNElJ+7h7YNtwq/291Pvd3vJ4xecUqWUA2dN1/EvetWVgUuMdKD9aAkP7axH/IgRkktViH1SYVE8jdMrH0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxr+cVhilpL87t5nxL1V4fvT6rDKmolBQXU2hmxfJesr9DZZ/7i
	a3IN36v19wrOqihVFB3Dblfmb+zGPMNoXFy1v2rK1tJo8ulkoMk+CH6WNzpUZBWAgLvbS9QVBNq
	z89AuGcT0tWxRZSTI2fVNzC29jp1zXj4=
X-Gm-Gg: AeBDieutfLShedwC4kv23dthFZbwreYH79HAROJwu2QA1ADbyryheif9JTJ6DN5js7A
	ScMi54OZ8sAofyAIyEYTKnKSQQ53Kfg4YJhNDZlZX09oSrjEcmkmUAPp0cyFrTA6A1oLB5ZFUCr
	V3pW4W7b5jdNcMNVKzfe27jkv2S4pXloYozMN2Jc//aX/OOWQXxZ5+FpOIzmp7oGedTfdWC5lMA
	mEvJtbd3ygjqtuLK2MEHyGtkpe076Gk+R86X4ibzp072uIDWALNQRLowPmqvRjl0zdKqrPqU9wF
	ZQtaHgdF2GzPHBOS455VKYqmhYZi15U034PRNOAaZoP/qoJocQ==
X-Received: by 2002:a17:902:f650:b0:2b2:4e70:6339 with SMTP id
 d9443c01a7336-2b2d5a58218mr260855625ad.25.1776327086856; Thu, 16 Apr 2026
 01:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260414125933.3520885-1-fredrik.b.bratberg@gmail.com> <ad539mUd8A0lDWAw@slm.duckdns.org>
In-Reply-To: <ad539mUd8A0lDWAw@slm.duckdns.org>
From: Fredrik Bratberg <fredrik.b.bratberg@gmail.com>
Date: Thu, 16 Apr 2026 10:11:16 +0200
X-Gm-Features: AQROBzCB1qfVdT-qV8WsW7BK4MvCAfOLYKrAzfLkUcyBBvGeNLz8wwHvxNaMnqg
Message-ID: <CALP2E1xwgfNmW+u=oyQ6bVW0ZeuQRZK65gR5RXyQyzy1n6U_8Q@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: add CONFIG_SCHED_EXT_RT_EXPERIMENTAL to move
 SCHED_EXT above SCHED_RR/SCHED_FIFO
To: Tejun Heo <tj@kernel.org>
Cc: Henrik Austad <henrik@austad.us>, Peter Ziljstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>, linux-rt-devel@lists.linux.dev, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I missed some context in my last email and only sent the patch (first time
submitting a patch, my apologies):

"I am a master's student currently implementing an algorithm called EDF-VD
in sched_ext, and have addressed the issue of sched_ext=E2=80=99s low sched=
uling
class priority as proposed in this patch. This change could be useful for
others who wish to improve sched_ext's real-time capabilities. It is a WIP,
and likely does not address all considerations needed to boost SCHED_EXT in
the scheduling class hierarchy. Therefore, any comments on the approach
taken for this patch are greatly appreciated."

On Tue, Apr 14, 2026 at 7:23=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> Isn't that mostly solvable by just not putting tasks in DL/RT and enablin=
g
> switching_all?

Yes, it is mostly solvable. But there can always be some RT tasks in the ke=
rnel
you do not have control over.

> The problem is that RT being above EXT is required for safety as EXT depe=
nds
> on RT superceding it for enable/disable path forward progress guarantee. =
If
> you put EXT on top of RT, it's relatively easy to stall out the whole sys=
tem
> without any way to recover it.

I understand that this patch undermines the safety aspects taken into
the design of
sched_ext: For example safely returning to the EEVDF scheduler if
tasks are starved.
However, this is a tradeoff which is fine for what I am trying to do,
and the Kconfig is
meant as an "expert" option.

My goal here is to look into the possibility of creating custom
real-time policies using
sched_ext, where SCHED_EXT tasks could gain priority over all other tasks. =
I am
aware that this pushes the boundaries of what sched_ext is meant to
do, but want to
start a discussion on whether this could in general be a future
feature of sched_ext
or not.
