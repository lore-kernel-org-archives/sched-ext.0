Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B4140A940
	for <sched-ext@lists.linux.dev>; Tue, 11 Aug 2026 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435209; cv=none; b=shNe49PBN0OJqVIVEuQ+W3xYGnUy718Yd+o8ABqhEBX9CSobUjTzLQ9R4njXVtgfobtlQbm+18VE4yfcsp6dGFC+LA7DkQyFGDRxcoE07ZjmjSzjTxfYkuTpqe9jRMS7UCgedihIMVkLcWrsy6tci76M7Q56ReaRf2ZjdSYIp0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435209; c=relaxed/simple;
	bh=O2wK6TNJCUQ27oS5RMJ+n4uSWvaBZEstDq3wqjsYBGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmlyWfqga+gtM5+Qj0YAkXISL+bAsmKDK/BEHv4VmCqUDvJ+8uoeJX9T3CqC/cWoMbDBkuD8g2li8MIXi1IU5WuqZAdfURY0v8jdluUU80B0DcT7/WR3n/3dX3nSeZTVa5cTKZFSiQWBt1rGeHlaDdxqxX6pzm8a6gVF3Ji1euY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lo/W+TYP; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lo/W+TYP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786435205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lqGW+YYQquEv1JA4YJdG3wyj6xCfkvvGSCfJkPKsEs4=;
	b=lo/W+TYPaIWH84nxdibI8bKQAU0eTZv2Z5LmobRWSUv//LYrCXQpboWHl1MWivunmrbQEO
	raho6ejgw9PtVBaoCl01YBiMMHaJXJc5aGwv4jQI2/Nc8fpvpCt0rrKuwu2yXV4hFka9GR
	MXR01lrmQ4jWDa7T7MQX8ODaEshEVAo=
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] sched_ext: don't BUG_ON a destroyed DSQ in process_deferred_reenq_users
Date: Tue, 11 Aug 2026 15:59:12 +0800
Message-ID: <20260811075913.344033-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

scx_bpf_dsq_reenq() queues a deferred reenq (dru) that runs from
run_deferred(), not ops.dispatch(). If the DSQ is destroyed before the dru
runs, process_deferred_reenq_users() sees dsq->id == SCX_DSQ_INVALID and
hits the BUG_ON. destroy_dsq() doesn't flush pending drus, so just skip.

Fixes: 84b1a0ea0b7c ("sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs")

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/ext.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 0bbe144c9811..604a05da41b9 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4531,7 +4531,9 @@ static void process_deferred_reenq_users(struct rq *rq)
 		/* see schedule_dsq_reenq() */
 		smp_mb();
 
-		BUG_ON(dsq->id & SCX_DSQ_FLAG_BUILTIN);
+		/* destroy_dsq() may race and invalidate @dsq; skip */
+		if (unlikely(dsq->id & SCX_DSQ_FLAG_BUILTIN))
+			continue;
 		reenq_user(rq, dsq, reenq_flags);
 	}
 }
-- 
2.43.0

