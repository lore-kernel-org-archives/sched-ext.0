Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687030D40C;
	Sat,  1 Aug 2026 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574318; cv=none; b=hXwSWE7nlRQPApcrExVB0WkX8o38xbmACQW49vzdqGkTyxh/ChQY0dZmuNKz0onKzXRctAB9Me1/ORKe7gJ8KFC/2jNxihuI4rVMzG8nOBt6jwLLtyWXimWEKAcG5GTPZoeOyfJxJZdUsSW0fkw8RRKVJlRRqsQqhnrhMN6q69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574318; c=relaxed/simple;
	bh=XZONJ9lPw3tjNrlADzxNnhs9eSsq0/bISOFJn34AkFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZbZbw5KKvNfc3G5jmg2nVhi5DLim5RgVVATQsPKc6QJFqiMSnWxbYJz4xKgJsASG04n5GVfLxr0V6MCmEr6zgIhGEHo+60JStV0bj17NUc2c+D9WH6vD7XEOs+vYfSd5LfephupEkowFJ36rcgxWZo8XFoJCQT1PpM4/i///9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCmFKUNL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCmFKUNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843EA1F00ACF;
	Sat,  1 Aug 2026 08:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574316;
	bh=K/317PVlmAcvln/XpEI8ixcX2VntzmVKxKDHESAiE4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gCmFKUNLFZX/Qf4wzcUUHNZijDrinez4AVPXNGBTqQU70Fcd6AoZWOVgtsnOvlZcS
	 yVteCi5S9rGXw+Is3eTswMB4d8UmLj88e2X1hmut/aBZ8oYEnocW3jh1AN819FzSB0
	 fOFYFjuqqbsOA1jvf+j3AM2tdJfeT9+UK6C/fsaPaNm+tWBymjWt0ZMmiJBIcMXM3C
	 y2Nk7QfLHd0M7uSHDF7lGfXsliMyUTP90Cxca2fzVJerPP9Ah83DpRZqi1r1U7CPLF
	 7BSv6Uyyolr1oRjcSgzZregFG0somRs73QF6BmS265HsjIt7u77IUxHNe7Vk39bpDT
	 /cBR+LGELQV6A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/12] sched_ext: Make SCX_ENQ_IGNORE_CAPS waive the preemption cap too
Date: Fri, 31 Jul 2026 22:51:43 -1000
Message-ID: <20260801085150.2697653-6-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801085150.2697653-1-tj@kernel.org>
References: <20260801085150.2697653-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCX_ENQ_IGNORE_CAPS is kernel-internal and marks a placement the kernel
forces. scx_caps_for_enq() waives the enqueue cap for it, but a PREEMPT
insert still picks up the preemption cap requirement from
scx_caps_for_preempt(). Update scx_caps_for_preempt() to take enq_flags and
require nothing when SCX_ENQ_IGNORE_CAPS is set.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 5 +++--
 kernel/sched/ext/sub.c | 2 +-
 kernel/sched/ext/sub.h | 9 ++++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 028cfbcd1314..bf1f9f4d0847 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8149,8 +8149,9 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	if (kickable && !scx_missing_caps(pcpu->sch, cpu, SCX_CAP_BASE)) {
 		if (cpumask_test_cpu(cpu, pcpu->cpus_to_preempt)) {
 			if (cur_class == &ext_sched_class) {
-				if (likely(!scx_missing_caps(pcpu->sch, cpu,
-							     scx_caps_for_preempt(pcpu->sch, rq))))
+				u64 caps = scx_caps_for_preempt(pcpu->sch, rq, 0);
+
+				if (likely(!scx_missing_caps(pcpu->sch, cpu, caps)))
 					scx_set_task_slice(rq->curr, 0);
 				else
 					__scx_add_event(pcpu->sch,
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 2ea9a690e986..c30f48ee07f9 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -262,7 +262,7 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
 	 * @p's owner (@sch). Check caps against the scheduling sched.
 	 */
 	if (*enq_flags & SCX_ENQ_PREEMPT)
-		needed |= scx_caps_for_preempt(asch, rq);
+		needed |= scx_caps_for_preempt(asch, rq, *enq_flags);
 	missing = scx_missing_caps(asch, cpu_of(rq), needed);
 
 	/* requirements met */
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index db449559bbe8..fe1d82e6c1d5 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -140,7 +140,7 @@ static inline u64 scx_missing_caps(struct scx_sched *sch, s32 cpu, u64 needed)
 static inline u64 scx_caps_for_enq(u64 enq_flags)
 {
 	/* a restored task must be put into the local DSQ regardless of caps */
-	if (enq_flags & SCX_ENQ_IGNORE_CAPS)
+	if (unlikely(enq_flags & SCX_ENQ_IGNORE_CAPS))
 		return 0;
 	if (enq_flags & SCX_ENQ_IMMED)
 		return SCX_CAP_ENQ_IMMED;
@@ -156,10 +156,13 @@ static inline u64 scx_caps_for_task(struct task_struct *p)
 }
 
 /* the cap @sch needs to preempt @rq's current task, 0 if none */
-static inline u64 scx_caps_for_preempt(struct scx_sched *sch, struct rq *rq)
+static inline u64 scx_caps_for_preempt(struct scx_sched *sch, struct rq *rq, u64 enq_flags)
 {
 	struct task_struct *curr = rq->curr;
 
+	/* a kernel-forced placement preempts regardless of caps */
+	if (unlikely(enq_flags & SCX_ENQ_IGNORE_CAPS))
+		return 0;
 	/* a non-ext task can't be preempted by ext, own-subtree needs no cap */
 	if (curr->sched_class != &ext_sched_class ||
 	    scx_is_descendant(scx_task_sched(curr), sch))
@@ -195,7 +198,7 @@ static inline bool scx_task_can_stay_on_cpu(struct rq *rq, struct task_struct *p
 #else	/* CONFIG_EXT_SUB_SCHED */
 
 static inline u64 scx_missing_caps(struct scx_sched *sch, s32 cpu, u64 needed) { return 0; }
-static inline u64 scx_caps_for_preempt(struct scx_sched *sch, struct rq *rq) { return 0; }
+static inline u64 scx_caps_for_preempt(struct scx_sched *sch, struct rq *rq, u64 enq_flags) { return 0; }
 static inline bool scx_task_can_stay_on_cpu(struct rq *rq, struct task_struct *p) { return true; }
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
-- 
2.55.0

