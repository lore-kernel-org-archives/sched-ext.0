Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792705126;
	b=taFpDJswZuh4X7GTiZCeE6o/CwQcLPFzKbNmYVih5juzz9s6v08nqlDKAkMbf+LfbBGo
	 DeUS98SAVPUjDzf3aMLERrY3jAIMZc1xRA9lfk2J36VZLRJpR63ZnB7f8x/klMB/rWqW0
	 hjzC6Cxb1apUOL/1NoS7Blci55blK0bPyG1oAJEugB3N9m6pTfpPhj93Jf6WmJUJou04j
	 zNyzHME8eMmMWzQZqxtOiKstSC94pviSl4MlOeRkWTY9m15aptMGMaRSu8Tz2XChxVMzb
	 19DnjQ2P//FbmAvvMzjheMhGPw8CDGOAopZujGvfU426uGMgRAKQpwFr7uEwfjCQQJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792705126;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QvxbeBlGdvi3A/lGYHoKVO5W3GD8xAvvg5tTDVndxU8=;
	b=NGmYjE7vNfGZu06FA81wvZVMUGhQFKawBceAlVPoONlT+0CwMhc/YDyKDcB7J6qEJBsD
	 Efx5WxojL5UgtqA6MrDKuM/uqc21iyogarqJU2qzgUKh4Ifl6khOwHMq9elgDlstUfHNa
	 4r/KzcRHHFvoOmzgVSd3jaI8tjNf7IbdD9coG2Zu1Uuvj1sC3a9LwITit8p7H2ENQCsca
	 IrlB+8gA1ktFFRWjcdKSOPJVRNwO6s7FXkjokKOr6P8c9wqZpfsr5Msn09Y2lYnwoFdAJ
	 //YKdHpQtU4RXwIJsDrQpR6SJh8Z/BG07P9Ul1cad0EGyaQSn6W6cdOrW1cnphWIcRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B930iBwa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A19660A260C;
	Thu, 22 Oct 2026 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B930iBwa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B80A1F01828;
	Thu, 22 Oct 2026 21:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792705125;
	bh=QvxbeBlGdvi3A/lGYHoKVO5W3GD8xAvvg5tTDVndxU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B930iBwal1qyLHDW/1Q1THu78MhtzTeOAz3i5zHBQptgKxLzA9peLmdjm0YSTqLHc
	 8ZQz0sI9z21RBb7gZx1bTfCc/nQzP1j031sS1N3EZqa0VZ1A7tvCkmwwHWUxR/QYG4
	 l7hp6kZQFshdYHsgywDtvZMs38Zh8ABzH6RQIqdtZhFTSHcGYxxaRTzZqgmxNPQ82l
	 Vhcgru998Q8ZJUXcTa4ttDzZnKZPsuNaKum1dg+KduaZGymm+vOXbGs4mvo1kGFbtE
	 1QOJVn1IGQlN5UsNzF/ZPfZEAvGyzed1cM4FG+pfQPyFwCZwmym2plHgkX+9K5sbCh
	 JNRWWMjix9G0Q==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/14] sched_ext: Refuse extending a kernel slice
Date: Thu, 22 Oct 2026 11:38:30 -1000
Message-ID: <20261022213836.2259069-9-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022213836.2259069-1-tj@kernel.org>
References: <20261022213836.2259069-1-tj@kernel.org>
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

A rescuee can keep running after its grant is served, on a cpu its scheduler
has lost. The write rules deny a slice extension only where the scheduler
lacks SCX_CAP_BASE on the cpu, and a scheduler holding BASE but not ENQ can
have a task under rescue there:

 1. the scheduler extends the rescuee's slice
 2. BASE is revoked. The cap-revoke eviction skips the rescuee.
 3. the grant is served and scx_rescue_charge() ends the rescue
 4. the task runs out the extension on the cpu its scheduler lost, outside
    the rescue's bandwidth

A scheduler shortens or zeroes a rescuee's slice to preempt it, and
scx_rescue_keep() resumes the grant afterwards. An extension serves no such
purpose.

Refuse extending a kernel slice in both scheduler write paths, the direct
write in scx_bpf_task_set_slice() and the out-of-band application, counted
in SCX_EV_SLICE_DENIED like an extension without BASE. Shortening stays
allowed.

scx_rescue_keep()'s restore of the remainder raises the slice from zero.
Like the kernel's other slice writes, it goes through scx_set_task_slice()
and not the scheduler write paths.

Fixes: 5fd501744b10 ("sched_ext: Add bandwidth-limited rescue execution for stranded tasks")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |  2 +-
 kernel/sched/ext/ext.c    | 29 ++++++++++++++++++-----------
 kernel/sched/ext/sub.c    | 10 +++++-----
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index fcf85b87fdd4..f3564581c317 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -113,7 +113,7 @@ enum scx_ent_flags {
 	 *   alone.
 	 * - Reenqueue scans skip the task.
 	 * - put_prev_task_scx() keeps a preempted task on the local DSQ.
-	 * - Scheduler slice writes and preemption still apply.
+	 * - Schedulers may shorten the slice, never extend it.
 	 */
 	SCX_TASK_KERNEL_SLICE	= 1 << 8, /* slice owned by the kernel */
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 73d49dd07255..a35be2c5b453 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1354,7 +1354,8 @@ enum scx_slice_oob_consts {
  * p->scx.slice_oob, applied under @p's rq lock at the next slice consideration.
  *
  * While %SCX_TASK_PROTECTED is set, every scheduler-reachable slice update is
- * refused. See set_task_slice_keep_oob().
+ * refused. See set_task_slice_keep_oob(). A kernel slice, see
+ * %SCX_TASK_KERNEL_SLICE, can be shortened but not extended.
  *
  * dsq_vtime orders the next PRIQ insertion and has no running-side consumer, so
  * scx_bpf_task_set_dsq_vtime() writes it directly. Fork-time init and direct
@@ -1480,9 +1481,9 @@ static void set_task_slice_oob(struct scx_sched *sch, struct task_struct *p, u64
 /*
  * Apply a pending out-of-band slice request under @rq's lock. A request whose
  * packed id no longer matches @p's current owner is dropped. An extension needs
- * baseline cpu access on @p's cid, shortening is always allowed, and a
- * protected slice refuses both. %SCX_EV_SLICE_DENIED counts the denials. See
- * the write rules above.
+ * baseline cpu access on @p's cid and is refused on a kernel slice. Shortening
+ * is always allowed. A protected slice refuses both. %SCX_EV_SLICE_DENIED
+ * counts the denials. See the write rules above.
  */
 static void apply_task_slice_oob(struct rq *rq, struct task_struct *p)
 {
@@ -1506,7 +1507,8 @@ static void apply_task_slice_oob(struct rq *rq, struct task_struct *p)
 	slice = dur == SCX_SLICE_OOB_DUR_MASK ? SCX_SLICE_INF : dur;
 
 	if (slice > p->scx.slice &&
-	    unlikely(scx_missing_caps(scx_task_sched(p), cpu_of(rq), SCX_CAP_BASE))) {
+	    unlikely(scx_task_has_kernel_slice(p) ||
+		     scx_missing_caps(scx_task_sched(p), cpu_of(rq), SCX_CAP_BASE))) {
 		__scx_add_event(scx_task_sched(p), SCX_EV_SLICE_DENIED, 1);
 		return;
 	}
@@ -10292,10 +10294,11 @@ __bpf_kfunc_start_defs();
  * rules above for the ownership model.
  *
  * Raising the slice is honored only while the scheduler holds %SCX_CAP_BASE on
- * @p's cpu, otherwise it is counted in %SCX_EV_SLICE_DENIED. Shortening is
- * always allowed. On the stashed path the slice is packed into an atomic64_t
- * with the scheduler id and a flag bit, so a slice too large to fit is clamped
- * and counted in %SCX_EV_SLICE_CLAMPED. %SCX_SLICE_INF is preserved.
+ * @p's cpu, and never on a kernel slice, see %SCX_TASK_KERNEL_SLICE. A refused
+ * raise is counted in %SCX_EV_SLICE_DENIED. Shortening is always allowed. On
+ * the stashed path the slice is packed into an atomic64_t with the scheduler id
+ * and a flag bit, so a slice too large to fit is clamped and counted in
+ * %SCX_EV_SLICE_CLAMPED. %SCX_SLICE_INF is preserved.
  *
  * Return %true on success, %false if @p is not on the calling scheduler.
  */
@@ -10333,9 +10336,13 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
 		return true;
 	}
 
-	/* under the rq lock: apply now, extensions gated on baseline access */
+	/*
+	 * @p's rq is locked, so apply now. An extension needs baseline access
+	 * and is refused on a kernel slice.
+	 */
 	if (slice > p->scx.slice &&
-	    unlikely(scx_missing_caps(sch, cpu_of(locked_rq), SCX_CAP_BASE))) {
+	    unlikely(scx_task_has_kernel_slice(p) ||
+		     scx_missing_caps(sch, cpu_of(locked_rq), SCX_CAP_BASE))) {
 		__scx_add_event(sch, SCX_EV_SLICE_DENIED, 1);
 		return true;
 	}
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 825055208ab3..4dff3183d33f 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -581,11 +581,11 @@ static void scx_rescue_timer_arm(struct rq *rq)
  * @p: task being admitted, off any DSQ
  * @slice: CPU time to grant
  *
- * The slice is a kernel slice, see %SCX_TASK_KERNEL_SLICE. The schedulers keep
- * their normal control over @p and may preempt or reslice it. @slice is
- * measured on served CPU time against the snapshot taken here, so neither
- * shortens the rescue, see scx_rescue_charge() and scx_rescue_keep(). Prolonged
- * denial escalates into protected execution, see scx_rescue_timerfn().
+ * The slice is a kernel slice, see %SCX_TASK_KERNEL_SLICE. The schedulers may
+ * preempt @p or shorten its slice, never extend it. @slice is measured on
+ * served CPU time against the snapshot taken here, so neither shortens the
+ * rescue, see scx_rescue_charge() and scx_rescue_keep(). Prolonged denial
+ * escalates into protected execution, see scx_rescue_timerfn().
  */
 static void scx_rescue_admit(struct rq *rq, struct task_struct *p, s64 slice)
 {
-- 
2.56.0

