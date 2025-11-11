Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AE23AA1BB;
	Tue, 11 Nov 2025 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883002; cv=none; b=aeifRzpdg/Cx9Rgo4BFHoq8uDhq5NLVU6czLAXLPxQXIxE417bzlqdhk5wSqi3AdUjCocRXMzHXEM+tiZFnLMpJ1LIWvSZ7FyWphmK/heJ2sUCWmwfle5vUWP/4zFM6TI0SF1Xw3AikI/ZzywtH/Q+/w6CA/eJrPv7FuHvbhGio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883002; c=relaxed/simple;
	bh=Yz669Ztox0ytmI5mSEtB7cE4WuBZ3elFNw7eEtmRQwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+zQm7SSvMHhDymSavr9eO+aJWxdm+5yAqY0FJKgJVa5+9moUJ5NR2yFda9QnuzMdBZ6p0lLzsfo+6/W/S5s++lxwIQRJh5y5LTBj22Z5Rdl85sLxpDvtjMmf3L+wc6BYvYUXnXL3vQFUwljdqvb9LaTt1Pa+WuiyPNPMiReONY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6E7DFd+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6E7DFd+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F197EC4CEF5;
	Tue, 11 Nov 2025 17:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762883001;
	bh=Yz669Ztox0ytmI5mSEtB7cE4WuBZ3elFNw7eEtmRQwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O6E7DFd+DO3gIMmU7nSCqUop58Zi9AMINYR/NDYZ5G2BNPEc5+Dn9OSlmhJ+X7RkN
	 FBbWbIJEBZ4Yo2ZVS0olQooVEAGa4oN7l5g8IajowaGfy1rSP/GtxNRjXUs3GSDe2L
	 g/NHrNVSuKQcGtYE74tbhbDgK3bYRosbNkHaTCSAD5XMASCXyLAmUiMMlI0Fpx7U4i
	 IzF4NvZgjZMd2DRW22GaQrUa4xHDX1WoS28xns1WQCY+OvEIh+GEf13dKj94dYvh59
	 NchScIjlMy75oIz9yI7i1hYJIqXsgDYV3N0VX+9iAJn/siUpM4T5ljQdg59iUY7d8Q
	 cIstw4ymWhJVw==
Date: Tue, 11 Nov 2025 07:43:19 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/14] sched_ext: Use shorter slice in bypass mode
Message-ID: <aRN1t_BT4IqYLdBj@slm.duckdns.org>
References: <20251110205636.405592-1-tj@kernel.org>
 <20251110205636.405592-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110205636.405592-3-tj@kernel.org>

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
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Andrea Righi <andrea.righi@linux.dev>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |   11 +++++++++++
 kernel/sched/ext.c        |   34 +++++++++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 3 deletions(-)

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
 
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -143,6 +143,32 @@ static struct scx_dump_data scx_dump_dat
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
 
@@ -919,7 +945,7 @@ static void dsq_mod_nr(struct scx_dispat
 
 static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 {
-	p->scx.slice = SCX_SLICE_DFL;
+	p->scx.slice = READ_ONCE(scx_slice_dfl);
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
@@ -2896,7 +2922,7 @@ void init_scx_entity(struct sched_ext_en
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
@@ -4780,7 +4808,7 @@ static int scx_enable(struct sched_ext_o
 			queue_flags |= DEQUEUE_CLASS;
 
 		scoped_guard (sched_change, p, queue_flags) {
-			p->scx.slice = SCX_SLICE_DFL;
+			p->scx.slice = READ_ONCE(scx_slice_dfl);
 			p->sched_class = new_class;
 		}
 	}
