Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4FF387374;
	Fri,  3 Jul 2026 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065745; cv=none; b=jPTRtbe4/qOBb/BOzleNBsZpZXE37Z7uDm+6pp5DvJ0XyHnGE/d774P26JHsuWMEx4Uccyl4wjaq74oMHGT1Lv4yk8EaDAozv57jxboS9CJZMugbyiM0cv+YzAe6R6TjkVOTMoFxtxjhSmaAo2ZWkdh57dyekGIAL+wdpflOR88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065745; c=relaxed/simple;
	bh=9qoVWaXiW5+USfQYXcJnXeXdCEFBLt6sN7BCGgfxqCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxB51ruA4MkeT6LPyzMr70uCGNTr4FceFkENKId/hT8Bu9mpbntNX3utxPkIMl7wmq8TWeQJbXnwXt0Oo6MjfGUnAn8GN7a8BgNr83d1xOmGLdJ55KI0IlNbJEuII28Vc0kEnsihWFVCa/1BBl4XC+JS6Gjcy/UWQA8PwZQaDYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pdk2ZFcs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pdk2ZFcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768CA1F00A3D;
	Fri,  3 Jul 2026 08:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065743;
	bh=xaFwfUJfeAZVtcnCXA8SUAp6m8Zk89XQ65ZLG0r0+/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pdk2ZFcs0eb/pG1hsMww4CR4T2du8ayWUVZrUrfG7S+qCYMqv4MaSdp8RwkT190yB
	 Yu1FHYHkVvWdq9IYUFZ0hIkeIQs8SFDWBw0FDywOaRDIyxmcvnJFXmULfpSgmA04/1
	 8JqtPNgGcTlhzqF2/2QBEYA5wGaxFUNSgvVhVU8ptdlP8FKMn6lZqLhhLtdk8uVhEA
	 Q+JEQLmsanGYEdbWdIBrlcOOP44BZFrrRv6N4HvHkqJV/urTiWnthWd4CAjxY2RiXF
	 42T7mlnQxM57C//aMPj0tTy5F++WeKc2+ms+t5gAZDxpoHa+E6t5us/y/oCFMDQH2j
	 jz3QUDMgxiITA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3 23/32] sched_ext: Assign a unique id to each scheduler instance
Date: Thu,  2 Jul 2026 22:01:50 -1000
Message-ID: <20260703080159.2314350-24-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703080159.2314350-1-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
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
index 9309d57e3f4f..7d4fd4e9d5a4 100644
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
@@ -6447,6 +6450,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		       level * sizeof(parent->ancestors[0]));
 	sch->ancestors[level] = sch;
 	sch->level = level;
+	sch->id = atomic64_inc_return(&scx_sched_id_cursor);
 
 	if (ops->timeout_ms)
 		sch->watchdog_timeout = msecs_to_jiffies(ops->timeout_ms);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 20a1ffbe4c26..323c88835698 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1443,6 +1443,9 @@ struct scx_sched {
 
 	struct list_head	all;
 
+	/* unique instance id, monotonic and never reused */
+	u64			id;
+
 #ifdef CONFIG_EXT_SUB_SCHED
 	struct rhash_head	hash_node;
 
-- 
2.54.0

