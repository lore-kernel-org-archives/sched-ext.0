Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179D2D3225
	for <sched-ext@lists.linux.dev>; Wed,  2 Sep 2026 06:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330027; cv=none; b=tGsA+NVAPk5asnw21M8GOU+h7kWiBYGqZdRpKi/6ryHjhjfJYXcT0cjzj8JeTioxhT0f+uzSjXEURRH2QCRTf1jZmrvZ8Iw1DyKi+u84VDUybqCi04sonvoKyIKfKCk1JyCGD1UQtiq5kX5wPEfqASj2uHjIzE67qJ5YNLx1ZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330027; c=relaxed/simple;
	bh=jnsFr4GxSNFLlPrh7SrHVKw54y1aBeukfrKXs0TsTl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bQwcAScW9d+9KZtcLkS5Um1teKtijIuIIccnkKuPdis22PGsfvptJlG4o7GmWa/Q1RSUhsVzmUCxrvYptSOSZfyvvyDov8hl2i5q6dPU35Xzct2adWJ32iA/zRptW9tSuf8c3iVgCJwRzEKynqkx+yUk2uNq96v/l3J4CEOE4VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5d461d1ea69611f19a56ed5b684f684d-20260902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:85813e93-bc78-4f6e-9a46-584bb34ed85d,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:34eccc06b26d2ae5bd701499e54fe8ee,BulkI
	D:nil,BulkQuantity:0,SF:83|102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5d461d1ea69611f19a56ed5b684f684d-20260902
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 984970168; Wed, 02 Sep 2026 14:20:16 +0800
From: Qiurong Fang <fangqiurong@kylinos.cn>
To: tj@kernel.org
Cc: arighi@nvidia.com,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH] sched_ext: Delete sub-scheduler kobjects before releasing scx_enable_mutex
Date: Wed,  2 Sep 2026 14:20:07 +0800
Message-Id: <20260902062007.446314-1-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Tejun,

Understood - it's the expected behavior. Withdrawing the patch.

Thanks for the explanation.
