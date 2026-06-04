Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9339B97F
	for <sched-ext@lists.linux.dev>; Thu,  4 Jun 2026 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565406; cv=none; b=UwlxhD25wYFPw1+Cp4x4H62KQWVkjDmgZGajwyN58IUhQOjyJU91kcd2vSk34DHPQG4Y9x1CyvzNaTzZArGJQuraOj3UJ7UC6pblUXpyUUszvNLK3iJlQ1EIANb3/6HLt3w4VFoDNHegYhwUgmkJHe0xknTAF41ZLQv2/qejGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565406; c=relaxed/simple;
	bh=ekRUM5BVqcvDpkWE0ZFiLCjtc4ZkzlY5LuALmfN15rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TP4nWLfAdSg43Cfvlc0PKQJ61t6iaD3IHoZNyFRLd2S8JadbPMILHK9fvdfTFSHYJU/6bRs2pmIny7cdltBdntiY6cqrALH8RAPVb0PCNQiiDAjmJsIxB0sozQg+Bzf6z0nhIUg51nS5s6YJj9GX61VicoS8FF1Vt4TAxvNzuF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f46f8ff85ff711f1aa26b74ffac11d73-20260604
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b19c0593-10fc-4b4c-8b07-af6d0f6890d3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:b4636da1207598877150ea3503eb4608,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|123|136|850|865|898,TC:n
	il,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f46f8ff85ff711f1aa26b74ffac11d73-20260604
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 58880156; Thu, 04 Jun 2026 17:29:58 +0800
From: luoliang@kylinos.cn
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	devnexen@gmail.com,
	yphbchou0911@gmail.com,
	zhaomengmeng@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/sched_ext: scx_flatcg: Document cgroup v2 requirement
Date: Thu,  4 Jun 2026 17:29:56 +0800
Message-Id: <20260604092956.576100-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c2c820b0287df816cae84763b9e757bc@kernel.org>
References: <c2c820b0287df816cae84763b9e757bc@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jun 03, 2026 at 10:29:10PM -1000, Tejun Heo wrote:
> This doesn't look accurate on current kernels. BPF_MAP_TYPE_CGRP_STORAGE is
> registered unconditionally and its fd access goes through
> cgroup_v1v2_get_from_fd(), and bpf_cgroup_ancestor(), bpf_cgroup_from_id()
> and scx_bpf_task_cgroup() all take a plain struct cgroup with no v1/v2
> gating. The program should load fine on cgroup1.

You are right, thank you for the correction. I was wrong about the
v2 dependency.

> Did you actually hit a load failure, and on which kernel? cgrp_storage's
> cgroup1 access was only enabled in v6.8 by 73d9eb340d2b ("bpf: Enable
> bpf_cgrp_storage for cgroup1 non-attach case"). Before that it was cgroup2
> only, which would explain a failure on an older kernel.

I did observe a load failure on v7.1-rc3 with cgroup v1 at the time,
but I can no longer reproduce it now. It was likely caused by a local
misconfiguration or build environment issue rather than a genuine v2
dependency. I should have validated the root cause before submitting.
My apologies.

Please drop this patch.
