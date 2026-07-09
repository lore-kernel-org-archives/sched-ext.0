Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A0F3E2AA1;
	Thu,  9 Jul 2026 22:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637472; cv=none; b=nXGf+8gFtGOT6Q9WndufbOV/loFlCyAIXNix135bayTmBxG4mGgA51SuwQ3wlJ0qkfs9uu6BT1NHP4G4MhXjOZiMO0eFACN68YJta5setbeyZ8ekxzoTCN0wdBdX4VL0ZvsPr50TR8ufIAHLUIvz19NvmY+2nw4Zgz6F4GN28m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637472; c=relaxed/simple;
	bh=EbYxgBWvx8mGNME+7eu5r1GD6SwIN6YjgqvTXet706g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFjAfF/Q8kNQmcfzd2RS7VAqqYchFIEzMjrhM/wh0ck3+qiQWhLN25U67OO3Y/EH6QNg/hvxzkvbOb6GJ6nYq3AvNghXDQTutFmFoToveozVWS8A1tPyf+NeMQgaFSaMFK++wOxey9HY9pWT9ssbqel0y7dKvSEWMqH+i+2FW0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBbhifEW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBbhifEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6111F00A3A;
	Thu,  9 Jul 2026 22:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637470;
	bh=b8m9o92jWu0rNUUnLC97PBxRDZa79KFOS36vIZK3k18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BBbhifEWO6r3QWnfG5k1rusdW69XvJpF51DY03hmCWSlOZiImJyKajKgjgqfWJdm2
	 C3LcssJ/YAJYOF4WKQji3S5A+umUftM5uWV2K3RWYzHdtqyh6xYu7BPtxS0xhdbQh5
	 LJHxx8Jx9IgFS8cuyD4vj2mUZWdBKfxuqpxs0ioXvbxPZxSPLXbHOewld7rKqf6iQf
	 7ooTdnj81WUQ20/1T3OjcWDW0xHSxqNcg2xeg1upx3wPHIQCGs3vr1Og6u5CBDtRsH
	 f7Rzo50YToznO4lWtJLKusNHduwaNXdSLqBG+GRrwMZG7Vy9XL3Ahy2JUG1wGnJ7xR
	 88SB5w316S7NQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 sched_ext/for-7.3 25/33] sched_ext: Add the SCX_CAP_ENQ cap
Date: Thu,  9 Jul 2026 12:50:33 -1000
Message-ID: <20260709225041.1695495-26-tj@kernel.org>
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

Add SCX_CAP_ENQ, which gates inserting tasks onto a cid's local DSQ. Unlike
IMMED enqueue, plain enqueues can pile up, so ENQ is the stronger cap and
implies ENQ_IMMED. Losing ENQ also triggers the reenq scan. The scan tests
each queued task and the running task against the cap each needs via
scx_caps_for_task(), so an ENQ-only loss reenqueues plain tasks, evicting a
running one, while IMMED tasks, which need only ENQ_IMMED, stay put.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |  1 +
 kernel/sched/ext/internal.h | 14 +++++++++++---
 kernel/sched/ext/sub.h      | 12 ++++++++++--
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ac1affa97567..5e99b2cca527 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4963,6 +4963,7 @@ SCX_ATTR(events);
 #ifdef CONFIG_EXT_SUB_SCHED
 static const char *scx_cap_names[__SCX_NR_CAPS] = {
 	[__SCX_CAP_ENQ_IMMED]	= "enq_immed",
+	[__SCX_CAP_ENQ]		= "enq",
 };
 
 static ssize_t scx_attr_caps_show(struct kobject *kobj,
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index ab1dfad28cb5..86f9db116a8e 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1224,8 +1224,8 @@ struct scx_sched_pcpu {
 	/*
 	 * pshard->caps[cap_bit] is the set of cids the sched holds that one
 	 * cap on. ecaps is its transpose: the set of SCX_CAP_* bits the sched
-	 * holds on this cpu, collected so that the hot-path check is a single
-	 * read.
+	 * effectively holds on this cpu, with implied caps folded in, so that
+	 * the hot-path check is a single read.
 	 *
 	 * While pshard->caps[] under pshard->lock is the target configuration,
 	 * ecaps is the effective copy owned by the cpu. It is written under the
@@ -1287,20 +1287,28 @@ struct scx_sched_pnode {
  * the allocation pattern.
  *
  * ENQ_IMMED  insert an IMMED task onto the cid's local DSQ
+ *
+ * ENQ        insert any task onto the cid's local DSQ (implies ENQ_IMMED)
+ *
+ * Implied caps apply to the holder's own use of a cid, not to delegation.
+ * scx_bpf_sub_grant() delegates literally-held caps, so a cap held only through
+ * implication is usable but cannot be re-delegated to a child.
  */
 enum scx_cap_flags {
 	__SCX_CAP_ENQ_IMMED		= 0,
+	__SCX_CAP_ENQ			= 1,
 
 	__SCX_NR_CAPS,
 	__SCX_CAP_ALL			= BIT_U64(__SCX_NR_CAPS) - 1,
 
 	SCX_CAP_ENQ_IMMED		= BIT_U64(__SCX_CAP_ENQ_IMMED),
+	SCX_CAP_ENQ			= BIT_U64(__SCX_CAP_ENQ),
 
 	/* alias for minimal cap to make any use of a cpu */
 	SCX_CAP_BASE			= SCX_CAP_ENQ_IMMED,
 
 	/* caps whose loss strands queued tasks, see scx_process_sync_ecaps() */
-	SCX_CAPS_REENQ_ON_LOSS		= SCX_CAP_ENQ_IMMED,
+	SCX_CAPS_REENQ_ON_LOSS		= SCX_CAP_ENQ_IMMED | SCX_CAP_ENQ,
 };
 
 #ifdef CONFIG_EXT_SUB_SCHED
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 8b11d93b712e..0d9d75558551 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -109,18 +109,26 @@ static inline u64 scx_caps_for_enq(u64 enq_flags)
 	/* a restored task must be put into the local DSQ regardless of caps */
 	if (enq_flags & SCX_ENQ_IGNORE_CAPS)
 		return 0;
-	return SCX_CAP_ENQ_IMMED;
+	if (enq_flags & SCX_ENQ_IMMED)
+		return SCX_CAP_ENQ_IMMED;
+	return SCX_CAP_ENQ;
 }
 
 /* map queued @p to the SCX_CAP_* bit required to stay on its local DSQ */
 static inline u64 scx_caps_for_task(struct task_struct *p)
 {
-	return SCX_CAP_ENQ_IMMED;
+	if (p->scx.flags & SCX_TASK_IMMED)
+		return SCX_CAP_ENQ_IMMED;
+	return SCX_CAP_ENQ;
 }
 
 /* caps implied by holding @cap */
 static inline u64 scx_caps_implied(u64 cap)
 {
+	switch (cap) {
+	case SCX_CAP_ENQ:
+		return SCX_CAP_ENQ_IMMED;
+	}
 	return 0;
 }
 
-- 
2.55.0

