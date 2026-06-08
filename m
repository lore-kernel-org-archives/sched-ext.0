Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EBE2D738F
	for <sched-ext@lists.linux.dev>; Mon,  8 Jun 2026 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903544; cv=none; b=M1H0kh+ZLiuDSq/Qtj2B6FERwhkqQ7/cDLxICyH8J5DHs7hxTgeHT6zJyWo1GktCR8yCrWd/1D3A1kX/z2B+6R7qljGgijNt5FmF2oUH81iukrAKbPDFvObiQydnBCjJRdTJLUnH9Hr2E6oZpXfIA7ZYxNefUCFEi48/TVwFxRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903544; c=relaxed/simple;
	bh=aVLTX5TZiWZ1shpD5SNvc+NRszvYDlGlfzlpkdmbZIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XyQ75b+oVcZ8BY0xRr0WuwA6rSVmCAsVLPbS0iZY9z7ry2xBNOcABMa9lKGIXRWbeIlcaPS1mIq+SSMc5PkXJBxvk915Wh29hkuiy3kOCkO8aM5U5sk/he9XlTQ1q8dlK310uzd7OzpGBV1EGbjcDMpx78zy6kf63/BzQrguqVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E+bSMESI; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E+bSMESI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jI
	gViJXZBlpKj3kHMm4C5KaiRzg/uKoJWxC7yEzS3TA=; b=E+bSMESIW1hZxL7FDx
	Iw6IL98MJ9w6C+miA9/Z8sBpbNawt6/8k8zJJ1JvLr3goT2Iy0mNAjKrIXkFgTDS
	nXKJj1f65V6mnktHevPPSEoxnsavfqDoOfswuKMvEqNpVus3Giuk4ecBMq+7IAhH
	OBQAvSE/WKv9SBwaKT66/WFRk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBXGiZabiZqD99KBA--.23024S2;
	Mon, 08 Jun 2026 15:25:16 +0800 (CST)
From: Wanwu Li <liwanwu9113@163.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	Wanwu Li <liwanwu@kylinos.cn>
Subject: [PATCH v2] sched_ext/scx_flatcg: Fix cvtime_delta race and add hweight scaling to bypass charging
Date: Mon,  8 Jun 2026 15:24:57 +0800
Message-Id: <20260608072457.3-1-liwanwu9113@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBXGiZabiZqD99KBA--.23024S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr48CFy3Zr15Cr4xAry5urg_yoW5ZFW7pF
	W8Cr1xtr15WF1UKry8Za1DWFyqkan0yw4DWrZ5Xa9xZr13Gw4rtr1UA3ZaqF43Zr9agw13
	uFW0k3WfX3W0y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOF4iUUUUU=
X-CM-SenderInfo: polzt01zxziiqt6rljoofrz/xtbC9xzWX2omblwg-gAA3C

From: Wanwu Li <liwanwu@kylinos.cn>

1. cgrp_cap_budget() used __sync_fetch_and_sub(&cgc->cvtime_delta,
   cgc->cvtime_delta) to atomically read and clear cvtime_delta. However,
   this is not a true atomic read-clear operation: the second argument
   (cgc->cvtime_delta) is evaluated as a normal read before the atomic
   fetch_and_sub executes. If a concurrent __sync_fetch_and_add() happens
   between the read and the sub, the added value gets included in the
   returned delta AND remains in cvtime_delta, causing double charging.

   Example: 
   CPU 0 runs cgrp_cap_budget(), CPU 1 runs fcg_stopping().
   Assume cvtime_delta = 100 initially.

     T1  CPU 0: sub_val = cvtime_delta = 100                 cvtime_delta = 100
     T2  CPU 1: __sync_fetch_and_add(&cvtime_delta, 10)      cvtime_delta = 110
     T3  CPU 0: __sync_fetch_and_sub(&cvtime_delta, sub_val) cvtime_delta = 10
                                                                returns old=110

   delta = 110 (includes the 10 from CPU 1), but cvtime_delta = 10
   (the 10 also remains). The 10 is charged twice: once in delta
   (applied to cgv_node->cvtime) and once in the residual cvtime_delta
   (fetched again next time).

   Fix by using __sync_fetch_and_and(&cgc->cvtime_delta, 0).
   Disassembly comparison:
   (1) delta = __sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_delta);
   228: (79) r7 = *(u64 *)(r9 +40)
   229: (87) r7 = -r7
   230: (db) r7 = atomic64_fetch_add((u64 *)(r9 +40), r7) //r9 may be changed

   (2) delta = __sync_fetch_and_and(&cgc->cvtime_delta, 0);
   228: (b7) r8 = 0
   229: (db) r8 = atomic64_xchg((u64 *)(r9 +40), r8)

2. The bypass charging path in fcg_stopping() charges raw execution time
   to cvtime_delta without scaling by the inverse of the cgroup hweight.
   Since cvtime_delta is eventually applied to cgv_node->cvtime which is
   in vtime space (weight-scaled), the bypass path should also scale by
   FCG_HWEIGHT_ONE / hweight to match the units used by the dispatch path.

Fixes: a4103eacc2ab ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")
Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_flatcg.bpf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index fec359581826..ffabf0d9f32e 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -256,7 +256,7 @@ static void cgrp_cap_budget(struct cgv_node *cgv_node, struct fcg_cgrp_ctx *cgc)
 	 * and thus can't be updated and repositioned. Instead, we collect the
 	 * vtime deltas separately and apply it asynchronously here.
 	 */
-	delta = __sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_delta);
+	delta = __sync_fetch_and_and(&cgc->cvtime_delta, 0);
 	cvtime = cgv_node->cvtime + delta;
 
 	/*
@@ -570,7 +570,8 @@ void BPF_STRUCT_OPS(fcg_stopping, struct task_struct *p, bool runnable)
 	cgc = find_cgrp_ctx(cgrp);
 	if (cgc) {
 		__sync_fetch_and_add(&cgc->cvtime_delta,
-				     p->se.sum_exec_runtime - taskc->bypassed_at);
+				     (p->se.sum_exec_runtime - taskc->bypassed_at) *
+				     FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));
 		taskc->bypassed_at = 0;
 	}
 	bpf_cgroup_release(cgrp);
-- 
2.25.1

