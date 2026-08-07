Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57F5379C48
	for <sched-ext@lists.linux.dev>; Fri,  7 Aug 2026 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786138010; cv=none; b=YlgPCWIlDlaqytaFD7TULL1xhAPn89R2doV70s9K1udOuXP9tdQN9tdYFDqFagQaJyi2TLu3mM0FA81m/2plwbvo0lwJV4lwXikjun2EHlwfnHm/YbbzvCWuLRRGmRer0Y7ooC9Jba8xwai4hxpzd30SjzGjKaOL4G+BmkfUZqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786138010; c=relaxed/simple;
	bh=/eE6KoBjG4zjvQ0gXWYFEr3Fq1nxxX3RZDh1rW5jwCI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZLO+vLJ31nv0+xiqGxbM5VVp625H/fxTgb2AGhJXlDk8Xlcfr+aZlpGytVUNly5kPUvf9Nrb/uaJ5ImILV/v7mfrf6L5TMaLsFBOLcmVwgIIlJY4jVU+wt0MoWYehM9SQ8q4SPixW2IGYnzk0eMxtpoA0SXK+UL/4smXtOaDR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp9tKQQF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp9tKQQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D811F000E9;
	Fri,  7 Aug 2026 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786138009;
	bh=EBuTyWjh7gvdmR/eF01AMau+hfJvINkhF1aoikQcMT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qp9tKQQFaLpZrOjwnM+HJV5J/FtrycN3Ha29HkrTLb4Gc4Oa+KDCOLC0liJ6MyYfy
	 8nUDMvirgA+aGDOTjr+EDHDBAiy+J6bii+TJdrQd4MuEhwxU441HCiU5JcWT/amr4X
	 ly2rtLRsKFj4ExN4VmTtzCQ25zZCRQSL2+dgbOWUTFAdP0MOPB+LwMnKBwNRZ8M0aA
	 nUuWcOaY36EJc3UyzUaIQwKSVpwhOUoYNPzh8I0k2W9M3cYjmvcnmDpI1BI3p1MPCe
	 7bn9GQctfqG2U52v7XyRMILIYBmJBVTzpjb0GJrm1kzP3syjd+1c8pBnxl9BQjmx2j
	 yWBSRqtzsw4jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] sched/core: Handle pick_task() releasing the rq
 lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260807210221.232543-2-tj@kernel.org>
References: <20260807210221.232543-1-tj@kernel.org>
 <20260807210221.232543-2-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 21:26:47 +0000
Message-Id: <20260807212648.A6D811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Stale runqueue clock and WARN_DOUBLE_CLOCK splats upon pick_task()=
 retry
--

--- Patch [1]: [PATCH 1/6] sched/core: Handle pick_task() releasing the rq =
lock ---
commit e3861f6642d2aed51cd1900fde0081c42124a072
Author: Tejun Heo <tj@kernel.org>

sched/core: Handle pick_task() releasing the rq lock

Core scheduling's pick_next_task() breaks when a ->pick_task() implementati=
on
can release the rq lock. This patch handles this by restarting the whole
selection when a pick returns RETRY_TASK after releasing the lock.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 96226707c2f61..136246846e792 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
[ ... ]
> @@ -6301,10 +6303,15 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
>  	 * and there are no cookied tasks running on siblings.
>  	 */
>  	if (!need_sync) {
>  		next =3D pick_task(rq, rf);
> -		if (unlikely(next =3D=3D RETRY_TASK))
> -			goto restart_single;
> +		if (unlikely(next =3D=3D RETRY_TASK)) {
> +			/* rq lock may have been dropped, clocks invalidated */
> +			core_clock_updated =3D false;
> +			if (!(rq->clock_update_flags & RQCF_UPDATED))
> +				update_rq_clock(rq);

[Severity: High]
Does this bypass the clock update entirely? When pick_task() drops the lock
and repins it, the rq->clock_update_flags are preserved and restored. This
means RQCF_UPDATED would still be set, making this condition false and leav=
ing
the runqueue clock stale despite the lock having been dropped.

> +			goto restart;
> +		}
> +
>  		if (!next->core_cookie) {
>  			rq->core_pick =3D NULL;
>  			rq->core_dl_server =3D NULL;
> @@ -6324,7 +6331,6 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
>  	 *
>  	 * Tie-break prio towards the current CPU
>  	 */
>  	max =3D NULL;
>  	for_each_cpu_wrap(i, smt_mask, cpu) {
>  		rq_i =3D cpu_rq(i);
> @@ -6338,8 +6344,13 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
>  			update_rq_clock(rq_i);

[Severity: High]
Will this trigger a WARN_DOUBLE_CLOCK splat for sibling runqueues if the
loop is restarted?=20

If a previous pass updated the clock for rq_i, the RQCF_UPDATED flag is set.
When we hit goto restart, we loop again and call update_rq_clock(rq_i)
unconditionally without clearing the flag first.

> =20
>  		p =3D pick_task(rq_i, rf);
> -		if (unlikely(p =3D=3D RETRY_TASK))
> -			goto restart_multi;
> +		if (unlikely(p =3D=3D RETRY_TASK)) {
> +			/* rq lock may have been dropped, clocks invalidated */
> +			core_clock_updated =3D false;
> +			if (!(rq->clock_update_flags & RQCF_UPDATED))
> +				update_rq_clock(rq);

[Severity: High]
Similarly, does this bypass the clock update on the local runqueue because
RQCF_UPDATED is still set after restoring the pin context?

> +			goto restart;
> +		}
> =20
>  		rq_i->core_pick =3D p;
>  		rq_i->core_dl_server =3D rq_i->dl_server;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807210221.2325=
43-1-tj@kernel.org?part=3D1
