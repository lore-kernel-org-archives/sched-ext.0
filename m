Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424C6334C00
	for <sched-ext@lists.linux.dev>; Wed,  8 Apr 2026 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775618442; cv=none; b=R97gymMAZIICm1a3mT23TjmDKrgZNHatOvgFbH38K84wPtNrMYu+FUt734lc51Us67aezDiUrAaGYXnSNP1IxH8vktzadbamA0pYdbCQMWodVT5zjUIRBcPme76SripQEclFqlc5e9rLs3FEqLcrgUZ4iSZdi+37DnVzBkMj8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775618442; c=relaxed/simple;
	bh=wdO34TE1x7sI+XTxVw2fw9hAp67564DaGEFxp67eupU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HKd+okHgcf38TleM9i6kYLq9fVKB0YpkGmeRxYztpUzcDmjmybXmnfNJIOVgy4P2IIK3bR3vFgvRWkU7nviZzGoU/KbUuCWcjiQOgbhFVrhTDtjcVnD6g7JgmewDd7QIi1YCSlTymBZOGbxQlFMKc0E4kIeX5M5kpjNMGa93cwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e423823832f911f1aa26b74ffac11d73-20260408
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ba2ed83b-eaa7-4ac7-b8c7-61efc6ffb3ee,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:5af77ef4e70d6989f24bc42410ef2adc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|850|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e423823832f911f1aa26b74ffac11d73-20260408
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1978303471; Wed, 08 Apr 2026 11:20:28 +0800
From: fangqiurong@kylinos.cn
To: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	arighi@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org
Subject: [PATCH] sched_ext: Remove dead code in scx_set_task_state default case
Date: Wed,  8 Apr 2026 11:20:25 +0800
Message-Id: <20260408032025.3042093-1-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fangqiurong <fangqiurong@kylinos.cn>

The 'warn = true' assignment before 'return' in the default case is
dead code - WARN_ONCE is never reached when returning early. Remove it.

Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
---
 kernel/sched/ext.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e8384b5f1b0f..4aaa7bf1faa6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2934,7 +2934,6 @@ static void scx_set_task_state(struct task_struct *p, enum scx_task_state state)
 		warn = prev_state != SCX_TASK_READY;
 		break;
 	default:
-		warn = true;
 		return;
 	}
 
-- 
2.25.1

