Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107B5332ED6
	for <sched-ext@lists.linux.dev>; Wed,  3 Jun 2026 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477285; cv=none; b=jWA9jW1qO1M0N3jZTBVziV6O784zjBYXVUnuOLFk5KpFNG3ZBEXMfpHy2P6Jh21Z5k/DTXK3W15YKwBdZGS5xQLVhvD1XNC/pGxRONsAsuk1tzbPgKbnjs9ORIXYS2vs60CVLFFPFvja0aUJftCWDudVZroxJJjt1+82uE4WdYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477285; c=relaxed/simple;
	bh=G1fIEdNONzxdA3zDHKtNurIIfdPJq84k5sXJlYm0xzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ljbKF2IIsDn64xMvtDSkFkmdK8Lj/UN/9W2Ov/8VdI0ZIFEKAFzPxz3lOHeq6YN9KKrJPazntO3Xkhn65WgGMYyO+gVBvhWxi1Clg1voKlN1bGxTZYQCRMZTIJcH3dwg6VYt8E6PvjngqeSkpBAC56MoourngJALSeXgj2nhWfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c5ba111a5f2a11f1aa26b74ffac11d73-20260603
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:44410617-16e2-447a-9294-756fd9383c88,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:5abcc23c39efe4e447567de6ae2951c0,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|136|850|865|898,TC:nil,Content:0
	|15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c5ba111a5f2a11f1aa26b74ffac11d73-20260603
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 858301019; Wed, 03 Jun 2026 17:01:13 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Carlier <devnexen@gmail.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomengmeng@kylinos.cn>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH] tools/sched_ext: scx_flatcg: Document cgroup v2 requirement
Date: Wed,  3 Jun 2026 17:01:06 +0800
Message-Id: <20260603090106.2494243-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

The BPF program relies on cgroup v2-specific features - specifically
BPF_MAP_TYPE_CGRP_STORAGE and cgroup v2 kfuncs (bpf_cgroup_ancestor,
bpf_cgroup_from_id, scx_bpf_task_cgroup, ...), none of which are
available on cgroup v1. The current file header describes the
algorithm but does not make this runtime requirement explicit, so
users running on a cgroup v1-only system get a confusing BPF load
error with no clear pointer to the cause.

Document the requirement in a Note paragraph at the end of the file
header so that it is visible to anyone reading the source.

No functional change.

Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 tools/sched_ext/scx_flatcg.bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index fec359581826..067e1a7991d4 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -42,6 +42,9 @@
  * The scheduler first picks the cgroup to run and then schedule the tasks
  * within by using nested weighted vtime scheduling by default. The
  * cgroup-internal scheduling can be switched to FIFO with the -f option.
+ *
+ * Note: Requires cgroup v2 (uses BPF_MAP_TYPE_CGRP_STORAGE and cgroup v2
+ * BPF kfuncs, neither of which are available on cgroup v1).
  */
 #include <scx/common.bpf.h>
 #include "scx_flatcg.h"
-- 
2.25.1

