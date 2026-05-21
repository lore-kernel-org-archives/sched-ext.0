Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94EC3B47D9
	for <sched-ext@lists.linux.dev>; Thu, 21 May 2026 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361171; cv=none; b=RvIBCxnvA6eAdWfZ0D3R738pTuR3o2tLm8BV81//ikLHc75rD7mdbuUpYU17J5gDMximSgKlTIt5V6b/VG1er+DOA/eOG0na6ABp36yAONg0leIDeanQkgnEdIld1MmX4o4IUvtVwWwC/hDFTQ5HICJnOIW5Gd01TCJIxkscifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361171; c=relaxed/simple;
	bh=68BoloNQf89hwszkqHA3k7O+Xe7v8Bwd2EmyJ5oj5pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUmyh/ivKW/zucpD5cZqxEz0RR91jrbZAnEYuMNpA33xs9/nZOOZK8I48ncYOHj625Hr7UFSA5klc+hYPr2LVNJor/L3TkraHfSIkVjQ84vUdqQVm0qncaBR6sRYqF15mqfWTpf50xOUckgQ6qnZ/Rsy1L8D0yYR/Ph43q+lBuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=fHmJO4lt; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="fHmJO4lt"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 19DEC27085;
	Thu, 21 May 2026 12:59:28 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7buWGWefuTCj; Thu, 21 May 2026 12:59:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1779361167; bh=68BoloNQf89hwszkqHA3k7O+Xe7v8Bwd2EmyJ5oj5pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fHmJO4ltboA9k2cmn0UfsusYv2ztH4CdS4pSyamXgQXJaCfHIzMBFFev2ZctXu6fK
	 w0eRzjBeyia6rCdrs9T7aXYE6myUMjgmDrMfzHfPGcSXB07p0bWAeOedP49FXUXKrM
	 TWQQtgrnWEptNuZEBohBarlm6jYo3pWrOaZLSQHJwdqTpieyVthWpWCIgTU9JBtK8W
	 FvglRWASyhH79udtIhKkcEzLU8fsF4mG7I1pqYod4BguVk2BhgROGkLEpAMIFhbyRy
	 O6t+zC0McxjFXaALXLfbuEEgnGd+NuRhY6SkxW2AbBFGNYQ7c9T4NRAynaHX+KszHw
	 Dogu8EmQlR2AA==
From: Samuele Mariotti <smariotti@disroot.org>
To: arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Samuele Mariotti <smariotti@disroot.org>,
	Paolo Valente <paolo.valente@unimore.it>
Subject: [PATCH V2 1/1] sched_ext: Fix spurious WARN on stale ops_state in ops_dequeue()
Date: Thu, 21 May 2026 12:59:11 +0200
Message-ID: <20260521105911.1814606-2-smariotti@disroot.org>
In-Reply-To: <20260521105911.1814606-1-smariotti@disroot.org>
References: <20260521105911.1814606-1-smariotti@disroot.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ops_dequeue() can race with finish_dispatch() and spuriously trigger the
"queued task must be in BPF scheduler's custody" warning.

ops_dequeue() snapshots p->scx.ops_state via atomic_long_read_acquire()
and then, in the SCX_OPSS_QUEUED arm, asserts that SCX_TASK_IN_CUSTODY
is set. The two reads are not atomic w.r.t. a concurrent
finish_dispatch() running on another CPU:

CPU 1                                    CPU 2
=====                                    =====
                                         dequeue_task_scx()
                                           ops_dequeue()
                                             opss = read_acquire(ops_state)
                                                  = SCX_OPSS_QUEUED
finish_dispatch()
  cmpxchg ops_state:
    SCX_OPSS_QUEUED -> SCX_OPSS_DISPATCHING  [succeeds]
  dispatch_enqueue(SCX_DSQ_GLOBAL,
                   SCX_ENQ_CLEAR_OPSS)
    call_task_dequeue()
      p->scx.flags &= ~SCX_TASK_IN_CUSTODY
                                             WARN_ON_ONCE(!(p->scx.flags &
                                                     SCX_TASK_IN_CUSTODY))
                                            /* opss is stale: QUEUED,
                                             * but task already claimed */
    set_release(ops_state, SCX_OPSS_NONE)

The race has been observed via two distinct call chains: the most common
goes through sched_setaffinity(), a rarer variant through
sched_change_begin().

For SCX_DSQ_GLOBAL / SCX_DSQ_BYPASS, dispatch_enqueue() clears
SCX_TASK_IN_CUSTODY before clearing ops_state to SCX_OPSS_NONE
(intentional, to avoid concurrent non-atomic RMW of p->scx.flags against
ops_dequeue()). The window between those two writes is exactly what
ops_dequeue() observes as "QUEUED without custody".

The observed state is not actually inconsistent, it just means CPU 1 has
already claimed the task and the QUEUED value held by CPU 2 is stale.
Re-read ops_state in that case; the next read is guaranteed to return
SCX_OPSS_DISPATCHING or SCX_OPSS_NONE, both of which exit the switch
cleanly. The retry is bounded: once IN_CUSTODY is cleared, ops_state has
already advanced past QUEUED for this dispatch cycle, and a fresh QUEUED
would require re-enqueue under p's rq lock, which CPU 2 holds.

Changes in v2:
- Use READ_ONCE() for p->scx.flags to ensure fresh reads and prevent
  compiler reordering in the lockless path
- Add cpu_relax() to reduce power consumption and improve performance
  during the spin-wait
- Use unlikely() to optimize branch prediction for the common case
- Expand the in-code comment to document the race condition and
  bounded retry guarantee

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Suggested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Samuele Mariotti <smariotti@disroot.org>
Signed-off-by: Paolo Valente <paolo.valente@unimore.it>
---
 kernel/sched/ext.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 547ca398f646..c1762420cc35 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2078,6 +2078,7 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 	/* dequeue is always temporary, don't reset runnable_at */
 	clr_task_runnable(p, false);
 
+retry:
 	/* acquire ensures that we see the preceding updates on QUEUED */
 	opss = atomic_long_read_acquire(&p->scx.ops_state);
 
@@ -2091,8 +2092,20 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 		 */
 		BUG();
 	case SCX_OPSS_QUEUED:
-		/* A queued task must always be in BPF scheduler's custody */
-		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_IN_CUSTODY));
+		/*
+		 * A queued task must always be in BPF scheduler's custody. If
+		 * SCX_TASK_IN_CUSTODY is clear, finish_dispatch() on another
+		 * CPU has already passed call_task_dequeue() (which clears the
+		 * flag), but has not yet written SCX_OPSS_NONE. That final
+		 * store does not require this rq's lock, so retrying with
+		 * cpu_relax() is bounded: we will observe NONE (or DISPATCHING,
+		 * handled by the fallthrough) on a subsequent iteration.
+		 */
+		if (unlikely(!(READ_ONCE(p->scx.flags) & SCX_TASK_IN_CUSTODY))) {
+			cpu_relax();
+			goto retry;
+		}
+
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
 			break;
-- 
2.54.0

