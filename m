Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C57537EFF1;
	Fri, 24 Jul 2026 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920621; cv=none; b=fdUDulalvM57yYtU5S5EWZNiFMOCEVFk3KdaLwTvIWw7lXWMfnuyswqAjwCILPIJf8DkTf4i/giClIx8SgCYacYsec9l9SjL59Zhfhg02oG9XcU4dAiYnV0z+qptmTtfpImCI25u8BNs1zdWtoUBmdL/91vCgMG82FcHaNBt+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920621; c=relaxed/simple;
	bh=q8e1KDdsBvZRzie86EmVYBAq7+Tj0/pg4hsxh+9wfWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jc3+FJy5EUOivD9N94F9gBUvUiTU2hB24T/cdL2KEYI/47iaUJQstmmxkcZaWhVTVRRA3O+ciTt16dy8riUmhMegAg5YUbtT+vnsTI9hYl6NGlrRpL/JaSHZK1T4jYn1ar2RecvNTxG38PaLyQt55iNhXzs6cQmBRzi7C7P4350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXeHGFRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXeHGFRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4071F00A3D;
	Fri, 24 Jul 2026 19:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784920616;
	bh=l1uItTK+O0ni6niyLU7EiQYbjD+dDhyd6D42U80TnGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SXeHGFRvpwRaJHGRD/LzOOHVmCG68q4J41YNYOoZao0uVbF8tWPTL++jXUdK3bjbN
	 t2DMawWXY4IMVTbtfL6yRDH9bnKte4QpYRsJx8lxDQ11QdYmvuPud8/2Cf2XmzFiNF
	 sVXrB3WOpVx/kCpZhn0tvi3l3BzsezZMg6UVBitk77Y0AOYC9kaIN3cZqeFpoaXIPM
	 aaapWzUQSCOFdruieJIgYvY/koJzYHKHN/b2Xqaa/bs60cStvm+5n5IaL2koOTY+Be
	 75HQXBZQeMe/ow6qiOwLnf3FngyljtpWa2ZvwHl4QOUQg6BbSlLi3yzUlUjdOqiJ4h
	 eih0g5J7720/Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/5] sched_ext: Factor out scx_cpuperf_set()
Date: Fri, 24 Jul 2026 09:16:50 -1000
Message-ID: <20260724191651.1040227-5-tj@kernel.org>
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

Factor the cpuperf target write out of scx_bpf_cpuperf_set() into
scx_cpuperf_set() which takes the acting sched and returns 0 or -errno, and
flatten the nested validation into early returns. No functional change.
Prep for gating the write behind a cap and reporting the outcome from the
cid-form kfunc.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 78 ++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 5d02bb99c09d..e11c66bd23e7 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9781,6 +9781,50 @@ __bpf_kfunc u32 scx_bpf_cidperf_cur(s32 cid, const struct bpf_prog_aux *aux)
 	return arch_scale_freq_capacity(cpu);
 }
 
+/* validate and apply a cpuperf target, see scx_bpf_cpuperf_set() */
+static s32 scx_cpuperf_set(struct scx_sched *sch, s32 cpu, u32 perf)
+{
+	struct rq *rq, *locked_rq;
+	struct rq_flags rf;
+
+	if (unlikely(perf > SCX_CPUPERF_ONE)) {
+		scx_error(sch, "Invalid cpuperf target %u for CPU %d", perf, cpu);
+		return -EINVAL;
+	}
+
+	if (!scx_cpu_valid(sch, cpu, NULL))
+		return -EINVAL;
+
+	rq = cpu_rq(cpu);
+	locked_rq = scx_locked_rq();
+
+	/*
+	 * When called with an rq lock held, restrict the operation to the
+	 * corresponding CPU to prevent ABBA deadlocks.
+	 */
+	if (locked_rq && rq != locked_rq) {
+		scx_error(sch, "Invalid target CPU %d", cpu);
+		return -EINVAL;
+	}
+
+	/*
+	 * If no rq lock is held, allow to operate on any CPU by acquiring
+	 * the corresponding rq lock.
+	 */
+	if (!locked_rq) {
+		rq_lock_irqsave(rq, &rf);
+		update_rq_clock(rq);
+	}
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
 /**
  * scx_bpf_cpuperf_set - Set the relative performance target of a CPU
  * @cpu: CPU of interest
@@ -9806,39 +9850,7 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf, const struct bpf_prog_au
 	if (unlikely(!sch))
 		return;
 
-	if (unlikely(perf > SCX_CPUPERF_ONE)) {
-		scx_error(sch, "Invalid cpuperf target %u for CPU %d", perf, cpu);
-		return;
-	}
-
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
-
-		/*
-		 * If no rq lock is held, allow to operate on any CPU by
-		 * acquiring the corresponding rq lock.
-		 */
-		if (!locked_rq) {
-			rq_lock_irqsave(rq, &rf);
-			update_rq_clock(rq);
-		}
-
-		rq->scx.cpuperf_target = perf;
-		cpufreq_update_util(rq, 0);
-
-		if (!locked_rq)
-			rq_unlock_irqrestore(rq, &rf);
-	}
+	scx_cpuperf_set(sch, cpu, perf);
 }
 
 /**
-- 
2.55.0

