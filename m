Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D767232570D;
	Tue, 11 Nov 2025 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888698; cv=none; b=dnEho3Lanx1NE4qG6QsFEWEJZ/x138Sz43WX8m0Zz1F15vtR79n/3DQjJFvM9+dumNc5eDJ8+Qr/yP048qU7wmbHHea3NZOckFsMGsKn7+rjpAdriZCS/p9htle2VhKPC12FHGFdJSj6Ys2CEEGQgozmo9YU7jZiVkEhlvp6M2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888698; c=relaxed/simple;
	bh=nfF4oUs0XvOLLgzU1+31yRGR6OzG29x+C0y5ASkfe/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ke37ujdLO0eCkO9mu7RFY6O4jtb8e6lgSGM+IIQETfuBgcitoOiXAlmW0kS+RWDJDofT4EfXXR/u9ZlE9VweP1PbJwFixjcV4LtYmkWIJ+c5/r8sE7yAGtMAYAcINmdzzacuz4hbycRWgHVSU0shwTYr/BoTDpUjzbT32yPYmfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7kMoAPl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7kMoAPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D18C4CEFB;
	Tue, 11 Nov 2025 19:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888698;
	bh=nfF4oUs0XvOLLgzU1+31yRGR6OzG29x+C0y5ASkfe/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h7kMoAPlKBRjk+JwAJ9PMDA5Y/KxQ35ws7egWbWYobVT8eqnunKNbbySVj4sMJ6tK
	 3YCzzOaUWUNASDwVlDjaupZCyRpwVDMxJX00Ul62iB5AINc8NPbsbS9c4/hEwMqh1J
	 qcbpRZuA3v4oIouhCNXqZMrSePOyl5U/xkHTQxfifpty9kT4I9e3vB3wDSExNaMcPG
	 mMgRCN7JZ/aLK8SAgizU8H84wVOIgqQmhjUCisrgBr8cA6BfKDMiSh1fmLzpWqddfi
	 0sKTq+qLNhUlnrPm2iFDggXPLYqnf+rSRJfqOKzTVwb1H2KEUhx3FEJP4L0Xfj+B3e
	 y8NQDEdO4t/iw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH 01/13] sched_ext: Use shorter slice in bypass mode
Date: Tue, 11 Nov 2025 09:18:04 -1000
Message-ID: <20251111191816.862797-2-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111191816.862797-1-tj@kernel.org>
References: <20251111191816.862797-1-tj@kernel.org>
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

v3: Use READ_ONCE/WRITE_ONCE for scx_slice_dfl access (Dan).

v2: Removed slice_dfl_us module parameter. Fixed typos (Andrea).

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
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
index 652a364e9e4c..1a9b28dd0961 100644
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
+	p->scx.slice = READ_ONCE(scx_slice_dfl);
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
@@ -2896,7 +2922,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
 	INIT_LIST_HEAD(&scx->runnable_node);
 	scx->runnable_at = jiffies;
 	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
-	scx->slice = SCX_SLICE_DFL;
+	scx->slice = READ_ONCE(scx_slice_dfl);
 }
 
 void scx_pre_fork(struct task_struct *p)
@@ -3774,6 +3800,7 @@ static void scx_bypass(bool bypass)
 		WARN_ON_ONCE(scx_bypass_depth <= 0);
 		if (scx_bypass_depth != 1)
 			goto unlock;
+		WRITE_ONCE(scx_slice_dfl, scx_slice_bypass_us * NSEC_PER_USEC);
 		bypass_timestamp = ktime_get_ns();
 		if (sch)
 			scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
@@ -3782,6 +3809,7 @@ static void scx_bypass(bool bypass)
 		WARN_ON_ONCE(scx_bypass_depth < 0);
 		if (scx_bypass_depth != 0)
 			goto unlock;
+		WRITE_ONCE(scx_slice_dfl, SCX_SLICE_DFL);
 		if (sch)
 			scx_add_event(sch, SCX_EV_BYPASS_DURATION,
 				      ktime_get_ns() - bypass_timestamp);
@@ -4780,7 +4808,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			queue_flags |= DEQUEUE_CLASS;
 
 		scoped_guard (sched_change, p, queue_flags) {
-			p->scx.slice = SCX_SLICE_DFL;
+			p->scx.slice = READ_ONCE(scx_slice_dfl);
 			p->sched_class = new_class;
 		}
 	}
-- 
2.51.2

