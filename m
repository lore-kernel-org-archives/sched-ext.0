Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F10363C45;
	Mon, 11 May 2026 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541505; cv=none; b=uUD80UL8JIuU/KBm2JylUqxbvUZvaIbHNNa76u5rGiHNmvs4iSK8iTPW/1oLTVadfLiyWb2twRQ8qD3tT2ecXhyIY01NARks6N9m7u6Uy8TmNEDSqKLZgAYk3tIgojH8qgFQMH2KYvQJ+nDHX5BXp9FzWMSOSvdYQ0SFm0pCp7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541505; c=relaxed/simple;
	bh=+RNmqH8Zuj3H8HpYBh+xX3Zaxgog3/zsKp8uEGabjfA=;
	h=Date:Message-ID:From:To:Cc:Subject; b=TcWTeH5kH2js+iU1nWA3B+PGLMZw7tUTiB4Ywh+b4iSlEKmnFfsCldm6pDRgIbWRLFDYjRUEJN0ZLhpm/xBQfUoHuPjN1xK3mUDEIOQH8fBZKyRCmBKwa6M/zmPJ8OZhjMbpGRxLmWxx1+kBJ4rU+OsTG6km2GeYXM+wUdApuhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jua4TzZA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jua4TzZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717EAC2BCB0;
	Mon, 11 May 2026 23:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778541504;
	bh=+RNmqH8Zuj3H8HpYBh+xX3Zaxgog3/zsKp8uEGabjfA=;
	h=Date:From:To:Cc:Subject:From;
	b=jua4TzZAhB7EpxGOm3iCIfJ9UqDIw/Krlv0XYcKI2zginLwIi9nAoI9rrtQIKpHrU
	 PlH7aagrpNsgVQq7XW7oP8iJoumGfPEGta3ZObKc1sjQVpoojc90vUZu9d92jePeUP
	 s82bEn33iFEn0j3mH5P2jKDpoEfNuW3WgBc7B3eCdlp6R5RG8f6hWgBPDZSbj82F1Q
	 V9YF+HNqJZCvKAlNk4FC1WZXeIIwCkw4VQKMSuh7Glyb0kuGpeqnkWJAt1jy8fNiYb
	 QTykbDnF/3QO0N/WwxfFFziQhG9nnsoZaDfzoCfosg2LLvA0OgdGoAoj1I+4uA/GpV
	 JOKZTllz0uF+w==
Date: Mon, 11 May 2026 13:18:23 -1000
Message-ID: <2f2b7481ef217ad89c5d90fd56fc0c01@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Defer sub_kset base put
 to scx_sched_free_rcu_work
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_sub_enable_workfn() pins parent->kobj before dropping scx_sched_lock,
but that does not pin parent->sub_kset. Concurrent disable can
kset_unregister and free sub_kset before scx_alloc_and_add_sched()
dereferences it.

Split sub_kset teardown: kobject_del() at disable keeps sysfs removal; defer
kobject_put() to scx_sched_free_rcu_work so the memory survives. A racing
child sees state_in_sysfs=0 with valid memory, sysfs_create_dir() fails, and
the existing exit_kind gate in scx_link_sched() turns it away with -ENOENT.

Fixes: 411d3ef1a705 ("sched_ext: Unregister sub_kset on scheduler disable")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1fb3329ae2b4..e18c0abbc575 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4829,6 +4829,8 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	kfree(sch->cgrp_path);
 	if (sch_cgroup(sch))
 		cgroup_put(sch_cgroup(sch));
+	if (sch->sub_kset)
+		kobject_put(&sch->sub_kset->kobj);
 #endif	/* CONFIG_EXT_SUB_SCHED */

 	for_each_possible_cpu(cpu) {
@@ -5869,7 +5871,7 @@ static void scx_sub_disable(struct scx_sched *sch)
 	if (sch->ops.exit)
 		SCX_CALL_OP(sch, exit, NULL, sch->exit_info);
 	if (sch->sub_kset)
-		kset_unregister(sch->sub_kset);
+		kobject_del(&sch->sub_kset->kobj);
 	kobject_del(&sch->kobj);
 }
 #else	/* CONFIG_EXT_SUB_SCHED */
@@ -6003,7 +6005,7 @@ static void scx_root_disable(struct scx_sched *sch)
 	 */
 #ifdef CONFIG_EXT_SUB_SCHED
 	if (sch->sub_kset)
-		kset_unregister(sch->sub_kset);
+		kobject_del(&sch->sub_kset->kobj);
 #endif
 	kobject_del(&sch->kobj);

