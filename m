Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792786212;
	b=YGD5KZhRjaBrQUIEjLOiT3UXobPqi+lK0G8J/lvN8lVAKLvimp2bAbKHrBHvm+Nc0DII
	 CVBj8OVNUBP0oWG4u2UpD9nl0EKInJ1kTPebn8C5iPlVLNtDOo12fVlpLOQqyOsUWd62q
	 OTd+Txb4fXVZSD89VyZc1RICHcVAd4v80rx9Ty+CJNsdFQbDN7FZaHRGUAqHsZeLSmGvm
	 c51kd5SyxhFe9M3WtkwLlsUL2XivnWa7ya5Kduc1wsyTFS9+ll0sBVyeq7zbV6wAbyLb2
	 5OzstgN3qZb4ePNOZQj8ACa4W8CE4CyQDunxZxx94nbJTQYTnpeF1VrtHB82nov1d7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792786212;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6V1oMuiq9qw4KmLZ1HFOusQNjrK4i0c4FnOOxnqx1Co=;
	b=iuOwxvdUr0UGSDKzA6J+DU/zYEqPSRxcyFkpm++LuHTxSprz5RqZMnQ80tk2GiAySQbu
	 5cIaokR/pBm54RwL3IEtsH/cLvlg2RDFb2VWW6ExE8mhNJpVLfsq5Y2SINloMu1VrQts4
	 xi/OPleIWi3WRJ3bnA9IbMP4yXbzGsikOn0BNiLTraY6S7okZagJ4arj9EIUIWAE7Dx0V
	 Ma8CxiedlvYxhqr7hb/ZQHSPvRPSNIk8qJuvwpRYMRUo9P9vG5x7PJJtlZ7lJrdUBB8Dv
	 T0JXQ+FdCY3Gd3mIGCRY6J2zJr6lobdz43KEg4Gu537jJsh4erAD49yC9CGQ20ZDIXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJQJWHc8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC01606A31A;
	Fri, 23 Oct 2026 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oJQJWHc8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C062F1F01825;
	Fri, 23 Oct 2026 20:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792786212;
	bh=6V1oMuiq9qw4KmLZ1HFOusQNjrK4i0c4FnOOxnqx1Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oJQJWHc8LfCxqO5yks/jJQdFUc25FGPF6gkOBsNDOBxAyjHzURR6Abf8Z5DR3T7br
	 gMZdTVysB+e7gfKLRjFcKBJlN1K1buy6oFDlWevwDz71Jg7W1H1WFDVoCTSxdDcc+N
	 m5CSO/Drrpe//jP7HPXUwkZcxBZlLMSEj6T4xFQHMnAyAMvGuSSRkg8mHLE4mjEt41
	 ofRE2JX6L/h+/T/ZlISNP7Yj0LExsJ9gRxufuMAuaJNJM3O0CFhxdM9OpDJoe2MbhC
	 5QrvECCdJ7lqzJlAy1cj8GhhxcKMILiKd240hyUMkbO9N0wLaQ9ooW68fYuHQy6DXv
	 G09osJ/tgrJVw==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 20/17] sched_ext: Fix a lone IMMED task waiting behind a kept prev
Date: Fri, 23 Oct 2026 10:10:10 -1000
Message-ID: <20261023201010.325099-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023175608.4120910-1-tj@kernel.org>
References: <20261023175608.4120910-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While dispatch is in progress, rq_is_open() returns true and dsq_inc_nr()
schedules no reenqueue for an IMMED task inserted on an empty local DSQ. The
check at the end of dispatch_one() catches up only when more than one task
is queued, so a dispatch that keeps prev leaves a lone IMMED task behind:

 1. a parent's ops.dispatch() sub-dispatches into a child, which consumes a
    task with SCX_ENQ_IMMED onto the empty local DSQ
 2. the parent extends prev's slice and dispatch keeps prev
 3. the local DSQ holds one task, so no reenqueue is scheduled

The IMMED task waits on the local DSQ behind prev instead of going back to
be placed again.

Schedule the reenqueue when dispatch keeps prev and an IMMED task is queued.
With prev keeping the cpu, even a lone IMMED task can't run right away.

Fixes: 98d709cba319 ("sched_ext: Implement SCX_ENQ_IMMED")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ae5e8861ca0a..25f3788605eb 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3464,8 +3464,12 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 	 *
 	 * - A non-IMMED HEAD task can get queued in front of an IMMED task
 	 *   between the IMMED queueing and the subsequent scheduling event.
+	 *
+	 * - Dispatch can keep prev with a lone IMMED task queued meanwhile. The
+	 *   task can't run right away behind prev.
 	 */
-	if (unlikely(rq->scx.local_dsq.nr > 1 && rq->scx.nr_immed))
+	if (unlikely((rq->scx.local_dsq.nr > 1 || verdict == SCX_DSP_PREV) &&
+		     rq->scx.nr_immed))
 		scx_schedule_reenq_local(rq, 0);
 
 	rq->scx.flags &= ~SCX_RQ_IN_DISPATCH;
-- 
2.56.0

