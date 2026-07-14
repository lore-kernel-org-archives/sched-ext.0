Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B07286A7
	for <sched-ext@lists.linux.dev>; Tue, 14 Jul 2026 03:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999263; cv=none; b=Pow8Ebsnus6xG0mmpoV7M0sQ5ip2WBlzI6xZb9KNJaEiBTX/zRLWi0IludiQNB+KVEv+ZfLE2iV6Bz37ARKzkL0fHKMy9hdWjVTiV34VGyKBwt5h+iFdQL1dvAvzgdUMS1Y/KOKS3tDAQMG0Ra8Z5BDVaLUyP/yo9drCNM4zH58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999263; c=relaxed/simple;
	bh=imJj1+N39504qvUUItN2VIC0AAnXvlsLwR+hXt//HQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AbYyvBGXaNLF6CCJXgON7QHDrpj3ja5M2d0aqF3/tLDOt8cr+E5GT9XYL1jb9oBcLvi16cbnQgUY2fXqLG/5MLhmmSsYKhzEcmHaHcU832nld0Qv+bzaYyltBzLkmX+/K0qTwcmuihahyek5FP5tctM8EEafrkEvF1s3w0IK/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 072ac4327f3311f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3585a902-582b-4b34-8eff-5454c50c8ded,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:a771dfdb77db12529ee2df7d029e2667,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|136|850|865|898,TC:nil,Content:0
	|15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 072ac4327f3311f1aa26b74ffac11d73-20260714
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 576022090; Tue, 14 Jul 2026 11:20:56 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH] tools/sched_ext: scx_qmap: Fix stale API name in comment
Date: Tue, 14 Jul 2026 11:20:51 +0800
Message-Id: <20260714032051.1834822-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

The comment above dispatch_highpri() still references
scx_bpf_dispatch[_vtime]_from_dsq(), which was renamed to
scx_bpf_dsq_move[_vtime]() in v6.13 to unload the overloaded
"dispatch" verb. The code below already uses the new names; only the
comment was left behind during the rename.

Fixes: 5cbb302880f5 ("sched_ext: Rename scx_bpf_dispatch[_vtime]_from_dsq*() -> scx_bpf_dsq_move[_vtime]*()")
Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 tools/sched_ext/scx_qmap.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index fd9a82a67627..05f88d819b40 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -495,7 +495,7 @@ static void update_core_sched_head_seq(struct task_struct *p)
  * moving them to HIGHPRI_DSQ and then consuming them first. This makes minor
  * difference only when dsp_batch is larger than 1.
  *
- * scx_bpf_dispatch[_vtime]_from_dsq() are allowed both from ops.dispatch() and
+ * scx_bpf_dsq_move[_vtime]() are allowed both from ops.dispatch() and
  * non-rq-lock holding BPF programs. As demonstration, this function is called
  * from qmap_dispatch() and monitor_timerfn().
  */
-- 
2.43.0

