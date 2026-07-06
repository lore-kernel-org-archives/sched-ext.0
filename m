Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D8388391;
	Mon,  6 Jul 2026 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302087; cv=none; b=kBuJIUi2odyvQ3+jbUcVYGsjgWaPWtyAgplIBL2o6g82au+nlG6MbQP7FJVvotZV7WsNtkRfLcQiiGKb9qyMW8pmddGSXdp7uG/g3R2V6Hnr5OHU11yjk4kwku0V76NMZshFvbrogkcowkODLhJq/33HuFgIGX6wxm3RZoGr68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302087; c=relaxed/simple;
	bh=1ptVYmPjoX6+oDr9Vhd4eEbG2L1QHW+WUTNS+LSJFqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajWlyIYGIKJsqTZWCuimdqSfjNN06q+u9MhT2Vnvqoy7IVcg9wbS+5pb+OpS2SVpb7pCsqEVZ/hEvyxA6FA14xFlrciXZHS0MFlUaNKwYf7Bj0bJPOYWLkCVCYJzcbFmYir2kbwrZqEqPU0g4wA+CoGAy76PL/chBYaGChIL/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfA+S41A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfA+S41A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB0E1F000E9;
	Mon,  6 Jul 2026 01:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302086;
	bh=ttRPdq3RpNnna60aHN2G2KjK1GqHkAkrHcfNU2sh+Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JfA+S41AYxwN5N8KyLvnKfLrHR5xNtHEepIwUIio29UZV0+oqiJ99nqOafm+oqfOj
	 iQV56T5jczQ3HMXQ3XRONHnHBpW5gLW3euZzFi8HCzH5zeG9UrdAzCAwjn9vRYtJQM
	 9GwEDCmTplhQx+v/MEfxEi63EjQ/HknAVDOziS0BHyTEQR+bkfKFT9vilPX3CoNGGt
	 hPscWp7qUQG+Tc5anjq0WU1T/gc7csWr354iWc+2wtmzDWu30k6PaOsiD5OmstS82R
	 kfhEZhHb7MtHQzDNAgxzZle3bzVXEOQ6jXEvzF6VEfp0hVS9qc4ZVEwGcbcycuY+5w
	 3GYCc75DRQ57Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 26/36] sched_ext: Assign a unique id to each scheduler instance
Date: Sun,  5 Jul 2026 15:40:48 -1000
Message-ID: <20260706014058.439853-27-tj@kernel.org>
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

Neither a scx_sched pointer nor its cgroup id uniquely identifies a
scheduler instance. A freed sched's memory can be reallocated, and a cgroup
can detach one sched and attach another. Add a monotonic, never-reused u64
id. A later patch compares it to drop a slice request that outlived a change
of a task's owning scheduler.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 4 ++++
 kernel/sched/ext/internal.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 796b857c7219..9fa4cfbc75c8 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -108,6 +108,9 @@ static bool dsq_is_rq_owned(struct scx_dispatch_q *dsq)
 	}
 }
 
+/* Cursor for unique scx_sched instance ids. id 0 is reserved. */
+static atomic64_t scx_sched_id_cursor = ATOMIC64_INIT(0);
+
 #ifdef CONFIG_EXT_SUB_SCHED
 /*
  * The sub sched being enabled. Used by scx_disable_and_exit_task() to exit
@@ -6442,6 +6445,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		       level * sizeof(parent->ancestors[0]));
 	sch->ancestors[level] = sch;
 	sch->level = level;
+	sch->id = atomic64_inc_return(&scx_sched_id_cursor);
 
 	if (ops->timeout_ms)
 		sch->watchdog_timeout = msecs_to_jiffies(ops->timeout_ms);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 5d4edd505ed1..0f3d98c19f7a 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1444,6 +1444,9 @@ struct scx_sched {
 
 	struct list_head	all;
 
+	/* unique instance id, monotonic and never reused */
+	u64			id;
+
 #ifdef CONFIG_EXT_SUB_SCHED
 	struct rhash_head	hash_node;
 
-- 
2.54.0

