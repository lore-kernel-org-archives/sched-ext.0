Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060283;
	b=N4/fcJd9M9Iimuz5WX6zS7rujFyYr5QF9HxE/1trvu3S5rCGMTAR+k7A6aXYPmqJPfKC
	 v7iZk3YtSP27rBM7xnwbw/PWAEZwXoWkbD7mHEiWFAChoeyyvYhjAfDdo46UA3rkDBg2a
	 RurVvVWR4pbo2VGPW6aMFrWhnfpAssOc4Sm0PwFHECoktLgnE0SI7UySjGfKXq6C1YppQ
	 39J9daRRu+Yczm/ZdLvmaQedpb91O0XA7VgpD9sUe8Vh19/xan1Sui7b9fhAWaDQHU3QW
	 Z4uH4nO2x85o95KKLCbiXiDQZHSTc+wXD752cIXq0Iok8AyksyVgI6pfurVsuqlMtsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060283;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HG924LSXAU+aotoX5xy8VjXBrAW9e7ixmtHG/GTfBuM=;
	b=eUSqKFb3cfoEE+D0SzDLtHibCFJklK8EBe9Oqc0GVGDuXLGJ15uSH6DXuUSDZQWr/HNt
	 JIoQ63aoTKyNjZlExlKgm/j9ou1ZAzKGlKiLlLchVrk3JrrD7P5jH1mxRK8TW+slHNsBr
	 aLJRGobTo/EbpvL5B7MkM2T4Uzdl8r7aoTkj4UfhfstABFHUTxM/gPj4Sw1VL02iO3VDz
	 1N3KxVOEfsYcfFU92KDcZZmzCPXay7LiJ7bEiybTs0SBYqaQh0Rb7wLt+5c8Eh5q+8NbZ
	 EX7CjqmPpvqUEyZaX3i0Bl8va/+f+D+lX8/aiZqTFJaKNdX5CeGrDBD573Q9kdVU3Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8wIE35j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3BD60A2617;
	Tue, 27 Oct 2026 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8wIE35j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A283B1F031E3;
	Tue, 27 Oct 2026 00:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060282;
	bh=HG924LSXAU+aotoX5xy8VjXBrAW9e7ixmtHG/GTfBuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n8wIE35jTU7OBqdUJoVCVK/Jcoq2Qmo84Rvp+VFcuxFTGTNOop0gbvwkUZdRYfFbw
	 wqJpmkZmDfyPgFH/VKq80FGyo7rgDZtoJb8FsLw5oMyZv3JA0zKAvBXziOK5fFByZJ
	 6nZSR2XOTWWwborLXkePGthMsT4d9dKoeLRV0K/4ycAp+hBvmk5CMQg5ECNNEtS0rE
	 g4mVCDOOfABSUAsgktexET66HMnSHP6xMF95wuRxGALQfrnI1i66VkeXdIdAAJ4lNa
	 twesoRTQZe4DI32VDKDduT9Nn/2lh2hK4xbp5jIxXA78qRBDikRxYdg77yQsiZxO7B
	 I6flFDhJbiG/Q==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 12/18] sched_ext: Expire prev's slice in dispatch_one() under bypass
Date: Mon, 26 Oct 2026 14:17:43 -1000
Message-ID: <20261027001749.1821379-13-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027001749.1821379-1-tj@kernel.org>
References: <20261027001749.1821379-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next patch keeps a bypassed rescuee on the local DSQ and needs
dispatch_one() to keep it running too. dispatch_one()'s keep test refuses
any prev whose scheduler is bypassing, so another local task could run ahead
of the rescuee, even an escalated SCX_TASK_PROTECTED one. The test exists
because a cpu-form scheduler can write p->scx.slice directly from BPF, so
the slice can't be trusted under bypass.

The refusal doesn't hold anyway. Since 025b1bd41965 ("sched_ext: Implement
hierarchical bypass mode"), the host's ops.dispatch() runs while prev's
scheduler bypasses, and the post-dispatch test in scx_dispatch_sched() keeps
a queued prev with slice left without checking bypass. A task dispatched in
between waits behind prev until the next bypass tick zeroes the slice, at
most a tick.

Expire the slice before the keep test instead when prev's scheduler is
bypassing, as the bypass tick would. Neither test keeps prev on a zeroed
slice, so prev rotates. A kernel slice survives the expiry and keeps prev.
Only a sub-scheduler's task can hold one, and sub-schedulers are cid-form,
which rejects direct slice writes, so it can be trusted.

Drop the stale pointer to scx_disable_workfn(), update scx_bypass()'s
kerneldoc, and add a TODO noting that the bypass slice handling can be
cleaned up once the cpu form is deprecated and the kfuncs refuse slice
raises from a bypassing scheduler.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9e503510ba1c..dafb40c75cbc 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3376,18 +3376,33 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 	if (prev->sched_class == &ext_sched_class) {
 		update_curr_scx(rq);
 
+		/*
+		 * Under bypass, @prev's slice can't be trusted as a cpu-form
+		 * scheduler can write it directly from BPF. Skipping the keep
+		 * below is not enough as the post-dispatch test in
+		 * scx_dispatch_sched() would keep @prev on the same slice.
+		 *
+		 * Expire it as the bypass tick would, so that neither test
+		 * keeps @prev on it and @prev rotates through the bypass
+		 * enqueue. A kernel slice is left alone and the keep below
+		 * keeps @prev on it, see %SCX_TASK_KERNEL_SLICE.
+		 *
+		 * TODO: Once the cpu form is deprecated and the kfuncs refuse
+		 * slice raises from a bypassing scheduler, slices can be
+		 * trusted under bypass. This expiry, the bypass tick's zeroing
+		 * and the related slice handling can then be cleaned up.
+		 */
+		if (scx_bypassing(scx_task_sched(prev), cpu))
+			expire_task_slice(prev);
+
 		/*
 		 * If @prev is runnable & has slice left, it has priority and
 		 * fetching more just increases latency for the fetched tasks.
 		 * Tell pick_task_scx() to keep running @prev. If the BPF
 		 * scheduler wants to handle this explicitly, it should
 		 * implement ->cpu_release().
-		 *
-		 * See scx_disable_workfn() for the explanation on the bypassing
-		 * test.
 		 */
-		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice &&
-		    !scx_bypassing(scx_task_sched(prev), cpu)) {
+		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice) {
 			verdict = SCX_DSP_PREV;
 			goto has_tasks;
 		}
@@ -6917,9 +6932,10 @@ static void unbypass_renotify_idle(struct rq *rq, struct scx_sched *pos,
  * - ops.sub_ecaps_updated() and ops.sub_child_ecaps_updated() are still called.
  *   The bypassed tasks are on the bypass DSQs, out of their reach.
  *
- * - dispatch_one() does not report %SCX_DSP_PREV on non-zero slice as slice
- *   can't be trusted. Whenever a tick triggers, the running task is rotated to
- *   the tail of the queue.
+ * - dispatch_one() expires prev's slice before its keep test as the slice can't
+ *   be trusted. Each tick does the same and rotates the running task to the
+ *   tail of the queue. A kernel slice is left alone, see
+ *   %SCX_TASK_KERNEL_SLICE.
  *
  * - pick_next_task() suppresses zero slice warning.
  *
-- 
2.56.0

