Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2C72FE050;
	Sun,  9 Nov 2025 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762713080; cv=none; b=Rj4yKo4C/4jQT4KKd/aNhcMnZYpGuJdXXwO8Gi05Gck3QYYofWVbAJjZXqNoIWl5Rtcr0wT2imXM87JwNGOZE8Vje7YpDXPG6Rk3bP70MZCXlZihgyl0nHzbK0QeMX5VIfAQ8t17NOfpiiVq+UVVlOMuLwnrH+tyOdKHdxL/dEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762713080; c=relaxed/simple;
	bh=QGnPg2dB5OoQFrkWMpAhDJYYI25oNNYd5xllyUaf70M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+7kiR/upRfnG9vLSJcZKA6OGbY2gNadqa0m7zcmZ432En8da50rTom3o3mOZ5b8DyScuCt5Lfi2JQEV6X7WbX92HdB4a2EbW4Z/3zfaVo/KmEbeiOU4cHXi09A0PYPCnJLayMsFWJdSvApoD9I0nmG5B5x39CQy57w2+E0H5kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsnCWWSe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsnCWWSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401D3C19423;
	Sun,  9 Nov 2025 18:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762713080;
	bh=QGnPg2dB5OoQFrkWMpAhDJYYI25oNNYd5xllyUaf70M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsnCWWSeQp8S4Jra9ov+l44W9qTEJIAqeL7KiCN+e5aHp9dWKlOPsnk9/eSQn47/I
	 rk6TImd2wBfFjHHAyeYTZkTBHqzeLzZ7gU8zlZl6YFL2taRYSlMX545Dx+o1oSiFiF
	 SerKnBiuUbJTEmJIFKNBbory9xQfs42An7/IXp+Yw+GJEMMF+roMvsLSvkxQ8hyrzj
	 sG7eLAbGBLkBmnU+R8bGKk/yQlLXUo8dFxTkfW7ZSNro2W5RSSEMLopDqf/+BZZrhh
	 Fpmt25E6PQ1RIpdtGPSAhA8EX0iOvP6jud2hQcD6dKOYs64dr0TsQYvjHITcPxFvXc
	 +/HsNlM1I0nzQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/13] sched_ext: Exit dispatch and move operations immediately when aborting
Date: Sun,  9 Nov 2025 08:31:05 -1000
Message-ID: <20251109183112.2412147-7-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109183112.2412147-1-tj@kernel.org>
References: <20251109183112.2412147-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

62dcbab8b0ef ("sched_ext: Avoid live-locking bypass mode switching") introduced
the breather mechanism to inject delays during bypass mode switching. It
maintains operation semantics unchanged while reducing lock contention to avoid
live-locks on large NUMA systems.

However, the breather only activates when exiting the scheduler, so there's no
need to maintain operation semantics. Simplify by exiting dispatch and move
operations immediately when scx_aborting is set. In consume_dispatch_q(), break
out of the task iteration loop. In scx_dsq_move(), return early before
acquiring locks.

This also fixes cases the breather mechanism cannot handle. When a large system
has many runnable threads affinitized to different CPU subsets and the BPF
scheduler places them all into a single DSQ, many CPUs can scan the DSQ
concurrently for tasks they can run. This can cause DSQ and RQ locks to be held
for extended periods, leading to various failure modes. The breather cannot
solve this because once in the consume loop, there's no exit. The new mechanism
fixes this by exiting the loop immediately.

The bypass DSQ is exempted to ensure the bypass mechanism itself can make
progress.

Reported-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 62 ++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 44 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 905d01f74687..afa89ca3659e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1821,48 +1821,11 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 	return dst_rq;
 }
 
-/*
- * A poorly behaving BPF scheduler can live-lock the system by e.g. incessantly
- * banging on the same DSQ on a large NUMA system to the point where switching
- * to the bypass mode can take a long time. Inject artificial delays while the
- * bypass mode is switching to guarantee timely completion.
- */
-static void scx_breather(struct rq *rq)
-{
-	u64 until;
-
-	lockdep_assert_rq_held(rq);
-
-	if (likely(!READ_ONCE(scx_aborting)))
-		return;
-
-	raw_spin_rq_unlock(rq);
-
-	until = ktime_get_ns() + NSEC_PER_MSEC;
-
-	do {
-		int cnt = 1024;
-		while (READ_ONCE(scx_aborting) && --cnt)
-			cpu_relax();
-	} while (READ_ONCE(scx_aborting) &&
-		 time_before64(ktime_get_ns(), until));
-
-	raw_spin_rq_lock(rq);
-}
-
 static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 			       struct scx_dispatch_q *dsq)
 {
 	struct task_struct *p;
 retry:
-	/*
-	 * This retry loop can repeatedly race against scx_bypass() dequeueing
-	 * tasks from @dsq trying to put the system into the bypass mode. On
-	 * some multi-socket machines (e.g. 2x Intel 8480c), this can live-lock
-	 * the machine into soft lockups. Give a breather.
-	 */
-	scx_breather(rq);
-
 	/*
 	 * The caller can't expect to successfully consume a task if the task's
 	 * addition to @dsq isn't guaranteed to be visible somehow. Test
@@ -1876,6 +1839,17 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 	nldsq_for_each_task(p, dsq) {
 		struct rq *task_rq = task_rq(p);
 
+		/*
+		 * This loop can lead to multiple lockup scenarios, e.g. the BPF
+		 * scheduler can put an enormous number of affinitized tasks into
+		 * a contended DSQ, or the outer retry loop can repeatedly race
+		 * against scx_bypass() dequeueing tasks from @dsq trying to put
+		 * the system into the bypass mode. This can easily live-lock the
+		 * machine. If aborting, exit from all non-bypass DSQs.
+		 */
+		if (unlikely(READ_ONCE(scx_aborting)) && dsq->id != SCX_DSQ_BYPASS)
+			break;
+
 		if (rq == task_rq) {
 			task_unlink_from_dsq(p, dsq);
 			move_local_task_to_local_dsq(p, 0, dsq, rq);
@@ -5635,6 +5609,13 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
 
+	/*
+	 * If the BPF scheduler keeps calling this function repeatedly, it can
+	 * cause similar live-lock conditions as consume_dispatch_q().
+	 */
+	if (unlikely(scx_aborting))
+		return false;
+
 	/*
 	 * Can be called from either ops.dispatch() locking this_rq() or any
 	 * context where no rq lock is held. If latter, lock @p's task_rq which
@@ -5655,13 +5636,6 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 		raw_spin_rq_lock(src_rq);
 	}
 
-	/*
-	 * If the BPF scheduler keeps calling this function repeatedly, it can
-	 * cause similar live-lock conditions as consume_dispatch_q(). Insert a
-	 * breather if necessary.
-	 */
-	scx_breather(src_rq);
-
 	locked_rq = src_rq;
 	raw_spin_lock(&src_dsq->lock);
 
-- 
2.51.1

