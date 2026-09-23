Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CF149D5B7
	for <sched-ext@lists.linux.dev>; Wed, 23 Sep 2026 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161672; cv=none; b=sEQPe6ENb17H1MjakaNwBUZEtyabF0D2DWSoi3yQ8A8DJJuQyNTWdT4DXMqL45fQO+YZfDT5EYB/Bgghf+Yh1M2R7n2i96q4gMDtU5ht7LDjIVAHJVP9YBY8BWoqvz7yvMp1alVTSQv8Twf0Kqh+bpurcEXfO+yKpJFwrj9BHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161672; c=relaxed/simple;
	bh=q05q06xrOZWDzoeeLkgXU128/uUDN8mIilVBA9NlWIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QVhMoZJpBhzpT0Iv1D6TjaX12mcWRK57iGReUpmatc/NZGPZ1vO6ktHeB1zBtiO3UVBA5wp7qUG/XqFK8u27vo1eHueS/fLeYlNi8kXx+1ACMXc2Rlp1bx2Lyza+BFjV000tt0/4GKM52s0CPxih//w35SguoTsF1ydJiT40UJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ff52e5c0b73e11f19a56ed5b684f684d-20260923
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ed170b95-82a7-4610-85e1-6326cd94c295,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:92b57fb9d887d4870761cf701b69c6bb,BulkI
	D:nil,BulkQuantity:0,SF:102|123|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ff52e5c0b73e11f19a56ed5b684f684d-20260923
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1437407162; Wed, 23 Sep 2026 19:07:42 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH] sched_ext: Count SCX_EV_SUB_BYPASS_DISPATCH in the dispatch fallback
Date: Wed, 23 Sep 2026 19:07:37 +0800
Message-Id: <20260923110737.2170928-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

When a descendant scheduler enters bypass mode, its tasks are parked in
the bypass DSQs of the nearest non-bypassing ancestor, which is then
responsible for running them. On behalf of such a non-bypassing host,
scx_dispatch_sched() consumes those bypass DSQs from two places: the
attempt made every SCX_BYPASS_HOST_NTH dispatches, and the
end-of-dispatch fallback that keeps the CPU from going idle while
bypassed descendants still have tasks queued.

The former increments SCX_EV_SUB_BYPASS_DISPATCH but the latter does
not, even though both perform the same scx_consume_dispatch_q() on the
same bypass DSQ. The descendant bypass dispatches done by the fallback
are therefore missing from the counter exposed via sysfs,
scx_dump_state() and the scx_bpf_events() kfunc, which under-reports the
actual number of such dispatches.

Add the missing __scx_add_event() so the fallback counts them too. When
@sch itself is bypassing, scx_dispatch_sched() takes the earlier
self-bypass branch and returns before reaching these host paths; that
mode is accounted for by SCX_EV_BYPASS_DISPATCH at enqueue time and is
intentionally left unchanged.

Fixes: 025b1bd41965 ("sched_ext: Implement hierarchical bypass mode")
Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 kernel/sched/ext/inlines.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/inlines.h b/kernel/sched/ext/inlines.h
index ed423bcc26b8..2ff5479334cb 100644
--- a/kernel/sched/ext/inlines.h
+++ b/kernel/sched/ext/inlines.h
@@ -129,8 +129,10 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	 * scheduler's ops.dispatch() doesn't yield any tasks.
 	 */
 	if (scx_bypass_dsp_enabled(sch) &&
-	    scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), 0))
+	    scx_consume_dispatch_q(sch, rq, scx_bypass_dsq(sch, cpu), 0)) {
+		__scx_add_event(sch, SCX_EV_SUB_BYPASS_DISPATCH, 1);
 		return SCX_DSP_LOCAL;
+	}
 
 	return SCX_DSP_NONE;
 }
-- 
2.43.0

