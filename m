Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FA447806;
	Fri, 24 Jul 2026 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917292; cv=none; b=ggxfor6Be4xlVzMg78KhudTRTTOawytORhp4Upgx88uG3fG4aoA3Fk82EtWpjPT6G4fYBP/9NNv5GbEMpUWvBjOkVnABJmDIPYoTWWVTKKoxE0qz5/F7O7rvpm/CHDhflhpQZ9732ovBMZSU6MVA7fR9rb5GK+X+KxHwZPjidiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917292; c=relaxed/simple;
	bh=zihPQNXjU5WQj1HQ8gvH3OYLod0APvRHGnK3CGYnmmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QO9sKKBDH3AL/Eb2OwU/8MEy8SZdGqwOKLE8Vwp6dltIKCmYY2Pg7nUudb7XvqiIGtAMtLma8g576sjsq/TWZW7lg8pAs3JoNmDkKHTq0FeRqcFeDN9jle7RJvBqLixV6jB1XIBzTfEGo01o5vgSjhtumABABW+lQcTrENUHcj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bggwHlSH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bggwHlSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662F91F00A3A;
	Fri, 24 Jul 2026 18:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784917290;
	bh=1+GSlYt/0wWFFDV0v8fpVxl7aFkHOPUWDuvfTa1gE2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bggwHlSHzaSIrdZmA2IHjJsFW+ctNIpuovwNjWXxrotQvLI1FOsnrS7ZYey2Eimlk
	 9Vj2eJ+IdFp5DEwZJE+KAzkuJ2JXGxzgnReblqF3xHJHgVFO/MnmW9dSaSkekeahHS
	 JMZsmlpc26aw7XV9r/TYVbKHVuq3cuvtXkxE9ExUoDM4rhK5RHwxtCMKAcJUILSwZA
	 LAKngQIPlkZbmdcucDaUzYxRN38a3mPm7/zI6WR93rKtF1vP4GoOekMC5LCHpwylL0
	 8ojPOKNw+B2m2NERTCkftP+r1fWgaUsuPzerHDH5d+7PgJvdNnP9B2cEnWNkdVTtMu
	 9zCJO5deEybwA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/5] sched_ext: Factor out scx_cpuperf_set()
Date: Fri, 24 Jul 2026 08:21:24 -1000
Message-ID: <20260724182125.985061-5-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724182125.985061-1-tj@kernel.org>
References: <20260724182125.985061-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor the cpuperf target write out of scx_bpf_cpuperf_set() into
scx_cpuperf_set() which takes the acting sched and returns 0 or -errno, and
flatten the nested validation into early returns. No functional change.
Prep for gating the write behind a cap and reporting the outcome from the
cid-form kfunc.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 77 ++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 5d02bb99c09d..366245daab68 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9796,49 +9796,60 @@ __bpf_kfunc u32 scx_bpf_cidperf_cur(s32 cid, const struct bpf_prog_aux *aux)
  * use. Consult hardware and cpufreq documentation for more information. The
  * current performance level can be monitored using scx_bpf_cpuperf_cur().
  */
-__bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf_prog_aux *aux)
+static s32 scx_cpuperf_set(struct scx_sched *sch, s32 cpu, u32 perf)
 {
-	struct scx_sched *sch;
-
-	guard(rcu)();
-
-	sch = scx_prog_sched(aux);
-	if (unlikely(!sch))
-		return;
+	struct rq *rq, *locked_rq;
+	struct rq_flags rf;
 
 	if (unlikely(perf > SCX_CPUPERF_ONE)) {
 		scx_error(sch, "Invalid cpuperf target %u for CPU %d", perf, cpu);
-		return;
+		return -EINVAL;
 	}
 
-	if (scx_cpu_valid(sch, cpu, NULL)) {
-		struct rq *rq = cpu_rq(cpu), *locked_rq = scx_locked_rq();
-		struct rq_flags rf;
-
-		/*
-		 * When called with an rq lock held, restrict the operation
-		 * to the corresponding CPU to prevent ABBA deadlocks.
-		 */
-		if (locked_rq && rq != locked_rq) {
-			scx_error(sch, "Invalid target CPU %d", cpu);
-			return;
-		}
+	if (!scx_cpu_valid(sch, cpu, NULL))
+		return -EINVAL;
 
-		/*
-		 * If no rq lock is held, allow to operate on any CPU by
-		 * acquiring the corresponding rq lock.
-		 */
-		if (!locked_rq) {
-			rq_lock_irqsave(rq, &rf);
-			update_rq_clock(rq);
-		}
+	rq = cpu_rq(cpu);
+	locked_rq = scx_locked_rq();
 
-		rq->scx.cpuperf_target = perf;
-		cpufreq_update_util(rq, 0);
+	/*
+	 * When called with an rq lock held, restrict the operation to the
+	 * corresponding CPU to prevent ABBA deadlocks.
+	 */
+	if (locked_rq && rq != locked_rq) {
+		scx_error(sch, "Invalid target CPU %d", cpu);
+		return -EINVAL;
+	}
 
-		if (!locked_rq)
-			rq_unlock_irqrestore(rq, &rf);
+	/*
+	 * If no rq lock is held, allow to operate on any CPU by acquiring
+	 * the corresponding rq lock.
+	 */
+	if (!locked_rq) {
+		rq_lock_irqsave(rq, &rf);
+		update_rq_clock(rq);
 	}
+
+	rq->scx.cpuperf_target = perf;
+	cpufreq_update_util(rq, 0);
+
+	if (!locked_rq)
+		rq_unlock_irqrestore(rq, &rf);
+
+	return 0;
+}
+
+__bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf_prog_aux *aux)
+{
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		return;
+
+	scx_cpuperf_set(sch, cpu, perf);
 }
 
 /**
-- 
2.55.0

