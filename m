Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB7637BE6F;
	Mon,  6 Jul 2026 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302063; cv=none; b=SX4vjSHZI788F07AvbjoSe5QN4BPLDP/aXCbwFogZuzpPI6qZqIeIl7FZojrcwb9RmJd4RN3oOjORQ/MvJ7PeoQV5IQH1GlKmSO4A3pPBkR7AyKTmRJPjor61QDztKgbTdlvi94eLSbTx+3I+qU5HYw0/eiwHtzSFMgAcHe1qAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302063; c=relaxed/simple;
	bh=0mI9WfCKXZ88xAlqsJMMNuFVm4h/9SvqfEqn8QqrLVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJpqIUAhOJgotJFTU+kDAwi7GbHuFDCTBoYJa00b+W/7j7ayXGGUPXStgj26UDluSleiSTXxl3yRjpyA5XRPSZ5qTwoCgZ4efDWZ0Hr2D6xaiHi0oIrOeMKM7QEe4KTE1sspmHxelUlZCovnbyOA7Gnz+t9SBH5xgNYFmunpOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byLNr34X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byLNr34X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5394F1F000E9;
	Mon,  6 Jul 2026 01:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302062;
	bh=IbYqhU62Y8V6P/etDCSBiUQ7EDXxksqUU4iZDQ19TuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=byLNr34XDAmTfZ/mJZkQUZDLan4JCVOZmEJ+Cwr9oWlW4/kqk0w5NScdeHWUtEfAR
	 6pmG2bdOVaUCIlZv91EH2IXblWD33Z3cM4kXdL38aGiHOhKcLs7DWjTC1A6Joa4GPn
	 /m5jeuIpbK+6G0iwJioNnIw4tKcE7ncNUWx0gqoGHiraBrh7HTBeFXvOXx8Opkz59m
	 8Qvk/O0R5oj/hIodTW+GDJCAD6KikprIuxDRj0Qbp9UrUEL3H6917qvGkJVr8CtUNO
	 mwpJGEzkumYxl9TRnOkULU8bquRGutrja//C///K9DDmNZpDF9Aed+yZ7JucXIE9Zc
	 ec7EMxnkYnz+A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 03/36] sched_ext: Fix premature ops->priv publication in scx_alloc_and_add_sched()
Date: Sun,  5 Jul 2026 15:40:25 -1000
Message-ID: <20260706014058.439853-4-tj@kernel.org>
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
index d15cf3c7f87c..be75bdc9ada2 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6355,11 +6355,6 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
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
@@ -6377,7 +6372,19 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
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
@@ -6432,7 +6439,6 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 
 #ifdef CONFIG_EXT_SUB_SCHED
 err_free_lb_resched:
-	RCU_INIT_POINTER(ops->priv, NULL);
 	free_cpumask_var(sch->stall_cpus);
 #endif
 err_free_lb_resched_cpumask:
-- 
2.54.0

