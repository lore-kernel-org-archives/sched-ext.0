Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505A2045AD;
	Thu, 11 Dec 2025 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765493292; cv=none; b=fYhlaJf9HV4nu9Z8iYkgBPFashNKBLfmBxryBd7VnserOkKXoiwKbdYgBlS54wKXPscV8anVV6q6K8DlpfvXcL6BxsQiEiNCHIcgLBzRlQhTbnWlEyAOmwqftqamDP3tJnkbJ0hGXS8Xvpcq0HKZj9/sI+g5zeLxqA1QkZSk0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765493292; c=relaxed/simple;
	bh=D2ksXda8flSP4YqVTk0OL/t1+G6a1rhwtXDlj65xFYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jV19bGWIlmps1f3gd6IZTdBYU/Y9OiH9JXwgNbHd6hh9RGQC+npHPEEb6NRCUAK3NbspJlyFxgDsPWHHdjoYiNWmmHNZdw/E2mXhJ4CrrOtely6NJ88/ZOA/VHO6FyEduDZGKWBJ+t7ypsQIydPw8GcUhh6NuRhE+REYbSE67ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyXgyDCC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyXgyDCC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A138C4CEF7;
	Thu, 11 Dec 2025 22:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765493292;
	bh=D2ksXda8flSP4YqVTk0OL/t1+G6a1rhwtXDlj65xFYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyXgyDCClHNhYUPDDEJdet2Adz0fbH0G5oQ3d2OUYsWsyw9ud2GUKYvC3xYHxvlVX
	 ZAQTFvT65PYwLU082DOf5rScTpEKhP0/GWpD8sETcMyvSAgOMPTNlLSl7NN4lE7MQF
	 lsGBWvn580933CyY/sWk2se2MKxCIAXNwj+SzdQta4S5mqRQgx4N62XSmsgflWgvPi
	 OLXhMDORRDWDcc8zITanFGKxKtvZFaF+kmwElz5WRWhzn3FaVYV9Bsf1CGOHSXZ2TD
	 RGldeRktLeM2pR064/gCTT/AJ+pwOSDk8xO3Nfz/o+EnqYlHOD6YHUSxRkLI4KrrES
	 llovzLWRT7ROQ==
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched_ext: Factor out local_dsq_post_enq() from dispatch_enqueue()
Date: Thu, 11 Dec 2025 12:48:08 -1000
Message-ID: <20251211224809.3383633-2-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211224809.3383633-1-tj@kernel.org>
References: <20251211224809.3383633-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out local_dsq_post_enq() which performs post-enqueue handling for
local DSQs - triggering preemption or resched_curr() if the enqueued task
has higher priority than the currently running task. No functional change.

This will be used by the next patch to fix move_local_task_to_local_dsq().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |   34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -975,6 +975,22 @@ static void refill_task_slice_dfl(struct
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
+static void local_dsq_post_enq(struct scx_dispatch_q *dsq, struct task_struct *p,
+			       u64 enq_flags)
+{
+	struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
+	bool preempt = false;
+
+	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
+	    rq->curr->sched_class == &ext_sched_class) {
+		rq->curr->scx.slice = 0;
+		preempt = true;
+	}
+
+	if (preempt || sched_class_above(&ext_sched_class, rq->curr->sched_class))
+		resched_curr(rq);
+}
+
 static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			     struct task_struct *p, u64 enq_flags)
 {
@@ -1086,22 +1102,10 @@ static void dispatch_enqueue(struct scx_
 	if (enq_flags & SCX_ENQ_CLEAR_OPSS)
 		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
 
-	if (is_local) {
-		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
-		bool preempt = false;
-
-		if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
-		    rq->curr->sched_class == &ext_sched_class) {
-			rq->curr->scx.slice = 0;
-			preempt = true;
-		}
-
-		if (preempt || sched_class_above(&ext_sched_class,
-						 rq->curr->sched_class))
-			resched_curr(rq);
-	} else {
+	if (is_local)
+		local_dsq_post_enq(dsq, p, enq_flags);
+	else
 		raw_spin_unlock(&dsq->lock);
-	}
 }
 
 static void task_unlink_from_dsq(struct task_struct *p,
