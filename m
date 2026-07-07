Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C8F1DC985;
	Tue,  7 Jul 2026 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383182; cv=none; b=Bz4QYQZAfCwQNnK/aPkpFthkEJNyxWjTXJ5bmOszv+ZkBCFIbkSsQi4uKyUua26kNR6Nof9awBbjnckVXliIVKRn69Za2qvJfhDb5ENWOBVDD+tmXaIIKhE4Ekvx6DloIlnbrOGq7kALepN7fgyYKAfVB1DRIE1GJoIKQse0sjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383182; c=relaxed/simple;
	bh=oJsvQjHFtUc6q6knIvg/HNqhxp3sXP/Dt4mt+FNrNZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8JfCGTE6ZJnXX1TNJE2WJM7IOBfw9eTVpmANdQVcrKsQEGBAlXt/skekQ9Six4J8CkmYkAQ7zcY4WyCeMAFLvTqWMIC8E/kfmlyWnyuruTix7mM6UIy2WyE6kNVnPq85049UfQJvlOqst7Q5rpQKB7felCqM21ZYWH2b/Y+3SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjKy6aT1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjKy6aT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD791F00A3E;
	Tue,  7 Jul 2026 00:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783383180;
	bh=o0n/d+9u32ANZKqBygG0ZnC4J9SyYiqc1nT5Td7HIys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cjKy6aT1z+b8sqHs84C0ujVJ3TCc2PGhAXA3pYkL8rZ9ImE05+uxFFAmRh7cHKV6A
	 Qla/eaP7ZZ9nW1kEuD8b6X2BSmk1lQX96K+kEgpQ4VQ2ovT7GmuXa8p0hyRrOEDzue
	 Z/OcETWjB+BOioLR9M872jCLDNnDcpfhr3+WJqUJnGJuKthvEJmaYpodbW8PT/3KDK
	 TvCHF1y3rFGnvAJRuuxsArh2YvIwmlSBlu8sUJb/aRjudIqVxGlbcNaaAURJOakrJr
	 1joHylSdmwL7WCulOovm/Fkn+MsmOe7jUFHTUrHDkzX6cw13jYoeG7ZmxV4s+Vl0rF
	 D/N1RbViuvAsQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 sched_ext/for-7.3 31/36] sched_ext: Authorize remote-move inserts against the placing scheduler
Date: Mon,  6 Jul 2026 14:12:24 -1000
Message-ID: <20260707001229.1410929-32-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707001229.1410929-1-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_local_or_reject_dsq() authorizes a local-DSQ insert against the caps
of the scheduler doing the insert. On the consume/dispatch paths that is
the scheduler running balance_one(), passed down through
scx_consume_dispatch_q() and move_local_task_to_local_dsq(), so the check
is correct.

The remote-move path loses it. move_remote_task_to_local_dsq()
re-activates @p on the destination rq through enqueue_task_scx(), which
reconstructs the scheduler from the task, i.e. @p's owner. When an
ancestor places a descendant's task - e.g. draining a bypassed
sub-scheduler - the owner is a sub-scheduler of the placer, so
authorizing against the owner checks a narrower cap set and can
spuriously reject a task the placer is entitled to run.

Carry the placing scheduler across the activate_task() boundary the same
way enq_flags already are, via a per-rq field set only for the duration
of the re-activation, and have scx_local_or_reject_dsq() authorize
against it. The placer's caps are a superset of the owner's, so this
admits what the placer may run and keeps rejecting what it may not.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 27 +++++++++++++++------------
 kernel/sched/ext/sub.c |  9 +++++++--
 kernel/sched/sched.h   |  3 ++-
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index c6e9a26213f4..1f0c371a8df7 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2248,7 +2248,8 @@ static void move_local_task_to_local_dsq(struct scx_sched *sch,
  *
  * Move @p which is currently on @src_rq to @dst_rq's local DSQ.
  */
-static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
+static void move_remote_task_to_local_dsq(struct scx_sched *sch,
+					  struct task_struct *p, u64 enq_flags,
 					  struct rq *src_rq, struct rq *dst_rq)
 {
 	lockdep_assert_rq_held(src_rq);
@@ -2265,15 +2266,19 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 	raw_spin_rq_lock(dst_rq);
 
 	/*
-	 * We want to pass scx-specific enq_flags but activate_task() will
-	 * truncate the upper 32 bit. As we own @rq, we can pass them through
-	 * @rq->scx.remote_activate_enq_flags instead.
+	 * activate_task() below truncates enq_flags to 32 bits and re-derives
+	 * @p's owner, dropping our scx flags and the placing @sch. We own @rq,
+	 * so stash both across the call. The enqueue reads them back, keeping
+	 * the scx flags and checking caps against the placer, not the owner.
 	 */
 	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr));
-	WARN_ON_ONCE(dst_rq->scx.remote_activate_enq_flags);
+	WARN_ON_ONCE(dst_rq->scx.remote_activate_enq_flags ||
+		     dst_rq->scx.remote_activate_sch);
 	dst_rq->scx.remote_activate_enq_flags = enq_flags;
+	dst_rq->scx.remote_activate_sch = sch;
 	activate_task(dst_rq, p, 0);
 	dst_rq->scx.remote_activate_enq_flags = 0;
+	dst_rq->scx.remote_activate_sch = NULL;
 }
 
 /*
@@ -2402,14 +2407,14 @@ static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
 		!WARN_ON_ONCE(src_rq != task_rq(p));
 }
 
-static bool consume_remote_task(struct rq *this_rq,
+static bool consume_remote_task(struct scx_sched *sch, struct rq *this_rq,
 				struct task_struct *p, u64 enq_flags,
 				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
 	raw_spin_rq_unlock(this_rq);
 
 	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
-		move_remote_task_to_local_dsq(p, enq_flags, src_rq, this_rq);
+		move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, this_rq);
 		return true;
 	} else {
 		raw_spin_rq_unlock(src_rq);
@@ -2471,8 +2476,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 			raw_spin_unlock(&src_dsq->lock);
 		} else {
 			raw_spin_unlock(&src_dsq->lock);
-			move_remote_task_to_local_dsq(p, enq_flags,
-						      src_rq, dst_rq);
+			move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, dst_rq);
 		}
 	} else {
 		/*
@@ -2525,7 +2529,7 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 		}
 
 		if (task_can_run_on_remote_rq(sch, p, rq, false)) {
-			if (likely(consume_remote_task(rq, p, enq_flags, dsq, task_rq)))
+			if (likely(consume_remote_task(sch, rq, p, enq_flags, dsq, task_rq)))
 				return true;
 			goto retry;
 		}
@@ -2619,8 +2623,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 			scx_dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
 					     p, enq_flags | SCX_ENQ_GDSQ_FALLBACK);
 		} else {
-			move_remote_task_to_local_dsq(p, enq_flags,
-						      src_rq, dst_rq);
+			move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, dst_rq);
 			/* task has been moved to dst_rq, which is now locked */
 			locked_rq = dst_rq;
 		}
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index bd133ad014a0..fac596cf350f 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -237,12 +237,17 @@ struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq
 					       struct task_struct *p, u64 *enq_flags)
 {
 	s32 cid = __scx_cpu_to_cid(cpu_of(rq));
+	struct scx_sched *asch = rq->scx.remote_activate_sch ?: sch;
 	u64 needed = scx_caps_for_enq(*enq_flags);
 	u64 missing;
 
+	/*
+	 * On a remote activation the scheduling sched (@asch) differs from
+	 * @p's owner (@sch). Check caps against the scheduling sched.
+	 */
 	if (*enq_flags & SCX_ENQ_PREEMPT)
-		needed |= scx_caps_for_preempt(sch, rq);
-	missing = scx_missing_caps(sch, cpu_of(rq), needed);
+		needed |= scx_caps_for_preempt(asch, rq);
+	missing = scx_missing_caps(asch, cpu_of(rq), needed);
 
 	/* requirements met */
 	if (likely(!missing))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c0a4699a6c0a..cdd21c814008 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -800,8 +800,9 @@ struct scx_rq {
 	struct list_head	runnable_list;		/* runnable tasks on this rq */
 	struct list_head	ddsp_deferred_locals;	/* deferred ddsps from enq */
 	unsigned long		ops_qseq;
-	/* see move_remote_task_to_local_dsq() */
+	/* both stashed across the activate_task() in move_remote_task_to_local_dsq() */
 	u64			remote_activate_enq_flags;
+	struct scx_sched	*remote_activate_sch;
 	u32			nr_running;
 	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
 	bool			in_select_cpu;
-- 
2.54.0

