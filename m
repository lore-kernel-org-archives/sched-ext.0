Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7823BF692
	for <sched-ext@lists.linux.dev>; Thu, 27 Aug 2026 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818074; cv=none; b=rv5/vLKY80cir9IVMBEo4LBPxIYRJm2sGjauQ7RCtKOqIvG9qxW8LmcVfxXkN6eSGKICyFc8ENhNn6LkMbGgSazsRXzUGbuSkE4zOpo8FaKq5ClayD4xJ77Izb1QR0Cbq9qWSMUqMwzYvCdOJshXKJ8I56DrHBT36AMIkoeKVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818074; c=relaxed/simple;
	bh=Iq9bINOSPxzr8e89Ie6d/8Vzg93tZ8SYLxSgTF2ETMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C4rddxfy+tQaj9UqE0GIfH+5/P9kO1w/qKl0JeCJ4tC3oE8lp4nC1jdp6WZqdHm+uCV9DIZ6nLn5Uj+ITHBMBnWnyxOPNDqt6nCOQOQ6OmckcxEa0IKjqlhQBL26yN04jbGC/ls6O7yssVVFYMjjmh58DAS7AkrW2OT+EVoQ02U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 60753ad0a1ee11f19a56ed5b684f684d-20260827
X-CID-CACHE: Type:Local,Time:202608271603+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5ea08da1-7c86-46ee-b052-310ade43f29b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:7db8b62,CLOUDID:35ca360fb1af2561cd20f5597769b48b,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50,EDM:2,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 60753ad0a1ee11f19a56ed5b684f684d-20260827
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 165197243; Thu, 27 Aug 2026 16:07:41 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Wanwu Li <liwanwu@kylinos.cn>
Subject: [PATCH] sched_ext: Fix vtime delta loss in scx_flatcg cgroup migration
Date: Thu, 27 Aug 2026 16:07:37 +0800
Message-Id: <20260827080738.829103-2-liwanwu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260827080738.829103-1-liwanwu@kylinos.cn>
References: <20260827080738.829103-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fcg_cgroup_move() lost the signed vtime offset across cgroup
migration in the mechanical conversion to time helpers:
time_delta() clamps negative deltas to 0, so a queued task (whose
dsq_vtime is normally behind the source frontier) loses its
accumulated vtime credit and lands exactly at the destination
frontier instead of keeping its relative position.  Restore the
wrapping signed subtraction.

Fixes: 62addc6dbf36 ("sched_ext: Use time helpers in BPF schedulers")
Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
---
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 64cf4dd964d6..d3186a6038c3 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -931,14 +931,14 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
 		    struct cgroup *from, struct cgroup *to)
 {
 	struct fcg_cgrp_ctx *from_cgc, *to_cgc;
 	s64 delta;
 
 	/* find_cgrp_ctx() triggers scx_bpf_error() on lookup failures */
 	if (!(from_cgc = find_cgrp_ctx(from)) || !(to_cgc = find_cgrp_ctx(to)))
 		return;
 
-	delta = time_delta(p->scx.dsq_vtime, from_cgc->tvtime_now);
+	delta = (s64)(p->scx.dsq_vtime - from_cgc->tvtime_now);
 	scx_bpf_task_set_dsq_vtime(p, to_cgc->tvtime_now + delta);
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(fcg_init)
