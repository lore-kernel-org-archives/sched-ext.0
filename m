Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135A45199D;
	Tue, 15 Sep 2026 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502620; cv=none; b=PgsZjmc3X79nC5zv6QmLNEKkVlVsuhTYp89++aQF9C8d1u+iQ6+uCwVFgImuEBcFDIaJDnJdVzZCscwOD9FfqBPm52n+mC9P+PPrcD1tn5hIr9XH1WmTUdUj8pCC+fXdcP1F/j9cQCinCNq5TO2faTyz09Gd/kWqXVA554er2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502620; c=relaxed/simple;
	bh=J1/smpDyxrDGYiV2CiCgM3SH/pNmEQGWcJotb5hCGts=;
	h=Date:Message-ID:From:To:Cc:Subject; b=mrztDSY9Ay0zaEa8jKzr28A+tFqDTWcpgjAAEiz4oThppz0gapblbY2zUTCZH2jvaq7305o9rwPJPafaZV3x/56FmC2lT0NnACtu4gneqW9T8iRc85MenpkOzGpAmu3JL3II3JIr0sET+vyF09QhUM+sHWsKWKelDJfjL67uxDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4RFndxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4RFndxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C641F000FF;
	Tue, 15 Sep 2026 20:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789502618;
	bh=1NX3L3isMLEq8eW7FJV21zsly+2Sp/DKv+UW45+zKYA=;
	h=Date:From:To:Cc:Subject;
	b=B4RFndxCAC8XHvzYrEbaYL0qH+aeJghzt1MKeDT1PRs+WwnyAW9peSUUywcqiGts3
	 +fZiQlLBuwiQvgj+ZnKi4y31ttvWkXes1bBYUnSac+SClVJhZSfSj3n5oUzw1AJzQO
	 KaqrPBXa6jKSct/dEEkKbg9H1sE7sA+ykqu/dB7+aL5EzxMvQR5tZo83Mpr2cyw+rG
	 LOahuSPUzrnTRrBXqhg0fuFe0hGAEDJDhNm8xG6jFVUQBXSMe/t8kZskhvOz/g6je4
	 nBf5d96z/PRUBbjP+1rUoqrDzKBLaOJnzSSJrddFwduDBonOxVumUHNnw6HJvCS8uA
	 jF4IWRg/kA1Jw==
Date: Tue, 15 Sep 2026 10:03:37 -1000
Message-ID: <a4304b3f0c89fba23f1e5e92997a8f56@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 Qiurong Fang <fangqiurong@kylinos.cn>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.3-fixes] sched_ext: Wait for
 SCX_OPSS_DISPATCHING before reenqueueing a task
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics") moved the final
ops_state store in scx_dispatch_enqueue() after the DSQ unlock so that the
custody update and ops.dequeue() precede it. A task can thus be found on a
DSQ while still SCX_OPSS_DISPATCHING.

The dequeue and core-sched pick paths wait for the state to clear in
ops_dequeue() but the reenqueue paths don't. A reenqueue in that window runs
ops.enqueue() and sets SCX_OPSS_QUEUED before the dispatch has completed.
The dispatcher's final store then overwrites it with SCX_OPSS_NONE and
finish_dispatch() drops every later dispatch of the task.

Wait for SCX_OPSS_DISPATCHING to clear before dequeueing a task for
reenqueue, the same way ops_dequeue() does.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |   13 +++++++++++++
 kernel/sched/ext/internal.h |    1 +
 kernel/sched/ext/sub.c      |    1 +
 3 files changed, 15 insertions(+)

--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4404,6 +4404,17 @@ static bool local_task_should_reenq(stru
 	return *reenq_flags & SCX_REENQ_ANY;
 }
 
+/*
+ * The dispatcher stores the final ops_state after dropping the DSQ lock, so @p
+ * can be found on a DSQ while still %SCX_OPSS_DISPATCHING. Reenqueueing @p
+ * before that store lands would have it clobber the new %SCX_OPSS_QUEUED.
+ */
+void scx_reenq_wait_dispatching(struct task_struct *p)
+{
+	if (unlikely(atomic_long_read_acquire(&p->scx.ops_state) == SCX_OPSS_DISPATCHING))
+		wait_ops_state(p, SCX_OPSS_DISPATCHING);
+}
+
 static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 {
 	LIST_HEAD(tasks);
@@ -4447,6 +4458,7 @@ static u32 reenq_local(struct scx_sched
 		if (!local_task_should_reenq(rq, p, &reenq_flags, &reason))
 			continue;
 
+		scx_reenq_wait_dispatching(p);
 		scx_dispatch_dequeue(rq, p);
 
 		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
@@ -4570,6 +4582,7 @@ static void reenq_user(struct rq *rq, st
 		}
 
 		/* @p is on @dsq, its rq and @dsq are locked */
+		scx_reenq_wait_dispatching(p);
 		dispatch_dequeue_locked(p, dsq);
 		raw_spin_unlock(&dsq->lock);
 
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2078,6 +2078,7 @@ void scx_kick_cpu(struct scx_sched *sch,
 u64 __scx_bpf_now(struct rq *rq);
 void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			u64 reenq_flags, struct rq *locked_rq);
+void scx_reenq_wait_dispatching(struct task_struct *p);
 int __scx_init_task(struct scx_sched *sch, struct task_struct *p,
 		    struct cgroup *cgrp, bool fork);
 void scx_enable_task(struct scx_sched *sch, struct task_struct *p);
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -801,6 +801,7 @@ void scx_reenq_reject(struct rq *rq)
 		if (WARN_ON_ONCE(p->migration_pending))
 			continue;
 
+		scx_reenq_wait_dispatching(p);
 		scx_dispatch_dequeue(rq, p);
 
 		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
