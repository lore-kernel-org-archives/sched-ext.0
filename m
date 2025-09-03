Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B472EC56F
	for <sched-ext@lists.linux.dev>; Wed,  3 Sep 2025 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934618; cv=none; b=BhUNWfSlVnT7qvaWSn81g9ktZyxkKgEa8ypQqaB7a+4GIjZmSyY8qoJr8vwNKyrYOUV6BkyezodCge1s0SDPVOdcx4wkP2FZVofCDRjW34u/JBdTqLNtlJwD1ub/Xbw177kRyb9sCUEX/L2sUFSW1yFOlcIbDnr4Pg3PfmqJ6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934618; c=relaxed/simple;
	bh=ElRvS8XUhRJeZToccc++Fe/3u4yPQ0/w/ug2DD+z+Xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VkpP6AQ68EOUTbgY3TpYNChztSrs3QJWZP4yI7ckTyhcNDd0SloJ79WovoHG114w63y1acOJOpq8vdmyJIDCPa2zufFNgP3cxCo7XShwows7PvK3tkKrP2HWTTtWGLGwoHdC03jNlJ4I2XCB4S/C2+UJai4AXHhqKO7+P+nkf9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E0421CE0;
	Wed,  3 Sep 2025 14:23:28 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.93.203])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 044C23F694;
	Wed,  3 Sep 2025 14:23:34 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: tj@kernel.org,
	arighi@nvidia.com,
	void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	changwoo@igalia.com,
	hodgesd@meta.com,
	mingo@redhat.com,
	peterz@infradead.org,
	jake@hillion.co.uk,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v7 3/3] sched_ext: deprecation warn for scx_bpf_cpu_rq()
Date: Wed,  3 Sep 2025 22:23:11 +0100
Message-Id: <20250903212311.369697-4-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903212311.369697-1-christian.loehle@arm.com>
References: <20250903212311.369697-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_cpu_rq() works on an unlocked rq which generally isn't safe.
For the common use-cases scx_bpf_locked_rq() and
scx_bpf_cpu_curr() work, so add a deprecation warning
to scx_bpf_cpu_rq() so it can eventually be removed.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6ea81b6a6b2d..1a0afdf5fcf5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -873,6 +873,7 @@ struct scx_sched {
 	struct scx_event_stats __percpu *event_stats_cpu;
 
 	bool			warned_zero_slice;
+	bool			warned_deprecated_rq;
 
 	atomic_t		exit_kind;
 	struct scx_exit_info	*exit_info;
@@ -7424,9 +7425,18 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
  */
 __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 {
+	struct scx_sched *sch = scx_root;
+
 	if (!kf_cpu_valid(cpu, NULL))
 		return NULL;
 
+	if (!sch->warned_deprecated_rq) {
+		printk_deferred(KERN_WARNING "sched_ext: %s() is deprecated; "
+				"use scx_bpf_locked_rq() when holding rq lock "
+				"or scx_bpf_cpu_curr() to read remote curr safely.\n", __func__);
+		sch->warned_deprecated_rq = true;
+	}
+
 	return cpu_rq(cpu);
 }
 
-- 
2.34.1

