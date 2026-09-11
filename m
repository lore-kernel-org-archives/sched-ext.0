Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4493D9530
	for <sched-ext@lists.linux.dev>; Fri, 11 Sep 2026 02:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789094599; cv=none; b=jD5Z3Pajr2ieHjgtYgh0q9VQPabUa9l26d3Zfocut/acR54wh8JW4BE3CYdFeF0q+3T7gAaEkuhGS2iDoz7Rjm25e/jA7n9X3TNtZ6UA25ERNSmAwptOtFkw4UrAhhRpx1/HXXH4mq8uSEYDZtTtfZhaOSTjYBpExWZqGDR3QkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789094599; c=relaxed/simple;
	bh=hUPE1bdCKDwWiRFRzL9edTj+ovAH6LjQvCi+MCSu0LE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QkAwVt725UMaRUKku3cE9ko4Pyl5u1tW1kNtSUzx6OKWxZzx5MtSuzFs1ZaZ0aFBWNzGL/t2mH6aKHkVFRpqj5JOF5PRIE7wZ6OvVXLdkBEVmqG8svNqOtQJ+hyad+rb69CRFSYUTRUjSsR/2L06VpqutTsAwbBdeX9wQ7S1VUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 871ba92ead8a11f19a56ed5b684f684d-20260911
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2ee4b41e-827a-41a0-bc02-59c6d5d72191,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-45
X-CID-META: VersionHash:7db8b62,CLOUDID:78d31d3c1e458565b743d876c978d37c,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|850|865|898,TC:nil,Content:0|15|50|9
	9,EDM:-19|2|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 871ba92ead8a11f19a56ed5b684f684d-20260911
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1452422760; Fri, 11 Sep 2026 10:43:10 +0800
From: Qiurong Fang <fangqiurong@kylinos.cn>
To: tj@kernel.org
Cc: sched-ext@lists.linux.dev,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Subject: [PATCH v2] sched_ext: Close the pre-enable ops error claim window
Date: Fri, 11 Sep 2026 10:42:56 +0800
Message-Id: <20260911024256.125287-1-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260910084533.2420199-1-fangqiurong@kylinos.cn>
References: <20260910084533.2420199-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fangqiurong <fangqiurong@kylinos.cn>

scx_alloc_and_add_sched() publishes ops->priv before
scx_root_enable_workfn() switches the state to SCX_ENABLING. An error
claimed via scx_bpf_error_bstr() from an associated BPF program in that
window is consumed by scx_disable_workfn(), which takes the pre-enable
shortcut in scx_root_disable(). The shortcut returns without any
teardown and restores SCX_DISABLED with an unconditional
scx_set_enable_state() xchg racing the enable workfn's own transition.
The enable then completes with the claim consumed: the scheduler stays
up but can never be disabled again, and bpf_scx_unreg() frees it while
still in use, resulting in a use-after-free. Both WARN_ON_ONCE()s fire
back to back:

  WARNING: kernel/sched/ext/ext.c:7522 at scx_root_enable_workfn+0xeec/0x1be0, CPU#3: scx_enable_help/276
  WARNING: kernel/sched/ext/ext.c:6398 at scx_root_disable+0xb50/0xdb8, CPU#0: sched_ext_helpe/664

scx_root_enable_workfn() switches to SCX_ENABLING before the
allocation, so ops->priv is never visible while SCX_DISABLED and
claimed errors get the regular scx_root_disable() teardown serialized
on scx_enable_mutex behind the in-flight enable. 

Fixes: 105dcd005be2 ("sched_ext: Introduce scx_prog_sched()")
Cc: stable@vger.kernel.org
Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
---

Changes since v1:
 - Drop the conditional restore in the pre-enable shortcut and the
   tryset/-EBUSY branch on the moved transition; both failure paths are
   unreachable once SCX_ENABLING precedes ops->priv publication
   (Tejun Heo).
 - Keep the allocation failure reset.
 kernel/sched/ext/ext.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10af28a9f2c0..479ae257ea7c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7506,22 +7506,23 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 #ifdef CONFIG_EXT_SUB_SCHED
 	cgroup_get(cgrp);
 #endif
+	/*
+	 * Transition to ENABLING and clear exit info to arm the disable path.
+	 * Failure triggers full disabling from here on.
+	 */
+	WARN_ON_ONCE(scx_set_enable_state(SCX_ENABLING) != SCX_DISABLED);
+	WARN_ON_ONCE(scx_root);
+
 	sch = scx_alloc_and_add_sched(cmd, cgrp, NULL);
 	if (IS_ERR(sch)) {
 		ret = PTR_ERR(sch);
+		scx_tryset_enable_state(SCX_DISABLED, SCX_ENABLING);
 		goto err_free_tid_hash;
 	}
 
 	if (sch->is_cid_type)
 		static_branch_enable(&__scx_is_cid_type);
 
-	/*
-	 * Transition to ENABLING and clear exit info to arm the disable path.
-	 * Failure triggers full disabling from here on.
-	 */
-	WARN_ON_ONCE(scx_set_enable_state(SCX_ENABLING) != SCX_DISABLED);
-	WARN_ON_ONCE(scx_root);
-
 	atomic_long_set(&scx_nr_rejected, 0);
 
 	for_each_possible_cpu(cpu) {
-- 
2.43.0

