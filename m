Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DBD3E2AD3
	for <sched-ext@lists.linux.dev>; Wed,  9 Sep 2026 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946291; cv=none; b=HgzezUYk+MPt6pyz7kqLtgrwwTxVEOVEEzLZ4e/KpYqCx60wQY09q6+MLdbWLeDtq0Zlcp53eqpMp+gSec2EldHKYFsZF2IzXx2bhLm77Yb8CXHbufK+zr/Lcjofo4j7tGy0hJhxIM7w+JneZSpDYoakDP5F/crkYVge2zhg1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946291; c=relaxed/simple;
	bh=dzp/cz6XtJEb7AshXqW047SmmM7FxkI0NQk8T/5SQ7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZf3aYCMB/1MyJ04EwaNf282CF3Zmr+NeVtYtKXfpD/Wfyl/7V01G+unXREq25ZW2wxoSm/FFtFZ4WxVuwWgF4YAIqt4Lg+U9D2DnHKzdcWLPui5GZ0Y+ocxILC51ESiGHjuGO7IomQ4ZeZZHIhI/xCjiK2/RoasjRZ8z83IB5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gnGUSYSo; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gnGUSYSo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ih
	1JQwfZlCrnNtHvDKt/ccOFDKngz150nEn9NUT9v14=; b=gnGUSYSo7CNn1TZGQG
	wt2lcUvEiabg4mwlR6iH15zfFbjxwSghwmjtHEavdREXiSjQIlcdFxgceBgBRX3k
	lZv5zHHQgdlo6PJGdofAbvy/87mhrulu7jV1k8dh4yZJxDj4p5ANGGuyXNtfFHtS
	qmOgU+YgQqIhbI0VONVpYLsN0=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXfysSJ6FqovnTQg--.10264S2;
	Wed, 09 Sep 2026 17:29:55 +0800 (CST)
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
Subject: [PATCH v4 3/5] sched/cache: Drive cache task tick from execution context
Date: Wed,  9 Sep 2026 18:28:59 +0900
Message-ID: <20260909092901.2989564-4-sh_def@163.com>
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
X-CM-TRANSID:QCgvCgDXfysSJ6FqovnTQg--.10264S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy5ZrWxGrW7Jr1rWF48JFb_yoW8CrW3pr
	WDuF47Wr4rta15tFWxZan5XF1rW3s7A342gF4DGF4rur1rG34rKr18ta1agFWjyryFkF9F
	vryj9ry7Gr4jk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaUDXUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6RPQMGqhJxObewAA3F

Cache-aware scheduling accounts CPU runtime to the mm of the task actually
executing. update_se() passes rq->curr to account_mm_sched() for this
purpose.

With proxy execution, task_tick_cache() still runs for the scheduling
context in rq->donor. When a fair task executes on behalf of an RT or
deadline donor, its mm runtime advances but its cache scan epoch is not
driven. This can cause account_mm_sched() to invalidate the mm's preferred
LLC.

Run task_tick_cache() from the fair execution-context section of
task_tick_fair(), alongside NUMA tick handling, so cache work and runtime
accounting refer to the same task and mm.

Fixes: df0d98475954 ("sched/cache: Introduce infrastructure for cache-aware load balancing")
Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/fair.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a8c7a9a29ace..43d558289856 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15086,13 +15086,15 @@ static void task_tick_fair(struct rq *rq, int queued)
 		return;
 
 	/* Update state owned by the execution context. */
-	if (curr->sched_class == &fair_sched_class &&
-	    static_branch_unlikely(&sched_numa_balancing))
-		task_tick_numa(rq, curr);
+	if (curr->sched_class == &fair_sched_class) {
+		if (static_branch_unlikely(&sched_numa_balancing))
+			task_tick_numa(rq, curr);
 
-	if (donor->sched_class == &fair_sched_class) {
-		task_tick_cache(rq, donor);
+		task_tick_cache(rq, curr);
+	}
 
+	/* Update state owned by the scheduling context. */
+	if (donor->sched_class == &fair_sched_class) {
 		update_misfit_status(donor, rq);
 		check_update_overutilized_status(task_rq(donor));
 
-- 
2.55.0

