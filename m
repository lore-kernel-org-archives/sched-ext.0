Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16534311975;
	Mon, 22 Sep 2025 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557683; cv=none; b=Jn7mcQsUf1zb2aRqPh2n6zRboyyLP10oUFuLesMIxbHSU358suYy95XU4S/0mYg7IA0xSkmZN1LvgIcIiFOxUNOX6BMqK0YNmLC/GyeoHaiZaDLU2bGTINlplK5XQwYL2wqDysk+qFiCu4VIyy0gfnsptJDBNIZ9wB8S45dY28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557683; c=relaxed/simple;
	bh=IWegEyR1c1/atVD9N7JvMZdR4sBXsOyYkuHm6qOODWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaKZZt9wTLe0LNCJ501prquXcANHdW+4h0YuEhvwVryTywpclHIz0erQZT91bqI+AxxIjIX0YJtBXY6kMIxlpk4lrhRjgUH0Rfwyb+ISJEEFtCB5J7B444LhBOMf3RV+h4j5UC2s0mVEjgmeoVL/8WR5mXwCR5DARHazKYbigbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPHZpJe2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPHZpJe2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845B0C4CEF0;
	Mon, 22 Sep 2025 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758557682;
	bh=IWegEyR1c1/atVD9N7JvMZdR4sBXsOyYkuHm6qOODWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPHZpJe2Rc7/c3MlJACWsDsCjqfqm2uc1+NSAadB0tHtSTdcBnAj5EUpMlWWcFllZ
	 hXpjCDZGS2y8Fp2xNnExlSk5yksdEVGWtLTs4q+9Qmgg4cvdJz68cR4NpRtZ3DHxsZ
	 e/6xieJQipJhzkQbUdA/OHnAx1U55O4uQwC9w8itCxsZmrLJRlb7ajNGLCdfiEhrU+
	 YixBLHxgPEUvypMv6u9VlniH3JHTfrilPvDDP/dGpzeEy95IeS67CI6Ye+VOTqWkFy
	 e/abT75ZG23S0aMJrvABTikquZSu8xXtvT3n7MdlZHuWIA7B1sAWjYa3UiN8cHcTuY
	 EJq2nTztIuinA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/7] sched_ext: Add the @sch parameter to scx_dsq_insert_preamble/commit()
Date: Mon, 22 Sep 2025 06:14:34 -1000
Message-ID: <20250922161436.358949-6-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922161436.358949-1-tj@kernel.org>
References: <20250922161436.358949-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for multiple scheduler support, add the @sch parameter to
scx_dsq_insert_preamble/commit() and update the callers to read $scx_root
and pass it in. The passed in @sch parameter is not used yet.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 56ca09f46d1e..1455f8c56d5c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5240,7 +5240,8 @@ void __init init_sched_ext_class(void)
 /********************************************************************************
  * Helpers that can be called from the BPF scheduler.
  */
-static bool scx_dsq_insert_preamble(struct task_struct *p, u64 enq_flags)
+static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p,
+				    u64 enq_flags)
 {
 	if (!scx_kf_allowed(SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
 		return false;
@@ -5260,8 +5261,8 @@ static bool scx_dsq_insert_preamble(struct task_struct *p, u64 enq_flags)
 	return true;
 }
 
-static void scx_dsq_insert_commit(struct task_struct *p, u64 dsq_id,
-				  u64 enq_flags)
+static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
+				  u64 dsq_id, u64 enq_flags)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct task_struct *ddsp_task;
@@ -5325,7 +5326,14 @@ __bpf_kfunc_start_defs();
 __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice,
 				    u64 enq_flags)
 {
-	if (!scx_dsq_insert_preamble(p, enq_flags))
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return;
+
+	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
 		return;
 
 	if (slice)
@@ -5333,7 +5341,7 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice
 	else
 		p->scx.slice = p->scx.slice ?: 1;
 
-	scx_dsq_insert_commit(p, dsq_id, enq_flags);
+	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags);
 }
 
 /**
@@ -5360,7 +5368,14 @@ __bpf_kfunc void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice
 __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 					  u64 slice, u64 vtime, u64 enq_flags)
 {
-	if (!scx_dsq_insert_preamble(p, enq_flags))
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return;
+
+	if (!scx_dsq_insert_preamble(sch, p, enq_flags))
 		return;
 
 	if (slice)
@@ -5370,7 +5385,7 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 
 	p->scx.dsq_vtime = vtime;
 
-	scx_dsq_insert_commit(p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
+	scx_dsq_insert_commit(sch, p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
 }
 
 __bpf_kfunc_end_defs();
-- 
2.51.0

