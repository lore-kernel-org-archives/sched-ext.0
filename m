Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA892C234A
	for <sched-ext@lists.linux.dev>; Mon,  8 Dec 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765193009; cv=none; b=acVVRc5sMpZy0wi+4tQRc9hJUuKt6LRcK/vg2UtjlwiCbaL14+athM9Q67nD2erwv4FLpbWXIQimRYmj4WW+sWfCNZ/5C2lLC/NDegfFd7aSpT9UPfsmWHYX5SCiHXdA7UNQ+4ZeOrdG66E9wWA4YFFY2SwY/bNDBecS/ivX1po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765193009; c=relaxed/simple;
	bh=FoAuYIVEojAr0/r6dSb+kPSPnWNJ7F50XXsVfk61fbs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dYhzDa9V+TJUVLuhG21hwNKLgqdw9PUhc84nx6oq3RynwWliRPrIoNBX2QJ/GntqZBRlNlrMCCnOrrEvNfn7Iatc0fljH6LlK85Nyxhzli+vhw57bMwrUg8U38BsoLlBhWk3dDAfxz/tqVvzqjzbcfFapCk8zG2YGBYT+p1KCu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OQSkyjSJ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OQSkyjSJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765193005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=wpW5EUCFED0eMrUYdftKPG5YatKQofxh4e2a3RdORD4=;
	b=OQSkyjSJ1TLwx4taudKR6hNFNfLwpI/lIG4J3g/TflkfLGqVmpP++QYyOyVQ9t8ntqoDEz
	EB4JnfH+WRK4+dPmNVAo4iBriXad1LMIVHEQVUksAuZxlvpsBOvxjJYuwFR8EDiUrirEBh
	DXir4xqZfwjisFNo1L16mkcTJw6c8hA=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] sched_ext: Fix the memleak for sch->helper objects
Date: Mon,  8 Dec 2025 19:23:19 +0800
Message-Id: <20251208112320.27144-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

This commit use kthread_destroy_worker() to release sch->helper
objects to fix the following kmemleak:

unreferenced object 0xffff888121ec7b00 (size 128):
  comm "scx_simple", pid 1197, jiffies 4295884415
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
    ff ff ff ff 00 00 00 00 ff ff ff ff ff ff ff ff  ................
  backtrace (crc 587b3352):
    kmemleak_alloc+0x62/0xa0
    __kmalloc_cache_noprof+0x28d/0x3e0
    kthread_create_worker_on_node+0xd5/0x1f0
    scx_enable.isra.210+0x6c2/0x25b0
    bpf_scx_reg+0x12/0x20
    bpf_struct_ops_link_create+0x2c3/0x3b0
    __sys_bpf+0x3102/0x4b00
    __x64_sys_bpf+0x79/0xc0
    x64_sys_call+0x15d9/0x1dd0
    do_syscall_64+0xf0/0x470
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index df00df359067..59fa391636c7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3516,7 +3516,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	int node;
 
 	irq_work_sync(&sch->error_irq_work);
-	kthread_stop(sch->helper->task);
+	kthread_destroy_worker(sch->helper);
 
 	free_percpu(sch->pcpu);
 
@@ -4508,7 +4508,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
 	return sch;
 
 err_stop_helper:
-	kthread_stop(sch->helper->task);
+	kthread_destroy_worker(sch->helper);
 err_free_pcpu:
 	free_percpu(sch->pcpu);
 err_free_gdsqs:
-- 
2.17.1

