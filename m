Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C73A6F0F
	for <sched-ext@lists.linux.dev>; Tue,  7 Apr 2026 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775555364; cv=none; b=IvP9pM7YJQm/EOpE8L99czmcybwBN303G+D9KPss6Mos/1Id8Q8jF+0sjheMVFMrYpfDn/T6JwDodj5VtbUk4QNIB6oQ4WRtXCUEuIHXD4wH3tQyg7gJzSPQ/BrGOexoAOYZo2tL9DLNJQ+REKlweMEkrNYQJVx5efz6u2oNpts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775555364; c=relaxed/simple;
	bh=fzcCyw/9umWpvSqx0r/H/r9HB+aOhgq05Y03kko+vaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WmAYYfK9InS34w8efNZJEq3YC9jWu8bUwjozQmzNgTaVnjcr3g1GsyuHIjZS7bzwzuk268aOnb2/dYBSf+xDpe4RLje94FniLAxe6PTDH9gXNCAQ9uQSCGOkbD7KHObIhn+Va7Yje/yK3BSI1XMOmRrgnYPBrDbSdYyesdnXaoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 093738fa326711f1aa26b74ffac11d73-20260407
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0f4b4505-fff3-4d6b-b770-3cf72a4f1ee3,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:3c92cfa91ca0a15833158eba1e3b9314,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|850|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 093738fa326711f1aa26b74ffac11d73-20260407
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1862919251; Tue, 07 Apr 2026 17:49:14 +0800
From: fangqiurong@kylinos.cn
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	arighi@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/ext: Remove redundant else after return in scx_bpf_dsq_move_to_local
Date: Tue,  7 Apr 2026 17:49:11 +0800
Message-Id: <20260407094911.2581120-1-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fangqiurong <fangqiurong@kylinos.cn>

The else branch is unnecessary when the if-block already returns.

Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
---
 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 064eaa76be4b..e8384b5f1b0f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6280,9 +6280,9 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
 		 */
 		dspc->nr_tasks++;
 		return true;
-	} else {
-		return false;
 	}
+
+	return false;
 }
 
 /**
-- 
2.25.1

