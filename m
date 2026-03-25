Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C2C17BA2
	for <sched-ext@lists.linux.dev>; Wed, 25 Mar 2026 03:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774408317; cv=none; b=LgzlXLLHL2Xfk0DSWFGB4kgh+9A2Lp++njbLSOcTuN5aBv8zrW+SA9dzfAvFqSveD0qiaVGJuQ6KE7wGqUn/7bj855XilIDuS0V9v+0+MukOJgZKETTMpXDO+g11y+WDanQjv/zupWZySqmhUM8kIc7a0skLSYixlpRN+rCPnO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774408317; c=relaxed/simple;
	bh=WZplLBb/zzJ8TopyIP/QMhDwLUpLW5NNVl6kzErBwKg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oolHwhe/NNI9GLgErXxcWcD4wMKfxpKPzPDmuRhQSXwmf2GgFOtbsweIV/BnHStSIkExxUHve+J1JZ9cBaLNEIRlrvxLYGBoKJvN/SoFHU7YtedfZtld0z8Oci+JwqMCvycNIBMuIEBaJbECxvcSAEOL7scu1IkgyP2Hu0kgPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O/J8gzJ9; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O/J8gzJ9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774408304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=GlOjr1EZKY3bXhZ6vt9D9keuTZu2IvV3+IrU6oq6YrY=;
	b=O/J8gzJ9jnEUUIa42YQw5qPNNZwgIN3zkQbyJiFoe7xh1rg6aLK40/RT4D8spV3fq6b1I2
	TrfT3aBZBrhqUpqOMHwdgZ+n4er4piQk8tJ/h4/+0VlEOdelGNXRJv6P96ID1SGH7kKFfd
	WrPURDoiwELRuwDuvSD9nnt1u1+ojo0=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH v2] sched_ext: Choose the right sch->ops.name to output in the print_scx_info()
Date: Wed, 25 Mar 2026 11:11:00 +0800
Message-Id: <20260325031100.22840-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The print_scx_info() always output scx_root structure's->ops.name,
but for built with CONFIG_EXT_SUB_SCHED=y kernels, the tasks may be
attach an sub scx_sched structure. this commit therefore use the
scx_task_sched_rcu() to correctly get scx_sched structure to output
ops.name, and drop state check.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/sched/ext.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2472231ec556..551bfb99157d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7680,14 +7680,18 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
  */
 void print_scx_info(const char *log_lvl, struct task_struct *p)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 	enum scx_enable_state state = scx_enable_state();
 	const char *all = READ_ONCE(scx_switching_all) ? "+all" : "";
 	char runnable_at_buf[22] = "?";
 	struct sched_class *class;
 	unsigned long runnable_at;
 
-	if (state == SCX_DISABLED)
+	guard(rcu)();
+
+	sch = scx_task_sched_rcu(p);
+
+	if (!sch)
 		return;
 
 	/*
-- 
2.17.1

