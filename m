Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD29347530;
	Mon, 16 Mar 2026 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773639812; cv=none; b=fcd7mTb+hS/xEvnnwzUEG+28ky9ys9RsRSTpY/DFBvvs+Oc+hA6EKPWFCaqoB9L1+JsDsQefJTo6NwMv0RKj7JSIXpiPlUYtEozfACn2FcK3KufwM2v20hfv3PJlhFQ4ODhM93HAhTPsbR/ufnOYdQ/+aNkV37tsEwI76MhqtgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773639812; c=relaxed/simple;
	bh=Q90EhNWRmEdTOmf20L0pVG2AjUUk1Cusoo2SoujLIrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcKnOgboVGURrKtZIgwgxYxs2JQx4S5uXJ7+ZdnT0hNepTaKrOE3TzVUvJboUb3w7VQxu4Cpr6W7J2vn//uAmNw+QPSeXaAlcOro2TRwEu47dkL8Oy9Q+zgIS846PtLJO+vagoGVS870/6Wxnl/AFu6xhaFmSYk4BXSTjAxLMak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4mmlXF+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4mmlXF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D49C4AF09;
	Mon, 16 Mar 2026 05:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773639812;
	bh=Q90EhNWRmEdTOmf20L0pVG2AjUUk1Cusoo2SoujLIrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o4mmlXF+PW4uVTJw2uJ6Ynky1b8D2rsKN1w0JCbMVN1C8R3hWygj2m5HxuHepYgBi
	 wXVeBd1Rx6YlUx6UCwmUV6a3jcTiaf8GPUC/CJ93u9+3eNOn+VKCc2l3VrvYJEVNx8
	 QfMJrA24lrMgXi0IUpCasXxVOKZKT9F5sdmc4mHzXo8Bv8u3VcC1bCau2wtUz2y0ob
	 B5oB8cDxtRWSyuQTmpu1v1IB08/Uebx2O0a6DRkFzHIcbnbXGwyFvUFzMzaUL0uXAv
	 MNk3uyAmae6Cjl8h+qED151G6jw749+6uNzG8x+5c452icjGTgmqlT6ckoz9+aZJeH
	 NjWa931lWr++w==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: David Carlier <devnexen@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] sched_ext: Use kobject_put() for kobject_init_and_add() failure in scx_alloc_and_add_sched()
Date: Sun, 15 Mar 2026 19:43:28 -1000
Message-ID: <20260316054328.838304-3-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316054328.838304-1-tj@kernel.org>
References: <20260316054328.838304-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kobject_init_and_add() failure requires kobject_put() for proper cleanup, but
the error paths were using kfree(sch) possibly leaking the kobject name. The
kset_create_and_add() failure was already using kobject_put() correctly.

Switch the kobject_init_and_add() error paths to use kobject_put(). As the
release path puts the cgroup ref, make scx_alloc_and_add_sched() always
consume @cgrp via a new err_put_cgrp label at the bottom of the error chain
and update scx_sub_enable_workfn() accordingly.

Fixes: 17108735b47d ("sched_ext: Use dynamic allocation for scx_sched")
Reported-by: David Carlier <devnexen@gmail.com>
Link: https://lore.kernel.org/r/20260314134457.46216-1-devnexen@gmail.com
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2f70effcc4a6..b942918fa364 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6353,6 +6353,10 @@ static struct scx_sched_pnode *alloc_pnode(struct scx_sched *sch, int node)
 	return pnode;
 }
 
+/*
+ * Allocate and initialize a new scx_sched. @cgrp's reference is always
+ * consumed whether the function succeeds or fails.
+ */
 static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 						 struct cgroup *cgrp,
 						 struct scx_sched *parent)
@@ -6362,8 +6366,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	s32 node, cpu, ret, bypass_fail_cpu = nr_cpu_ids;
 
 	sch = kzalloc_flex(*sch, ancestors, level);
-	if (!sch)
-		return ERR_PTR(-ENOMEM);
+	if (!sch) {
+		ret = -ENOMEM;
+		goto err_put_cgrp;
+	}
 
 	sch->exit_info = alloc_exit_info(ops->exit_dump_len);
 	if (!sch->exit_info) {
@@ -6468,8 +6474,8 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 		ret = kobject_init_and_add(&sch->kobj, &scx_ktype, NULL, "root");
 
 	if (ret < 0) {
-		kfree(sch->cgrp_path);
-		goto err_stop_helper;
+		kobject_put(&sch->kobj);
+		return ERR_PTR(ret);
 	}
 
 	if (ops->sub_attach) {
@@ -6479,11 +6485,12 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 			return ERR_PTR(-ENOMEM);
 		}
 	}
-
 #else	/* CONFIG_EXT_SUB_SCHED */
 	ret = kobject_init_and_add(&sch->kobj, &scx_ktype, NULL, "root");
-	if (ret < 0)
-		goto err_stop_helper;
+	if (ret < 0) {
+		kobject_put(&sch->kobj);
+		return ERR_PTR(ret);
+	}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 	return sch;
 
@@ -6506,6 +6513,8 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	free_exit_info(sch->exit_info);
 err_free_sch:
 	kfree(sch);
+err_put_cgrp:
+	cgroup_put(cgrp);
 	return ERR_PTR(ret);
 }
 
@@ -6577,6 +6586,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 {
 	struct scx_enable_cmd *cmd = container_of(work, struct scx_enable_cmd, work);
 	struct sched_ext_ops *ops = cmd->ops;
+	struct cgroup *cgrp = root_cgroup();
 	struct scx_sched *sch;
 	struct scx_task_iter sti;
 	struct task_struct *p;
@@ -6593,7 +6603,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	if (ret)
 		goto err_unlock;
 
-	sch = scx_alloc_and_add_sched(ops, root_cgroup(), NULL);
+	cgroup_get(cgrp);
+	sch = scx_alloc_and_add_sched(ops, cgrp, NULL);
 	if (IS_ERR(sch)) {
 		ret = PTR_ERR(sch);
 		goto err_free_ksyncs;
@@ -6887,11 +6898,12 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 	kobject_get(&parent->kobj);
 	raw_spin_unlock_irq(&scx_sched_lock);
 
+	/* scx_alloc_and_add_sched() consumes @cgrp whether it succeeds or not */
 	sch = scx_alloc_and_add_sched(ops, cgrp, parent);
 	kobject_put(&parent->kobj);
 	if (IS_ERR(sch)) {
 		ret = PTR_ERR(sch);
-		goto out_put_cgrp;
+		goto out_unlock;
 	}
 
 	ret = scx_link_sched(sch);
-- 
2.53.0

