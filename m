Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396B544CAF6;
	Wed, 21 Jan 2026 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037118; cv=none; b=DR09oc6U1VunrdBgwkwZiA9/EE7fDqu6Et1l3yA3DblAMOJkcS+vdchrgwsCD9aukW5y5p8Xc9IPbq6p4NJ1qbmEEsB4ZaD0IdmDM31VfKyW+xJI2ovKYPhAetYl2RbMEPTL0PuK6DMco5Cmvg0rtsI4ougXXuEs8o9fChVWOJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037118; c=relaxed/simple;
	bh=jlVTlmutiKmoZkpAQi7bOF2Dgrl2Av/7OHoIpz9TUtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+g9YfEzfuoe3O+27O6q5wXATuv40qZzmVqIhi3JzwNrg10GCzEB84skgp0ZP/1Lc/f6ggFdr1WKpXwT1kbnw75N5vtq/IWwvS/lj7q7Gw+F1Dm1WrYc9YAJ3aXRbyCetLN60hMaxEMRpT2G1OcquI4jx7awQ39R+CKHUjilztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btdjPfag; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btdjPfag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3555FC16AAE;
	Wed, 21 Jan 2026 23:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037117;
	bh=jlVTlmutiKmoZkpAQi7bOF2Dgrl2Av/7OHoIpz9TUtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btdjPfagz6RvVRRM4YJ74OVj8DFij/MjCfONbnxRz0H4j675eVquYxM4PTre2E2no
	 NTf54IQlbvQUjeesF1DwHfeGncKGr2ts2qsu6PXy5ZpzLsi8/6RQ2ATb8mmWHc6Yz1
	 YJIoYnivo2AKEhfCvvH5Q//1WTAfrxR7RN6SCafhJZmboJGFkxVAzf4crv2sSw45E2
	 HhbrMgNnbhhEYgtX81RJBIl+Yn8eEWM8zVAvdBHex8mDO34cPcjRR3HTHXKJIh+DQI
	 Zq8dxYprhh9CyhyX+XOoh+bvotBYddoltJkPV0X0ui4b1MCP+7yP+mlrm47KdTSlvQ
	 KpvhwwmXv4z5g==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 15/34] sched_ext: Move default slice to per-scheduler field
Date: Wed, 21 Jan 2026 13:11:21 -1000
Message-ID: <20260121231140.832332-16-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121231140.832332-1-tj@kernel.org>
References: <20260121231140.832332-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default time slice was stored in the global scx_slice_dfl variable which
was dynamically modified when entering and exiting bypass mode. With
hierarchical scheduling, each scheduler instance needs its own default slice
configuration so that bypass operations on one scheduler don't affect others.

Move slice_dfl into struct scx_sched and update all access sites. The bypass
logic now modifies the root scheduler's slice_dfl. At task initialization in
init_scx_entity(), use the SCX_SLICE_DFL constant directly since the task may
not yet be associated with a specific scheduler.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 12 ++++++------
 kernel/sched/ext_internal.h |  1 +
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ad4f8fbc0f24..aad534a8f704 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -164,7 +164,6 @@ static struct kset *scx_kset;
  * There usually is no reason to modify these as normal scheduler operation
  * shouldn't be affected by them. The knobs are primarily for debugging.
  */
-static u64 scx_slice_dfl = SCX_SLICE_DFL;
 static unsigned int scx_slice_bypass_us = SCX_SLICE_BYPASS / NSEC_PER_USEC;
 static unsigned int scx_bypass_lb_intv_us = SCX_BYPASS_LB_DFL_INTV_US;
 
@@ -1127,7 +1126,7 @@ static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
 
 static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 {
-	p->scx.slice = READ_ONCE(scx_slice_dfl);
+	p->scx.slice = READ_ONCE(sch->slice_dfl);
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
@@ -3151,7 +3150,7 @@ void init_scx_entity(struct sched_ext_entity *scx)
 	INIT_LIST_HEAD(&scx->runnable_node);
 	scx->runnable_at = jiffies;
 	scx->ddsp_dsq_id = SCX_DSQ_INVALID;
-	scx->slice = READ_ONCE(scx_slice_dfl);
+	scx->slice = SCX_SLICE_DFL;
 }
 
 void scx_pre_fork(struct task_struct *p)
@@ -4262,7 +4261,7 @@ static void scx_bypass(bool bypass)
 		WARN_ON_ONCE(scx_bypass_depth <= 0);
 		if (scx_bypass_depth != 1)
 			goto unlock;
-		WRITE_ONCE(scx_slice_dfl, scx_slice_bypass_us * NSEC_PER_USEC);
+		WRITE_ONCE(sch->slice_dfl, scx_slice_bypass_us * NSEC_PER_USEC);
 		bypass_timestamp = ktime_get_ns();
 		if (sch)
 			scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
@@ -4278,7 +4277,7 @@ static void scx_bypass(bool bypass)
 		WARN_ON_ONCE(scx_bypass_depth < 0);
 		if (scx_bypass_depth != 0)
 			goto unlock;
-		WRITE_ONCE(scx_slice_dfl, SCX_SLICE_DFL);
+		WRITE_ONCE(sch->slice_dfl, SCX_SLICE_DFL);
 		if (sch)
 			scx_add_event(sch, SCX_EV_BYPASS_DURATION,
 				      ktime_get_ns() - bypass_timestamp);
@@ -5111,6 +5110,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	sch->ancestors[level] = sch;
 	sch->level = level;
 
+	sch->slice_dfl = SCX_SLICE_DFL;
 	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
 	init_irq_work(&sch->error_irq_work, scx_error_irq_workfn);
 	kthread_init_work(&sch->disable_work, scx_disable_workfn);
@@ -5447,7 +5447,7 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			queue_flags |= DEQUEUE_CLASS;
 
 		scoped_guard (sched_change, p, queue_flags) {
-			p->scx.slice = READ_ONCE(scx_slice_dfl);
+			p->scx.slice = READ_ONCE(sch->slice_dfl);
 			p->sched_class = new_class;
 		}
 	}
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 335e90ca132e..8836bad027ea 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -950,6 +950,7 @@ struct scx_sched {
 	struct scx_dispatch_q	**global_dsqs;
 	struct scx_sched_pcpu __percpu *pcpu;
 
+	u64			slice_dfl;
 	s32			level;
 
 	/*
-- 
2.52.0

