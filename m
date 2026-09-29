Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600C541A91B
	for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662347; cv=none; b=G3yC4I6HYVqOomGbn8OZZnkxuGm0wPGGlvBW8ck71LEpvAbTCQ5U91A9upIQiPogNo7+a6/4VehMvBd7nZ2LHBFoe8twcIv2cBs/lBYomLBq+oPDo4JCzfSvckIkADVd16MMDl0qNgmwQFekfvcuB/sJtxCEyNQvg+CTgcWL6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662347; c=relaxed/simple;
	bh=wJpmwTcQ0uQfQa5O5y1/eVoJwyqg92DAVizNcZmx/w4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKXNT+Z+kXkLfot5u86SmWuG1wlyev84NiwHPQQk2X6PDQ1DFpOax2Nj9EdVyuR3VmAYatudPIwwGX9LWFFU+wBF82ui/kPkcrBtmy9fYjQojM3CYRvqrrBXwyRHvrDPsQEiY3PCuC5N0gy/RVOXBLK91mbfpWgDPsAc7q/bv9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b95f5412bbcc11f19a56ed5b684f684d-20260929
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:fe474b09-56e1-453d-8e16-07aaa04dbde8,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:b4c4c600e71a8aaa69ac7a59bfdff265,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|123|136|850|865|898,TC:nil,Content:0|
	15|50|99,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b95f5412bbcc11f19a56ed5b684f684d-20260929
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1909150436; Tue, 29 Sep 2026 14:12:18 +0800
From: luoliang@kylinos.cn
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: Re: [PATCH v2] sched_ext: Count cap-rejected local DSQ inserts in SCX_EV_SUB_REJECT
Date: Tue, 29 Sep 2026 14:12:13 +0800
Message-Id: <20260929061213.241696-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <artII3WkutGPf7VQ@gpd4>
References: <artII3WkutGPf7VQ@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

Hello Andrea,

Thanks for the review.

On Tue, Sep 29, 2026 at 07:09:55AM +0200, Andrea Righi wrote:
> I still don't see a need for this event. The BPF scheduler receives
> SCX_TASK_REENQ_CAP on cap-related re-enqueues and can count those itself, as
> scx_qmap already does.

Fair enough - the scheduler-side counting covers this, and I agree the
distinctions are marginal for diagnosis. Withdrawing the patch.

Thanks to you and Tejun for taking a look.

Liang Luo
