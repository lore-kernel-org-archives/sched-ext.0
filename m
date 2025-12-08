Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AAE313E34
	for <sched-ext@lists.linux.dev>; Mon,  8 Dec 2025 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765193012; cv=none; b=pe7UXNt6F8R68ltqOVlptOphvFZizYQvH7gCDj+PGiPFXTf4FWyd2Uu3X/zy9QcbcGsV8uJVHWVhUYxTPpobSBxjG3TkfZSGki7LgGpWOom9N2jjTtgnjdmN91xlnilOxNOOyP1G61QD2w1IJdDgZeNKoAPa8R3FtIH+I/LBfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765193012; c=relaxed/simple;
	bh=0m5iAW/Nd8j7hDlOxLcA4Noqp62jm6vf7BKFDjDMhcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FuEW6jXinWbqjGX4JfRtO45V9Ks+tn2ohGQD2tJ6HA4ym/MSyTLYNFmDCr3xIGPVLGGjt7KTtdZCooyzyAUOdy6oE3UMzhMIoJLfvwLhwI3HAexN/geQ1/jPNxUY6J94JGC2A7gPxs7tLSx2YUeMHsvTJxfxIR1wbGOkMEHSMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LV5KjtAs; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LV5KjtAs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765193008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=FBA1+KfP4TBsycv0Ln832wv6CmXeR/OBRu0sYKDXMm0=;
	b=LV5KjtAsqaF8GGDSByymzF02D4FgnTAhhfuZVVpdVYwlycYlTxsHOGO/FXerwR4YWi9Ug2
	6L3RICG6Ktma13IgbobVbtiyMUgGVBvWP9dj6e08neuLWDzB7jydubI2k+cI3mvyvo6s//
	c/bYt8KjMZtKrGt4IumweYpRRVjc5ng=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] sched_ext: Fix lockdep warnings in the ops_dump_init()
Date: Mon,  8 Dec 2025 19:23:20 +0800
Message-Id: <20251208112320.27144-2-qiang.zhang@linux.dev>
In-Reply-To: <20251208112320.27144-1-qiang.zhang@linux.dev>
References: <20251208112320.27144-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

For builts with PREEMPT_RT=y kernel, the dump_lock convert to
sleepable rt-spinlock and not disable-irq, the following lockdep
warning will appear:

WARNING: CPU: 3 PID: 47 at kernel/sched/ext.c:4130 ops_dump_init+0x60/0xa0
Modules linked in:
CPU: 3 UID: 0 PID: 47 Comm: irq_work/3
RIP: 0010:ops_dump_init+0x60/0xa0
Call Trace:
<TASK>
scx_dump_state+0x1091/0x1620
? __schedule+0xf1c/0x3ec0
? rcu_is_watching+0x19/0xb0
? __pfx_scx_dump_state+0x10/0x10
? kvm_sched_clock_read+0x15/0x30
? __lock_acquire+0x98b/0x1ae0
? __this_cpu_preempt_check+0x17/0x20
? insn_get_modrm+0x107/0x6e0
scx_error_irq_workfn+0xeb/0x120
irq_work_single+0x113/0x260
irq_work_run_list.part.7+0x44/0x70
run_irq_workd+0x6b/0x90
? __pfx_run_irq_workd+0x10/0x10
smpboot_thread_fn+0x34c/0xa50
? trace_preempt_on+0x54/0x120
? __pfx_smpboot_thread_fn+0x10/0x10
kthread+0x411/0x8a0
? __pfx_kthread+0x10/0x10
? rt_spin_unlock+0x9f/0x210
? __pfx_kthread+0x10/0x10
ret_from_fork+0x406/0x500
? __switch_to_asm+0x33/0x70
? __pfx_kthread+0x10/0x10
ret_from_fork_asm+0x1a/0x30
</TASK>

This commit therefore convert dump_lock to raw spinlock.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/sched/ext.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 59fa391636c7..2e19e3689f1c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4235,7 +4235,7 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
 
 static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 {
-	static DEFINE_SPINLOCK(dump_lock);
+	static DEFINE_RAW_SPINLOCK(dump_lock);
 	static const char trunc_marker[] = "\n\n~~~~ TRUNCATED ~~~~\n";
 	struct scx_sched *sch = scx_root;
 	struct scx_dump_ctx dctx = {
@@ -4251,7 +4251,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 	char *buf;
 	int cpu;
 
-	spin_lock_irqsave(&dump_lock, flags);
+	raw_spin_lock_irqsave(&dump_lock, flags);
 
 	seq_buf_init(&s, ei->dump, dump_len);
 
@@ -4375,7 +4375,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
 		       trunc_marker, sizeof(trunc_marker));
 
-	spin_unlock_irqrestore(&dump_lock, flags);
+	raw_spin_unlock_irqrestore(&dump_lock, flags);
 }
 
 static void scx_error_irq_workfn(struct irq_work *irq_work)
-- 
2.17.1

