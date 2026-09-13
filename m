Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CD356750
	for <sched-ext@lists.linux.dev>; Sun, 13 Sep 2026 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789282105; cv=none; b=MUPNHCLgGoLnNPyl5d0pw5qvgp0pnmDBdHBvrBEaMTpmVIh7sfHQYJtOnaz8GKwc8fKQo9KaAfA/Qn8XpsSaSHjOuwe6LUXpEwaSZY1QYInXwh2bg6tUhlXiN50WOV0Fq/JU5AQmcSkCSFu8PuzCZe2Ya6okZeijFQWnXYWzg3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789282105; c=relaxed/simple;
	bh=N5ToNp5LZjfiYCgANS1U7zesxQ9cbBbdJ9qJa4nhuoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hs8+poRnytN4H8M90xqhMqPROj589Pj6BW4IhcRDq/INu/718RWMAO0F6bWmWtKNTcY3klxOvnj1WdJbCqJazqRKqqEc/B92yOLbVxy0T+94bk1G3MIYnQITVQngpTkXufN6OGYBgcjE621JLJKBJMapoaNaUjjDstRQW8p/lAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cq/H7W41; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cq/H7W41"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=z6
	VU2sEzMZnU3iYO4KQfIiHIv73H1TxSzgtCCUe/gSg=; b=cq/H7W41JvviZ/6lZT
	j746NyVWszYL6zQ0lAoUh2GNg1Hfbq7tz84ym6udd0XJZEm1+Mgpmb3DCfF20SGn
	npQJtaqKFLfw3nfkK47I4LaZ0Fkv/0IQVvvDfRuiovos0cP34nLd3rH19GsrtVUg
	kMXot8clPn273EWAnwGoaGEdI=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3V0ADR6ZqhX2YAQ--.37172S2;
	Sun, 13 Sep 2026 14:47:32 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: peterz@infradead.org,
	soolaugust@gmail.com,
	arighi@nvidia.com
Cc: mingo@redhat.com,
	kprateek.nayak@amd.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	connoro@google.com,
	jstultz@google.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH v5 2/4] sched/numa: Drive NUMA task tick from execution context
Date: Sun, 13 Sep 2026 15:47:20 +0900
Message-ID: <20260913064722.1534766-3-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913064722.1534766-1-sh_def@163.com>
References: <20260913064722.1534766-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V0ADR6ZqhX2YAQ--.37172S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1kGryUXF48Gr18WrW5Awb_yoW5uFW7pF
	Z0ka4aqrZrKa1YqF17ZrWDX3WfGwn7A347WF4DGF48ur1Ut39Y9rn3KFWSqF4YyrW0kFy2
	vrWj9r17Cr1UKw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtrchUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6QQXdmqmRwSX4wAA33

Proxy execution separates the scheduling context in rq->donor from the
execution context in rq->curr. The task tick dispatcher can therefore
invoke task_tick_fair() for either side of a cross-class proxy
relationship.

task_tick_numa() operates on state associated with the task actually
executing, including its mm and NUMA work state. Task-level execution
runtime is likewise accounted to rq->curr, and task_tick_numa() uses that
runtime to drive periodic NUMA scanning.

Order task_tick_fair() as one donor-owned block followed by one
execution-context block. Keep the cache tick in the donor block for this
patch; the following patch moves it with the other execution-context work.
Run the NUMA tick only when rq->curr belongs to the fair scheduling class.
The donor class tick runs first, so execution runtime is accounted before
the NUMA tick consumes it.

Fixes: 7de9d4f94638 ("sched: Start blocked_on chain processing in find_proxy_task()")
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20260909110348.GZ4120091@noisy.programming.kicks-ass.net
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/fair.c | 46 +++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6f1777799371..002456cf9f8d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15061,41 +15061,43 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
  */
 static void task_tick_fair(struct rq *rq, int queued)
 {
-	struct task_struct *donor = rq->donor;
-	struct sched_entity *se;
+	struct task_struct *curr = rq->curr, *donor = rq->donor;
 
-	if (donor->sched_class != &fair_sched_class)
-		return;
+	if (donor->sched_class == &fair_sched_class) {
+		struct sched_entity *se = &donor->se;
 
-	se = &donor->se;
+		if (se->on_rq) {
+			unsigned long weight = NICE_0_LOAD;
+			struct cfs_rq *cfs_rq;
 
-	if (se->on_rq) {
-		unsigned long weight = NICE_0_LOAD;
-		struct cfs_rq *cfs_rq;
+			for_each_sched_entity(se) {
+				cfs_rq = cfs_rq_of(se);
+				entity_tick(cfs_rq, se, queued);
 
-		for_each_sched_entity(se) {
-			cfs_rq = cfs_rq_of(se);
-			entity_tick(cfs_rq, se, queued);
+				weight = __calc_prop_weight(cfs_rq, se, weight);
+			}
 
-			weight = __calc_prop_weight(cfs_rq, se, weight);
+			se = &donor->se;
+			reweight_eevdf(cfs_rq, se, weight, se->on_rq);
 		}
 
-		se = &donor->se;
-		reweight_eevdf(cfs_rq, se, weight, se->on_rq);
+		if (!queued) {
+			task_tick_cache(rq, donor);
+			update_misfit_status(donor, rq);
+			check_update_overutilized_status(task_rq(donor));
+
+			task_tick_core(rq, donor);
+		}
 	}
 
 	if (queued)
 		return;
 
-	if (static_branch_unlikely(&sched_numa_balancing))
-		task_tick_numa(rq, donor);
-
-	task_tick_cache(rq, donor);
-
-	update_misfit_status(donor, rq);
-	check_update_overutilized_status(task_rq(donor));
+	/* Update state owned by the execution context. */
+	if (curr->sched_class == &fair_sched_class &&
+	    static_branch_unlikely(&sched_numa_balancing))
+		task_tick_numa(rq, curr);
 
-	task_tick_core(rq, donor);
 }
 
 /*
-- 
2.55.0

