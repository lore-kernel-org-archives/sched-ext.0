Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761283845B0
	for <sched-ext@lists.linux.dev>; Wed, 19 Aug 2026 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787109181; cv=none; b=kLI4iPh9+ezE+nQu+y0exbgT3RR/ecBhjSu1EDZBO21OT9lg8uFRpcbuY15d5ERT5J4aoL5qA53uOmiNF19BVpItBHtPZb3zz2wUDMPGjO/5GHaI/91g74sm8RSjWeIZQkrveeh8NuY1pULtY8qeBqG9H/dhTbead032fShQ9H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787109181; c=relaxed/simple;
	bh=2QjuidKP6eexRE9LYaMRC5TleDJm4t+IPnedd6ltN48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LyxLBzjioEN8kvc9VGvQGJ0yuUV/GG49awACJT2Sw2QYh7sd5ajYILkj9fnbJqLXi8sTwj/8F/5lKRMhQ4NWPiVFSNPmWmaOJX1tpSX76RcV+W3WbugOhSMwTYuUxNEgZ/6gBP+396w92dNV22spwlttiCe6jSg+FrTCLb8C31A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dd64324a9b7b11f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0c2070be-5550-4929-9b3d-a5181043b2eb,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:fb5acf10af2571136c0ea83ef1103ae4,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|123|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dd64324a9b7b11f19a56ed5b684f684d-20260819
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 71192582; Wed, 19 Aug 2026 11:12:52 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH 1/2] Docs/admin-guide/cgroup-v2: document BPF scheduler callbacks for cpu.max and cpu.idle
Date: Wed, 19 Aug 2026 11:12:43 +0800
Message-Id: <20260819031244.178638-2-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819031244.178638-1-luoliang@kylinos.cn>
References: <20260819031244.178638-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

The cpu.weight and cpu.weight.nice entries already state that the files
also affect a BPF scheduler through the cgroup_set_weight callback.
However, cpu.max, cpu.max.burst and cpu.idle only mention the fair-class
scheduler, even though sched_ext implements the cgroup_set_bandwidth
(notified with the period/quota from cpu.max and the burst from
cpu.max.burst) and cgroup_set_idle callbacks from these interfaces.

Mirror the cpu.weight wording for the three entries so BPF scheduler
users can discover these notification points.

Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 Documentation/admin-guide/cgroup-v2.rst | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index aed195a71cbf..3f77f15d0543 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1202,7 +1202,9 @@ will be referred to. All time durations are in microseconds.
 	$PERIOD duration.  "max" for $MAX indicates no limit.  If only
 	one number is written, $MAX is updated.
 
-	This file affects only processes under the fair-class scheduler.
+	This file affects only processes under the fair-class scheduler and a BPF
+	scheduler with the ``cgroup_set_bandwidth`` callback depending on what
+	the callback actually does.
 
   cpu.max.burst
 	A read-write single value file which exists on non-root
@@ -1210,7 +1212,9 @@ will be referred to. All time durations are in microseconds.
 
 	The burst in the range [0, $MAX].
 
-	This file affects only processes under the fair-class scheduler.
+	This file affects only processes under the fair-class scheduler and a BPF
+	scheduler with the ``cgroup_set_bandwidth`` callback depending on what
+	the callback actually does.
 
   cpu.pressure
 	A read-write nested-keyed file.
@@ -1262,7 +1266,9 @@ will be referred to. All time durations are in microseconds.
 	own relative priorities, but the cgroup itself will be treated as
 	very low priority relative to its peers.
 
-	This file affects only processes under the fair-class scheduler.
+	This file affects only processes under the fair-class scheduler and a BPF
+	scheduler with the ``cgroup_set_idle`` callback depending on what the
+	callback actually does.
 
 Memory
 ------
-- 
2.43.0

