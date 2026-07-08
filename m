Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63B3F8EDC;
	Wed,  8 Jul 2026 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545911; cv=none; b=epwjl9F7q408dQy6Ef6Yshu9blpoVwkIGBVpihf6GhfgaiM1XsyivLfC7J5D21yIyg9C7Z4n7VMTg7ckSKdcExrQWhDq0tQMf3255BIlyQyHa2w/CTu1JxYXKy5PS7NpQNwCuYGvywXLpBQv8LeU8eqI54Ymv5iQODShdMzTmks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545911; c=relaxed/simple;
	bh=thsExQXpucZlm7TiAioQl8fKtbFYWsyRE6peiULA8w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMkVmGgxQ6obPL5eci2iRp9Mt401vmOD4a35gfG1Rendhfd2PxB8m0XQBNUwm9vkw5xW448mVsp5ivI38H2WNmxbP/0+thXkt3GcIRIN4kTYUi2fUtWqMKLndGWpx6d6bUlHQLd9KuWGdIvzACk7LAs1jMj2HLTuoIKKE3YBgYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVTZ4IBz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVTZ4IBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A1F1F000E9;
	Wed,  8 Jul 2026 21:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545910;
	bh=ceuCQIfh27E4kl746rW2u14xapmNhYLYVMiPXHChYFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DVTZ4IBzVzuv0ea2DJ5nWfNSfCy03YI81FXbpK6TX7iXCUUqzgWaJss3CauB1Pw6f
	 IQy00rJfK+krDgZNyUdoRaIldqiV0/3VAHjefpQBaHdt3SqCEMMwjLqFBi5YEsw9u3
	 VGsURu+l9WQsfB/GgCqPcL1GyNb6kKsf1Qu+MuSWp2rTusgDiE6x6qGuYdesa9W544
	 1KspR4M4iVQAdlW3L5Q4v0OMyJoqHXagsdGByEsxurM/jP0UPR8ONUAfhETLTh8Uq5
	 IVWiZGCiGo2CTTkdwKUTP8RZ0cZzhKsZuTbCbwdjPLNBSJUmIIuweElpxCCFJur2WN
	 6firy9M7hpCYA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 36/40] sched_ext: Replay ecaps notifications suppressed by bypass
Date: Wed,  8 Jul 2026 11:24:25 -1000
Message-ID: <20260708212429.3405787-37-tj@kernel.org>
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

scx_process_sync_ecaps() consumes ecaps syncs while the sched is bypassing
without delivering ops.sub_ecaps_updated(), leaving reported_ecaps stale.
Nothing re-queued a sync when bypass lifted, so a cid whose caps never
change again would never be notified. Attach-time initial grants hit this
every time: they are consumed during the enable bypass window, so a sched
never learned its initial effective caps through the callback.

Re-queue a sync for every (sched, cpu) with an undelivered delta at the
per-cpu bypass exit in scx_bypass(), next to the idle renotify catch-up. The
next balance on the cpu then delivers the pending delta with proper dispatch
context.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c |  4 +++-
 kernel/sched/ext/sub.c | 35 +++++++++++++++++++++++++++++++++++
 kernel/sched/ext/sub.h |  2 ++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 94801f3b4ce9..44622dcc8b4f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5621,8 +5621,10 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 				pcpu->flags |= SCX_SCHED_PCPU_BYPASSING;
 			} else {
 				pcpu->flags &= ~SCX_SCHED_PCPU_BYPASSING;
-				if (was_bypassing)
+				if (was_bypassing) {
 					unbypass_renotify_idle(rq, pos, pcpu);
+					scx_unbypass_replay_ecaps(rq, pos);
+				}
 			}
 		}
 
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index bdb08f18ed74..77cb7f3d7826 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -575,6 +575,41 @@ void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 		scx_schedule_reenq_local(rq, SCX_REENQ_CAP_REVOKE);
 }
 
+/**
+ * scx_unbypass_replay_ecaps - Replay a bypass-suppressed ecaps notification
+ * @rq: rq of the cpu leaving bypass
+ * @sch: scheduler that just left bypass on @rq's cpu
+ *
+ * scx_process_sync_ecaps() consumes syncs while bypassing without delivering
+ * ops.sub_ecaps_updated(), leaving reported_ecaps stale. Nothing re-queues a
+ * sync when bypass lifts, so without a replay a cid that never changes again
+ * would never be notified. The attach-time initial grants are the acute case
+ * as they are consumed during the enable bypass window. Re-queue a sync for
+ * any undelivered delta so the next balance delivers it.
+ */
+void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch)
+{
+	s32 cpu = cpu_of(rq);
+	struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+	struct scx_pshard *ps;
+	s32 cid;
+
+	lockdep_assert_rq_held(rq);
+
+	/* root holds every cap and never uses ecaps */
+	if (!sch->level)
+		return;
+
+	if (READ_ONCE(pcpu->ecaps) == pcpu->reported_ecaps)
+		return;
+
+	cid = __scx_cpu_to_cid(cpu);
+	ps = sch->pshard[scx_cid_to_shard[cid]];
+
+	guard(raw_spinlock)(&ps->lock);
+	queue_sync_ecaps(sch, cid);
+}
+
 /*
  * A cpu came back. Re-seed each sub-sched's ecaps on the cpu's cid. The sync
  * recomputes effective caps from the pshard and fires ops.sub_ecaps_updated()
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index c2ef980351ef..7464b33623bd 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -30,6 +30,7 @@ void scx_free_pshards(struct scx_sched *sch);
 s32 scx_alloc_pshards(struct scx_sched *sch);
 void scx_init_root_caps(struct scx_sched *sch);
 void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev);
+void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch);
 void scx_online_ecaps(struct rq *rq);
 void scx_offline_ecaps(struct rq *rq);
 void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu);
@@ -52,6 +53,7 @@ static inline void scx_free_pshards(struct scx_sched *sch) {}
 static inline s32 scx_alloc_pshards(struct scx_sched *sch) { return 0; }
 static inline void scx_init_root_caps(struct scx_sched *sch) {}
 static inline void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev) {}
+static inline void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch) {}
 static inline void scx_online_ecaps(struct rq *rq) {}
 static inline void scx_offline_ecaps(struct rq *rq) {}
 static inline void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu) {}
-- 
2.54.0

