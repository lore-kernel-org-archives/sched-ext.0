Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75AA23AB9D;
	Sat, 15 Aug 2026 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786755936; cv=none; b=p9M/a8iP7oZw8ljsn18/Ty/gD95axskKTZA5TdzZo7A7p/j7w6wCt82PBGpzFJZS8eWlJBhqkGAnruCJbYskrs3ijigr5rjE3O5xs5abPzPENIOb/Wv9tH3hLdM29XwIcZP/dkWw8Bvihedh4ZFJwxCY2TLO41fUXSDtt71Q6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786755936; c=relaxed/simple;
	bh=IEvCmi4jX4TOPxqdiJWzdumqiYtVhTarQmIJlSCN1CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJG2P/91kS+dkbdUqfkUzsj3Hdxtd7FGE1PrdQTXnmjqmtEsHiHBBuWDGCYywWdmT7KRv71YRiOYAqZh3wSddEeTzZu8pggwaP/dX6g4R8KU9nSUUhqg6im6O1cisgMonZbr1q5QjqZ0dy6XhXjqHBlcEfYohaOc/pLYaZa7cfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwRt3JB7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwRt3JB7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7A31F000E9;
	Sat, 15 Aug 2026 01:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786755935;
	bh=ropyht7MWTjZXecsTc27JOBIBJy4URexeNyvlMRiWK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SwRt3JB7Apro/ALHKcy/mdZPsdHTAl9ipxprZmUEkJIzaxuFxY/EVOdDqKInRflMi
	 c458mHcDAbyk06IUViv4+1oPviYmEW8BNfjpLFqqxGpqYLpfqEJuYVJhWDxA3SoMI2
	 DbiAi/g+l9TtBypsoylGeNeLdj0WVkp2ywbqzbh2CBmyalOsY5GZ1lKBYtrWNB/osZ
	 qW73yn3CUhnc6o4HQugX20dgxrjiw8rst9xowGlH+IjCGoRVUhwt5QE1hJfQyx5+lE
	 Dpp4wj82WcxsChot1QxQp9khG/ftK0LSwSNvgyZwHXoAiYnwis21iMuHGwiIlAFdsq
	 lIZpfDdIXKFiQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/3] sched_ext: Drop the stale keep_prev fixup in dispatch_pick()
Date: Fri, 14 Aug 2026 15:05:31 -1000
Message-ID: <20260815010532.3663253-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815010532.3663253-1-tj@kernel.org>
References: <20260815010532.3663253-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fixup demoting a keep verdict when @prev is not on ext_sched_class
guarded against the rq-level SCX_RQ_BAL_KEEP flag going stale back when
balancing and picking were separate operations.

The verdict now travels in the return value, created and consumed in one
invocation against the @prev it evaluated, and every keep decision tests
SCX_TASK_QUEUED under the rq lock, which implies ext_sched_class as a class
switch dequeues first. Drop the fixup along with dispatch_core_pick()'s
copy.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4867517b71a4..19db98f0e727 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3355,11 +3355,6 @@ static enum scx_dsp_verdict dispatch_pick(struct rq *rq, struct rq_flags *rf,
 				       kick_sync_wait_bal_cb);
 	}
 
-	if (unlikely(verdict == SCX_DSP_PREV && prev->sched_class != &ext_sched_class)) {
-		WARN_ON_ONCE(scx_enable_state() == SCX_ENABLED);
-		verdict = SCX_DSP_LOCAL;
-	}
-
 	return verdict;
 }
 
@@ -3410,13 +3405,6 @@ static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_flags *r
 	if (rq->scx.lock_drop_seq != seq)
 		return SCX_DSP_RETRY;
 
-	/* see dispatch_pick() */
-	if (unlikely(verdict == SCX_DSP_PREV &&
-		     prev->sched_class != &ext_sched_class)) {
-		WARN_ON_ONCE(scx_enable_state() == SCX_ENABLED);
-		verdict = SCX_DSP_LOCAL;
-	}
-
 	return verdict;
 }
 #else	/* CONFIG_SCHED_CORE */
-- 
2.55.0

