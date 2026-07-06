Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C03E2759
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322684; cv=none; b=BnFJsPriheXeTuapvH6LvBk4q5PNGbHMClA4O9yKGYlYNrNEK3XND48hQg8QQq7VPqvct8e7GLIVxflDjnrSpkD+UVsX1CwYkMfmSzhmdPyFbopN6UI70dwmZ302EVX/N2gKKjqyZHC/XoNrilHDD07UUlsznTfSbXjH9HhTrxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322684; c=relaxed/simple;
	bh=EoG5hQ24lovjcUjl2rk8O7C99SvhTJx6rUOmolplRn4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pElhN4qvNaXirOl+hICQ/6gsz1fVKgV9fp7wENtga1XBjhLjsGRZ9hI2Jlf4KDlClWg8Y6BqMGz/ZqOUmcRygQyrFxCUjP1vq1BxRRs7Q7MZP2QRYSGVikN3/LF/mKQcNiDlxXIN7akwfkII/RSB9p8rGHrmaSZ8Br6Pr43fMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hI20ZNg2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI20ZNg2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F1D1F000E9;
	Mon,  6 Jul 2026 07:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783322674;
	bh=MRG7Spc5FZ1Uftiy5lfeO7r6VBCHIVgWTxO11GLuFu8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hI20ZNg2wegEz7egePCFdFDcQrOj3brvo+3vKXN3GSaJVplbPFLDZ48WfmQysEvvN
	 l8r9wM0QPYtUsruQ4PRJpapV4TnNMvORDM5DaY/kMoU+BGagfl6EDEq4ggwukSNcjU
	 HDXeOsl+t/Dbf2FZv+KcU6ayw7yC1GxFBXe4fA5ZuelCR3n1ngpDweqvJdTy70vAoj
	 /fd4tQJBCvMGrF81pDMBrovs+uamxnuRHEQj4zwwyF371c/PxVoQA2F3nk6RB80h2i
	 rJY47WV4bXoyyNI9cZvhqVgE4PAPV5tneub63ug8jAxk5q2EY4vVaJsfrC6bs8hpNe
	 e/4M8K4V3POCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] sched_ext: Fix TOCTOU race in consume_remote_task()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260706070410.282826-4-arighi@nvidia.com>
References: <20260706070410.282826-1-arighi@nvidia.com>
 <20260706070410.282826-4-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 07:24:33 +0000
Message-Id: <20260706072434.65F1D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing tracking bug in dispatch_to_local_dsq(): it drops the=
 locked_rq lock without clearing the scx_locked_rq_state tracking, which tr=
iggers a lockdep crash if a nested ops.dequeue() callback executes in the f=
allback path.
--

commit aff47a8e37704807f1fefe8e15adcb99c8836308
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Fix TOCTOU race in consume_remote_task()

This commit addresses a TOCTOU race condition in sched_ext during task
migration between runqueues. It ensures task eligibility is re-evaluated
after locking the source runqueue and properly tracks runqueue lock state
while dropping the lock to avoid lockdep warnings.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 242f6ffbba350..4c6cd694c86db 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
[ ... ]
> @@ -2240,20 +2246,58 @@ static bool unlink_dsq_and_lock_src_rq(struct tas=
k_struct *p,
>  		!WARN_ON_ONCE(src_rq !=3D task_rq(p));
>  }
> =20
> -static bool consume_remote_task(struct rq *this_rq,
> +static bool consume_remote_task(struct scx_sched *sch, struct rq *this_r=
q,
>  				struct task_struct *p, u64 enq_flags,
>  				struct scx_dispatch_q *dsq, struct rq *src_rq)
>  {
> +	struct rq *tracked_rq =3D scx_locked_rq();
> +	bool consumed =3D false;
> +
> +	/*
> +	 * consume_remote_task() may be called from an SCX op with @this_rq
> +	 * recorded as the currently locked rq. Clear the tracking while the rq
> +	 * lock is dropped so nested callbacks don't save and later try to rest=
ore
> +	 * an rq which isn't locked anymore.
> +	 */
> +	if (tracked_rq) {
> +		WARN_ON_ONCE(tracked_rq !=3D this_rq);
> +		update_locked_rq(NULL);
> +	}
>  	raw_spin_rq_unlock(this_rq);

[Severity: High]
This is a pre-existing issue, but does dispatch_to_local_dsq() have a simil=
ar
problem with stale rq lock tracking?

Similar to consume_remote_task(), dispatch_to_local_dsq() drops the locked_=
rq
without temporarily clearing scx_locked_rq_state:

kernel/sched/ext/ext.c:dispatch_to_local_dsq() {
    ...
	/* switch to @src_rq lock */
	if (locked_rq !=3D src_rq) {
		raw_spin_rq_unlock(locked_rq);
		locked_rq =3D src_rq;
		raw_spin_rq_lock(src_rq);
	}
    ...
}

If task_can_run_on_remote_rq() fails, it falls back to enqueueing to the gl=
obal
DSQ:

		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
			p->scx.holding_cpu =3D -1;
			fallback =3D true;
			scx_dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
					     p, enq_flags | SCX_ENQ_GDSQ_FALLBACK);

When scx_dispatch_enqueue() triggers the nested ops.dequeue() callback via
SCX_CALL_OP_TASK, the stale, unlocked rq state is saved and later restored
in SCX_CALL_OP, which triggers a lockdep assertion failure.

Could this lead to a lockdep crash if a nested ops.dequeue() executes in the
fallback path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706070410.2828=
26-1-arighi@nvidia.com?part=3D3
