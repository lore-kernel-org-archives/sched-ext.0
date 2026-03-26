Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269432DB787
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516688; cv=none; b=OlqPXH/sjMyeUPkNQya/BKjk68wLkNN0T3JMohp6lA0TJgs2OvXSkWA14GJagx3F8pQYjFZEdR3+8zSR0y+q+alOkWRYMsOdoquoxmwG2rV6r6XKL6Tz87fYslyplrNoa1m7Kvsu+BBT8A/+gqkqPodWUce8y3QHbYT9tl+t5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516688; c=relaxed/simple;
	bh=ynb5E3d5WO4xJeTVNBzo57d70Qa1mRrcWqzpUoEaZ1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YzfsVEoR5Go7Aa7uG5yepjokBvpxLhLl0lc/9jXwRAKD7+PsLCdPUUGu0EXos6wKPYddDYW9yzDQIKcSYKu0A6k+xUSbfkkzMMnUzxaqbftuWdTQLCOmhLcJsQPqxUm5RZHQp+/r3dXxohiGv+IsBitXevAHkgn6V2YHRsVOYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF/nfYh9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF/nfYh9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b0586d5bb8so5404325ad.3
        for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 02:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774516686; x=1775121486; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u5L/p3jok5ub3ykqcDjJqQfW/Y7+Y6SXASAcxbMUHCI=;
        b=NF/nfYh9qPk7+qZgHxqw/99qflpXnp7c7FtcOlwuyAr1HTCkavgkhQfcvDPvAAEotM
         l90S5X+2foM6CjwW1FKbTh2dLh1CQyhXd2SFixuJJfAQzkurgZ6xvzChZwBd+K8fTKoJ
         JU5SYDacK37yYUfgQs+I+XfFDLl12kD89i9qjEfg2+fzwEPhCibyBCKVWDpNweBzUjml
         zNWrKApGGXeqsKh2nGZ/OFgtWQ8JWSsLdJJ5tPJbyfqnyaVRMGQS1TyvRWe85jxZQVmr
         SrYMpTz+FFTNdj4N1+nwBNjRmBlkShn02DsIbsyIIFPnGFNJCycmOcUn/4cncOEDSQJm
         wHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774516686; x=1775121486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5L/p3jok5ub3ykqcDjJqQfW/Y7+Y6SXASAcxbMUHCI=;
        b=tS4NYIKaGTsvOodGCrTo11JUDMMjJT22yElF3R8HUmYgGGvCx76WzC4GE1xzx89yOj
         Ba6m3mSofbqlWrF76zqYgEaqAanLau2t8K47+otUpZa7tDzjQVOH+NTt08JHgq6suFUt
         xsHwi7hbM++Lg+/pjtKjoOBfZu0stkUCJJsPBur8NRO5mfP8nc3d9TlUDNfSGse8/w8/
         m9PbkXl5T+in+5czuwXvRg38Lp8MTR3iGASWe7SgQzXrrbhp93951CWV/sXQmtdJhkNk
         v2yAYtFjmTWynRQMV6pSztripgAQB5JElMBN2rOif8EFyIsNhxiAk4eU1VQ/OckPezKj
         /OEw==
X-Gm-Message-State: AOJu0YyNiXyWFcxTSQEmJXbwsaDrs1ePB9f/o2G00Z+J5uIIi+iTXbjU
	kug6/EBNikG7HE+pTZrvvS5zE6CB7sr+or03qfeEk+ep5QZknBwoGG4yCH7yLOr9
X-Gm-Gg: ATEYQzzGtrrwZI71fojnJpjJ+tPb6KAtsyQ9tmTi4x3PD0AfOwUpx1cnqe62NwXPjtv
	IuhXEweTt1/6YUtPJIdEIpAN7czLFAniXe7pQ8pLRaiQON601aYhiIIFY0MklEtdtGg6JvwBQ6x
	rk4czYqMq7m177csma1xJ28HbuvZesrxiM9lGGI/553Qju7IBA0AhVPkTMWulYga0v9XfdwVXG+
	meCvy2te0/YhOH08NNAwbdQSXQXYfOOYk4FDRbGUU0zit9KmkwFUP920NPaLL+cenuIahF6HoDl
	Qopj5tOFQg6pUgyhoxleTIUMEkxEKlBEYtCjhJnpNukpC9ywIIzEOp4DUd7AsDpQ+caQBl48uWz
	VkU6pJXtM56Adu/eHDsgho7FrLH06ZzMf1X2oj7EISyNIVjRzkRgFrM9v8MuxWSCAgdq4vQ96Cd
	L1afUF6CySBV33PGd6DUZUzllCDar2Giz0PMD7k62S0lUJW3qSuFY=
X-Received: by 2002:a17:902:d582:b0:2b0:65e8:4041 with SMTP id d9443c01a7336-2b0b0b19ae0mr77976695ad.36.1774516686069;
        Thu, 26 Mar 2026 02:18:06 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:ac9c:4df3:99d:84b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76bbdcsm24229525ad.5.2026.03.26.02.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 02:18:05 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH] sched_ext: Fix scx_bpf_dsq_move_to_local___v2() to handle SCX_DSQ_GLOBAL
Date: Thu, 26 Mar 2026 17:17:30 +0800
Message-ID: <20260326091756.816828-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_dsq_move_to_local___v2() called find_user_dsq() for all dsq_id
values, but find_user_dsq() only searches the rhashtable of user-created
DSQs. SCX_DSQ_GLOBAL is a builtin DSQ stored in the per-node pnode and
not in the rhashtable, so passing SCX_DSQ_GLOBAL caused find_user_dsq()
to return NULL, triggering scx_error() and aborting the scheduler.

Add an explicit check for SCX_DSQ_GLOBAL and use find_global_dsq() in
that case, matching the pattern used in find_dsq_for_dispatch().

Fixes: 860683763ebf ("sched_ext: Add enq_flags to scx_bpf_dsq_move_to_local()")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 551bfb99157d..0d0780c77ffd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8249,7 +8249,10 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local___v2(u64 dsq_id, u64 enq_flags,
 
 	flush_dispatch_buf(sch, dspc->rq);
 
-	dsq = find_user_dsq(sch, dsq_id);
+	if (dsq_id == SCX_DSQ_GLOBAL)
+		dsq = find_global_dsq(sch, cpu_of(dspc->rq));
+	else
+		dsq = find_user_dsq(sch, dsq_id);
 	if (unlikely(!dsq)) {
 		scx_error(sch, "invalid DSQ ID 0x%016llx", dsq_id);
 		return false;
-- 
2.48.1

