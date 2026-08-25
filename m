Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC492264B0;
	Tue, 25 Aug 2026 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644834; cv=none; b=TPcK9B0BUCrwaJmf6jJbu4Eami5mjzKxKcZCuDHhLLZ8mHvkDrIqcgFnV6GznmsH0mcJ3N6iLWXW6BOJ+xmWCIxTdHFtu2je5lflhxPm8ABeOg+znFEaxS5kapMslykxt/wbKMffbels1Xapc3fH+Zqrq37ReXlIy9lwUgjMzvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644834; c=relaxed/simple;
	bh=Z4kAGEmMRQEF9ppuXsT0f5Wrj8330ReQKn/7VM3gG3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEazxyNV37SGFS9yueYNGHxwDFc6KQJzk/fAxQ0Ci27XUK3P90Q61HY1yzD+olk98HBTmexngYTXidNTjFpZoylCAaVaDXnXcsfRYcMo9iDl4sjrNbHGRUQk+PU96/7abHHQ5bK8WIcY+XUZqn4HDeWFkf7Dx/spbKUOQ4PlJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 06a0dadaa05b11f19a56ed5b684f684d-20260825
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:e4eaa579-a734-431f-b042-5a2caf6aaa59,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:079686635116dc1dcda7a1f79f1d9a8b,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|850|865|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 06a0dadaa05b11f19a56ed5b684f684d-20260825
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1565334611; Tue, 25 Aug 2026 16:00:23 +0800
From: Liang Luo <luoliang@kylinos.cn>
To: sashiko-bot@kernel.org
Cc: luoliang@kylinos.cn,
	sashiko-reviews@lists.linux.dev,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH] sched_ext: Fix missing @slice and @vtime descriptions in finish_dispatch() kernel-doc
Date: Tue, 25 Aug 2026 16:00:20 +0800
Message-Id: <20260825080020.2463550-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260825055849.ECF201F000E9@smtp.kernel.org>
References: <20260825055849.ECF201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 25, 2026 at 05:58:49AM +0000, sashiko-bot@kernel.org wrote:
> Looking at the code, finish_dispatch() does not appear to have slice or
> vtime parameters in its signature:
> 
> static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
>                             struct task_struct *p,
>                             unsigned long qseq_at_dispatch,
>                             u64 dsq_id, u64 enq_flags)

The review appears to be against a tree predating commit 13f1eae3b662
("sched_ext: Synchronize slice and dsq_vtime writes"), which added the
slice and vtime parameters to finish_dispatch(). In current mainline,
the signature is:

    static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
                                struct task_struct *p,
                                unsigned long qseq_at_dispatch, u64 dsq_id,
                                u64 slice, u64 vtime, u64 enq_flags)

scripts/kernel-doc -none kernel/sched/ext/ext.c reports the two
"function parameter not described" warnings before this patch and
produces no warnings after it, so no "Excess function parameter"
warning is introduced.
