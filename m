Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D274A207B;
	Sat, 17 Oct 2026 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792276664; cv=none; b=i/ldyz38BDFxtvEUesvYru6afEQX814XIkjR/RL0cNI90MCTL8Fh+JPxqQyfCC7ya4hFkSHzC9H3HoN5Cn6G6p+Fw7ml1qiNI1lmfomOnHK+GMwzehj0mPW1Up9585aP8JguB95Ic9+MKKTLJyCgWXagvaoSNnimbcWvfib/ejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792276664; c=relaxed/simple;
	bh=aFvsEQiFe+acVRD/OP89N83Pgk7Dhp8uo5/qjL7aCQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bgg1V79Gh5ScnnF3t1qFJdFtG1SkK/bxLMlRhYhz9Z54Xk4bBVOb+AjdYR2EVM6b7eCxHi7aiPv6mGU210H3IR4O8G352GPhnVgXrH5Ra4brh7QkZleF8+GrDemZ9qs96nMb8pzo3UPWBOgoGLCEKuMo66bDdSTF8p7mdDbePGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4/LQ77V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4/LQ77V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8231F000C5;
	Sat, 17 Oct 2026 22:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792276663;
	bh=TW+xjrd+vNz++QRmcV1JuE9QIBZEOYwD32mrxTgZJz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A4/LQ77VAHV+d7yUtWzszW839s6l7OdcZ8dWh+KxeshzrFYstfzMoU3ogHLzAhEOx
	 to1zxgvQGsrM4hW+DTfAhnh7kakiBEqquEVoooeFsrjczk6M3VBLimdqweRj6RHbqD
	 08yL2YpmJK5RCAqKCbE7dKtvlnhG4r1FFxD80rvgx6HGrUV6sXProZwqBa9hJ/Uiu7
	 3hqfinYsuuroIxKtFkjWzxijpzY6rFCyPTTyIVOqY603ySgfY9cwsWhDZNz0bHv3ij
	 Qt99VxXB4MLUkJNyTBz6sHCzfsyr53O1FpbvXjDayYassrCGozJ2S2n/vycYoV4xz/
	 WtcdpBIFcUAsQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/3] sched_ext: scx_qmap: Also re-enqueue stranded tasks with scx_bpf_dsq_reenq_task()
Date: Sat, 17 Oct 2026 12:37:38 -1000
Message-ID: <20261017223738.993262-4-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017223738.993262-1-tj@kernel.org>
References: <20261017223738.993262-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scan_shared_dsq() rescues a task stranded on SHARED_DSQ or HIGHPRI_DSQ by
moving it to the rescue path with scx_bpf_dsq_move(). For a task with an odd
pid, mark it with scx_bpf_dsq_reenq_task() instead, which sends it back
through qmap_enqueue() and its rescue, so that both kfuncs are exercised.

scan_shared_dsq() runs from qmap_dispatch() and from the monitor timer, so
the kfunc can be called both with the dispatch rq locked and with no rq lock
held.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 50 +++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 61143a2d79f8..e8e451be862d 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -651,10 +651,35 @@ static void update_core_sched_head_seq(struct task_struct *p)
 		qa.core_sched_head_seqs[idx] = taskc->core_sched_seq;
 }
 
+/*
+ * Send @p, stranded on the DSQ @it iterates, to the kernel rescue path. To
+ * exercise both kfuncs, move tasks with an even pid there with
+ * scx_bpf_dsq_move() and re-enqueue the others with scx_bpf_dsq_reenq_task(),
+ * which takes them through qmap_enqueue()'s rescue. The choice is per task so
+ * that a marked task isn't moved by another scan before the re-enqueue reaches
+ * it.
+ */
+static __always_inline void rescue_stranded(struct bpf_iter_scx_dsq *it,
+					    struct task_struct *p, task_ctx_t *taskc)
+{
+	s32 c;
+
+	if (p->pid & 1) {
+		scx_bpf_dsq_reenq_task(it, p);
+		return;
+	}
+
+	c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
+	if (c >= 0 && c < scx_bpf_nr_cids()) {
+		__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
+		scx_bpf_dsq_move(it, p, SCX_DSQ_LOCAL_ON | c, SCX_ENQ_RESCUE);
+	}
+}
+
 /*
  * One pass over SHARED_DSQ: rescue stranded tasks and boost highpri ones. A
  * task whose cids were lost while it was queued in the fifos would strand on
- * SHARED_DSQ, which is consumed only on self cids it can't run on - move it to
+ * SHARED_DSQ, which is consumed only on self cids it can't run on - send it to
  * the kernel rescue path. One whose cids were lost after the highpri cull is
  * likewise rescued out of HIGHPRI_DSQ below.
  *
@@ -663,9 +688,9 @@ static void update_core_sched_head_seq(struct task_struct *p)
  * consuming them first. This makes minor difference only when dsp_batch is
  * larger than 1.
  *
- * scx_bpf_dsq_move[_vtime]() are allowed both from ops.dispatch() and
- * non-rq-lock holding BPF programs. As demonstration, this function is called
- * from qmap_dispatch() and monitor_timerfn().
+ * scx_bpf_dsq_move[_vtime]() and scx_bpf_dsq_reenq_task() are allowed both from
+ * ops.dispatch() and non-rq-lock holding BPF programs. As demonstration, this
+ * function is called from qmap_dispatch() and monitor_timerfn().
  */
 static bool scan_shared_dsq(bool from_timer)
 {
@@ -677,19 +702,13 @@ static bool scan_shared_dsq(bool from_timer)
 	bpf_for_each(scx_dsq, p, SHARED_DSQ, 0) {
 		static u64 highpri_seq;
 		task_ctx_t *taskc;
-		s32 c;
 
 		if (!(taskc = lookup_task_ctx(p)))
 			return false;
 
 		/* stranded? rescue - it can't be dispatched here either way */
 		if (!cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask)) {
-			c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
-			if (c >= 0 && c < scx_bpf_nr_cids()) {
-				__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
-				scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | c,
-						 SCX_ENQ_RESCUE);
-			}
+			rescue_stranded(BPF_FOR_EACH_ITER, p, taskc);
 			continue;
 		}
 
@@ -723,19 +742,12 @@ static bool scan_shared_dsq(bool from_timer)
 						      &qa.usable_cids.mask,
 						      this_cid + 1);
 		if (cid >= nr_cids) {
-			s32 c;
-
 			/* self cids lack caps in effect yet, leave it queued */
 			if (cmask_intersects(&taskc->cpus_allowed, &qa.self_cids.mask))
 				continue;
 
 			/* stranded after the cull - rescue it from here */
-			c = cmask_next_set_wrap(&taskc->cpus_allowed, 0);
-			if (c >= 0 && c < nr_cids) {
-				__sync_fetch_and_add(&qa.nr_rescue_dsp, 1);
-				scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p, SCX_DSQ_LOCAL_ON | c,
-						 SCX_ENQ_RESCUE);
-			}
+			rescue_stranded(BPF_FOR_EACH_ITER, p, taskc);
 			continue;
 		}
 
-- 
2.56.0

