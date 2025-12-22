Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3066C256C6C
	for <sched-ext@lists.linux.dev>; Mon, 22 Dec 2025 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404425; cv=none; b=R1jOZsi1j+waVggTxeprq5y9GG4sLiUzt0OZmyaUwMjLs5iMKetzmVCqOM+Hjrm6eOfa4DEjsqMDzkN86UDiUAPsZeAZIMSJaU2FqKHbzAyrOTWjx7t2YOmMYXqNq5vrdkllozCZKSsxcfhLm2+JaMPyZMQqlaIOib9A4ugyZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404425; c=relaxed/simple;
	bh=iDBH31KAvMiK7gGK24TkR0zHqbvwVIlROnHVFcdNe3I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jUCVglmRF52x7JUbqT5riO7EvdVOszKTnvdJlDK8NFNee5B4aAn29lXzuiIiZJU2adxSSobvDmejwHvD7BYOiuJQOA8777W/Xo14xapyso+pv7t86m0g/y8FZfoIrWL/QV/ZBJuO6mSLaJu0GkDf3jUbjI0xqILJ2palwDXEfzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U2XRcYqJ; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U2XRcYqJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766404420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=0tzTYav6q6uZxzhZYoGqQH8itSljy9YuKM+a57abJ70=;
	b=U2XRcYqJW42dg1qvfBYBFmJ2/VExM6Pe8tD4rPlvpPT62bHR8nmHCg7qUDhT5kNnvT67jQ
	2ht5rUyzqctnwjXF/gMcGQipZJt8Bej4OaYn9nEozJTQ5ZU+dNSXEzR++TlPZEqkYWhjMg
	4WPFpYGFeE6tysk0Jof26kXKyOyKjMc=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] sched_ext: Use the resched_cpu() to replace resched_curr() in the bypass_lb_node()
Date: Mon, 22 Dec 2025 19:53:17 +0800
Message-Id: <20251222115318.18997-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

For the PREEMPT_RT kernels, the scx_bypass_lb_timerfn() running in the
preemptible per-CPU ktimer kthread context, this means that the following
scenarios will occur(for x86 platform):

       cpu1                          cpu2
				 ktimer kthread:
                                 ->scx_bypass_lb_timerfn
                                   ->bypass_lb_node
                                     ->for_each_cpu(cpu, resched_mask)

    migration/1:                       by preempt by migration/2:
    multi_cpu_stop()                     multi_cpu_stop()
    ->take_cpu_down()
      ->__cpu_disable()
	->set cpu1 offline

                                       ->rq1 = cpu_rq(cpu1)
                                       ->resched_curr(rq1)
                                         ->smp_send_reschedule(cpu1)
					   ->native_smp_send_reschedule(cpu1)
					     ->if(unlikely(cpu_is_offline(cpu))) {
                					WARN(1, "sched: Unexpected
							reschedule of offline CPU#%d!\n", cpu);
                					return;
        					}

This commit therefore use the resched_cpu() to replace resched_curr()
in the bypass_lb_node() to avoid send-ipi to offline CPUs.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/sched/ext.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5ebf8a740847..8f6d8d7f895c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3956,13 +3956,8 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 					     nr_donor_target, nr_target);
 	}
 
-	for_each_cpu(cpu, resched_mask) {
-		struct rq *rq = cpu_rq(cpu);
-
-		raw_spin_rq_lock_irq(rq);
-		resched_curr(rq);
-		raw_spin_rq_unlock_irq(rq);
-	}
+	for_each_cpu(cpu, resched_mask)
+		resched_cpu(cpu);
 
 	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
 		u32 nr = READ_ONCE(cpu_rq(cpu)->scx.bypass_dsq.nr);
-- 
2.17.1

