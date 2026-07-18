Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8B4503B
	for <sched-ext@lists.linux.dev>; Sat, 18 Jul 2026 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784405869; cv=none; b=Yfs0f1rUn9kEhvj5xEAyeG1esQd+hpH4dqB2zj2eo3QA17NHrI7K6MaTZGiSwcC4fxFJzWM276NJSK42xvJPElAWWjKw+WC1BovPGVjiAEPvF6m7hnVBIR1OKWRRSarmbCopG8jSxWImXSt5RhdmuzFLMM3wYxrJM6QTpdXwhhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784405869; c=relaxed/simple;
	bh=mdNDbL1ZbLOovWxIYYR0FsEcIXjDNHEoX5kVwP7YXEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mgVwVJk/8+RWaqD7EA4q+RxLKkYVWVJVmG7PXN6Tg7yGgJvbQc0hF8LjiD80ZBNoMsy8xLjizpcV2ILM5I3XA+PD2SrsIbloR40j2TpxspdViUK9c4eMaTnnKKrMTkoOVstHbEkj23SPnt3lmepi8H26eu5vSEaMUyeoJbV/Qxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IwfRwgJH; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IwfRwgJH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aN
	ZcrnwJUb8dIAlVfZD4IoXdCGWNUcT8sVztnOa7EZU=; b=IwfRwgJHwoBap6/5Xf
	1E2hCaLkAFqiGGJGXq90HtjVwMmusFs6imCVytkT6QUMEUOQVKXPM0JzkVuPrjiN
	kZBHiLKKVo6vbb8AUR2rN/Wt21lgBQjddNfEO0rUchPoagEs/Roiq+xowzwT8fLT
	St9bzZ+uNLu37J8QF+CpYQpbY=
Received: from cuijian-virtual-machine.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgC3BSJK31tqq7K4Hw--.50927S2;
	Sun, 19 Jul 2026 04:17:15 +0800 (CST)
From: Cui Jian <cjian720@163.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cui Jian <cjian720@163.com>
Subject: [PATCH] sched_ext: Fix stale errno in scx_sub_enable_workfn()
Date: Sun, 19 Jul 2026 04:17:13 +0800
Message-Id: <20260718201713.17890-1-cjian720@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgC3BSJK31tqq7K4Hw--.50927S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWUAry3Zr4xJFW3KFy8Xwb_yoW8Cw13pa
	yay3srt3ykWFW8uFWjyFZ7u3WYgws7tr17XryDCw1Iyw1Sgr1FqF95JF12gFW2krn5C3W3
	ZFWjvr9rG34qk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_PETdUUUUU=
X-CM-SenderInfo: pfmlt0qxsqqiywtou0bp/xtbC3At7CGpb30sdNwAA3r

scx_sub_enable_workfn() drops the return value of validate_ops().
When validate_ops() fails, the function jumps to err_disable with
ret still holding 0 from the previous call, so the fallback error
added by commit db4e9defd2e8 ("sched_ext: Record an error on
errno-only sub-enable failure") reports "scx_sub_enable() failed
(0)".

This is currently harmless because validate_ops() records its own
scx_error() first and the first error wins, but it leaves the
fallback broken for this path. Save the return value into ret,
like scx_root_enable_workfn() already does.

The nesting depth check and the cgroup online check also reach
err_disable without setting ret. Set -EINVAL and -ENODEV there so
the fallback always reports a real errno.

Signed-off-by: Cui Jian <cjian720@163.com>
---
 kernel/sched/ext/ext.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e3fa7b2fac9d..e623d6375f66 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7559,6 +7559,7 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 	if (sch->level >= SCX_SUB_MAX_DEPTH) {
 		scx_error(sch, "max nesting depth %d violated",
 			  SCX_SUB_MAX_DEPTH);
+		ret = -EINVAL;
 		goto err_disable;
 	}
 
@@ -7580,7 +7581,8 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 	if (ret)
 		goto err_disable;
 
-	if (validate_ops(sch, ops))
+	ret = validate_ops(sch, ops);
+	if (ret)
 		goto err_disable;
 
 	struct scx_sub_attach_args sub_attach_args = {
@@ -7613,6 +7615,7 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 	set_cgroup_sched(sch_cgroup(sch), sch);
 	if (!(cgrp->self.flags & CSS_ONLINE)) {
 		scx_error(sch, "cgroup is not online");
+		ret = -ENODEV;
 		goto err_unlock_and_disable;
 	}
 

base-commit: 1229e2e57a5c2980ccd457b9b53ea0eed5a22ab3
-- 
2.34.1

