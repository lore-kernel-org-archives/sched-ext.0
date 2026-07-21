Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CF02C11E4
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 07:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617340; cv=pass; b=bu8GfLB+j5dG+XLVjhMAxYeF5mfXLbOeLQUkEUyVZzBDY0DU8HWkVAXmDUmzJl7x0x5NTpHvgDOmZGpj4mDMf4wMiXWsZc1Zb5+aUvLBY3CC5CVysaFTIZHgKt9VPd1tPqGj9A23z9mfV+KGZKHcdMwC9YqLnxbmXnXyvpg2cQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617340; c=relaxed/simple;
	bh=JARzrLqnQvEgBeB8KCflCeB06cCLs5i5rU0FoC5OqPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNdY3+Rn0AfRp1dMBW5+XaJtPAzxWp73yBEPg7410ANg7Cw/qQ7V922AjvgAypoGFl6+6j0/Irb9GLRj1EPmxvcURHyRTVpEOZbIv5oQa7HUMPzf8cBPrByLDPSdFEJI8cwOL7rnzUVTKrWpo5duTc26NRx/4dw/yrllcd+Qthc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TbKiyO3B; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbKiyO3B"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so7026974a91.0
        for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 00:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784617339; cv=none;
        d=google.com; s=arc-20260327;
        b=jOG42wkyjkMAMGVR2qvlMrh9HfDAND2ObFu8jYAS4nzy9+a59CuFSvG4uUzRfLZkZc
         C8pZN7Igp/ozFCEUg8bqrKN/XpRyjHeyFKPFv5o9NbxstTszp8LJO7mADyCc+pF3VYu1
         Zx0Rcj2nWLlLxPozdtXczugSa/np74a6VBj1e4+xGcuJqGJRfU9zG5SxXXNS0b9tvnJy
         nw0n4OG7742B9aX5UVSAYyOSHRC6qJxnfqGzXennDTraHqSm3jZtG/cwqj9tRT960Vh+
         WsKFO58DAPQHHGVjtX2dvsXKAKAdBqDvTJGBVUEuNG+yae7nCLk5KAhUfiHaVubuwcPT
         DvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JARzrLqnQvEgBeB8KCflCeB06cCLs5i5rU0FoC5OqPY=;
        fh=nJgwk62bglFEBR7c3BkJzn0inE8PIZqIypnfJZnn9uE=;
        b=N/1zoZkitmCz+h4dVtjsKnQCWOux/Ig2nrx8Nm7QZP4OXS69CchuSece01KQ0yiv7r
         3QeEAgFUG7844Slb1yecHDTbff4BRS/U/uu0yAk1KLLAvHNrh3SUHTybK0eRF4A2+Pxc
         4dwg4bGEIGriVxoJ6vz26rKoSd8A80l8JGbqwboGMZ2ciajH7ma5Sf6JL2UwmuBIgvh8
         T/Of1AIk/jOWYqmIcTu/MuasuPyH3YDfup/QsKkhmWF5uVI/G66HHCpW7GZ9hIPaLDC1
         MTu5jxKaknnFmhOZvywoxdN1OOYTKkzPVV1OeKGolYgENsnU+AZqPHuOT62RQlybuC/T
         PThw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784617339; x=1785222139; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JARzrLqnQvEgBeB8KCflCeB06cCLs5i5rU0FoC5OqPY=;
        b=TbKiyO3BuX3kTaf3eoBCaZMvs46tuv+hwHikF/FfGvjMf6oOQbGbkvkTNeG8c+CG2s
         nVV0dy/BHdIyEnVwPZwP6JsMZpqK8uBNq0kmqzjmzq3pjpy60pMT0BFzo3k+F85GeDuW
         I4AuQ00GZxzPCzJBqyJEoV57/rX3P1OOX7KDnxvF0EWNr3KrViTZmeL6HWpnYiV/QAJk
         h4A94E3nrlcDooWs0KjeyIMLELm4soNinhdBenjqH7na2phHe97VEfcRyvIoGiUEocSk
         IWAuhpmGk9Bi45dsPQeNzfl2l5Mw/jJRCW8jSYcFd6MhSjXAO4FDvfApNyCh+kphUv5v
         AivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784617339; x=1785222139;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JARzrLqnQvEgBeB8KCflCeB06cCLs5i5rU0FoC5OqPY=;
        b=fmah0Z8tqNqT6nKeeTtk48aRmsXY5EbKvhScGzHpA92gObUp73pVnOT99Uwi4RKO7f
         EwPpGYEwlW2tT0RMhGytEGHi2UrqJbAPGPfA2Cw8QL26yNLc1FyOnG2iEwdlBS0N+3gU
         P3NBcgcPwa0iUgsxAa5pi4VSBaPsNyD4Ew0Pry6X8zRiyyn7mkY9p1cJj8bYblMue7hI
         iGUxJ6Ajjm8H1IaAibc3C3ajkGJqSpDbEqAmp9C9mGzxfK7wUht9M+OAZvBdE8jCZ5Ey
         3m7AyRR0BuiZtJ+RbpiWNHKvxf2AFKpr9ZtrlU5SJzqfMum0XFbJJXyCYXt71h/ps9ii
         rOWg==
X-Forwarded-Encrypted: i=1; AHgh+RpylWYwmiktdwdfgFHj2aM8GseOZteGRc6t12O7eRZtB6RATu91aKCFdt2Axxszh/IYbKVkesxWPRw=@lists.linux.dev
X-Gm-Message-State: AOJu0YwJi9ov2IoXJ6tk/imFY3ioeDfzPdjhJdu1TZFEI8E2ceBpmJE8
	U4gwcIxxJJC2H969WUO5frXg0yO8DLhZSinHW+Zi3wW1GG31XaGpXv8UigAuY8i2ZL6ggwcJNRG
	crZG74hDysCZbMYzmAChmpQpOy5RxCFLXaWJ2moI=
X-Gm-Gg: AR+sD114/5WPWg9VHELpQWbwZVKc6cAry3PJp68SQ8CejLtO6wvjFdSOMgPHQxmIAC9
	S4yD9MHy0kffiF6JbVLeBUsnIfbTwyvOAs5oO9Kay7DV/K6tKaKDzWmCkmfbqLrHcFdszWU5Lt8
	hBRtzUCnTR6JeE62cpnf9j9rzkVwlAI8Mh29TWFr1kZ1jef7146wbObUEUjeNJjgao2xr6JCSyR
	qlL2jiiw9vKkePehRDeT+27C1zhRvF69U+8v1izb/DtqLjrjZxAiloXiDeopNl0OgWxP5dmw4PJ
	su+e9/bpTRjBzvagppDOJyJttlUIlTZOSE5ldXG+x5RH3yUJFapl4Pq/7BtV21T/lRveETXbWai
	6yL8JidrQbqm9Hg==
X-Received: by 2002:a17:90b:5866:b0:37e:10d1:c05b with SMTP id
 98e67ed59e1d1-38e4b5166e5mr16648699a91.22.1784617338392; Tue, 21 Jul 2026
 00:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260721063242.552774-1-arighi@nvidia.com> <20260721063242.552774-4-arighi@nvidia.com>
In-Reply-To: <20260721063242.552774-4-arighi@nvidia.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 21 Jul 2026 00:02:06 -0700
X-Gm-Features: AUfX_mwR3JvFbKfVlBbxBb7xkVzqMSaXM3VVTzNUAF7HoTdNkBH9kJQxTMyDofg
Message-ID: <CANDhNCqn59srtp0n2ZuLp-rd3x8ky+DQoMXY88+zKLKt9sxakQ@mail.gmail.com>
Subject: Re: [PATCH 03/12] sched: Add helper to block retained proxy donors
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Christian Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, 
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>, 
	Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 11:33=E2=80=AFPM Andrea Righi <arighi@nvidia.com> w=
rote:
>
> Scheduler ownership changes may need to turn a mutex-blocked task
> retained on the runqueue for proxy execution back into a normally
> blocked task.
>
> Add sched_proxy_block_task() to perform that transition while holding
> p->pi_lock and the task's runqueue lock. Reset an active donor to the
> physical current task before blocking it. If DELAY_DEQUEUE keeps a FAIR
> donor queued, the immediately following sched_change_begin() completes
> the dequeue through switching_from_fair() before recording its queued
> state.
>
> This is a preparatory change to support proxy execution with sched_ext.
>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Acked-by: John Stultz <jstultz@google.com>
