Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5D8394792
	for <sched-ext@lists.linux.dev>; Fri,  7 Aug 2026 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786095545; cv=none; b=Z6/49AykyMyI8IMXTVIXetFIQ9W47NYeAniK5gptYmvkLcu4vYvggHviCM0zSHfdkQ3aVg3Fxkmfg3WogurKmxFVXsgI0Blu0M//gxmU9KrfmVz0VLJg+ia9PBf0iZiYR7cNNGdnt2Mza3OOfP+NTJ5fIf8q6XIcDNWfs1sNJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786095545; c=relaxed/simple;
	bh=89jGM4c+vn3KA93xdHQb/fkqCpfxHpQEbGtAld1RZiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=avs32HQ4YdH8ToK9XBulVL6e0eovvBw0lVfM2hA8/+ZRgux41UsuBLPveTVo3YCS+1btpvaiMC7pAGi7jUxwBEvrz7p4w1jQYqo4Q75hhXrZFrZHTkmznAy04uo+nqBlZWQ5yVWjVTuih+DSUjOqX6Bd0cltuvsTEWYc1mnJOKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GXTOINrp; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GXTOINrp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Jz
	XIef971cDIJl/krmt8IkgIud1AvEsYTj+se2y0TPA=; b=GXTOINrpM9TSs2saaI
	vGw1LnfCvjcZnRNQHUt5ECRpfVmJbSfH55yTPkGsormxpcdsF0uGgWUkuc1NiPNh
	t7m4AI1khBoBYveOONkTXNqCsWlIfqGGU1xLtF8JI0MInTdidZRj0OgQ4SZHjyRu
	iBOtPgkLvKDu6/AygIIhEHriQ=
Received: from cuijian-virtual-machine.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnyACep3Vq64SUMQ--.116S2;
	Fri, 07 Aug 2026 17:38:40 +0800 (CST)
From: Cui Jian <cjian720@163.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cui Jian <cjian720@163.com>
Subject: [PATCH] sched_ext: Fix NULL dereference in find_parent_sched()
Date: Fri,  7 Aug 2026 17:38:37 +0800
Message-Id: <20260807093838.56002-1-cjian720@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnyACep3Vq64SUMQ--.116S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GryfGr4xAF1DuF1DXr4ruFg_yoWfKrc_Zw
	13Ga15G34UAr1DKw429398ZrWfKFW2kryrZF9FkFW3JF1kJrZxXr1fCF95t3sIkFWxXFyD
	Gr9IkFykArn7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREID75UUUUU==
X-CM-SenderInfo: pfmlt0qxsqqiywtou0bp/xtbC3AAKlmp1p6B1XAAA3x

find_parent_sched() dereferences cgrp->scx_sched without checking
for NULL. cgroup_get_from_id() can return cgroups from any
hierarchy, including cgroup v1 where scx_sched is never set.

A BPF program that passes a v1 cgroup ID as sub_cgroup_id would
hit parent->cgrp on a NULL pointer and crash the kernel.

Add a NULL check and return -ENODEV.

Signed-off-by: Cui Jian <cjian720@163.com>
---
 kernel/sched/ext/sub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index d7842a609d96..6395281bae71 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1209,6 +1209,10 @@ static struct scx_sched *find_parent_sched(struct cgroup *cgrp)
 
 	lockdep_assert_held(&scx_sched_lock);
 
+	/* no SCX sched */
+	if (!parent)
+		return ERR_PTR(-ENODEV);
+
 	/* can't attach twice to the same cgroup */
 	if (parent->cgrp == cgrp)
 		return ERR_PTR(-EBUSY);
-- 
2.34.1

