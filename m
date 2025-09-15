Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F1B214236;
	Mon, 15 Sep 2025 06:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919183; cv=none; b=XnN+CI7Xor1y3fvGrwbXihqoODoqzs4DP/HE5Nps0rfeJlqtM6nbmvwrUg9TzQZx9umTFcpZuODSk99jWsyXHDnwHHo8O0vCQ6Bf/Fh5TEc84TjwTpmArpZCXUa/RLtyay0YKs93gKLuWVlAehybSUDUhwOsu2tOUJ/T1nWP34o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919183; c=relaxed/simple;
	bh=eTnWsuowkvPW2CNQFBCtuWekj/ZUpGVr6DjRo9OXlfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJBlowtOTwzTHRaTYji92Y0qGhl+ySdTCFMUMv2zjxvRpb6/kgHZw02wdvdCyMErrbeSWUkhDT9YLFUSyK3d5pSFfi2BI53sCTD32LF3nDIe3JFY77fp7zjg3FDC+FLTffqmxz+CNmPFpNOOFAamWk5YX/qOSpf2YVLCtKvG3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WZ7sEzKM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WZ7sEzKM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nMOQLJiy/VsypA3JP622mRkwPrLWm4CPv8lTuG2ajGo=; b=WZ7sEzKMymJToveqY1HimB8gtz
	NRFIp1vT2UPG23kqeRIBpvHcPJpGX294RPEQ0NcagF5dljOx2qAtIcotTaW/k8yGNPc6P/deiSG0O
	IG3C9rLh/afB3I9LGN6HrOQ9ZT5Ygz4mW4sRaJf+RCpqU8Buq871mLHWigy/XeaDCYmVXbrWkMskd
	q1/fQ66/4jnB9uMpJZ+JYiTCwFn070kTX9uPdqj47hTXrcMq4ddam/mcUUZhGjOQrcUkl4YcV7Lp6
	g7YL4WU9xOtx8BA0n0CTeArpxMHduXl+cAVtS3TLsEIUTgUcImT1/xyVuQJZUY++NSB3DeTbq3ZDG
	eghamXNA==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uy34t-00Bgzm-UV; Mon, 15 Sep 2025 08:52:44 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH] sched_ext: allow scx_bpf_task_cgroup() in ops.dispatch()
Date: Mon, 15 Sep 2025 15:52:36 +0900
Message-ID: <20250915065236.13669-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling scx_bpf_task_cgroup() on the prev task from ops.dispatch()
currently triggers a runtime error:

------
CodecWorker[92989] triggered exit kind 1024:
  runtime error (called on a task not being operated on)

Backtrace:
  scx_bpf_task_cgroup+0xbb/0xd0
  bpf_prog_d7d2e9d404cf3602_lavd_dispatch+0xc45/0xccc
  bpf__sched_ext_ops_dispatch+0x4b/0xab
  balance_one+0x25f/0x550
  balance_scx+0x37/0x160
  prev_balance+0x46/0xb0
  __schedule+0x702/0x23d0
  schedule+0x27/0xd0
  irqentry_exit_to_user_mode+0x1ac/0x200
  asm_sysvec_apic_timer_interrupt+0x1a/0x20
------

This happens because the prev task is not registered as a task argument
of ops.dispatch(). As a result, scx_kf_allowed_on_arg_tasks() rejects
scx_bpf_task_cgroup() calls on the prev task.

Fix this by adding the prev task to scx.kf_tasks so that task-related
BPF helpers such as scx_bpf_task_cgroup() can be called safely. Since
the SCX_CALL_OP_TASK family assumes the first argument is the task,
introduce a new SCX_CALL_OP_TASK_ANY macro without that restriction.
Also update __SCX_KF_TERMINAL to include SCX_KF_DISPATCH.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 include/linux/sched/ext.h |  3 ++-
 kernel/sched/ext.c        | 13 +++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 7047101dbf58..b404a93d371c 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -116,7 +116,8 @@ enum scx_kf_mask {
 
 	__SCX_KF_RQ_LOCKED	= SCX_KF_CPU_RELEASE | SCX_KF_DISPATCH |
 				  SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
-	__SCX_KF_TERMINAL	= SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
+	__SCX_KF_TERMINAL	= SCX_KF_DISPATCH | SCX_KF_ENQUEUE |
+				  SCX_KF_SELECT_CPU | SCX_KF_REST,
 };
 
 enum scx_dsq_lnode_flags {
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3eb6be889da6..f704d2e5dce2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -328,6 +328,14 @@ do {										\
 	__ret;									\
 })
 
+#define SCX_CALL_OP_TASK_ANY(sch, mask, op, rq, task, args...)			\
+do {										\
+	BUILD_BUG_ON((mask) & ~__SCX_KF_TERMINAL);				\
+	current->scx.kf_tasks[0] = task;					\
+	SCX_CALL_OP((sch), mask, op, rq, ##args);				\
+	current->scx.kf_tasks[0] = NULL;					\
+} while (0)
+
 /* @mask is constant, always inline to cull unnecessary branches */
 static __always_inline bool scx_kf_allowed(u32 mask)
 {
@@ -2105,8 +2113,9 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	do {
 		dspc->nr_tasks = 0;
 
-		SCX_CALL_OP(sch, SCX_KF_DISPATCH, dispatch, rq,
-			    cpu_of(rq), prev_on_scx ? prev : NULL);
+		SCX_CALL_OP_TASK_ANY(sch, SCX_KF_DISPATCH, dispatch, rq,
+				     prev_on_scx ? prev : NULL,
+				     cpu_of(rq), prev_on_scx ? prev : NULL);
 
 		flush_dispatch_buf(sch, rq);
 
-- 
2.51.0

