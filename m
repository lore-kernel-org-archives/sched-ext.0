Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EA03AE701
	for <sched-ext@lists.linux.dev>; Wed,  9 Sep 2026 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947191; cv=none; b=CUQlnf+Hh1bleR3Ts/M5lyrg0YcoImp6WNZRW0HNaKKMU8Rvqj6dFyYsEtvWMJF0Umfn92j1YUfJuXAiovPFNpAbBx5yXx2tqv7Y7kgPecyRalGnXZe6KwC2I1B+V8767a8tsS30if1y7EbO6fyw98+Zih9DCmIERNsvPNf5eiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947191; c=relaxed/simple;
	bh=p0rFHQFStQT/DpBKuRsFBnyoK7x980aoh9fzzELVu6g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SBIzDCjc/qZ2GPtRGKchVBJNROtwPINvdB+G+rZu61NcBfrp2ipboDlCF58BBCRqCKKlEGKXFZ0qPv13p3dnZTbuhYeFHez2PD/2ZR8OzcXHLG6PNfb8zAnmCeAj0wfxB5QqqqCYG+ez2XTqrQkhAglCAWx0NlNJSqRkSuPwabc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDfp9DEy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDfp9DEy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765871F00A3D;
	Wed,  9 Sep 2026 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788947190;
	bh=rzxxNiiz9cZzQ/G/UBWPM+Q0aT8IFV2AhGBKlt1bg90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mDfp9DEyoLAj5YrX15CrLGxhmcpx75E27qJ4JZGUDtpiEiRk4fU4eHD5GuIBGPr4X
	 vKd1XFEv+k88xCij9lIyoiyJDjyHxua65f8qFddtWTcX8OY3HfYR78l+P2ggU/EnZn
	 tZq9YSXAUJe1nzSnm3vvIqEhO3i2iDBrEfJhsquvJi6cMBX5bKShF9GjmYFdFtY1Ms
	 tM2NBIl9QQiEMgALrw32h+TNg7v0tSA5TjokqkwJrCTdAN+VNexPfXS+o3sy1Yzk6I
	 RNrKYhv+YRgsaDnDU5RyLjLv4lwPrq3GjvJ5JsKPhvbMXhbfRphSF+MjNvc0QZ9+VK
	 5N5xEAH2EyS+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] sched: Dispatch task ticks for donor and
 execution classes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260909092901.2989564-2-sh_def@163.com>
References: <20260909092901.2989564-1-sh_def@163.com>
 <20260909092901.2989564-2-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:46:30 +0000
Message-Id: <20260909094630.765871F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Infinite timeslice and preemption bypass during SCX proxy executio=
n due to a mismatch between slice decrement (execution context) and slice c=
hecking (scheduling context).
--

commit ff57ff4a11692a1b0d98a6cd57257eb58a1bd864
Author: Hui Su <sh_def@163.com>

sched: Dispatch task ticks for donor and execution classes

Proxy execution can run a task from one scheduling class on behalf of a don=
or
from another. This patch updates sched_class::task_tick() to drop the task
argument, using a common dispatcher to call the donor class first and, if
needed, the execution class second.

Link: https://lore.kernel.org/r/20260908104407.GD687043@noisy.programming.k=
icks-ass.net

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 51de1d8b72a1e..70815bef52960 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
[ ... ]
> @@ -3789,9 +3789,15 @@ void scx_tick(struct rq *rq)
>  	update_other_load_avgs(rq);
>  }
> =20
> -static void task_tick_scx(struct rq *rq, struct task_struct *curr, int q=
ueued)
> +static void task_tick_scx(struct rq *rq, int queued)
>  {
> -	struct scx_sched *sch =3D scx_task_sched(curr);
> +	struct task_struct *curr =3D rq->donor;
> +	struct scx_sched *sch;
> +
> +	if (curr->sched_class !=3D &ext_sched_class)
> +		return;
> +
> +	sch =3D scx_task_sched(curr);
> =20
>  	update_curr_scx(rq);

[Severity: High]
Does this cause an infinite timeslice for SCX tasks during proxy execution?

When an SCX task acts as a donor in proxy execution, task_tick_scx() sets
curr to rq->donor. However, update_curr_scx() applies the slice
decrement to the execution context (rq->curr):

static void update_curr_scx(struct rq *rq)
{
        struct task_struct *curr =3D rq->curr;
        ...
        if (curr->scx.slice !=3D SCX_SLICE_INF)
                curr->scx.slice -=3D min_t(u64, curr->scx.slice, delta_exec=
);
        ...
}

Later in task_tick_scx(), the slice check is performed against the donor
task which was never decremented:

        if (!curr->scx.slice)
                resched_curr(rq);

Since the donor's slice doesn't decrease, it will never hit zero, meaning
resched_curr(rq) is bypassed indefinitely.

Additionally, if the proxy task is SCX but the donor is not, task_tick_scx()
returns early here because the donor is not an SCX task, skipping the SCX
tick processing completely. Should the slice management be explicitly tied
to the execution context rather than the donor?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909092901.2989=
564-1-sh_def@163.com?part=3D1
