Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65A1BD9D0;
	Sun, 10 May 2026 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778453113; cv=none; b=kFmBV2RGP8hOY+o3yZmUClc63ok2+qimV5qIZH1nmn2+nAMWN9wWJV0TpVPoYPXDqgdb6hwDEQ5ArnbrOeBcQPIs0jYPwGZPB7oiikdeMFU4NmoGc26yegFZs+37Mk4hcQ0s0fMxYZknBk36bXTmur9JfeAnoy+QiQDlNDfBxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778453113; c=relaxed/simple;
	bh=u7oT9dI7oHt2t0S/vOkQmQ9XaiEoHNZB3DMdwiRjWIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iy5xvMNeKFw/FljpDwutZpYHzUXhZVwRI2a22ZPBtcQ9vZuDWBpac49tSMW5ze9aWefef/1j3BDSDySKP/aaulIE6fILMttCrwutkC7wTkWCGby/9yyHOBN3SmGCzT/XY2uJ1mV8FoJkwWEONnaexqR0d4ryqrWHqM99SnQ+aeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBY0C7x6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBY0C7x6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA33C2BCB8;
	Sun, 10 May 2026 22:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778453113;
	bh=u7oT9dI7oHt2t0S/vOkQmQ9XaiEoHNZB3DMdwiRjWIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bBY0C7x6ZtLEOtInpyoySZgEZQmOToHB/eFPX4B+rXg1netAGe+rmCdqEFHSYcr5y
	 bElfrMKmCQX4xA7dKIKxQq1c/HcWmx6F3vgjyIdToOEXEUYbPDHNXkj+xMF9DX5csY
	 nFoTRds8+3KxvyqWFvUM5JTzScSdVhWCi3B/gpAGewg98K00tug52za1YEHYYQXX1y
	 mietfROyUxSWqpN/xyLc8OF3g4qFHfBL4epdBtG/XS+P5takp3CV58O2k4s/dUo9vx
	 v1jNjH7B2z8qf7nGYCVhjsPM3iAcviPmBUhRJmGuWhecqNYOli6DOiiheFAv7IWxkR
	 HUKSRD9yzmmNg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: emil@etsalapatis.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.2] sched_ext: Add scx_task_iter_relock() and use it in scx_root_enable_workfn()
Date: Sun, 10 May 2026 12:45:11 -1000
Message-ID: <20260510224511.2683323-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510222302.2614731-1-tj@kernel.org>
References: <20260510222302.2614731-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_root_enable_workfn()'s post-init block re-acquires scx_tasks_lock
briefly via a scoped_guard() for the tid hash insertion. c941d7391f25
("sched_ext: Close root-enable vs sched_ext_dead() race with
SCX_TASK_INIT_BEGIN") on for-7.1-fixes adds a post-init DEAD recheck that
holds the task's rq lock across the state-machine updates in the same
region. A naive merge would acquire scx_tasks_lock while the rq lock is
held, inverting the iter's outer/inner order (scx_tasks_lock then rq lock).

Add scx_task_iter_relock(iter, p), the counterpart to
scx_task_iter_unlock(), that re-acquires scx_tasks_lock and, if @p is
non-NULL, @p's rq lock. The locks are tracked in @iter so subsequent
iteration releases them.

Use it in scx_root_enable_workfn()'s post-init block and drop the
now-redundant scoped_guard on the hash insertion. The post-init region now
runs with both scx_tasks_lock and the task's rq lock held across the init
failure check, the state-machine updates and the hash insert.

v2: Move scx_task_iter_relock() earlier to ease the for-7.1-fixes merge.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applied to sched_ext/for-7.2 to resolve the merge conflict from
for-7.1-fixes.

 kernel/sched/ext.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b685f45b4fd0..fbdc1819d4cb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -902,6 +902,24 @@ static void __scx_task_iter_maybe_relock(struct scx_task_iter *iter)
 	}
 }
 
+/**
+ * scx_task_iter_relock - Re-acquire scx_tasks_lock and, optionally, @p's rq
+ * @iter: iterator to relock
+ * @p: task whose rq to lock, or %NULL for scx_tasks_lock only
+ *
+ * Counterpart to scx_task_iter_unlock(). Locking @p's rq is optional. Once
+ * re-acquired, both locks are managed by the iterator from here on.
+ */
+static void scx_task_iter_relock(struct scx_task_iter *iter,
+				 struct task_struct *p)
+{
+	__scx_task_iter_maybe_relock(iter);
+	if (p) {
+		iter->rq = task_rq_lock(p, &iter->rf);
+		iter->locked_task = p;
+	}
+}
+
 /**
  * scx_task_iter_stop - Stop a task iteration and unlock scx_tasks_lock
  * @iter: iterator to exit
@@ -7064,6 +7082,9 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		scx_task_iter_unlock(&sti);
 
 		ret = scx_init_task(sch, p, false);
+
+		scx_task_iter_relock(&sti, p);
+
 		if (ret) {
 			put_task_struct(p);
 			scx_task_iter_stop(&sti);
@@ -7076,15 +7097,12 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		scx_set_task_state(p, SCX_TASK_READY);
 
 		/*
-		 * Insert into the tid hash under scx_tasks_lock so we can't
-		 * race sched_ext_dead() and leave a stale entry for an already
-		 * exited task.
+		 * Insert into the tid hash. scx_tasks_lock is held by the iter;
+		 * list_empty() guards against sched_ext_dead() having taken @p
+		 * off the list while init ran unlocked.
 		 */
-		if (scx_tid_to_task_enabled()) {
-			guard(raw_spinlock_irq)(&scx_tasks_lock);
-			if (!list_empty(&p->scx.tasks_node))
-				scx_tid_hash_insert(p);
-		}
+		if (scx_tid_to_task_enabled() && !list_empty(&p->scx.tasks_node))
+			scx_tid_hash_insert(p);
 
 		put_task_struct(p);
 	}
-- 
2.54.0

