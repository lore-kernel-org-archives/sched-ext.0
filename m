Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F03338A728;
	Fri, 10 Apr 2026 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802658; cv=none; b=mRkQMhaeGyojcZ7B9Yf6A+dSf9OpWBBBDalHnbDYrmEgUhtDEoAHsI023MOc8oQmGcw4J8VwDIy6Y35YuD3GCxzdHZ2GZ7F6xVGyZeD6ZbCt9Bkwqq69pGu/dHYjF7j9Xim6SGrZcDhOiWVM70tRp2TVGfjhuve8yPgrETlvh6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802658; c=relaxed/simple;
	bh=KNb/z2yRE2cuPGhPmYTvpEafu7+gyfB6fcKu3U/I+Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzJ9yh8PndXRASMPtz8+YyMw70NELhTJbgsMJN8aBFbJyPrgrmS2MbZm9Vw8rvBsNk6Qcm1ODIJN+oFmWfTCriOk7pg0lyTC+bgL9uowES6OkS8W4cImbDz+nebOY39WAXy3daCy3a3QeJPm4BM4hojBbryhD8b5xZBmAEe3tOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQLL7Lfi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQLL7Lfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E86C2BC9E;
	Fri, 10 Apr 2026 06:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775802658;
	bh=KNb/z2yRE2cuPGhPmYTvpEafu7+gyfB6fcKu3U/I+Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQLL7Lfi2pL6rlgHFnj3CmB/9/nKr3EAsSBuuCAunHAl+eAgp3ZuZf6HsCxSowqo/
	 5Fc6q6Uga7X55x8lleVaWxmklfgI6qFTuw2q2y5EhuUpfuHhschTWfjHilxaHr0q39
	 SFsJVKjQlik5nWkgKN6GHlNJUZvdsW89BMsYXvaL6aaQBuYjX/5jW7/tntOfqUIcSL
	 92JZMqusTcG4CeRAJBw286c0QcXWhp0011Mnek7IdC3qNxABBV/TQFfyLxwpB+RPez
	 phk6waN4EWP04a4gAWfhA/1TEt+OzT1Gjz159zw8sY7nubs7mnzSIwseK05SK9PRlx
	 Jl2OwYONoR/GA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/10] sched_ext: Warn on task-based SCX op recursion
Date: Thu,  9 Apr 2026 20:30:46 -1000
Message-ID: <20260410063046.3556100-11-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410063046.3556100-1-tj@kernel.org>
References: <20260410063046.3556100-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kf_tasks[] design assumes task-based SCX ops don't nest - if they
did, kf_tasks[0] would get clobbered. The old scx_kf_allow() WARN_ONCE
caught invalid nesting via kf_mask, but that machinery is gone now.

Add a WARN_ON_ONCE(current->scx.kf_tasks[0]) at the top of each
SCX_CALL_OP_TASK*() macro. Checking kf_tasks[0] alone is sufficient: all
three variants (SCX_CALL_OP_TASK, SCX_CALL_OP_TASK_RET,
SCX_CALL_OP_2TASKS_RET) write to kf_tasks[0], so a non-NULL value at
entry to any of the three means re-entry from somewhere in the family.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 27091ae075a3..99760d1fbbd4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -502,10 +502,13 @@ do {										\
  * held by try_to_wake_up() with rq tracking via scx_rq.in_select_cpu. So if
  * kf_tasks[] is set, @p's scheduler-protected fields are stable.
  *
- * These macros only work for non-nesting ops since kf_tasks[] is not stacked.
+ * kf_tasks[] can not stack, so task-based SCX ops must not nest. The
+ * WARN_ON_ONCE() in each macro catches a re-entry of any of the three variants
+ * while a previous one is still in progress.
  */
 #define SCX_CALL_OP_TASK(sch, op, rq, task, args...)				\
 do {										\
+	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
 	current->scx.kf_tasks[0] = task;					\
 	SCX_CALL_OP((sch), op, rq, task, ##args);				\
 	current->scx.kf_tasks[0] = NULL;					\
@@ -514,6 +517,7 @@ do {										\
 #define SCX_CALL_OP_TASK_RET(sch, op, rq, task, args...)			\
 ({										\
 	__typeof__((sch)->ops.op(task, ##args)) __ret;				\
+	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
 	current->scx.kf_tasks[0] = task;					\
 	__ret = SCX_CALL_OP_RET((sch), op, rq, task, ##args);			\
 	current->scx.kf_tasks[0] = NULL;					\
@@ -523,6 +527,7 @@ do {										\
 #define SCX_CALL_OP_2TASKS_RET(sch, op, rq, task0, task1, args...)		\
 ({										\
 	__typeof__((sch)->ops.op(task0, task1, ##args)) __ret;			\
+	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
 	current->scx.kf_tasks[0] = task0;					\
 	current->scx.kf_tasks[1] = task1;					\
 	__ret = SCX_CALL_OP_RET((sch), op, rq, task0, task1, ##args);		\
-- 
2.53.0

