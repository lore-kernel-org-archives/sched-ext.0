Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376C3D3D02;
	Wed,  4 Mar 2026 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661697; cv=none; b=lfXKb2HNLKgIU129Hco2hQOHa4yWGDV2EXUlPi2xaHc6VHb5YqTh/5zP53G9KFzAY3b4F5odAm8AXTFI9NO8VJUduS7S02hFpdDm3B6axaeij+jA9DO100c0EX8OOFk+Ib7JuaASA79MNRyKKn/PHv6RKkH0lMNW5kipcXsfP2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661697; c=relaxed/simple;
	bh=BlXDkO2knYoonqX5Pq9nOLxjZkz433uCK6N+xoKuONM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZssaBe9VQWhFf8ASfUz34r/h8h2y0toXMybYveX1/BxvX0+WhMc4wR0SIiylgVYItOgyRsBABanfUnr4pq0j2z37+dByHq6e3ZCGg6zRm4LBUD9t9hpTPTFSu3buOiucZvHNzR+56/5g8Tjr3cGc8X+45ABlW/C2F2+E8Ufa0kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPFboBFA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPFboBFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BE5C4CEF7;
	Wed,  4 Mar 2026 22:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661697;
	bh=BlXDkO2knYoonqX5Pq9nOLxjZkz433uCK6N+xoKuONM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPFboBFAyF/KkxiWpPlIOUGdvGZyP/+4yFRXC18ijI43nZAdSeopExprcrvQm5O2o
	 JmcTtoRgI2QWCWTveoho6+SnS5mLTyT1uVRJFkcnWg7joXb/b3OF6oDcQyi5LImjX7
	 xYnI/L5M8kNa9pq5sdmMpvnoHNBGNpK5s3GjNJGuam38jshZTp5a3MEcrqdh9Z8276
	 mSGBkKmVZ6SlIChbFPKQLm9CbuWwVycKp+ZOlQdcqUPvqWXtl8MHPlyyYid0QyHBzK
	 8CWfgjjN8MkN5jI01KaA9Kjc6s0ekoIf6gS5IbqG6hn/1+bqRqOhAc6jY5084SbM1W
	 XMnTRNedN8Pgw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 16/34] sched_ext: Move aborting flag to per-scheduler field
Date: Wed,  4 Mar 2026 12:01:01 -1000
Message-ID: <20260304220119.4095551-17-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The abort state was tracked in the global scx_aborting flag which was used to
break out of potential live-lock scenarios when an error occurs. With
hierarchical scheduling, each scheduler instance must track its own abort
state independently so that an aborting scheduler doesn't interfere with
others.

Move the aborting flag into struct scx_sched and update all access sites. The
early initialization check in scx_root_enable() that warned about residual
aborting state is no longer needed as each scheduler instance now starts with
a clean state.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 10 +++-------
 kernel/sched/ext_internal.h |  1 +
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index efbc6507cd1f..958bec1c4b82 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -44,7 +44,6 @@ static atomic_t scx_enable_state_var = ATOMIC_INIT(SCX_DISABLED);
 static int scx_bypass_depth;
 static cpumask_var_t scx_bypass_lb_donee_cpumask;
 static cpumask_var_t scx_bypass_lb_resched_cpumask;
-static bool scx_aborting;
 static bool scx_init_task_enabled;
 static bool scx_switching_all;
 DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
@@ -2151,7 +2150,7 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 		 * the system into the bypass mode. This can easily live-lock the
 		 * machine. If aborting, exit from all non-bypass DSQs.
 		 */
-		if (unlikely(READ_ONCE(scx_aborting)) && dsq->id != SCX_DSQ_BYPASS)
+		if (unlikely(READ_ONCE(sch->aborting)) && dsq->id != SCX_DSQ_BYPASS)
 			break;
 
 		if (rq == task_rq) {
@@ -4677,7 +4676,6 @@ static void scx_root_disable(struct scx_sched *sch)
 
 	/* guarantee forward progress and wait for descendants to be disabled */
 	scx_bypass(true);
-	WRITE_ONCE(scx_aborting, false);
 	drain_descendants(sch);
 
 	switch (scx_set_enable_state(SCX_DISABLING)) {
@@ -4838,7 +4836,7 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 	 * flag to break potential live-lock scenarios, ensuring we can
 	 * successfully reach scx_bypass().
 	 */
-	WRITE_ONCE(scx_aborting, true);
+	WRITE_ONCE(sch->aborting, true);
 
 	/*
 	 * Propagate exits to descendants immediately. Each has a dedicated
@@ -5485,8 +5483,6 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	 */
 	WARN_ON_ONCE(scx_set_enable_state(SCX_ENABLING) != SCX_DISABLED);
 	WARN_ON_ONCE(scx_root);
-	if (WARN_ON_ONCE(READ_ONCE(scx_aborting)))
-		WRITE_ONCE(scx_aborting, false);
 
 	atomic_long_set(&scx_nr_rejected, 0);
 
@@ -6758,7 +6754,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	 * If the BPF scheduler keeps calling this function repeatedly, it can
 	 * cause similar live-lock conditions as consume_dispatch_q().
 	 */
-	if (unlikely(READ_ONCE(scx_aborting)))
+	if (unlikely(READ_ONCE(sch->aborting)))
 		return false;
 
 	if (unlikely(!scx_task_on_sched(sch, p))) {
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 842d7b4e5334..279d7f338c83 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -951,6 +951,7 @@ struct scx_sched {
 	struct scx_sched_pcpu __percpu *pcpu;
 
 	u64			slice_dfl;
+	bool			aborting;
 	s32			level;
 
 	/*
-- 
2.53.0

