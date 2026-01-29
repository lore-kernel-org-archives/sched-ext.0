Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D92B37F0F2
	for <sched-ext@lists.linux.dev>; Thu, 29 Jan 2026 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678758; cv=none; b=fIlYltfML5SDTWcB+2oQSiFT1YphUKUvJHUjBPuXR10Zy1PERsqqHwcdqD5AlrSqyQK7O1n+Z8vPdBYgcpjFFSlsCS7tmcUkUqPp7wmmgygA/sxV2mAVu5DaRY+Q1nDFmRVNTlFLHjQRGg5dDXFNf22FhHtJTRUiOgDaaqF+ycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678758; c=relaxed/simple;
	bh=2vL5vaBKvnf50L++sEE/srNQXP9JQAti5uItm2EwmNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q00RfrOVy610j8HgH3sQlzdifYnyq1VCcDi/5Yt9D9frhJR1OM/dMQlw9MoTXHNaluhYNUH2axGBn4YyXwTULih9yIhikH8HGm08/S3xOIdpzNoUWG9eRl5+dtwUNd69hHGTgmaHuaJlr6+jFn4AEx4JoLSKHChltQ1mGTwpQ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A9C1153B;
	Thu, 29 Jan 2026 01:25:49 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.33.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6AF5F3F73F;
	Thu, 29 Jan 2026 01:25:54 -0800 (PST)
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org,
	tj@kernel.org
Cc: arighi@nvidia.com,
	void@manifault.com,
	sched-ext@lists.linux.dev,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 1/2] sched_ext: Don't kick CPUs running higher classes
Date: Thu, 29 Jan 2026 09:25:45 +0000
Message-Id: <20260129092546.49128-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129092546.49128-1-christian.loehle@arm.com>
References: <20260129092546.49128-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

commit a9c1fbbd6dadbaa38c157a07d5d11005460b86b9 upstream.

When a sched_ext scheduler tries to kick a CPU, the CPU may be running a
higher class task. sched_ext has no control over such CPUs. A sched_ext
scheduler couldn't have expected to get access to the CPU after kicking it
anyway. Skip kicking when the target CPU is running a higher class.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 31eda2a56920..3d53b2232937 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5164,18 +5164,23 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *pseqs)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct scx_rq *this_scx = &this_rq->scx;
+	const struct sched_class *cur_class;
 	bool should_wait = false;
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
+	cur_class = rq->curr->sched_class;
 
 	/*
 	 * During CPU hotplug, a CPU may depend on kicking itself to make
-	 * forward progress. Allow kicking self regardless of online state.
+	 * forward progress. Allow kicking self regardless of online state. If
+	 * @cpu is running a higher class task, we have no control over @cpu.
+	 * Skip kicking.
 	 */
-	if (cpu_online(cpu) || cpu == cpu_of(this_rq)) {
+	if ((cpu_online(cpu) || cpu == cpu_of(this_rq)) &&
+	    !sched_class_above(cur_class, &ext_sched_class)) {
 		if (cpumask_test_cpu(cpu, this_scx->cpus_to_preempt)) {
-			if (rq->curr->sched_class == &ext_sched_class)
+			if (cur_class == &ext_sched_class)
 				rq->curr->scx.slice = 0;
 			cpumask_clear_cpu(cpu, this_scx->cpus_to_preempt);
 		}
-- 
2.34.1

