Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0438E8B0;
	Fri,  3 Jul 2026 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065751; cv=none; b=TxsGOWzNAZnfgQ7/5Z7IsQfZUoPpgeAnaAJ1dZlEPMkC6I7n24Hiw5/tg9e5WIOsOpFrZqKmCPifni4Q0L6OqOla7ZBAdEelLqt8hY2lG0wP9jC2up7dEOjNq3ETao6HeWRa2FAYk1zW5Va24YCNYe7iFxczCvNEFVo1868i/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065751; c=relaxed/simple;
	bh=3sYUZlqV95gBaQngTksCVE20oKxt85dh4tU4uP/E9y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBIy9KOQenBlhVayrtTv7m0vKrse6esCti6RatcmeFrWBk+AKkLgUxBGXulsHBAJpsu7o30BOErk1adAkVMR0xzWOdzvWzaVrZvjUzJPNjm/kSnZQ7c2ksSm1paI9UykmseAigfoF16T+J7LbcAXVgwhm7+hfqcW5F7So0MqN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgbPC73K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgbPC73K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF301F00A3A;
	Fri,  3 Jul 2026 08:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065749;
	bh=5YRtSpwmyHcc6aEFaS1fwlg42aHAsKVYT+v991TB15Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LgbPC73KXPHpKyrq/5PMUgAaq8MIPAb+UBX0lego6ZXcjgkzU3KpftUuJT1npLz/m
	 BME7MIezGnToYyCnye4+wjVhKWQ1RTMu1nSBtiOI4RTow/J3RRR0Js0BwYq47GAMcG
	 GaFXWhqxfz+dP+CkEjTYhjbWB84JqFq8gS3Ckhk7bdH40C86T5dnCrSnpUeDHXxHW5
	 yh/TpWt4gQe3HsQotvfxULykZrBjrFFs3ec0FGEpPGGgWtIf/9oPh2ocH5FdkcQs5l
	 3PAut8oUoP2guzZFR1tNdxP0SywhOeeHtoEBWpzdJbNJGZ4m+q/nmXDSn57vNBMN4J
	 rHlcrA9Erpbsw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3 29/32] sched_ext: Replay ecaps notifications suppressed by bypass
Date: Thu,  2 Jul 2026 22:01:56 -1000
Message-ID: <20260703080159.2314350-30-tj@kernel.org>
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
index bd934928d31d..4c5c80393c2d 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5597,8 +5597,10 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
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
index 90caf76db8bf..15edcf4f81ee 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -550,6 +550,41 @@ void scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
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

