Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0137342509
	for <sched-ext@lists.linux.dev>; Thu, 20 Aug 2026 02:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787191312; cv=none; b=YhotWOjkFbJRrArvNDVzpkiXBZy6nfXOtc5le3+pfvX0G8H6H7MQxbiE4PPVFnITCBqmJZlG79syeHNHdN/raBj86UKWTLGXpO7XpBNNJSxD2crryQ33r8PT8G3kM8w/fM33YnIikhlLfbqExn1ouvYoyqXvSIPlo+RvtMFuVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787191312; c=relaxed/simple;
	bh=D70uGgmp6+u1rvDr+7DCqLKbGMthdGeGlean2K5J5t0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJYml+BPGynyjJM4V9iNlP1AV9ac+rNA0szm+OPQdLhBh2QByPuNVGsVEQPjWfgK4AaX9SXB3DQCz5O98vi1Q096TtFaea6HKCRqcilyILTdWR2iR3cO71mJXLefyYMP8IIsNRzlOypGae0YM14EfxfCIAXCDQL5o33/ArgBLhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 15c5cbde9c3b11f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:89fafefe-376d-44c3-b9bf-d55568a44c81,IP:0,U
	RL:0,TC:0,Content:6,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:6
X-CID-META: VersionHash:7db8b62,CLOUDID:e6eb325efb83014365d9e8b16d53af3d,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|123|850|865|898,TC:nil,Content:4|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 15c5cbde9c3b11f19a56ed5b684f684d-20260820
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1917488911; Thu, 20 Aug 2026 10:01:40 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Docs/admin-guide/cgroup-v2: document BPF scheduler callbacks for cpu.max and cpu.idle
Date: Thu, 20 Aug 2026 10:01:38 +0800
Message-Id: <20260820020138.1956564-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <05fa2ecdf1468ca7454244941343626f@kernel.org>
References: <05fa2ecdf1468ca7454244941343626f@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Wed, Aug 19, 2026 at 10:08:32AM -1000, Tejun Heo wrote:
> The "CPU Interface Files" preamble defines the categories that the
> interface file entries refer back to and it only knows about
> cgroup_set_weight:
>
> With cpu.max, cpu.max.burst and cpu.idle now referring to
> cgroup_set_bandwidth and cgroup_set_idle, the preamble no longer covers
> the entries that follow it. Can you please update the preamble to match,
> e.g. by making the bullets refer to the corresponding cgroup_set_*
> callback, and resend?

Right, I missed that the preamble only knows cgroup_set_weight.
Generalized the bullets to the corresponding cgroup_set_* callback and
resent as v2.

Thanks for the review.

-- 
Liang
