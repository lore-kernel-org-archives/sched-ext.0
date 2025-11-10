Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC462F6567;
	Mon, 10 Nov 2025 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808201; cv=none; b=U5PgsTVe6nTlxmfUOpepHKir2nyLT/G/EY3kSM8sv5z2ulsknUMpG/a6q6A03ABYoWAr2uK+uJGXLMpR0kuyYnZTa2AHA1a7o5nnAEa3XbHDTv7on2cAj0tXZSM1tFTmvBEYYzCXNpxPDEWSYksCCx3cNWPOEaGZK4t01CZ3vmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808201; c=relaxed/simple;
	bh=Bk0xj60IMhRSM8OyLfyP4EW/0X3PqhAu5P4TEbFYUr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUQDQUnUiWseT034hF5g5pfdzjOMhPpEjH7b3K1c2Brp28r7V+aeblHVUF/cFxGUZMtxrIVCHzjULjnUAMbitiFJf1Vp9yoSkdPa0+M7Kl9TsfJWkDHDvv4bftO4tGUhd7/N61Iglr/m0/VO28WOOhz6D3YpEiWUrHTn/RQcXCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR/XDOwT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR/XDOwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656E7C113D0;
	Mon, 10 Nov 2025 20:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762808200;
	bh=Bk0xj60IMhRSM8OyLfyP4EW/0X3PqhAu5P4TEbFYUr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SR/XDOwTthCIiZDPtjuaIWd8mwBATKedKznIztKWi1wv31eeBYm94aEvMnu7GGXUT
	 CaXL2GEg5Xq6c39bsdmhTem2iANVtoN3Qa0p11g7p9dacrsE66RKejckCSJ43Orcej
	 /QA7as5zOWp5mtcWCdh3oMBVz9VQasIeZKnnHMKZxYaX8MdYfmVu4W/EFyGjqQF2iY
	 rXrw4v8whTcbHjDdSfSGj8v2+w4zAIUA729hbb2EPcLOzyPM7cfobXlaxmRcN+sU9M
	 FjkfaMGdq1a3Q6Kuo++c1freXb1RCCeMpd5FBf8GGmyTHE7NhbMXdBH3b+DyjwJybN
	 lEE/vqLKmNfjQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH v2 03/14] sched_ext: Refactor do_enqueue_task() local and global DSQ paths
Date: Mon, 10 Nov 2025 10:56:25 -1000
Message-ID: <20251110205636.405592-4-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110205636.405592-1-tj@kernel.org>
References: <20251110205636.405592-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local and global DSQ enqueue paths in do_enqueue_task() share the same
slice refill logic. Factor out the common code into a shared enqueue label.
This makes adding new enqueue cases easier. No functional changes.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index abf2075f174f..b18864655d3a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1279,6 +1279,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 {
 	struct scx_sched *sch = scx_root;
 	struct task_struct **ddsp_taskp;
+	struct scx_dispatch_q *dsq;
 	unsigned long qseq;
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
@@ -1346,8 +1347,17 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 direct:
 	direct_dispatch(sch, p, enq_flags);
 	return;
-
+local_norefill:
+	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
+	return;
 local:
+	dsq = &rq->scx.local_dsq;
+	goto enqueue;
+global:
+	dsq = find_global_dsq(sch, p);
+	goto enqueue;
+
+enqueue:
 	/*
 	 * For task-ordering, slice refill must be treated as implying the end
 	 * of the current slice. Otherwise, the longer @p stays on the CPU, the
@@ -1355,14 +1365,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	touch_core_sched(rq, p);
 	refill_task_slice_dfl(sch, p);
-local_norefill:
-	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
-	return;
-
-global:
-	touch_core_sched(rq, p);	/* see the comment in local: */
-	refill_task_slice_dfl(sch, p);
-	dispatch_enqueue(sch, find_global_dsq(sch, p), p, enq_flags);
+	dispatch_enqueue(sch, dsq, p, enq_flags);
 }
 
 static bool task_runnable(const struct task_struct *p)
-- 
2.51.2

