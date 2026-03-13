Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE433DEAD0;
	Fri, 13 Mar 2026 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427075; cv=none; b=cjI83qZ0PK4jdiRuITIZ0OPX2vzPufP8/3Wudv9th1Q7rFjWEU55qCIBhnLA6P9288qbGL6/yF8Di8q/r47fNzd6rGqUBNQic+We4egLbQV2g5YRlDhoRH49rte3sfee0Az3x6BoNpeNHp0wDnkJvMuq7Qoddeu/kjwXUH6xVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427075; c=relaxed/simple;
	bh=yCgHs6ikM/jPq6s+Z9A8o3VFg5xiTtTTGnBTykJNDeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uh3Pf7NBJDYLWQTzlhc4jAyF2m+mNL52DZjDwpXNlowhLElgwUvLTbeYzkjY9Fd2wystpWjnT4uIFSNdvka3WZ41eN7kuZ+XEJWmizXgWWQBAhCAlDtdSThBj0mrIMUIJPGN39SHW0j99sIlDDmmsFDBNp/5M8mNv4tmvcAU2dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGGH6ocA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGGH6ocA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A782C19421;
	Fri, 13 Mar 2026 18:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773427075;
	bh=yCgHs6ikM/jPq6s+Z9A8o3VFg5xiTtTTGnBTykJNDeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGGH6ocAT4vn65D6DvK7oddnexgcWmuOPauRQwcRmEGEmio8a5VjRMw5BwI13onhz
	 psNUadLIuw0fwenSdbYrcjmQRWOYrIlZhrkghdVO0xfpIlBiiPf/ImMyacPzn0HmOp
	 5s3BoySIq9Z7f42LytA/0BFM+z4gpc/zbAfs0Vi3rzajCQn74QBQFWZ2E1w4eqJb/f
	 XjpAkTJ2pMb/ncMSihhTU0AGoiOG0xGsRS6zp8ixTaHzkfuIwLoyUfmITsKZSu1HQU
	 mbV8dMYSK5hOzA/PbyySDkYvb32PKNBs5M8UYHFAODV1rCs1UNaxzmtkykZr1kwnxH
	 C111pvbtBG/VA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/6 sched_ext/for-7.1] sched_ext: Use schedule_deferred_locked() in schedule_dsq_reenq()
Date: Fri, 13 Mar 2026 08:37:53 -1000
Message-ID: <20260313183753.1825456-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313113114.1591010-1-tj@kernel.org>
References: <20260313113114.1591010-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

schedule_dsq_reenq() always uses schedule_deferred() which falls back to
irq_work. However, callers like schedule_reenq_local() already hold the
target rq lock, and scx_bpf_dsq_reenq() may hold it via the ops callback.

Add a locked_rq parameter so schedule_dsq_reenq() can use
schedule_deferred_locked() when the target rq is already held. The locked
variant can use cheaper paths (balance callbacks, wakeup hooks) instead of
always bouncing through irq_work.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f7def0c57b51..a87d99ffe1fe 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1218,8 +1218,10 @@ static void schedule_deferred_locked(struct rq *rq)
 }
 
 static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
-			       u64 reenq_flags)
+			       u64 reenq_flags, struct rq *locked_rq)
 {
+	struct rq *rq;
+
 	/*
 	 * Allowing reenqueues doesn't make sense while bypassing. This also
 	 * blocks from new reenqueues to be scheduled on dead scheds.
@@ -1228,7 +1230,8 @@ static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 		return;
 
 	if (dsq->id == SCX_DSQ_LOCAL) {
-		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
+		rq = container_of(dsq, struct rq, scx.local_dsq);
+
 		struct scx_sched_pcpu *sch_pcpu = per_cpu_ptr(sch->pcpu, cpu_of(rq));
 		struct scx_deferred_reenq_local *drl = &sch_pcpu->deferred_reenq_local;
 
@@ -1247,10 +1250,9 @@ static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 				list_move_tail(&drl->node, &rq->scx.deferred_reenq_locals);
 			WRITE_ONCE(drl->flags, drl->flags | reenq_flags);
 		}
-
-		schedule_deferred(rq);
 	} else if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN)) {
-		struct rq *rq = this_rq();
+		rq = this_rq();
+
 		struct scx_dsq_pcpu *dsq_pcpu = per_cpu_ptr(dsq->pcpu, cpu_of(rq));
 		struct scx_deferred_reenq_user *dru = &dsq_pcpu->deferred_reenq_user;
 
@@ -1269,11 +1271,15 @@ static void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq
 				list_move_tail(&dru->node, &rq->scx.deferred_reenq_users);
 			WRITE_ONCE(dru->flags, dru->flags | reenq_flags);
 		}
-
-		schedule_deferred(rq);
 	} else {
 		scx_error(sch, "DSQ 0x%llx not allowed for reenq", dsq->id);
+		return;
 	}
+
+	if (rq == locked_rq)
+		schedule_deferred_locked(rq);
+	else
+		schedule_deferred(rq);
 }
 
 static void schedule_reenq_local(struct rq *rq, u64 reenq_flags)
@@ -1283,7 +1289,7 @@ static void schedule_reenq_local(struct rq *rq, u64 reenq_flags)
 	if (WARN_ON_ONCE(!root))
 		return;
 
-	schedule_dsq_reenq(root, &rq->scx.local_dsq, reenq_flags);
+	schedule_dsq_reenq(root, &rq->scx.local_dsq, reenq_flags, rq);
 }
 
 /**
@@ -8845,7 +8851,7 @@ __bpf_kfunc void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags,
 		reenq_flags |= SCX_REENQ_ANY;
 
 	dsq = find_dsq_for_dispatch(sch, this_rq(), dsq_id, smp_processor_id());
-	schedule_dsq_reenq(sch, dsq, reenq_flags);
+	schedule_dsq_reenq(sch, dsq, reenq_flags, scx_locked_rq());
 }
 
 /**
-- 
2.53.0

