Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E22236F7
	for <sched-ext@lists.linux.dev>; Tue, 29 Sep 2026 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650847; cv=none; b=jOoUJIaTCRcjOlOUJlrl5tpIVp783pdTJl/XHXPQZD8B7HC2E+dJ2wDbquWXsQFSPuUYjtdke3Y0Fv5XLG/MCbVK/Nx1DfyO9Urji3FHGb1+xD6U3u4OKmn4TtjeXcwOFzwioaAG9yif/C4jMwxHGZMeL0g/1VQBFpRjE1Xux0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650847; c=relaxed/simple;
	bh=fQaHSHx7bCG7hmqm54HuBgHs/9X0mPqgoRUz97D83TU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pJRoqDTOxCcJpXilabxCrfMoStNeniTMK2jqfyuNxwx/b4hWKzFzJRfqIUIyzyVMK58DntZvw5Fip7H1XBFxFTwZIU2CvNTln/ZhQzR87GJMshb2z0uirsjiHHkfp8puVKk+fz1wNs8cm/yC4pzBCpdMbs/knw715+iwvPrYBfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ee956704bbb111f19a56ed5b684f684d-20260929
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0a7f46ae-f8dd-4405-9830-458891a13818,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:d1eb1fa83e3542f1fbb5abfe677ecfcf,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|123|136|850|865|898,TC:nil,Content:0|
	15|50|99,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ee956704bbb111f19a56ed5b684f684d-20260929
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1470517916; Tue, 29 Sep 2026 11:00:31 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: Re: [PATCH] sched_ext: Count cap-rejected local DSQ inserts in SCX_EV_SUB_REJECT
Date: Tue, 29 Sep 2026 11:00:26 +0800
Message-Id: <20260929030026.3449491-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4aed937b9a7376fd50c1e272f9e1f177@kernel.org>
References: <4aed937b9a7376fd50c1e272f9e1f177@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

Hello Tejun,

Thanks for the review.

On Mon, Sep 28, 2026 at 09:06:21AM -1000, Tejun Heo wrote:
> I have nothing against adding the counter, but we don't count every path,
> so an uncounted branch arm isn't a reason by itself. What's the rationale
> for counting this one?

That's fair - a counter should be justified on its own, not by symmetry
with its siblings. The rationale here is that of the three outcomes, the
reject diversion is the one without preconditions: the other two
require a draining rq, a task that cannot migrate anywhere else, or an
explicit SCX_ENQ_RESCUE opt-in, while every other cap-missing insert
lands in the reject DSQ. With this counter, the events cover all three
outcomes of a cap-missing local insert.

> This doesn't fix a bug. Can you drop the Fixes: tag?

Done in v2.

Thanks.

Liang Luo
