Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694FE3CB8F0;
	Fri,  9 Oct 2026 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791586917; cv=none; b=fBGy2STPO/bcJ6YuEqTEuqRFkli3fRRX+vgLc3pZhTnFVsgpL4D23Cb7Cv9LBEYhEqBVdLaG5W/DnciKHMiadG44MV7u3J/FDLiNvfeGRXSdK565CSoitqmXeuTN68/SD8EfZS59MiQN3MT4vPqWOuqRDszwkBze+yX9fS9S/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791586917; c=relaxed/simple;
	bh=53aA3Jr/Sxw2MD/5w8mjzQtGuXFC4yZv9swUbcXDEwA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=tMyXnhtmUFFd8YsEzEmDr8iQZ3FppHhYEB862iBj0S378KyDYzMQXZV4rjsgGrFTumKgDqn8orO6lAu8aJhJST1yBOlSFolHYmtiUlFuNiSMiSZmaga19kncySV09fp4h04EOMMr6Vr7WxtfNJdbS098HqK2IAGJIGCZXLrRSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGUG7dp6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGUG7dp6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252CF1F000FF;
	Fri,  9 Oct 2026 23:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791586916;
	bh=BPwfZ+pMHA/jXjXFHij6wg8LC56jGiwqEjBKLFTM55A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DGUG7dp69yTfYiB+on5IzedBwpQR9ha8Yg9kO6CJsbyvj9to5pyBSn6SsJtsuDHv5
	 MCqxAECKtICcg+Fer/j2C5NtKXjOifAnmTn/p8zXuoEmIJA6e19MYUHdQn1yVaiLi7
	 PmJX3bzYCCtXEcsInX7kezR0kWmRlzUZERae2INlutGI0MvKZ77UEDyQqxBxZyroB1
	 IKqJTT3WQgw9hAZVSrR0n7yTWLkT3AdpTzR/O8FoxNRxyBBaelYfbic66KuwE9jFVY
	 7DRHyS94jUErAJyndy8AispHXMzfPIi8hzxw9n1eixxi2I+QRKt83KYQ+OSs0jsycI
	 zKlnhB3jqr+JQ==
Date: Fri, 09 Oct 2026 13:01:55 -1000
Message-ID: <61e309273c68312c1c68e3da2ea45394@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, John Stultz <jstultz@google.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.4] sched_ext: Keep proxy donors with slice left on the local DSQ
In-Reply-To: <20261009200827.4026499-1-arighi@nvidia.com>
References: <20261009200827.4026499-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Fri, Oct 09, 2026 at 10:08:26PM +0200, Andrea Righi wrote:
> 		if ((p->scx.slice || unlikely(p == scx_rescuee(rq))) &&
> 		    !scx_bypassing(sch, cpu_of(rq))) {
> -			if (p->scx.flags & SCX_TASK_IMMED) {
> +			if ((p->scx.flags & SCX_TASK_IMMED) && !proxy_put) {

The bypassing test skips the keep for a proxy_put as well, so under bypass
the put falls through to the ENQ_LAST branch with idle as @next, and the
WARN there fires for an ENQ_BLOCKED scheduler without ENQ_LAST. Every
blocked donor picked during enable or disable and put back by
proxy_resched_idle() takes that path; the base tree's blocked-donor block
never reached it. Reproduced on a 16-CPU VM with pipe mutex contention
while cycling scx_qmap -X, the first disable trips it on three CPUs:

  WARNING: kernel/sched/ext/ext.c:3607 at put_prev_task_scx+0x743/0x870, CPU#5: pipe-contend/2042
  Sched_ext: qmap (disabling), task: runnable_at=+0ms
  Call Trace:
   proxy_resched_idle+0x51/0x120
   __schedule+0x3f1/0x1900
   schedule+0xae/0x100
   schedule_preempt_disabled+0x12/0x20
   __mutex_lock+0x4d6/0xc20
   anon_pipe_write+0xa0/0x650

The same branch is also reachable without bypass if an out-of-band slice
write zeroes a non-running donor's slice before the bookkeeping put.

> +					/* SCX_ENQ_IMMED uses SCX_CAP_ENQ_IMMED, the base cap. */
> +					if (proxy_put && (p->scx.flags & SCX_TASK_IMMED))
> +						enq_flags |= SCX_ENQ_IMMED;

Not from this patch, but noticed while going through it: this insert runs
with rq->next_class still ext, and proxy_resched_idle() then lowers it to
idle with the IMMED donor on the local DSQ. A higher class waking on the
CPU before the re-pick hits the idle class's wakeup_preempt() rather than
wakeup_preempt_scx(), so nothing reenqueues the donor and it sits behind
the new task. The scan dsq_inc_nr() queued only helps if it runs after that
wakeup. proxy_resched_idle() never looked at the local DSQ, but with this
patch that's the regular state after every IMMED donor's bookkeeping put.

The SCX_ENQ_IMMED comment in internal.h describes v2: in v3 an IMMED donor
stays local only for the bookkeeping put and is reenqueued on preemption or
by the deferred scan like any other IMMED task. The dispatch_one() addition
about a blocked IMMED donor making the scan a no-op comes from v2's
exemption in local_task_should_reenq() too, and the dsq_inc_nr() and
local_task_should_reenq() comment changes don't go with anything in v3.

Thanks.

-- 
tejun
