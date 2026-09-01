Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870C371887
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258179; cv=none; b=QMfAMKx+Zwtb09LrVNDbOovwAzyeK0n347pbiY4ch6b0/lBs8y+RrnsprNTvaRWXgsck1JgLCv/og6AW3FLaSa9NNleM88+8PORtKVROjdaMJ7d/Utv4qjNAW40NeGu0mkVgHqye0JK663Jj2t80AVQ3EfdCw95xp2PkStNXUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258179; c=relaxed/simple;
	bh=tulWFrcy/7BbVnCZiIQzDqCUf7cknANKSqC7DqdFLbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cpECJvogz7yfRXacNZfdrXIw0GBDn7ZYLgAoUUBRQ9pY6Ag/nrnu0P0rJ1n+B03Ik33CAi0TIK/68MvMQWi2APzm5FmWmzTSGM0T0USbG0ufPqc49Iizn/HxwutEvjuEh62ew9sBiwzESL4OTUrPtBqYUZ06z07rm4uUgAmTBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 173e8402a5ef11f19a56ed5b684f684d-20260901
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:46033c71-130e-4f38-ab2a-37c10c0fd8aa,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:9a999c7250a998c8676658c1631a269a,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 173e8402a5ef11f19a56ed5b684f684d-20260901
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1844356903; Tue, 01 Sep 2026 18:22:53 +0800
From: Qiurong Fang <fangqiurong@kylinos.cn>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev
Subject: [PATCH] sched_ext: Delete sub-scheduler kobjects before releasing scx_enable_mutex
Date: Tue,  1 Sep 2026 18:22:40 +0800
Message-Id: <20260901102240.2671888-1-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fangqiurong <fangqiurong@kylinos.cn>

The sub-scheduler disable path deletes the scheduler's kobjects after
releasing scx_enable_mutex, while the root path deletes them before
releasing it. A concurrent enable on the same cgroup can therefore hit
kobject_add() with the same "sub-%llu" name still in the hierarchy and
fail with -EEXIST, tearing down an otherwise healthy scheduler.

Move the two kobject_del() calls above mutex_unlock() to match the root
path.

Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
---
 kernel/sched/ext/sub.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index a17d84db93bd..1923e3023bff 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1631,6 +1631,12 @@ void scx_sub_disable(struct scx_sched *sch)
 
 	scx_unlink_sched(sch);
 
+	if (sch->sub_kset)
+		kobject_del(&sch->sub_kset->kobj);
+	/* not added if enable failed before scx_sched_sysfs_add() */
+	if (sch->kobj.state_in_sysfs)
+		kobject_del(&sch->kobj);
+
 	mutex_unlock(&scx_enable_mutex);
 
 	/*
@@ -1661,12 +1667,6 @@ void scx_sub_disable(struct scx_sched *sch)
 	 */
 	WRITE_ONCE(sch->dead, true);
 	synchronize_rcu();
-
-	if (sch->sub_kset)
-		kobject_del(&sch->sub_kset->kobj);
-	/* not added if enable failed before scx_sched_sysfs_add() */
-	if (sch->kobj.state_in_sysfs)
-		kobject_del(&sch->kobj);
 }
 
 /* verify that a scheduler can be attached to @cgrp and return the parent */
-- 
2.43.0

