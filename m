Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB97CA4E;
	Sat, 25 Apr 2026 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777076384; cv=none; b=lf0K44D/LhXE2EwzTINcihpflzBtGrTBQunFDRUiyn48o/CstCA9HnMVL7dZ8Yjw30TTVc13ATt8iCpNQiRJfWFF2iTXdptvleAvNKUTGh4WCeBQLEnAdmwJHPCs7sj6dBy03QdJVxSQqbiRQzzzBV04iy2S9BohduwlGN3vY7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777076384; c=relaxed/simple;
	bh=2hpZ6QqrYQjzOekia5d5+ZSusUa/0K8DDWbmllsasm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wgs6Zu1N3kJqehOHcBXRHAc2xJyqVsnpsooHtskF1WK7n8hWq/sPs5wuTbhZLTRn2MG1qb3NI9W4R4ifvVgCe6uiyS1o9MxI9MxMaADYap87FEoxOGUxEpycjFFW+ZyS2Tg4bg7a+pC62hfsr2imXYB8J3nv+59VxIKqY/4mmB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euVDx/qx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euVDx/qx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A273C19425;
	Sat, 25 Apr 2026 00:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777076383;
	bh=2hpZ6QqrYQjzOekia5d5+ZSusUa/0K8DDWbmllsasm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=euVDx/qxqMoFmtr0SZzIG8YPZyftc8qc8+miH2ANUhIjKOtzmOZYv+PxexjUW77/0
	 NuKuDkPxETGZHeIm+/lROPceI4KBO8tx+VgKzkGscUroFsEdlcpk3capRf5N3UnQOd
	 y/eJFdury5kx6r5KYZLFYHUdL/U5bJGgfAB/5GzdL/hXUsi0TnRqmXCW7EilgZGthC
	 6joEELKH+wUYVntgxwUmelwdupU0andxztzOub41lXF18xnqcrLw16I8ZPUAjbilXW
	 2STGn+AglmeKnbfsJM2nQpSCi9szIjW9BtUbbA27vvs8XvGgqL7G7Ukcl4t/KwgPoX
	 +Li+VjcAgIH4A==
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
Subject: [PATCH v2 13/13] sched_ext: Refuse cross-task select_cpu_from_kfunc calls
Date: Fri, 24 Apr 2026 14:19:42 -1000
Message-ID: <20260425001942.3987351-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424204418.3809733-14-tj@kernel.org>
References: <20260424204418.3809733-14-tj@kernel.org>
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

Abort the scheduler on cross-task calls in both branches: for
ops.select_cpu() use scx_kf_arg_task_ok() to verify @p is the wake-up
task recorded in current->scx.kf_tasks[] by SCX_CALL_OP_TASK_RET();
for other rq-locked SCX ops compare task_rq(p) against scx_locked_rq().

v2: Per Andrea Righi: switch the in_select_cpu cross-task check from
direct_dispatch_task comparison to scx_kf_arg_task_ok(). The former
spuriously rejects when ops.select_cpu() calls scx_bpf_dsq_insert()
first (mark_direct_dispatch() stamps direct_dispatch_task =
ERR_PTR(-ESRCH)), then calls scx_bpf_select_cpu_*() on the same task.

Fixes: 0022b328504d ("sched_ext: Decouple kfunc unlocked-context check from kf_mask")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index c43d62d90e40..7468560a6d80 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -927,14 +927,24 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 	 * Accessing p->cpus_ptr / p->nr_cpus_allowed needs either @p's rq
 	 * lock or @p's pi_lock. Three cases:
 	 *
-	 *  - inside ops.select_cpu(): try_to_wake_up() holds @p's pi_lock.
+	 *  - inside ops.select_cpu(): try_to_wake_up() holds the wake-up
+	 *    task's pi_lock; the wake-up task is recorded in kf_tasks[0]
+	 *    by SCX_CALL_OP_TASK_RET().
 	 *  - other rq-locked SCX op: scx_locked_rq() points at the held rq.
 	 *  - truly unlocked (UNLOCKED ops, SYSCALL, non-SCX struct_ops):
 	 *    nothing held, take pi_lock ourselves.
+	 *
+	 * In the first two cases, BPF schedulers may pass an arbitrary task
+	 * that the held lock doesn't cover. Refuse those.
 	 */
 	if (this_rq()->scx.in_select_cpu) {
+		if (!scx_kf_arg_task_ok(sch, p))
+			return -EINVAL;
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

