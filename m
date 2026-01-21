Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39098450911;
	Wed, 21 Jan 2026 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037120; cv=none; b=uikr5GJAv3DtcDmMu46/DaacvVvVY7wYEoAlPt9DOoBM7iYwUKcQ0wb+NDcK023XDwwZf1TNO9Fp1gsY9kSl+lsz7D68ONySNHroax8RsFwNfd81ZquQnSxVpSQGiu6sLFkZHzUAbwRv6F32L52HRLb38B5NIeH1N3LcrMgkpAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037120; c=relaxed/simple;
	bh=ES3hHa5nVhX+Su2Wstg2vSfxtRXI1jvjhbMj7VNzMpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PX9Dd8NdjH75f+wTTw2eB9sRnimSL7f2+bssbiPv4bUSdw7QAgimbtzAXWGzYOsJHXBLoKl2NSowT4sZXsFw0MNsbjh5Db9xeVVKM6xmeaLbnxak6Z+oawJvyVGQjWp+uu4LB1PoNg6EdlYixZVTeqgO7IRB7Nf88fyf1xeIaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m992tKFx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m992tKFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DD8C19425;
	Wed, 21 Jan 2026 23:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037118;
	bh=ES3hHa5nVhX+Su2Wstg2vSfxtRXI1jvjhbMj7VNzMpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m992tKFxXAvAPcEeuI1Z8Ng1uRhBpcokSvRM9i0rcJjAGkKf/TRmlfor+11Ygo1zm
	 NJ7/qNDUzeGN9GozkkC3X2e+CsX02w2F5AITg75Get+j9y0leCWZfBEAuF5azBr0lM
	 XhfeB61VQX+5fgFR7iGjamMRHxdPB+tWqXdR5jRAEFfQ3/teY32Wr+oCI4/7VfJArL
	 ay7SfZFigz9cUpuLUzCkPuCSKYgbKxFpELz4By267xbDkyav/JO2lf9aGa3O7iinHg
	 fziVQdCICUH6hHSHaSevIcYJQmU8cUxtK8jw3prbJnh8o0nExq+1dN8nd9tKBPjySV
	 tL1SN7MUysWGw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 16/34] sched_ext: Move aborting flag to per-scheduler field
Date: Wed, 21 Jan 2026 13:11:22 -1000
Message-ID: <20260121231140.832332-17-tj@kernel.org>
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
index aad534a8f704..e71fce857c6b 100644
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
@@ -2057,7 +2056,7 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 		 * the system into the bypass mode. This can easily live-lock the
 		 * machine. If aborting, exit from all non-bypass DSQs.
 		 */
-		if (unlikely(READ_ONCE(scx_aborting)) && dsq->id != SCX_DSQ_BYPASS)
+		if (unlikely(READ_ONCE(sch->aborting)) && dsq->id != SCX_DSQ_BYPASS)
 			break;
 
 		if (rq == task_rq) {
@@ -4480,7 +4479,6 @@ static void scx_root_disable(struct scx_sched *sch)
 
 	/* guarantee forward progress and wait for descendants to be disabled */
 	scx_bypass(true);
-	WRITE_ONCE(scx_aborting, false);
 	drain_descendants(sch);
 
 	switch (scx_set_enable_state(SCX_DISABLING)) {
@@ -4632,7 +4630,7 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 	 * flag to break potential live-lock scenarios, ensuring we can
 	 * successfully reach scx_bypass().
 	 */
-	WRITE_ONCE(scx_aborting, true);
+	WRITE_ONCE(sch->aborting, true);
 
 	/*
 	 * Propagate exits to descendants immediately. Each has a dedicated
@@ -5268,8 +5266,6 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	WARN_ON_ONCE(scx_set_enable_state(SCX_ENABLING) != SCX_DISABLED);
 	WARN_ON_ONCE(scx_root);
-	if (WARN_ON_ONCE(READ_ONCE(scx_aborting)))
-		WRITE_ONCE(scx_aborting, false);
 
 	atomic_long_set(&scx_nr_rejected, 0);
 
@@ -6502,7 +6498,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	 * If the BPF scheduler keeps calling this function repeatedly, it can
 	 * cause similar live-lock conditions as consume_dispatch_q().
 	 */
-	if (unlikely(READ_ONCE(scx_aborting)))
+	if (unlikely(READ_ONCE(sch->aborting)))
 		return false;
 
 	if (unlikely(!scx_task_on_sched(sch, p))) {
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 8836bad027ea..16c1f0eb6c69 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -951,6 +951,7 @@ struct scx_sched {
 	struct scx_sched_pcpu __percpu *pcpu;
 
 	u64			slice_dfl;
+	bool			aborting;
 	s32			level;
 
 	/*
-- 
2.52.0

