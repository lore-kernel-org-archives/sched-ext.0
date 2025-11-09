Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95C63043AC;
	Sun,  9 Nov 2025 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762713083; cv=none; b=oAJaxl6OmnPUHZruZKrAPh07YZwE5Yx/soNvsrzkQVJ/X3iKL2BQhb7eQ71t2OWu8HbWi/uSnRC/7s20fLZ7vF0fjOIF7iG5iA1BJ1aFCVZ/SunOhDSl/WxDvL4DVHSBeDMMFyrAfQ8qmHHMIP0sGOmmriYMXVGe8LWcPPT0bn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762713083; c=relaxed/simple;
	bh=ty7kfcwc61iFAjo3klt9tkXL0zko6IERMAit0S1rLXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naF3gCw9fQJ8x90vX0PHAES2s9diQCEQndIlLoQXsmE2iKK4AroUCbMgC0A7y3QczucGqOGHb7VjbnHl22x3pMhAabOFhzJt6IMLUXckhNGf6Pyl0FXF/rcRN7HWHSlIJ7n2tiSC3soQ0f57WWpVD8Mc1TwFetp7IKlBJzcKmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqy2OuJh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqy2OuJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BAEC4CEF7;
	Sun,  9 Nov 2025 18:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762713082;
	bh=ty7kfcwc61iFAjo3klt9tkXL0zko6IERMAit0S1rLXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bqy2OuJhQanG8ND42jllU3JiwqusABcPAz+1ikhdvPQRyJZcz2GiiZR5RLDnku6HI
	 VtRTZsYfml60NDZwnHG8IP0WOItjAtL0M+hCwP8YUSFG8ltDh8PAEhk7HN3362ZIiW
	 gz5nub+WcLiHoUzsC9SjtGTIF01Oc0CSQ7UqhnM9RVU5mpoSHTVIjyBBmly+1I6qYC
	 KbwQRhqJ/i0OBu4TInRYuV0g5Xm7oa6xucmnl4Ja6F/1N71f2xaX2j8+xISuXwT59I
	 pZhz48zUeiIXaBCcvifZR8ZSgtE4BfvD+y4TeCUQzgru8YNuQA0NRlJ7E6v7pWVplU
	 cbGlugPb66hhg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/13] sched_ext: Refactor lockup handlers into handle_lockup()
Date: Sun,  9 Nov 2025 08:31:07 -1000
Message-ID: <20251109183112.2412147-9-tj@kernel.org>
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

scx_rcu_cpu_stall() and scx_softlockup() share the same pattern: check if the
scheduler is enabled under RCU read lock and trigger an error if so. Extract
the common pattern into handle_lockup() helper. Add scx_verror() macro and use
guard(rcu)().

This simplifies both handlers, reduces code duplication, and prepares for
hardlockup handling.

Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 65 ++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 033c8b8e88e8..5c75b0125dfe 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -195,6 +195,7 @@ static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
 }
 
 #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
+#define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, fmt, args)
 
 #define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
 
@@ -3653,39 +3654,40 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
 	return false;
 }
 
-/**
- * scx_rcu_cpu_stall - sched_ext RCU CPU stall handler
- *
- * While there are various reasons why RCU CPU stalls can occur on a system
- * that may not be caused by the current BPF scheduler, try kicking out the
- * current scheduler in an attempt to recover the system to a good state before
- * issuing panics.
- */
-bool scx_rcu_cpu_stall(void)
+static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
 {
 	struct scx_sched *sch;
+	va_list args;
 
-	rcu_read_lock();
+	guard(rcu)();
 
 	sch = rcu_dereference(scx_root);
-	if (unlikely(!sch)) {
-		rcu_read_unlock();
+	if (unlikely(!sch))
 		return false;
-	}
 
 	switch (scx_enable_state()) {
 	case SCX_ENABLING:
 	case SCX_ENABLED:
-		break;
+		va_start(args, fmt);
+		scx_verror(sch, fmt, args);
+		va_end(args);
+		return true;
 	default:
-		rcu_read_unlock();
 		return false;
 	}
+}
 
-	scx_error(sch, "RCU CPU stall detected!");
-	rcu_read_unlock();
-
-	return true;
+/**
+ * scx_rcu_cpu_stall - sched_ext RCU CPU stall handler
+ *
+ * While there are various reasons why RCU CPU stalls can occur on a system
+ * that may not be caused by the current BPF scheduler, try kicking out the
+ * current scheduler in an attempt to recover the system to a good state before
+ * issuing panics.
+ */
+bool scx_rcu_cpu_stall(void)
+{
+	return handle_lockup("RCU CPU stall detected!");
 }
 
 /**
@@ -3700,28 +3702,11 @@ bool scx_rcu_cpu_stall(void)
  */
 void scx_softlockup(u32 dur_s)
 {
-	struct scx_sched *sch;
-
-	rcu_read_lock();
-
-	sch = rcu_dereference(scx_root);
-	if (unlikely(!sch))
-		goto out_unlock;
-
-	switch (scx_enable_state()) {
-	case SCX_ENABLING:
-	case SCX_ENABLED:
-		break;
-	default:
-		goto out_unlock;
-	}
-
-	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU%d stuck for %us, disabling \"%s\"\n",
-			smp_processor_id(), dur_s, scx_root->ops.name);
+	if (!handle_lockup("soft lockup - CPU %d stuck for %us", smp_processor_id(), dur_s))
+		return;
 
-	scx_error(sch, "soft lockup - CPU#%d stuck for %us", smp_processor_id(), dur_s);
-out_unlock:
-	rcu_read_unlock();
+	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU %d stuck for %us, disabling BPF scheduler\n",
+			smp_processor_id(), dur_s);
 }
 
 /**
-- 
2.51.1

