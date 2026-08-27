Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A77F4195D0
	for <sched-ext@lists.linux.dev>; Thu, 27 Aug 2026 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822068; cv=none; b=h7Z144WpcuJGUeeauSP6d2cpdqVkHXMFLzhTo1wHWZUZUh1a2VaFonsP3gKsM16EqlOffg5/s4BC2Kl4xjW9XPqJoRB0QYntqUoSIheN/t/LYeqI11pW7zyvTdqfnJmeepSJEZS6hAErWas4yO2elZ45m7BHNrPf20DlEfMU6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822068; c=relaxed/simple;
	bh=IBwm0fJgU4UF1iFMHhZtfv1eT8Q6mg3+8CzVvU//wzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pwQlXixi10kq07OC+R/7WfTsPOtgwa1sHG+Wd2dyp3gxa5nxOXoxtp+m6nEir3XO88PRSVixHA2JW6hbxUMhhmH20tibhAcvek+zPft+R697XKw56/InP8F2Lzzz7/nuaw5aaN21BgrGTBFQAc079ReO35DIeZnHhlNcd/kHCQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ac1a386aa1f711f19a56ed5b684f684d-20260827
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f1ab915c-2a2a-494c-be83-5f2c8ccc64db,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:565fc58de3ad897ba33f44609da0daf8,BulkI
	D:nil,BulkQuantity:0,SF:102|136|865|898,TC:nil,Content:0|15|50,EDM:-3|-100
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ac1a386aa1f711f19a56ed5b684f684d-20260827
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1976401653; Thu, 27 Aug 2026 17:14:14 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Wanwu Li <liwanwu@kylinos.cn>
Subject: [PATCH] sched_ext: Fix several comment issues
Date: Thu, 27 Aug 2026 17:14:11 +0800
Message-Id: <20260827091411.973621-1-liwanwu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several comment issues found during review:
__setschduler_prio() -> __setscheduler_class()
scx_iter_scx_dsq_new() -> bpf_iter_scx_dsq_new()
scx_next_task_scx() -> set_next_task_scx()

Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
---
 kernel/sched/ext/ext.c      | 6 +++---
 kernel/sched/ext/internal.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10af28a9f2c0..5377a8a52ba0 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -876,7 +876,7 @@ struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter)
 		 * unloading. The init_tasks ("swappers") should be excluded
 		 * from the iteration because:
 		 *
-		 * - It's unsafe to use __setschduler_prio() on an init_task to
+		 * - It's unsafe to use __setscheduler_class() on an init_task to
 		 *   determine the sched_class to use as it won't preserve its
 		 *   idle_sched_class.
 		 *
@@ -5514,7 +5514,7 @@ static const struct kset_uevent_ops scx_uevent_ops = {
 };
 
 /*
- * Used by sched_fork() and __setscheduler_prio() to pick the matching
+ * Used by sched_fork() and __setscheduler_class() to pick the matching
  * sched_class. dl/rt are already handled.
  */
 bool task_should_scx(int policy)
@@ -9765,7 +9765,7 @@ __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *i
  * bpf_iter_scx_dsq_destroy - Destroy a DSQ iterator
  * @it: iterator to destroy
  *
- * Undo scx_iter_scx_dsq_new().
+ * Undo bpf_iter_scx_dsq_new().
  */
 __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
 {
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 27bbf5e04d90..5d31df2b265c 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -442,7 +442,7 @@ struct sched_ext_ops {
 	 *
 	 * Note that this callback may be called from a CPU other than the
 	 * one the task is going to run on. This can happen when a task
-	 * property is changed (i.e., affinity), since scx_next_task_scx(),
+	 * property is changed (i.e., affinity), since set_next_task_scx(),
 	 * which triggers this callback, may run on a CPU different from
 	 * the task's assigned CPU.
 	 *
-- 
2.25.1

