Received: from mta0.migadu.com (out-166.mta0.migadu.com [91.218.175.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2110429003
	for <sched-ext@lists.linux.dev>; Mon, 24 Aug 2026 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578833; cv=none; b=upc8Ljm1av+tuA633CycD8VAdz6qeU5R0xWCiKxpM+b7xSDMHpF+8IMZfBVrEznuW1I/rvGwEyUfZTFiWYXqfwrwoG5iIZXXG89p8KGKrAAlIsU+dQlKvOZwWoU1IgrrroTeozqVkQsv7Vf+m7+H9Bl/1F5cFZFGu962obRVvrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578833; c=relaxed/simple;
	bh=3edNKJO7hDiLr+6N33bx+1GdVJff9by9zddu2YSlVF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VevZJ9QehYo4rIaeWnJegeXmfc7VaKSbQfUlYmR8JQmPGcd7Cfm/IVtyZmIMTcxLhEe0dA77rKhh6ZA9a0SRcvyZY09QRxOVCgjoZQf5RA3ZzeEhpN55rU/tD4WMlV3zLXAYhApJIQC/mxS56taxTgHadN0DpteGAzWM1tjxAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kRZYyx51; arc=none smtp.client-ip=91.218.175.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kRZYyx51"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=3edNKJO7hDiLr+6N33bx+1GdVJff9by9zddu2YSlVF4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787578823; v=1; x=1788183623;
 b=kRZYyx51myGJ0OEhQ6QlAzfnEpDU7IVRG3/Q1Llp9HelK12nb8KBosQuSXkYSyvh84y5fRhg
 zAnxogSIf7hMVxxL4oU8AXk9+sjEm7IUFrQZq5g7LpPQu+rI6QlDFPcV4zkNwhXIaJXrhfmSOmi
 i01u7lQ/fhKvHrYC/Js5zGeA=
X-Envelope-To: sched-ext@lists.linux.dev
Received: from ctao-book.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id c8db36bdc943f2b5;
	Mon, 24 Aug 2026 13:40:03 +0000
X-Mizu-Trace-ID: c8db36bdc943f2b5
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: changwoo@igalia.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] sched_ext: pass the initial cpu.idle state in scx_cgroup_init_args
Date: Mon, 24 Aug 2026 21:39:54 +0800
Message-ID: <20260824133954.561956-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

scx_cgroup_init_args carries the initial weight and bandwidth control
parameters of a cgroup to ops.cgroup_init(), but not its cpu.idle
state. A cgroup that was already configured idle before the scheduler
was loaded (or before it was onlined under it) is presented as
non-idle, and the BPF scheduler only learns about it if cpu.idle is
written again later.

Add the idle state to scx_cgroup_init_args and fill it in both places
that build the args -- scx_tg_online() for cgroups created under the
scheduler and scx_cgroup_init() for cgroups that already exist when
the scheduler is loaded.

Verified in a VM with a probe scheduler printing the init args: a
cgroup configured cpu.idle=1 before loading shows idle=1 in
ops.cgroup_init(), the default shows 0, and later cpu.idle writes
still come through ops.cgroup_set_idle().

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/ext.c      | 4 +++-
 kernel/sched/ext/internal.h | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b646711a45fe..a7218314dcfb 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4764,7 +4764,8 @@ int scx_tg_online(struct task_group *tg)
 				{ .weight = tg->scx.weight,
 				  .bw_period_us = tg->scx.bw_period_us,
 				  .bw_quota_us = tg->scx.bw_quota_us,
-				  .bw_burst_us = tg->scx.bw_burst_us };
+				  .bw_burst_us = tg->scx.bw_burst_us,
+				  .idle = tg->scx.idle };
 
 			ret = SCX_CALL_OP_RET(sch, cgroup_init,
 					      NULL, tg->css.cgroup, &args);
@@ -5185,6 +5186,7 @@ static int scx_cgroup_init(struct scx_sched *sch)
 				.bw_period_us = tg->scx.bw_period_us,
 				.bw_quota_us = tg->scx.bw_quota_us,
 				.bw_burst_us = tg->scx.bw_burst_us,
+				.idle = tg->scx.idle,
 			};
 
 			ret = SCX_CALL_OP_RET(sch, cgroup_init, NULL, css->cgroup, &args);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 53e136a47924..aa149a9c29f7 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -259,6 +259,9 @@ struct scx_cgroup_init_args {
 	u64			bw_period_us;
 	u64			bw_quota_us;
 	u64			bw_burst_us;
+
+	/* whether the cgroup is configured idle via cpu.idle */
+	bool			idle;
 };
 
 enum scx_cpu_preempt_reason {
-- 
2.43.0

