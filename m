Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465757;
	b=npWEJrFYliLJRzYnRfpJFaW1U/OV8MOsXPg79hwuAfUtUnOAj3PlxqMTGkJ8AhWl+Z1q
	 N1223qFBS8aEMUOfbYCW//7X7xzwraRHEKOGUGX+zOano+MGCsoeBrogYhKAbmOAclGDV
	 k7//3N8RTQ9l1EwqGzSMw1DkrmUTh1LQquNEw2ZwW5l+tnPjpyHb3c0kW20elKo5azPAm
	 vVGKJon8oGPSSy9HDBXFS9LRoO8hpfpRZxWGktGsN/NIbcRJs1Xp943LQDhnEsppgxeUH
	 Y+fFoNICZ2JqmVenu7HkwGWlzfPN8kMZloyFYrk+Zd6CFGCcMBuvkj9w3gfaIKA2bAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465757;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KCfE8wUW2aQqSWxSJ/nNbYC12JpYTff36ahdbVDg/z4=;
	b=EpSLk6Bst4QRKUCLWDuc0Blfm7M/Ty8Gdexy0ZCrjGARox9SC+T4oThp90w0r6Jx9KIm
	 4HiaOZLQgyRrRciRoHE4VjJZeOX+SYjTWvFmNeX1fAADByg0WbaggFxv4hIc03cP6wKlk
	 u8n1Mv3hXRBD9UTnJz8c/uxa2O4eJi7g5Bw0GKp5hGNCLyVvvIp8WJ+2nPbcuK7YV6q0E
	 4mnBCkdokgPgSKDFvUjJ7/AkIbg46zFeTz8HH/R/1Xy/oMX+ub7Mr24WGKlHGsS6Fwemn
	 xe6oD1PDsNjWuS/8cI8FI7tIiF1Ib2BZL6wfxOxVS6uoJ6UrRjWAR5Z8RDnn4/347OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DjcWnF/v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F9606A31A
	for <sched-ext@lists.linux.dev>; Sat, 31 Oct 2026 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjcWnF/v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642AA1F000C1;
	Sat, 31 Oct 2026 16:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793465756;
	bh=KCfE8wUW2aQqSWxSJ/nNbYC12JpYTff36ahdbVDg/z4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DjcWnF/v5GnbSNvy7Nb2yrZutJKdk3CubX+0nuHD845EhdferC95zIKUT2lSwBPO0
	 QSdaoABCLEMqsmQBCvjZo7A12QAlwgW2rwzxYcyRqGZ2mBGogQs1Z4gHlsrlkBAST9
	 Dc9BNKmhr5UYKNIG8vkFT8Mrm/UBH8+NDQxQN8Awvcntv6TzEiIBgqhBdqjifCfKp/
	 sxAuDwCgzCfAzh4vCMXWQzOCuelOUii5/ux3XujNrTZB2+85cKvBJZJdwHKtRE3yKC
	 7fHf64BGIEoYdOf8YZFzZGlWi/ddZ/F0jOENNFoEOaD/S1sc013Sl+9VhbQYKg1xN9
	 EpcJF/yOg2uCg==
Message-ID: <sashiko-outbox-192051@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.4-fixes] sched_ext: Fix stale pick
 when the donor changes during dispatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>, sched-ext@lists.linux.dev
In-Reply-To: <20261031162803.541236-1-tj@kernel.org>
References: <20261031162803.541236-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 16:55:55 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sched_ext: dispatch_one() emits ops.cpu_acquire() before checkin=
g stale prev
--

commit 15726c74d0541a9ea4622e6efa11631d9ab6aea0
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix stale pick when the donor changes during dispatch

This commit fixes a stale task pick in sched_ext when rq->donor changes
while the rq lock is dropped during dispatch under proxy execution or core
scheduling. It introduces scx_dsp_prev_stale() to detect when prev is no
longer rq->donor and restarts the pick with SCX_DSP_RETRY.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 0403c46342813..bcd1f7ee8c89b 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -2950,6 +2950,12 @@ static enum scx_dsp_verdict dispatch_one(struct rq=
 *rq, struct task_struct *prev
>  		rq->scx.cpu_released =3D false;
>  	}
> =20
> +	/* the ecaps sync may have dropped the rq lock */
> +	if (scx_dsp_prev_stale(rq, prev)) {
> +		verdict =3D SCX_DSP_RETRY;
> +		goto has_tasks;
> +	}

[Severity: Medium]
In dispatch_one(), scx_dsp_prev_stale() is checked after handling
rq->scx.cpu_released rather than immediately after
scx_process_sync_ecaps():

kernel/sched/ext/ext.c:dispatch_one() {
	...
	scx_process_sync_ecaps(rq, prev);

	if ((root_sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT) &&
	    unlikely(rq->scx.cpu_released)) {
		if (root_sch->ops.cpu_acquire)
			SCX_CALL_OP(root_sch, cpu_acquire, rq, cpu, NULL);
		rq->scx.cpu_released =3D false;
	}

	/* the ecaps sync may have dropped the rq lock */
	if (scx_dsp_prev_stale(rq, prev)) {
		verdict =3D SCX_DSP_RETRY;
		goto has_tasks;
	}
	...
}

When scx_process_sync_ecaps() drops the rq lock in
scx_flush_dispatch_buf(), a sibling CPU under core scheduling can switch
that rq to a higher-priority RT or DL task, running
put_prev_set_next_task() -> put_prev_task_scx() -> switch_class(), which
emits ops.cpu_release() and sets rq->scx.cpu_released =3D true. Under proxy
execution, if rq->scx.cpu_released was already true on entry, a remote
wakeup during that lock drop can reset rq->donor to a non-SCX rq->curr
while an RT or DL task becomes runnable.

When scx_process_sync_ecaps() returns, dispatch_one() will call
ops.cpu_acquire() and clear rq->scx.cpu_released =3D false before seeing
scx_dsp_prev_stale() and returning SCX_DSP_RETRY. If the restarted pick
then selects the higher-priority RT or DL task without reaching
ext_sched_class, and rq->donor is no longer an SCX task, switch_class()
will not run again to set rq->scx.cpu_released =3D true.

Should the scx_dsp_prev_stale() check be placed immediately after
scx_process_sync_ecaps(), before emitting ops.cpu_acquire() and clearing
rq->scx.cpu_released?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031162803.5412=
36-1-tj@kernel.org?part=3D1
