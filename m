Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F04719AD90
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384739; cv=none; b=YNWQDcvBC8BTLfXTiQiPtScfbFCwCojwOcVrj4uP2NWu36jdr1cRb6pRn83xQ0Gnhi3PDs9pO0w5gUmOdgpouv/TVaA3GWUvSiv0QF8aaOllgZSwjGh1B0DNCrJXPY/YFTb82EtSqMbeUMg2lRJOgeWR/ir5o9PRZdmoZhA+pX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384739; c=relaxed/simple;
	bh=BHz69ikV7sUM8YG3HrEstqom4x9EHnyUTXlrja15208=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WTPsofNndeFAv7xDJXhye35tuqIsGnW+wSQxvGa5EGYDJt5YC8u9XyniUwmg6RokGi/yoqotn0/GpQk7qhpqE9ZtuNRkUiwXqvwxyFTY3hBaTmGlE6yTyU5JwZjdH/ebxmiiCp/pU37pFJg0m1d9gJB7jZbjEG7OFDlfzsnPx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkRXDV2V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkRXDV2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBB11F000E9;
	Tue,  7 Jul 2026 00:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783384738;
	bh=K9/Hko8b4hdvOtdP+8ZLEZbxpWYtKmlH030CmCfJ7KA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZkRXDV2VUBtswmZqqH92CYvaMifg75EbojK1v8xYt2567KFhz+PDPaRTnuHN+O8yj
	 OUz7x/qyI2gaQk3oMaaSR5WoV+0xB2ByySpwZegd4LadLAtj/azvU/NevEJ30km9Hf
	 Q0F99U1F8wsUXm0ijbACMcvuEeOW9LmhqikZnr0thmm1ovJ/PRvV+0LGgjcbit9NYJ
	 HOsKT8HSmonznpUKdwR7yn1DlBwW8AtcjQ5riS7+P5dwmBXDgKyFMWF6ASvQP7Au4t
	 /ccMP6e1CogseUpGTT6fqPpNeO1YAI4wyE5SgtbgiQ3cvTvQjrBC9YsNVKHJdBxF16
	 tu44+g4TbmiOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 24/36] sched_ext: Add reject DSQ
 for cap-rejected dispatches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260707001229.1410929-25-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-25-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:38:57 +0000
Message-Id: <20260707003858.1BBB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The CPU incorrectly goes idle and strands tasks when a consumed ta=
sk is diverted to reject_dsq.
--

--- Patch [24]: [PATCH v3 sched_ext/for-7.3 24/36] sched_ext: Add reject DS=
Q for cap-rejected dispatches ---
commit 17b65480202fa0fa8a74c72c6813fa99184ffb6d
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add reject DSQ for cap-rejected dispatches

This commit introduces a kernel-internal reject DSQ for the sched_ext
sub-scheduler. Tasks dispatched to a CPU where the sub-scheduler lacks
required capabilities are parked here instead of the local DSQ, and later
handed back to the BPF scheduler to re-decide.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 87a9f1ff2b0e1..d0966412ee421 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -2063,7 +2079,7 @@ static void move_local_task_to_local_dsq(struct scx=
_sched *sch,
>  					 struct scx_dispatch_q *src_dsq,
>  					 struct rq *dst_rq)
>  {
> -	struct scx_dispatch_q *dst_dsq =3D &dst_rq->scx.local_dsq;
> +	struct scx_dispatch_q *dst_dsq =3D scx_local_or_reject_dsq(sch, dst_rq,=
 p, &enq_flags);

[Severity: High]
If the task is diverted to the reject_dsq here, how do the callers handle t=
he
fact that the local_dsq might still be empty?

For example, when scx_consume_dispatch_q() processes a task:

if (rq =3D=3D task_rq) {
    task_unlink_from_dsq(p, dsq);
    move_local_task_to_local_dsq(sch, p, enq_flags, dsq, rq);
    raw_spin_unlock(&dsq->lock);
    return true;
}

Does this cause scx_consume_dispatch_q() to unconditionally return true,=20
leading balance_one() to believe it found a task and stop searching?=20

If do_pick_task_scx() then finds the local_dsq empty, could the CPU=20
incorrectly enter the idle state while runnable tasks remain in the global=
=20
DSQ, eventually triggering the SCX watchdog timeout?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707001229.1410=
929-1-tj@kernel.org?part=3D24
