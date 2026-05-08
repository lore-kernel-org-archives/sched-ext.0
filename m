Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739EA30F95F
	for <sched-ext@lists.linux.dev>; Fri,  8 May 2026 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241060; cv=none; b=Os+ofMaJ+vwo6Y+/FyEqC2dDSWw0AuB4SUFVqlAI2QeSTovvKFm3gXv+HMGFLzUCcWOnPQC1kUDaBHklTduGaz1xoey75bQ8esPyn7vHfxC+97aSZ9DzJFfCd+th72Y4pqQrlyDIbEbsSihd5fwEMIUFCnI1utLOWrM9Kk+lPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241060; c=relaxed/simple;
	bh=Kg9VgwKqysDugUNyQ1F4e6hdDnnJTPjgeXYgAFGSdTI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DuH28QtofXVd/W/WGnnUDiJouNq6JBOIL+orZYoBvt5pXHJqWPYxImQJCICfqTsM1NVnA+fwIFRCe1+LwT6iRx3SEXg7rnLABVRq7ZL7086EayWheC6zpnAWa+axOgQhXj1DILiM8RSqOTXuMsv6GY/MJN6mBW35sOXEDMvndc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xxjY/DUc; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xxjY/DUc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778241056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=AAs1k05Z+eYo43LjlYet0grTAvlw+pleDZML7XVrxI8=;
	b=xxjY/DUc7yowaJldZfTHdFeX9vnN/81p5Vq5jEOTkv6JdOB8urDAdpJdll7mwBdIXU+72P
	rt8qssuKzq/wxRBz+YZ5TlWGW5CQyZpPyZe6vNAw41n0MqJzhHrylsmN3ghOmq5lnBr/VU
	juHL/8qMSyHnG4PAudH+/vdxggYQk6I=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	yphbchou0911@gmail.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] sched_ext: Use IRQ_WORK_INIT_HARD() to initialize sch->disable_irq_work
Date: Fri,  8 May 2026 19:50:45 +0800
Message-Id: <20260508115045.23739-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

For built with PREEMPT_RT kernels, the scx_disable_irq_workfn() is
called from per-cpu irq_work kthreads context, this means that
when call the scx_dump_state() in the scx_disable_irq_workfn() to
output current->comm/pid, it always output current irq_work kthread's
comm/pid. this commit therefore use the IRQ_WORK_INIT_HARD() to
initialize sch->disable_irq_work to make scx_disable_irq_workfn() is
called from hardirq context.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d5be34e7b8ae..ef4e8e6addd1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6770,7 +6770,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 
 	sch->slice_dfl = SCX_SLICE_DFL;
 	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
-	init_irq_work(&sch->disable_irq_work, scx_disable_irq_workfn);
+	sch->disable_irq_work = IRQ_WORK_INIT_HARD(scx_disable_irq_workfn);
 	kthread_init_work(&sch->disable_work, scx_disable_workfn);
 	timer_setup(&sch->bypass_lb_timer, scx_bypass_lb_timerfn, 0);
 
-- 
2.17.1

