Received: from mta0.migadu.com (out-216.mta0.migadu.com [91.218.175.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77389442FD1
	for <sched-ext@lists.linux.dev>; Tue, 18 Aug 2026 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061246; cv=none; b=cu1m9zclGhnST85wnVSAf29SaG7Wr66YYqICdG5O8lAgjNi0hhmWOpFUEQMpT7xs+gr2tWHH6wA6fZfeIojOYo6p+Bjov4hgSCkQL90ZiD/1XP4kPBtFuOLGSPuYdWsBwqS5Pjn3tjXQICuQbwLKli8c/yaISk9d65NI7NKui9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061246; c=relaxed/simple;
	bh=KCY0EO4TqmjMyeYYnd/oEjXuRasscoLUdG32qylcLIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNpC3B2A92JiGsMVjOulhSLYPHBhEY7DNMhZA8H4/5cv0uXgWsHx/e3Ue9CK+Srx/GljOyglSI6pItptpeTrBWYOROieHyKCop7qVjypkzTWic647cZf5smHGyqMr/JCekRKc6gW8ltNT+NklUawh8EoQTEHmYaJqumfskxnq2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AmPb14T8; arc=none smtp.client-ip=91.218.175.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AmPb14T8"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=KCY0EO4TqmjMyeYYnd/oEjXuRasscoLUdG32qylcLIw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787061240; v=1; x=1787666040;
 b=AmPb14T8hHtICXIE9z18kbMxVd93nPIIwMTiWbsLX04Q2saAby7lEOzms5/f3IxbDImD+Eo+
 jShWxFPyKpRIclz67+ahh40jIU+mRkBELwX+evtoZa0JTtPaIJUAl9ijEloKgbqSf3XpNWa+0Px
 aDe1/Dl1Ihv5WOohtoxR77hg=
X-Envelope-To: sched-ext@lists.linux.dev
Received: from ctao-book.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 049d7f0f91a3b581;
	Tue, 18 Aug 2026 13:53:59 +0000
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	void@manifault.com
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH RFC] sched_ext: warn when cpu.max is set but the BPF scheduler doesn't implement bandwidth control
Date: Tue, 18 Aug 2026 21:53:28 +0800
Message-ID: <20260818135328.174152-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The kernel stores cpu.max bandwidth parameters in the task_group and
passes them to the BPF scheduler via ops.cgroup_set_bandwidth() and
scx_cgroup_init_args, but does not enforce the quota itself. If the
loaded BPF scheduler doesn't implement the callback, cpu.max is
silently ignored -- the cgroup gets unlimited CPU regardless of the
configured quota.

Of the example schedulers, only scx_qmap implements the callback --
and only to bpf_printk() the parameters, so no in-tree scheduler
actually enforces the quota. Measured with scx_simple: a
cgroup with cpu.max = "50000 100000" (50% of one CPU) and one
busy task used 9946ms of CPU in 10 seconds with nr_throttled
remaining 0.

Print a one-time warning when a finite quota is configured on a
cgroup while the active scheduler lacks the callback, so users and
container orchestrators know the quota is not enforced.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/ext.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10af28a9f2c0..de786d0b928a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4953,6 +4953,12 @@ void scx_group_set_bandwidth(struct task_group *tg,
 	     tg->scx.bw_burst_us != burst_us))
 		SCX_CALL_OP(sch, cgroup_set_bandwidth, NULL,
 			    tg_cgrp(tg), period_us, quota_us, burst_us);
+	else if (scx_cgroup_enabled && sch &&
+		 !SCX_HAS_OP(sch, cgroup_set_bandwidth) &&
+		 quota_us != RUNTIME_INF)
+		pr_warn_once("sched_ext: BPF scheduler \"%s\" does not implement "
+			     "ops.cgroup_set_bandwidth(); cpu.max will not be enforced\n",
+			     sch->ops.name);
 
 	tg->scx.bw_period_us = period_us;
 	tg->scx.bw_quota_us = quota_us;
-- 
2.43.0

