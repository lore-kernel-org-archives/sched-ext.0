Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97F3F4DF5;
	Wed,  8 Jul 2026 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545874; cv=none; b=H4nTePRxehTAWdxC8nJOW3SfgeYO4x6Gyy3lv6CQs5Mm/bzztSwxeiyXOpiHXDba4m2EGM1gGj5lhJbiDCsVKXkgdqahn5CUB+zccbTxGFTNvfkvi/W3R4jUKql9p6z2a2mlPOCTqaFteOAhUPlYob7qD8UqRm6E9hudgoXF+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545874; c=relaxed/simple;
	bh=q4XybpGw42HrGGHc/WvRBbcfug4LeqOWQOxtrYNN0e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3GfkxcHg1xhApI6GYXymOU9WgVPme3R7h5iTu5ZeDKhTPhLMe8tXwsE+sV3SORtb39MqpaDBvDtfMoBvEIk6ujyY1NowfAtXEhmuzZ54BLcq85S5Mb5zvBNrMopgewF23joFqSep0+YS8IPjDPI7wWchTBibJnrnx0SFMTYQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZezwzLz4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZezwzLz4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3E31F000E9;
	Wed,  8 Jul 2026 21:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545872;
	bh=1r4N/mvxRKDE/PAAkn/aDSzcifa2eHUV28nLjPhLHB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZezwzLz4gBGUB7pTQtgJkpkhRni4wtCXMAo+KRkAsdjF0gLgXGaxTU+fTOpMpRXWj
	 H6GvKJpjKoZw2GpsK4wp1y+W2cEUzndNf9e1cnVdw2dFZj3IxYvnntMItNXQ/DLwvP
	 a4b5tWQJcS9mS8XO0NaVt0Gxs/cro0/BX9bqCz9c0+ZgQsN+rh/XfCeERTU7qnbOpC
	 z/irGjIp2p4uxZskL3+ahroW7x6li5elIjuJyZn8SwS8R8a3E8xZQ7tH2EHQP8L5aS
	 C28VKUN7QmqqZ78qSs7d+K+AgB1nYhyEYuqRxHCiTI/rNvj6h2EmbDAGIbP9Y6F58u
	 UQeHg7hPMDXYA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 02/40] sched_ext: Fix premature ops->priv publication in scx_alloc_and_add_sched()
Date: Wed,  8 Jul 2026 11:23:51 -1000
Message-ID: <20260708212429.3405787-3-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708212429.3405787-1-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
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

