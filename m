Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B414E2F2;
	Sat,  7 Mar 2026 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772842995; cv=none; b=ZIdz2OkKhjXNfPXnNDTrg9AnMMWOdIzXZZ/1ImLJem4faPgu5pqqxfDgIWlMmCsth+MiSnUYxAH//fE54mtc/KXRqQ9i0YVHu0RL6nL1bh8DnMpXUP/TMWp5EDcdrvKKSaRigt3s164Nv+7OloLRyzQBHDZzrAdJObKKolEYEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772842995; c=relaxed/simple;
	bh=41DKUveKDRWtqMCZCugB4RA//ZVmkbhFS2rf+X0qoZI=;
	h=Date:Message-ID:From:To:Cc:Subject; b=TU+o0W+J0VK1NcrFtp4nJALB5UrUGaXmm/lI/1ZMa42YZeR88it1IlgXZKURZ4K1BySyLUsQMn837ChD5ZnYcWb8lyvcZSB3pUIYWFftnkBhEQTXrnHVrgmAIt09l6BZf+8tBrv8J6lj+OjaRxIQdso0IPazH5al7HuVgauau+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oi0+TEd8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oi0+TEd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13F7C4CEF7;
	Sat,  7 Mar 2026 00:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772842994;
	bh=41DKUveKDRWtqMCZCugB4RA//ZVmkbhFS2rf+X0qoZI=;
	h=Date:From:To:Cc:Subject:From;
	b=Oi0+TEd89fX2BzTrcXAjw5nTFuz5/ZP4SM6xJE7mda7ti/5VLxnrkSf6yEKIwqF0b
	 +lnx6NMv/zkxiD5z4CZdd9lNVUL+Mqf4xHlm8+cMnaS4MmKEGqgbmrQmGUVFOT25Up
	 izEQGVm+1fp2Xxd8aNYG6PFqMzMDbtA4/kO8o7qVCtybJ/hqh51TITrhywf8dRn3es
	 KtUbM1rLDpKdM6HTujijr1ggB053fqAFvaWDkQ1vJPJBDHcp9KpvNSC79EKQRDsNLA
	 58irPs2Reawj2C3tH3IUaGdRM2X1OSJr+2YkuaXDTAYPzZjDJ2kFs7FSwuRWGcg919
	 Tt2u4Nv3pvAaw==
Date: Fri, 06 Mar 2026 14:23:13 -1000
Message-ID: <9b72570da1834f89d8f6017ce3b14db0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.0-fixes] sched_ext: Fix enqueue_task_scx()
 truncation of upper enqueue flags
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

enqueue_task_scx() takes int enq_flags from the sched_class interface.
SCX enqueue flags starting at bit 32 (SCX_ENQ_PREEMPT and above) are
silently truncated when passed through activate_task(). extra_enq_flags
was added as a workaround - storing high bits in rq->scx.extra_enq_flags
and OR-ing them back in enqueue_task_scx(). However, the OR target is
still the int parameter, so the high bits are lost anyway.

The current impact is limited as the only affected flag is SCX_ENQ_PREEMPT
which is informational to the BPF scheduler - its loss means the scheduler
doesn't know about preemption but doesn't cause incorrect behavior.

Fix by renaming the int parameter to core_enq_flags and introducing a
u64 enq_flags local that merges both sources. All downstream functions
already take u64 enq_flags.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index XXXXXXX..XXXXXXX 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1728,16 +1728,15 @@ static void clr_task_runnable(struct task_struct *p)
 		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 }

-static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags)
+static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_flags)
 {
 	struct scx_sched *sch = scx_task_sched(p);
 	int sticky_cpu = p->scx.sticky_cpu;
+	u64 enq_flags = core_enq_flags | rq->scx.extra_enq_flags;

 	if (enq_flags & ENQUEUE_WAKEUP)
 		rq->scx.flags |= SCX_RQ_IN_WAKEUP;

-	enq_flags |= rq->scx.extra_enq_flags;
-
 	/*
 	 * Restoring a running task will be immediately followed by
 	 * set_next_task_scx() which expects the task to not be on the BPF
--
tejun
