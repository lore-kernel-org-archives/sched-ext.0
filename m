Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E8D2D592D;
	Mon, 29 Jun 2026 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782773750; cv=none; b=e9aAf6yGoLiSLZ2i0XqX1IS60v/SPYvDw3749sc/rMzZ1v+SFm/KebI2Q5KXaoyw8LVD8W9gRGULql0yex0IMkJSClwEomfS+sjvOANm1NBqnKrVHqn4o3rm5QdiUkAGoQ+MdiOEq/K6mgrVjSEcjSg/zBZRD1B3tpftoE7VkSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782773750; c=relaxed/simple;
	bh=X4K+BK3JmZwOUcM6+n8pOkrhiU/4kdZMQfTuanek7dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBQxdEOI3GR06YMn4q92kvqcG0nRa8sDD1S/KEtoeCFzaEAuVCPfBrMZvMzNDvw0yp5MaDn9dA2pUAdCQcTcq7wKzYZTxcvfDoZDrtfpI48DbP1ly2ni9BWQDajagMZRRFVyK1JDpmwFwmkcSuMIw2+P+mSOpsHmj+A3215pLew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lk3VK9eq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lk3VK9eq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201F31F000E9;
	Mon, 29 Jun 2026 22:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782773749;
	bh=MHXs29NnLQHGBzL05rgrxnxo6/44YOaw2/NJMWbg4UE=;
	h=From:To:Cc:Subject:Date;
	b=Lk3VK9eqVAlasB8ssMaMShE9KEdB6J3um48UaisZG8X3+xAy1nA4qNWa/EKJK6T8i
	 N1HAbsTzSZ251wELa7oW9D1c7fZ4oFVKS6Zg7TtpuSAmL42WQzRUbTW5uEugMGAjN/
	 h9cM81Wo1diyB+SWR8cez5dnmAFrSJ+uZpmoRv3iCwmbyzsRQz5AyyPS2iqBj48WKe
	 Nqa9k+8VhEdWTfOb09cUY9RSQseeZk8OEbnD+ZzDzcoiImFm0fDxg2whxNM1Qj2KwD
	 +f81nqF5YuNMB1eBSwNU+PHxHWTbz8aHk+o7j/qa75rcFf+BvuulZTGP3tpeoQrVSc
	 QzZq4FRd2GyfA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Kuba Piecuch <jpiecuch@google.com>
Subject: [PATCH v3] sched_ext: Don't warn on core-sched forced idle in put_prev_task_scx()
Date: Mon, 29 Jun 2026 12:55:48 -1000
Message-ID: <20260629225548.3562257-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

put_prev_task_scx() warns when a runnable task drops to a lower sched_class
without SCX_OPS_ENQ_LAST, on the assumption that balance_one() would have
kept it running. Core scheduling breaks that: a forced-idle SMT sibling
reschedules through the core_pick fast path in pick_next_task(), which skips
pick_task_scx() and thus balance_one(), so a runnable task can drop to idle
with ENQ_LAST unset.

Gate the warning on sched_cpu_cookie_match(): a cookie mismatch means core
scheduling forced the idle, while a match (or core scheduling off) still
catches a genuine missing-ENQ_LAST drop.

v3: Gate the warning on sched_cpu_cookie_match() so it is suppressed only on
    the forced-idle CPU instead of whenever core scheduling is enabled, so a
    genuine missing-ENQ_LAST drop is still caught (Andrea Righi).
v2: Reworded the description (Kuba Piecuch).

Fixes: 7c65ae81ea86 ("sched_ext: Don't call put_prev_task_scx() before picking the next task")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 3b2e13bc924b..e75e2fd5ab7e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3090,9 +3090,14 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * sched_class, %SCX_OPS_ENQ_LAST must be set. Tell
 		 * ops.enqueue() that @p is the only one available for this cpu,
 		 * which should trigger an explicit follow-up scheduling event.
+		 *
+		 * Core scheduling can force this CPU idle while @p stays
+		 * runnable. @p's cookie then won't match the core's, so skip
+		 * the warning in that case.
 		 */
 		if (next && sched_class_above(&ext_sched_class, next->sched_class)) {
-			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_LAST));
+			WARN_ON_ONCE(sched_cpu_cookie_match(rq, p) &&
+				     !(sch->ops.flags & SCX_OPS_ENQ_LAST));
 			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
 		} else {
 			do_enqueue_task(rq, p, 0, -1);
