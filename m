Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FEB340401
	for <sched-ext@lists.linux.dev>; Thu, 27 Aug 2026 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818074; cv=none; b=K60ezHCkTUBX1iwtt2XUE2wKrPYEf0OhDu3rnh9Fy864jNlHSbLSWNpqFcp2KLXbUdZPhs5JWIo26/qDnBSeZtaFc+aFpDLgeDzQ41Fhm9PhbY80D5ufp4qnCcjwhQQ3b0n0fjK3Ftpe7fxFrLXIdp+DrndBSQ7jp485uaOgq6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818074; c=relaxed/simple;
	bh=l0WGRDYPQyeNPAdok/S3yyQr+tWsrY09QwEI6xb57lE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Js3/YMeoX3x/qju+ujghQySW4HBi3S+7HlMBKLeOQijo0pkZdOf8Qfsph8/mlyWhnyrJfcd9iRUdRWh+YmebCo4xkylFV144UUQXw5wmaCfp9G5ca2bQh3l2IyaqshYxwfoR477Zzq5dc69ppzYVD2X9F65vgM1cdQKoccyWrlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 60a2d45ea1ee11f19a56ed5b684f684d-20260827
X-CID-CACHE: Type:Local,Time:202608271603+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:dd9acc03-49a5-4fc5-bfee-ca0e28bc3dd4,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:7db8b62,CLOUDID:14058bf1c06be5fcae16e6403fe6b496,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50,EDM:1|-10
	0,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 60a2d45ea1ee11f19a56ed5b684f684d-20260827
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1974656026; Thu, 27 Aug 2026 16:07:42 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Wanwu Li <liwanwu@kylinos.cn>
Subject: [PATCH] sched_ext: Check bpf_timer_start return values in scx_qmap
Date: Thu, 27 Aug 2026 16:07:38 +0800
Message-Id: <20260827080738.829103-3-liwanwu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260827080738.829103-1-liwanwu@kylinos.cn>
References: <20260827080738.829103-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

monitor_timerfn(), lowpri_timerfn() and round_robin_timerfn() ignore
bpf_timer_start()'s return value: a failed re-arm silently stops the
periodic heartbeat, starving every task parked in LOWPRI_DSQ (lowpri)
or freezing cid rotation (round-robin).  Check the returns and raise
scx_bpf_error(), matching the init paths.

Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
---
 tools/sched_ext/scx_qmap.bpf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 5bb8b90a275a..9f6e61d7ca07 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -1246,7 +1246,8 @@ static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
 			   scx_read_event(&events, SCX_EV_BYPASS_ACTIVATE));
 	}
 
-	bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
+	if (bpf_timer_start(timer, ONE_SEC_IN_NS, 0))
+		scx_bpf_error("failed to re-arm stats timer");
 	return 0;
 }
 
@@ -1268,7 +1269,8 @@ struct {
 static int lowpri_timerfn(void *map, int *key, struct bpf_timer *timer)
 {
 	scx_bpf_dsq_reenq(LOWPRI_DSQ, 0);
-	bpf_timer_start(timer, LOWPRI_INTV_NS, 0);
+	if (bpf_timer_start(timer, LOWPRI_INTV_NS, 0))
+		scx_bpf_error("failed to re-arm lowpri timer");
 	return 0;
 }
 
@@ -1747,7 +1749,8 @@ static void rr_advance(void)
 static int round_robin_timerfn(void *map, int *key, struct bpf_timer *timer)
 {
 	rr_advance();
-	bpf_timer_start(timer, round_robin_ns, 0);
+	if (bpf_timer_start(timer, round_robin_ns, 0))
+		scx_bpf_error("failed to re-arm round-robin timer");
 	return 0;
 }
 
-- 
2.25.1

