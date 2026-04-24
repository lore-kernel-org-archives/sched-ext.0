Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DFA3FBEDD;
	Fri, 24 Apr 2026 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063462; cv=none; b=tuOZD+xdZvX+Y7ZG+zY6X/yLxzAibGxd4RMWYjyWm2O7FznSUG0pEcq8Txx8yWz8YpsBHVcCqXxu2i1NEPS+qc8n2vcU8teG/xdCJgmSGsExwrLyTDSd7Wx4qzXDV8thjOIu/YmNjVERmc1E0TTQzC8GG+FG42fZC+NJ9ws+5zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063462; c=relaxed/simple;
	bh=4zgA/8D5i8VIk2iiuAZijpdOo+YcCOiQlUoXstiK0x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIi3JhhBCIsta0RzLLjEcx9Sn//c9Ox99q9p8ps65f+RRMqKdC0WuC1ymimvdLpuhyRJDdLRsRE/mjQlXG5bS5Yn6Ubs6EUpmEeI3pR+f7A5mthThzeC1qRdKHBL1V1GxjaJAE6QGRrVnYANKKBVDff11HlHgI/QbEo/tw+XqLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyWJ9R1B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyWJ9R1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF12FC2BCB0;
	Fri, 24 Apr 2026 20:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063462;
	bh=4zgA/8D5i8VIk2iiuAZijpdOo+YcCOiQlUoXstiK0x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uyWJ9R1B+AWZ5TyRrDDy+uH1L7QK+ou0w1yaZ2vGWnjqAr+4aPTatYfWaivS60dFY
	 JUxsro0O85EBB/XRFuDZWvO9OH2BIwdUhktV0j32VQJmLKqdUXL1vR4FJdBa9VX2vm
	 HyfJaJm+nqX9U27J9iRSeBprxZj6swLjd3OjB6VPZH62cAfweQjL1r9egtiMDFrc8V
	 GuSlbtl0iG8z4i0SAgmNbANMmSPAoIzV3LlX8EkG3T1KkgLFq9YwfGivm7Wd4OSnbH
	 zZqHhEzJLXp5wpVOAHJMmaBVsf2tNgqYstH3eIbG+2kflshFmEBR0ak3XEN1IyG+jp
	 9122HFW++nlkg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 02/13] sched_ext: Guard scx_dsq_move() against NULL kit->dsq after failed iter_new
Date: Fri, 24 Apr 2026 10:44:07 -1000
Message-ID: <20260424204418.3809733-3-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424204418.3809733-1-tj@kernel.org>
References: <20260424204418.3809733-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_iter_scx_dsq_new() clears kit->dsq on failure and
bpf_iter_scx_dsq_{next,destroy}() guard against that. scx_dsq_move() doesn't -
it dereferences kit->dsq immediately, so a BPF program that calls
scx_bpf_dsq_move[_vtime]() after a failed iter_new oopses the kernel.

Return false if kit->dsq is NULL.

Fixes: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0c435a4612dc..89170a0e5779 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8055,12 +8055,22 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 			 struct task_struct *p, u64 dsq_id, u64 enq_flags)
 {
 	struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
-	struct scx_sched *sch = src_dsq->sched;
+	struct scx_sched *sch;
 	struct rq *this_rq, *src_rq, *locked_rq;
 	bool dispatched = false;
 	bool in_balance;
 	unsigned long flags;
 
+	/*
+	 * The verifier considers an iterator slot initialized on any
+	 * KF_ITER_NEW return, so a BPF program may legally reach here after
+	 * bpf_iter_scx_dsq_new() failed and left @kit->dsq NULL.
+	 */
+	if (unlikely(!src_dsq))
+		return false;
+
+	sch = src_dsq->sched;
+
 	if (!scx_vet_enq_flags(sch, dsq_id, &enq_flags))
 		return false;
 
-- 
2.53.0

