Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC50535AC32;
	Mon,  6 Jul 2026 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302061; cv=none; b=WWRctOoeTSPhATe3jp8ZXZxuVSvrrwF1G3Ocz0uLVpo+wBEw5y3dzuQp0UD1VOCAanzw0lYp7qUiqbdA52gTAjvzIZDnxp/Ow5TfOj5cLZdbngHpzkkIEIIPiomrWgiDAdLAaZxM64yf03jebwx1ePRysePEWk14uKLLk0QvGIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302061; c=relaxed/simple;
	bh=BoRsHTZREwmo8rcBqggdqoqQZZQqfp4YFKxD4uf48rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTlo/UxG07kAw/pwniIEeELYdSv88anNoxh2PNBsXvpo7LB/cMTtdTZ4lbBiajM7rBW5J6mhb2GFNWwN0YqadTtqyGHB89bs5OB4QKrc9hvdmoAQ1YulDt9gVHbHftqSRStrPLnfiqpD7ly37rLuqLz7MyIZFUfgzWfDNmadfDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZT+44XFS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZT+44XFS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624C61F00A3A;
	Mon,  6 Jul 2026 01:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302060;
	bh=+yzY8hY1XhLRiifyUAjnY9BqCotpFI8yffUlj/27IAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZT+44XFSKgc2FnuKgWD20XxdaPRmjQGK6qW/YdHRL1IVpszR3U1hDpVv1wH8zAyU4
	 2nVefYQSGV/FnTBlwd+mhAfiuhqn9bO69myKt8ywjsHXApW1fKSjTZ210SykTy70xy
	 uQAC6sHeFc73DfO0Hur2N2dycdkDxn5FcXySFzgWBmvswaD6+LOEr80zSdlbklL2qH
	 zZwS7G4mz6xVHqXKCmtkmTsKe8LM4ItSi3dWqAd0zuOUxCIZx/o6JH8V9pPxW3AIrl
	 sdn7fzcKp3Vgd3+V2kAUAnADCLtJkadfweZOCXeewXC31gAS6jitbRgnAxo/3pQQsl
	 uiQ+37SiIk6jA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 01/36] sched_ext: Add SCX_CALL_CID_OP_TASK() for cid-form op dispatch
Date: Sun,  5 Jul 2026 15:40:23 -1000
Message-ID: <20260706014058.439853-2-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706014058.439853-1-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cid-form ops overlay their cpu-form siblings at the same struct slot.
Ops whose signature matches the sibling are invoked through the cpu-form
call sites unchanged, but set_cmask() takes an arena cmask address rather
than a cpumask, so scx_call_op_set_cpumask() calls ops_cid.set_cmask()
directly and hand-rolled the kf_tasks[] and locked_rq bracket that
SCX_CALL_OP_TASK() provides. The hand-rolled bracket reset locked_rq to
NULL on exit instead of restoring the saved value, so a nested call would
clobber the outer op's locked-rq tracking.

Parameterize the dispatch macros by the ops-table member and add
SCX_CALL_CID_OP_TASK(), which routes through sch->ops_cid. Convert
scx_call_op_set_cpumask() to it and drop the hand-rolled bracket. The only
behavioral change is that locked_rq is now saved and restored like every
other op call site.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 14 +++-----------
 kernel/sched/ext/internal.h | 23 ++++++++++++++++++++---
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1a0ec985da77..b1bd506fd6ec 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -410,11 +410,6 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
 					   struct task_struct *task,
 					   const struct cpumask *cpumask)
 {
-	WARN_ON_ONCE(current->scx.kf_tasks[0]);
-	current->scx.kf_tasks[0] = task;
-	if (rq)
-		update_locked_rq(rq);
-
 	if (scx_is_cid_type()) {
 		struct scx_cmask *kern_va = *this_cpu_ptr(sch->set_cmask_scratch);
 		/*
@@ -423,14 +418,11 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
 		 * the sole user of the scratch area.
 		 */
 		scx_cpumask_to_cmask(cpumask, kern_va);
-		sch->ops_cid.set_cmask(task, scx_kaddr_to_arena(sch, kern_va));
+		SCX_CALL_CID_OP_TASK(sch, set_cmask, rq, task,
+				     scx_kaddr_to_arena(sch, kern_va));
 	} else {
-		sch->ops.set_cpumask(task, cpumask);
+		SCX_CALL_OP_TASK(sch, set_cpumask, rq, task, cpumask);
 	}
-
-	if (rq)
-		update_locked_rq(NULL);
-	current->scx.kf_tasks[0] = NULL;
 }
 
 enum scx_dsq_iter_flags {
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index f9fe7c6ebc4b..5ca44ad88786 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1751,8 +1751,11 @@ static inline void update_locked_rq(struct rq *rq)
 /*
  * SCX ops can recurse via scx_bpf_sub_dispatch() - the inner call must not
  * clobber the outer's scx_locked_rq_state. Save it on entry, restore on exit.
+ *
+ * @ops is the ops table to dispatch through: ops for the cpu form, ops_cid
+ * for the cid form.
  */
-#define SCX_CALL_OP(sch, op, locked_rq, args...)				\
+#define __SCX_CALL_OP(sch, ops, op, locked_rq, args...)				\
 do {										\
 	struct rq *__prev_locked_rq;						\
 										\
@@ -1765,6 +1768,9 @@ do {										\
 		update_locked_rq(__prev_locked_rq);				\
 } while (0)
 
+#define SCX_CALL_OP(sch, op, locked_rq, args...)				\
+	__SCX_CALL_OP(sch, ops, op, locked_rq, ##args)
+
 #define SCX_CALL_OP_RET(sch, op, locked_rq, args...)				\
 ({										\
 	struct rq *__prev_locked_rq;						\
@@ -1796,14 +1802,25 @@ do {										\
  * WARN_ON_ONCE() in each macro catches a re-entry of any of the three variants
  * while a previous one is still in progress.
  */
-#define SCX_CALL_OP_TASK(sch, op, locked_rq, task, args...)			\
+#define __SCX_CALL_OP_TASK(sch, ops, op, locked_rq, task, args...)		\
 do {										\
 	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
 	current->scx.kf_tasks[0] = task;					\
-	SCX_CALL_OP((sch), op, locked_rq, task, ##args);			\
+	__SCX_CALL_OP((sch), ops, op, locked_rq, task, ##args);			\
 	current->scx.kf_tasks[0] = NULL;					\
 } while (0)
 
+#define SCX_CALL_OP_TASK(sch, op, locked_rq, task, args...)			\
+	__SCX_CALL_OP_TASK(sch, ops, op, locked_rq, task, ##args)
+
+/*
+ * Dispatch a task op through the cid-form ops_cid table. Only set_cmask() needs
+ * this: it takes an arena cmask address instead of a cpumask, so it cannot be
+ * invoked via its cpu-form set_cpumask() slot.
+ */
+#define SCX_CALL_CID_OP_TASK(sch, op, locked_rq, task, args...)			\
+	__SCX_CALL_OP_TASK(sch, ops_cid, op, locked_rq, task, ##args)
+
 #define SCX_CALL_OP_TASK_RET(sch, op, locked_rq, task, args...)			\
 ({										\
 	__typeof__((sch)->ops.op(task, ##args)) __ret;				\
-- 
2.54.0

