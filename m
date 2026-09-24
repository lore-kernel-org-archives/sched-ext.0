Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903FB3CD8BD
	for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260634; cv=none; b=SS+urlQ8iqKlOQOL1ICDGo0+G1IPZEOF8MDNurJRSkJnmKjFmdufa8jsMEaxdU3I6+aBbFJ4ZzvxhFguyO0JNHaqynOtYDG59YDKxONgZbuj47+9HJlf84YrpJ9yUS4ptY69yIXR4OigSPjl0QBGPCMD1YRnJ/c1r5VFD/fGLks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260634; c=relaxed/simple;
	bh=Fz6Z4Nr3SvSvPAGfiReuOCC+epviMAhVLZWi1F7has4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EmIhjk68tHsQQt2uO8L4VZfbMqeKtcn0dPzenNdZqIppxGcaoPrLDcj0ypeoFMF+BmFRxMAPZNPdzEhyV/008hOuJ1LCNjVnCuZG6cCdbM7rcB7cfKfa1/lx6BlUMzJLANxhkuiDqRA2z+oCQ/dIAlnBDiD8iUrMHY7NW1NaM9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 69031bc0b82511f19a56ed5b684f684d-20260924
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b86fd2c7-25a0-44b8-9617-bc6141950bcc,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:7db8b62,CLOUDID:d43faa7a03634a1e1c5300030383f3a6,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|865|898,TC:nil,Content:0|15|50|99,ED
	M:44|-19|2|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_EDM_RNO
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 69031bc0b82511f19a56ed5b684f684d-20260924
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1343200725; Thu, 24 Sep 2026 22:37:04 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wanwu Li <liwanwu@kylinos.cn>
Subject: [PATCH 3/3] tools/sched_ext: scx_pair: Verify task cgroup before dispatch
Date: Thu, 24 Sep 2026 22:36:59 +0800
Message-Id: <20260924143659.268595-4-liwanwu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260924143659.268595-1-liwanwu@kylinos.cn>
References: <20260924143659.268595-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pair_enqueue() pushes a task's pid into the FIFO for the cgroup it
was in at enqueue time.  scx_pair has no .dequeue callback and no
.cgroup_move callback, so when a task migrates to another cgroup
between enqueue and dispatch, its stale pid remains in the old
cgroup's FIFO.

try_dispatch() pops such a stale pid, bpf_task_from_pid() returns
the (alive) task, and scx_bpf_dsq_insert() dispatches it under the
old cgroup's context.  This violates the pair scheduler's core
invariant: paired CPUs must only run tasks from the same cgroup.

Fix it by reading the task's current cgroup after
bpf_task_from_pid() and comparing it against the cgid the pair is
dispatching for.  A mismatch means the task migrated away; drop it
and retry, mirroring the existing lost-task path.

Fixes: f0262b102c7c ("tools/sched_ext: add scx_pair scheduler")
Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
---
 tools/sched_ext/scx_pair.bpf.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/sched_ext/scx_pair.bpf.c b/tools/sched_ext/scx_pair.bpf.c
index 0d61b7b812db..05658d5dc796 100644
--- a/tools/sched_ext/scx_pair.bpf.c
+++ b/tools/sched_ext/scx_pair.bpf.c
@@ -519,6 +519,25 @@ static int try_dispatch(s32 cpu)
 
 	p = bpf_task_from_pid(pid);
 	if (p) {
+		struct cgroup *task_cgrp;
+		u64 task_cgid;
+
+		/*
+		 * Without a .dequeue callback, a task that migrated to
+		 * another cgroup after being enqueued leaves a stale pid
+		 * behind. Dispatching it here would run it under the wrong
+		 * cgroup. Drop it and retry.
+		 */
+		task_cgrp = scx_bpf_task_cgroup(p);
+		task_cgid = task_cgrp->kn->id;
+		bpf_cgroup_release(task_cgrp);
+
+		if (task_cgid != cgid) {
+			bpf_task_release(p);
+			__sync_fetch_and_add(&nr_missing, 1);
+			return -EAGAIN;
+		}
+
 		__sync_fetch_and_add(&nr_dispatched, 1);
 		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
 		bpf_task_release(p);
-- 
2.25.1

