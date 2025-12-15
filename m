Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47F330335
	for <sched-ext@lists.linux.dev>; Mon, 15 Dec 2025 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798205; cv=none; b=ahX4YFlXdsXv+vLtsY4jh/1lAdFL1wRAYLnqvxlC08zHaBA5k1rFxM3AJUfFyobtRL87BABb5dc1jGlzUz9kumrdds6XIsATsXJwOpMDUHS1Gl6p5B3mGg5asNFg6T7julKRH7c9gRnhgpyNkYLsUn9ODV5tnq9A7NNLcOOBHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798205; c=relaxed/simple;
	bh=7VLHSdzKxUCRStujZLx5p59uRGdezuyyTYT8jDvVGIc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gfDkLKumNjObGdQt5yNkQO9vV+pRub5DuI0A4r+vIYzi+Ax95kJfXwsVEfo5x4rMdCR3LgGNf0NfvGmRmPsUWOC6585iQOPgeLCWfPIz3cVHmlu85KVexZrEc4Jn5ZKIIRyNOTgoN33HvAHPNjIlQvReVQ4w0D0gUqFyHvTjLN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R1el3xBm; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R1el3xBm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765798199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=4W1FedU1RCa0yAwIRVGo/nEgetuazo+TJ9dRvMEdbmA=;
	b=R1el3xBm7GNVhp2En5/WeY532zXNVZxN3mRgZUpknNjhZzKMNHYn3iL9E+u0F7aD6W5F4K
	s+AAskWsrJue0qY6P1vWXD4W1MNl1K4hI2SfO3Kic8Bq6mdWQrtzNjxyGbLDsSVXT4QIJw
	SN+vgmLtr8vZnfqrqCXzQO96VEWvYvc=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] sched_ext: Remove unused code in the do_pick_task_scx()
Date: Mon, 15 Dec 2025 19:29:40 +0800
Message-Id: <20251215112940.23640-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The kick_idle variable is no longer used, this commit therefore remove
it and also remove associated code in the do_pick_task_scx().

Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()"),
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/sched/ext.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 695503a2f7d1..94164f2dec6d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2446,7 +2446,7 @@ static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
 	struct task_struct *prev = rq->curr;
-	bool keep_prev, kick_idle = false;
+	bool keep_prev;
 	struct task_struct *p;
 
 	/* see kick_cpus_irq_workfn() */
@@ -2488,12 +2488,8 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 			refill_task_slice_dfl(rcu_dereference_sched(scx_root), p);
 	} else {
 		p = first_local_task(rq);
-		if (!p) {
-			if (kick_idle)
-				scx_kick_cpu(rcu_dereference_sched(scx_root),
-					     cpu_of(rq), SCX_KICK_IDLE);
+		if (!p)
 			return NULL;
-		}
 
 		if (unlikely(!p->scx.slice)) {
 			struct scx_sched *sch = rcu_dereference_sched(scx_root);
-- 
2.17.1

