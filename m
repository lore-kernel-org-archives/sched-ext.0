Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2FD2F90DE;
	Tue, 11 Nov 2025 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888705; cv=none; b=l69PRNmw62azGNPt6lXuI+QFd/JUSie9cO0jaq+fQZjGG07cQql+VCASIOjyF7r60ESGGbRG7MqAhVWt3pn8TW0NRvSRENzZI5mm45HrRoRL0ctBKTg5Q8GDg49VE5e77UVjuX6LEEugSsVFUn1aLs4ApFL/5/LJOYCn5Xhh8P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888705; c=relaxed/simple;
	bh=Iuhhx9ASFglT3FQiEq1L1On2cSvv4Rrpt7SJahmBvd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTk+N49b6h2uVAYA1zs+ZdvyiOibIJolw53eeQhEZkm0ouWmCroj0SCvh0cbfXrT85lbmcuu8GJzXhEjgdGa5Lp+nQ/2XVrYmFbtk0n15vPoejNr6uIwgIxVrnvAND0GyHVna+GUTD755+44B6OeNWtCIdH2M8PisgEYWvdMzSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIrP/qNk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIrP/qNk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17538C4CEF7;
	Tue, 11 Nov 2025 19:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888705;
	bh=Iuhhx9ASFglT3FQiEq1L1On2cSvv4Rrpt7SJahmBvd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIrP/qNkkztTRF8t+jnnmoOwq5X1SdzNkaekrZCqCeNiD/9pemV4PfRo9j1/YcSFb
	 HuK7Y9NKvTgBE1Lrz7F+VX4CTtM/0GbHLoeQnwcZ5VOvwt3Zxhk+NJI/QMG5Uw7Zzv
	 he3ss26e465XeF8uccNTMGDMzdM5V2apBSup3ImDIMiKZHRArdOkWsX/5oBst6CwDO
	 GAZ8LCFyXvUFgAho11thLPEizl7uu2GNT6Z2wf3K3S5Pq41as9LBsKE//tqWDkAv8q
	 SZGJ9XJSJBtTWsHURh/TpFDmdrnDPWMjeMah/7l7xlswK9Ex+QOUZWgeqysAc5kQRz
	 k5p5p+URw5ZDg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH 07/13] sched_ext: Refactor lockup handlers into handle_lockup()
Date: Tue, 11 Nov 2025 09:18:10 -1000
Message-ID: <20251111191816.862797-8-tj@kernel.org>
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

scx_rcu_cpu_stall() and scx_softlockup() share the same pattern: check if the
scheduler is enabled under RCU read lock and trigger an error if so. Extract
the common pattern into handle_lockup() helper. Add scx_verror() macro and use
guard(rcu)().

This simplifies both handlers, reduces code duplication, and prepares for
hardlockup handling.

Reviewed-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 65 ++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e6e69a7fe105..ad5d3902e99d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -192,6 +192,7 @@ static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
 }
 
 #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
+#define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, fmt, args)
 
 #define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
 
@@ -3654,39 +3655,40 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
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
@@ -3701,28 +3703,11 @@ bool scx_rcu_cpu_stall(void)
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
2.51.2

