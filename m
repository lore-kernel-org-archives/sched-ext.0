Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BF3411661
	for <sched-ext@lists.linux.dev>; Tue, 11 Aug 2026 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435926; cv=none; b=mVyYPr26PVluhq8s4WI9/MkSVTyXznM//7HmfDfOYAcw7t+YJX/Uv7jK8kyE1LoxdQ8m728FeghWiJHOHnfxJ3SSNpleiiVFupePZAFED/QOKvq5rIjQC4Hwi4Ngbxj4jeu/1bqUhoPiTLons7+xNElc8uxrODQNDikhHFI87RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435926; c=relaxed/simple;
	bh=ZoabJPJqAKRZQ9hg/TOuOksqg5OSZ2PQIG2m/E9ggMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i1KtnoSugtW7O9/YSmApubaBaE2gkyD5EWQTTv5SgEtVSIt27QL3idCyO1pa3XBlXJIp+J3D89oeXS2x99XzMDo/jvLTaICXdTxMZlualy42UHhYtM5J6aAkN/doXJagjt4mojhcbauhJu5BaxVo+DwoTQaNOvVBdHkb4tSkM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 526a955a955c11f1aa26b74ffac11d73-20260811
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:05ad737a-9290-4729-848e-9651246b62a2,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:4136d58b3a1d7fc56c3e298e78e20a61,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 526a955a955c11f1aa26b74ffac11d73-20260811
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 373315854; Tue, 11 Aug 2026 16:11:57 +0800
From: Qiurong Fang <fangqiurong@kylinos.cn>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	fangqiurong <fangqiurong@kylinos.cn>
Subject: [PATCH] sched_ext: Fix scx_bpf_dsq_move_to_local___v2 compat detection
Date: Tue, 11 Aug 2026 16:11:43 +0800
Message-Id: <20260811081143.578573-1-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fangqiurong <fangqiurong@kylinos.cn>

libbpf strips the last ___flavor suffix when resolving kfunc externs, so
the bare ___v2 declaration resolves to scx_bpf_dsq_move_to_local, whose
BTF proto lacks @enq_flags. The extern never matches, bpf_ksym_exists()
returns false on every kernel that has the ___v2 kfunc, and the macro
falls back to ___v1, silently dropping @enq_flags.

Add the trailing ___compat suffix used by the other versioned externs in
this file (scx_bpf_dsq_insert___v2, scx_bpf_reenqueue_local___v2).

scx_qmap passes needs_immed() as @enq_flags, so on time-shared cids the
SHARED_DSQ draining move currently drops SCX_ENQ_IMMED.

Fixes: e01a940b4813 ("sched_ext: Add enq_flags to scx_bpf_dsq_move_to_local()")
Assisted-by: Z.ai:glm-5.2
Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
---
 tools/sched_ext/include/scx/compat.bpf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index cf469d5ff9ca..34eeb03afa2f 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -31,7 +31,7 @@ struct cgroup *scx_bpf_task_cgroup___new(struct task_struct *p) __ksym __weak;
  *
  * v7.1: scx_bpf_dsq_move_to_local___v2() to add @enq_flags.
  */
-bool scx_bpf_dsq_move_to_local___v2(u64 dsq_id, u64 enq_flags) __ksym __weak;
+bool scx_bpf_dsq_move_to_local___v2___compat(u64 dsq_id, u64 enq_flags) __ksym __weak;
 bool scx_bpf_dsq_move_to_local___v1(u64 dsq_id) __ksym __weak;
 void scx_bpf_dsq_move_set_slice___new(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
 void scx_bpf_dsq_move_set_vtime___new(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
@@ -45,8 +45,8 @@ bool scx_bpf_dispatch_from_dsq___old(struct bpf_iter_scx_dsq *it__iter, struct t
 bool scx_bpf_dispatch_vtime_from_dsq___old(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 
 #define scx_bpf_dsq_move_to_local(dsq_id, enq_flags)				\
-	(bpf_ksym_exists(scx_bpf_dsq_move_to_local___v2) ?			\
-	 scx_bpf_dsq_move_to_local___v2((dsq_id), (enq_flags)) :		\
+	(bpf_ksym_exists(scx_bpf_dsq_move_to_local___v2___compat) ?		\
+	 scx_bpf_dsq_move_to_local___v2___compat((dsq_id), (enq_flags)) :	\
 	 (bpf_ksym_exists(scx_bpf_dsq_move_to_local___v1) ?			\
 	  scx_bpf_dsq_move_to_local___v1((dsq_id)) :				\
 	  scx_bpf_consume___old((dsq_id))))
-- 
2.43.0

