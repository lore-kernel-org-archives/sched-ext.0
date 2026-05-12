Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F33C7DF1;
	Tue, 12 May 2026 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620263; cv=none; b=aekn57z7ZMRetsWTrR9k4rMLK2ZjyFg4bl58752qwIIHouHFGDp72NQ7TdIU/atuzJVFwDyZdPFrU9Zh1AxEM1HBmLIGbzwK4FsbjEsrmHVQ1EOVadCr26DnyR3m+Edi4wnLicroGu2NC1T6DtDThkj54Tgxn6bMgNiTXDPwzxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620263; c=relaxed/simple;
	bh=1P4ShyO3TeU5jYRi+nAn7vOmP7rI9lPAvk5BRi1SBMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MG1lPx/6MapAPwXZhfzU382VQA9OZxthmLaCJjXJmz/GsGTV8svsfOI7hZnGVN0/GpF/X9ofU80muJMmwpPGuRbBVR3M9L3zBFVp0qimnIVyHRXXZSIXdbrtcbaqQEXj3uOV8XimfUD+w6Fd6rEvDQtjKf0yqmctZ+NGpyE7Vc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egCeJMtT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egCeJMtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301FAC2BCFA;
	Tue, 12 May 2026 21:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778620263;
	bh=1P4ShyO3TeU5jYRi+nAn7vOmP7rI9lPAvk5BRi1SBMM=;
	h=From:To:Cc:Subject:Date:From;
	b=egCeJMtTL7PyFnH7hS2FBOMyn9x+AZ6D0KDBBsNFtKI+AMMKmLWoWEpnJleNnYKyZ
	 gO5teEFGSLQvHRQKsGE/dvHaV9yuBD5R3mzB4M9Uh/xeuiobSmywp7xLE3G7lHo4AW
	 pE7458wO1GPyguxp61yGdO1jagLsXbC6j4wgEG+DyzXG1rY4wseoi+DKWlGQNNFjJ7
	 CkAXmUZ+Bu0ay+KyP4f+ZHu4bQ+b+dTYQtnFrV/hRQv2GaWchIRMBe7YUiOcNUlG3N
	 nhYWiFbjr/Lmyqk/AvHMoKnAxW9y1u6W8wq5lB2mg8d+qCS3vh3e1GGBUOfJDzme82
	 t1oQqtJatxvmA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Drop %NONE early return in scx_disable_and_exit_task()
Date: Tue, 12 May 2026 11:11:02 -1000
Message-ID: <20260512211102.883417-1-tj@kernel.org>
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

v2: Extend the SUB_INIT block comment to note that the flag is only
    set on the sub-enable path, so it's always clear on the %NONE
    re-entry (Andrea).

Fixes: d3e73a0808dd ("sched_ext: Handle SCX_TASK_NONE in disable/switched_from paths")
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9354da79e162..68120f679178 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3703,22 +3703,14 @@ static void scx_sub_init_cancel_task(struct scx_sched *sch, struct task_struct *
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
 	 * If set, @p exited between __scx_init_task() and scx_enable_task() in
 	 * scx_sub_enable() and is initialized for both the associated sched and
 	 * its parent. Exit for the child too - scx_enable_task() never ran for
-	 * it, so undo only init_task.
+	 * it, so undo only init_task. The flag is only set on the sub-enable
+	 * path, so it's always clear when @p arrives here in %SCX_TASK_NONE.
 	 */
 	if (p->scx.flags & SCX_TASK_SUB_INIT) {
 		if (!WARN_ON_ONCE(!scx_enabling_sub_sched))
-- 
2.51.0

