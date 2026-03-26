Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8900831A55B
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774517007; cv=none; b=UsiX0Y0eKm/CXDHfn5TOsSO0DGjntnodC4QwJB+IRJRexVyr884/Apj03AJsQy/aoBIlTXel67TQxpq3Mj6j4L+15QC8j4WnDTkalOsWCb9VFm78Tv0aBUEipdvkYi2sTAlp6qLN6uHjFtqD2z5y2YE90B6kv6cWB37QRlm659U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774517007; c=relaxed/simple;
	bh=UIeZM1Rih8redGTLOVhUM5EOPoekZOr07MP3LYxFguo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYhb7apChwEyrTHSYfniwSL+KrQk/Y3slcMyrFScBToWr+MiUVkQ3A0yWj8oqH+wBPp3cW6/wIjo7deW2yejsfhJW8003Pz/mdhujZiJSYeklNH/YnzpbEE6XCaK2KIYUe83rdA1KS4p85QQIJcmFteLGM3h5YaUCtqhVP3ZauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=o8YjOm+f; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="o8YjOm+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mE
	7QChujbAfwdIe8F3YyGwvh9G0sMmK+/ROCqdamUwc=; b=o8YjOm+f90NCXb6r5n
	vwglI/oNltNS2iTGGjwq8g2QlF+pu6tD8735LPV0f7s7mwnObvzK7jpRyeTsfHo3
	NuYrXKiBc/PmwePULWFqXySU9493cZVTrHpA+V32ndMM4Mjtr14moUgsWH3EgCkd
	2fYNC180HG3XGZJtCZqdcADkc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD391Qw+cRpggwvAg--.46626S2;
	Thu, 26 Mar 2026 17:15:29 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhaomengmeng@kylinos.cn
Subject: [PATCH] tools/sched_ext: scx_central: start timer from central dispatch
Date: Thu, 26 Mar 2026 17:15:23 +0800
Message-ID: <20260326091523.299333-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD391Qw+cRpggwvAg--.46626S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JrWftF15Jw4rKw1xXFWfAFb_yoW7GFWkpF
	ZrCFyfAF1jqrW2qw4ktr4kCry3ZasxXryxKrs3KwnIvF4xCr1UtF1UtF4S9F43GrWkAa42
	yF409FZxGanYy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_3ktUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqxEWjWnE+TGEyQAA3J

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

scx_central currently assumes that ops.init() runs on the selected
central CPU and aborts otherwise. This is no longer true, as ops.init()
is invoked from the scx_enable_helper thread, which can run on any
CPU. As a result, sched_setaffinity() from userspace doesn't work, loading
scx_central can fail with:

[ 1985.319942] sched_ext: central: scx_central.bpf.c:314: init from non-central CPU
[ 1985.320317]    scx_exit+0xa3/0xd0
[ 1985.320535]    scx_bpf_error_bstr+0xbd/0x220
[ 1985.320840]    bpf_prog_3a445a8163fa8149_central_init+0x103/0x1ba
[ 1985.321073]    bpf__sched_ext_ops_init+0x40/0xa8
[ 1985.321286]    scx_root_enable_workfn+0x507/0x1650
[ 1985.321461]    kthread_worker_fn+0x260/0x940
[ 1985.321745]    kthread+0x303/0x3e0
[ 1985.321901]    ret_from_fork+0x589/0x7d0
[ 1985.322065]    ret_from_fork_asm+0x1a/0x30

DEBUG DUMP
===================================================================

central: root
scx_enable_help[134] triggered exit kind 1025:
  scx_bpf_error (scx_central.bpf.c:314: init from non-central CPU)

To fix it, initialize the BPF timer from ops.init(), but defer
bpf_timer_start() to the first dispatch on the central CPU. This preserves
the requirement that the timer be started from the central CPU when
BPF_F_TIMER_CPU_PIN is used, without depending on the CPU affinity of
the enable path.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 tools/sched_ext/scx_central.bpf.c | 60 ++++++++++++++++++++-----------
 tools/sched_ext/scx_central.c     |  1 -
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 399e8d3f8bec..b2d9b1164603 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -60,6 +60,7 @@ const volatile u32 nr_cpu_ids = 1;	/* !0 for veristat, set during init */
 const volatile u64 slice_ns;
 
 bool timer_pinned = true;
+bool timer_started;
 u64 nr_total, nr_locals, nr_queued, nr_lost_pids;
 u64 nr_timers, nr_dispatches, nr_mismatches, nr_retries;
 u64 nr_overflows;
@@ -179,9 +180,47 @@ static bool dispatch_to_cpu(s32 cpu)
 	return false;
 }
 
+static void start_central_timer(void)
+{
+	struct bpf_timer *timer;
+	u32 key = 0;
+	int ret;
+
+	if (likely(timer_started))
+		return;
+
+	timer = bpf_map_lookup_elem(&central_timer, &key);
+	if (!timer) {
+		scx_bpf_error("failed to lookup central timer");
+		return;
+	}
+
+	ret = bpf_timer_start(timer, TIMER_INTERVAL_NS, BPF_F_TIMER_CPU_PIN);
+	/*
+	 * BPF_F_TIMER_CPU_PIN is pretty new (>=6.7). If we're running in a
+	 * kernel which doesn't have it, bpf_timer_start() will return -EINVAL.
+	 * Retry without the PIN. This would be the perfect use case for
+	 * bpf_core_enum_value_exists() but the enum type doesn't have a name
+	 * and can't be used with bpf_core_enum_value_exists(). Oh well...
+	 */
+	if (ret == -EINVAL) {
+		timer_pinned = false;
+		ret = bpf_timer_start(timer, TIMER_INTERVAL_NS, 0);
+	}
+
+	if (ret) {
+		scx_bpf_error("bpf_timer_start failed (%d)", ret);
+		return;
+	}
+
+	timer_started = true;
+}
+
 void BPF_STRUCT_OPS(central_dispatch, s32 cpu, struct task_struct *prev)
 {
 	if (cpu == central_cpu) {
+		start_central_timer();
+
 		/* dispatch for all other CPUs first */
 		__sync_fetch_and_add(&nr_dispatches, 1);
 
@@ -310,29 +349,10 @@ int BPF_STRUCT_OPS_SLEEPABLE(central_init)
 	if (!timer)
 		return -ESRCH;
 
-	if (bpf_get_smp_processor_id() != central_cpu) {
-		scx_bpf_error("init from non-central CPU");
-		return -EINVAL;
-	}
-
 	bpf_timer_init(timer, &central_timer, CLOCK_MONOTONIC);
 	bpf_timer_set_callback(timer, central_timerfn);
 
-	ret = bpf_timer_start(timer, TIMER_INTERVAL_NS, BPF_F_TIMER_CPU_PIN);
-	/*
-	 * BPF_F_TIMER_CPU_PIN is pretty new (>=6.7). If we're running in a
-	 * kernel which doesn't have it, bpf_timer_start() will return -EINVAL.
-	 * Retry without the PIN. This would be the perfect use case for
-	 * bpf_core_enum_value_exists() but the enum type doesn't have a name
-	 * and can't be used with bpf_core_enum_value_exists(). Oh well...
-	 */
-	if (ret == -EINVAL) {
-		timer_pinned = false;
-		ret = bpf_timer_start(timer, TIMER_INTERVAL_NS, 0);
-	}
-	if (ret)
-		scx_bpf_error("bpf_timer_start failed (%d)", ret);
-	return ret;
+	return 0;
 }
 
 void BPF_STRUCT_OPS(central_exit, struct scx_exit_info *ei)
diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
index fd4c0eaa4326..f4bed0e69357 100644
--- a/tools/sched_ext/scx_central.c
+++ b/tools/sched_ext/scx_central.c
@@ -98,7 +98,6 @@ int main(int argc, char **argv)
 
 	/*
 	 * Affinitize the loading thread to the central CPU, as:
-	 * - That's where the BPF timer is first invoked in the BPF program.
 	 * - We probably don't want this user space component to take up a core
 	 *   from a task that would benefit from avoiding preemption on one of
 	 *   the tickless cores.
-- 
2.43.0

