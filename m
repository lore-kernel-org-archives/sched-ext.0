Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7674657F4;
	Wed, 21 Jan 2026 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037125; cv=none; b=R2BYDKPqDqoYJ6NilMDKyqUzGVCEa+5OabrD9lwzPVQ/MJTWJ72PKl2JuiBz25JLg2u6D8U8PI3gZsEFjjeeYnOhFG3qWkXyUsjoPYWlAaw6h7NfFigs0NlPHxIUC9pgjiojlBniFqk5Bbr3fRqSg9Q0IQ0ROLAZLzdfc8BlEe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037125; c=relaxed/simple;
	bh=a/5hAEdrXu7HyGaHnMWGO7cxt0Omr6MBWit32hjxUB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2BVYqIzYFNFAoeMyHtbUm0IRUD4CbEpSeSKI7uH3bk+Q5R1+ki9ChXyzFWoj0pjJK+R8C+PkCXK/lKX9hxzUbb//fRcG737iGxHrFvVMRRRd98LKKwNEinzhMvnOXbvtBHQE7SG5B87c5ukwoEKevcG5dzd1IoMMomKtufhAGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEw1UZMK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEw1UZMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B55CC19425;
	Wed, 21 Jan 2026 23:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037124;
	bh=a/5hAEdrXu7HyGaHnMWGO7cxt0Omr6MBWit32hjxUB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bEw1UZMKCXiJCpv3rUqnBIj+Ac6aZXqvJ9i6/7zRFS1WCpabFaQbkJMutHK7fuYjC
	 BpiOBK1qy1Wwzr+2MYk0WE7Az9u2HvLnXlrU9atu71yXjeg6GY4aSHgUA83ktfYiiD
	 +7ILDSgehCiF+RAABP7n5WZI8J1Xms029cHcl4uIaF5QXfWf3SRAcbLh7DTXcQMIfX
	 R+cllqsdZ1MdJVPAVLw6mcpvEhZiGH18USTn55wkK4qrvb+IFNBTyKLqE9gvp4REMP
	 cgloy/Y7h3RSkV9cRdohg42e1FugvuxxWWGUDQlwgalkrYuG1feCFDhrd/mv8sVoK3
	 M3XiNMgUxHSTA==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 22/34] sched_ext: Separate bypass dispatch enabling from bypass depth tracking
Date: Wed, 21 Jan 2026 13:11:28 -1000
Message-ID: <20260121231140.832332-23-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121231140.832332-1-tj@kernel.org>
References: <20260121231140.832332-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bypass_depth field tracks nesting of bypass operations but is also used
to determine whether the bypass dispatch path should be active. With
hierarchical scheduling, child schedulers may need to activate their parent's
bypass dispatch path without affecting the parent's bypass_depth, requiring
separation of these concerns.

Add bypass_dsp_enable_depth and bypass_dsp_claim to independently control
bypass dispatch path activation. The new enable_bypass_dsp() and
disable_bypass_dsp() functions manage this state with proper claim semantics
to prevent races. The bypass dispatch path now only activates when
bypass_dsp_enabled() returns true, which checks the new enable_depth counter.

The disable operation is carefully ordered after all tasks are moved out of
bypass DSQs to ensure they are drained before the dispatch path is disabled.
During scheduler teardown, disable_bypass_dsp() is called explicitly to ensure
cleanup even if bypass mode was never entered normally.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 74 ++++++++++++++++++++++++++++++++-----
 kernel/sched/ext_internal.h |  5 +++
 2 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d27c6394d452..084e346b0f0e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -356,6 +356,26 @@ static struct scx_dispatch_q *bypass_dsq(struct scx_sched *sch, s32 cpu)
 	return &per_cpu_ptr(sch->pcpu, cpu)->bypass_dsq;
 }
 
+/**
+ * bypass_dsp_enabled - Check if bypass dispatch path is enabled
+ * @sch: scheduler to check
+ *
+ * When a descendant scheduler enters bypass mode, bypassed tasks are scheduled
+ * by the nearest non-bypassing ancestor, or the root scheduler if all ancestors
+ * are bypassing. In the former case, the ancestor is not itself bypassing but
+ * its bypass DSQs will be populated with bypassed tasks from descendants. Thus,
+ * the ancestor's bypass dispatch path must be active even though its own
+ * bypass_depth remains zero.
+ *
+ * This function checks bypass_dsp_enable_depth which is managed separately from
+ * bypass_depth to enable this decoupling. See enable_bypass_dsp() and
+ * disable_bypass_dsp().
+ */
+static bool bypass_dsp_enabled(struct scx_sched *sch)
+{
+	return unlikely(atomic_read(&sch->bypass_dsp_enable_depth));
+}
+
 /*
  * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
  * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
@@ -2306,7 +2326,7 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	if (consume_global_dsq(sch, rq))
 		return true;
 
-	if (scx_bypassing(sch, cpu))
+	if (bypass_dsp_enabled(sch) && scx_bypassing(sch, cpu))
 		return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
 
 	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
@@ -4202,7 +4222,7 @@ static void scx_bypass_lb_timerfn(struct timer_list *timer)
 	int node;
 	u32 intv_us;
 
-	if (!READ_ONCE(sch->bypass_depth))
+	if (!bypass_dsp_enabled(sch))
 		return;
 
 	for_each_node_with_cpus(node)
@@ -4243,6 +4263,42 @@ static bool dec_bypass_depth(struct scx_sched *sch)
 	return true;
 }
 
+static void enable_bypass_dsp(struct scx_sched *sch)
+{
+	u32 intv_us = READ_ONCE(scx_bypass_lb_intv_us);
+	s32 ret;
+
+	/*
+	 * @sch->bypass_depth transitioning from 0 to 1 triggers enabling.
+	 * Shouldn't stagger.
+	 */
+	if (WARN_ON_ONCE(test_and_set_bit(0, &sch->bypass_dsp_claim)))
+		return;
+
+	/*
+	 * The LB timer will stop running if bypass_arm_depth is 0. Increment
+	 * before starting the LB timer.
+	 */
+	ret = atomic_inc_return(&sch->bypass_dsp_enable_depth);
+	WARN_ON_ONCE(ret <= 0);
+
+	if (intv_us && !timer_pending(&sch->bypass_lb_timer))
+		mod_timer(&sch->bypass_lb_timer,
+			  jiffies + usecs_to_jiffies(intv_us));
+}
+
+/* may be called without holding scx_bypass_lock */
+static void disable_bypass_dsp(struct scx_sched *sch)
+{
+	s32 ret;
+
+	if (!test_and_clear_bit(0, &sch->bypass_dsp_claim))
+		return;
+
+	ret = atomic_dec_return(&sch->bypass_dsp_enable_depth);
+	WARN_ON_ONCE(ret < 0);
+}
+
 /**
  * scx_bypass - [Un]bypass scx_ops and guarantee forward progress
  * @sch: sched to bypass
@@ -4284,17 +4340,10 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 	raw_spin_lock_irqsave(&scx_bypass_lock, flags);
 
 	if (bypass) {
-		u32 intv_us;
-
 		if (!inc_bypass_depth(sch))
 			goto unlock;
 
-		intv_us = READ_ONCE(scx_bypass_lb_intv_us);
-		if (intv_us && !timer_pending(&sch->bypass_lb_timer)) {
-			sch->bypass_lb_timer.expires =
-				jiffies + usecs_to_jiffies(intv_us);
-			add_timer_global(&sch->bypass_lb_timer);
-		}
+		enable_bypass_dsp(sch);
 	} else {
 		if (!dec_bypass_depth(sch))
 			goto unlock;
@@ -4376,6 +4425,9 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 		raw_spin_rq_unlock(rq);
 	}
 
+	/* disarming must come after moving all tasks out of the bypass DSQs */
+	if (!bypass)
+		disable_bypass_dsp(sch);
 unlock:
 	raw_spin_unlock_irqrestore(&scx_bypass_lock, flags);
 }
@@ -4477,6 +4529,8 @@ static void scx_sub_disable(struct scx_sched *sch)
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
+	disable_bypass_dsp(sch);
+
 	raw_spin_lock_irq(&scx_sched_lock);
 	list_del_init(&sch->sibling);
 	list_del_rcu(&sch->all);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b7f63a555193..26b7ab28de44 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -961,6 +961,11 @@ struct scx_sched {
 	u64			slice_dfl;
 	u64			bypass_timestamp;
 	s32			bypass_depth;
+
+	/* bypass dispatch path enable state, see bypass_dsp_enabled() */
+	unsigned long		bypass_dsp_claim;
+	atomic_t		bypass_dsp_enable_depth;
+
 	bool			aborting;
 	s32			level;
 
-- 
2.52.0

