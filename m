Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792786010;
	b=vNRZILkxVuY3jnZFQhwVKIYiuIfsVybSPNrxEnJhzWcFkFMdVCHjOLsnx4/WUMhFKAaY
	 fjZjsd2oAEJVlLknmV2urVZBI+UJgRI2i8JCFWTDiMnCeEp65hEDESusjeEB+NDcZgPBW
	 0qwtHPy+xihq3q+G4nys7qNpueE3oyDPyxkO0Pr2JUZ6qfVFwoBYCCZLX4phi7Chwl+YQ
	 9x33pyaAvfyhc0u+Nk1UYH/OXJuaB6S3wGTS/yMibUQOttAff3EqkiXC3TB/0PvREXI6B
	 2CecfVI/GL614YnJqNVZz1cEZr0RSYTIsTBD/MPoNAC+TPgzRLdx0RSpv1HDO1UhLqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792786010;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=Nl48PoMK38GLepoISc/8tHkok9y5SRtsyF2AuLnejX4=;
	b=gtdBiUYYbJVJWxB5KduG/Q2Tq8e+SXERHPmSykEOliPjEilcwIPXaF7jl4voGDpLte2c
	 z1BBQli2ejuYgNATjeK7pFyuukmJ/svU7hfU4cuPBPtKlGiPRi/CgnFQ7lBbhtMnTSWme
	 K0MsTLttDRGYb76g2nDQiiR4UL7nupUOHCn97kM4ctZJwdpIN4qBqlkEOpSQfgw5cNyLB
	 CUgcD8e0xcLcs7HQcci9yPS5KfVyOfqjy7Mcqcxa6ImLi7YhNpdXTKvbM05t45Z91eUYO
	 nsVafTCrjQyEMkeTreqAYdwnNd5lcQJ3PcNt77qITulCY1LEQyOUOc/R7V2lc3O1+nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8AdQzOd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB603606A31D;
	Fri, 23 Oct 2026 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8AdQzOd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408371F01828;
	Fri, 23 Oct 2026 20:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792786009;
	bh=Nl48PoMK38GLepoISc/8tHkok9y5SRtsyF2AuLnejX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y8AdQzOdLQkUBcwiCNaVHw7UOf8GaQCfspKx65pI5T36pHMPLgqInIkaQbTqdGF+4
	 YESYBm4eGaXv0g7WaDlMDH8prP3x1SSYZ93n0DlUGuWyTzx70Ytk3mMM2RloRoDdV2
	 QgWvAX+GPvGBUTZh2FR+0M2V8iegIRCExEjMP+u2+G83MPVRxI5ZYLEc13CQGfUHMf
	 A36x0x/mXUe+XMI6J/6E11/hnJJE4+CiiapD888+oZ7Og/hAxet4o1hoMWDxLWWlMI
	 +qM869Td7T62kkaAza16Xzp9ywvV261gwucIUk2lGAenCmfiyVy6WYjjHe4JkAz06V
	 IKjOII15KSTcQ==
Date: Fri, 23 Oct 2026 10:06:48 -1000
Message-ID: <6373f2a93140aa91dd857e28058b7777@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 13/17] sched_ext: Fix bypassed tasks stalling when the host lacks SCX_CAP_BASE
In-Reply-To: <sashiko-outbox-183097@kernel.org>
References: <20261023175608.4120910-1-tj@kernel.org> <20261023175608.4120910-14-tj@kernel.org> <sashiko-outbox-183097@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello,

On Fri, Oct 23, 2026 at 07:02:35PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> When bypass_enq_target_dsq() diverts a bypassed task p owned by sch into
> rescue on behalf of host = scx_exec_sched(sch, cpu_of(rq)), can rescue
> overload accounting and watchdog stall attribution still blame sch instead of
> host?
...
> Since host has no rescue_avg charged for those bypassed tasks, won't
> scx_rescue_check_overload() either fail to find a victim and leave host
> unejected, or eject an unrelated sub-scheduler on that CPU?

The overload ejection not working while the owner exits is fine. Left as
is.

> If sch is already exiting, __scx_exit() becomes a no-op via scx_claim_exit()
> while timed_out = true stops both the rq scan and scx_watchdog_workfn()'s
> CPU scan without ejecting host. Should scx_rescue_charge() and
> check_rq_for_timeouts() resolve through scx_exec_sched() when the task's
> scheduler is bypassing on that CPU?

The watchdog taking no action is a problem. If the parent isn't processing
the bypassed tasks right, the child may not be able to exit. Fixed by
"[PATCH 19/17] sched_ext: Fix the stall watchdog blaming a bypassing owner
for a stuck task", posted in this thread, which blames the host for a stuck
task whose owner is bypassing.

> [Severity: Critical]
> Can admitting a bypassed task into rescue here also leave a dangling
> rq->scx.rescue.curr pointer if the task is in state SCX_TASK_NONE?

Right. Fixed by "[PATCH 18/17] sched_ext: Fix use-after-free of a NONE
rescuee leaving sched_ext", also in this thread. switched_from_scx() now
ends the slice for a NONE task.

Thanks.

--
tejun
