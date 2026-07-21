Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CB432BD3
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617787; cv=pass; b=cidtzekTSgwu3WVSbEvZN6DtgpzEsXsQEZiIJSXS0EO83YtMUn7nna9HFvGPTY768tPEO17+bciacHQob2OW9OBgkF4VkrPEb3ZCV2q4vrLnwxtutI7LT3zi9UJpih1zBHqR3qRQEw85iMLLyUNU5rbMSBXDyw+ot5iBqIS23/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617787; c=relaxed/simple;
	bh=IxkQz9Vs9QQO8JBKj1egBC4jkvEPPc6wvjf5Ueh6/e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7AJoOF1pBMpDNcMDmV7iS4iNQaODAdNYwxvrkg9ViybpVq9KJd4hHlNVLHtT4cEzbLiA0oIkmOKWqCBNJZ250xH9qb3LWMhF2lwqk+4l6QFNNSjC6T544ELPRX4oWSZogMlB6D3wZmsUvBbJ5y8xFvdl1saCeDUP1gZaU/oCIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOWPElJG; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOWPElJG"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e041ea211so8874099a91.0
        for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 00:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784617786; cv=none;
        d=google.com; s=arc-20260327;
        b=JCEh5tJI+upGhQTdPjes0aX+mjX4BsoYdjsgo7mOFaGc3uV1oIgYtXpZWTJRZQLpG2
         arW3Skm69zYrxBdl+slqN85d5OBenmiwWAcyP5jHhODyonjcur0Zj/0PIOEUU1CSU+q2
         svqWh66cddn7VYIGW1Ko/BHhGxjgO+7rYlxJSg/oJfVjmWD7GZIBV0jmx0AaRKbWtISD
         N5TwQPHB4aJ/AdMnkdBVDM4X+4E40+EG74QFG51Fx8DIWzu9b/vA1Q3uuKiS8PT5gsZI
         mb6C6G5Qh5bhZZTGcRLN8NM0gqi/rD54oaVllWPcSwMh6PhrniqeXcny16bC85n28KIW
         57/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IxkQz9Vs9QQO8JBKj1egBC4jkvEPPc6wvjf5Ueh6/e8=;
        fh=96fKUM/Pd+O8PWf7dya0KFaq7SHEt5nwkUjnRqOKfWs=;
        b=GPNPl+nlPFFREcWMbbsg5NOGymUCzdHen/vX5C/qQ9uQ7L/SXPQU9J9l0PA++WCato
         /GJHJuIfTE1yIp4jI8S8qoCy9/mIrwDaE+JK/j8s70kx1Xl5mjFgUa2TGU7kzNtXumvH
         MZvsaLS7/ptCFKLu2pSlYSFEVXqIoLYuKS/0kch/oX7mp5oQXnr5cljHGvVTL94RVIZx
         BQJU0Jg3RpN60I+GmgMV8OS3lmL5trqtoynfFubG2goYWCYd8EQgxN9XiBUi1bIItfsA
         C896a/w9Mi0urcJ/g7gtG6QAPzuWTrqFsKXmVClYHOsp+1KQ5lEoLKasWGW0ZH1b8YCy
         aNgQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784617786; x=1785222586; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IxkQz9Vs9QQO8JBKj1egBC4jkvEPPc6wvjf5Ueh6/e8=;
        b=pOWPElJGbB/9Ay59V6Uf3lHvLHAPmNzh5+Uotmvl15riYlzXdWpECnchrqWh+WGbct
         bHAQnbSj22XvHl3VG7T5dR6523KaKGlQk0hwgIF/Edkz0PwFxqC3sW65LQ8BTysq9dbZ
         cO2Nhdj0yINaN2T4O8AdmeV4cq1xBFWX6OCUx7EsvqhY63q+zWZOdtX1rtmL3QCJHeWg
         ABMQpbsRP4J1jR/glhP6ZJGYVOG4tgVB+FaRERRF5FDwNne+9gmsewgzJYsilQN+ohyj
         IzLEEqousSAvy6R2KOzZoh5nwiVKZP9ZOHqEJkGnEZtIVImN5gcyHU1xeiLdvRj9688s
         1REA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784617786; x=1785222586;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxkQz9Vs9QQO8JBKj1egBC4jkvEPPc6wvjf5Ueh6/e8=;
        b=AYxDyOxhAMLN3pb7B+2iy8jWX61AduVMdK3gy69dtCVU5tfs9+1mDnunHKonWHlqI9
         MsxeraADGSXcK4AHunc1n0+v3vvozri+B9sdJsx6Y8B6MsO5N08ulAcGVHfTshQ17wue
         1Pe7U7uE0OwjPesMGqDTSqEeULuecwtskjNQFY6KxP7XO7W8i0BiQAHx4kcIO5q4Tiuh
         bfEuqJztvkVYymCvIVPt8V5W+Sa7hjz6w5fkXabl6WT4N+VOHkU4ptCsMKbHtzu/n/es
         eaqAy/xFhG23tVyIDzB6anEhYW1ieLmHeN+GKyUQPmpFF9KHdjh/Zgn8+GZYxtW+dJlM
         6Hog==
X-Forwarded-Encrypted: i=1; AHgh+RpF4mUpskjolEIs/E6DDomzVEGAEtcHzowApsbPm4UvPfnSnbrJhtwGJKAPO1bIzdpbQ+Bsf2pubDM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzWQt9+f7ufl0HGo/F3op98YyeNm7IfR0VTFDJYrXAQ0KyYk2O+
	8oY4vhgZvWKrJbuuCCwZJDvJczFTAHCFa205H9E6aZhQcMpc2Lp7xPmx5xBws+PoYXZPmCFEwvL
	FsHs3wmZ83j0k8hgA5mmcH2Ye8LX7fEy60PFNZEM=
X-Gm-Gg: AR+sD13y20k6QcBTgjSgRmuEBXKh6mG2ibyxksirwoa0kfN4yADMeoCtCpskSFHOT7g
	4rhqGyH2VVAxRqF7rdeZGxpXFeVn7kvUlzEUhY+d4X+/9S4NY/EzhXTIci8+gXNEC8WJIjT0qC5
	dDBl1/Hmp62a5QecIaNhDpqNnC6N5He5bs0nZt5dL28ygXrFz9/vvaZlidpa9VKPLCvWT9U7YV7
	YbpyqphjdhvEshegE2EamA4KL7SBvxyU8WHpdObPHxvIvSgwbif5k9X/ogCs9qxIrix8Tyf8Jzi
	MawxEEaS+6qDRLSzBcvmGANBSXPTUqimxFCct9u0JfUAPj2x/beussaOGx9i3fBujZHEiY8IVMN
	hwRqzLN0xO1fbag==
X-Received: by 2002:a17:90b:2883:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-38e4b431219mr19935193a91.15.1784617785259; Tue, 21 Jul 2026
 00:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260721063242.552774-1-arighi@nvidia.com> <20260721063242.552774-7-arighi@nvidia.com>
In-Reply-To: <20260721063242.552774-7-arighi@nvidia.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 21 Jul 2026 00:09:33 -0700
X-Gm-Features: AUfX_mzyJjK50Uu8wVZC1pw0Ou1892oKYhSWVX7ED_ESQnWN1MVjDCt-PAcGT2g
Message-ID: <CANDhNCrFgjFGF64w_B52x3+x+dEH0wT0-+nOGuHzRe68QR2Ltg@mail.gmail.com>
Subject: Re: [PATCH 06/12] sched_ext: Fix proxy-exec race in consume_remote_task()
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

On Mon, Jul 20, 2026 at 11:34=E2=80=AFPM Andrea Righi <arighi@nvidia.com> w=
rote:
>
> Without proxy execution, the DSQ lock and holding_cpu handshake ensure
> that a task cannot be dequeued or start running during the rq-lock
> handoff without clearing holding_cpu.
>
> Proxy execution is an exception. A task can start physically executing
> as a lock owner while its own scheduling context remains on the DSQ. Its
> on-CPU or migration-disabled state can therefore change without clearing
> holding_cpu.
>
> Keep the existing lockless destination validation unchanged. After
> switching to the source rq lock, recheck only the on-CPU and
> migration-disabled states when proxy execution is enabled. If either
> changed, cancel the transfer and requeue the task on the global DSQ
> without treating the race as a BPF scheduler error.
>
> A rejected task may be requeued onto the DSQ currently being consumed.
> Snapshot the DSQ sequence and skip tasks added after the consume attempt
> started to prevent repeatedly selecting the same task. Keep this retry
> bounding confined to proxy execution so the non-proxy path remains
> unchanged.
>
> With proxy execution enabled, stress-ng --pipeherd can trigger this race
> and migrate an active execution context, leading to
> sleeping-while-atomic warnings and subsequent lockdep corruption.
>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

So, I've acked the core scheduler changes, but I'm not sure I know the
sched_ext logic well enough for my ack to be very meaningful.

However, as a sign of general positivity the series, if you feel its
useful, feel free to add "Acked-by: John Stultz <jstultz@google.com>"
to the entire series.

thanks
-john
