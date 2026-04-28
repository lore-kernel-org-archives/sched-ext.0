Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59539221FC6;
	Tue, 28 Apr 2026 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335399; cv=none; b=gC7WNBfCJpi0IKFEr/RAJG/BmV4Gbxj+JukO9AcFvO+OIv++pK6DmlwUROLCKFdBwHZAGCrk31unAHmObNUkZC47HHfSBdAniwKTMvVmDAdZmpXNvIcLSLlRtBnRigZZPkhc75sv3SjYz4XHVu4DAzFXWw9tiPQBjvJODFxdzWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335399; c=relaxed/simple;
	bh=od1s4MV8L5N/ILgM4Rh2KQemqy2nBwm/ge9PgC0XnHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pc4mTroZgDT6dOpiw7mazTgpTOIT+ODEbKy60bmbITbfiQUBLs1bCpFW49xEODCXVJDYaxcSptRFCTrmp12whPBr+Lp0C4vawJxAPV7TwyLDZYIJUXUED4nipGKgGq9WIv2YwUCxExYhgCZkQOgtEdgneLsynrRw3LvzhVXDD1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtt6NuzQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtt6NuzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EC4C2BCB4;
	Tue, 28 Apr 2026 00:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777335399;
	bh=od1s4MV8L5N/ILgM4Rh2KQemqy2nBwm/ge9PgC0XnHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qtt6NuzQ6xsq9337R199ZyziCGGaL5dCQo/I4aoGjrLa0/Zk6SW0f+b/cOG0mBjrl
	 B5YBUYaYnKNxWElZslBoVcpEfEyfLShUgXz+Yc1hWkpZKU60gkTcj7uO56kPISvGwZ
	 MAQ++DJckujpXPpybBu9qdrut5twUsEs9u8TQgdLb5c/z5yWINWKAvLz25tYVIwv9V
	 tC66If5fUKFJyfrq55vhkRFh81A6okstEZBm+XslrlV6a4zou3Hst7ENSiw8CWmyr2
	 dcC3zdjew+Zkc+3JBnaAV7uVPuSisMgjh/7Qhybe306u4zEElpr78mlVf5GSBMtoei
	 hz0DcKm60atRQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sched_ext: Skip past-sched_ext_dead() tasks in scx_task_iter_next_locked()
Date: Mon, 27 Apr 2026 14:16:35 -1000
Message-ID: <20260428001635.3293997-3-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428001635.3293997-1-tj@kernel.org>
References: <20260428001635.3293997-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_task_iter's cgroup-scoped mode can return tasks whose
sched_ext_dead() has already completed: cgroup_task_dead() removes
from cset->tasks after sched_ext_dead() in finish_task_switch() and is
irq-work deferred on PREEMPT_RT. The global mode is fine -
sched_ext_dead() removes from scx_tasks via list_del_init() first.

Callers (sub-sched enable prep/abort/apply, scx_sub_disable(),
scx_fail_parent()) assume returned tasks are still on @sch and trip
WARN_ON_ONCE() or operate on torn-down state otherwise.

Set %SCX_TASK_OFF_TASKS in sched_ext_dead() under @p's rq lock and
have scx_task_iter_next_locked() skip flagged tasks under the same
lock. Setter and reader serialize on the per-task rq lock - no race.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |  1 +
 kernel/sched/ext.c        | 33 +++++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 1a3af2ea2a79..adb9a4de068a 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -101,6 +101,7 @@ enum scx_ent_flags {
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
 	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 	SCX_TASK_IMMED		= 1 << 5, /* task is on local DSQ with %SCX_ENQ_IMMED */
+	SCX_TASK_OFF_TASKS	= 1 << 6, /* removed from scx_tasks by sched_ext_dead() */
 
 	/*
 	 * Bits 8 and 9 are used to carry task state:
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index cf43be8ac1aa..6c3c40499404 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -928,16 +928,27 @@ static struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter)
 		 *
 		 * Test for idle_sched_class as only init_tasks are on it.
 		 */
-		if (p->sched_class != &idle_sched_class)
-			break;
-	}
-	if (!p)
-		return NULL;
+		if (p->sched_class == &idle_sched_class)
+			continue;
 
-	iter->rq = task_rq_lock(p, &iter->rf);
-	iter->locked_task = p;
+		iter->rq = task_rq_lock(p, &iter->rf);
+		iter->locked_task = p;
 
-	return p;
+		/*
+		 * cgroup_task_dead() removes the dead tasks from cset->tasks
+		 * after sched_ext_dead() and cgroup iteration may see tasks
+		 * which already finished sched_ext_dead(). %SCX_TASK_OFF_TASKS
+		 * is set by sched_ext_dead() under @p's rq lock. Test it to
+		 * avoid visiting tasks which are already dead from SCX POV.
+		 */
+		if (p->scx.flags & SCX_TASK_OFF_TASKS) {
+			__scx_task_iter_rq_unlock(iter);
+			continue;
+		}
+
+		return p;
+	}
+	return NULL;
 }
 
 /**
@@ -3816,6 +3827,11 @@ void sched_ext_dead(struct task_struct *p)
 	/*
 	 * @p is off scx_tasks and wholly ours. scx_root_enable()'s READY ->
 	 * ENABLED transitions can't race us. Disable ops for @p.
+	 *
+	 * %SCX_TASK_OFF_TASKS synchronizes against cgroup task iteration - see
+	 * scx_task_iter_next_locked(). NONE tasks need no marking: cgroup
+	 * iteration is only used from sub-sched paths, which require root
+	 * enabled. Root enable transitions every live task to at least READY.
 	 */
 	if (scx_get_task_state(p) != SCX_TASK_NONE) {
 		struct rq_flags rf;
@@ -3823,6 +3839,7 @@ void sched_ext_dead(struct task_struct *p)
 
 		rq = task_rq_lock(p, &rf);
 		scx_disable_and_exit_task(scx_task_sched(p), p);
+		p->scx.flags |= SCX_TASK_OFF_TASKS;
 		task_rq_unlock(rq, p, &rf);
 	}
 }
-- 
2.53.0

