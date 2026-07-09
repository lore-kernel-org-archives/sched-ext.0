Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95743D88FA;
	Thu,  9 Jul 2026 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637466; cv=none; b=byKKgIy4pwiYtu3KubSTD4TMkZByBtKJMIVTdvw1lniHSzKrbaZyXRCfG8ATNzlZpnZBC1a735wGtp0ZE4Y7lzaFaxM2gU9gLJqeGvW/QPoLbH/sS1xLSmgqK+OhE6efGN7UP0nzwUPIwJKRS6zneR/4X/QCmO1drcmZ3JUZcmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637466; c=relaxed/simple;
	bh=3n5t2QGvS6JZy0D0t1d8Bd9Mcx3eF6LsoHNFksZYgK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q98NFZn3R3M3u9D6R+JM9/qHiRcWvgpR9o7rYlGzN7mWVr6Ww3O85Aw5AjUd0yNIgGeIlwU1sn/c3Po2oto8pxg5wY8AcxNosRKTiTUMUU8J7sZVURp1do/DXNp5Qg9ZTA4r6bgr7nF19hVgiom2E0JuwR+fChJAIx7t/H5l3CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFAWXGYX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFAWXGYX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C1E1F000E9;
	Thu,  9 Jul 2026 22:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637463;
	bh=S9uQzdE7/FWYO3BRh5uj+g5rWIjabr6tATKrtSUfdfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LFAWXGYXUFrdE8d2AEemJsjOtVU5rxPBn1iEKLej4AE/AAKOHE8LtDdTSEOP/vXbz
	 GFhkPlBGiW3m7E9f3rN7xWV6P6ri7Xj81PLS+SfWO6JRgrTINR0pkT86S3kDZceUKB
	 Idyh0SZ9I4oF3QQkVR8yTsJYhUqMRXx2qfhDZnh9jRTc0NyAZ+/TbzWqdXAMjwb5o9
	 z/ZiJewsmj/sH8/K5eB/muBovGaMozRfBns/KHBfW7szdSIBxiKLU4F2vSCq1kPecm
	 sT7npODQjv8OcNTWG8/Tv90G1RKdjnl88R/mfSDPfwo+C65ziU+gyb2F+pYkJfP7C0
	 nRTlkDh3oTuJw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 sched_ext/for-7.3 19/33] sched_ext: Add SCX_ENQ_IGNORE_CAPS for in-place restore
Date: Thu,  9 Jul 2026 12:50:27 -1000
Message-ID: <20260709225041.1695495-20-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709225041.1695495-1-tj@kernel.org>
References: <20260709225041.1695495-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A SAVE/RESTORE requeue re-inserts a running task in place and is immediately
followed by set_next_task_scx(). It is not a real scheduling event: the task
is already admitted to its cid and must return to the local DSQ
unconditionally.

scx_caps_for_enq() maps an enqueue to the cap its local-DSQ insert requires.
Add SCX_ENQ_IGNORE_CAPS, set it on the RESTORE-in-place branch of
enqueue_task_scx(), and have scx_caps_for_enq() require no caps for it, so
the cid admission gate never diverts an in-place restore to the reject DSQ.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 7 +++++--
 kernel/sched/ext/internal.h | 1 +
 kernel/sched/ext/sub.h      | 3 +++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 3e1829126fee..80c8971638f9 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1878,10 +1878,13 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int core_enq_
 	 * Restoring a running task will be immediately followed by
 	 * set_next_task_scx() which expects the task to not be on the BPF
 	 * scheduler as tasks can only start running through local DSQs. Force
-	 * direct-dispatch into the local DSQ by setting the sticky_cpu.
+	 * direct-dispatch into the local DSQ by setting the sticky_cpu. Mark
+	 * IGNORE_CAPS to force entry into the local DSQ.
 	 */
-	if (unlikely(enq_flags & ENQUEUE_RESTORE) && task_current(rq, p))
+	if (unlikely(enq_flags & ENQUEUE_RESTORE) && task_current(rq, p)) {
 		sticky_cpu = cpu_of(rq);
+		enq_flags |= SCX_ENQ_IGNORE_CAPS;
+	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		WARN_ON_ONCE(!task_runnable(p));
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index a360d312702b..079ee941b343 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1568,6 +1568,7 @@ enum scx_enq_flags {
 	SCX_ENQ_DSQ_PRIQ	= 1LLU << 57,
 	SCX_ENQ_NESTED		= 1LLU << 58,
 	SCX_ENQ_GDSQ_FALLBACK	= 1LLU << 59,	/* fell back to global DSQ */
+	SCX_ENQ_IGNORE_CAPS	= 1LLU << 60,	/* admit to local DSQ ignoring caps */
 };
 
 enum scx_deq_flags {
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 51400e174cd0..a1a2825dc04e 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -106,6 +106,9 @@ static inline u64 scx_missing_caps(struct scx_sched *sch, s32 cpu, u64 needed)
 /* map @enq_flags to the SCX_CAP_* bit required for the local-DSQ insert */
 static inline u64 scx_caps_for_enq(u64 enq_flags)
 {
+	/* a restored task must be put into the local DSQ regardless of caps */
+	if (enq_flags & SCX_ENQ_IGNORE_CAPS)
+		return 0;
 	return 0;
 }
 
-- 
2.55.0

