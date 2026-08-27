Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E93BFAFB
	for <sched-ext@lists.linux.dev>; Thu, 27 Aug 2026 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818073; cv=none; b=Fs5WcpKMAAmVdazoIKuHKI2rFmybXQMSdm+1tAAlJu2N6KfTCYy0J+2b4bj8jCU+0ATJEDV/4KtwmBNTG1copEXI6Llite40ik+pJf18MRyhc+J9hORdMxZ44OKokC1Dsmcu5ysSYgB4iIL1aYD14usGUYQ8xMzfjfxooMTZtOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818073; c=relaxed/simple;
	bh=VfjIIfx/6JW+Y7SZvQX0qiKqVmt69bzgYi7ALKBSZzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bOSWVD5d61+UmnprkL9qQCAlMmuHHRaP55/73QTV9Elr7LYm+toegm13scdgVWWm24BZAwQ6GUumX9HR57Z7fmd9RIXc094sTQM6Oqdn0VX+bAkfbR9N6H1wdZVYXUZD1EN665CpmzgYlEJ0DD89RQFwqToHmXJ4kn2B7l87O7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 60441acca1ee11f19a56ed5b684f684d-20260827
X-CID-CACHE: Type:Local,Time:202608271603+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:61786183-20b9-4776-a217-eb4ac0266eb2,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:7db8b62,CLOUDID:2b001011f52c908cbbecc3d4b3ba3a82,BulkI
	D:nil,BulkQuantity:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:1|-100,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 60441acca1ee11f19a56ed5b684f684d-20260827
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1112516909; Thu, 27 Aug 2026 16:07:41 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Wanwu Li <liwanwu@kylinos.cn>
Subject: [PATCH] sched_ext: Fix timer pinning and return value in scx_central
Date: Thu, 27 Aug 2026 16:07:36 +0800
Message-Id: <20260827080738.829103-1-liwanwu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

central_timerfn() re-arms the timer with a hardcoded
BPF_F_TIMER_CPU_PIN flag and ignores the return value, defeating
central_init()'s -EINVAL fallback for kernels without the flag
(<6.7): on such kernels the first tick kills the timer permanently
with no diagnostic.  Honor timer_pinned and check the return like
the init path does.

Fixes: 22a920209ab6 ("sched_ext: Implement tickless support")
Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
---
diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 64dd60b3e922..65dae9e45400 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -299,6 +299,7 @@ static int central_timerfn(void *map, int *key, struct bpf_timer *timer)
 	u64 now = scx_bpf_now();
 	u64 nr_to_kick = nr_queued;
 	s32 i, curr_cpu;
+	int ret;
 
 	curr_cpu = bpf_get_smp_processor_id();
 	if (timer_pinned && (curr_cpu != central_cpu)) {
@@ -332,7 +333,10 @@ static int central_timerfn(void *map, int *key, struct bpf_timer *timer)
 		scx_bpf_kick_cpu(cpu, SCX_KICK_PREEMPT);
 	}
 
-	bpf_timer_start(timer, TIMER_INTERVAL_NS, BPF_F_TIMER_CPU_PIN);
+	ret = bpf_timer_start(timer, TIMER_INTERVAL_NS,
+			      timer_pinned ? BPF_F_TIMER_CPU_PIN : 0);
+	if (ret)
+		scx_bpf_error("bpf_timer_start failed (%d)", ret);
 	__sync_fetch_and_add(&nr_timers, 1);
 	return 0;
 }
