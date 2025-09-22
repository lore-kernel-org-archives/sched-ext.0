Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196953112B6;
	Mon, 22 Sep 2025 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557679; cv=none; b=CdFJsxZyHu+bwvC9Q5n9GeQtagZxfV5Pt+f/T5pW2g/yWRGYN5xV9YVlGYsGLz62QGIB7uu5iHPZSVW8noY5dXbRd9RpuTCcurNPFtw6PN5Q4yu1Q5m4CiWah4H8X/lbDwa0SZrsD77so2zF62i5PGUhLhYfB0HiaTgbSPc0a9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557679; c=relaxed/simple;
	bh=jS8B27EZgJNAB+RxeI7M5SPmwNU6LGe4HCSeTNE5PIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCOoKD+/0HBlqMWgtNJQRGxDYhCCkU3Uw52uyB1V1MqQrEGVbbhhJW7b38uz2zmlk67gMkDe6/0fBx+uipN9KeSjBDEYCM+Ac1ToQEqBFq24jqaafMF6h7eDpnKcEU8GX5rIK4xtQFwDF4F8hsxloK9i6KAiWuk/okN+ljpS1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQyixq4m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQyixq4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0ADC4CEF0;
	Mon, 22 Sep 2025 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758557678;
	bh=jS8B27EZgJNAB+RxeI7M5SPmwNU6LGe4HCSeTNE5PIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQyixq4mAykto4JCE1pYf2h2kHVI5D0ut1hkym35nVjdZuIcTne9jtMGjzoYN1bVX
	 J2F3Fgpenkr1TUsWPQ9XiY+Z+5WuekTkc/2bCuxz31jafrlOP/zst6LwvR95+YLm6i
	 Bjm6zP/X3Wobknf1CFeyb3PBb6Ps7eFTQKlmLydbssGdE65Ea37N8P7alcSoTk0eGU
	 aYymOgEWYa0NqrqmKtt7scjnXr1gBDg6LvC9JgYnPbYHO3g/ApwDU3f6OhOVBYCUg2
	 cRXtBbcnhzDnscRBEE4gM66ssa6Xo3Fg9atv1sH/DLLV0advetnNtSrmB/PdCCxQ4B
	 oJ2o5gtJ7v52g==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/7] sched_ext: Separate out scx_kick_cpu() and add @sch to it
Date: Mon, 22 Sep 2025 06:14:30 -1000
Message-ID: <20250922161436.358949-2-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922161436.358949-1-tj@kernel.org>
References: <20250922161436.358949-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for multiple scheduler support, separate out scx_kick_cpu()
from scx_bpf_kick_cpu() and add the @sch parameter to it. scx_bpf_kick_cpu()
now acquires an RCU read lock, reads $scx_root, and calls scx_kick_cpu()
with it if non-NULL. The passed in @sch parameter is not used yet.

Internal uses of scx_bpf_kick_cpu() are converted to scx_kick_cpu(). Where
$sch is available, it's used. In the pick_task_scx() path where no
associated scheduler can be identified, $scx_root is used directly. Note
that $scx_root cannot be NULL in this case.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d131e98156ac..560ac5a575bd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -136,7 +136,7 @@ static struct kset *scx_kset;
 #include <trace/events/sched_ext.h>
 
 static void process_ddsp_deferred_locals(struct rq *rq);
-static void scx_bpf_kick_cpu(s32 cpu, u64 flags);
+static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 static void scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
 		      s64 exit_code, const char *fmt, va_list args);
 
@@ -2125,10 +2125,10 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * balance(), we want to complete this scheduling cycle and then
 		 * start a new one. IOW, we want to call resched_curr() on the
 		 * next, most likely idle, task, not the current one. Use
-		 * scx_bpf_kick_cpu() for deferred kicking.
+		 * scx_kick_cpu() for deferred kicking.
 		 */
 		if (unlikely(!--nr_loops)) {
-			scx_bpf_kick_cpu(cpu_of(rq), 0);
+			scx_kick_cpu(sch, cpu_of(rq), 0);
 			break;
 		}
 	} while (dspc->nr_tasks);
@@ -2417,7 +2417,8 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 		p = first_local_task(rq);
 		if (!p) {
 			if (kick_idle)
-				scx_bpf_kick_cpu(cpu_of(rq), SCX_KICK_IDLE);
+				scx_kick_cpu(rcu_dereference_sched(scx_root),
+					     cpu_of(rq), SCX_KICK_IDLE);
 			return NULL;
 		}
 
@@ -3721,7 +3722,7 @@ static void scx_clear_softlockup(void)
  *
  * - pick_next_task() suppresses zero slice warning.
  *
- * - scx_bpf_kick_cpu() is disabled to avoid irq_work malfunction during PM
+ * - scx_kick_cpu() is disabled to avoid irq_work malfunction during PM
  *   operations.
  *
  * - scx_prio_less() reverts to the default core_sched_at order.
@@ -5809,17 +5810,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
 
 __bpf_kfunc_start_defs();
 
-/**
- * scx_bpf_kick_cpu - Trigger reschedule on a CPU
- * @cpu: cpu to kick
- * @flags: %SCX_KICK_* flags
- *
- * Kick @cpu into rescheduling. This can be used to wake up an idle CPU or
- * trigger rescheduling on a busy CPU. This can be called from any online
- * scx_ops operation and the actual kicking is performed asynchronously through
- * an irq work.
- */
-__bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags)
+static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 {
 	struct rq *this_rq;
 	unsigned long irq_flags;
@@ -5872,6 +5863,26 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags)
 	local_irq_restore(irq_flags);
 }
 
+/**
+ * scx_bpf_kick_cpu - Trigger reschedule on a CPU
+ * @cpu: cpu to kick
+ * @flags: %SCX_KICK_* flags
+ *
+ * Kick @cpu into rescheduling. This can be used to wake up an idle CPU or
+ * trigger rescheduling on a busy CPU. This can be called from any online
+ * scx_ops operation and the actual kicking is performed asynchronously through
+ * an irq work.
+ */
+__bpf_kfunc void scx_bpf_kick_cpu(s32 cpu, u64 flags)
+{
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = rcu_dereference(scx_root);
+	if (likely(sch))
+		scx_kick_cpu(sch, cpu, flags);
+}
+
 /**
  * scx_bpf_dsq_nr_queued - Return the number of queued tasks
  * @dsq_id: id of the DSQ
-- 
2.51.0

