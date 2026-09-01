Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D063515C2
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269676; cv=none; b=GS9sdg8gnba6gBu1c63FIbA1kERCTE6GWW37AMlOW5t9RBcm80oVC4BCyq6GONhtP5ShYDG3a0myil7i9uNZPxQEbmdSiPW0rGa1/iT1j8elvP4rDOrRVX6a/V/+loIU3ft3Od9CkKcD9gMbKVWHYaD9smssVVfnmAWHTNJewx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269676; c=relaxed/simple;
	bh=BpMmoUdZJz5C+Xly0UFL+K5vxlejQKcCLE69xeqVoNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nzuHcbF/EBouKD/NwsfoSoIfipRex3eY6NiV4H0Ojvox2X2C7/6FA6/va0DzrdTl3U0krnVyCE38GsSVAkAP48CZC0EX/uceFraGLdpE6KBPaBRrbBf8V+gjMCQN1pqQ+phylxdTZx6cebZ/yT2iAwtp49452HY+dNUW1P/1x5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d9e7a9baa60911f19a56ed5b684f684d-20260901
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a58203f0-d71c-4f6d-9cfc-533507975d3a,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:7e4bed32bd1383ad1806b08a1eff91c5,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|850|865|898,TC:nil,Content:0|15|50,ED
	M:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d9e7a9baa60911f19a56ed5b684f684d-20260901
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2062903539; Tue, 01 Sep 2026 21:34:26 +0800
From: Qiurong Fang <fangqiurong@kylinos.cn>
To: zhanxusheng@xiaomi.com
Cc: Qiurong Fang <fangqiurong@kylinos.cn>,
	tj@kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH v2] sched_ext: Skip per-CPU data allocation for built-in DSQs
Date: Tue,  1 Sep 2026 21:34:21 +0800
Message-Id: <20260901133421.2981014-1-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260901022004.1824584-1-zhanxusheng@xiaomi.com>
References: <20260827082329.3368255-1-fangqiurong@kylinos.cn> <20260901013258.1822890-1-fangqiurong@kylinos.cn> <20260901022004.1824584-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Zhan,

Thanks for the review and the Reviewed-by. I'll fold the changelog
wording in the next spin, if there is one.
