Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171F3B8139
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785219009; cv=none; b=VcqFXivE9Frl+eru7wjluo3DrkQrpnoq7tJ4FHANND0JaNiCpSXYTp547DMI6DOIK3QjPsRp/vpRcxysTLlNR7JIhY1SNN/x6bXSgZGFlDOQ27QkPAsm8Uv2C30Njkr+Dx7twBF9ZbQIuI7GRgkoFVeureDfR8BonHB1Xc7qwwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785219009; c=relaxed/simple;
	bh=eUAduvagUVxRo39UhVPwIPWlhk+08a8H/iJdklwqsLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qWQTHSDqXRePsXOy7488jw+Y/KEFSWe/MUlUdSUDJluXK+bl8qM5d3kfM8u9Y3AkBhsfeGlNkLG4qkJPLHSz7pQ/sT/E14q+WVbqXRFXOrDJnjVspfRUVL4wye2kaWPY58gm5MGC8fkJsp3yxYeNWPAgpDCbWofRMuurKA/vWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f6f84b348a4a11f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7719b851-5816-4385-988d-87bf2c59d957,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:31b227da0bf3e2fd95a99c3d1ffc4f85,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|136|850|865|898,TC:nil,Content:0
	|15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f6f84b348a4a11f1aa26b74ffac11d73-20260728
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1963428931; Tue, 28 Jul 2026 14:10:00 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH] sched_ext: Set errno on ENABLING -> ENABLED transition failure
Date: Tue, 28 Jul 2026 14:09:55 +0800
Message-Id: <20260728060955.4102964-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

If the SCX_ENABLING -> SCX_ENABLED cmpxchg at the tail of
scx_root_enable_workfn() fails, the function jumps to err_disable
without setting ret. At that point ret still holds the return value
of the last successful __scx_init_task() call, which is 0, so the
err_disable fallback reports the meaningless message:

  scx_root_enable() failed (0)

Set ret = -EBUSY, consistent with the other enable-state guards at
the top of the same function, so the fallback always reports a real
errno.

Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 kernel/sched/ext/ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 312938179e52..6a3e94707c8b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7520,6 +7520,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 
 	if (!scx_tryset_enable_state(SCX_ENABLED, SCX_ENABLING)) {
 		WARN_ON_ONCE(atomic_read(&sch->exit_kind) == SCX_EXIT_NONE);
+		ret = -EBUSY;
 		goto err_disable;
 	}
 
-- 
2.43.0

