Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C167C4014A0;
	Fri, 24 Apr 2026 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063473; cv=none; b=u6mTKAqpsT9RDLZkVrVuBuEDr974E6YAOcUg/7cdsBbRm9gN4SyCQTUcDOCp+CA6xONFBrQZMOTLtYhVzdXRgkX1iNDqAK1QBdV8IXrChXYmhbdM1lfRs6AkiK8glf3kQgeMS20NOkeWFkpY+yYkc8OwY1T7Fn6Hm5lzuChe6hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063473; c=relaxed/simple;
	bh=HY8mhoSA8xFDxWdsYS/lGGl51bT5hsX31Wi7bVd76sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiw9AC8wH4v6WbJwewJg69/h7MlhADzeMVq468vmC9GF5kNauwZ2ki1QcjBArXDpk7BlEh/FQuzQ0MrvUO3LXerP4nsVbB5ogGWOwFoaGMhcwaonDJBOU6ii6YjLVDlvD68tohYsS4ZK0BAizV1diMLIHySSy9vFOR9TZ/6KKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBBx3lMc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBBx3lMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58335C19425;
	Fri, 24 Apr 2026 20:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063473;
	bh=HY8mhoSA8xFDxWdsYS/lGGl51bT5hsX31Wi7bVd76sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hBBx3lMcUrXku7Fu592tEoq8wGUrfvE6cYqBD400odo1OJYJjzGgzq7mKqpGjy6bI
	 oXfq8pa4ZjyJtZXwkgvnnpBbfrKIhGJqJEt2z6lNo75JkNf39eDWuQr2thhEeIcZCH
	 Z1ZAtQOmCD+iWXNm2D3ZcdHOBnfGHizL7RhR0EkRlemCCPTRGQXPngMn1oI/cGhSn/
	 vE9+CfrLn5Cmd0S3wH4wv5VLzu2m9p0JcUMu2JyZ6kkQ0tvBvJYRF+V7npckfja0U/
	 0mVHjjjK2rq+z2JQGmz0EklW4UF7BPbmVEQQhwnDiKIyttN66ZWwfJHrqy7lZbZYuD
	 jZeOnuWS4O8TQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/13] sched_ext: Refuse cross-task select_cpu_from_kfunc calls
Date: Fri, 24 Apr 2026 10:44:18 -1000
Message-ID: <20260424204418.3809733-14-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424204418.3809733-1-tj@kernel.org>
References: <20260424204418.3809733-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

select_cpu_from_kfunc() skipped pi_lock for @p when called from
ops.select_cpu() or another rq-locked SCX op, assuming the held lock
protects @p. scx_bpf_select_cpu_dfl() / __scx_bpf_select_cpu_and() accept an
arbitrary KF_RCU task_struct, so a caller in e.g. ops.select_cpu(p1) or
ops.enqueue(p1) can pass some other p2 - the held pi_lock / rq lock is p1's,
not p2's - and reading p2->cpus_ptr / nr_cpus_allowed races with
set_cpus_allowed_ptr() and migrate_disable_switch() on another CPU.

Abort the scheduler on cross-task calls in both branches: check @p against
direct_dispatch_task (the task currently being selected) for
ops.select_cpu(), and task_rq(p) against scx_locked_rq() for other rq-locked
SCX ops.

Fixes: 0022b328504d ("sched_ext: Decouple kfunc unlocked-context check from kf_mask")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index c43d62d90e40..ff4d1b97437d 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -927,14 +927,24 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 	 * Accessing p->cpus_ptr / p->nr_cpus_allowed needs either @p's rq
 	 * lock or @p's pi_lock. Three cases:
 	 *
-	 *  - inside ops.select_cpu(): try_to_wake_up() holds @p's pi_lock.
+	 *  - inside ops.select_cpu(): try_to_wake_up() holds the wake-up
+	 *    task's pi_lock (stashed in direct_dispatch_task;
+	 *    mark_direct_dispatch() invalidates it post-dispatch).
 	 *  - other rq-locked SCX op: scx_locked_rq() points at the held rq.
 	 *  - truly unlocked (UNLOCKED ops, SYSCALL, non-SCX struct_ops):
 	 *    nothing held, take pi_lock ourselves.
+	 *
+	 * In the first two cases, BPF schedulers may pass an arbitrary task
+	 * that the held lock doesn't cover. Refuse those.
 	 */
 	if (this_rq()->scx.in_select_cpu) {
+		if (p != __this_cpu_read(direct_dispatch_task))
+			goto cross_task;
 		lockdep_assert_held(&p->pi_lock);
-	} else if (!scx_locked_rq()) {
+	} else if (scx_locked_rq()) {
+		if (task_rq(p) != scx_locked_rq())
+			goto cross_task;
+	} else {
 		raw_spin_lock_irqsave(&p->pi_lock, irq_flags);
 		we_locked = true;
 	}
@@ -960,6 +970,11 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 		raw_spin_unlock_irqrestore(&p->pi_lock, irq_flags);
 
 	return cpu;
+
+cross_task:
+	scx_error(sch, "select_cpu kfunc called cross-task on %s[%d]",
+		  p->comm, p->pid);
+	return -EINVAL;
 }
 
 /**
-- 
2.53.0

