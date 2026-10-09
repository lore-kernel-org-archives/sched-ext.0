Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8D49B1FD;
	Fri,  9 Oct 2026 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791539047; cv=none; b=U8zd07NfOjg97aKnMO/0V2K3Hry0SHAMLLiX01tQ0gyEwa0aRJv3RB19FI2u9FNoyJDA/0fwAAzrfovGQML702GoKu/V3MKoXla+U3SWrM0O5XeWiX8oocCHNE4OWAPmAySVLBhWu5RgNqPqUD3hEL6eauwJdGNdRRojA3ocvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791539047; c=relaxed/simple;
	bh=O8uZTzJH0oQRgoawT3bDiNdnYbqMee+AAVvARJhFqVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtLBm19wFaRqXtSRgi0myzW8BukJRVGlEiGvqBzRzubHg9s1QIrLT2yhNjBhqFTpvk6wsITX97vkAuJE6jxqg6kUjNmuifEHNuhnpEdAovv/pTOOC19o/aJlv7rAkTt464VUcSw/5zuNfFahpe+ICgQRVDWh95vAFcQRg1RojcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcPKKGkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcPKKGkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C6A1F00898;
	Fri,  9 Oct 2026 09:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791539039;
	bh=9z8kOnhNvpqwPLjthKyXNa8R0gW/X+bsztDoMBATdQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FcPKKGkNrFyDTph3xao6n7JLCvIBB2D45fQXlGsRU4ZBdL0KIpHeTiRT8S2yYclBf
	 G7G3Tm1/SKK7eFKTvrPC4/9t52N2Wn3fSadyr9AaeBXwQU9UE8zt/O4C9WmJM4Aorb
	 D+GEHll8u2Ek+feQev7/WmJoOoQK0f+/vcW+kOEP3K0p6Svz4l83b8f9iYm5cDdQZv
	 5hTL/PC9J5dRL3vuy/tpKD6NYik39VG+GhvLWUeOCZKw84507Mo6rcWPWSeLipa6wP
	 N+QTU01ZblA4hBz3EnIAuTTWe3vGzXE9okLxzuGZ7+V2OxSKn5QuG+SqQhrfvrNGr7
	 ASy1lvdv1M0lg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] sched_ext: Report a sub-scheduler's attach-time ecaps before lifting its enable bypass
Date: Thu,  8 Oct 2026 23:43:56 -1000
Message-ID: <20261009094356.2852794-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009094356.2852794-1-tj@kernel.org>
References: <20261009094356.2852794-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sub-scheduler learns which cids it holds through ops.sub_ecaps_updated().
Today, the grants its parent makes when it attaches are reported only after
its enable bypass is lifted, which is also when its tasks are handed to it.
So the sub-scheduler gets its first ops.enqueue() calls before it has been
notified of a single cid and has to hold the tasks somewhere until the
grants arrive.

Report the attach-time grants before lifting bypass instead. The
sub-scheduler then has its complete cid view when the first task arrives and
can place it right away. Nothing else reaches its ops in the meantime, as it
is still bypassing.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/sub.c | 73 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 313e69841bc9..889fe322198e 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1069,6 +1069,9 @@ static void discard_queued_syncs(struct rq *rq)
  * @prev: @rq's previous task from the in-progress dispatch
  * @report: whether a change is reported to the sched
  *
+ * @prev may be NULL when seeding a bypassing sched. Only a nested
+ * scx_bpf_sub_dispatch() reads it, and a sched being enabled has no children.
+ *
  * pshard->caps[] is the target configuration. pcpu->ecaps is the effective
  * transposed copy owned by the cid's cpu and written only here under @rq's
  * lock.
@@ -1107,13 +1110,21 @@ static u64 sync_pcpu_ecaps(struct rq *rq, struct scx_sched_pcpu *pcpu, s32 cid,
 	if (ecaps != pcpu->reported_ecaps &&
 	    SCX_HAS_OP(pcpu->sch, sub_ecaps_updated) && report) {
 		struct scx_dsp_ctx *dspc = &this_cpu_ptr(pcpu->sch->pcpu)->dsp_ctx;
+		struct task_struct *prev_stash;
 
 		dspc->rq = rq;
-		/* stash @prev so nested dispatches can access it */
+		/*
+		 * Stash @prev for nested dispatches. The enable path calls this
+		 * while the cpu's own dispatch may be inside an op with the rq
+		 * lock dropped. That dispatch needs its stash back when it
+		 * resumes, so save and restore it. A bypassing sched's op never
+		 * drops the lock, so nothing else writes the stash in between.
+		 */
+		prev_stash = rq->scx.sub_dispatch_prev;
 		rq->scx.sub_dispatch_prev = prev;
 		SCX_CALL_OP(pcpu->sch, sub_ecaps_updated, rq, scx_cpu_arg(cpu_of(rq)),
 			    pcpu->reported_ecaps, ecaps);
-		rq->scx.sub_dispatch_prev = NULL;
+		rq->scx.sub_dispatch_prev = prev_stash;
 		scx_flush_dispatch_buf(pcpu->sch, rq);
 		pcpu->reported_ecaps = ecaps;
 	}
@@ -1184,6 +1195,48 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		scx_schedule_reenq_local(rq, SCX_REENQ_CAP_REVOKE);
 }
 
+/**
+ * scx_sub_seed_ecaps - Report @sch's attach-time ecaps before lifting bypass
+ * @sch: sub-scheduler being enabled, still bypassing
+ *
+ * The grants made during ops.sub_attach() were applied without calling
+ * ops.sub_ecaps_updated(), as @sch had no ops registered yet or was already
+ * bypassing. Report them before lifting bypass, so that @sch is notified of its
+ * cids before any task reaches its ops. A sync still queued on a cpu finds
+ * nothing new afterwards. Kicks and inserts from the op are dropped while
+ * bypassing. Lifting bypass reschedules all cpus.
+ */
+static void scx_sub_seed_ecaps(struct scx_sched *sch)
+{
+	s32 cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+		s32 cid, shard;
+
+		/* unpinned, the lock state the op is called in from dispatch */
+		guard(raw_spin_rq_lock_irqsave)(rq);
+
+		/*
+		 * When a cpu goes offline, its ecaps are cleared and must stay
+		 * zero until it comes back online. Don't write non-zero ecaps
+		 * on an inactive cpu.
+		 */
+		if (!cpu_active(cpu))
+			continue;
+		cid = __scx_cpu_to_cid(cpu);
+		shard = rcu_dereference_all(scx_cid_to_shard)[cid];
+
+		/*
+		 * An aborting sched gets no op calls.
+		 * __scx_process_sync_ecaps() gets that from its bypass test,
+		 * but @sch is bypassing here, so test aborting directly.
+		 */
+		sync_pcpu_ecaps(rq, per_cpu_ptr(sch->pcpu, cpu), cid, shard, NULL,
+				!READ_ONCE(sch->aborting));
+	}
+}
+
 /**
  * scx_unbypass_replay_ecaps - Replay a bypass-suppressed ecaps notification
  * @rq: rq of the cpu leaving bypass
@@ -1192,9 +1245,8 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
  * scx_process_sync_ecaps() consumes syncs while bypassing without delivering
  * ops.sub_ecaps_updated(), leaving reported_ecaps stale. Nothing re-queues a
  * sync when bypass lifts, so without a replay a cid that never changes again
- * would never be notified. The attach-time initial grants are the acute case
- * as they are consumed during the enable bypass window. Re-queue a sync for
- * any undelivered delta so the next dispatch delivers it.
+ * would never be notified. Re-queue a sync for any undelivered delta so the
+ * next dispatch delivers it.
  */
 void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch)
 {
@@ -2145,10 +2197,15 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
-	scx_bypass(sch, false);
-
-	/* @sch is enabled; deliver any caps owed since its sub_attach() */
+	/*
+	 * @sch is enabled but still bypassing. Report the caps and ecaps
+	 * granted during ops.sub_attach() before lifting bypass and letting its
+	 * tasks reach ops.enqueue().
+	 */
 	scx_sub_seed_caps(sch);
+	scx_sub_seed_ecaps(sch);
+
+	scx_bypass(sch, false);
 
 	pr_info("sched_ext: BPF sub-scheduler \"%s\" enabled\n", sch->ops.name);
 	kobject_uevent(&sch->kobj, KOBJ_ADD);
-- 
2.55.0

