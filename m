Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8285C4A;
	Sat, 25 Oct 2025 00:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761351531; cv=none; b=le+y76A6H5QBIAj0AYQUtFLJbUXUc98zaMGOvVjO+1Yt0ZWFsYSvrYRARcG4nzwiuc//eGq5g8rOtAd6cNufpIChAZ87+/+SS9/JdeRprmAwwp/c6MEYVRFu144dJzwNV4XtsSxkCxpcfNQHkR1DpTcvLwIVE7Mh5D7eH8vSld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761351531; c=relaxed/simple;
	bh=YtJDfd/uiTkSqr4ZXvLx5t+UOaEJXwP2qMsy/ZRYyaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEE5hkD8M6QdJz4AznoQy1L3hAarQ3d8Idy32jLNBPd1hidrnnuSYRwkQ6ELf2Y2/0Hw9zAbdtx/5JtIFjilughxyaaWaduBMpSQnoT2daitKaWGElPsGgHmzO9PbnfuXmixyG2CAQ1C6zj4YYlH3v25RSmL1mb20XYzB34B0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFKgs5tk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFKgs5tk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C26AC4CEF1;
	Sat, 25 Oct 2025 00:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761351531;
	bh=YtJDfd/uiTkSqr4ZXvLx5t+UOaEJXwP2qMsy/ZRYyaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFKgs5tk8mq5R4J855qRTaRqh/jjK6Nn8O0boSX+1QqxjpxTZZPjho+GNMco6rEHM
	 HBKH2f17n+nMiYCY+BguHY0SguLz+cWvzYdzLNB42BohpM//X3aX8VyytGz1gloS97
	 W46BkqLIeLmbj2GpGpd+zr9jt8kA8jq8+S+L1RxHY53QspnIuubMUrI5DCN3Jz8fn+
	 Cs4OgPCd9C0qZgYhlnBADKAQn6qt3il/iYVkc7jKT7yFhHksufWOxQ09/BcszbTPE6
	 htn7OWHpOF/RMKSZMhF2VV8SqSAP/2qTsBOsgbHH+AJGhTPTrnuXxqQvaur+SijWxm
	 DooaGV58TvqNg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Wen-Fang Liu <liuwenfang@honor.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/3] sched_ext: Split schedule_deferred() into locked and unlocked variants
Date: Fri, 24 Oct 2025 14:18:47 -1000
Message-ID: <20251025001849.1915635-2-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251025001849.1915635-1-tj@kernel.org>
References: <20251025001849.1915635-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

schedule_deferred() currently requires the rq lock to be held so that it can
use scheduler hooks for efficiency when available. However, there are cases
where deferred actions need to be scheduled from contexts that don't hold the
rq lock.

Split into schedule_deferred() which can be called from any context and just
queues irq_work, and schedule_deferred_locked() which requires the rq lock and
can optimize by using scheduler hooks when available. Update the existing call
site to use the _locked variant.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 000000000000..111111111111 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -775,12 +775,28 @@ static void deferred_irq_workfn(struct irq_work *irq_work)
  * schedule_deferred - Schedule execution of deferred actions on an rq
  * @rq: target rq
  *
- * Schedule execution of deferred actions on @rq. Must be called with @rq
- * locked. Deferred actions are executed with @rq locked but unpinned, and thus
- * can unlock @rq to e.g. migrate tasks to other rqs.
+ * Schedule execution of deferred actions on @rq. Deferred actions are executed
+ * with @rq locked but unpinned, and thus can unlock @rq to e.g. migrate tasks
+ * to other rqs.
  */
 static void schedule_deferred(struct rq *rq)
 {
+	/*
+	 * Queue an irq work. They are executed on IRQ re-enable which may take
+	 * a bit longer than the scheduler hook in schedule_deferred_locked().
+	 */
+	irq_work_queue(&rq->scx.deferred_irq_work);
+}
+
+/**
+ * schedule_deferred_locked - Schedule execution of deferred actions on an rq
+ * @rq: target rq
+ *
+ * Schedule execution of deferred actions on @rq. Equivalent to
+ * schedule_deferred() but requires @rq to be locked and can be more efficient.
+ */
+static void schedule_deferred_locked(struct rq *rq)
+{
 	lockdep_assert_rq_held(rq);

 	/*
@@ -812,12 +828,11 @@ static void schedule_deferred(struct rq *rq)
 	}

 	/*
-	 * No scheduler hooks available. Queue an irq work. They are executed on
-	 * IRQ re-enable which may take a bit longer than the scheduler hooks.
-	 * The above WAKEUP and BALANCE paths should cover most of the cases and
-	 * the time to IRQ re-enable shouldn't be long.
+	 * No scheduler hooks available. Use the generic irq_work path. The
+	 * above WAKEUP and BALANCE paths should cover most of the cases and the
+	 * time to IRQ re-enable shouldn't be long.
 	 */
-	irq_work_queue(&rq->scx.deferred_irq_work);
+	schedule_deferred(rq);
 }

 /**
@@ -1211,7 +1226,7 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 		WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
 		list_add_tail(&p->scx.dsq_list.node,
 			      &rq->scx.ddsp_deferred_locals);
-		schedule_deferred(rq);
+		schedule_deferred_locked(rq);
 		return;
 	}

--
2.47.1
