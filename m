Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647748;
	b=qOUPGdP6NHwjqZWMBeIAeMkqqTukAcYHhW/BwD6cnH36Orl0q7xAfspCRAWxfQFSjnVX
	 W4VGTalJDbBmirSVfQ0LajvYIuyiyR2lWA9hxpInsABFDL+1+j9ydAwjIWeCcVIWCnW51
	 H2GXLLvRj57HNvgpWwoTBM81geulmzflhNmVJnh8XAcwFHNeuEV1P4gPcZfXOfTe66H/g
	 H8wFVSo5DnitGGbvGd/D9otL7nXzfzy+jDgdXRp/bMqySeqYSoum5z7W2Ilpk+WF38LL+
	 lwCNJBd4c932kGMBO0ySG6aKy1JibkFfkJefsuri1dyVBl3vFN4o/mZnkLNkMrs6Pkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647748;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l8oMOFBUnxX0SXd942Bitnq6SLdMARMTndQMOs5MKuU=;
	b=BiYzUrPkeMCRWS7Ch3AJAYLR9J+C0/KlQefjQTXdTwYTg5rxgrtnBSNpe4AP4U0chBkt
	 4WqVI+srk165y4UaSYbKZAuX8m2HgJSJbqL3w/091dMdr1lPCI3d2O1MbjX4gAk+UhBIa
	 B1pc8nXC2IuZTcsNawC8QeL7fO/nHkDwFTkfPS6daqiMJXNrJrXA0xxqnZtYFJgaHLkWQ
	 DqonEhUs5gSgva4Ajk6fqPbv/av8kUw781jWHE6t6ZZndFW1qMyteOPnpmmQAzretMvbq
	 jr+CPnwgUZEuayVdFFKIF0KJkZ5XBoz0QaUanc+4bBfenRBpznVNu49IAknhU/y+pkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMl90w3v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E404606A324;
	Mon,  2 Nov 2026 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMl90w3v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5661F00A16;
	Mon,  2 Nov 2026 19:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793647748;
	bh=l8oMOFBUnxX0SXd942Bitnq6SLdMARMTndQMOs5MKuU=;
	h=From:To:Cc:Subject:Date;
	b=KMl90w3v8Yz8ZZVbgLdl3uosIUH1XgErRE//c8+Q7iOqCTksUFTuhoXkNe6SNEABK
	 ts0geKM6+4iJWzmVv+fKZ6ncTt1PkWsLTRzDOmfWwvhIlz8Qkz4j7BrMgWkU+rhIym
	 Gqo59FJvrMTF80mDd3mv3SoYIgG1SykMh4jSO5dt0sJori6+e0hWreEWZb7rsFQYHF
	 jgSAStUwxcHB+0bf6UWjzEv2/yE6dzkzOEaP4daXOy67s3z5B5oCbvHOCTKXqEGIrX
	 EpqKK18ewNmYhN3Dcxqt4mhvVE/ib5Iqv1A31KCOJQIRsvYtGo/AW1UW/s508HSEEV
	 qZd8M63HlKv1A==
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	John Stultz <jstultz@google.com>,
	Andrea Righi <arighi@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched/urgent] sched/core: Don't lower rq->next_class in proxy_reset_donor()
Date: Mon,  2 Nov 2026 09:29:07 -1000
Message-ID: <20261102192907.2177529-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A pick that drops the rq lock, sched_balance_newidle() or
do_pick_task_scx(), first lowers rq->next_class to its own class if it's
above. After relocking, it restarts if rq_modified_above() shows a higher
class wakeup. proxy_reset_donor() sets next_class to rq->curr's class
unconditionally and can lower it in that window. With a sched_ext task as
rq->curr:

1. fair's queue is empty and sched_balance_newidle() drops the rq lock with
   next_class at ext from the last pick.
2. An RT wakeup raises next_class to rt and calls resched_curr().
3. rq->donor, which proxy exec migrated to this CPU, wakes up.
   proxy_needs_return() calls proxy_reset_donor(), which sets next_class
   back to ext.
4. rq_modified_above() sees nothing above fair, sched_ext returns a task and
   __schedule() clears need_resched. The RT task runs only at the CPU's next
   schedule.

This needs a sched_ext donor. With a fair donor, fair's queue isn't empty
and newidle doesn't run, and RT and DL donors are picked before fair. Proxy
exec with sched_ext became possible with c6fe97c34a1a ("sched: Allow
enabling proxy exec with sched_ext").

Only raise next_class in proxy_reset_donor(). next_class above rq->curr's
class is what wakeup_preempt() leaves after any higher class wakeup, and the
->wakeup_preempt() methods ignore a donor of another class since
fa02b2868420 ("sched/core: Fix inter-class wakeup_preempt()"). The
resched_curr() in proxy_reset_donor() makes the next pick set next_class.
The raise stays so that rq_modified_above() still catches a reset to a curr
of a higher class.

Fixes: c6fe97c34a1a ("sched: Allow enabling proxy exec with sched_ext")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04b62c16fa8c..f850f4ae19ea 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3809,7 +3809,12 @@ static inline void proxy_reset_donor(struct rq *rq)
 	WARN_ON_ONCE(rq->donor == rq->curr);
 
 	put_prev_set_next_task(rq, rq->donor, rq->curr);
-	rq->next_class = rq->curr->sched_class;
+	/*
+	 * A pick that dropped the rq lock checks next_class after relocking to
+	 * catch a higher class wakeup, see rq_modified_above(). Don't lower it.
+	 */
+	if (sched_class_above(rq->curr->sched_class, rq->next_class))
+		rq->next_class = rq->curr->sched_class;
 	rq_set_donor(rq, rq->curr);
 	zap_balance_callbacks(rq);
 	resched_curr(rq);
-- 
2.56.0

