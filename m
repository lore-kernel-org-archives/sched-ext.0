Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8ED3E5593;
	Wed,  4 Mar 2026 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661705; cv=none; b=FTFkVWmVsoD0TKXW16+YL5JUoZ9AD61XwYK2s8qbZqELZZ6H62MESMPFFrzIH+rLojJhNP6w186csdZuMKHg6uHxfAlg0E9nqstTlEb9WAWinOp3xUzIgnn4B8h1Qu6WbPDJsSG9tGKOLwOaXFFUlHfePt0MGQx5KEyzCRclSOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661705; c=relaxed/simple;
	bh=lrwlxOwvEWhD7eaTFUU7my9DPIJ9sugq/eYCxldVPOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blP9YnvI8Ngq2pIAnMcZjmx/To7AOE117j9sjYgpAkVVsJ1tLr99ROZqEZunYHHEE7XQdv3R9GjKlaRXabFHLvLJKSAiS1u6DC6370k24/y/Un/ABR6zZKlTWVlYvb7VzHjebHVxbqJaaY9YYYxjJKiKihEgktNOfupwGlq93WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqboT+f3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqboT+f3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4A6C4CEF7;
	Wed,  4 Mar 2026 22:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661704;
	bh=lrwlxOwvEWhD7eaTFUU7my9DPIJ9sugq/eYCxldVPOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TqboT+f3bDPqWTbDzP/YZIVLbuVwrJZz7C2bNmbX0vyiIZINTlemkDddOyLWyaOsk
	 RuxS6V73UlXy3qgOG/dH75mUXaVC3u7d2pWoWZ9uxk6grmMWF1w/4v8lsGH1bQE7kw
	 oB5gzpLJ1xl0ldXBufNIM/+q8a1ssPMCaCBWRnx9R6y452zD/oMesxpgRK0wYFTt1i
	 TOg4zV0MF5isFX6/j2ADtJHeqet1Kl5L4Kf10AdXAHlObKw1cD01LwqxeC75PUhECK
	 eypnrQyhfSCF9DJs+BGtYE0AA/kgGLD1blqpTtxe+u+SYPU0SrEDuPVotoH36C6LO8
	 dotAvQ2LSqUTg==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 23/34] sched_ext: Implement hierarchical bypass mode
Date: Wed,  4 Mar 2026 12:01:08 -1000
Message-ID: <20260304220119.4095551-24-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
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
 kernel/sched/ext.c          | 97 ++++++++++++++++++++++++++++++++++---
 kernel/sched/ext_internal.h | 11 +++++
 2 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6b07d97b0af6..2a19df67a66c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -357,6 +357,27 @@ static struct scx_dispatch_q *bypass_dsq(struct scx_sched *sch, s32 cpu)
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
@@ -1650,7 +1671,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	dsq = find_global_dsq(sch, p);
 	goto enqueue;
 bypass:
-	dsq = bypass_dsq(sch, task_cpu(p));
+	dsq = bypass_enq_target_dsq(sch, task_cpu(p));
 	goto enqueue;
 
 enqueue:
@@ -2420,8 +2441,33 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	if (consume_global_dsq(sch, rq))
 		return true;
 
-	if (bypass_dsp_enabled(sch) && scx_bypassing(sch, cpu))
-		return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
+	if (bypass_dsp_enabled(sch)) {
+		/* if @sch is bypassing, only the bypass DSQs are active */
+		if (scx_bypassing(sch, cpu))
+			return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
+
+#ifdef CONFIG_EXT_SUB_SCHED
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
+		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+
+		if (!(pcpu->bypass_host_seq++ % SCX_BYPASS_HOST_NTH) &&
+		    consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu))) {
+			__scx_add_event(sch, SCX_EV_SUB_BYPASS_DISPATCH, 1);
+			return true;
+		}
+#endif	/* CONFIG_EXT_SUB_SCHED */
+	}
 
 	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
 		return false;
@@ -2467,6 +2513,14 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
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
 
@@ -4085,6 +4139,7 @@ static ssize_t scx_attr_events_show(struct kobject *kobj,
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DISPATCH);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_ACTIVATE);
 	at += scx_attr_event_show(buf, at, &events, SCX_EV_INSERT_NOT_OWNED);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_SUB_BYPASS_DISPATCH);
 	return at;
 }
 SCX_ATTR(events);
@@ -4460,6 +4515,7 @@ static bool dec_bypass_depth(struct scx_sched *sch)
 
 static void enable_bypass_dsp(struct scx_sched *sch)
 {
+	struct scx_sched *host = scx_parent(sch) ?: sch;
 	u32 intv_us = READ_ONCE(scx_bypass_lb_intv_us);
 	s32 ret;
 
@@ -4471,14 +4527,35 @@ static void enable_bypass_dsp(struct scx_sched *sch)
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
 
@@ -4492,6 +4569,11 @@ static void disable_bypass_dsp(struct scx_sched *sch)
 
 	ret = atomic_dec_return(&sch->bypass_dsp_enable_depth);
 	WARN_ON_ONCE(ret < 0);
+
+	if (scx_parent(sch)) {
+		ret = atomic_dec_return(&scx_parent(sch)->bypass_dsp_enable_depth);
+		WARN_ON_ONCE(ret < 0);
+	}
 }
 
 /**
@@ -5266,6 +5348,7 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 	scx_dump_event(s, &events, SCX_EV_BYPASS_DISPATCH);
 	scx_dump_event(s, &events, SCX_EV_BYPASS_ACTIVATE);
 	scx_dump_event(s, &events, SCX_EV_INSERT_NOT_OWNED);
+	scx_dump_event(s, &events, SCX_EV_SUB_BYPASS_DISPATCH);
 
 	if (seq_buf_has_overflowed(&s) && dump_len >= sizeof(trunc_marker))
 		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index fd2671340019..79d44d396152 100644
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
2.53.0

