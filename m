Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5321A32E75E
	for <sched-ext@lists.linux.dev>; Thu, 13 Nov 2025 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034263; cv=none; b=t1OV65tn7iB8t8IapJFf8gPO7fUHkr+qdSMkVol6MQdbP2X99LKaRJGr6A0D+7Q7xvLRCkT5kD+8x5PUJ39tyXb3wlU1JaqsLfynWMH7+BN0voAyDM7sA8mwS1+k8IALqmQ74XD1UwBRtg/5ihFYAgLDKUlujoYRkdHRmBnCoE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034263; c=relaxed/simple;
	bh=cayhevHlhqpCkcyseaRFmNDhVj8QyOhC36i7FYExAfA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Q+PMe9sGhjIcfbGxetDaZ51re5UDq0USOox6tJjOGTSGDKZCLXNZMji3qh59cfU276vMT1HGg73LjLpqQKB1QATO8ikC/zN6atZxUpMiBDN5+vJdEnYoj1h2O2gF4A/mClQWZVDvjCPvElk2J1K0kUqiDj8ELIBJnGNP6XRAG1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EyydNcHn; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EyydNcHn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763034259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=OpSEyujv6xez7n2B9Rt5/pmDqH1hHhrLwBlVTGozI5Y=;
	b=EyydNcHnigncRiI/sA5/DuUq+ar8c4s8T3lyQwXyMMeWZFAExFhkcfQfE1Mc+JK7iN34sX
	/IGYD6DTru5dFOVvxy5Rr5vx53xDF4FdLmKOiXh4XpbuXWZFbOh6+Y0h6+hXMoHHzNvfID
	C5mnFt+WRGSzLbThX7DgQ6cSctG+cHQ=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] sched_ext: Fix possible deadlock in the deferred_irq_workfn()
Date: Thu, 13 Nov 2025 19:43:55 +0800
Message-Id: <20251113114355.24572-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

For PREEMPT_RT=y kernels, the deferred_irq_workfn() is executed in
the per-cpu irq_work/* task context and not disable-irq, if the rq
returned by container_of() is current CPU's rq, the following scenarios
may occur:

lock(&rq->__lock);
<Interrupt>
  lock(&rq->__lock);

This commit use IRQ_WORK_INIT_HARD() to replace init_irq_work() to
initialize rq->scx.deferred_irq_work, make the deferred_irq_workfn()
is always invoked in hard-irq context.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2b0e88206d07..747b0d8528ab 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5225,7 +5225,7 @@ void __init init_sched_ext_class(void)
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_kick_if_idle, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_preempt, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_wait, GFP_KERNEL, n));
-		init_irq_work(&rq->scx.deferred_irq_work, deferred_irq_workfn);
+		rq->scx.deferred_irq_work = IRQ_WORK_INIT_HARD(deferred_irq_workfn);
 		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
 
 		if (cpu_online(cpu))
-- 
2.17.1

