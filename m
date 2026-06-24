Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C52652AF;
	Wed, 24 Jun 2026 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782345334; cv=none; b=M55rw4GHHFPPx9r4Jil5nBR+oOt9QsNQAD+6v8+uSkBL6WRmTCONfnwNNHqvP98Kvag7rl5dFdWKHvyU7hgS4/GGIwSWEoY/+ewv88K4xwR14Jdns4yvGShTatbSRw97y6KXB2W5f8IXgofNrdUP6zat+SKJhSJsdpROLm/Q/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782345334; c=relaxed/simple;
	bh=DWEPJCpu3QrDhwamWRIGJd5NNzLE4XGS1Kb9dC3L84k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFj6VF5I/sLs7acyyEw7CoaAOrFKXeChnBypgKgDKW7emzM46YCJif5yLRPYfwZtI5ZlL10cMXVaqUVT66Npzfn9zW+p2KUieM3E7B9gdOUoapVebPmYjdEzISR3IVc6daxZ4sO3KX+A8ZUqHlamQs/LB/kLJNNmwdvx4hx3Gbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzcGdO+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzcGdO+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7B01F000E9;
	Wed, 24 Jun 2026 23:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782345333;
	bh=dlZuFnUplu825VpNYh4LDqSTV0APJIi+I856VEvhJiM=;
	h=From:To:Cc:Subject:Date;
	b=dzcGdO+M/Bfk5wFr4YMsszGvLXsb3fev580xNZEkMv2tUX6Uf5pdn7uxKdlKlSadq
	 Zy+S/Bnpa5ksLf3YUfGrEIlHDciOh0wO2mNEpoH4vBvAwxDwhaHBhPvN7you9MDxbG
	 9CHHHtTTCxfknf7KbmkoY/s1VlIU6t5CHBydXuY9L3Gk93q0+GZAkcGyhd5X65SfgJ
	 bz11dQXsw10bpSx9XK9QzxY7P9K94O7vDeUaJW1tCNQT9AEq9TFCpk+aPk8VGHl7+G
	 0r1aNzqkr+ZjJZy4010cn2etIawRceH2kKPvFn3AjfTdbe9Iv1wCqDs600+OV3IRnk
	 uSbb+7IPY5xdg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Don't warn on core-sched forced idle in put_prev_task_scx()
Date: Wed, 24 Jun 2026 13:55:31 -1000
Message-ID: <20260624235531.2979880-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

put_prev_task_scx() warns when a runnable task drops to a lower
sched_class without SCX_OPS_ENQ_LAST, assuming balance_one() would
otherwise keep it running.

Under core scheduling that assumption is wrong: a forced-idle SMT sibling
reschedules through the core_pick fast path in pick_next_task(), which
skips balance() for the CPU, so balance_one() never runs and a runnable
task can drop to idle with ENQ_LAST unset. Skip the warning when core
scheduling is enabled.

Fixes: 7c65ae81ea86 ("sched_ext: Don't call put_prev_task_scx() before picking the next task")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9c9cb9d08bca..503c4d2105ee 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3092,7 +3092,9 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * which should trigger an explicit follow-up scheduling event.
 		 */
 		if (next && sched_class_above(&ext_sched_class, next->sched_class)) {
-			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_LAST));
+			/* core-sched can force cpu idle while @p is runnable */
+			if (!sched_core_enabled(rq))
+				WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_LAST));
 			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
 		} else {
 			do_enqueue_task(rq, p, 0, -1);
