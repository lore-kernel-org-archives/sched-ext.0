Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E0466B57;
	Wed, 21 Jan 2026 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037126; cv=none; b=s5Z+QDjK8oJkFYjS3Qtqk+rO48B2i2943ui5bsrhyW7mZYxf68mZS6VQ7zdw5p7eMke7QozZPiQHlwi/4Z/XytT9PJ/nbQs8odLmQf2lVrrhNJ4ul/STA+CkFu+BmyrbPq7ey0dtvX8x+E34TcpmlXcccGv+nsQNu7ZHuBstgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037126; c=relaxed/simple;
	bh=LB0YHyVQxcT6Glaoi1D7Z9z4rKsVQEG2namwdAdlj1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4/Jw+PDhEqKX7m3Zw6XeqMkLhKgzKmNwWQECfSFf7bUs5WB+KClRQifJnxlMsYH3KB98yjTWWFpYACQ1c6+vfhnmoWi+UZaFLXxHUtuoY6Bza8U3tefhlH/xtyEByXqXp2L98HKZkmdLHY3gmsdxiwvmJGKe2WVlX2g5nLDwdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSfzJX0b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSfzJX0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969EEC19421;
	Wed, 21 Jan 2026 23:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037125;
	bh=LB0YHyVQxcT6Glaoi1D7Z9z4rKsVQEG2namwdAdlj1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SSfzJX0b5NX2sxfWsDGM49cKVgisvG017/iCCOvuCbPpFBAlzi3BdsFI+OBzv676L
	 qq5jTKSXpp4efCw0jc6cBfMSjYHY8beN+SKuUrDx4JHCS8MoNilcMP1kHsEQyQwtyG
	 o0YXlU7tBO/uFx/GwbKU+6eKFp/glA37V5B4hunCjgXQcPrVyIhgtxx2ep0hY+9BgZ
	 zVDmOd66wPC6qTVbf3rc5S+YKapXUxn4qMz1Kk0yfoSaT8y7VPF0jp108FEVJoguTm
	 LGnC/Y1XGhBOjhSWGIOLcFQBMRw4amgM650pE1/UnGBusXtIgPI+44abp1XnamH6FI
	 vcedF9jPDM40g==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 23/34] sched_ext: Implement hierarchical bypass mode
Date: Wed, 21 Jan 2026 13:11:29 -1000
Message-ID: <20260121231140.832332-24-tj@kernel.org>
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

When a sub-scheduler enters bypass mode, its tasks must be scheduled by an
ancestor to guarantee forward progress. Tasks from bypassing descendants are
queued in the bypass DSQs of the nearest non-bypassing ancestor, or the root
scheduler if all ancestors are bypassing. This requires coordination between
bypassing schedulers and their hosts.

Add bypass_enq_target_dsq() to find the correct bypass DSQ by walking up the
hierarchy until reaching a non-bypassing ancestor. When a sub-scheduler starts
bypassing, all its runnable tasks are re-enqueued after scx_bypassing() is set,
ensuring proper migration to ancestor bypass DSQs.

Update scx_dispatch_sched() to handle hosting bypassed descendants. When a
scheduler is not bypassing but has bypassing descendants, it must schedule both
its own tasks and bypassed descendant tasks. A simple policy is implemented
where every Nth dispatch attempt (SCX_BYPASS_HOST_NTH=2) consumes from the
bypass DSQ. A fallback consumption is also added at the end of dispatch to
ensure bypassed tasks make progress even when normal scheduling is idle.

Update enable_bypass_dsp() and disable_bypass_dsp() to increment
bypass_dsp_enable_depth on both the bypassing scheduler and its parent host,
ensuring both can detect that bypass dispatch is active through
bypass_dsp_enabled().

Add SCX_EV_SUB_BYPASS_DISPATCH event counter to track scheduling of bypassed
descendant tasks.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 96 ++++++++++++++++++++++++++++++++++---
 kernel/sched/ext_internal.h | 11 +++++
 2 files changed, 100 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 084e346b0f0e..6087083e8b70 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -356,6 +356,27 @@ static struct scx_dispatch_q *bypass_dsq(struct scx_sched *sch, s32 cpu)
 	return &per_cpu_ptr(sch->pcpu, cpu)->bypass_dsq;
 }
 
+static struct scx_dispatch_q *bypass_enq_target_dsq(struct scx_sched *sch, s32 cpu)
+{
+#ifdef CONFIG_EXT_SUB_SCHED
+	/*
+	 * If @sch is a sub-sched which is bypassing, its tasks should go into
+	 * the bypass DSQs of the nearest ancestor which is not bypassing. The
+	 * not-bypassing ancestor is responsible for scheduling all tasks from
+	 * bypassing sub-trees. If all ancestors including root are bypassing,
+	 * @p should go to the root's bypass DSQs.
+	 *
+	 * Whenever a sched starts bypassing, all runnable tasks in its subtree
+	 * are re-enqueued after scx_bypassing() is turned on, guaranteeing that
+	 * all tasks are transferred to the right DSQs.
+	 */
+	while (scx_parent(sch) && scx_bypassing(sch, cpu))
+		sch = scx_parent(sch);
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
+	return bypass_dsq(sch, cpu);
+}
+
 /**
  * bypass_dsp_enabled - Check if bypass dispatch path is enabled
  * @sch: scheduler to check
@@ -1585,7 +1606,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	dsq = find_global_dsq(sch, p);
 	goto enqueue;
 bypass:
-	dsq = bypass_dsq(sch, task_cpu(p));
+	dsq = bypass_enq_target_dsq(sch, task_cpu(p));
 	goto enqueue;
 
 enqueue:
@@ -2326,8 +2347,31 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	if (consume_global_dsq(sch, rq))
 		return true;
 
-	if (bypass_dsp_enabled(sch) && scx_bypassing(sch, cpu))
-		return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
+	if (bypass_dsp_enabled(sch)) {
+		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+
+		/* if @sch is bypassing, only the bypass DSQs are active */
+		if (scx_bypassing(sch, cpu))
+			return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
+
+		/*
+		 * If @sch isn't bypassing but its children are, @sch is
+		 * responsible for making forward progress for both its own
+		 * tasks that aren't bypassing and the bypassing descendants'
+		 * tasks. The following implements a simple built-in behavior -
+		 * let each CPU try to run the bypass DSQ every Nth time.
+		 *
+		 * Later, if necessary, we can add an ops flag to suppress the
+		 * auto-consumption and a kfunc to consume the bypass DSQ and,
+		 * so that the BPF scheduler can fully control scheduling of
+		 * bypassed tasks.
+		 */
+		if (!(pcpu->bypass_host_seq++ % SCX_BYPASS_HOST_NTH) &&
+		    consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu))) {
+			__scx_add_event(sch, SCX_EV_SUB_BYPASS_DISPATCH, 1);
+			return true;
+		}
+	}
 
 	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
 		return false;
@@ -2373,6 +2417,14 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 		}
 	} while (dspc->nr_tasks);
 
+	/*
+	 * Prevent the CPU from going idle while bypassed descendants have tasks
+	 * queued. Without this fallback, bypassed tasks could stall if the host
+	 * scheduler's ops.dispatch() doesn't yield any tasks.
+	 */
+	if (bypass_dsp_enabled(sch))
+		return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
+
 	return false;
 }
 
@@ -3892,6 +3944,7 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DISPATCH);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_ACTIVATE);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_INSERT_NOT_OWNED);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_SUB_BYPASS_DISPATCH);
 	return at;
 }
 SCX_ATTR(events);
@@ -4252,6 +4305,7 @@ static bool dec_bypass_depth(struct scx_sched *sch)
 {
 	lockdep_assert_held(&scx_bypass_lock);
 
+
 	WARN_ON_ONCE(sch->bypass_depth < 1);
 	WRITE_ONCE(sch->bypass_depth, sch->bypass_depth - 1);
 	if (sch->bypass_depth != 0)
@@ -4265,6 +4319,7 @@ static bool dec_bypass_depth(struct scx_sched *sch)
 
 static void enable_bypass_dsp(struct scx_sched *sch)
 {
+	struct scx_sched *host = scx_parent(sch) ?: sch;
 	u32 intv_us = READ_ONCE(scx_bypass_lb_intv_us);
 	s32 ret;
 
@@ -4276,14 +4331,35 @@ static void enable_bypass_dsp(struct scx_sched *sch)
 		return;
 
 	/*
-	 * The LB timer will stop running if bypass_arm_depth is 0. Increment
-	 * before starting the LB timer.
+	 * When a sub-sched bypasses, its tasks are queued on the bypass DSQs of
+	 * the nearest non-bypassing ancestor or root. As enable_bypass_dsp() is
+	 * called iff @sch is not already bypassed due to an ancestor bypassing,
+	 * we can assume that the parent is not bypassing and thus will be the
+	 * host of the bypass DSQs.
+	 *
+	 * While the situation may change in the future, the following
+	 * guarantees that the nearest non-bypassing ancestor or root has bypass
+	 * dispatch enabled while a descendant is bypassing, which is all that's
+	 * required.
+	 *
+	 * bypass_dsp_enabled() test is used to detemrine whether to enter the
+	 * bypass dispatch handling path from both bypassing and hosting scheds.
+	 * Bump enable depth on both @sch and bypass dispatch host.
 	 */
 	ret = atomic_inc_return(&sch->bypass_dsp_enable_depth);
 	WARN_ON_ONCE(ret <= 0);
 
-	if (intv_us && !timer_pending(&sch->bypass_lb_timer))
-		mod_timer(&sch->bypass_lb_timer,
+	if (host != sch) {
+		ret = atomic_inc_return(&host->bypass_dsp_enable_depth);
+		WARN_ON_ONCE(ret <= 0);
+	}
+
+	/*
+	 * The LB timer will stop running if bypass dispatch is disabled. Start
+	 * after enabling bypass dispatch.
+	 */
+	if (intv_us && !timer_pending(&host->bypass_lb_timer))
+		mod_timer(&host->bypass_lb_timer,
 			  jiffies + usecs_to_jiffies(intv_us));
 }
 
@@ -4297,6 +4373,11 @@ static void disable_bypass_dsp(struct scx_sched *sch)
 
 	ret = atomic_dec_return(&sch->bypass_dsp_enable_depth);
 	WARN_ON_ONCE(ret < 0);
+
+	if (scx_parent(sch)) {
+		ret = atomic_dec_return(&scx_parent(sch)->bypass_dsp_enable_depth);
+		WARN_ON_ONCE(ret < 0);
+	}
 }
 
 /**
@@ -5061,6 +5142,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DISPATCH);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_ACTIVATE);
 	scx_dump_event(s, &events, SCX_EV_INSERT_NOT_OWNED);
+	scx_dump_event(s, &events, SCX_EV_SUB_BYPASS_DISPATCH);
 
 	if (seq_buf_has_overflowed(&s) && dump_len >= sizeof(trunc_marker))
 		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 26b7ab28de44..db2065ec94ee 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -24,6 +24,8 @@ enum scx_consts {
 	 */
 	SCX_TASK_ITER_BATCH		= 32,
 
+	SCX_BYPASS_HOST_NTH		= 2,
+
 	SCX_BYPASS_LB_DFL_INTV_US	= 500 * USEC_PER_MSEC,
 	SCX_BYPASS_LB_DONOR_PCT		= 125,
 	SCX_BYPASS_LB_MIN_DELTA_DIV	= 4,
@@ -923,6 +925,12 @@ struct scx_event_stats {
 	 * scheduler.
 	 */
 	s64		SCX_EV_INSERT_NOT_OWNED;
+
+	/*
+	 * The number of times tasks from bypassing descendants are scheduled
+	 * from sub_bypass_dsq's.
+	 */
+	s64		SCX_EV_SUB_BYPASS_DISPATCH;
 };
 
 enum scx_sched_pcpu_flags {
@@ -940,6 +948,9 @@ struct scx_sched_pcpu {
 	struct scx_event_stats	event_stats;
 
 	struct scx_dispatch_q	bypass_dsq;
+#ifdef CONFIG_EXT_SUB_SCHED
+	u32			bypass_host_seq;
+#endif
 };
 
 struct scx_sched {
-- 
2.52.0

