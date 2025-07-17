Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305128E7;
	Thu, 17 Jul 2025 01:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714257; cv=none; b=NihwUU64yA8T0gq+sXUQ6Cbne5IziFgs9c0jovAeOUsUZg2Pm25KPQ/XLhZFnnwz6wigqB64+yiDkX/XIpulrEv2fgbQgqryRqRYShLngv2qKeLdXxnSQmcQu/7xl/svE7n32DqEl/JmOwjaYzyYvlWn08dm7aJe1ETA2bqo6WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714257; c=relaxed/simple;
	bh=b7ONfz8tgk+Ga8sqaTxdW+yomUzwVOiYLkjimeztWyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBpiQ0lU7O2RKaA+5rEUkPb232IJI3X67yaJdmxtkeV5De8M/V/s0U3cDWUQluT9Eg23QGYgngnGhfh6h3ukv1foY9VrnQTO11f7WJZWxMSDcnv8yKfOoHzqxNG/LDB8PxQ14c4CtH2Yjou1s9v2qiwHuGVNEfVsDRkvnYUdfNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEL0mZJH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEL0mZJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498B4C4CEE7;
	Thu, 17 Jul 2025 01:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752714257;
	bh=b7ONfz8tgk+Ga8sqaTxdW+yomUzwVOiYLkjimeztWyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XEL0mZJHoVUMW4O0w6mCBljwunBBpgsWW219bXa+2PwPp0iMVTPXUv36w10orcXra
	 pwpUgCULAJcYUREtTLQFSziTS2SEhpcsKpm3oVLYDYb/IsXQypnvimalHMby0xwjhY
	 0+IC3vqH00sjSZfMxK3ETWhaqzH8vKaJ+c6I6wbNO24/lmMOwLtitQ1YJWPdVQzUQA
	 8zRsCa9bLt8NcbbF94ANSkg/8uy6vvC0XdSb5gpCHtYN9OpNtxvvj4gW1aF9SLZV0G
	 9bQ4mTXsJl2MWph+DweCBjakjRPCGs7yg5XAHd0bPae3ek+CzUGPJ92aDfgkobSaCz
	 htsI+zPojbQeg==
Date: Wed, 16 Jul 2025 15:04:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, jake@hillion.co.uk,
	kernel-team@meta.com
Subject: Re: [PATCH v2] sched/ext: Prevent update_locked_rq() calls with NULL
 rq
Message-ID: <aHhMEAICLTiS9uvx@slm.duckdns.org>
References: <20250716-scx_warning-v2-1-1d015b2d8efa@debian.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716-scx_warning-v2-1-1d015b2d8efa@debian.org>

Applied to sched_ext/for-6.16-fixes w/ commit message edit suggested by
Andrea:
------ 8< ------
From e14fd98c6d66cb76694b12c05768e4f9e8c95664 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Wed, 16 Jul 2025 10:38:48 -0700
Subject: [PATCH] sched/ext: Prevent update_locked_rq() calls with NULL rq

Avoid invoking update_locked_rq() when the runqueue (rq) pointer is NULL
in the SCX_CALL_OP and SCX_CALL_OP_RET macros.

Previously, calling update_locked_rq(NULL) with preemption enabled could
trigger the following warning:

    BUG: using __this_cpu_write() in preemptible [00000000]

This happens because __this_cpu_write() is unsafe to use in preemptible
context.

rq is NULL when an ops invoked from an unlocked context. In such cases, we
don't need to store any rq, since the value should already be NULL
(unlocked). Ensure that update_locked_rq() is only called when rq is
non-NULL, preventing calling __this_cpu_write() on preemptible context.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Fixes: 18853ba782bef ("sched_ext: Track currently locked rq")
Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org # v6.15
---
 kernel/sched/ext.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d867ba21..7dd5cbcb7a06 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1272,7 +1272,8 @@ static inline struct rq *scx_locked_rq(void)
 
 #define SCX_CALL_OP(sch, mask, op, rq, args...)					\
 do {										\
-	update_locked_rq(rq);							\
+	if (rq)									\
+		update_locked_rq(rq);						\
 	if (mask) {								\
 		scx_kf_allow(mask);						\
 		(sch)->ops.op(args);						\
@@ -1280,14 +1281,16 @@ do {										\
 	} else {								\
 		(sch)->ops.op(args);						\
 	}									\
-	update_locked_rq(NULL);							\
+	if (rq)									\
+		update_locked_rq(NULL);						\
 } while (0)
 
 #define SCX_CALL_OP_RET(sch, mask, op, rq, args...)				\
 ({										\
 	__typeof__((sch)->ops.op(args)) __ret;					\
 										\
-	update_locked_rq(rq);							\
+	if (rq)									\
+		update_locked_rq(rq);						\
 	if (mask) {								\
 		scx_kf_allow(mask);						\
 		__ret = (sch)->ops.op(args);					\
@@ -1295,7 +1298,8 @@ do {										\
 	} else {								\
 		__ret = (sch)->ops.op(args);					\
 	}									\
-	update_locked_rq(NULL);							\
+	if (rq)									\
+		update_locked_rq(NULL);						\
 	__ret;									\
 })
 
-- 
2.50.1

