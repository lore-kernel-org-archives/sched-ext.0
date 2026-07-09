Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2319A3E0C55;
	Thu,  9 Jul 2026 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637467; cv=none; b=uZ92BNkb1YXtGqqvl4lMnX2GKwZo1ZUqm8E9B3DFIHTznn5m782MlAsAkSukh0avTg5lIzuzD/rDyuGQrqVXD9C7B374O8I418bTzO6PwsSZpYJpNE2G6y6CKiMQw+yermzwK8EqQS74XLhVQkSSpax2avgDkqkJR/E/NrsQJQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637467; c=relaxed/simple;
	bh=bpUcsNHgr0D9Y4CQxg3ipj95hidCPtzowXQmG635p6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaZn3RxC/hPnMLAzLFPFIzBKDG0uDKAvBWfRH6Yy/j6xlcXAFyoeOH7jFQ57DW5bd3xT09e+okt/yXp3uPzjxqFD2mEk2tKaeRPJUBbWBIsNg2IbNKy1QadsQtVFSCGn/XhChdVcnx2O1Irq72Ip2oCo3q6Pap3Z70bONUhOdn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLAxAPad; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLAxAPad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6621F00A3D;
	Thu,  9 Jul 2026 22:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637465;
	bh=NqiF85oqwkWhGUy2CBua/r+Ht6pqGN2+Y8b9quD6l+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NLAxAPad0nH42G2Ac5n4jz+EaDGriSdY8GUlOOFSLS2yt33dVjqGWQB+APN/YbdZi
	 qJcPinkKppE0HTDSmIFEhXCKoJU06LVUqDWgc1zUylxYEwUy1R/FiWrjRGPDZGMXcj
	 2EVxHDCtKtFsoSzGOp7taW0zLta1H5JJk4KN+cvwPLTJGfvojWEAbQOxfLpwNMsMG2
	 qwL55gjQXudBY2bGOHd1I5LYpPkUfCARwXeYYVgd8VyWY9V8+/rQaU7MtkG6Nc/q3T
	 c61W38uaE/2xV2Pa+w9kwqyIwZ37bqiDXJWtBTcQhZscTUBVEN75PhFpLXPq6/dATv
	 KwVpJkRWWBJqg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 sched_ext/for-7.3 21/33] sched_ext: Assign a unique id to each scheduler instance
Date: Thu,  9 Jul 2026 12:50:29 -1000
Message-ID: <20260709225041.1695495-22-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709225041.1695495-1-tj@kernel.org>
References: <20260709225041.1695495-1-tj@kernel.org>
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
index 54ba5b57f283..0efb396de008 100644
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
@@ -6500,6 +6503,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		       level * sizeof(parent->ancestors[0]));
 	sch->ancestors[level] = sch;
 	sch->level = level;
+	sch->id = atomic64_inc_return(&scx_sched_id_cursor);
 
 	if (ops->timeout_ms)
 		sch->watchdog_timeout = msecs_to_jiffies(ops->timeout_ms);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index e735812e77a5..ad98e3469b12 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1445,6 +1445,9 @@ struct scx_sched {
 
 	struct list_head	all;
 
+	/* unique instance id, monotonic and never reused */
+	u64			id;
+
 #ifdef CONFIG_EXT_SUB_SCHED
 	struct rhash_head	hash_node;
 
-- 
2.55.0

