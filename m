Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B92923535E;
	Sun,  9 Nov 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762713077; cv=none; b=nprqHUBO+/zDDh5TODyMVYamsQ8FaPQZYk5Zrl1G8/fyH4nvSGJChkspTs1idRZqCzbVHMYQ4oxHl94k+XpgU3Q5hVj0/Q/PWUHecI7VYeIkxf2uYQIDMzq3vA1HhFzbDa3CKsRZprA0du1PoPzvo5H+Xi/mQUN+XPRd7Wr5YNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762713077; c=relaxed/simple;
	bh=BZA976NqBnv8n4qbBNLMXwselot6RRON/84dLPnnXy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErfII2L+AQXjKpUeiJUGgHIJxltLeFcLU8f/esxdLnjo1kE2pgy2cv2W+jF5h6ZCbDlqz9w18H92XaIMtUtZwKbr5CmBD6zDa8r/FaAYt1KVoC/vnC/aVB1Urh0DtIaDe9NGkpcL2LQDUgKXoEooZnFMluiFGIkQkyyNla78dxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oynzwPCW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oynzwPCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7367C4CEF8;
	Sun,  9 Nov 2025 18:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762713076;
	bh=BZA976NqBnv8n4qbBNLMXwselot6RRON/84dLPnnXy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oynzwPCWGbtMsTtWU2wn7zQHdxNcDwjMbOtTVwNPaFn6f/eatqEKwH7QWPf73cL9V
	 LlGf+zYocHv93QOlQ3t3tF1Ahtc+7jGHP85ckWk1VfEFd+gmgutBNMBVpYjdm0DHRg
	 nISiatLsxIqWrNkXahVvrl/n6QnvagqkHPpXBD/1lUVC4myjKb0vz/IxG9A6wHTjB3
	 2i+fq6QMmdqx9mCBNIR0s+Ly/oCxb85REgNPDf07G6TAYH9xE4I2Gg5cXckawiYVIZ
	 cBFr7gMb8R2U7Q8XnCFWsGoHhhpRcXrZPem6qvFEeXgsLZCNlAzLeerG+BXULbCx/c
	 ZlpbmHRc/orKA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/13] sched_ext: Make slice values tunable and use shorter slice in bypass mode
Date: Sun,  9 Nov 2025 08:31:01 -1000
Message-ID: <20251109183112.2412147-3-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109183112.2412147-1-tj@kernel.org>
References: <20251109183112.2412147-1-tj@kernel.org>
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
switch to it when entering bypass mode. Also make both the default and bypass
slice values tunable through module parameters (slice_dfl_us and
slice_bypass_us, adjustable between 100us and 100ms) to make it easier to test
whether slice durations are a factor in problem cases. Note that the configured
values are applied through bypass mode switching and thus are guaranteed to
apply only during scheduler [un]load operations.

Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h | 11 +++++++++++
 kernel/sched/ext.c        | 37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index eb776b094d36..9f5b0f2be310 100644
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
+	 * mode. As mkaing forward progress for all tasks is the main goal of
+	 * the bypass mode, a shorter slice is used.
+	 */
 	SCX_SLICE_DFL		= 20 * 1000000,	/* 20ms */
+	SCX_SLICE_BYPASS	=  5 * 1000000, /*  5ms */
 	SCX_SLICE_INF		= U64_MAX,	/* infinite, implies nohz */
 };
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index cf8d86a2585c..2ce226018dbe 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -143,6 +143,35 @@ static struct scx_dump_data scx_dump_data = {
 /* /sys/kernel/sched_ext interface */
 static struct kset *scx_kset;
 
+/*
+ * Parameter that can be adjusted through /sys/module/sched_ext/parameters.
+ * There usually is no reason to modify these as normal scheduler opertion
+ * shouldn't be affected by them. The knobs are primarily for debugging.
+ */
+static u64 scx_slice_dfl = SCX_SLICE_DFL;
+static unsigned int scx_slice_dfl_us = SCX_SLICE_DFL / NSEC_PER_USEC;
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
+module_param_cb(slice_dfl_us, &slice_us_param_ops, &scx_slice_dfl_us, 0600);
+MODULE_PARM_DESC(slice_dfl_us, "default slice in microseconds, applied on [un]load (100us to 100ms)");
+module_param_cb(slice_bypass_us, &slice_us_param_ops, &scx_slice_bypass_us, 0600);
+MODULE_PARM_DESC(slice_bypass_us, "bypass slice in microseconds, applied on [un]load (100us to 100ms)");
+
+#undef MODULE_PARAM_PREFIX
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/sched_ext.h>
 
@@ -919,7 +948,7 @@ static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
 
 static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 {
-	p->scx.slice = SCX_SLICE_DFL;
+	p->scx.slice = scx_slice_dfl;
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
@@ -2892,7 +2921,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
 	INIT_LIST_HEAD(&scx->runnable_node);
 	scx->runnable_at = jiffies;
 	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
-	scx->slice = SCX_SLICE_DFL;
+	scx->slice = scx_slice_dfl;
 }
 
 void scx_pre_fork(struct task_struct *p)
@@ -3770,6 +3799,7 @@ static void scx_bypass(bool bypass)
 		WARN_ON_ONCE(scx_bypass_depth <= 0);
 		if (scx_bypass_depth != 1)
 			goto unlock;
+		scx_slice_dfl = scx_slice_bypass_us * NSEC_PER_USEC;
 		bypass_timestamp = ktime_get_ns();
 		if (sch)
 			scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
@@ -3778,6 +3808,7 @@ static void scx_bypass(bool bypass)
 		WARN_ON_ONCE(scx_bypass_depth < 0);
 		if (scx_bypass_depth != 0)
 			goto unlock;
+		scx_slice_dfl = scx_slice_dfl_us * NSEC_PER_USEC;
 		if (sch)
 			scx_add_event(sch, SCX_EV_BYPASS_DURATION,
 				      ktime_get_ns() - bypass_timestamp);
@@ -4776,7 +4807,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			queue_flags |= DEQUEUE_CLASS;
 
 		scoped_guard (sched_change, p, queue_flags) {
-			p->scx.slice = SCX_SLICE_DFL;
+			p->scx.slice = scx_slice_dfl;
 			p->sched_class = new_class;
 		}
 	}
-- 
2.51.1

