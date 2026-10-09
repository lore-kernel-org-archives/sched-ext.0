Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244DB31E844;
	Fri,  9 Oct 2026 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583307; cv=none; b=gl9vX9kwjrCyq5CDHwy3HE2k4mLqW47TjzZclEqSojfYuaXOVJhPV3O7us0bLWuiYSLBHRrs1jiV+5RikDKyHoWqa/xXCf4U5HwqON4ajFX5w2nfVBmWz7v8e3oig7ElhwGUUbdBfpztomOEYmuS61oW0CPtJUI6SSxtMV5m2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583307; c=relaxed/simple;
	bh=Slwqbmadkcoo574iR+kAVkJQ+P6a5VRxQg3DfEccmkU=;
	h=Date:From:To:Cc:Message-ID:Subject; b=UzDii85kQBfSlG2oOpKRb0jdLDE1aBxjnuK/lH1Oup/mjRn2MPvH54N7pNaQpoUYixEonFbGEeS6U6kpgQVA1nvwUMg+7iQ4YZmm3KfronjAuxaoizFUsu6KfESJqXwpLe65vL6ySphcKgjOQ4eO1HK+wZ0uhWwa0fk+KLaPQ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9hLVX7p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9hLVX7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BF01F000FF;
	Fri,  9 Oct 2026 22:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791583306;
	bh=IBG5j/dZ2hTNDKhmiuQZc0JwV/nWQkgBL0WOmT/X3KA=;
	h=Date:From:To:Cc:Subject;
	b=V9hLVX7pXhtArprnvnTdBZ60z7lpl51Pe/aJzHcltz+JVeN8JcxIfxskY0oEb4aS3
	 /DOMcvirRnxX3AuoLLM1/LEtxFG2vsW3WuH/inUHNUnj/27naShIxc4u2uTaItZwLa
	 EnR0OIKvW4QPq9MZO0rsFrbLlUFk4U7h/cDxNoTp7xX4Q070s70BBPZuiNsxbKt8dv
	 0a0+cv1sKbdZp8+1x3Ky2tBqWtyybTpn1o9LvctJva4+heAe7n8+CobRrJeBbUETLx
	 SlIU/A0bsdbJ12gA68qSoxBgn6f1XDpd1MZprmpP5Q46BWwYk3QAWlExM1T1S+qRs9
	 dyY8YIp6Jtcdw==
Date: Fri, 09 Oct 2026 12:01:45 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Hui Su <sh_def@163.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 David Dai <david.dai@linux.dev>, Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Message-ID: <20261009220001.196762128-1-tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3-fixes] sched_ext: Fix use-after-free of a destroyed user DSQ by a deferred reenqueue
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

A deferred reenqueue can read a freed user DSQ. The request stays on its
CPU's deferred list until run_deferred() takes it, and the RCU callback that
frees the DSQ assumes that the grace period has flushed it, so exit_dsq()
checks the per-CPU node without the deferred list lock. A grace period waits
for readers in flight, not for a pending run_deferred(). A run_deferred()
which starts after the grace period began can detach the request right
before the callback looks and then read the freed DSQ's id.

Cancel the pending requests before the grace period instead. The irq work
that frees the DSQ unlinks every CPU's request under the per-CPU deferred
list lock, and schedule_dsq_reenq() ignores a new request under the same
lock once the id is invalid. Only a run_deferred() that started before the
grace period can hold a request, and it runs with IRQs disabled, so the
grace period waits for it and nothing touches the DSQ after the callback.

Fixes: 84b1a0ea0b7c ("sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs")
Cc: stable@vger.kernel.org # v7.1+
Reported-by: Hui Su <sh_def@163.com>
Link: https://lore.kernel.org/all/20261008024753.4096008-1-sh_def@163.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c |   28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1149,6 +1149,10 @@ void schedule_dsq_reenq(struct scx_sched
 
 			guard(raw_spinlock_irqsave)(&rq->scx.deferred_reenq_lock);
 
+			/* @dsq is being destroyed, see free_dsq_irq_workfn() */
+			if (unlikely(READ_ONCE(dsq->id) == SCX_DSQ_INVALID))
+				return;
+
 			if (list_empty(&dru->node))
 				list_move_tail(&dru->node, &rq->scx.deferred_reenq_users);
 			WRITE_ONCE(dru->flags, dru->flags | reenq_flags);
@@ -5171,8 +5175,8 @@ static void exit_dsq(struct scx_dispatch
 		struct rq *rq = cpu_rq(cpu);
 
 		/*
-		 * There must have been a RCU grace period since the last
-		 * insertion and @dsq should be off the deferred list by now.
+		 * free_dsq_irq_workfn() cancelled the reenqs before the grace
+		 * period and schedule_dsq_reenq() queues nothing after that.
 		 */
 		if (WARN_ON_ONCE(!list_empty(&dru->node))) {
 			guard(raw_spinlock_irqsave)(&rq->scx.deferred_reenq_lock);
@@ -5196,8 +5200,26 @@ static void free_dsq_irq_workfn(struct i
 	struct llist_node *to_free = llist_del_all(&dsqs_to_free);
 	struct scx_dispatch_q *dsq, *tmp_dsq;
 
-	llist_for_each_entry_safe(dsq, tmp_dsq, to_free, free_node)
+	llist_for_each_entry_safe(dsq, tmp_dsq, to_free, free_node) {
+		s32 cpu;
+
+		/*
+		 * Cancel pending reenqs. Only a run_deferred() that started
+		 * before the grace period can hold one, and it keeps IRQs off,
+		 * so the grace period waits for it. After this sweep,
+		 * schedule_dsq_reenq() sees the invalid id under the same lock
+		 * and queues nothing.
+		 */
+		for_each_possible_cpu(cpu) {
+			struct scx_dsq_pcpu *pcpu = per_cpu_ptr(dsq->pcpu, cpu);
+			struct rq *rq = cpu_rq(cpu);
+
+			guard(raw_spinlock_irqsave)(&rq->scx.deferred_reenq_lock);
+			list_del_init(&pcpu->deferred_reenq_user.node);
+		}
+
 		call_rcu(&dsq->rcu, free_dsq_rcufn);
+	}
 }
 
 static DEFINE_IRQ_WORK(free_dsq_irq_work, free_dsq_irq_workfn);
