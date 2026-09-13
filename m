Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2282AD2E
	for <sched-ext@lists.linux.dev>; Sun, 13 Sep 2026 06:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789282108; cv=none; b=d+lhtfGNwFZ5JsM1+iz0K9Hvu5TdVJAKSeMZe1CJAZ0LyA/7POygCQZu2cSELJi7xcsTzG8YX3ItlX6TWc09oumIFOjkv3smoo3vnvvY7VAq2UiaFtSka2p336jrd6QyjSCs3gVzmiehQ1qSJ9hMyvAmrtMLCqjVnF+ZEPXHDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789282108; c=relaxed/simple;
	bh=NutYZjBxzMe66jW2zqFRhhxwy5CY16mbZyEZ+NN/89A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJdu7eV9BQl3PQ+v0NSto9TAagDH/zH4sUbcbs6OSLCQeQnX+7R28ZMwnsQAdBf0pTGZSMH+Q9CrlX4dZ3PT8G/1zFdZGiYxDNl3mFUb6F2hbSHaLXYDLUFiYSrZqK88xnMo8z2S7DLc4JHh8d31eVqeGgYgitqb0c5gNKia8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hCVbDCBa; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hCVbDCBa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=GU
	+TuUcfrWu4SxBOyCiFLSOs3WkR+5LcdV+bX5c+4nM=; b=hCVbDCBa8XtpSb2uVt
	0oQsDngYAWuOTDruf1z1IN7H+bOfMKePyE8ZuvY09t+0OXpLZA1Z4tfqXITK7WLT
	X2iwlVSGf1Zwekyh8wK/GtJVmRLYDd57oMoFMKb6dEhhuru6Ky5rbWtEu8Ij1t2b
	NfUvfSofipTVvt9u/bKPat3KI=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBHJh4ER6ZqaYFfRQ--.32988S2;
	Sun, 13 Sep 2026 14:47:33 +0800 (CST)
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
Subject: [PATCH v5 3/4] sched/cache: Drive cache task tick from execution context
Date: Sun, 13 Sep 2026 15:47:21 +0900
Message-ID: <20260913064722.1534766-4-sh_def@163.com>
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
X-CM-TRANSID:QCgvCgBHJh4ER6ZqaYFfRQ--.32988S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4rZr4kAryDGr4rtr15XFb_yoW8ZFyUpr
	WqgF4UJrWktay5ZFy8Aa9YqF1fuwn3J342gFs8Gr4F9ry5G3WrKrnYq3W2vF10yr40yF12
	vr1j9r9rGw4jk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtrchUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6QUXdmqmRwWX8QAA3l

Proxy execution separates the scheduling context in rq->donor from the
execution context in rq->curr. Keep the fair task tick organized as one
donor-owned block followed by one execution-context block.

Task cache accounting is performed for rq->curr by account_mm_sched(), and
cache tick handling must operate on the same execution context. With proxy
execution, keeping task_tick_cache() on the donor can leave the executing
task's cache state and epoch stale.

Move task_tick_cache() into the execution-context section alongside the
NUMA tick. The final layout has one donor-owned block containing entity,
misfit, overutilized and core-scheduling work, followed by one
execution-context block containing NUMA and cache work. Preserve the normal
queued/hrtick gating while attributing each operation to the right context.

Fixes: df0d98475954 ("sched/cache: Introduce infrastructure for cache-aware load balancing")
Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/fair.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 002456cf9f8d..ed08b287016a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15082,7 +15082,6 @@ static void task_tick_fair(struct rq *rq, int queued)
 		}
 
 		if (!queued) {
-			task_tick_cache(rq, donor);
 			update_misfit_status(donor, rq);
 			check_update_overutilized_status(task_rq(donor));
 
@@ -15094,10 +15093,12 @@ static void task_tick_fair(struct rq *rq, int queued)
 		return;
 
 	/* Update state owned by the execution context. */
-	if (curr->sched_class == &fair_sched_class &&
-	    static_branch_unlikely(&sched_numa_balancing))
-		task_tick_numa(rq, curr);
+	if (curr->sched_class == &fair_sched_class) {
+		if (static_branch_unlikely(&sched_numa_balancing))
+			task_tick_numa(rq, curr);
 
+		task_tick_cache(rq, curr);
+	}
 }
 
 /*
-- 
2.55.0

