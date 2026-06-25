Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F92F25E4;
	Thu, 25 Jun 2026 23:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782429839; cv=none; b=PM4SfrdU6LumENHR0wz/SzAS6MZ9KP/aVO9nLYMTtEy+/HJyoWnOIfA35HVWDYsv+fS2aG/yTpb5T+OKRZG26giNvK1rt4lk7gsgL9HTCyjePia78lFI76y5oAUKFbe7J6dE8bl4Stg7xM6n7nTNmyNJMkEhT5kIyVLEszLeVPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782429839; c=relaxed/simple;
	bh=qEPHRmxHAN74XEDLyEyK+6YP/yqB0JveOsbDAT+bryU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6JGYSu2sMkAaJm3CkC/X0RcSnrTC4aKey84a9qaSNriN3Ld0KUzuhMBHrtXfKu0iMUx7nq24KKJG9Z/cJKTGaHtI61Bw+Zhe8H6cgwTI3/k2rzZI3f4xZvOtey53sTpcFzRg44ulIzqDGLiITsLeFoZSgc+e59U7NWRsgkJBro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUp181D+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUp181D+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F93A1F000E9;
	Thu, 25 Jun 2026 23:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782429837;
	bh=nE+viarz/pTHbQcDnhYHvhgTQ044nlTFtRXJMtPtn50=;
	h=From:To:Cc:Subject:Date;
	b=DUp181D+GMOYiTYGJy9aQMXAuWZkzOdY/YhLunrHH7J2uRb8k9L81BQCdyjoh2iit
	 7UM2fIjsFy3u7wj6DY7OYaQcpe1ACHjeCJPKATk2JUJpj0TgaEotwtLFL0O+n+bs8h
	 pKVMaNECofYmd+2J9xT3/Jp3rzAfl68p2RpWFEWP8AfHSS7ofGXv1txFiwx4GYF8hN
	 8vXkJFj/0PhCEneKuVjkZh/118uvodaIkVvXZGKQ3/IIB0c9lJLkiiZ7gSe3jaKTPN
	 LRwltD196FUxEsbt0TycCfr06Ib7DNIGqlIeXQ0U1tWR2n7zuag7LWFlyefrecWxt0
	 G3xSlgML6dfkQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Pin parent scx_sched across a child sub-scheduler's lifetime
Date: Thu, 25 Jun 2026 13:23:56 -1000
Message-ID: <20260625232356.3801838-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A child sub-scheduler dereferences its parent scx_sched throughout its life,
e.g., in scx_sub_disable() which reparents the child's tasks and calls
parent->ops.sub_detach() after unlinking from the parent. However, the
parent is pinned only through parent->sub_kset, which is dropped during
disable. The parent scx_sched can be RCU-freed while a child is still
disabling.

Take a direct reference on the parent in scx_alloc_and_add_sched(), dropped
in scx_sched_free_rcu_work(), so a parent always outlives its descendants.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index aecbb021d6d7..3b2e13bc924b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4916,6 +4916,8 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 		cgroup_put(sch_cgroup(sch));
 	if (sch->sub_kset)
 		kobject_put(&sch->sub_kset->kobj);
+	if (scx_parent(sch))
+		kobject_put(&scx_parent(sch)->kobj);
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
 	for_each_possible_cpu(cpu) {
@@ -6863,12 +6865,19 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 	INIT_LIST_HEAD(&sch->children);
 	INIT_LIST_HEAD(&sch->sibling);
 
-	if (parent)
+	if (parent) {
+		/*
+		 * Pin @parent for @sch's lifetime. The kobject hierarchy pins
+		 * it only via @parent->sub_kset, which is dropped during
+		 * disable. Released in scx_sched_free_rcu_work().
+		 */
+		kobject_get(&parent->kobj);
 		ret = kobject_init_and_add(&sch->kobj, &scx_ktype,
 					   &parent->sub_kset->kobj,
 					   "sub-%llu", cgroup_id(cgrp));
-	else
+	} else {
 		ret = kobject_init_and_add(&sch->kobj, &scx_ktype, NULL, "root");
+	}
 
 	if (ret < 0) {
 		RCU_INIT_POINTER(ops->priv, NULL);
-- 
2.54.0

