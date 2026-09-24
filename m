Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890143CCFAE
	for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260635; cv=none; b=HynrAOy+FLOg7zGXP80PA6xyTq/25M/9gt4Q5AoEgXv8rmeTNYylXDn/FT1PbQbmek643NHoW59BmSjTu8wLECNl3eDOC0p4V7OdfE0aurz35V5GIdDEEj+XAjDVVsNNmxA+mp2jG1x05IiioYfbMseEysNp3VlORMG9LCwDGNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260635; c=relaxed/simple;
	bh=SIBLrDFjoH+OgQlv0pYmuN3/XOHeSF+kUtmvc3OgR3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u13f2Q5Aqrr/IqdUu/8RX2ToZAMJvSVMlD0Tw7K++mJXjuAbuHsZTcLKUSGzb1U4YDhp6qRpZG9+INcRM3PWDWfVdPqriazlC81gqKoV/w+l6Zd4hfsa8qJCo6zdK56Cqjvqj2fnJwrpp7ag7JhNeSd2pmTszbhh/jVN+/lqDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 68b15f2eb82511f19a56ed5b684f684d-20260924
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0af4e205-8bdc-462c-ace2-a7ffca252d22,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:2995fa3ca1e4614609e5649312b1354a,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|865|898,TC:nil,Content:0|15|50|99,ED
	M:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 68b15f2eb82511f19a56ed5b684f684d-20260924
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 10850255; Thu, 24 Sep 2026 22:37:03 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wanwu Li <liwanwu@kylinos.cn>
Subject: [PATCH 2/3] tools/sched_ext: scx_pair: Drain task queue on cgroup exit
Date: Thu, 24 Sep 2026 22:36:58 +0800
Message-Id: <20260924143659.268595-3-liwanwu@kylinos.cn>
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

pair_cgroup_exit() releases a cgroup's queue slot by clearing the
busy marker and deleting the cgid hash entry, but leaves the task
queue (cgrp_q_arr) and its length counter (cgrp_q_len) alone.  The
slot is handed to the next cgroup through pair_cgroup_init() without
any reset, so if the outgoing cgroup left entries behind -- tasks
which exited or migrated away after being enqueued, which scx_pair
never dequeues -- the inheriting cgroup starts with a non-zero
cgrp_q_len.  pair_enqueue() only queues a cgroup on top_q on the
0 -> 1 transition of that counter, so the new cgroup never reaches
top_q and none of its tasks is ever dispatched: the cgroup starves
for the lifetime of the scheduler.

Fix it by draining the queue and taking the length counter to zero
with it, claiming each entry just as try_dispatch() does before
popping so that the drain cannot race an in-flight dispatcher into
a fatal pop failure.  All pids left behind are stale so dropping
them is safe.

Fixes: f0262b102c7c ("tools/sched_ext: add scx_pair scheduler")
Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
---
 tools/sched_ext/scx_pair.bpf.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/sched_ext/scx_pair.bpf.c b/tools/sched_ext/scx_pair.bpf.c
index 0d61b7b812db..a1fe67fdaf5c 100644
--- a/tools/sched_ext/scx_pair.bpf.c
+++ b/tools/sched_ext/scx_pair.bpf.c
@@ -633,6 +633,34 @@ void BPF_STRUCT_OPS(pair_cgroup_exit, struct cgroup *cgrp)
 
 	q_idx = bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
 	if (q_idx) {
+		struct cgrp_q *cgq;
+		s32 pid;
+		u64 *cgq_len;
+
+		/*
+		 * All tasks have left the cgroup by the time it exits, so
+		 * the pids left behind are stale; drain the queue and take
+		 * the length counter down with them -- the next cgroup
+		 * inheriting this slot must see its first enqueue go
+		 * 0 -> 1 or it never reaches top_q.  Each pop claims a
+		 * counter slot as try_dispatch() does, so that the drain
+		 * can't steal an entry from an in-flight dispatcher and
+		 * trip its scx_bpf_error().
+		 */
+		cgq = bpf_map_lookup_elem(&cgrp_q_arr, q_idx);
+		cgq_len = MEMBER_VPTR(cgrp_q_len, [*q_idx]);
+		if (cgq && cgq_len)
+			bpf_repeat(BPF_MAX_LOOPS) {
+				u64 len = *(volatile u64 *)cgq_len;
+
+				if (!len)
+					break;
+				if (__sync_val_compare_and_swap(cgq_len, len, len - 1) != len)
+					continue;
+				if (bpf_map_pop_elem(cgq, &pid))
+					break;
+			}
+
 		u64 *busy = MEMBER_VPTR(cgrp_q_idx_busy, [*q_idx]);
 		if (busy)
 			*busy = 0;
-- 
2.25.1
