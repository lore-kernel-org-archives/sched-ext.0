Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E92367CF;
	Sun,  9 Nov 2025 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762713077; cv=none; b=TQ0IiUxsnl747n7awvTzMfGavY/Mk6O74FrwJTcaa5XY2q8wq0cUMVpgdXYN+gC5ygKuD2A74jWTgsw/67PIM7rPX3IKAB+pA3CWGftdykglY35oxhGKzhpTr0m0AGmYwsSRsL7tgzrN509MI9TagVdXhk5zbiHhwjLN7NSrXQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762713077; c=relaxed/simple;
	bh=NanRDlhKdjwX4gJBCXEuWlXsS+tRETi/49MISOFzM0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1f1s1L5xnG2gGs6S+3zU2mtzV95eTllIq7Payy8QeGgXB757BraXT2NGqTBrMY1BrHnXjEdwKXvj8cVxmgGBnF7NuWoqxBmtoUcn1UmqlqPpCdu7EwWbLfMbvqtqVYO8Xck+EJGduz0GlF9x1qUkG6vjmAoFj+pkggYfikxKZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9Kw/UH0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9Kw/UH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F276EC16AAE;
	Sun,  9 Nov 2025 18:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762713077;
	bh=NanRDlhKdjwX4gJBCXEuWlXsS+tRETi/49MISOFzM0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9Kw/UH0+K1cP1/ZdkJg0ucVQI2uE5PgFl9SGI8RQhxZ9nyFWcWtGjKqfP1nXSCvn
	 9nLDoW+1Aa3jB9maZePm3KaYYp3CjwjUZk9PpvfXkD93wLsPdKPL6IYQqAAF/PLJYm
	 hfX78X0BZsTuKwNNJNsrzMeJnlYTtWHQkj94kGBfRYWa2SrHNcgxvHhiEcr6HFfjmb
	 GMCXWxP8NCPjOmfb2DCoGwmilR+kFwVOf3SU8clkIZtxEBaHH5eYHKdYy2cUWB+9Rn
	 JtIVBCy/mkV9Sc8X+CM2/P4TE+NiK/9zjTtMpDi/ZWDFVKtesTsGOaUAjvSwT268n+
	 pUackgF9bf3pg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/13] sched_ext: Refactor do_enqueue_task() local and global DSQ paths
Date: Sun,  9 Nov 2025 08:31:02 -1000
Message-ID: <20251109183112.2412147-4-tj@kernel.org>
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

The local and global DSQ enqueue paths in do_enqueue_task() share the same
slice refill logic. Factor out the common code into a shared enqueue label.
This makes adding new enqueue cases easier. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2ce226018dbe..a29bfadde89d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1282,6 +1282,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 {
 	struct scx_sched *sch = scx_root;
 	struct task_struct **ddsp_taskp;
+	struct scx_dispatch_q *dsq;
 	unsigned long qseq;
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
@@ -1349,8 +1350,17 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 direct:
 	direct_dispatch(sch, p, enq_flags);
 	return;
-
+local_norefill:
+	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
+	return;
 local:
+	dsq = &rq->scx.local_dsq;
+	goto enqueue;
+global:
+	dsq = find_global_dsq(sch, p);
+	goto enqueue;
+
+enqueue:
 	/*
 	 * For task-ordering, slice refill must be treated as implying the end
 	 * of the current slice. Otherwise, the longer @p stays on the CPU, the
@@ -1358,14 +1368,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	touch_core_sched(rq, p);
 	refill_task_slice_dfl(sch, p);
-local_norefill:
-	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
-	return;
-
-global:
-	touch_core_sched(rq, p);	/* see the comment in local: */
-	refill_task_slice_dfl(sch, p);
-	dispatch_enqueue(sch, find_global_dsq(sch, p), p, enq_flags);
+	dispatch_enqueue(sch, dsq, p, enq_flags);
 }
 
 static bool task_runnable(const struct task_struct *p)
-- 
2.51.1

