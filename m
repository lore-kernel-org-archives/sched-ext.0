Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFEA3E6388
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584151; cv=none; b=SJ8mQ1WH5HVXFIfTs2r/OKangLvJG/cRrJ7sFFLp4adJ1jHbjp/e9AY8kpS5qxHZpZceEq6obJu6fcDEgaoMHvesbmlsbuhIonDGb34UprAacV1WEvDEUuS/ZOfAZKvqH9Ny0s7BNa79PhPfO5yAo6zBAZxfWhBIIQdRocSxKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584151; c=relaxed/simple;
	bh=zBl4oLXZ3l5Nbt9vMWYi3gbsySp2VicO2F5NVVAfNXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=myM4btbvCx2w7HhtLeHORD8Vf6LW2JKHr6s3sNytA2u0zqHRTIDpVfEX04bSfXa28o6wlUT60EKMe1y3dTiFH0CkCX9A8dxp6obQlYpk83fuWWw5k1r/NdHwi4+C8td4vKhwmkRREN/zkiIhwtAmsQgnL8J2XU7KbJZgk/xun6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 828ea1867b6c11f1aa26b74ffac11d73-20260709
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:54c11bff-df27-4d6f-bfa3-0b75869a1a06,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:0029ba10db526155f3f18fe741429bb0,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|136|850|865|898,TC:nil,Content:0
	|15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 828ea1867b6c11f1aa26b74ffac11d73-20260709
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1544719346; Thu, 09 Jul 2026 16:02:20 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH] sched_ext: Fix typo in scx_bpf_dsq_insert() comment
Date: Thu,  9 Jul 2026 16:02:05 +0800
Message-Id: <20260709080205.534892-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

The comment for scx_bpf_dsq_insert() references "@dsp_id" in the
description body, but the parameter is named "@dsq_id" in both the
parameter list and the function signature.

Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 kernel/sched/ext/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 691d53fe0f64..cbfa23d71e68 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8572,7 +8572,7 @@ __bpf_kfunc_start_defs();
  * When called from ops.select_cpu() or ops.enqueue(), it's for direct dispatch
  * and @p must match the task being enqueued.
  *
- * When called from ops.select_cpu(), @enq_flags and @dsp_id are stored, and @p
+ * When called from ops.select_cpu(), @enq_flags and @dsq_id are stored, and @p
  * will be directly inserted into the corresponding dispatch queue after
  * ops.select_cpu() returns. If @p is inserted into SCX_DSQ_LOCAL, it will be
  * inserted into the local DSQ of the CPU returned by ops.select_cpu().
-- 
2.43.0

