Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB523BD05;
	Tue,  7 Jul 2026 00:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383181; cv=none; b=Ob4rfSWDuqpeVDrATehixQYjD2wVLg+BU164gv5jNl4ugPM5X6NbnC7OP0/60PI8OeBcV7pbbiFPHpo6NaqWTRIFJh1jahpsHoNZNm95kaFaj/jxczjq5FiYKngclfQTnez/DgRJ5WCaNNkEBE3JbBPZIyNk55kdCLavIEslx0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383181; c=relaxed/simple;
	bh=IRy94cczU8C9VKTT2PKczzemQwbDXDgSovE0Tx65WLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsgMg3mf/CHsFo0gX9qNgFLQAhNCf8JKZq0WOtPHvE8FgGWHHasukZX0ZqvtsZ7SRCueriPicycNYV81ljywkg+MMIOUPY3FW4XvqdFcrDg6JSwoIMd7CqoMxbLvcmk8O21dC1TDJcbCWtoU3ckLyAPuNNz74Kr71PTbwamnJoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMs8MSSh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMs8MSSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7668F1F00A3D;
	Tue,  7 Jul 2026 00:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783383179;
	bh=sqvWpLLUe7QbIoGYcDprQBJMyJU1OJq8s1AF+w4ZnUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GMs8MSShbnnQJ2qkma26g1Vj+L0XhhV0qJgleF9bLNfEDiYawmecg/nlpzAOtYXMe
	 uSelCft7nN1pf0jwki8npqsdOSKz8XDcWcuXj0L8HeRcXc8flpREbWv6dYWU2AGduO
	 zC5Abq3xJ6BtfgqTlJI/yNX1gV2tK6cYNyrY/iYBguYHxtP9nJIvM26cW34pfcErUh
	 W1qn/r2u0QYBzmsWreS1lDDFPgQquE415qVdlGQG3T6838NTdjQ11GlDhFnaOLs5wU
	 XBTHGgHjoDWLZzj5S3nW8fIe8VRwKrOZ4Y7OfJZL5LrbPxDP4uVpUlCiYtGx8knNku
	 +PJ/iJ7RHF/uA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 sched_ext/for-7.3 30/36] sched_ext: Gate kicks on SCX_CAP_BASE and preemption on SCX_CAP_PREEMPT
Date: Mon,  6 Jul 2026 14:12:23 -1000
Message-ID: <20260707001229.1410929-31-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707001229.1410929-1-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A kick forces a scheduling event on the target cpu, and a preemption also
evicts the running task. Gate both on caps. Any kick requires baseline
access on the cid, and preempting a task the sub-sched does not own -
whether by a SCX_ENQ_PREEMPT insert or a SCX_KICK_PREEMPT kick - requires
the new SCX_CAP_PREEMPT. Gating either alone would leave a hole - the
weakest cap authorizing preempting kicks, or plain kicks disturbing cpus the
kicker has no access to.

Preempting the sched's own subtree is always allowed, and the cap extends
the right to any task on the cid. PREEMPT implies ENQ, and so ENQ_IMMED.

A preempting insert tests the running task under the target rq lock and is
rejected and reenqueued unless the victim is in the inserter's subtree or it
holds PREEMPT. A migration-disabled task is admitted regardless, but with
SCX_ENQ_PREEMPT stripped.

Kicks are enforced on the delivery path, where the effective caps can be
read coherently under the target rq's lock. A kick from a sub-sched lacking
SCX_CAP_BASE on the cid is dropped, and a SCX_KICK_PREEMPT kick without
PREEMPT for a task outside the kicker's subtree degrades to a plain
reschedule.

Unlike the enqueue caps, PREEMPT is checked only at the instant of the
insert or kick, never as a standing property of a queued task.

v2: Clear SCX_ENQ_PREEMPT on the offline and migration_pending force-admits.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 34 +++++++++++++++++++++++++---------
 kernel/sched/ext/internal.h | 24 ++++++++++++++++++++++--
 kernel/sched/ext/sub.c      | 19 +++++++++++++++----
 kernel/sched/ext/sub.h      | 15 +++++++++++++++
 4 files changed, 77 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 88c56357e60d..c6e9a26213f4 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -294,7 +294,7 @@ static bool u32_before(u32 a, u32 b)
  *
  * Test whether @sch is a descendant of @ancestor.
  */
-static bool scx_is_descendant(struct scx_sched *sch, struct scx_sched *ancestor)
+bool scx_is_descendant(struct scx_sched *sch, struct scx_sched *ancestor)
 {
 	if (sch->level < ancestor->level)
 		return false;
@@ -4915,6 +4915,7 @@ SCX_ATTR(events);
 static const char *scx_cap_names[__SCX_NR_CAPS] = {
 	[__SCX_CAP_ENQ_IMMED]	= "enq_immed",
 	[__SCX_CAP_ENQ]		= "enq",
+	[__SCX_CAP_PREEMPT]	= "preempt",
 };
 
 static ssize_t scx_attr_caps_show(struct kobject *kobj,
@@ -7837,13 +7838,22 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
 	 * forward progress. Allow kicking self regardless of online state. If
 	 * @cpu is running a higher class task, we have no control over @cpu.
-	 * Skip kicking.
+	 * Skip kicking. A sub-sched lacking baseline access on @cid has no
+	 * business forcing a reschedule there - skip. This is the authoritative
+	 * cap check: ecaps is read here under @rq's lock.
 	 */
 	if ((cpu_online(cpu) || cpu == cpu_of(this_rq)) &&
-	    !sched_class_above(cur_class, &ext_sched_class)) {
+	    !sched_class_above(cur_class, &ext_sched_class) &&
+	    !scx_missing_caps(pcpu->sch, cpu, SCX_CAP_BASE)) {
 		if (cpumask_test_cpu(cpu, pcpu->cpus_to_preempt)) {
-			if (cur_class == &ext_sched_class)
-				set_task_slice(rq->curr, 0);
+			if (cur_class == &ext_sched_class) {
+				if (likely(!scx_missing_caps(pcpu->sch, cpu,
+							     scx_caps_for_preempt(pcpu->sch, rq))))
+					set_task_slice(rq->curr, 0);
+				else
+					__scx_add_event(pcpu->sch,
+							SCX_EV_SUB_PREEMPT_DENIED, 1);
+			}
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
 		}
 
@@ -7867,15 +7877,18 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	return should_wait;
 }
 
-static void kick_one_cpu_if_idle(s32 cpu, struct rq *this_rq)
+static void kick_one_cpu_if_idle(s32 cpu, struct scx_sched_pcpu *pcpu,
+				 struct rq *this_rq)
 {
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
 
+	/* idle kicks need baseline access too, see kick_one_cpu() */
 	if (!can_skip_idle_kick(rq) &&
-	    (cpu_online(cpu) || cpu == cpu_of(this_rq)))
+	    (cpu_online(cpu) || cpu == cpu_of(this_rq)) &&
+	    !scx_missing_caps(pcpu->sch, cpu, SCX_CAP_BASE))
 		resched_curr(rq);
 
 	raw_spin_rq_unlock_irqrestore(rq, flags);
@@ -7912,7 +7925,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 		}
 
 		for_each_cpu(cpu, pcpu->cpus_to_kick_if_idle) {
-			kick_one_cpu_if_idle(cpu, this_rq);
+			kick_one_cpu_if_idle(cpu, pcpu, this_rq);
 			cpumask_clear_cpu(cpu, pcpu->cpus_to_kick_if_idle);
 		}
 	}
@@ -8950,7 +8963,10 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * cid-addressed equivalent of scx_bpf_kick_cpu(). An invalid @cid aborts the
- * scheduler via scx_cid_to_cpu().
+ * scheduler via scx_cid_to_cpu(). Caps are enforced on the delivery path: a
+ * kick is dropped if the caller lacks baseline access on @cid, and a
+ * %SCX_KICK_PREEMPT degrades to a plain reschedule if the caller lacks
+ * %SCX_CAP_PREEMPT for a task outside its subtree.
  */
 __bpf_kfunc void scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *aux)
 {
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 185dea079d79..3537c1dd532e 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1155,6 +1155,13 @@ struct scx_event_stats {
 	 * it can't be rejected. The violation is counted here.
 	 */
 	s64		SCX_EV_SUB_FORCED_ADMIT;
+
+	/*
+	 * The number of times a preempting kick was refused because the
+	 * sub-sched lacked SCX_CAP_PREEMPT for a task outside its subtree. The
+	 * kick degrades to a plain reschedule.
+	 */
+	s64		SCX_EV_SUB_PREEMPT_DENIED;
 };
 
 #define SCX_EVENTS_LIST(SCX_EVENT)					\
@@ -1173,7 +1180,8 @@ struct scx_event_stats {
 	SCX_EVENT(SCX_EV_BYPASS_ACTIVATE);				\
 	SCX_EVENT(SCX_EV_INSERT_NOT_OWNED);				\
 	SCX_EVENT(SCX_EV_SUB_BYPASS_DISPATCH);				\
-	SCX_EVENT(SCX_EV_SUB_FORCED_ADMIT)
+	SCX_EVENT(SCX_EV_SUB_FORCED_ADMIT);				\
+	SCX_EVENT(SCX_EV_SUB_PREEMPT_DENIED)
 
 struct scx_sched;
 
@@ -1287,22 +1295,33 @@ struct scx_sched_pnode {
  * the allocation pattern.
  *
  * ENQ_IMMED  insert an IMMED task onto the cid's local DSQ
+ *            - kick the cid's cpu (except SCX_KICK_PREEMPT)
  *
  * ENQ        insert any task onto the cid's local DSQ (implies ENQ_IMMED)
  *
+ * PREEMPT    preempt any task running on the cid regardless of the owning
+ *            sched (implies ENQ). Preempting a task in the sched's own subtree
+ *            doesn't require any cap.
+ *            - SCX_ENQ_PREEMPT inserts
+ *            - SCX_KICK_PREEMPT kicks
+ *
  * Implied caps apply to the holder's own use of a cid, not to delegation.
  * scx_bpf_sub_grant() delegates literally-held caps, so a cap held only through
- * implication is usable but cannot be re-delegated to a child.
+ * implication is usable but cannot be re-delegated to a child. When granting a
+ * cap, it usually makes sense to delegate its implied caps explicitly alongside
+ * it.
  */
 enum scx_cap_flags {
 	__SCX_CAP_ENQ_IMMED		= 0,
 	__SCX_CAP_ENQ			= 1,
+	__SCX_CAP_PREEMPT		= 2,
 
 	__SCX_NR_CAPS,
 	__SCX_CAP_ALL			= BIT_U64(__SCX_NR_CAPS) - 1,
 
 	SCX_CAP_ENQ_IMMED		= BIT_U64(__SCX_CAP_ENQ_IMMED),
 	SCX_CAP_ENQ			= BIT_U64(__SCX_CAP_ENQ),
+	SCX_CAP_PREEMPT			= BIT_U64(__SCX_CAP_PREEMPT),
 
 	/* alias for minimal cap to make any use of a cpu */
 	SCX_CAP_BASE			= SCX_CAP_ENQ_IMMED,
@@ -1912,6 +1931,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 					  struct scx_sched *parent);
 int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops);
 int scx_sched_sysfs_add(struct scx_sched *sch);
+bool scx_is_descendant(struct scx_sched *sch, struct scx_sched *ancestor);
 
 extern raw_spinlock_t scx_sched_lock;
 extern struct mutex scx_enable_mutex;
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 778ae3f6f91f..bd133ad014a0 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -221,11 +221,14 @@ void scx_init_root_caps(struct scx_sched *sch)
  * @sch: enqueuing sub-sched
  * @rq: rq whose local DSQ @p targets
  * @p: task being inserted
- * @enq_flags: in/out; %SCX_ENQ_IMMED is cleared when diverting to reject
+ * @enq_flags: in/out, unhonored flags are cleared
  *
  * Return @rq's local DSQ if @sch holds the required caps on @rq's cid,
  * otherwise @rq's reject DSQ after recording the reenq reason on @p.
  *
+ * %SCX_ENQ_IMMED and %SCX_ENQ_PREEMPT are cleared when diverting to reject.
+ * %SCX_ENQ_PREEMPT is also cleared on a fallback migration-disabled admission.
+ *
  * Bypass doesn't need special-casing as a bypassing sched's tasks are enqueued
  * to and run by its nearest non-bypassing ancestor. If root is bypassing, it
  * always holds all caps.
@@ -234,7 +237,12 @@ struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq
 					       struct task_struct *p, u64 *enq_flags)
 {
 	s32 cid = __scx_cpu_to_cid(cpu_of(rq));
-	u64 missing = scx_missing_caps(sch, cpu_of(rq), scx_caps_for_enq(*enq_flags));
+	u64 needed = scx_caps_for_enq(*enq_flags);
+	u64 missing;
+
+	if (*enq_flags & SCX_ENQ_PREEMPT)
+		needed |= scx_caps_for_preempt(sch, rq);
+	missing = scx_missing_caps(sch, cpu_of(rq), needed);
 
 	/* requirements met */
 	if (likely(!missing))
@@ -244,10 +252,12 @@ struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq
 	 * The task must run on this CPU regardless of caps: the rq is draining
 	 * offline (BPF scheduler bypassed), the task is migration-disabled, or a
 	 * migration is pending. Admit despite the missing caps and count it.
+	 * Refuse preemptions.
 	 */
 	if (unlikely(!scx_rq_online(rq) || is_migration_disabled(p) ||
 		     p->migration_pending)) {
 		__scx_add_event(sch, SCX_EV_SUB_FORCED_ADMIT, 1);
+		*enq_flags &= ~SCX_ENQ_PREEMPT;
 		return &rq->scx.local_dsq;
 	}
 
@@ -257,9 +267,10 @@ struct scx_dispatch_q *scx_local_or_reject_dsq(struct scx_sched *sch, struct rq
 	/*
 	 * Only local DSQ can honor IMMED and dsq_inc_nr() WARNs on IMMED into
 	 * others. Strip both the enq flag and the sticky task flag - the
-	 * latter can carry in from an earlier admitted IMMED insert.
+	 * latter can carry in from an earlier admitted IMMED insert. Strip
+	 * PREEMPT too.
 	 */
-	*enq_flags &= ~SCX_ENQ_IMMED;
+	*enq_flags &= ~(SCX_ENQ_IMMED | SCX_ENQ_PREEMPT);
 	p->scx.flags &= ~SCX_TASK_IMMED;
 
 	return &rq->scx.reject_dsq;
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 1d278c0d1602..c2ef980351ef 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -119,10 +119,24 @@ static inline u64 scx_caps_for_task(struct task_struct *p)
 	return SCX_CAP_ENQ;
 }
 
+/* the cap @sch needs to preempt @rq's current task, 0 if none */
+static inline u64 scx_caps_for_preempt(struct scx_sched *sch, struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+
+	/* a non-ext task can't be preempted by ext, own-subtree needs no cap */
+	if (curr->sched_class != &ext_sched_class ||
+	    scx_is_descendant(scx_task_sched(curr), sch))
+		return 0;
+	return SCX_CAP_PREEMPT;
+}
+
 /* caps implied by holding @cap */
 static inline u64 scx_caps_implied(u64 cap)
 {
 	switch (cap) {
+	case SCX_CAP_PREEMPT:
+		return SCX_CAP_ENQ | SCX_CAP_ENQ_IMMED;
 	case SCX_CAP_ENQ:
 		return SCX_CAP_ENQ_IMMED;
 	}
@@ -142,6 +156,7 @@ static inline bool scx_task_can_stay_on_cpu(struct rq *rq, struct task_struct *p
 #else	/* CONFIG_EXT_SUB_SCHED */
 
 static inline u64 scx_missing_caps(struct scx_sched *sch, s32 cpu, u64 needed) { return 0; }
+static inline u64 scx_caps_for_preempt(struct scx_sched *sch, struct rq *rq) { return 0; }
 static inline bool scx_task_can_stay_on_cpu(struct rq *rq, struct task_struct *p) { return true; }
 
 #endif	/* CONFIG_EXT_SUB_SCHED */
-- 
2.54.0

