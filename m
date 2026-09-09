Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148BC3F1AC6
	for <sched-ext@lists.linux.dev>; Wed,  9 Sep 2026 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946279; cv=none; b=Hewd/Hs2A3Z+CkMjvsB598jEPqhlwYJC3ejsZXfSAZRgEhbejLSasmufqn7CChIzslr81qWlPxQpsv9h7y7/GH57chkswQCx/zuhqZqNRMtxy37GolIoJnNMPZ7b5mR7mbA84M1RVpNMD6LoXWx5ssPrpCpXsOzrwiXrga117ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946279; c=relaxed/simple;
	bh=aaqpDOS9Q9cZvmbCAbQLpx2aBdRlsOav7VgVnknEK0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtJhk4L729WWZN92jVGnDPU9UUXTXQdfhirFtDqmAEmN6kUNzhU8durHQLKG+cuvlr2lGtNAlXmHc1riB6uGmytb+5fvzIGeGsOOexHU9cKtY1qZd9+K2/DR7KbykLt8QACjqkpIgiNNGMy/dFYeCPZF1L1yAWb4H7NOEWi8X6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E9ORiZoi; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E9ORiZoi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=j6
	BQax1ALxulWvxdR+klhw1jBgkWS9cMRWy4AOIlkWk=; b=E9ORiZoivaGpH5n/np
	x29ZqGaaYzaqd+IDAmET7IQ7ZFV7WzS96iFwUQXweCC4GNIsrILirkxiYc5l23mk
	efUZVjaT3UBXFNw2OHq/PRTuHG75VU8tyuSuuuB7KsCJAFJ6b3fNwuyOEDvMuSRM
	ZrQjvcNDTCYoouIn8mJemuITY=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD311ARJ6FqNvVuBg--.47931S2;
	Wed, 09 Sep 2026 17:29:54 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	tim.c.chen@linux.intel.com,
	yu.c.chen@intel.com,
	kprateek.nayak@amd.com
Cc: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	connoro@google.com,
	jstultz@google.com,
	arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH v4 2/5] sched/numa: Drive NUMA task tick from execution context
Date: Wed,  9 Sep 2026 18:28:58 +0900
Message-ID: <20260909092901.2989564-3-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909092901.2989564-1-sh_def@163.com>
References: <20260909092901.2989564-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD311ARJ6FqNvVuBg--.47931S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1kGr45GFykuF4kWry8Zrb_yoW5CF1fpF
	s0ka4aq3y7ta1YqF17ZrWDX3WfGwn3A347WFZrGFW8ur1UK3sY9rn3KFySqF4rArW0kFy2
	vrWj9r17Cr1UKw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaUDXUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwhLQMGqhJxIp4AAA3H

Proxy execution separates the scheduling context in rq->donor from the
execution context in rq->curr. The task tick dispatcher can therefore
invoke task_tick_fair() for either side of a cross-class proxy
relationship.

task_tick_numa() operates on state associated with the task actually
executing, including its mm and NUMA work state. Task-level execution
runtime is likewise accounted to rq->curr, and task_tick_numa() uses that
runtime to drive periodic NUMA scanning.

Split task_tick_fair() into donor and execution-context sections and run
the NUMA tick only when rq->curr belongs to the fair scheduling class. The
donor class tick runs first, so execution runtime is accounted before the
NUMA tick consumes it.

Fixes: 7de9d4f94638 ("sched: Start blocked_on chain processing in find_proxy_task()")
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/fair.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6f1777799371..a8c7a9a29ace 100644
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
-
-		se = &donor->se;
-		reweight_eevdf(cfs_rq, se, weight, se->on_rq);
 	}
 
 	if (queued)
 		return;
 
-	if (static_branch_unlikely(&sched_numa_balancing))
-		task_tick_numa(rq, donor);
+	/* Update state owned by the execution context. */
+	if (curr->sched_class == &fair_sched_class &&
+	    static_branch_unlikely(&sched_numa_balancing))
+		task_tick_numa(rq, curr);
 
-	task_tick_cache(rq, donor);
+	if (donor->sched_class == &fair_sched_class) {
+		task_tick_cache(rq, donor);
 
-	update_misfit_status(donor, rq);
-	check_update_overutilized_status(task_rq(donor));
+		update_misfit_status(donor, rq);
+		check_update_overutilized_status(task_rq(donor));
 
-	task_tick_core(rq, donor);
+		task_tick_core(rq, donor);
+	}
 }
 
 /*
-- 
2.55.0

