Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336434FF45;
	Fri, 24 Jul 2026 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920617; cv=none; b=FG9aV8byFiaEX4B/uHXbdPWwYIm6Xv1qRt/Nj+ml/MEor9vw7GasQOx3GDmd/m2h97OWu8Bl2XhILI7t81ekWbJOFLoSo78QKpgFFCQ5RA3fw5ZsxUP/ESyz/8LXIxTfPhHoei3S5LwmVdZRjIsoJ/xNHPsKUvS+d/aNwvLDiCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920617; c=relaxed/simple;
	bh=IsQiZOx5g3d7sUGPARj9PNgRb2ELI+dOUh7LtyeZeoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHB9DXk0XSTiFPrpZpefkikJ7i0GGBVq6DVzs760lmzniQOiRaWnDrMw+f/kqNL+hz/4D/NiO2zmHOJgrN/4iEzJ3gR3GcOsPS5tAZs0djvI5YHWq+aC0SeZ8nyNMK/6KCdv8meOs9L0UPe7ZPq29zGGNhVFGa1qfvtUB6jL+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=El/FNDKn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="El/FNDKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840D31F00A3A;
	Fri, 24 Jul 2026 19:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784920615;
	bh=cg+SBG271+Icv77zPaEzMH8/nEUykrnFb4Vyl7dzrcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=El/FNDKnflzJZk4cXrJDDqi73dA/680hpzwqYZEGIcvRkqfLBCbKNwlwMdsHMj2Tx
	 PDZEMdrQQoaNEDczFUfd9u4aSpwFJAqhi28DH8MCTgv1q7VNmmYvpLWouZ2z1jkH/R
	 Q717kM5ST8NxLJdaO5tWFvobS4E+9pL37Ngvr8PrZ7hNiR1arGHvN6oEiwpJyJNOha
	 kUR+a53hibN1kDglB2weEO2OFSt19gPfbrYz0xQc8vOBlZZrVm4Hls43+pbFjJhc5K
	 cBihinqAhV5MKq+bVZz4FzL1ivp0sIEMeJT6mcPe6nfnHY4iSbdcNCtMHZc80l2iI2
	 6RC25UGAN2qHg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/5] sched_ext: Count kicks denied for lacking baseline cid access
Date: Fri, 24 Jul 2026 09:16:49 -1000
Message-ID: <20260724191651.1040227-4-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724191651.1040227-1-tj@kernel.org>
References: <20260724191651.1040227-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kick_one_cpu() silently skips a kick when the kicking sub-sched lacks
SCX_CAP_BASE on the target cid, as does kick_one_cpu_if_idle() for idle
kicks. The skips are sound with the same logic as the reenq gate but are
invisible today, unlike the preempt degradation counted in
SCX_EV_SUB_PREEMPT_DENIED. Count them in a new SCX_EV_SUB_KICK_DENIED event
so every cap denial is observable.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 20 ++++++++++++++------
 kernel/sched/ext/internal.h |  8 ++++++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index fd88b4d4f12a..5d02bb99c09d 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8118,6 +8118,7 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	struct scx_rq *this_scx = &this_rq->scx;
 	const struct sched_class *cur_class;
 	bool should_wait = false;
+	bool kickable;
 	unsigned long flags;
 
 	raw_spin_rq_lock_irqsave(rq, flags);
@@ -8131,9 +8132,10 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 	 * business forcing a reschedule there - skip. This is the authoritative
 	 * cap check: ecaps is read here under @rq's lock.
 	 */
-	if ((cpu_online(cpu) || cpu == cpu_of(this_rq)) &&
-	    !sched_class_above(cur_class, &ext_sched_class) &&
-	    !scx_missing_caps(pcpu->sch, cpu, SCX_CAP_BASE)) {
+	kickable = (cpu_online(cpu) || cpu == cpu_of(this_rq)) &&
+		   !sched_class_above(cur_class, &ext_sched_class);
+
+	if (kickable && !scx_missing_caps(pcpu->sch, cpu, SCX_CAP_BASE)) {
 		if (cpumask_test_cpu(cpu, pcpu->cpus_to_preempt)) {
 			if (cur_class == &ext_sched_class) {
 				if (likely(!scx_missing_caps(pcpu->sch, cpu,
@@ -8157,6 +8159,9 @@ static bool kick_one_cpu(s32 cpu, struct scx_sched_pcpu *pcpu, struct rq *this_r
 
 		resched_curr(rq);
 	} else {
+		/* a kickable cpu was skipped solely for the missing caps */
+		if (kickable)
+			__scx_add_event(pcpu->sch, SCX_EV_SUB_KICK_DENIED, 1);
 		cpumask_clear_cpu(cpu, pcpu->cpus_to_preempt);
 		cpumask_clear_cpu(cpu, pcpu->cpus_to_wait);
 	}
@@ -8176,9 +8181,12 @@ static void kick_one_cpu_if_idle(s32 cpu, struct scx_sched_pcpu *pcpu,
 
 	/* idle kicks need baseline access too, see kick_one_cpu() */
 	if (!can_skip_idle_kick(rq) &&
-	    (cpu_online(cpu) || cpu == cpu_of(this_rq)) &&
-	    !scx_missing_caps(pcpu->sch, cpu, SCX_CAP_BASE))
-		resched_curr(rq);
+	    (cpu_online(cpu) || cpu == cpu_of(this_rq))) {
+		if (likely(!scx_missing_caps(pcpu->sch, cpu, SCX_CAP_BASE)))
+			resched_curr(rq);
+		else
+			__scx_add_event(pcpu->sch, SCX_EV_SUB_KICK_DENIED, 1);
+	}
 
 	raw_spin_rq_unlock_irqrestore(rq, flags);
 }
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 1bdf34f3fc3c..308d16320818 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1194,6 +1194,13 @@ struct scx_event_stats {
 	 */
 	s64		SCX_EV_SUB_PREEMPT_DENIED;
 
+	/*
+	 * The number of times a kick was skipped because the sub-sched lacked
+	 * baseline access on the target cid. The preempt-part degradation of a
+	 * delivered kick is counted in SCX_EV_SUB_PREEMPT_DENIED instead.
+	 */
+	s64		SCX_EV_SUB_KICK_DENIED;
+
 	/*
 	 * The number of times a local DSQ reenq was dropped because the
 	 * sub-sched lacked baseline access on the target cid.
@@ -1219,6 +1226,7 @@ struct scx_event_stats {
 	SCX_EVENT(SCX_EV_SUB_BYPASS_DISPATCH);				\
 	SCX_EVENT(SCX_EV_SUB_FORCED_ADMIT);				\
 	SCX_EVENT(SCX_EV_SUB_PREEMPT_DENIED);				\
+	SCX_EVENT(SCX_EV_SUB_KICK_DENIED);				\
 	SCX_EVENT(SCX_EV_SUB_REENQ_DENIED)
 
 struct scx_sched;
-- 
2.55.0

