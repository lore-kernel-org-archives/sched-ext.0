Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60A3A5422;
	Wed,  1 Jul 2026 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938083; cv=none; b=hbCo5LEYjXhjxh9P/8IylWTxQLwbAu8mIofvc0GAaQEpiOzZ95QFuP6MgzhTKK6Ti7UoQmdxBJDOaJRDz6VfYxD9GNtaNI3DQtgEudKlJvaTGQQXKuFIr1PlFsItgYGpQLuM9luGVoXosbCo4zLt40yVdUZkr7r9BGh7UXQH6d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938083; c=relaxed/simple;
	bh=XkI1ZI+N9W7dj/kRO5e1UnP7s1zLEpbA8LbsuadkgYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8xFIjBNIDIOf+sNljigLayBp5YV4PW+mf5IpoVIWDSPHWoDRAc0p35dK+idwZWBeiJswzSanDrR5665PsOMy0z7vKK6AU0TJbpUCJ+6KQF01Ze8bkmqwl2jFp4r/KqFe+e5aCqmO2CDLE7hxY/V6FU6kp9NU21Dhft3PC81YyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W92ivA/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W92ivA/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144021F00A3D;
	Wed,  1 Jul 2026 20:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782938082;
	bh=Zyu7LbwH/lv/F4Z7wUYyj58xmqf48xu3MLmbNNmzYL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W92ivA/AGPRIcDgVhlNzcgKJ/OxsYBggy5Fa1KS1GHmYa392L8z8gRzsoeqUhaKId
	 mjoXv5ZdqhqGqqzlSlDUh81IGNquy9oFDneZG/MAz50M3vpsrDxAp0utpOI3Rro7rC
	 IVDgf/7bSARj+khFg9n7mWQDH2SJsdKRNPiqMGtwGJCgHZLY+XnW8YfMwcJUiR/BQp
	 8o2NgkgwKcN/LlLm8Bo6aIkWkJiu2cqOnxpC31NuFfoPGH5AY8qH+J3MC1C1ovk4lM
	 64ijAj13AKmwlMjefDFD5DCG5+vu+41iFajWPTX84nM9O9DWSCgfZbL1R0Ww0mhYKE
	 UWcEE9AZfwCFA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 sched_ext/for-7.3 3/4] sched_ext: Inline small ext.c helpers shared across the sub.c split
Date: Wed,  1 Jul 2026 10:34:37 -1000
Message-ID: <20260701203438.2837392-4-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701203438.2837392-1-tj@kernel.org>
References: <20260701203438.2837392-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following trivial helpers in ext.c are called from both ext.c and the
sub-scheduler code. Define them as static inline in internal.h.

- scx_bypass_dsq()
- scx_bypass_dsp_enabled()
- scx_ops_sanitize_err()
- scx_schedule_reenq_local()

No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c      | 57 -------------------------------------
 kernel/sched/ext/internal.h | 57 +++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index bdbc66466962..d1ef79c1038d 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -368,11 +368,6 @@ static const struct sched_class *scx_setscheduler_class(struct task_struct *p)
 	return __setscheduler_class(p->policy, p->prio);
 }
 
-static struct scx_dispatch_q *scx_bypass_dsq(struct scx_sched *sch, s32 cpu)
-{
-	return &per_cpu_ptr(sch->pcpu, cpu)->bypass_dsq;
-}
-
 static struct scx_dispatch_q *bypass_enq_target_dsq(struct scx_sched *sch, s32 cpu)
 {
 #ifdef CONFIG_EXT_SUB_SCHED
@@ -394,26 +389,6 @@ static struct scx_dispatch_q *bypass_enq_target_dsq(struct scx_sched *sch, s32 c
 	return scx_bypass_dsq(sch, cpu);
 }
 
-/**
- * scx_bypass_dsp_enabled - Check if bypass dispatch path is enabled
- * @sch: scheduler to check
- *
- * When a descendant scheduler enters bypass mode, bypassed tasks are scheduled
- * by the nearest non-bypassing ancestor, or the root scheduler if all ancestors
- * are bypassing. In the former case, the ancestor is not itself bypassing but
- * its bypass DSQs will be populated with bypassed tasks from descendants. Thus,
- * the ancestor's bypass dispatch path must be active even though its own
- * bypass_depth remains zero.
- *
- * This function checks bypass_dsp_enable_depth which is managed separately from
- * bypass_depth to enable this decoupling. See enable_bypass_dsp() and
- * scx_disable_bypass_dsp().
- */
-static bool scx_bypass_dsp_enabled(struct scx_sched *sch)
-{
-	return unlikely(atomic_read(&sch->bypass_dsp_enable_depth));
-}
-
 /**
  * rq_is_open - Is the rq available for immediate execution of an SCX task?
  * @rq: rq to test
@@ -1060,28 +1035,6 @@ bool scx_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where)
 	}
 }
 
-/**
- * scx_ops_sanitize_err - Sanitize a -errno value
- * @sch: scx_sched to error out on error
- * @ops_name: operation to blame on failure
- * @err: -errno value to sanitize
- *
- * Verify @err is a valid -errno. If not, trigger scx_error() and return
- * -%EPROTO. This is necessary because returning a rogue -errno up the chain can
- * cause misbehaviors. For an example, a large negative return from
- * ops.init_task() triggers an oops when passed up the call chain because the
- * value fails IS_ERR() test after being encoded with ERR_PTR() and then is
- * handled as a pointer.
- */
-static int scx_ops_sanitize_err(struct scx_sched *sch, const char *ops_name, s32 err)
-{
-	if (err < 0 && err >= -MAX_ERRNO)
-		return err;
-
-	scx_error(sch, "ops.%s() returned an invalid errno %d", ops_name, err);
-	return -EPROTO;
-}
-
 static void deferred_bal_cb_workfn(struct rq *rq)
 {
 	run_deferred(rq);
@@ -1233,16 +1186,6 @@ void schedule_dsq_reenq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 		schedule_deferred(rq);
 }
 
-static void scx_schedule_reenq_local(struct rq *rq, u64 reenq_flags)
-{
-	struct scx_sched *root = rcu_dereference_sched(scx_root);
-
-	if (WARN_ON_ONCE(!root))
-		return;
-
-	schedule_dsq_reenq(root, &rq->scx.local_dsq, reenq_flags, rq);
-}
-
 /**
  * touch_core_sched - Update timestamp used for core-sched task ordering
  * @rq: rq to read clock from, must be locked
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index c4a910d2ca91..c3b97ea4ae79 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1640,6 +1640,63 @@ extern struct scx_sched *scx_enabling_sub_sched;
 #define scx_error(sch, fmt, args...)						\
 	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
 
+static inline struct scx_dispatch_q *scx_bypass_dsq(struct scx_sched *sch, s32 cpu)
+{
+	return &per_cpu_ptr(sch->pcpu, cpu)->bypass_dsq;
+}
+
+/**
+ * scx_bypass_dsp_enabled - Check if bypass dispatch path is enabled
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
+ * scx_disable_bypass_dsp().
+ */
+static inline bool scx_bypass_dsp_enabled(struct scx_sched *sch)
+{
+	return unlikely(atomic_read(&sch->bypass_dsp_enable_depth));
+}
+
+/**
+ * scx_ops_sanitize_err - Sanitize a -errno value
+ * @sch: scx_sched to error out on error
+ * @ops_name: operation to blame on failure
+ * @err: -errno value to sanitize
+ *
+ * Verify @err is a valid -errno. If not, trigger scx_error() and return
+ * -%EPROTO. This is necessary because returning a rogue -errno up the chain can
+ * cause misbehaviors. For an example, a large negative return from
+ * ops.init_task() triggers an oops when passed up the call chain because the
+ * value fails IS_ERR() test after being encoded with ERR_PTR() and then is
+ * handled as a pointer.
+ */
+static inline int scx_ops_sanitize_err(struct scx_sched *sch, const char *ops_name, s32 err)
+{
+	if (err < 0 && err >= -MAX_ERRNO)
+		return err;
+
+	scx_error(sch, "ops.%s() returned an invalid errno %d", ops_name, err);
+	return -EPROTO;
+}
+
+static inline void scx_schedule_reenq_local(struct rq *rq, u64 reenq_flags)
+{
+	struct scx_sched *root = rcu_dereference_sched(scx_root);
+
+	if (WARN_ON_ONCE(!root))
+		return;
+
+	schedule_dsq_reenq(root, &rq->scx.local_dsq, reenq_flags, rq);
+}
+
 /*
  * Return the rq currently locked from an scx callback, or NULL if no rq is
  * locked.
-- 
2.54.0

