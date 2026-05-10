Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437636920F;
	Sun, 10 May 2026 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778398881; cv=none; b=ePKU0R0pO2DHSNc4GvACs8zm4fRUFpkxt6kd5mZUCP77bEk+2Oa9zbopwZUwBH5ru0UzP1dZ/isdkW1dt7XtKQf8LCsZQte30sQm1nEzVXvttAxrcvVaeAi9GeVJtxZVo0ZbJsCA0gdUkWmnfGHavVlcgIz+VjPLV3jZQRLJ274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778398881; c=relaxed/simple;
	bh=CaMdfLdbyKwNlxe1v/NJFOPPgi1slPwR7v21ZgiKuos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHEWU1sPAKNM9QoJu9rPVNqoyAJapR7p3/RLgS0uPRzlRKSGj/M1CgtipZbxfMfuCOkOr+iBOW2ver0rUpMPnAM4uQv2hWy4laoR67ISlq+Q/2TUNL2obdLzixPLbtBWxyMlSHSmeroTQtgJKdk1U27nHj/3qHb7SpURGCartGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQd/qKV4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQd/qKV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0FDC2BCF7;
	Sun, 10 May 2026 07:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778398881;
	bh=CaMdfLdbyKwNlxe1v/NJFOPPgi1slPwR7v21ZgiKuos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQd/qKV4Y5gi3BRMS+CQQrV473tH7aDUqdFzFPBS17AX+K4NsqNYLTJe+yH7WxiAK
	 1fmhlIbrfEQtBWAjWs0dBc+FyUjcdXxNL+jxUgRBemyqQVhN92wJu7zLeV4YqC2DPq
	 a3eJi/9dwLxd24IJXKItggoJkDwPDBK/xcjmUSgyAlMLh0csDK4A/TVcO216ecLQQc
	 OCpHGCV4BrCK7oP4B8GKHaxYQncdrT4H4OHEMJmuM9e2AJ6aCr9wlSvVeK/bcII9wu
	 GYI31ZLh4XpRedPyKO/Sqj72LLazMRIGhyV8c+4Au9N5IZUgD9vMvyoTvcFgf7ckxH
	 y1saHSRAMwxkw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: emil@etsalapatis.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] sched_ext: Handle SCX_TASK_NONE in disable/switched_from paths
Date: Sat,  9 May 2026 21:41:13 -1000
Message-ID: <20260510074113.2049514-7-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510074113.2049514-1-tj@kernel.org>
References: <20260510074113.2049514-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_fail_parent() leaves cgroup tasks at (state=NONE, sched=parent,
sched_class=ext) until the parent itself is torn down by the scx_error() it
raised. When the later root_disable iterates them, two paths trip on NONE.

scx_disable_and_exit_task() re-enters the wrapper at NONE: the inner switch
returns early but the trailing scx_set_task_sched(p, NULL) clobbers the
parent sched left by scx_fail_parent(), and scx_set_task_state(p, NONE)
wastes a write on an already-NONE task. switched_from_scx() then calls
scx_disable_task(), which WARNs on non-ENABLED state and writes state=READY,
producing a NONE -> READY transition the validation matrix rejects.

Treat NONE as "nothing to do" in both paths. Add a NONE early-return at the
top of scx_disable_and_exit_task() and a parallel NONE check in
switched_from_scx() next to task_dead_and_done().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6fbe3160eccd..4efe0099f79a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3703,6 +3703,15 @@ static void scx_sub_init_cancel_task(struct scx_sched *sch, struct task_struct *
 static void scx_disable_and_exit_task(struct scx_sched *sch,
 				      struct task_struct *p)
 {
+	/*
+	 * %NONE means @p is already detached at the SCX level (e.g. handed
+	 * back to the parent by scx_fail_parent() with no init to undo).
+	 * Skip to avoid clobbering scx_task_sched() and writing %NONE again
+	 * on a state that's already %NONE.
+	 */
+	if (scx_get_task_state(p) == SCX_TASK_NONE)
+		return;
+
 	__scx_disable_and_exit_task(sch, p);
 
 	/*
@@ -3921,6 +3930,16 @@ static void switched_from_scx(struct rq *rq, struct task_struct *p)
 	if (task_dead_and_done(p))
 		return;
 
+	/*
+	 * %NONE means SCX is no longer tracking @p at the task level (e.g.
+	 * scx_fail_parent() handed @p back to the parent at NONE pending the
+	 * parent's own teardown). There is nothing to disable; calling
+	 * scx_disable_task() would WARN on the non-%ENABLED state and trigger a
+	 * NONE -> READY validation failure.
+	 */
+	if (scx_get_task_state(p) == SCX_TASK_NONE)
+		return;
+
 	scx_disable_task(scx_task_sched(p), p);
 }
 
-- 
2.54.0

