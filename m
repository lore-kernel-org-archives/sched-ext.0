Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9BD3F9A0A
	for <sched-ext@lists.linux.dev>; Fri, 15 May 2026 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778867947; cv=none; b=LKydGeAJTUj5QQvnbfLoHSH4Ow0t0xWNNgZbnuCBB+sqTwgTGrq9r/IM51bwRDD9HmzOE+9Z7lCxKqdDLdDTkE4cdDACcPht8xXcWCkFn8ljWB2bWTQLfQLJcaO4MuNZ4h1ADI9uObnDje5PAdWCjX4Q9LQHUdO4WId7zbBlR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778867947; c=relaxed/simple;
	bh=Z4WJrfP4hQqnboA0ygzTG/azOdUHfSnia0k4Ii3iO6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bD8nhLdse8B2bBNlKts/X092AAhY38efh7XRCJd3QUqUjRdZOcOeFYNRo7j3er7tBaXOHiA2w9YbXHoFGyItp/w2XzNqJgk0f1qgiwywj7Epc6jSERJsew+rhShHtQ3AIdXLznKRX698sEQ6yd5Z/skX+TcjnR2gTvgbpkqR9Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/uirDvf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/uirDvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCBEC2BCB0;
	Fri, 15 May 2026 17:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778867946;
	bh=Z4WJrfP4hQqnboA0ygzTG/azOdUHfSnia0k4Ii3iO6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Y/uirDvfOlfhMSLkqrGrMrUkI7TlyA2MnV4iq4AJW7RyWdEkfhDw9h+q+mbRqYO9+
	 p+0hcb/qH/hsOuuQnvowT0nC1EaLme3tFVTP1Qd7wEBdiJo28yomavRPwuzMLgdqNf
	 WfJPgy8anaeaqqprpgMBeE6upjQ1wO0Du+Hh+tL9qg+EWb1gp5l6BCBxlEnt4zWTEv
	 4n9LY9msaABebp87C3pHLfqzyxKHsVA5CS6S/E577E6fTFZ7RBAsMcN4dHLxCkDuZ9
	 Qo8g9Qow5H53IS5wIrXayYKWqYHO9mq/dVuSrC3aHiY5frSmI1ldUtznK2WxpU3nsi
	 b7efHg6GSRpSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Add dispatch transaction API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260515172807.254804-3-yphbchou0911@gmail.com>
References: <20260515172807.254804-3-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 17:59:05 +0000
Message-Id: <20260515175906.5FCBEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Double Fetch / TOCTOU vulnerability in `scx_bpf_dsq_insert_commit(=
)` when accessing `args` fields.
- [High] Unprotected state modification (`p->scx.slice`) causing a data rac=
e on actively running or migrated tasks.
--

commit c413431466d2cd2f8ef609dabb82ff0b92ea46d2
Author: Cheng-Yang Chou <yphbchou0911@gmail.com>

sched_ext: Add dispatch transaction API

This commit introduces scx_bpf_dsq_insert_begin() and
scx_bpf_dsq_insert_commit() kfuncs to allow a dispatch transaction. This
mechanism extends the race detection window for schedulers that queue tasks
in ops.enqueue() but do not implement properly synchronized ops.dequeue().

Link: https://lore.kernel.org/r/20260203230639.1259869-1-arighi@nvidia.com/

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 0dadda97ef57c..2dfcfc3c885bb 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c

[ ... ]

> @@ -8518,6 +8530,92 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct t=
ask_struct *p, u64 dsq_id,

[ ... ]

> +__bpf_kfunc bool scx_bpf_dsq_insert_commit(struct task_struct *p,
> +					    struct scx_bpf_dsq_insert_commit_args *args,
> +					    u64 token,
> +					    const struct bpf_prog_aux *aux)
> +{
> +	struct scx_sched *sch;
> +	u64 enq_flags =3D args->enq_flags;
> +
> +	guard(rcu)();
> +	sch =3D scx_prog_sched(aux);
> +	if (unlikely(!sch))
> +		return false;
> +
> +	if (args->dsq_id !=3D SCX_DSQ_LOCAL &&
> +	    (args->dsq_id & SCX_DSQ_LOCAL_ON) !=3D SCX_DSQ_LOCAL_ON) {

Since pointer arguments to BPF kfuncs like args can point to shared memory
such as BPF map values, which can be concurrently modified by userspace or
other BPF programs, is it possible for args->dsq_id to change between reads?

If args->dsq_id changes to a global DSQ ID after this local-only check pass=
es,
could it bypass the constraint during the subsequent scx_dsq_insert_preambl=
e()
and scx_dsq_insert_stage() calls?

> +		scx_error(sch, "scx_bpf_dsq_insert_commit() may only target local DSQs=
");
> +		return false;
> +	}
> +
> +	if (!scx_dsq_insert_preamble(sch, p, args->dsq_id, &enq_flags))
> +		return false;
> +
> +	if (args->slice)
> +		p->scx.slice =3D args->slice;
> +	else
> +		p->scx.slice =3D p->scx.slice ?: 1;

Could a concurrent modification to args->slice between the condition check
and the assignment result in setting the task's slice to 0, bypassing the
fallback logic?

Would it be safer to fetch args->dsq_id and args->slice exactly once into
local variables at the beginning of the function, similar to how
args->enq_flags is handled?

Additionally, since scx_bpf_dsq_insert_commit() is intended for schedulers
where p may have been dequeued or migrated to another CPU after the dispatch
token was captured, the current CPU might not hold p's runqueue lock here.

Could modifying p->scx.slice without synchronization cause a data race if
the task is actively running or queued on another CPU?

Even if the stale token is later detected and discarded by finish_dispatch(=
),
it appears the corruption to p->scx.slice would already have occurred. Is
there a way to defer this write or synchronize it so the active state is not
modified?

> +
> +	scx_dsq_insert_stage(sch, p, args->dsq_id, enq_flags, token);
> +
> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515172807.2548=
04-1-yphbchou0911@gmail.com?part=3D2
