Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B9D28AAF9;
	Thu,  9 Oct 2025 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054185; cv=none; b=jAqcB3oJ/k+k/rodf1CjqIfqxtCzKPLRY2UxSBQNWibb9+VS9JoFnbStwdUJMWSKp/TWc8RDGb0N/S8Fbg6bKZxQO5/ctCDY3UJYwQRWEaqrD43BIEOoMvKab3JTf7LJJwznVoxR9QQ+xgjQ/sbSSeBT3gdAPwR1IXwMkDCsG08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054185; c=relaxed/simple;
	bh=fpoEBaXfc7p9qNaa/8UsDw15nv+ev3tq7W/P+MBiaAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C2ENyLuoHO6YtjOHLkk1lasJgLRoORwnLQ8WiSQPqYn3K5/FTUKPeEtRgDA6zqBqdpNipQ3es6vtT5M8eXopsQrsBHw0d0YlCloZ/kOePfi8d9qMiPqUiHb3dGxz3IFEFtKtT2pCrgWiiKjqRg5q0Y5M9fifZ8F7vlnXjQ/YhVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXI8IJnL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXI8IJnL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1490C4CEE7;
	Thu,  9 Oct 2025 23:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760054184;
	bh=fpoEBaXfc7p9qNaa/8UsDw15nv+ev3tq7W/P+MBiaAA=;
	h=From:To:Cc:Subject:Date:From;
	b=FXI8IJnLfTNwyYwLL0djeYmCvJ5jC9LahQOu2aBcilpuD0E5ZfFlzePv2u5tKIYsB
	 m0/9rI84lsGDHySJ8NaCguHo0M3K1yuDHeK978Sskb+VV2kqi9gbqMnHEbV2EG6TCQ
	 f+j6Dos05VKNHnv4gxG+O6iN9pe8qLOv8t7HW1dZtNRAxiKpvI/t+qozpRx+rlBmvu
	 mQDk+Ti4PYGKLOIKt5AJBmUD+I79eSQtLrVJMu1tlxh/yw4VJZeQ4xNK/GwZrlFUtT
	 XMDVappU87cPoKEUsOO1X4DpYu4roh8nCVvkksZ0rUR8v8rCUCRKANbZYr3O2Z4zAv
	 PafNxcj2QXxVg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-6.18-fixes] sched_ext: Sync error_irq_work before freeing scx_sched
Date: Thu,  9 Oct 2025 13:56:23 -1000
Message-ID: <20251009235623.4135746-1-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By the time scx_sched_free_rcu_work() runs, the scx_sched is no longer
reachable. However, a previously queued error_irq_work may still be pending or
running. Ensure it completes before proceeding with teardown.

Fixes: bff3b5aec1b7 ("sched_ext: Move disable machinery into scx_sched")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index XXXXXXXX..XXXXXXXX 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3471,7 +3471,9 @@ static void scx_sched_free_rcu_work(struct rcu_work *rwork)
 	struct scx_dispatch_q *dsq;
 	int node;

+	irq_work_sync(&sch->error_irq_work);
 	kthread_stop(sch->helper->task);
+
 	free_percpu(sch->pcpu);

 	for_each_node_state(node, N_POSSIBLE)
--
2.48.0
