Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C397531715A
	for <sched-ext@lists.linux.dev>; Fri, 31 Jul 2026 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465018; cv=none; b=HJN6hZ8y0hEbSXYuxgOmdBNpBbDFNqTrohe+emaufrO/zHQT5eRcMeMnPpXlw38Om//Nq8Ugtng0w6HUyi3OyIf+H5st4LF09WjPX3G0RrktRLU1CeFgIr/KihgjeLnFqZOGqWKXDQhqxpVXqM2TKD6yWtnsUMxxrA8n4LDhr9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465018; c=relaxed/simple;
	bh=hvA1K2S2totpRjIStelT6r6Zihmoa8RBG576T0AaCVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uXn4jiS1YERd72eDQUVchFXdf0VoibW/Xq1u5fu9UIoi0mkoAjSPlFv/eU+uueLszapUur0aAiGnF1wSWqzrhFnc8gymtXbb5F5OCE/HIIHWWgkfRss+ZP+ugLqoJvIuiZjOPwSkWNrILIQ/dqPN2H+VNRB5/c6X6b805Z3qiE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bf8d20fe8c8711f1aa26b74ffac11d73-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b7c03d32-603c-4bdc-b37c-2553b5900c49,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:84bbd42c76f2b322247797c5dfb46e1a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bf8d20fe8c8711f1aa26b74ffac11d73-20260731
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1147927624; Fri, 31 Jul 2026 10:30:08 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH] sched_ext: Fix stale @cgroup_id in sched_ext_ops kernel-doc
Date: Fri, 31 Jul 2026 10:30:04 +0800
Message-Id: <20260731023004.1062947-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

The kernel-doc comment for sched_ext_ops::sub_cgroup_id uses the old
@cgroup_id name, which no longer matches the struct member. This
produces two kernel-doc warnings:

  Warning: struct member sub_cgroup_id not described in sched_ext_ops
  Warning: Excess struct member cgroup_id description in sched_ext_ops

Update the @param name to match the actual member.

Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 kernel/sched/ext/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 673059fa9d72..9145adcb9589 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -809,7 +809,7 @@ struct sched_ext_ops {
 	u64 hotplug_seq;
 
 	/**
-	 * @cgroup_id: When >1, attach the scheduler as a sub-scheduler on the
+	 * @sub_cgroup_id: When >1, attach the scheduler as a sub-scheduler on the
 	 * specified cgroup.
 	 */
 	u64 sub_cgroup_id;
-- 
2.43.0

