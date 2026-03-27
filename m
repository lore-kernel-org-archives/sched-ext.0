Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600B833A9D3
	for <sched-ext@lists.linux.dev>; Fri, 27 Mar 2026 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774592315; cv=none; b=r8bY/KfGYxbTXAo/tAlsv0l2vc901XBFRUB9po0DDU9V+b5xAW8iIUpYwLAV2NoX/gMD5BNgxvXkCFwuEF3TrtOwVS+2Skr1nJqyqAdD1BdAFFKeh5JpuDKHjXKiJSTEmC+9FXgVPh3QqJmuFau1SIzL04RuSNmgwWtFAp0EtwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774592315; c=relaxed/simple;
	bh=b/lQ0xtRPomqOeqilusoWC6LJkzps+btxDFUZn8eYKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EyzoR/pKC5o887sj7KPEMLR2DYaEPavvfLGWfLNGmjympjyUmAXzesdHBj7WGiDQq1bDWBKNu4pdqm2f3+1jRGTQf/a7BmZmx6kfB9yFMNch5WafgAqEklkic3gAflqNvD18WK+aa7rpo7bG3yDWeOTnutwRdSJ16V+oVZIfH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ZZaqplt9; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ZZaqplt9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vE
	lCNqJQP706filSx6HKAEMrNOm0zS0AqOYeueLdRRU=; b=ZZaqplt9aoEsxZALY1
	kkjZmICV8M+XD+zwIaMbu1HJGhTiGbc0xBc2rmjh4yWzyqm+Hao4qAnM//fmB23K
	Lob6TwjUNzAdbNGpZinAi9SBxqLHbn+yTyhtaLXprZt/GESl3l9CrZeRhu5a3KUu
	o0/fbn/HbENXqRoaZ7ZgDWrDE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3FRAcIcZprXLQAQ--.25271S2;
	Fri, 27 Mar 2026 14:18:04 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhaomengmeng@kylinos.cn
Subject: [PATCH RESEND v2] scx_central: Defer timer start to central dispatch to fix init error
Date: Fri, 27 Mar 2026 14:17:57 +0800
Message-ID: <20260327061757.252255-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3FRAcIcZprXLQAQ--.25271S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JrWfZFy8JrW3KFy7CF43trb_yoWxAryUpF
	srCFyfJr1YqrWjvwsrtr4kCry3Xa17XryUtrWfGwnavF4xur4jqF1UtF4SqFWDGrWkAa42
	yFW09FZxGFsYyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_3ktUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqxxb0mnGIRw54AAA31

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

scx_central currently assumes that ops.init() runs on the selected
central CPU and aborts otherwise. This is no longer true, as ops.init()
is invoked from the scx_enable_helper thread, which can run on any
CPU.

As a result, sched_setaffinity() from userspace doesn't work, causing
scx_central to fail when loading with:

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

Fix this by:
- Defer bpf_timer_start() to the first dispatch on the central CPU.
- Initialize the BPF timer in central_init() and kick the central CPU
to guarantee entering the dispatch path on the central CPU immediately.
- Remove the unnecessary sched_setaffinity() call in userspace.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
V2:
- Remove sched_setaffinity() call and kick central cpu at ops.init() as
suggested by Tejun.
- Refactor the commit message and header for better clarity.
---
 tools/sched_ext/scx_central.bpf.c | 62 +++++++++++++++++++++----------
 tools/sched_ext/scx_central.c     | 24 ------------
 2 files changed, 42 insertions(+), 44 deletions(-)

diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 399e8d3f8bec..4efcce099bd5 100644
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
 
@@ -310,29 +349,12 @@ int BPF_STRUCT_OPS_SLEEPABLE(central_init)
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
+	scx_bpf_kick_cpu(central_cpu, 0);
+
+	return 0;
 }
 
 void BPF_STRUCT_OPS(central_exit, struct scx_exit_info *ei)
diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
index fd4c0eaa4326..4a72df39500d 100644
--- a/tools/sched_ext/scx_central.c
+++ b/tools/sched_ext/scx_central.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
  */
 #define _GNU_SOURCE
-#include <sched.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <inttypes.h>
@@ -49,8 +48,6 @@ int main(int argc, char **argv)
 	struct bpf_link *link;
 	__u64 seq = 0, ecode;
 	__s32 opt;
-	cpu_set_t *cpuset;
-	size_t cpuset_size;
 
 	libbpf_set_print(libbpf_print_fn);
 	signal(SIGINT, sigint_handler);
@@ -96,27 +93,6 @@ int main(int argc, char **argv)
 
 	SCX_OPS_LOAD(skel, central_ops, scx_central, uei);
 
-	/*
-	 * Affinitize the loading thread to the central CPU, as:
-	 * - That's where the BPF timer is first invoked in the BPF program.
-	 * - We probably don't want this user space component to take up a core
-	 *   from a task that would benefit from avoiding preemption on one of
-	 *   the tickless cores.
-	 *
-	 * Until BPF supports pinning the timer, it's not guaranteed that it
-	 * will always be invoked on the central CPU. In practice, this
-	 * suffices the majority of the time.
-	 */
-	cpuset = CPU_ALLOC(skel->rodata->nr_cpu_ids);
-	SCX_BUG_ON(!cpuset, "Failed to allocate cpuset");
-	cpuset_size = CPU_ALLOC_SIZE(skel->rodata->nr_cpu_ids);
-	CPU_ZERO_S(cpuset_size, cpuset);
-	CPU_SET_S(skel->rodata->central_cpu, cpuset_size, cpuset);
-	SCX_BUG_ON(sched_setaffinity(0, cpuset_size, cpuset),
-		   "Failed to affinitize to central CPU %d (max %d)",
-		   skel->rodata->central_cpu, skel->rodata->nr_cpu_ids - 1);
-	CPU_FREE(cpuset);
-
 	link = SCX_OPS_ATTACH(skel, central_ops, scx_central);
 
 	if (!skel->data->timer_pinned)
-- 
2.43.0

