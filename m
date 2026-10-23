Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733102;
	b=h0TNUaTs35Ssu303icBQ/lWq9U6yGIbQVpG6jSlsUSg2lhssO/8iaoYlyIqNi/sbVees
	 7ZfWvLutq/yU4JVIPhN5ixO32rCvgRhQ1bZUHwbkAuuRhgSYEQcmsGlpaW9Q5kH6jPTLd
	 jdyvrjMfttfW0sxtTjc4rsVeW99HAjXzwISuh01cs7HaUfGfOICSBHb3qjwecZQzxbnk3
	 ppbyVRj8T5HbGhZhaS95pKEyAwlBfBwI+eloYvX9vZb0opd1F1hcK0AzHIGQ09LmHIwq5
	 iTfEDYGPVEn3qgG2rUxMvjX0dz297gvcyimA2AVrvzionk5XNTaxq6nV8QiXVvq9PEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733102;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r0hIHV8oe9jSky5xFtOl29/vswjIM9cyeWc4sDbSdb8=;
	b=zXx9HlaKrbu2pLu6OXQ/5keVsFqNTvXAwJBgSs+dadzG3V2vBe85VGnD9TU90Wnyemnw
	 yXUZ5jjWinakOWTLu98Jh5GFHZSCUjNkbjWff6TWZW2dCouMMAa4KVmK4jOtBduIGkDmF
	 qdEfa0tiaIAVIRnmulUzl1YJfRqzMrg2g61cb5fln48xpDJgQBZIHDD2QdheV3leJJ6hP
	 Dz6yq95C9kwTf8+RRQ1mpH1cjGHoXygSrJh+VIGq+56Dr87cuP4nOUgGFT6ieyHjzCMAA
	 R2umn7kbRnOfgIw+xhYf/89WTh1sbmnJbB5l2kvs8oB+GKHsfNDuKOPJFAGGTqGd/Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ST03QbFF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633AB606A332;
	Fri, 23 Oct 2026 05:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ST03QbFF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B191F031E7;
	Fri, 23 Oct 2026 05:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792733102;
	bh=r0hIHV8oe9jSky5xFtOl29/vswjIM9cyeWc4sDbSdb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ST03QbFFdgBJ2ATPKfjlhtzNQ1niHVbUH565iPW8oUMaomlMZr5Ol2SV3QLewtcQp
	 z8Pa5gbUDrmGrRzuYoDMVrIs4iiVVdPZr6XuEKxi2OlsfoUazrkGxpy7k9p/ijzTj/
	 q+cQDWEGXLyUmmzvJwQ5BfDXhlGl5/DQ8R0FAmeXBb3GEvU6CBPiiDVsh6KrYgK0Px
	 zunh+zpLCpBBBb9CLfHNvKjdKvrwell7yRngQZICsvcS2AfoUgxe+K5fFpAcOma3+B
	 bU823DgK4yXvPAu2PdJHE+p22rUj5w7zEvyepbouPgzQ8kRGKMeU0jwcd2YYvO5USS
	 a1olfr4/JjRXg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/15] sched_ext: Refuse extending a kernel slice
Date: Thu, 22 Oct 2026 19:24:45 -1000
Message-ID: <20261023052452.2889061-9-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023052452.2889061-1-tj@kernel.org>
References: <20261023052452.2889061-1-tj@kernel.org>
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
index cd363c7b5d71..3ca150154a3e 100644
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
@@ -10300,10 +10302,11 @@ __bpf_kfunc_start_defs();
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
@@ -10341,9 +10344,13 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
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

