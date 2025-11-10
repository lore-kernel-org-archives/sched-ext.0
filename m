Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD62F6171;
	Mon, 10 Nov 2025 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808199; cv=none; b=YU5J9ayKvRkoRd8cDfEKrKXB0XeQfCiIoFaAVaCxTZc7prqJgMoU7Z9VVv9Qhg9GtIGIF+FJtsad66Y8KNmC/VcJHK+kkaIsqBrbSuFyO1rdKUQtFiJqI7eYcRoWECq7VpWq76h3g5KuMHkXa/R6M8Y6ykDyz69r1HZ8bzwn/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808199; c=relaxed/simple;
	bh=4OzVqEguqaDRV/AlGVBbNYGI0N2Uak5xnFrYl2E/Qds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvS6pEoTL6PFjM9rscOvcoi616oc7l2kZ9c+Ps7RWzRoAMVatkcEYbIGBu4qb/BQo792Pw/coyqd0vGN54fDalmsvdRjsLeoERp4j0y8i1rg6+BxwiEsCice5sFHxxE41deQ/Tm5066B3ACH+uNZv2KD/1I2DAjwhB/p7h8ayYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZMFlQdA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZMFlQdA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47388C113D0;
	Mon, 10 Nov 2025 20:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762808199;
	bh=4OzVqEguqaDRV/AlGVBbNYGI0N2Uak5xnFrYl2E/Qds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZMFlQdADl2ZSmMqK2i0UcZRcd4K00z9NGEs+J1Old2DWAYWBLuDqimuofU5/3Vkg
	 M+JU4kvbN8FuFYZc3BRFuMV9xE/PeL2tRm41CQdqVOlrBegrGrbE+CZLnbH1EpOunm
	 dEo4VYQglxxQmvTyU5jGt4AF0rlQH2PH6EzScEck15ORYzcc6dV3CVECkpHTg9H0Ye
	 yMjFDb5rSAxFC3iXO4R+1FEnY7Lxe5EdrkKBBRMGQPUfZlVx6cVX1ZDrPacWvdMLHB
	 i+RY2Q2x3ia4M/cN/ytw7B3q7hKaAcideW4GQuo86NmKNDlH7ReTN6pbYEr+w/9mIH
	 /y99+trD0Ygiw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 02/14] sched_ext: Make slice values tunable and use shorter slice in bypass mode
Date: Mon, 10 Nov 2025 10:56:24 -1000
Message-ID: <20251110205636.405592-3-tj@kernel.org>
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

There have been reported cases of bypass mode not making forward progress fast
enough. The 20ms default slice is unnecessarily long for bypass mode where the
primary goal is ensuring all tasks can make forward progress.

Introduce SCX_SLICE_BYPASS set to 5ms and make the scheduler automatically
switch to it when entering bypass mode. Also make the bypass slice value
tunable through the slice_bypass_us module parameter (adjustable between 100us
and 100ms) to make it easier to test whether slice durations are a factor in
problem cases.

v2: Removed slice_dfl_us module parameter. Fixed typos (Andrea).

Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Cc: Andrea Righi <andrea.righi@linux.dev>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h | 11 +++++++++++
 kernel/sched/ext.c        | 34 +++++++++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index eb776b094d36..60285c3d07cf 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -17,7 +17,18 @@
 enum scx_public_consts {
 	SCX_OPS_NAME_LEN	= 128,
 
+	/*
+	 * %SCX_SLICE_DFL is used to refill slices when the BPF scheduler misses
+	 * to set the slice for a task that is selected for execution.
+	 * %SCX_EV_REFILL_SLICE_DFL counts the number of times the default slice
+	 * refill has been triggered.
+	 *
+	 * %SCX_SLICE_BYPASS is used as the slice for all tasks in the bypass
+	 * mode. As making forward progress for all tasks is the main goal of
+	 * the bypass mode, a shorter slice is used.
+	 */
 	SCX_SLICE_DFL		= 20 * 1000000,	/* 20ms */
+	SCX_SLICE_BYPASS	=  5 * 1000000, /*  5ms */
 	SCX_SLICE_INF		= U64_MAX,	/* infinite, implies nohz */
 };
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index cf8d86a2585c..abf2075f174f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -143,6 +143,32 @@ static struct scx_dump_data scx_dump_data = {
 /* /sys/kernel/sched_ext interface */
 static struct kset *scx_kset;
 
+/*
+ * Parameters that can be adjusted through /sys/module/sched_ext/parameters.
+ * There usually is no reason to modify these as normal scheduler operation
+ * shouldn't be affected by them. The knobs are primarily for debugging.
+ */
+static u64 scx_slice_dfl = SCX_SLICE_DFL;
+static unsigned int scx_slice_bypass_us = SCX_SLICE_BYPASS / NSEC_PER_USEC;
+
+static int set_slice_us(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, 100, 100 * USEC_PER_MSEC);
+}
+
+static const struct kernel_param_ops slice_us_param_ops = {
+	.set = set_slice_us,
+	.get = param_get_uint,
+};
+
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX	"sched_ext."
+
+module_param_cb(slice_bypass_us, &slice_us_param_ops, &scx_slice_bypass_us, 0600);
+MODULE_PARM_DESC(slice_bypass_us, "bypass slice in microseconds, applied on [un]load (100us to 100ms)");
+
+#undef MODULE_PARAM_PREFIX
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/sched_ext.h>
 
@@ -919,7 +945,7 @@ static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
 
 static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 {
-	p->scx.slice = SCX_SLICE_DFL;
+	p->scx.slice = scx_slice_dfl;
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
@@ -2892,7 +2918,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
 	INIT_LIST_HEAD(&scx->runnable_node);
 	scx->runnable_at = jiffies;
 	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
-	scx->slice = SCX_SLICE_DFL;
+	scx->slice = scx_slice_dfl;
 }
 
 void scx_pre_fork(struct task_struct *p)
@@ -3770,6 +3796,7 @@ static void scx_bypass(bool bypass)
 		WARN_ON_ONCE(scx_bypass_depth <= 0);
 		if (scx_bypass_depth != 1)
 			goto unlock;
+		scx_slice_dfl = scx_slice_bypass_us * NSEC_PER_USEC;
 		bypass_timestamp = ktime_get_ns();
 		if (sch)
 			scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
@@ -3778,6 +3805,7 @@ static void scx_bypass(bool bypass)
 		WARN_ON_ONCE(scx_bypass_depth < 0);
 		if (scx_bypass_depth != 0)
 			goto unlock;
+		scx_slice_dfl = SCX_SLICE_DFL;
 		if (sch)
 			scx_add_event(sch, SCX_EV_BYPASS_DURATION,
 				      ktime_get_ns() - bypass_timestamp);
@@ -4776,7 +4804,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			queue_flags |= DEQUEUE_CLASS;
 
 		scoped_guard (sched_change, p, queue_flags) {
-			p->scx.slice = SCX_SLICE_DFL;
+			p->scx.slice = scx_slice_dfl;
 			p->sched_class = new_class;
 		}
 	}
-- 
2.51.2

