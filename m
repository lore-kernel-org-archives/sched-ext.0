Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1035A3BF
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927101; cv=none; b=W2bMR2TCArTjkgk+qgCeDq254LE3W1NhJoXX9QljHiZrrAfavx1SmbQgchM/IkdntbKk+rtfdKoRigxKXT6YASNg5e/E/dDIbuMAhGdNEs/8tkZB4nDr7kYFcdJERaDpWgoIZgZPl0de8xLn5PR/ojtsGsL6Qhy2CvqPoqFdnhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927101; c=relaxed/simple;
	bh=Pkw1DG0zqPF4HqKLmMGnDURBWSAnonHFg0O+E5MVlmM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DTORZdNjDNBtR5fIZ8tL6hoXckUgdIbpDLMVr7Cw+8Ydeu7s0mvku7pQ3DV8kn0JJ9qrLKprdParCNGb0oZumxcgcuzNDT3tQy7VdIrqQY2L5X5N+DjKp5HVlLamIUaeo8X5PqmwaLtY/i5K3QjG95DnAiUGrK4hr/NRwVaHs8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 023629c47e8b11f1aa26b74ffac11d73-20260713
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e78bb630-2b93-44d7-8a4f-50c10f3ec552,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:242305836b319d49a9e56d9c249baf9a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|136|850|865|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 023629c47e8b11f1aa26b74ffac11d73-20260713
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 830648413; Mon, 13 Jul 2026 15:18:12 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH] tools/sched_ext: scx_flatcg: Fix uninitialized stats on allocation failure
Date: Mon, 13 Jul 2026 15:18:08 +0800
Message-Id: <20260713071808.89847-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

In fcg_read_stats(), the memset() that zeroes the output @stats array
sits after the calloc() failure check. When calloc() fails, the
function returns without writing @stats.

The caller in main() declares acc_stats uninitialized, passes it as
the @stats argument, and then reads it unconditionally:

    __u64 acc_stats[FCG_NR_STATS];
    fcg_read_stats(skel, acc_stats);
    stats[i] = acc_stats[i] - last_stats[i];   // reads garbage

Because fcg_read_stats() returns void, the caller cannot detect the
failure. Reading the uninitialized array is undefined behavior, and
the garbage is further copied into last_stats via memcpy(), corrupting
the baseline used by the next interval.

This regression was introduced by commit cabd76bbc036 ("tools/sched_ext:
scx_flatcg: fix potential stack overflow from VLA in fcg_read_stats"),
which replaced the VLA with calloc() and inserted the failure check
before the existing memset().

Move the memset() above the calloc() failure check so @stats is always
zeroed regardless of allocation outcome.

Fixes: cabd76bbc036 ("tools/sched_ext: scx_flatcg: fix potential stack overflow from VLA in fcg_read_stats")
Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 tools/sched_ext/scx_flatcg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
index de2bef86d64d..7799782b76d1 100644
--- a/tools/sched_ext/scx_flatcg.c
+++ b/tools/sched_ext/scx_flatcg.c
@@ -105,12 +105,12 @@ static void fcg_read_stats(struct scx_flatcg *skel, __u64 *stats)
 	__u64 *cnts;
 	__u32 idx;
 
+	memset(stats, 0, sizeof(stats[0]) * FCG_NR_STATS);
+
 	cnts = calloc(skel->rodata->nr_cpus, sizeof(__u64));
 	if (!cnts)
 		return;
 
-	memset(stats, 0, sizeof(stats[0]) * FCG_NR_STATS);
-
 	for (idx = 0; idx < FCG_NR_STATS; idx++) {
 		int ret, cpu;
 
-- 
2.43.0

