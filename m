Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A003F787B
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547819; cv=none; b=Bq/v0z82hPL0sLgTL8zRU6qxf1kMnykEacif84BCwK7OZvOkHsSwfCXRrq/wfBDtO79sA1ui2vn5IXpDBEK7ye3lYGGAfGXhJ0PRr3m063O15S/PHtGNQIoOIRDwBNmQcxhxq6drPCZpLOo39M0Wms9iMQN02b2SR2ST29H719k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547819; c=relaxed/simple;
	bh=iCm+3oaef2w+MSe6NSvNcKOBu06C+5bsvdjHUDK0L+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qFOK1j66t9SYuVfHJIkrb7XAkETrnLgqjIK4St2pvhr95CZM+L9CaddQIctc6/sSaxidPw/V5TQZ6UK76jFCy28M3ofMbS//tBMntRJ/AJ/GES94RSAtgZGHt/BDr8s0Xmx/OOKOw5cMfvSRlYuPFvRzN3BDhG9+xr/uIbltt6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKCDCGvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKCDCGvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB5E1F000E9;
	Wed,  8 Jul 2026 21:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783547818;
	bh=UM9DFYuh9uKZDUodfVaF2HG2uM46dmFzObIIL1hdxxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JKCDCGvs8Q5hyrwkDd49FOa/HMnbczeDfJ6w6JOu47J9TpvMGl8CQjXkuFTzeXfva
	 Mv4buSIqhyNeoyYoTJkQ6sXkHPaJmGSPY3mm9TPPJMPE4A9U8FufiGwr8i81a3HfO4
	 zd+PyqhX4b+pfUGqXIQL/4dtZLS5Id+sqZk25lNeBAvCcb5r+9j03EINd3XxNw+kx2
	 H0u1CNRAuiNl6/6omF9QbEidG1vA6PAdWmHafNLgtNTziMMmZvlKhE+v/zhg5oKgb+
	 ENbi9CRFbfiRIYoa2Xc7hTWYncTzlLWrhX9igB9sOdBlSmNbwxdtlNKQz9+3oZIRU0
	 UVbvc5kiU/F4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 27/40] sched_ext: Add the
 SCX_CAP_ENQ_IMMED cap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260708212429.3405787-28-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-28-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 21:56:57 +0000
Message-Id: <20260708215657.DDB5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] scx_caps_for_enq() unconditionally maps all local DSQ enqueues to =
SCX_CAP_ENQ_IMMED, allowing sub-schedulers to bypass isolation guarantees a=
nd swamp the CPU with non-IMMED tasks.
- [High] Tasks in a bypassing descendant's runqueue can be permanently stra=
nded if their nearest non-bypassing ancestor lacks SCX_CAP_BASE on the CPU.
--

--- Patch [27]: [PATCH v4 sched_ext/for-7.3 27/40] sched_ext: Add the SCX_C=
AP_ENQ_IMMED cap ---
commit 5bf5e66c851f3131250d2bde5c5d59c7f1533314
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add the SCX_CAP_ENQ_IMMED cap
   =20
This commit introduces the SCX_CAP_ENQ_IMMED capability to replace the dummy
placeholder, acting as a gate for inserting IMMED tasks into a local DSQ. It
establishes ENQ_IMMED as the baseline capability required to use a CPU,
enforcing that inserts without this cap are rejected or tasks reenqueued.

> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 787cc36dc7b73..c741918c21a78 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -1279,6 +1279,14 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_i=
d, const struct bpf_prog_aux *
>  		return false;
>  	}
> =20
> +	/*
> +	 * Skip a child that does not effectively hold the base cap on this cpu:
> +	 * its inserts would only be rejected. ecaps are synced at the top of
> +	 * balance_one() before dispatch, so this reflects the in-effect state.
> +	 */
> +	if (scx_missing_caps(child, cpu_of(this_rq), SCX_CAP_BASE))
> +		return false;
> +
> +	return scx_dispatch_sched(child, this_rq, this_rq->scx.sub_dispatch_pre=
v,
> +				  true);
>  }

[Severity: High]
Could this early return cause a regression that permanently strands tasks i=
n a
bypassing descendant's runqueue?

If a grandchild scheduler enters bypass mode, its enqueued tasks are routed=
=20
to the per-CPU bypass DSQ of its nearest non-bypassing ancestor (the child=
=20
scheduler). If that child scheduler then loses the SCX_CAP_BASE capability=
=20
on this specific CPU, this check returns false and skips scx_dispatch_sched=
().=20

Since bypass DSQs are strictly per-CPU and only consumed via=20
scx_dispatch_sched(), will the child's bypass DSQ remain unpumped?=20

Capability revocation via scx_process_sync_ecaps() only schedules a=20
re-enqueue scan for the local DSQ, so it seems tasks trapped in the bypass=
=20
DSQ would never be rescued.

[ ... ]

> diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
> index 51400e174cd00..f3548976800b0 100644
> --- a/kernel/sched/ext/sub.h
> +++ b/kernel/sched/ext/sub.h
> @@ -106,13 +106,13 @@ static inline u64 scx_missing_caps(struct scx_sched=
 *sch, s32 cpu, u64 needed)
>  /* map @enq_flags to the SCX_CAP_* bit required for the local-DSQ insert=
 */
>  static inline u64 scx_caps_for_enq(u64 enq_flags)
>  {
> -	return 0;
> +	return SCX_CAP_ENQ_IMMED;
>  }
> =20
>  /* map queued @p to the SCX_CAP_* bit required to stay on its local DSQ =
*/
>  static inline u64 scx_caps_for_task(struct task_struct *p)
>  {
> -	return 0;
> +	return SCX_CAP_ENQ_IMMED;
>  }

[Severity: High]
Does unconditionally returning SCX_CAP_ENQ_IMMED introduce a regression=20
allowing sub-schedulers to bypass isolation guarantees?

Because scx_caps_for_enq() does not inspect enq_flags for SCX_ENQ_IMMED, a
sub-scheduler holding only the baseline IMMED capability could call
scx_bpf_dispatch() to enqueue a non-IMMED task to a local DSQ.=20

The task would then be placed in the local DSQ without the SCX_TASK_IMMED
flag. This would mean it sits in the queue indefinitely rather than forcing=
 a=20
CPU eviction, which seems to contradict the commit message's goal of=20
ensuring IMMED work can never pile up.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708212429.3405=
787-1-tj@kernel.org?part=3D27
