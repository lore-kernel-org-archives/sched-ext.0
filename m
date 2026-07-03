Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98201371048;
	Fri,  3 Jul 2026 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065722; cv=none; b=aveJhNpudNNQ06jsrtrBxuryvkccusIsJo/axVJAHRaSqCacZkG6thqZ23Bo4In8Afg2BcrHrquhEnN+ttOsOq9WIjN97j0en/oG2yrsCE4A3jI0RSLMZTFoOtCUt4vkBOmGZIK+NP0pouQQ+usLTi3N/GHGNdS4gdQsiZn+gdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065722; c=relaxed/simple;
	bh=q4XybpGw42HrGGHc/WvRBbcfug4LeqOWQOxtrYNN0e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khe5GMHmHjbidqV8pgXCiHI83tUgWeVNw5UHhVElcsUl4FAFNTRQP/jeq7rukDDHNArkUVywkQdBWFbTZy8rjPBvHwH16yk+YPNT328sgFirnqB581scBgrSGItOFbWJZnSq7ir/Bmgyb020IU4iYMTTc3xJNDxmNJXMVUL0bOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCaA/KwK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCaA/KwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388151F00A3E;
	Fri,  3 Jul 2026 08:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065721;
	bh=1r4N/mvxRKDE/PAAkn/aDSzcifa2eHUV28nLjPhLHB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XCaA/KwKfvcv/j7+7XldlwWqW5uqO2hcmUIca0DR+HKmeSIiw/bsPgifGU3QmIPjF
	 hQ/lYjjk9flG1N7YnhMOzXh092m+IMBbuyOo7Kju5yazcs7NMCFkOSK5liUeBYJUng
	 l0MYpI/g09wPmxBZ3M82Hoe2jvH9PMbsEFxudMEDOIqnUAeNd4XGSHKhaB5I9fCHMA
	 fzNF4Wi7nY54U4PstqfpTcqp0ErksiF3FSjJ4EgLsXGCO/mJFkIysFfdTj4XqMj3xV
	 dSY1WqZk3qtyiMUMaJATzN6Cmv07uiP22kqlXI1oeByVpykml3cjSh5YsHNh6hGlUm
	 XuN2TrRUEWrAg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3 01/32] sched_ext: Fix premature ops->priv publication in scx_alloc_and_add_sched()
Date: Thu,  2 Jul 2026 22:01:28 -1000
Message-ID: <20260703080159.2314350-2-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703080159.2314350-1-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_alloc_and_add_sched() publishes @sch through ops->priv before allocating
the cgroup path. If that allocation fails, the unwind path clears ops->priv
and frees @sch immediately. scx_prog_sched() callers can dereference
ops->priv from RCU context the moment it is set, so freeing without a grace
period can use-after-free a concurrent kfunc caller.

Move the publication below the cgroup path allocation so that every failure
path after publication frees @sch through kobject_put(), whose release path
defers the freeing by a grace period.

Fixes: 105dcd005be2 ("sched_ext: Introduce scx_prog_sched()")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1a0ec985da77..f4725698f5ef 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6363,11 +6363,6 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		sch->ops = *cmd->ops;
 	}
 
-	rcu_assign_pointer(ops->priv, sch);
-
-	sch->kobj.kset = scx_kset;
-	INIT_LIST_HEAD(&sch->all);
-
 #ifdef CONFIG_EXT_SUB_SCHED
 	char *buf = kzalloc(PATH_MAX, GFP_KERNEL);
 	if (!buf) {
@@ -6385,7 +6380,19 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 	sch->cgrp = cgrp;
 	INIT_LIST_HEAD(&sch->children);
 	INIT_LIST_HEAD(&sch->sibling);
+#endif	/* CONFIG_EXT_SUB_SCHED */
 
+	/*
+	 * Publishing makes @sch visible to scx_prog_sched() readers. Failure
+	 * paths after this point must free @sch through kobject_put() whose
+	 * release path defers the actual freeing by an RCU grace period.
+	 */
+	rcu_assign_pointer(ops->priv, sch);
+
+	sch->kobj.kset = scx_kset;
+	INIT_LIST_HEAD(&sch->all);
+
+#ifdef CONFIG_EXT_SUB_SCHED
 	if (parent) {
 		/*
 		 * Pin @parent for @sch's lifetime. The kobject hierarchy pins
@@ -6440,7 +6447,6 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 
 #ifdef CONFIG_EXT_SUB_SCHED
 err_free_lb_resched:
-	RCU_INIT_POINTER(ops->priv, NULL);
 	free_cpumask_var(sch->stall_cpus);
 #endif
 err_free_lb_resched_cpumask:
-- 
2.54.0

