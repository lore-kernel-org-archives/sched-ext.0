Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84AF25B081;
	Tue, 12 May 2026 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610619; cv=none; b=i7jAy2EvIz00cnRtjmIVT+S+eOauabrHQTSvzS45/O5Y8KSsr/c0EQmkjbqqSKlq3L5lIm/bXTb4quJ78TBVpFKdMx+TDqydh31l5JEv+WDKhvmeH+BGJmMPhzY+QV19YlHE4b1wZJ64LQ8aBooeA+UOYpmT9iTZap9uGVwVHzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610619; c=relaxed/simple;
	bh=VaAZKaFxVwDgn6TuQKxewo+yXdc0q0F9B/9XShGF6q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/pOUckWj0qyqohJrojNwr/REWbtjdQWCMCzu5Ua9n5t54jb1kSuoWJilpTvHvsjRermjL98J4u3tKVQV5UXOpYLACnnm3HZ7ZYMA64cGdj3fO0ifyyuvGekYRao/ubhZD21s1yg+zeUlPgFeJCHhjwuvhZVRTKHCZZB7hpRAXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jj+Le/QP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jj+Le/QP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE8BC2BCB0;
	Tue, 12 May 2026 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778610619;
	bh=VaAZKaFxVwDgn6TuQKxewo+yXdc0q0F9B/9XShGF6q8=;
	h=From:To:Cc:Subject:Date:From;
	b=Jj+Le/QP75j7GvNjGOGXA9jJG9aAFNgR98EYRWYDlW85AddelhSy+SChMOL8gOkPJ
	 Myl0jfwsLE2Qx3eYHJF2QT40Rp9xgxwpyZ3T2wlVQKBjoLAYePYEHrzT+hXcZd9AXB
	 dNPn7yfN0LojAM3bO5mz3oT32kP/PM6KcYIbo53pE+hEyTHuhVDtQsVPzXkcXy7lfw
	 QjxOxUDnlDq6ZCoAgilfMLmDnr/PsPqewpJuhQrV4QxQ6/c00tHPTu7U4F2yRocF9n
	 VJWD9JqWnkmiLCjSIeXRWEoOebhjjBe82cqx11ccg2/nSO9ipHNwZ8StSF4uZpStSN
	 bZNiVnc2HJphA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Drop %NONE early return in scx_disable_and_exit_task()
Date: Tue, 12 May 2026 08:30:18 -1000
Message-ID: <20260512183018.705960-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

d3e73a0808dd ("sched_ext: Handle SCX_TASK_NONE in disable/switched_from
paths") skipped the trailing scx_set_task_sched(p, NULL) on %NONE tasks.
After scx_fail_parent() parks a task at %NONE/sched=parent and the
parent is later freed via queue_rcu_work() during root_disable, the
preserved p->scx.sched dangles - print_scx_info() from sched_show_task()
reads sch->ops.name from freed memory.

Drop the early return. __scx_disable_and_exit_task() already short-
circuits on %NONE and the SUB_INIT block was cleared by
scx_fail_parent()'s earlier call, so clearing p->scx.sched is the only
work left - and the one thing the path actually needs.

Fixes: d3e73a0808dd ("sched_ext: Handle SCX_TASK_NONE in disable/switched_from paths")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9354da79e162..8861b2deb504 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3703,15 +3703,6 @@ static void scx_sub_init_cancel_task(struct scx_sched *sch, struct task_struct *
 static void scx_disable_and_exit_task(struct scx_sched *sch,
 				      struct task_struct *p)
 {
-	/*
-	 * %NONE means @p is already detached at the SCX level (e.g. handed
-	 * back to the parent by scx_fail_parent() with no init to undo).
-	 * Skip to avoid clobbering scx_task_sched() and writing %NONE again
-	 * on a state that's already %NONE.
-	 */
-	if (scx_get_task_state(p) == SCX_TASK_NONE)
-		return;
-
 	__scx_disable_and_exit_task(sch, p);
 
 	/*
-- 
2.51.0

