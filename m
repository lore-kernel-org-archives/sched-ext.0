Received: from mta1.migadu.com (out-164.mta1.migadu.com [95.215.58.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FAF126BE1
	for <sched-ext@lists.linux.dev>; Sat, 15 Aug 2026 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786760436; cv=none; b=eVb6WmEEI48tQwwNb4vJ2XjXLNtgXY0ZF4n6IPSJtRhGBPpPSWZCA6Hqi5DMV2OLcxEDZy8qj0IWTDcLzI8qV5ANZwtVLcH4GZ3v6aReUslf8l3rSnI5DAHOglXJjJmDtWEcCnS6iu3SKTAL1DJM7P6Rcl7rRY94wsGOmrKFHeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786760436; c=relaxed/simple;
	bh=0GEb5Od/PvQ0CVIdukkmwdJNdI6cQzLzbMS4Sv189cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PjNeQizXsAtBa3947oEr7/GpXTBmvbwYooceR3O8I5Bdyx5Gaz1YEYwlezl/f7MUkKg4QPDgljVFVjnGx4oD4+dtYSR+WPvrX+bX5+UQ1QKbWhFRNxMzetgzJgr/OiykJb1aykz4JQlUdFW49pOokj1obYieHWkZKKvcF8qg+PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f6nVfrY2; arc=none smtp.client-ip=95.215.58.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f6nVfrY2"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=0GEb5Od/PvQ0CVIdukkmwdJNdI6cQzLzbMS4Sv189cw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786760431; v=1; x=1787365231;
 b=f6nVfrY2JKtiSNDY0WwEjg1TYbT1ddb58oJ0yvj+N8+bgMruNBAQCLNgeYf4Oj/vIUKUOuYL
 N4zzCcbQrI6ngDCkPH4NucnMH8PoP4Y12B0FXYFdySAnLnmTQos/r9wdzyO3ooeo7VCfBEyp2jy
 qSw7lfZzruqRBeev206qyjpk=
X-Envelope-To: sched-ext@lists.linux.dev
Received: from ctao-book.. (111.162.215.50)
	by smtp.migadu.com with ESMTPS id 1b23676e190949c0;
	Sat, 15 Aug 2026 02:20:30 +0000
X-Migadu-Flow: FLOW_OUT
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
Subject: [PATCH v2] sched_ext: Don't BUG_ON a destroyed DSQ in process_deferred_reenq_users
Date: Sat, 15 Aug 2026 10:20:17 +0800
Message-ID: <20260815022017.3305427-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

scx_bpf_dsq_reenq() queues a deferred reenq (dru) that runs from
run_deferred(), not ops.dispatch(). If the DSQ is destroyed before the dru
runs, process_deferred_reenq_users() sees dsq->id == SCX_DSQ_INVALID and
hits the BUG_ON. destroy_dsq() doesn't flush pending drus, so just skip.

Fixes: 84b1a0ea0b7c ("sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
Change in v2:
Only skip SCX_DSQ_INVALID and keep the BUG_ON for other builtin ids
instead of skipping every builtin-flagged id, per Tejun.
---
 kernel/sched/ext/ext.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 26dbbbfe5a87..7d097209e778 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4637,6 +4637,10 @@ static void process_deferred_reenq_users(struct rq *rq)
 		/* see schedule_dsq_reenq() */
 		smp_mb();
 
+		/* destroy_dsq() may have raced and invalidated @dsq, nothing to reenq */
+		if (unlikely(dsq->id == SCX_DSQ_INVALID))
+			continue;
+
 		BUG_ON(dsq->id & SCX_DSQ_FLAG_BUILTIN);
 		reenq_user(rq, dsq, reenq_flags);
 	}
-- 
2.43.0

