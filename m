Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2843E558D;
	Sat, 17 Oct 2026 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215444; cv=none; b=dAlM/yfvHcvsN1T1ApRvYkGD2NsIfXxBpWHKBmlcW4c6LsITK/POmD3cThKau0aGkljFZMlHEV3qwq4DiHUuX+ZcKvlf1xbtSSyVvax7g+EiInbzSJgSyz3y91VXtK8g5Wkk9HxC3Qngt9Q5iGC0/t0w2wP9S1aoNSWGxp3k54M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215444; c=relaxed/simple;
	bh=PsPrVLy6AkIrddmi/bMiRtmCHmuce3pAL6AAf5Me+rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQnBbqlJXT00GWtlLccBue2Lh3/bcyrSaaTqjrA0qfRl9JGoRmHP6WXBeD3lxOfQoOrY9WYOkRfy48kSYaAy+NPKnoP4yiqVxvXvjQeg28pE6wrqPMNDkhPoFliSourQvJ+ytdq6MlPaVGeEPpSXYnILelsdpjOTXQzSC5PoI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcXZqmBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcXZqmBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430851F000C5;
	Sat, 17 Oct 2026 05:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792215439;
	bh=LRmBMThYMM7ic70JULoLql06ueyZigANJI1ix7iZlWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VcXZqmBsBxseUnG7NViMwrqgdXEdX3BcqoXEL39uloXxzaHza1wEWx97mnXpYmXlg
	 fKFxRSvASwzmSOqf55e5JtU2JjbFYWyOfXu/VFkl3JgMqipbbThzz2lMfqtB6SR8de
	 jE5/xc9Q8n310BC2r2hh38vjTxPsmCD4VnP7mU6EImdo4AY0lV0yDJtBuj9ItWHscg
	 aN53YBRuRQMw0CkazbA/i0KPXJFr6ESksh19v7IUvtprlCP81pF+7SN/Jag6JbgzJH
	 EjUthxILpuO1dgiJEHG6k64wf3UPTHIpzVCW+6xD7r+BCMCcFRihbDxbArJiCe6jjy
	 AStskyu9c8+Jw==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched_ext: Fix the running task keeping its protection into bypass
Date: Fri, 16 Oct 2026 19:37:16 -1000
Message-ID: <20261017053717.3162619-2-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017053717.3162619-1-tj@kernel.org>
References: <20261017053717.3162619-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protection ends when the scheduler enters bypass, so that bypass scheduling
can cut every task's slice. scx_bypass() clears it for the queued tasks by
cycling them, and strips the running task's in the same walk over
rq->scx.runnable_list. The running task is never on that list.
set_next_task_scx() takes it off and put_prev_task_scx() puts it back, so
the strip never runs. A protected running task then keeps its slice into
bypass, where the tick's attempts to cut it are refused.

Strip the running task's protection outside the walk.

Fixes: 9cfc6ab34a31 ("sched_ext: Add SCX_TASK_PROTECTED")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 2c213153bdab..d6689bf8e769 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6318,6 +6318,16 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 			continue;
 		}
 
+		/*
+		 * Bypass trumps protection. Cycling the queued tasks below
+		 * clears theirs. The current task isn't on the runnable list,
+		 * so strip its protection here.
+		 */
+		p = rq->curr;
+		if (bypass && p->sched_class == &ext_sched_class &&
+		    scx_is_descendant(scx_task_sched(p), sch))
+			scx_task_slice_ended(rq, p);
+
 		/*
 		 * The use of list_for_each_entry_safe_reverse() is required
 		 * because each task is going to be removed from and added back
@@ -6330,13 +6340,6 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 			if (!scx_is_descendant(scx_task_sched(p), sch))
 				continue;
 
-			/*
-			 * Bypass trumps protection. Cycling clears for queued
-			 * tasks but current task needs explicit stripping.
-			 */
-			if (bypass && task_current(rq, p))
-				scx_task_slice_ended(rq, p);
-
 			/* cycling deq/enq is enough, see the function comment */
 			scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
 				/* nothing */ ;
-- 
2.56.0

