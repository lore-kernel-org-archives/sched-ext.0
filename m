Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533FE529417;
	Thu, 15 Oct 2026 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084698; cv=none; b=bKY3e6EcWLznsqHbTn/txaWvvm2a85KwVQYbHwb/HBbmE0rEKA7ppuJt2+P+TJ0LLFWIGv2SAhuCh9zp0l+SGUikgoxjtBVGcu0RNa975xDo1TDUqfkZ+hU5ngNu98+W0eByX2jrP4id7D88ZwXxYMrkVu7nrxUr+C8+9dhuIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084698; c=relaxed/simple;
	bh=DRguH0xaQl04xtBKffn8Nb3MdWdMreek8/1o6KIVta8=;
	h=Date:From:To:Cc:Message-ID:Subject; b=mCOBspkx9QqWJlQnq+LzgGGeHZz0d1LGWugOOUzQneahf14JLqREDjs1qDKVcaZB3YWsZ8151mpibM0I5+3mpzM+xNxXbpLhf2JFzCpA/wpPfR99jy0CczXCS6OuB/2wcixy3UkDM0tCdnCt6vkC9+Br89MkRHMafLRQdpirHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeiejSEe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeiejSEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD6B1F000C6;
	Thu, 15 Oct 2026 17:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792084686;
	bh=805FUkdxNGNay9RfFRN7XUZGYeEbVg/yYMLfW8xKPSc=;
	h=Date:From:To:Cc:Subject;
	b=QeiejSEeXRzZFCMlvHtn0rZq3ICsvN25lxt69LhAk90OSL2BTjvlpCxdO3+e5/xl2
	 o9WaJZMTtml9MR90a4Q1cJ1U1WHtd0f5B6VCJYmaqpzDGFZpVEwY92qRmWqD02db5S
	 2z7dk6aA2rsm/lzBfIXiFPVkCwrKPXhcoSJK/ZKcwouMbz7JZrOjtKL9RhsSTZkCyq
	 qvMBpjmYJCfd+ve6+97h3k6rgrDVRuBE6HATMWym+EVY+geCNDalBKvEHWwZ0IIH7V
	 ryrBBD4Kra2aZPMxaxduYd7jmgemrPntyzmmoMG2WFADloASpA523TExaiPeaglSAo
	 zozT1cjKi1kPQ==
Date: Thu, 15 Oct 2026 07:18:05 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Message-ID: <20261015171628.714661316-1-tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3-fixes] sched_ext: Fix use-after-free of a local reenq node left on an inactive cpu
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

A local DSQ reenq is queued on the rq through a per-sched node and run from
deferred work. When the reenq is requested from dispatch, the work is a
balance callback queued once dispatch is done. A cpu going down installs
balance push early in its teardown, and queue_balance_callback() refuses new
callbacks from then on. ops.dispatch() keeps running on that cpu until the
rq goes offline after an RCU grace period, so a reenq it requests in that
window may never run. The IMMED handling in dispatch_one() requests one the
same way.

A reenq requested from elsewhere for a cpu that is already offline goes
through irq_work_queue_on(), which warns, and its work doesn't run until the
cpu comes back.

Either way the node stays on the rq's list. When the scheduler is freed,
scx_sched_free_rcu_work() warns and frees the pcpu with the node still
linked, and the list is walked again once the cpu comes back.

An inactive cpu's local DSQ holds only tasks that are bound to it or are
being moved off, so the reenq is pointless. Ignore reenqs of an inactive
cpu's local DSQ.

The test is lockless. The hotplug thread of a cpu going down runs on that
cpu, and it marks the cpu inactive before it installs balance push. A
dispatch on the cpu runs to completion before that thread can run there, so
a dispatch that saw the cpu active has queued its callback by then. Requests
from outside dispatch run from the wakeup path or through irq_work, which
balance push doesn't affect. The grace period after the cpu goes inactive
waits for any requester that saw it active, so that irq_work is queued while
the cpu is online.

Fixes: 238eba8c210d ("sched_ext: Use schedule_deferred_locked() in schedule_dsq_reenq()")
Fixes: 76edc2761ab8 ("sched_ext: Use irq_work_queue_on() in schedule_deferred()")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1103,6 +1103,18 @@ void schedule_dsq_reenq(struct scx_sched
 		rq = container_of(dsq, struct rq, scx.local_dsq);
 
 		/*
+		 * An inactive cpu's local DSQ holds only tasks that are bound
+		 * to it or are being moved off, so a reenq of it is pointless.
+		 * Once balance push is installed, queue_balance_callback() also
+		 * drops the callback that would run a reenq requested from
+		 * dispatch, and irq_work_queue_on() can't reach an offline cpu.
+		 * The reenq's node would then stay on this rq's list after
+		 * @sch's pcpu is freed.
+		 */
+		if (unlikely(!cpu_active(cpu_of(rq))))
+			return;
+
+		/*
 		 * A sub-sched lacking baseline access on the target cid has no
 		 * business triggering IPIs. The lockless test is fine: slipping
 		 * through right after a revoke is harmless and a wrong denial
@@ -10020,7 +10032,8 @@ __bpf_kfunc struct task_struct *scx_bpf_
  * - Local DSQs (%SCX_DSQ_LOCAL or %SCX_DSQ_LOCAL_ON | $cpu)
  * - User DSQs
  *
- * Re-enqueues are performed asynchronously. Can be called from anywhere.
+ * Re-enqueues are performed asynchronously. Can be called from anywhere. A
+ * re-enqueue of an inactive cpu's local DSQ is ignored.
  *
  * %SCX_DSQ_LOCAL resolves to the local DSQ of the rq the current scheduler
  * operation is locked to - e.g. the rq being dispatched for in ops.dispatch() -
