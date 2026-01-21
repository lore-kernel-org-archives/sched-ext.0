Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F404657EA;
	Wed, 21 Jan 2026 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037125; cv=none; b=nv2hf/5fCFBbiuEMOcnwlQ1shg53wQnl8qnI2Lrx2hI7rohJkwJbXPFv3jNGfvJeSt9LhY05+7kG4G8XylyVdWf60+4XuaHSMbFnhMAB664p2IUhWObmUIjCAb1akd+6tnu0liBC+E08dLYL+RomGTThmcOlT2ATP70wSa6v73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037125; c=relaxed/simple;
	bh=RsJAlnh+wqpqLqaCD87s58RXfCbOFr+W/tXIEvm9Q0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ybx+HQQNe6lHQ+QpoZ0XpbJC2vH8MrhU4GppgDmkX/Yjh+NF2Ev+wggWLfNjk1Zqgaxh5GGxPdT9Myk9ttigDpbnpqIradvNQGgDfgj0HNYr3kS5LJx5FGYnpYjbWiC4Ea0Sli3F8Xrf1AkXEjqEn/DkLntqUYVwp2AV39u9Irs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlATPMXx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlATPMXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D12C16AAE;
	Wed, 21 Jan 2026 23:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037123;
	bh=RsJAlnh+wqpqLqaCD87s58RXfCbOFr+W/tXIEvm9Q0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FlATPMXx7dM7vkoG04Q152O4i65yF8HQWyz99qakCkE4mTq8J34TgJ7XWDtxoF9BO
	 gJoFlRB0KzEtzhC1g3fCE8obJlPGANos7wvn2/hgV0YvrxoHSnk0cjFjZf1/v2caEV
	 ZItlaw82/Kuoqzoa9I3ZGYzS4UHVKOA4glBJCB1nfzsE7M3BNKUEB0y/SClIww59B0
	 55ZKL1foxzifcZCiKup9Ne/Y7PxOdmipyEOYvwr+BorejSCkcKcglGA7/RpKlT5HIK
	 XghquMqb/2UJfiNljAoEo/B1xgzBw+zmNklw/JBbqtY1gVeyf13GGwuwrTRRYVdtFl
	 3lBffTXJFKbmw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 21/34] sched_ext: When calling ops.dispatch() @prev must be on the same scx_sched
Date: Wed, 21 Jan 2026 13:11:27 -1000
Message-ID: <20260121231140.832332-22-tj@kernel.org>
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

The @prev parameter passed into ops.dispatch() is expected to be on the
same sched. Passing in @prev which isn't on the sched can spuriously
trigger failures that can kill the scheduler. Pass in @prev iff it's on
the same sched.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 682dbaa22488..d27c6394d452 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2298,9 +2298,10 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 			       struct task_struct *prev)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
-	bool prev_on_scx = prev->sched_class == &ext_sched_class;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
 	s32 cpu = cpu_of(rq);
+	bool prev_on_sch = (prev->sched_class == &ext_sched_class) &&
+		sch == rcu_access_pointer(prev->scx.sched);
 
 	if (consume_global_dsq(sch, rq))
 		return true;
@@ -2324,7 +2325,7 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 		dspc->nr_tasks = 0;
 
 		SCX_CALL_OP(sch, SCX_KF_DISPATCH, dispatch, rq, cpu,
-			    prev_on_scx ? prev : NULL);
+			    prev_on_sch ? prev : NULL);
 
 		flush_dispatch_buf(sch, rq);
 
-- 
2.52.0

