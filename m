Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0841746AECF;
	Wed, 21 Jan 2026 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037128; cv=none; b=Y9ZKUdMwbNUcPruvUZWtUWdgMmfr2/CJsvVBRAgX4VHVWzBBsSWIu0vtxW9czu9OpL1XfrasEx4wggZ6ck6PaqBhVe3RUjzCRTSzhwHPPKvQAuT6SCKUT2sFE+26eTZXiNyq/eu53AfAoNsIsom2qXqjH/J7WUsQEwGsoXZzrCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037128; c=relaxed/simple;
	bh=LYp2O3PiuS8vfyun93zR8+tF9sa9U7okX67FHFuIgZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXj8yDTia1JU0ZQgV2Bv+Mns/z6vldJyKdS/yjBjSpGtkUdfQkG3PzgPevz2x+tvBrT9NIdTsVSW1frDyocBP1Ax1sMF7cTVdfrlN6qiogaxZ1QEYeLdXES1hecRiuouQ53sAXbDLM+L7x8uGLtvGKmLJdDMCaLvcynp2lsQuuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvVifWhQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvVifWhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDF8C4AF09;
	Wed, 21 Jan 2026 23:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037126;
	bh=LYp2O3PiuS8vfyun93zR8+tF9sa9U7okX67FHFuIgZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IvVifWhQyt9wYrN3UImy0jcvvAmA5b9SRjVYDDF8HFdIZ2QC0TyE7EBQJU+ZbHGLC
	 1Il+Zelz8O7YOaBuTMkHUu3q4FRIi7AkKIQ0JAT8Wvye+RGvDDPXJx2TFeKtCFNnCy
	 yORz1aGN64wyzHC1zs2KgxrDN/w4WfOC5kDaTsDAWFyvZ8F/Fv+XarqZFNg0kVitVU
	 lwTR5esbl8AZ4qV9VKsZJMhLtngR8ROipwpBvDdwM+Msr3KB5lQmyCw6Ef65vThZYT
	 lXMC1Uo3and4JlcrT61SV2Xo0wFt21nrowHjzrfLu6VobT5VBsZyLVtiA3xHJObGVv
	 dIH98PoC6BmYw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 24/34] sched_ext: Dispatch from all scx_sched instances
Date: Wed, 21 Jan 2026 13:11:30 -1000
Message-ID: <20260121231140.832332-25-tj@kernel.org>
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

The cgroup sub-sched support involves invasive changes to many areas of
sched_ext. The overall scaffolding is now in place and the next step is
implementing sub-sched enable/disable.

To enable partial testing and verification, update balance_one() to
dispatch from all scx_sched instances until it finds a task to run. This
should keep scheduling working when sub-scheds are enabled with tasks on
them. This will be replaced by BPF-driven hierarchical operation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6087083e8b70..69158c01f308 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2430,7 +2430,7 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 
 static int balance_one(struct rq *rq, struct task_struct *prev)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_root, *pos;
 	s32 cpu = cpu_of(rq);
 
 	lockdep_assert_rq_held(rq);
@@ -2474,9 +2474,13 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	if (rq->scx.local_dsq.nr)
 		goto has_tasks;
 
-	/* dispatch @sch */
-	if (scx_dispatch_sched(sch, rq, prev))
-		goto has_tasks;
+	/*
+	 * TEMPORARY - Dispatch all scheds. This will be replaced by BPF-driven
+	 * hierarchical operation.
+	 */
+	list_for_each_entry_rcu(pos, &scx_sched_all, all)
+		if (scx_dispatch_sched(pos, rq, prev))
+			goto has_tasks;
 
 	/*
 	 * Didn't find another task to run. Keep running @prev unless
-- 
2.52.0

