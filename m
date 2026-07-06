Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6291A3A168B;
	Mon,  6 Jul 2026 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302096; cv=none; b=P6VN9RXq8IrTvpf5ccti1Q0zRGWMqGLa8vHcXh3if1VmYGl+NLPz46MkTepeIwSl4JoPWoQLYG7NBHm9buPWhlcBnEGB8a3lv32uwvKaosCwM5FMLmxA2cUtAGK9tmT/7JjVhigniPM6+AgT+Q1DeKB09sEPjlLa0L6AGAj9Nh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302096; c=relaxed/simple;
	bh=eG3LwHyh2F7ka72js6dhCJuYMpADXCDrkilW0bnYrDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFOyH9qeUC/pFiWV+Hnzfs9//BP4qmDqDnS0mOyTjud/tULWIpRZBx8O/vNEIKhKJABzbN6hpIz/6jIJFgPlbL/5cxBQu/lOUkcLo70665JLOyz/CeUbZZDZQPSNwZEt+NfQV1jcDiAyjISQN7OxbotQqBo5afE6HeFh26VB3As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ4U8nkc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ4U8nkc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153081F00A3A;
	Mon,  6 Jul 2026 01:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302093;
	bh=bPcufUl6l5mcXV/nkgYZMYOi4j4Gv+RLWS2yb3PwuSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hZ4U8nkcOH6ZERIGR2jXhlrzoyVH5hGU34K5LIwhOTpYVGKCZxA0ZlPgXdiTrjVpL
	 +hOjfFObSdj8/0Q5ksllPwQjvK5uNmMT7qRUJZxBjs8yu5u0fJ55wLKEJzIOUKVthB
	 FJ/v1cF8rn3mEP31nG01fU37l2nspUtnj3999Ju6N2m4LwX8Et2j6NYusP1CYcVUvB
	 OsV/CXnoX8f0kW0gkNq41eSiu8YBVIHLUXFufrN8Ma5BjPjPHljlUDt0trvsaLWYp1
	 RxpqYT5BYNOnU06OMkSZSqdHjTPQap5Rp69vHvcN0PO/RL1fKMvGOYR8+d4VhvhqJ2
	 jcelHnrTRix8g==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 33/36] sched_ext: Replay ecaps notifications suppressed by bypass
Date: Sun,  5 Jul 2026 15:40:55 -1000
Message-ID: <20260706014058.439853-34-tj@kernel.org>
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
index 8caca7fe2460..a8250eb69da8 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5599,8 +5599,10 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
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
index 5a48304b72a6..9e0643e3cecb 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -562,6 +562,41 @@ void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
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
index 9f74c142b73f..dd33472fadd4 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -29,6 +29,7 @@ void scx_free_pshards(struct scx_sched *sch);
 s32 scx_alloc_pshards(struct scx_sched *sch);
 void scx_init_root_caps(struct scx_sched *sch);
 void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev);
+void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch);
 void scx_online_ecaps(struct rq *rq);
 void scx_offline_ecaps(struct rq *rq);
 void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu);
@@ -51,6 +52,7 @@ static inline void scx_free_pshards(struct scx_sched *sch) {}
 static inline s32 scx_alloc_pshards(struct scx_sched *sch) { return 0; }
 static inline void scx_init_root_caps(struct scx_sched *sch) {}
 static inline void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev) {}
+static inline void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch) {}
 static inline void scx_online_ecaps(struct rq *rq) {}
 static inline void scx_offline_ecaps(struct rq *rq) {}
 static inline void scx_discard_ecaps_to_sync(s32 cpu, struct scx_sched_pcpu *pcpu) {}
-- 
2.54.0

