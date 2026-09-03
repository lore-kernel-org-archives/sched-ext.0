Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73429368D4A
	for <sched-ext@lists.linux.dev>; Thu,  3 Sep 2026 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788406214; cv=none; b=Jz4gtsrgcwireyEODXocu8C+JzB3Y5AFQSUpKtnpMNnVIV9E94u7mYo6gJAXal66xqICPNPKS7gwNgzrzH7Ez/NwqCv2myWWgC/cQHz62nTGgKxP53Nd5QQ0OVh13MgHDFQSRfZmgq3u+ofx7TQvYhWHgL7KIjXnl08u/OC78FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788406214; c=relaxed/simple;
	bh=eXya5nlr3+zA4EDNnHy8itBISYAMhMCrW69Q+K9z3+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kneyaIfROYZbmN2DXV2Rns26/wMW29y8IzTOZLCE5jArTVGDyn8/Xuzd4PcbI0lUEftKrXjTbsfvN7jrnZD57Yc13aJRhS7kVJOS+IzHUaNa1YzVoTkX2Xqot/1sz4BeOiHCEdQyQjGM7iimuI1WGWKexVnJpkyc+eNoxVXZlhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bca13634a74711f19a56ed5b684f684d-20260903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2e91eb2d-9e09-408f-9667-1d9f4c398891,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:08f6ef09610bb2fe696fea773d2164b1,BulkI
	D:nil,BulkQuantity:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:5,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bca13634a74711f19a56ed5b684f684d-20260903
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1644833514; Thu, 03 Sep 2026 11:29:57 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: tj@kernel.org,
	arighi@nvidia.com,
	void@manifault.com,
	changwoo@igalia.com,
	emil@etsalapatis.com
Cc: liwanwu@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] sched_ext: two more context-safety fixes found in the NMI kfunc audit
Date: Thu,  3 Sep 2026 11:29:51 +0800
Message-Id: <20260903032953.659847-1-liwanwu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Continuing the audit that the sashiko bot kicked off on the NMI-reject
series, I went through every kfunc exposed to BPF_PROG_TYPE_TRACING
(the any / idle / cid context-filter sets). Two more context-safety
issues came out of it; this pair addresses both.

 - Patch 1 fixes the scx_locked_rq() class (three "any"-category kfuncs
   read scx_locked_rq() and take an unsafe fast path on a non-NULL
   return from NMI). scx_locked_rq() gains an in_nmi() test at the
   source that returns NULL from NMI, so the three callers fall onto
   their unlocked paths. This supersedes guarding them individually.

 - Patch 2 fixes an IRQ re-entrancy race on the per-CPU
   per_cpu_unvisited nodemask scratch in the idle path. The search
   scratch is protected only by preempt_disable(), which doesn't mask
   IRQs; switch to irqsave instead. The NMI case is left as-is (a
   misuse with no legitimate use and no crash risk).

Wanwu Li (2):
  sched_ext: Make scx_locked_rq() return NULL from NMI
  sched_ext: Protect the idle-search scratch nodemask with irqsave

 kernel/sched/ext/idle.c     | 14 ++++++++++++--
 kernel/sched/ext/internal.h |  9 +++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.25.1
