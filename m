Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF664A138B
	for <sched-ext@lists.linux.dev>; Wed, 22 Jul 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714664; cv=none; b=WSo81bMyIada3URHHoF/wrijcPvru19EBBxnrGuF9Hn3TKQU3NHyOfXLGXzv7pLb+DWzAdKQYbq86Ff8G/MvJOCt+TSAp6SBh3SxRzzde9xOjU9fH1Rd2mokTdv5muA/iay1NWCUtqTRyutrSEIetrQNcddkVE40oGyv576BnIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714664; c=relaxed/simple;
	bh=XxjQhvbi6pMdjEklBMd1kVLQbogpNRr+rxntNJ1ujms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/Cimo6AejeWw7VvbovEQX+XtenLGp4hL5QlHzi9aRNdM60XJnlshnbXA31cC5bSkC+wO8Q8xNJbRlMF6rvVptJ1Jucxdz0DU5A7VRNAi58nlJmcbhPZ7OgKtRvhKv5d8zsw+JNa1lCNRLy7Y6iycnxyyvqKkCQ7Oy8MQaL5FyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P27DWKVJ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P27DWKVJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=UN
	1PIcIVTv6HVbq+krOUEgErsGszp3PxqzrI31jiC+U=; b=P27DWKVJmjmZBpZTke
	KVsk+HMaZivmw6YFYz2tNy//DEY59xLDGKV1bmlaeIM6KwZ+Sw5FAMtGaeItWsvZ
	fpIZg2uEwsw+/dldJvdFKHwyrIL5NsCyask0fSlEGkN2X8JXWFmil0qlmglA9ZSo
	O8UTqAg5hJBMsBbwy2RF9US0M=
Received: from cuijian-virtual-machine.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDn1wSJlWBqoE07Hw--.47660S2;
	Wed, 22 Jul 2026 18:03:54 +0800 (CST)
From: Cui Jian <cjian720@163.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cui Jian <cjian720@163.com>
Subject: [PATCH v2] sched_ext: Fix stale errno in scx_sub_enable_workfn()
Date: Wed, 22 Jul 2026 18:03:52 +0800
Message-Id: <20260722100352.36627-1-cjian720@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <al-tQH99wT1RBfnd@gpd4>
References: <al-tQH99wT1RBfnd@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDn1wSJlWBqoE07Hw--.47660S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrW3Gw4rXry7urykuFy3Arb_yoW8XryrpF
	ZYqrsrtrWkGFW8Cr4UtayIga4Fg3yktr17Xr1DAw1Iqw1fKr1FqryrXF12gFWq9rn3Aa4a
	yrW2q3sxGF4qkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_PETdUUUUU=
X-CM-SenderInfo: pfmlt0qxsqqiywtou0bp/xtbC3Ao6xmpglYoYMAAA3X

The nesting depth check and the cgroup online check in
scx_sub_enable_workfn() reach err_disable without setting ret, so
the fallback error added by commit db4e9defd2e8 ("sched_ext: Record
an error on errno-only sub-enable failure") reports
"scx_sub_enable() failed (0)".

This is currently harmless because both paths record their own
scx_error() first and the first error wins, but it leaves the
fallback broken for these paths. Set -EINVAL and -ENODEV there
so the fallback always reports a real errno.

v2: The validate_ops() path from v1 is already fixed in for-7.3
    (sub.c already has ret = scx_validate_ops()), so only the two
    remaining paths are addressed.

Signed-off-by: Cui Jian <cjian720@163.com>
---
 kernel/sched/ext/sub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index d7842a609d96..6da6c91e4287 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1331,6 +1331,7 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 	if (sch->level >= SCX_SUB_MAX_DEPTH) {
 		scx_error(sch, "max nesting depth %d violated",
 			  SCX_SUB_MAX_DEPTH);
+		ret = -EINVAL;
 		goto err_disable;
 	}
 
@@ -1378,6 +1379,7 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 	set_cgroup_sched(sch_cgroup(sch), sch);
 	if (!(cgrp->self.flags & CSS_ONLINE)) {
 		scx_error(sch, "cgroup is not online");
+		ret = -ENODEV;
 		goto err_unlock_and_disable;
 	}
 
-- 
2.34.1

