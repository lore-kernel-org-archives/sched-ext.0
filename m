Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A437A4BC
	for <sched-ext@lists.linux.dev>; Fri, 10 Apr 2026 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803692; cv=none; b=fDMHHrbZj5SpbX3gR+ggJMj+PjZabnUb8YN/FItrrQfHdCFdQnsUVELcI4ZH44UuGQbja8z12SO8UTx5CyKW70/yCV1eWZKUgUcvR/VDUChl8bu7WHGrTXU0E/zOdI0b0teKRSRveIYdcxQDVMRgOD2j5RH4V8tthu7UfjZjmiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803692; c=relaxed/simple;
	bh=1h2YqNJo0GavyU4mracICOaQN+/Vkfdqcp7RITRrETs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PxMEp/Cz3TVp3/yrVK8ZjvXCQuqnplcFKCKfsCLKRbZ0AWVS/gAlO9heGxYLgEEA2SAoc1MPBI73ha9TVkt+EIfLDmv5KpCWMwFRsfSja2IQ/OS6+2c8rPM6imp01186jn6fB/l6ty4HjUX7tQNj8cMloudDdyPge5GYUZy1M9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 34b93e1c34a911f1aa26b74ffac11d73-20260410
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:60f23653-d9c4-49f3-bfa5-c9260a8e803f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:d4b50ce756fe4d1c8db6dcc7ba6ba837,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|850|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 34b93e1c34a911f1aa26b74ffac11d73-20260410
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 126916995; Fri, 10 Apr 2026 14:47:56 +0800
From: fangqiurong@kylinos.cn
To: tj@kernel.org,
	void@manifault.com
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	shuah@kernel.org,
	christian.loehle@arm.com,
	newton@meta.com,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fangqiurong <fangqiurong@kylinos.cn>
Subject: [PATCH] selftests/sched_ext: Fix wrong DSQ ID in peek_dsq error message
Date: Fri, 10 Apr 2026 14:47:53 +0800
Message-Id: <20260410064753.469802-1-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fangqiurong <fangqiurong@kylinos.cn>

The error path after scx_bpf_create_dsq(real_dsq_id, ...) was reporting
test_dsq_id instead of real_dsq_id in the error message, which would
mislead debugging.

Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
---
 tools/testing/selftests/sched_ext/peek_dsq.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/peek_dsq.bpf.c b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
index 96e3a336a8a6..7f23fb17b1e0 100644
--- a/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
+++ b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
@@ -197,7 +197,7 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(peek_dsq_init)
 	}
 	err = scx_bpf_create_dsq(real_dsq_id, -1);
 	if (err) {
-		scx_bpf_error("Failed to create DSQ %d: %d", test_dsq_id, err);
+		scx_bpf_error("Failed to create DSQ %d: %d", real_dsq_id, err);
 		return err;
 	}
 
-- 
2.25.1

