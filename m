Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17454404BE7;
	Wed,  8 Jul 2026 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545907; cv=none; b=msYGfkG9wJoLN9gEDdd0fHkIf45eLcRL+Lcy4+kitOUGn+JGq05mT0+Q1VZY5yD6ImE1WHcws4lPFe1nz8Nec9u1caj0GtEEqdF2f7aT3MbOT44+W0porGbtavBujQNR98xq5vQ14QxyjVhe91dOuzuDqu4uRhq1ADmNpipe1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545907; c=relaxed/simple;
	bh=GX/ljjyZs9qPxqgiEvc8ujI8j1HW9Fd4VWCkf1ajgO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lnj1KchnEk8Lr5EKZFG6Aj9nnCRpjzkQLLGbYy3ujQCbXsmDLcrMSaWzJl6rYVc1KFdAPPQ9HGFTbqQTlV0Z4C8SqgqaWMJrdH1CsJsRBFK2iTVVk/7UQeGyWpwUOeXsQ5tmyKMSbe7+izbtn4oNBSTMwI0ksurnCpzY0+4iZy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2Bh7lcN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2Bh7lcN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C228D1F00A3A;
	Wed,  8 Jul 2026 21:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545906;
	bh=F+2wSPwW7n5iBB0gaRDd6UIi4Zs2mjBszoEIwi/bQu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2Bh7lcNgisvBBbRsepmeqYgg25Z3a1fXh2/qKWz7EzXGyXT/cAZAuTvs9aJccMEZ
	 iqHQf3etybQkGnZ05JgbGLweQlELoRRD7TAIrD89cRWjhuuTebQ79HmR44t/7HiqjM
	 PKaZxTm1vKlk39+cvOPbeMuA2PqUyyxvYPUu/fBsBRWgbyTurg4dqe8vhdDYnYNaXb
	 LZxzPoMOw/DMt77bhjkKPew/JKOQuj/D6qIcYIwSF8fqhYCJ6vMdFl6g0nsmyokRTp
	 jdXdt3vudpfD2tFGxpjvUE2kqLyU5LnQxi8vukuxhuvQEpJTmUQpyjYO3EsR2mmPKo
	 9r39k/AJezGSw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 32/40] sched_ext: Add the SCX_CAP_ENQ cap
Date: Wed,  8 Jul 2026 11:24:21 -1000
Message-ID: <20260708212429.3405787-33-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708212429.3405787-1-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
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
index 202760edf4c2..3def65598b1b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4923,6 +4923,7 @@ SCX_ATTR(events);
 #ifdef CONFIG_EXT_SUB_SCHED
 static const char *scx_cap_names[__SCX_NR_CAPS] = {
 	[__SCX_CAP_ENQ_IMMED]	= "enq_immed",
+	[__SCX_CAP_ENQ]		= "enq",
 };
 
 static ssize_t scx_attr_caps_show(struct kobject *kobj,
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index bc27f9c6da05..a9b74ea87f16 100644
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
index e4c645dfbf7b..1d278c0d1602 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -106,18 +106,26 @@ static inline u64 scx_missing_caps(struct scx_sched *sch, s32 cpu, u64 needed)
 /* map @enq_flags to the SCX_CAP_* bit required for the local-DSQ insert */
 static inline u64 scx_caps_for_enq(u64 enq_flags)
 {
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
2.54.0

