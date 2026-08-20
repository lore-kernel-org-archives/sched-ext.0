Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10D22F549F
	for <sched-ext@lists.linux.dev>; Thu, 20 Aug 2026 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787193476; cv=none; b=hbvthE06LXGyBvy/zBngYqFihFbe0JoDX9VoyPSvGe5tyH7JQetgyEgHPWJBLjSvynyQZpQjH/YabUtVhrroUXePm8M87VxQr6ayxN2DgixsQDtY4CioDVrKbHdAV8wOvIrf5W0OXwkkUnw4lpVzhVlyqX6DhQ/UJpvdfxgADwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787193476; c=relaxed/simple;
	bh=0L4PfZG7E0vwtJtXjxRrvcdqzzZE4NpMVy97GHRGjx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cDU3ZsBCIBlE20QvLSn40QZunz/6S8hdnCiORetw5HqY3abHdbD4QxwTMnQrsmNvJkC06fas/mPlba79BZVZGibr1leu84YuQ8tPM5kHB8qZV0EqDNiyEV+UC1NdUwHmcrkrzSzIeyu0zpLIb331GHYXadOxyHilVN7+RNX81c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 21fbbe909c4011f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b6d8eedb-761b-4a81-a2d8-4048c7b19469,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:46403b67e802efdec153145319f3bd91,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|123|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 21fbbe909c4011f19a56ed5b684f684d-20260820
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1183335667; Thu, 20 Aug 2026 10:37:48 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH v2] Docs/admin-guide/cgroup-v2: document BPF scheduler callbacks for cpu.max and cpu.idle
Date: Thu, 20 Aug 2026 10:37:44 +0800
Message-Id: <20260820023744.2005150-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819031244.178638-2-luoliang@kylinos.cn>
References: <20260819031244.178638-2-luoliang@kylinos.cn>
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

Mirror the cpu.weight wording for the three entries and generalize the
category preamble to refer to the corresponding cgroup_set_* callback so
it keeps covering the entries below.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Liang Luo <luoliang@kylinos.cn>

---
v2: Generalize the category preamble to the corresponding cgroup_set_*
callback so it keeps covering the entries below, per Tejun's review.

 Documentation/admin-guide/cgroup-v2.rst | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index aed195a71cbf..3dc6889ebdb2 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1130,9 +1130,9 @@ policy and the underlying scheduler. From the point of view of the cpu controlle
 processes can be categorized as follows:
 
 * Processes under the fair-class scheduler
-* Processes under a BPF scheduler with the ``cgroup_set_weight`` callback
+* Processes under a BPF scheduler with the corresponding ``cgroup_set_*`` callback
 * Everything else: ``SCHED_{FIFO,RR,DEADLINE}`` and processes under a BPF scheduler
-  without the ``cgroup_set_weight`` callback
+  without the corresponding ``cgroup_set_*`` callback
 
 For details on when a process is under the fair-class scheduler or a BPF scheduler,
 check out :ref:`Documentation/scheduler/sched-ext.rst <sched-ext>`.
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

