Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2933CB544
	for <sched-ext@lists.linux.dev>; Fri, 24 Jul 2026 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784880526; cv=none; b=nHV8J+rhjp6IWDBPEntkk0EKKRUEI/V9PlmTEqBuxxDBPOu3DRd9ahP082WkNcdjof1Qr9nWdN7OyoEieCTgvvoq1PMCejtEPeTXVjyOKOaI+c3H3A2OsFyVNibghuUlHbBCOOfNfNkshHxoCWPl2PouAkcOJwB/tmlFpNYfoTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784880526; c=relaxed/simple;
	bh=O86RicdFStfo5mxExHlM3c9GvksAJlrnlskL0EJpE8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=slSMra/dhm1GQYvdodDK17nXKGn5gzsax6B9KTBN/rf9Yox4hx7zCZX3TD/Gs89eAIKH7XAhtRW4Xumh9t4byS0x6epEQfqS8EAssgER65uCG+vGf7tgsVy8nDiEXP9xcHuvoEawCRmKwsvESZ7QEFXAzht9ryvHNZ8YQHiWm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: da7e062c873611f1aa26b74ffac11d73-20260724
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a23b71f7-e8aa-4fde-957d-35e711556b59,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:0a2b2bf4b04257b66df7bb0150cda503,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: da7e062c873611f1aa26b74ffac11d73-20260724
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1325976147; Fri, 24 Jul 2026 16:08:28 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH] sched_ext: Fix incorrect SCX_PICK_IDLE_CPU_* flag prefix in kernel-doc
Date: Fri, 24 Jul 2026 16:08:24 +0800
Message-Id: <20260724080824.2483100-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

The flags passed to the pick-idle kfuncs are values from the
scx_pick_idle_cpu_flags enum, whose members are prefixed
SCX_PICK_IDLE_ (SCX_PICK_IDLE_CORE, SCX_PICK_IDLE_IN_NODE).

Three kernel-doc comments in idle.c erroneously used
%SCX_PICK_IDLE_CPU_* which does not correspond to any defined flag
name, while the adjacent scx_bpf_pick_idle_cpu_node() correctly
documents %SCX_PICK_IDLE_*.

Fix the three occurrences to use the correct SCX_PICK_IDLE_* prefix.

Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 kernel/sched/ext/idle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index 16ebe3ab8647..079a47ca8c2f 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -1352,7 +1352,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(const struct cpumask *cpus_allowed,
 /**
  * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
  * @cpus_allowed: Allowed cpumask
- * @flags: %SCX_PICK_IDLE_CPU_* flags
+ * @flags: %SCX_PICK_IDLE_* flags
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Pick and claim an idle cpu in @cpus_allowed. Returns the picked idle cpu
@@ -1399,7 +1399,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
  *			       or pick any CPU from @node
  * @cpus_allowed: Allowed cpumask
  * @node: target NUMA node
- * @flags: %SCX_PICK_IDLE_CPU_* flags
+ * @flags: %SCX_PICK_IDLE_* flags
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Pick and claim an idle cpu in @cpus_allowed. If none is available, pick any
@@ -1450,7 +1450,7 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu_node(const struct cpumask *cpus_allowed,
 /**
  * scx_bpf_pick_any_cpu - Pick and claim an idle cpu if available or pick any CPU
  * @cpus_allowed: Allowed cpumask
- * @flags: %SCX_PICK_IDLE_CPU_* flags
+ * @flags: %SCX_PICK_IDLE_* flags
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Pick and claim an idle cpu in @cpus_allowed. If none is available, pick any
-- 
2.43.0

