Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F3B29B78F;
	Thu, 16 Jul 2026 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237464; cv=none; b=Q3mTTl4kLpzdQDj4Wp4qLXNYPD1F3cKSxfaDjhbO61GWRe43CLuxnwSu0dFsjnGvxXKmDKTW/Art5sp3X49yAjfOXsAD07FBLWdoutGTIxqq3o+Vhjte3sX5wqsTCTaK9YMFVzrDUkB89b06gHxEuHEWq2brwIzM/aT1NZhlYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237464; c=relaxed/simple;
	bh=YtXIISsUXbSmbVV98If3Y/8fFlpDnnh4/mbQf8Aw6fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCAAgpod5TLo9DcWrPeN5NmVvC7rRCE0I5LQyGrGVUfOdoZnRJE47IEXN6h1KBTfdFagODt48sfhDk6gkj795AYKBZ6K0PeB8a9wJJICDsVmt8z6VxUnNpOsP0CbCEIyBU9Mxg2XJ1+0bjK0zO4Cwtj4P1nJUwCavCbQ/i1HNhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2PAXDgQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2PAXDgQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FFD1F000E9;
	Thu, 16 Jul 2026 21:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784237463;
	bh=nCrMrCrl+c3y3VgiJfFW6NSbs/SRBwnVsKE3crNzk3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I2PAXDgQ0ZQeJ90HHAU+aeXv6UMUqnONDWt9lNtxvDMWlRJS++4gTJeAFvizBxB73
	 yoXZkzWTNIF8LiBOpt1CDe+Ajh61+B3HaiGX47L4D/FvwZqS0cOYFforYzGnNOVsJ6
	 U82UB8Kou9iXMxNUII64CiJP+MyZy9T5Njq+coNCguBvwz8YzmU0WaXgZchirtE6FK
	 6c/dBtjevEah9h1BINHRkoiyvyLPXKDC/LoC3IpVpRRyFf4r/zZ7nXQKpxXtyA6AQf
	 hDF34GtkCV7mT132QcZor5X3PcaCSF/6aedRhATutFHrReYC9Z1WDjqMspowCGhU3h
	 WCC9VO+06YdeQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] sched_ext: Don't enable non-ext tasks in the sub-sched task loops
Date: Thu, 16 Jul 2026 11:30:58 -1000
Message-ID: <20260716213058.1739522-5-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716213058.1739522-1-tj@kernel.org>
References: <20260716213058.1739522-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Root enable and scx_post_fork() enable a task only if it's on the ext class.
Tasks on other classes, possible under an SCX_OPS_SWITCH_PARTIAL root, are
left READY and enabled by switching_to_scx() when they switch over. The sub
enable-commit pass and the sub-disable re-home loop enable unconditionally,
so a fair-class READY task in the subtree becomes ENABLED while not on
sched_ext. A later switch to SCHED_EXT then trips the task state validation
WARN (ENABLED with the previous state not READY) and calls ops.enable() a
second time.

Gate scx_enable_task() on the task's class in both loops.

Fixes: 337ec00b1d9c ("sched_ext: Implement cgroup sub-sched enabling and disabling")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 98dd7df88db4..18183062f751 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6010,15 +6010,22 @@ static void scx_sub_disable(struct scx_sched *sch)
 			/*
 			 * $p is initialized for $parent and still attached to
 			 * @sch. Disable and exit for @sch, switch over to
-			 * $parent, override the state to READY to account for
-			 * $p having already been initialized, and then enable.
+			 * $parent and override the state to READY to account
+			 * for $p having already been initialized.
 			 */
 			scx_disable_and_exit_task(sch, p);
 			scx_set_task_state(p, SCX_TASK_INIT_BEGIN);
 			scx_set_task_state(p, SCX_TASK_INIT);
 			scx_set_task_sched(p, parent);
 			scx_set_task_state(p, SCX_TASK_READY);
-			scx_enable_task(parent, p);
+
+			/*
+			 * A task on a non-ext class, possible under an
+			 * %SCX_OPS_SWITCH_PARTIAL root, stays READY and is
+			 * enabled by switching_to_scx() if it switches over.
+			 */
+			if (p->sched_class == &ext_sched_class)
+				scx_enable_task(parent, p);
 		}
 
 		task_rq_unlock(rq, p, &rf);
@@ -7726,10 +7733,14 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 
 			/*
 			 * $p is now only initialized for @sch and READY, which
-			 * is what we want. Assign it to @sch and enable.
+			 * is what we want. Assign it to @sch and, if it's on
+			 * the ext class, enable. A non-ext task, possible under
+			 * an %SCX_OPS_SWITCH_PARTIAL root, stays READY and is
+			 * enabled by switching_to_scx() if it switches over.
 			 */
 			scx_set_task_sched(p, sch);
-			scx_enable_task(sch, p);
+			if (p->sched_class == &ext_sched_class)
+				scx_enable_task(sch, p);
 
 			p->scx.flags &= ~SCX_TASK_SUB_INIT;
 		}
-- 
2.55.0

