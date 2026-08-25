Received: from mta1.migadu.com (out-119.mta1.migadu.com [95.215.58.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653FA2F8E87
	for <sched-ext@lists.linux.dev>; Tue, 25 Aug 2026 02:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625411; cv=none; b=hYwBLUVDwjJDFHP+2uRyRYcGmFJJaIUnFX8EOPhQf1TDgGnScDlWXzSOkNnm7F4RWdFBbB43zHWQC+oy7TVrRSOh9yI7OxSchQpXadUarA/CLU1OMNnxSvoWbacDp3+cKlPXlbtymX4nBNnpBUTKyoRsfaTsZpEJ6ZtyfJYXdBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625411; c=relaxed/simple;
	bh=kQYD7IQyAYV/gcw5kEmzhLPfEyEbr9orpZ++l7MzIcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SF1hCc6esc3bYnBpf/I6uP3gJT8tLV1l8HiUfp6sI1eQHcWQCBOtuWUkOyvR5C8Bz34mzwgi5wusSEQTDFHc6RuJ5cC2gXsJ4PkkEZV9jDwsyc5O9ZBXcxthmh346h2/NsN/g5DyDVPlwOvgcgJJd7Rg8ajL0zmmvvZ0r5nBNIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MRgN9g5w; arc=none smtp.client-ip=95.215.58.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MRgN9g5w"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=kQYD7IQyAYV/gcw5kEmzhLPfEyEbr9orpZ++l7MzIcg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787625408; v=1; x=1788230208;
 b=MRgN9g5wT/LEtXCkkOu1HasVY2QjD0ioOzsnWVpjrnNzN7h6CoblzDM/b9WrwbFubevuuGWe
 RM+jXNlzem1vLmNS0hZ9VIC4oi8HEwRZpM93l2BSwFYR8w6kddAb1lLlqNFGPpo/6HY8fXk4P1m
 7k4THW+/CCwq2Zy4BiEeLhYg=
X-Envelope-To: sched-ext@lists.linux.dev
Received: from ctao-book.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id eaf90f4b94f5b259;
	Tue, 25 Aug 2026 02:36:48 +0000
X-Mizu-Trace-ID: eaf90f4b94f5b259
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: changwoo@igalia.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v3 2/2] sched_ext: rename tg->scx.idle to tg->scx.sched_idle
Date: Tue, 25 Aug 2026 10:35:57 +0800
Message-ID: <20260825023557.27881-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825023557.27881-1-cui.tao@linux.dev>
References: <20260825023557.27881-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

A bare "idle" reads as CPU idle state in sched_ext (ops.update_idle(),
idle cpumasks, scx_bpf_pick_idle_cpu()). cpu.idle is the cgroup analog
of the SCHED_IDLE policy, so name the task_group field sched_idle to
match scx_cgroup_init_args.sched_idle.

Pure rename, no behavior change.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 include/linux/sched/ext.h | 2 +-
 kernel/sched/ext/ext.c    | 8 ++++----
 kernel/sched/ext/sub.c    | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 582d7cd4a983..7b9cdb65deef 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -323,7 +323,7 @@ struct scx_task_group {
 	u64			bw_period_us;
 	u64			bw_quota_us;
 	u64			bw_burst_us;
-	bool			idle;
+	bool			sched_idle;
 #endif
 };
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 82cf8f57e15c..4a9c38297093 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4682,7 +4682,7 @@ void scx_tg_init(struct task_group *tg)
 	tg->scx.weight = CGROUP_WEIGHT_DFL;
 	tg->scx.bw_period_us = default_bw_period_us();
 	tg->scx.bw_quota_us = RUNTIME_INF;
-	tg->scx.idle = false;
+	tg->scx.sched_idle = false;
 }
 
 /**
@@ -4765,7 +4765,7 @@ int scx_tg_online(struct task_group *tg)
 				  .bw_period_us = tg->scx.bw_period_us,
 				  .bw_quota_us = tg->scx.bw_quota_us,
 				  .bw_burst_us = tg->scx.bw_burst_us,
-				  .sched_idle = tg->scx.idle };
+				  .sched_idle = tg->scx.sched_idle };
 
 			ret = SCX_CALL_OP_RET(sch, cgroup_init,
 					      NULL, tg->css.cgroup, &args);
@@ -4935,7 +4935,7 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
 		SCX_CALL_OP(sch, cgroup_set_idle, NULL, tg_cgrp(tg), idle);
 
 	/* Update the task group's idle state */
-	tg->scx.idle = idle;
+	tg->scx.sched_idle = idle;
 
 	percpu_up_read(&scx_cgroup_ops_rwsem);
 }
@@ -5186,7 +5186,7 @@ static int scx_cgroup_init(struct scx_sched *sch)
 				.bw_period_us = tg->scx.bw_period_us,
 				.bw_quota_us = tg->scx.bw_quota_us,
 				.bw_burst_us = tg->scx.bw_burst_us,
-				.sched_idle = tg->scx.idle,
+				.sched_idle = tg->scx.sched_idle,
 			};
 
 			ret = SCX_CALL_OP_RET(sch, cgroup_init, NULL, css->cgroup, &args);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 385302d19914..a17d84db93bd 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1361,7 +1361,7 @@ static s32 scx_cgroup_claim_subtree(struct scx_sched *sch)
 			.bw_period_us = tg->scx.bw_period_us,
 			.bw_quota_us = tg->scx.bw_quota_us,
 			.bw_burst_us = tg->scx.bw_burst_us,
-			.sched_idle = tg->scx.idle,
+			.sched_idle = tg->scx.sched_idle,
 		};
 
 		if (tg->scx.sched != parent ||
@@ -1465,7 +1465,7 @@ static void scx_cgroup_return_subtree(struct scx_sched *sch)
 			.bw_period_us = tg->scx.bw_period_us,
 			.bw_quota_us = tg->scx.bw_quota_us,
 			.bw_burst_us = tg->scx.bw_burst_us,
-			.sched_idle = tg->scx.idle,
+			.sched_idle = tg->scx.sched_idle,
 		};
 
 		/* the first pass must have transferred everything */
-- 
2.43.0

