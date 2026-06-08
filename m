Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6165A31578E
	for <sched-ext@lists.linux.dev>; Mon,  8 Jun 2026 04:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780893360; cv=none; b=nTHaVKOzPUZP0R1AAaF6jMplZEpCRmNRBGrYkuZFLDINdvNAUza688KPSpuqbrrBoDGF5nXHUP6smnfphXbmIh54QyKTkx35GUh3+AWlhf8H3UgWbslcqqE/1IeS6YTHU+2SelB5GimNkqJ3DxfZFGI+dRLb1+LL+LDqNUL8eac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780893360; c=relaxed/simple;
	bh=iQ+bfBC9SptEHIYDxfCVWVkttNtMZc4UmTZeCuwt2NQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ep0uD45xqmSMbvL7miKqqn1R7vqNKCGldhbSiSBg3jswVAXbRbLb8YWoIDt4tcQO9Ta4c7J4b5pYD7KlP+pTuvbwMGSlLn7ilWaP+4jm79KSbF7Fd1nVH8mJxRl/JtH4VsZCuxzEvIWldaLbYFwJyUFpb35EFw8WCzSnTa85Tt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPb6fwMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPb6fwMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBCE1F00893;
	Mon,  8 Jun 2026 04:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780893359;
	bh=Il9rzP00YZOeLtZWb/R2JE1+OU+vGkvRKwyHlq5JgB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BPb6fwMpZVminSosrv3NG/mnfsFEFBNtkTtuiaJD7wZN+7SgGVTRNsA0wbQGrI68H
	 nThn1Vq7w1Qwuo9GxA78TUEsW1dct63OprGzwqN/Rdq3fGQQcMUNvgvNh7UFFSXAlZ
	 q5qP/W/iVlnH7Q+jSpjQqpaNyL+UTT/TkZhXZElXHfqXrgK0SxuN/Bin5v1zywSD8s
	 StbEguL2xw6LOPyecFyiUnIz0n200eKfYlMptzgVqf6q+iCa15qy5YusFfOgeb54uN
	 wgCZvIQTNzkr8y+rE4klSf3XvplhT4STAMb1uTJP2VGtz8/pAT/iXJeQ0oZkbmbCSm
	 BGscKdHMw6OYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext/scx_flatcg: Fix cvtime_delta race and add
 hweight scaling to bypass charging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanwu Li" <liwanwu9113@163.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260608042230.3-1-liwanwu9113@163.com>
References: <20260608042230.3-1-liwanwu9113@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 04:35:58 +0000
Message-Id: <20260608043558.ECBCE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect tracking of cgroup virtual time delta in `fcg_dispatch` =
leads to double charging on early yield and permanent starvation on slice o=
verrun due to sign inversion and unsigned division of negative values.
--

commit 26a5b29cfee7b890fe54a82847b9652c4700912d
Author: Wanwu Li <liwanwu@kylinos.cn>

sched_ext/scx_flatcg: Fix cvtime_delta race and add hweight scaling to bypa=
ss charging

This commit fixes a double-charging race condition in cgrp_cap_budget() by
using __sync_fetch_and_and() to read and clear cvtime_delta atomically. It
also updates the bypass charging path in fcg_stopping() to scale the raw
execution time by the inverse of the cgroup hweight before adding it to
cvtime_delta.

> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatc=
g.bpf.c
> index fec3595818269..0fd214cc61dae 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c

[ ... ]

> @@ -570,7 +570,8 @@ void BPF_STRUCT_OPS(fcg_stopping, struct task_struct =
*p, bool runnable)
>  	cgc =3D find_cgrp_ctx(cgrp);
>  	if (cgc) {
>  		__sync_fetch_and_add(&cgc->cvtime_delta,
> -				     p->se.sum_exec_runtime - taskc->bypassed_at);
> +				     (p->se.sum_exec_runtime - taskc->bypassed_at) *
> +				     FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));

[Severity: High]
This is a pre-existing issue, but seeing the hweight scaling logic added
here brings to mind a potential bug with the same pattern in fcg_dispatch().
Does the tracking of the cgroup virtual time delta in fcg_dispatch() suffer
from double-charging and underflow issues?

In fcg_dispatch(), the unused slice time is calculated as:

(cpuc->cur_at + cgrp_slice_ns - now)

Because the cgroup is charged a full slice upfront in try_pick_next_cgroup(=
),
should this unused time be refunded by subtracting it from cvtime_delta? The
current code uses __sync_fetch_and_add() which adds the positive unused time
and penalizes the cgroup a second time when it yields early.

Also, if the cgroup overruns its slice (now > cur_at + slice), the
calculation underflows. Because FCG_HWEIGHT_ONE is an unsigned value
(1LLU << 16), does the subsequent multiplication and division by cgc->hweig=
ht
destroy the two's complement representation of the negative value?

This unsigned division would shift zeros into the most significant bits,
resulting in a huge positive number being added to cvtime_delta. Could this
push the cgroup's virtual time days into the future and cause permanent
starvation?

>  		taskc->bypassed_at =3D 0;
>  	}
>  	bpf_cgroup_release(cgrp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608042230.3-1-=
liwanwu9113@163.com?part=3D1
