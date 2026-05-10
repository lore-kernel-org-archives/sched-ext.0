Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7293436B046;
	Sun, 10 May 2026 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778398880; cv=none; b=u48WevwXpa5I+DYQve0D9ArEBRQAPezQZkcySislRU00tq2VVq+Yi0rseHqcBb72jfUjJcsTass0if772+RRia0YJUnijNiVZjmskH4/S+GZAOsdu6/YUCrCTkqJgqpOAVCQkURA1UVf3TBoZfZIIE+IqT7yj5sVvGQswhiaOvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778398880; c=relaxed/simple;
	bh=7T17m2drb6+9UwlrWFOVj31tBd4C9ImDXY/kAiIlxdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXjs5dqmEHKXlcDqVH33lbyWC+pNmShxf2fztQwqVMq9g7DbGT5e9GH9du/RoFDousIero4xBTrponilgSwkSTJa3aGZvdMUgLI4nv5BB9uJzgU/ZoFdAbDF0rb/N87YppJYUwF4x6OwdAMuhnAeHtZL4lC0jnWBfN+0mT4sKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dggZiMd/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dggZiMd/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E8EC2BCFD;
	Sun, 10 May 2026 07:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778398880;
	bh=7T17m2drb6+9UwlrWFOVj31tBd4C9ImDXY/kAiIlxdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dggZiMd/c4rxeyF0XzL21ytMhLdbEBrAkDwUmx8RYZCkjp00+5muNxFu4yJXIPIw9
	 7WPEMb/AVC1slf7j4czY8/RJXO3bb98VS4wdFuCokXoy65tZLQrRiEhQ5CJYejuexC
	 Cg2Y0S+jv8/gdjjtxVm2mn2y2rs5ON6jQldQ0bPV1Iper7+Idw2Xo1ouNDdlk6lInm
	 FLivTeJRnB694uP19AJnSZ53Q3HKw55ziKUIdfmZh8nx4jF7O8a3P9CqK0wTGrqxuH
	 5tFWv4pB98E10oR/ErOzo4A2LZWkshOkVkJADT5/IPbEs7CG8QgI/bh3j6XF9rg7/I
	 eYljXG/uFwwtw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: emil@etsalapatis.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/6] sched_ext: Close sub-sched init race with post-init DEAD recheck
Date: Sat,  9 May 2026 21:41:12 -1000
Message-ID: <20260510074113.2049514-6-tj@kernel.org>
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

scx_sub_enable_workfn()'s init pass and scx_sub_disable() migration both
drop the rq lock to call __scx_init_task() against the other sched. A
TASK_DEAD @p can fall through sched_ext_dead() in that window.
sched_ext_dead() runs ops.exit_task() on the sched @p was attached to, not
on the sched whose init just completed, so the new allocation leaks.

Reuse the DEAD signal set by sched_ext_dead(). After __scx_init_task()
returns, take task_rq_lock(p) and check for DEAD; on hit, call
scx_sub_init_cancel_task() against the sub sched the init ran for and drop
@p; on miss, proceed as before.

Reported-by: zhidao su <suzhidao@xiaomi.com>
Link: https://lore.kernel.org/all/20260429133155.3825247-1-suzhidao@xiaomi.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 29fa9ffe7c7b..6fbe3160eccd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5777,6 +5777,21 @@ static void scx_sub_disable(struct scx_sched *sch)
 		}
 
 		rq = task_rq_lock(p, &rf);
+
+		if (scx_get_task_state(p) == SCX_TASK_DEAD) {
+			/*
+			 * sched_ext_dead() raced us between __scx_init_task()
+			 * and this rq lock and ran exit_task() on @sch (the
+			 * sched @p was on at that point), not on $parent.
+			 * $parent's just-completed init is owed an exit_task()
+			 * and we issue it here.
+			 */
+			scx_sub_init_cancel_task(parent, p);
+			task_rq_unlock(rq, p, &rf);
+			put_task_struct(p);
+			continue;
+		}
+
 		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
 			/*
 			 * $p is initialized for $parent and still attached to
@@ -5791,8 +5806,8 @@ static void scx_sub_disable(struct scx_sched *sch)
 			scx_set_task_state(p, SCX_TASK_READY);
 			scx_enable_task(parent, p);
 		}
-		task_rq_unlock(rq, p, &rf);
 
+		task_rq_unlock(rq, p, &rf);
 		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
@@ -7212,6 +7227,21 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 			goto abort;
 
 		rq = task_rq_lock(p, &rf);
+
+		if (scx_get_task_state(p) == SCX_TASK_DEAD) {
+			/*
+			 * sched_ext_dead() raced us between __scx_init_task()
+			 * and this rq lock and ran exit_task() on $parent (the
+			 * sched @p was on at that point), not on @sch. @sch's
+			 * just-completed init is owed an exit_task() and we
+			 * issue it here.
+			 */
+			scx_sub_init_cancel_task(sch, p);
+			task_rq_unlock(rq, p, &rf);
+			put_task_struct(p);
+			continue;
+		}
+
 		p->scx.flags |= SCX_TASK_SUB_INIT;
 		task_rq_unlock(rq, p, &rf);
 
-- 
2.54.0

