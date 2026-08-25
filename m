Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6BB1A23A6
	for <sched-ext@lists.linux.dev>; Tue, 25 Aug 2026 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787637067; cv=none; b=YE5NXzRUk0F0I+1zHJeDeFkqVOi5qzYo7jQSQ1WTCqTfDq2tjJJ4T0j5V/B+TMfWrRDjZ5ShDD2VLeC14lnVZnL5kkKmbOsomYksVc0G4shpKKZXS2s/uovlrmqScMdotq5HrfZDJ0E/+em2vZIu1P61J/3L3aEu3Nk+g08YWiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787637067; c=relaxed/simple;
	bh=35++GzHW33WGcBBNpA0yeknr7a81h3CEzfsdTwy2G9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uDDaCWSOvHXWjwZhQGx3T/WIohK3qydukD+PCeDt/T8Z0Dm1b4PlLWVzSo0YVPUAp/mcpFKtlr2yiGnHcxbmXdiYqzdyWiXK4+V7tCFPznuDqn6HCrWTaYV16LJBdWoQIUkFhhDXXg4abzGq9NWkoC0eNyqqppmAaRH9IiH/eUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f1901d98a04811f19a56ed5b684f684d-20260825
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a61b0d98-fd14-4c7e-93dc-b8b71e5c98ed,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:03cfeaec2479aa533d585bb771cb0461,BulkI
	D:nil,BulkQuantity:0,SF:102|123|850|865|898,TC:nil,Content:0|15|50,EDM:-3,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f1901d98a04811f19a56ed5b684f684d-20260825
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 174054166; Tue, 25 Aug 2026 13:50:57 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH] sched_ext: Fix missing @slice and @vtime descriptions in finish_dispatch() kernel-doc
Date: Tue, 25 Aug 2026 13:50:53 +0800
Message-Id: <20260825055053.2295139-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

Commit 13f1eae3b662 ("sched_ext: Synchronize slice and dsq_vtime
writes") added the slice and vtime parameters to finish_dispatch() but
did not update its kernel-doc, which produces warnings:

  Warning: function parameter 'slice' not described in 'finish_dispatch'
  Warning: function parameter 'vtime' not described in 'finish_dispatch'

Describe both parameters using the same wording as
dispatch_to_local_dsq(), which receives the same values.

Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 kernel/sched/ext/ext.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10af28a9f2c0..a40a6d73b413 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2806,6 +2806,8 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
  * @p: task to finish dispatching
  * @qseq_at_dispatch: qseq when @p started getting dispatched
  * @dsq_id: destination DSQ ID
+ * @slice: slice carried by the insert verdict, 0 keeps the current value
+ * @vtime: vtime carried by the insert verdict, committed on PRIQ inserts
  * @enq_flags: %SCX_ENQ_*
  *
  * Dispatching to local DSQs may need to wait for queueing to complete or
-- 
2.25.1

