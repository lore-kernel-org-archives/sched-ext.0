Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A094B53FB;
	Sat,  5 Sep 2026 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788624608; cv=none; b=IfcH+l4twt4kxnhHj6H/Yq8TK9BNK1HlWinf5r3ZrpM4kaYDsdeoZhOyDZp8biTdj6CGYMWIbuWSUBEiST5zzxoe3gX0KtIOlmfMobaXNJg06D4/p3hsSx6eM3xRyxgmqayZS7syLAUTl0DknH59sKfNKOo9tKyNoRkZBirlYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788624608; c=relaxed/simple;
	bh=zaBXCccT5srNhNeySNEZHEu98nuUxgWaDl9kDcuxx7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+L4EKJ0j82DKPT7WJIKup7K0NtqUgygd3R0XbF+AurxjtkjV5458GAUZSBMFJI2vbj7j+nqcoK/zZLQqpKhLr9N+YLiCkhP9R9pAl9H7Kme7TNSJrccfYftG/x16X2VtF00fmP4djS3EaPSxlrw8Fk2J/85GYeU3Y4PUlQ/XqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTpd3hCR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTpd3hCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61401F00A3D;
	Sat,  5 Sep 2026 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788624601;
	bh=XUNU2t8YQzAspKxWGe5BBztG9bFMG4zkyrZuHadh+d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BTpd3hCRywQMq5BqIExAkbrFTiOfFky3tIdMJMMhtGL3gdGc+FBsj7571bZCExOmV
	 kpXHiYeEh4L2UBEMOKfe3/h1Vo/8WndxQO9TpD5c0e2naukKDNcs+ai37KblWFOdgF
	 51MRLVZ52+k/wKhgiIc25tJpHiouKQpc3AxhuE8WaJuFctoVif4rWm7B43kuoy6TvH
	 q57ZsnWIAquMcMJghKrCYrFAEHxw7DezVEErGg3iqo3V0WJVNb3a3GJtlkCAppWB4F
	 K4FfYgKIyE8qMUZWWY9R00xMsRgJRoCkDVOyz2ymrI5/HcX4QLAJbnCjaCFMuCiFVL
	 Bm6HkBwV7cdaA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3-fixes 1/4] sched_ext: Rename sch to root_sch in dispatch_one()
Date: Sat,  5 Sep 2026 06:09:55 -1000
Message-ID: <20260905160958.1565156-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905160958.1565156-1-tj@kernel.org>
References: <20260905160958.1565156-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dispatch_one() uses the root scheduler for everything it does, including the
two decisions to keep running @prev, which are wrong when @prev belongs to a
sub-scheduler. The function has to deal with @prev's scheduler too. Rename
the root's local from sch to root_sch for clarity and to make room for it.
No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 7e414a7c53fc..120540cdda74 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2919,7 +2919,7 @@ static inline void maybe_queue_balance_callback(struct rq *rq)
 
 static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev)
 {
-	struct scx_sched *sch = scx_root_protected_live();
+	struct scx_sched *root_sch = scx_root_protected_live();
 	enum scx_dsp_verdict verdict;
 	s32 cpu = cpu_of(rq);
 
@@ -2928,7 +2928,7 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 
 	scx_process_sync_ecaps(rq, prev);
 
-	if ((sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT) &&
+	if ((root_sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT) &&
 	    unlikely(rq->scx.cpu_released)) {
 		/*
 		 * If the previous sched_class for the current CPU was not SCX,
@@ -2936,8 +2936,8 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 		 * core. This callback complements ->cpu_release(), which is
 		 * emitted in switch_class().
 		 */
-		if (sch->ops.cpu_acquire)
-			SCX_CALL_OP(sch, cpu_acquire, rq, cpu, NULL);
+		if (root_sch->ops.cpu_acquire)
+			SCX_CALL_OP(root_sch, cpu_acquire, rq, cpu, NULL);
 		rq->scx.cpu_released = false;
 	}
 
@@ -2955,7 +2955,7 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 		 * test.
 		 */
 		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice &&
-		    !scx_bypassing(sch, cpu)) {
+		    !scx_bypassing(root_sch, cpu)) {
 			verdict = SCX_DSP_PREV;
 			goto has_tasks;
 		}
@@ -2967,7 +2967,7 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 		goto has_tasks;
 	}
 
-	verdict = scx_dispatch_sched(sch, rq, prev, false);
+	verdict = scx_dispatch_sched(root_sch, rq, prev, false);
 	if (verdict != SCX_DSP_NONE)
 		goto has_tasks;
 
@@ -2976,9 +2976,9 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 	 * %SCX_OPS_ENQ_LAST is in effect.
 	 */
 	if ((prev->scx.flags & SCX_TASK_QUEUED) &&
-	    (!(sch->ops.flags & SCX_OPS_ENQ_LAST) || scx_bypassing(sch, cpu)) &&
+	    (!(root_sch->ops.flags & SCX_OPS_ENQ_LAST) || scx_bypassing(root_sch, cpu)) &&
 	    scx_task_can_stay_on_cpu(rq, prev)) {
-		__scx_add_event(sch, SCX_EV_DISPATCH_KEEP_LAST, 1);
+		__scx_add_event(root_sch, SCX_EV_DISPATCH_KEEP_LAST, 1);
 		verdict = SCX_DSP_PREV;
 		goto has_tasks;
 	}
-- 
2.55.0

