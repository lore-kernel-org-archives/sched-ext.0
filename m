Received: from mta1.migadu.com (out-116.mta1.migadu.com [95.215.58.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70C2EEE75
	for <sched-ext@lists.linux.dev>; Tue, 25 Aug 2026 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625405; cv=none; b=hoKXtjuYhgEDV9GSG6Z2K3SBZvcW/dBlQkQZ96/yenZAs/tJ4Fg49//N3e7ZgmA+uY5oGgncKQNUxfAfwuDXgPnL/3zwJqp56zU5U1S3khM9JfpTrvR7wQ4fisGxdtCsoW68bCSIBU2bzvlR5VDHC/hZKV9Qu2zw3ILFqBl61Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625405; c=relaxed/simple;
	bh=RDHKP6vi2P0mwUjTZ0I8B0pUXzcuPpJIMnY+GJKK9Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKLeN/YeuaUokYRxPScqJWtnVMflp+hX1P/7fCV1QyPAjAwVl2nfvW+IZaPrl3T+yo3ttjRLnKFheqAZyrpzuHghhmMDSte8kvyyf9m0ctxYY9WypJ84/UKSZ9eaXhOirUR936frE33W4c+hLOO4xmZRPyyKRmt8b+1dag9J/yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uzAZaE7q; arc=none smtp.client-ip=95.215.58.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uzAZaE7q"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=RDHKP6vi2P0mwUjTZ0I8B0pUXzcuPpJIMnY+GJKK9Gs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787625402; v=1; x=1788230202;
 b=uzAZaE7qfpAvCWjj6eIb3GsLNqcyEXRqU1+ddM6Up4tv511iSr1nZopbNiQuPV/H8KDvz4qD
 ppjpnErsIOhR7/qjfKCAQqan5P4QkiU878tKRQnVm7RW9I++J3qfAG1ifL8zRYlJJa4TuNHaa3W
 pVYjPdN5iP/SqumIjzD3x7F0=
X-Envelope-To: sched-ext@lists.linux.dev
Received: from ctao-book.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id e9a2453b1ed5d049;
	Tue, 25 Aug 2026 02:36:42 +0000
X-Mizu-Trace-ID: e9a2453b1ed5d049
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
Subject: [PATCH v3 1/2] sched_ext: pass the initial cpu.idle state in scx_cgroup_init_args
Date: Tue, 25 Aug 2026 10:35:56 +0800
Message-ID: <20260825023557.27881-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825023557.27881-1-cui.tao@linux.dev>
References: <20260825023557.27881-1-cui.tao@linux.dev>
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

Add the sched_idle state to scx_cgroup_init_args and fill it in all
four places that build the args: scx_tg_online() for cgroups onlined
under the scheduler, scx_cgroup_init() for cgroups that already exist
when the scheduler is loaded, and the sub-scheduler handover paths
scx_cgroup_claim_subtree() and scx_cgroup_return_subtree().

Verified in a VM with a probe scheduler printing the init args: a
cgroup configured cpu.idle=1 before loading shows sched_idle=1 in
ops.cgroup_init(), the default shows 0, and later cpu.idle writes
still come through ops.cgroup_set_idle(). The sub-scheduler paths
are compile-tested only.

Fixes: 347ed2d566da ("sched/ext: Implement cgroup_set_idle() callback")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
v2 -> v3: Rename the new field to sched_idle, as a bare "idle" reads
as CPU idle state in sched_ext, per Tejun. Add the Fixes: tag
suggested by Andrea. Regenerated on top of current linux-next, which
also resolves the CI conflict reported for v2. The tg->scx.idle
rename now lives in 2/2.

v2: https://lore.kernel.org/r/20260824142817.568085-1-cui.tao@linux.dev

 kernel/sched/ext/ext.c      | 4 +++-
 kernel/sched/ext/internal.h | 3 +++
 kernel/sched/ext/sub.c      | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index c539d15cda63..82cf8f57e15c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4764,7 +4764,8 @@ int scx_tg_online(struct task_group *tg)
 				{ .weight = tg->scx.weight,
 				  .bw_period_us = tg->scx.bw_period_us,
 				  .bw_quota_us = tg->scx.bw_quota_us,
-				  .bw_burst_us = tg->scx.bw_burst_us };
+				  .bw_burst_us = tg->scx.bw_burst_us,
+				  .sched_idle = tg->scx.idle };
 
 			ret = SCX_CALL_OP_RET(sch, cgroup_init,
 					      NULL, tg->css.cgroup, &args);
@@ -5185,6 +5186,7 @@ static int scx_cgroup_init(struct scx_sched *sch)
 				.bw_period_us = tg->scx.bw_period_us,
 				.bw_quota_us = tg->scx.bw_quota_us,
 				.bw_burst_us = tg->scx.bw_burst_us,
+				.sched_idle = tg->scx.idle,
 			};
 
 			ret = SCX_CALL_OP_RET(sch, cgroup_init, NULL, css->cgroup, &args);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 53e136a47924..c6987a3a073b 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -259,6 +259,9 @@ struct scx_cgroup_init_args {
 	u64			bw_period_us;
 	u64			bw_quota_us;
 	u64			bw_burst_us;
+
+	/* whether the cgroup is configured SCHED_IDLE via cpu.idle */
+	bool			sched_idle;
 };
 
 enum scx_cpu_preempt_reason {
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 0554448835bd..385302d19914 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1361,6 +1361,7 @@ static s32 scx_cgroup_claim_subtree(struct scx_sched *sch)
 			.bw_period_us = tg->scx.bw_period_us,
 			.bw_quota_us = tg->scx.bw_quota_us,
 			.bw_burst_us = tg->scx.bw_burst_us,
+			.sched_idle = tg->scx.idle,
 		};
 
 		if (tg->scx.sched != parent ||
@@ -1464,6 +1465,7 @@ static void scx_cgroup_return_subtree(struct scx_sched *sch)
 			.bw_period_us = tg->scx.bw_period_us,
 			.bw_quota_us = tg->scx.bw_quota_us,
 			.bw_burst_us = tg->scx.bw_burst_us,
+			.sched_idle = tg->scx.idle,
 		};
 
 		/* the first pass must have transferred everything */
-- 
2.43.0

