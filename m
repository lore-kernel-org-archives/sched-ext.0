Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620865;
	b=dQNPC20kssyBLc8BzDViluGLKW42ArXiOJxlser1pI5ItHdcFXAT7NkSCZxaGvQYrW9O
	 UZPlJX27oEPbcZPWeYo5t91eVLpmHjOoMEnAmLwRD73k6W02op0HAA2OBABJJuqrVew1E
	 Xn6UuZ9NxqL+lysmSLFRZKLb3+RYqAY5Z0tyWlHVutWMkh6waZoWQZs6whiWTM5HIct0n
	 9sc7zJi6FApxwZjKjyM5Qp18K/v9E7eXYER87awy8ZjbpL8m9xeHS1SzY/H3NHSulhxXl
	 9GWJGc1qnJtqR02Bk4Q0F3W+vF2BvAtlkgAFltuUMzxsjUpyFccIJHNM2Y2MrdkUlIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=KinJlHopK6bybWfdH+Z3VhGjbEHAS/fH8cSNDqvPnfA=;
	b=MV52i6s78cmnH1+ju38Onsd0XICc/HKx6iv4tPEKbyjbKbDtNyqeJvD8vcHLEGwMaDSm
	 ReoEtowXKQZfF1Hh5G4lvBBqTU8dND0JeAuvneEBSEjT0hTZhcko+2uGYoOZjsFTZEbSS
	 VEbggELJUmHEOCuJWR1WjKNgkX/+Pq28EnfVtH4uWmWF1PUbHAmBScjnNBh/P54kclej+
	 ec4dkbBkShkvJ/ugDXwX3LEU9SO+rAr6syMEnzXh3vvLpQRCCWI8VmpT3RrxoaAV73uLb
	 w+X2py/V9pIuFsdMB+VUWJOFXWWWJ/qVSGLMFAClgJhZFJBKoiWgFG+P95d0EbyyAtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="lAIno2L/";
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D55606A327
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 15:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1D55606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lAIno2L/
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4bb69d84053so43115705e9.0
        for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 07:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795620863; x=1796225663; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KinJlHopK6bybWfdH+Z3VhGjbEHAS/fH8cSNDqvPnfA=;
        b=lAIno2L/UHN03j/DGcExoLTK3Z2KoPcJAK6ivvCamb7P0IS31pACe1nMPcG4RWeJHi
         TVIJo0GaewhLdPy/iGPabEb28Pu2dfr/1BnbKA6JUrv7JMDExzcruDuOPxhmtzCsK0W9
         YJwrAxK3yf4rmqgHHdzVMjfJy+bsf7jp0yxHYAxAm6/kMz7H3ly+RiKbCSE5RUpedgpu
         YvMJOSQU81vb+eGC+Af/hIFT3ZV+4rFw4ly2XRrtOWtcZwDa0eITJwzOXZamNXgapu1T
         VWG/+XtyWvlB/93SHRuSi69DO+E2J3PlnXoFreuaA99WZYHr1YzodqaDSGHK4ZxDQmO6
         13XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620863; x=1796225663;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KinJlHopK6bybWfdH+Z3VhGjbEHAS/fH8cSNDqvPnfA=;
        b=g+2WcH6fKURNR3t3lBP6SBDjX+8kN90yTpRWrYKqFbo2AJS08YNAQnZ85F3NhUtJHd
         2/0Gi0nE9dBvPucG1SuvVDH1R1iw8WYzrovm3oGnwFshY1NEnfzT/h+/TJHiyoVJzR/a
         6SAqirjxFy+0PtqGZUQN+5nfV2Hc7nMAtz+nx/nBFwmjPfnsQ6Cy1pAm2Iz8AbU6cA7m
         G4HqJdK4fs705wo20R9XI5lHEgYqXz8ctetbbZpbaUtq6Xle+yZTV+cNNmRlNmtTrjNp
         7ouIViUxWDBXYE9Z9fshBq0epirn2HhU5UlvrrQwqa37Q73d2EGuX12PyaVdSVi45Of9
         e+mw==
X-Forwarded-Encrypted: i=1; AL+hErF3a3OVkSj/0AeM6HHy4AvTEPtLIclvfhCw9oXarsC5FygkZIa03456Q6AG10VDPE4joU+qQy+O+rA=@lists.linux.dev
X-Gm-Message-State: APuU4Z9OurL/VhLSMX4bl44ME4JbJiMC8vL8CbHTuRRh88pLLXya/PqV
	UKioR4ylbfJ1XWsnbbdxFESEHcRuLp0ROittXvBResHOGiSQEix415cpi5JTiolTwCBfQDjD48O
	8Xy8HkqRbWDqk7w==
X-Received: from wmfq8.prod.google.com ([2002:a05:600c:2e48:b0:4bb:5bb3:d156])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a087:b0:4bb:5c92:ce22 with SMTP id 5b1f17b1804b1-4bb887fe887mr367808505e9.8.1795620863173;
 Wed, 25 Nov 2026 07:34:23 -0800 (PST)
Date: Wed, 25 Nov 2026 15:34:20 +0000
In-Reply-To: <20261125153353.1364467-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261125153353.1364467-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125153353.1364467-2-jpiecuch@google.com>
Subject: [RFC PATCH 1/2] sched_ext: sub: Defer ops.sub_caps_updated() out of
 SCX op contexts
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

scx_bpf_sub_grant() and scx_bpf_sub_revoke() are in scx_kfunc_ids_any and
deliver ops.sub_caps_updated() synchronously with a NULL locked_rq.
__SCX_CALL_OP() leaves scx_locked_rq_state untouched when locked_rq is
NULL, so ops.sub_caps_updated() inherits whatever context its parent
called grant or revoke from:

- From ops.sub_attach() or a BPF timer, scx_locked_rq() is NULL. From an
  rq-locked op (such as ops.enqueue(), or scx_qmap repartitioning a
  grandchild from ops.sub_ecaps_updated()), scx_locked_rq() points at the
  parent's rq. Unlike other callbacks, the child cannot safely tell which
  state it is in: scx_bpf_locked_rq() aborts the child when unlocked,
  scx_bpf_cidperf_set() aborts it with "Invalid target CPU" on any cid
  outside the parent's rq, and SCX_DSQ_LOCAL in scx_bpf_dsq_reenq() and
  scx_bpf_dsq_nr_queued() resolves to scx_locked_rq() ?: this_rq().

- Because ops.sub_caps_updated() may propagate grant/revoke to its own
  children, synchronous delivery can fan out across a subtree of
  descendant callbacks while holding the parent's rq lock, p->pi_lock
  (from ops.select_cpu()) or scx_dump_lock (from ops.dump*()), extending
  lock hold time.

- From ops.dump*(), scx_dump_data.cpu remains set, so a child calling
  scx_bpf_dump() writes into the parent's dump instead of failing.

Give ops.sub_caps_updated() a consistent unlocked context by deferring
delivery when grant or revoke runs in an SCX op context (an rq lock held,
kf_tasks[] set, ops.select_cpu() or ops.dump*()). Queue the deliveries on
a global list and kick a per-cpu hard irq_work, or an online cpu's when
this cpu is going down. Suppress the kick while PM is in progress, where
irq_work_queue() can malfunction in the syscore phase, and kick any queued
deliveries from scx_sub_pm_end(). Queued nodes stay in flight so later
updates keep coalescing into them. Before freeing a scheduler's pshards,
scx_free_pshards() drops its queued entries and flushes every cpu's
irq_work.

Fixes: 5f2a9a4c2e6c ("sched_ext: Add coalescing sub_caps_updated() notifier for sub-schedulers")
Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c      |   6 ++
 kernel/sched/ext/internal.h |   8 +++
 kernel/sched/ext/sub.c      | 129 ++++++++++++++++++++++++++++++++++--
 3 files changed, 139 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index efa1d01d03af..570d6c923904 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7964,6 +7964,12 @@ static void ops_dump_exit(void)
 	scx_dump_data.cpu = -1;
 }
 
+/* whether this cpu is in scx_dump_state(), where scx_bpf_dump() is allowed */
+bool scx_in_dump(void)
+{
+	return READ_ONCE(scx_dump_data.cpu) == raw_smp_processor_id();
+}
+
 static void scx_dump_task(struct scx_sched *sch, struct seq_buf *s, struct scx_dump_ctx *dctx,
 			  struct rq *rq, struct task_struct *p, char marker)
 {
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 58652370da5a..69846ac85a44 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -909,6 +909,8 @@ struct sched_ext_ops {
 	 * cpu, once it is in effect.
 	 *
 	 * May call scx_bpf_sub_grant() / scx_bpf_sub_revoke() on children.
+	 * Even if the parent called grant / revoke under an rq lock or from
+	 * ops.select_cpu() or ops.dump*(), this callback runs unlocked.
 	 */
 	void (*sub_caps_updated)(const struct scx_cmask *cmask, u64 caps);
 
@@ -1666,6 +1668,11 @@ enum scx_cap_flags {
  *
  * (3) leads to deferred delivery. Events accumulate during grant/revoke and are
  * delivered after the shard lock is released.
+ *
+ * When grant or revoke runs in an SCX op context (an rq lock held,
+ * ops.select_cpu() or ops.dump*()), caps_updated_deliver_or_defer() defers the
+ * delivery to an irq_work so that ops.sub_caps_updated() always runs unlocked
+ * instead of inheriting the caller's context.
  */
 struct scx_caps_updated {
 	raw_spinlock_t		lock;
@@ -2314,6 +2321,7 @@ bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 			    struct scx_dispatch_q *dsq, u64 enq_flags);
 bool scx_consume_global_dsq(struct scx_sched *sch, struct rq *rq);
 bool scx_rq_online(struct rq *rq);
+bool scx_in_dump(void);
 void scx_flush_dispatch_buf(struct scx_sched *sch, struct rq *rq);
 s32 scx_init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id, struct scx_sched *sch);
 __printf(2, 3) void scx_dump_line(struct seq_buf *s, const char *fmt, ...);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 7c069a289766..d535b9258b10 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -66,7 +66,10 @@ static DECLARE_WAIT_QUEUE_HEAD(ecaps_offline_waitq);
 static struct cpumask scx_frozen_cpus;
 static DECLARE_WAIT_QUEUE_HEAD(scx_frozen_cpus_waitq);
 
-/* between the PREPARE and POST notifications of a PM cycle */
+/*
+ * True between the PREPARE and POST notifications of a PM cycle. Updated under
+ * caps_updated_deferred_lock.
+ */
 static bool scx_pm_in_progress;
 
 /**
@@ -307,6 +310,47 @@ void set_cgroup_sched(struct cgroup *cgrp, struct scx_sched *sch)
 		rcu_assign_pointer(pos->scx_sched, sch);
 }
 
+/*
+ * Queue of ops.sub_caps_updated() deliveries deferred out of SCX op contexts.
+ * Queued entries stay linked on scx_caps_updated->node_in_flight so that
+ * caps_updated_record() keeps coalescing into them.
+ *
+ * Each cpu has its own hard irq_work:
+ * - A single irq_work queued on multiple cpus can run irq_work_single()
+ *   concurrently and clear IRQ_WORK_BUSY early, breaking irq_work_sync().
+ * - A dying cpu still runs SCX ops after hotplug parks its irq_work thread,
+ *   which would strand a regular irq_work on PREEMPT_RT.
+ */
+static void caps_updated_deferred_workfn(struct irq_work *irq_work);
+static LIST_HEAD(caps_updated_deferred);
+static DEFINE_RAW_SPINLOCK(caps_updated_deferred_lock);
+static DEFINE_PER_CPU(struct irq_work, caps_updated_deferred_irq_work) =
+	IRQ_WORK_INIT_HARD(caps_updated_deferred_workfn);
+
+/*
+ * Drop @sch's deferred caps_updated deliveries before freeing its pshards.
+ * scx_sched_free_rcu_work() calls this after two RCU grace periods post
+ * unlink, so scx_bpf_sub_grant/revoke() cannot queue new entries for @sch.
+ */
+static void caps_updated_cancel_deferred(struct scx_sched *sch)
+{
+	struct scx_caps_updated *cu, *tmp;
+	s32 cpu;
+
+	scoped_guard (raw_spinlock_irqsave, &caps_updated_deferred_lock) {
+		list_for_each_entry_safe(cu, tmp, &caps_updated_deferred, node_in_flight) {
+			if (container_of(cu, struct scx_pshard, caps_updated)->sch != sch)
+				continue;
+			guard(raw_spinlock)(&cu->lock);
+			list_del_init(&cu->node_in_flight);
+		}
+	}
+
+	/* wait for any workfn that already spliced @sch's entries */
+	for_each_possible_cpu(cpu)
+		irq_work_sync(per_cpu_ptr(&caps_updated_deferred_irq_work, cpu));
+}
+
 static void free_pshard(struct scx_pshard *pshard)
 {
 	struct scx_caps_updated *cu;
@@ -327,6 +371,7 @@ void scx_free_pshards(struct scx_sched *sch)
 
 	if (!sch->pshard)
 		return;
+	caps_updated_cancel_deferred(sch);
 	for (si = 0; si < sch->nr_pshards; si++)
 		free_pshard(sch->pshard[si]);
 	kfree(sch->pshard);
@@ -1034,6 +1079,77 @@ static void caps_updated_deliver(struct list_head *to_deliver)
 	}
 }
 
+static void caps_updated_deferred_workfn(struct irq_work *irq_work)
+{
+	LIST_HEAD(to_deliver);
+
+	/* hard irq_work, same irq-disabled context as a synchronous delivery */
+	lockdep_assert_irqs_disabled();
+
+	scoped_guard (raw_spinlock, &caps_updated_deferred_lock)
+		list_splice_init(&caps_updated_deferred, &to_deliver);
+
+	caps_updated_deliver(&to_deliver);
+}
+
+static void caps_updated_kick_deferred(void)
+{
+	s32 cpu = smp_processor_id();
+
+	lockdep_assert_held(&caps_updated_deferred_lock);
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * During the PM syscore phase, irq_work_queue() can malfunction.
+	 * scx_sub_pm_end() kicks the queue when the PM cycle finishes.
+	 */
+	if (unlikely(scx_pm_in_progress))
+		return;
+
+	if (likely(cpu_online(cpu))) {
+		irq_work_queue(this_cpu_ptr(&caps_updated_deferred_irq_work));
+		return;
+	}
+
+	/*
+	 * When hotplug parks a dying cpu's migration thread, ops.update_idle()
+	 * runs after smpcfd_dying_cpu() already drained local irq_work. Route
+	 * to an online cpu; cpus_write_lock() keeps cpu_online_mask stable.
+	 */
+	cpu = cpumask_first(cpu_online_mask);
+	if (likely(cpu < nr_cpu_ids))
+		irq_work_queue_on(per_cpu_ptr(&caps_updated_deferred_irq_work, cpu),
+				  cpu);
+}
+
+/*
+ * If the caller runs in an SCX op context (an rq lock held, ops.select_cpu()
+ * or ops.dump*()), defer @to_deliver to an irq_work. Otherwise deliver it now.
+ *
+ * ops.sub_caps_updated() is called with a NULL locked_rq, which leaves
+ * scx_locked_rq() untouched. Delivering synchronously here would inherit the
+ * parent's scx_locked_rq() or dump state and hold the parent's rq lock, pi_lock
+ * or scx_dump_lock across any cascading grant/revoke down the subtree.
+ */
+static void caps_updated_deliver_or_defer(struct list_head *to_deliver)
+{
+	lockdep_assert_irqs_disabled();
+
+	if (likely(!scx_locked_rq() && !current->scx.kf_tasks[0] &&
+		   !this_rq()->scx.in_select_cpu && !scx_in_dump())) {
+		caps_updated_deliver(to_deliver);
+		return;
+	}
+
+	if (list_empty(to_deliver))
+		return;
+
+	scoped_guard (raw_spinlock, &caps_updated_deferred_lock) {
+		list_splice_tail_init(to_deliver, &caps_updated_deferred);
+		caps_updated_kick_deferred();
+	}
+}
+
 /*
  * Deliver caps owed to @sch that couldn't be delivered earlier (e.g. a grant
  * taken during its sub_attach(), before has_op was set). Called once has_op is
@@ -1325,6 +1441,7 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 
 void scx_sub_pm_begin(void)
 {
+	guard(raw_spinlock_irqsave)(&caps_updated_deferred_lock);
 	WRITE_ONCE(scx_pm_in_progress, true);
 }
 
@@ -1376,7 +1493,11 @@ void scx_sub_pm_end(void)
 				   cpumask_weight(&scx_frozen_cpus));
 	}
 
-	WRITE_ONCE(scx_pm_in_progress, false);
+	scoped_guard (raw_spinlock_irqsave, &caps_updated_deferred_lock) {
+		WRITE_ONCE(scx_pm_in_progress, false);
+		if (!list_empty(&caps_updated_deferred))
+			caps_updated_kick_deferred();
+	}
 	cpumask_clear(&scx_frozen_cpus);
 	wake_up_all(&scx_frozen_cpus_waitq);
 }
@@ -2981,7 +3102,7 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
 
 	ret = any_denied ? -EPERM : 0;
 out:
-	caps_updated_deliver(&to_deliver);
+	caps_updated_deliver_or_defer(&to_deliver);
 	return ret;
 }
 
@@ -3073,7 +3194,7 @@ __bpf_kfunc void scx_bpf_sub_revoke(u64 cgroup_id, u64 caps,
 		}
 	}
 
-	caps_updated_deliver(&to_deliver);
+	caps_updated_deliver_or_defer(&to_deliver);
 }
 
 /**
-- 
2.56.1.839.g22a8290db9-goog

