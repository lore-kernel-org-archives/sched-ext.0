Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0DC2F7ACD;
	Mon, 10 Nov 2025 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808203; cv=none; b=iJfQDs4ZvnyrMIiXY6tlfbKkUu8Z10VrrGx5Gg0SQb2jDdzsXdTu6xeTvRZR10w8qEzl7Btao4nNOBGhxZ6L5DXetcnbU2SDWzQ+sLsKnQoDdbZHdkcAg851eiRDeARC+mnCDpqxxSqt09byHT8BGGxsP1m1vm4IOfp5Fp3ldmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808203; c=relaxed/simple;
	bh=pok+dP2FL4/bENdMwjkWaySxM4LzKzvA7emyZuGYTC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyH5A5XDo4819RAQ5dznbHKqW0RztQ20z0/B7s+8bGYJ+cgNdUVH8nXJKMsddAtf/GtUWB9LJRwbKD2TCNemymYPc32YnOwbklW0j8kNnd4XD5knwOmsakat5zaElPCquIVrpq0LK1MS6saep45lGYnDQBQ79ZThsaqp0wEiG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jd5Ft/UV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jd5Ft/UV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C541C19424;
	Mon, 10 Nov 2025 20:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762808202;
	bh=pok+dP2FL4/bENdMwjkWaySxM4LzKzvA7emyZuGYTC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jd5Ft/UVzdiNOII3j+nx2tfFpRiPCABbycrlKThBsz/yZ/S+aDvcPLoE3dUlc353k
	 mzjYDyXvZkVay+rYWvxEibhebtiuGOVQY5XSa8J3HMqCVxkBvrN08fT53rUn09kpzF
	 XmdD7+CEd0fIPBfbRr/ginmivatY7jwt3tE+Bzeja8Tq9ev1Da+GneccGrp10/T4xJ
	 rXrvZG4qxLoFwakn4Nss0J83/Q2irSO/kXLlXRJdu0ATi3bvywQ9tiJS2hWUtXNhER
	 vCHTPF79evvK3/4PiRFM0eqZg2A8XmhMx0SOuVpsxaFtugkggzvI7yUAMNwX0S0gCg
	 RJRIn55liWyTA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH v2 05/14] sched_ext: Simplify breather mechanism with scx_aborting flag
Date: Mon, 10 Nov 2025 10:56:27 -1000
Message-ID: <20251110205636.405592-6-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110205636.405592-1-tj@kernel.org>
References: <20251110205636.405592-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The breather mechanism was introduced in 62dcbab8b0ef ("sched_ext: Avoid
live-locking bypass mode switching") and e32c260195e6 ("sched_ext: Enable the
ops breather and eject BPF scheduler on softlockup") to prevent live-locks by
injecting delays when CPUs are trapped in dispatch paths.

Currently, it uses scx_breather_depth (atomic_t) and scx_in_softlockup
(unsigned long) with separate increment/decrement and cleanup operations. The
breather is only activated when aborting, so tie it directly to the exit
mechanism. Replace both variables with scx_aborting flag set when exit is
claimed and cleared after bypass is enabled. Introduce scx_claim_exit() to
consolidate exit_kind claiming and breather enablement. This eliminates
scx_clear_softlockup() and simplifies scx_softlockup() and scx_bypass().

The breather mechanism will be replaced by a different abort mechanism in a
future patch. This simplification prepares for that change.

Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 54 +++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4e128b139e7c..2a171338d8f4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -33,9 +33,8 @@ static DEFINE_MUTEX(scx_enable_mutex);
 DEFINE_STATIC_KEY_FALSE(__scx_enabled);
 DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_enable_state_var = ATOMIC_INIT(SCX_DISABLED);
-static unsigned long scx_in_softlockup;
-static atomic_t scx_breather_depth = ATOMIC_INIT(0);
 static int scx_bypass_depth;
+static bool scx_aborting;
 static bool scx_init_task_enabled;
 static bool scx_switching_all;
 DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
@@ -1831,7 +1830,7 @@ static void scx_breather(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
-	if (likely(!atomic_read(&scx_breather_depth)))
+	if (likely(!READ_ONCE(scx_aborting)))
 		return;
 
 	raw_spin_rq_unlock(rq);
@@ -1840,9 +1839,9 @@ static void scx_breather(struct rq *rq)
 
 	do {
 		int cnt = 1024;
-		while (atomic_read(&scx_breather_depth) && --cnt)
+		while (READ_ONCE(scx_aborting) && --cnt)
 			cpu_relax();
-	} while (atomic_read(&scx_breather_depth) &&
+	} while (READ_ONCE(scx_aborting) &&
 		 time_before64(ktime_get_ns(), until));
 
 	raw_spin_rq_lock(rq);
@@ -3737,30 +3736,14 @@ void scx_softlockup(u32 dur_s)
 		goto out_unlock;
 	}
 
-	/* allow only one instance, cleared at the end of scx_bypass() */
-	if (test_and_set_bit(0, &scx_in_softlockup))
-		goto out_unlock;
-
 	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU%d stuck for %us, disabling \"%s\"\n",
 			smp_processor_id(), dur_s, scx_root->ops.name);
 
-	/*
-	 * Some CPUs may be trapped in the dispatch paths. Enable breather
-	 * immediately; otherwise, we might even be able to get to scx_bypass().
-	 */
-	atomic_inc(&scx_breather_depth);
-
 	scx_error(sch, "soft lockup - CPU#%d stuck for %us", smp_processor_id(), dur_s);
 out_unlock:
 	rcu_read_unlock();
 }
 
-static void scx_clear_softlockup(void)
-{
-	if (test_and_clear_bit(0, &scx_in_softlockup))
-		atomic_dec(&scx_breather_depth);
-}
-
 /**
  * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
  * @bypass: true for bypass, false for unbypass
@@ -3823,8 +3806,6 @@ static void scx_bypass(bool bypass)
 				      ktime_get_ns() - bypass_timestamp);
 	}
 
-	atomic_inc(&scx_breather_depth);
-
 	/*
 	 * No task property is changing. We just need to make sure all currently
 	 * queued tasks are re-queued according to the new scx_rq_bypassing()
@@ -3880,10 +3861,8 @@ static void scx_bypass(bool bypass)
 		raw_spin_rq_unlock(rq);
 	}
 
-	atomic_dec(&scx_breather_depth);
 unlock:
 	raw_spin_unlock_irqrestore(&bypass_lock, flags);
-	scx_clear_softlockup();
 }
 
 static void free_exit_info(struct scx_exit_info *ei)
@@ -3978,6 +3957,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 
 	/* guarantee forward progress by bypassing scx_ops */
 	scx_bypass(true);
+	WRITE_ONCE(scx_aborting, false);
 
 	switch (scx_set_enable_state(SCX_DISABLING)) {
 	case SCX_DISABLING:
@@ -4100,9 +4080,24 @@ static void scx_disable_workfn(struct kthread_work *work)
 	scx_bypass(false);
 }
 
-static void scx_disable(enum scx_exit_kind kind)
+static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 {
 	int none = SCX_EXIT_NONE;
+
+	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
+		return false;
+
+	/*
+	 * Some CPUs may be trapped in the dispatch paths. Enable breather
+	 * immediately; otherwise, we might not even be able to get to
+	 * scx_bypass().
+	 */
+	WRITE_ONCE(scx_aborting, true);
+	return true;
+}
+
+static void scx_disable(enum scx_exit_kind kind)
+{
 	struct scx_sched *sch;
 
 	if (WARN_ON_ONCE(kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE))
@@ -4111,7 +4106,7 @@ static void scx_disable(enum scx_exit_kind kind)
 	rcu_read_lock();
 	sch = rcu_dereference(scx_root);
 	if (sch) {
-		atomic_try_cmpxchg(&sch->exit_kind, &none, kind);
+		scx_claim_exit(sch, kind);
 		kthread_queue_work(sch->helper, &sch->disable_work);
 	}
 	rcu_read_unlock();
@@ -4432,9 +4427,8 @@ static void scx_vexit(struct scx_sched *sch,
 		      const char *fmt, va_list args)
 {
 	struct scx_exit_info *ei = sch->exit_info;
-	int none = SCX_EXIT_NONE;
 
-	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
+	if (!scx_claim_exit(sch, kind))
 		return;
 
 	ei->exit_code = exit_code;
@@ -4650,6 +4644,8 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	WARN_ON_ONCE(scx_set_enable_state(SCX_ENABLING) != SCX_DISABLED);
 	WARN_ON_ONCE(scx_root);
+	if (WARN_ON_ONCE(READ_ONCE(scx_aborting)))
+		WRITE_ONCE(scx_aborting, false);
 
 	atomic_long_set(&scx_nr_rejected, 0);
 
-- 
2.51.2

