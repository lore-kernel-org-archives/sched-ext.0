Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92538332F
	for <sched-ext@lists.linux.dev>; Thu,  3 Sep 2026 04:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788409146; cv=none; b=BIDAC1tJqdkrHYu5wWZiboE2s/RMsv8CIKQIbbleNnmokNQML7Wo7aIJcwts/0QQLO9FADTY2ypPZOL/XYVbevK/HnNNyGYqbn8sZDHrbqhiE62315h+KTLkxc3Tp+icjeYP+dbpVzVgPAJDtvRdywGkdHl8D1OcKrQLh9at490=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788409146; c=relaxed/simple;
	bh=rPu/G6PIfSetSlhS4fo6Ia2PeSixCLcyJ/ceh12toig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZaxN0HPp+cyLvzFsDbyhWtF2wH4Y3b34Go76oHR7obMrTN1r62esTSYH8rBiYU5dcoTATlwoKDn1qbWZ+Nk5IjB5KL//fhjJ8zilVU2lsSpSQ7klSx9zYdxa5zPFl1jDPatjlttbS2+pvhNOHdxEPNB3Nxo8UacnQ8al0HcZmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5xWvWlR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5xWvWlR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936D41F000E9;
	Thu,  3 Sep 2026 04:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788409134;
	bh=rdI8bgs4Gm6maEqq7h8IqMK3tRLp8Z0KpTzIY7jMi48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g5xWvWlRqn8dY2N4C33xlxWObsvv/HiHtmVEYPuB5UJhQRPOGrqnn3TWUN1rNL3on
	 YMnKfDkysTr66j0JtkwdWMLQF897AtmHATukM49jrY0X1JgyZA0dcPDnm+9thdyIXQ
	 tIWCEU/D6a67Ct9DTtkXS7h5XNGhVvPcjl0Ua+9W4IldgPwgP6ZkNZnJFo6nw4RLmv
	 WUNCqYLWkbZA9eHGwdX2pG1QcF0SZmw/IizOlOIuTcKkz6+0ZQwMfd/mMrqm7qK2Yp
	 x2V0SVv6iPx6lt/D1/tm6L16ADw8FKQIIOJZQRf4RK40seBQhd48rtOclkojRIJqKt
	 z0Ixv7SZ3mHFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Make scx_locked_rq() return NULL from
 NMI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanwu Li" <liwanwu@kylinos.cn>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260903035719.721445-1-liwanwu@kylinos.cn>
References: <20260903032953.659847-1-liwanwu@kylinos.cn>
 <20260903035719.721445-1-liwanwu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 04:18:54 +0000
Message-Id: <20260903041854.936D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] scx_bpf_cpuperf_set() and scx_bpf_cidperf_set() deadlock in NMI wh=
en scx_locked_rq() returns NULL.

Pre-existing issues:
- [High] Tracing BPF programs executing in NMI context can deadlock the sys=
tem by calling pre-existing 'any' category kfuncs that acquire raw spinlock=
s.
--

commit e3a4b62825e5b60c4d87fa4b8dd2f4b8dee65bbf
Author: Wanwu Li <liwanwu@kylinos.cn>

sched_ext: Make scx_locked_rq() return NULL from NMI

scx_locked_rq() reads the per-CPU scx_locked_rq_state, which tracks the
rq locked by the context running on the CPU. Tracing progs can call
kfuncs from NMI, and an NMI interrupts - rather than replaces - the
context that set scx_locked_rq_state, so a non-NULL read from NMI
falsely tells the caller that it holds the interrupted context's rq lock.

Link: https://lore.kernel.org/r/d84b31727f04e1ed0d40042ba1c09e61@kernel.org

> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index 27bbf5e04d900..faa80ac5a653a 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -2181,6 +2181,15 @@ static inline void scx_schedule_reenq_local(struct=
 rq *rq, u64 reenq_flags)
>   */
>  static inline struct rq *scx_locked_rq(void)
>  {
> +	/*
> +	 * Tracing progs can call kfuncs from NMI. scx_locked_rq_state tracks
> +	 * the rq locked by the interrupted context, so a non-NULL read from
> +	 * NMI would falsely claim its lock. Return NULL from NMI so that
> +	 * callers take their unlocked paths.
> +	 */
> +	if (unlikely(in_nmi()))
> +		return NULL;
> +

[Severity: High]
Does returning NULL in NMI cause a deadlock in scx_cpuperf_set() and
scx_cidperf_set()?

When a tracing BPF program executing in NMI context calls
scx_bpf_cpuperf_set(), it now sees locked_rq as NULL:

kernel/sched/ext/ext.c:scx_cpuperf_set() {
    [ ... ]
    locked_rq =3D scx_locked_rq();

    /*
     * If no rq lock is held, allow to operate on any CPU by acquiring
     * the corresponding rq lock.
     */
    if (!locked_rq) {
        rq_lock_irqsave(rq, &rf);
        update_rq_clock(rq);
    }
    [ ... ]
}

If the interrupted kernel context was already holding this CPU's rq->lock,
wouldn't attempting to unconditionally acquire it here cause the NMI handler
to spin forever and deadlock the system?

[Severity: High]
This isn't a bug introduced by this patch, but several any category kfuncs
unconditionally acquire raw spinlocks. Can these cause similar deadlocks if
invoked from NMI tracing programs?

For example, scx_bpf_destroy_dsq() calls destroy_dsq():

kernel/sched/ext/ext.c:destroy_dsq() {
    [ ... ]
    raw_spin_lock_irqsave(&dsq->lock, flags);
    [ ... ]
}

Similarly, bpf_iter_scx_dsq_next() unconditionally takes the dsq lock:

kernel/sched/ext/ext.c:bpf_iter_scx_dsq_next() {
    [ ... ]
    guard(raw_spinlock_irqsave)(&kit->dsq->lock);
    [ ... ]
}

And scx_bpf_dsq_reenq() calls schedule_dsq_reenq() which also takes a raw
spinlock:

kernel/sched/ext/ext.c:schedule_dsq_reenq() {
    [ ... ]
    guard(raw_spinlock_irqsave)(&rq->scx.deferred_reenq_lock);
    [ ... ]
}

If an NMI interrupts a kernel path holding one of these locks and the traci=
ng
program invokes the corresponding kfunc, will the NMI handler spin forever
trying to acquire the held lock?

>  	return __this_cpu_read(scx_locked_rq_state);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903032953.6598=
47-1-liwanwu@kylinos.cn?part=3D1
