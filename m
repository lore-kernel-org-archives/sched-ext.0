Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C52777FC;
	Fri, 24 Apr 2026 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994357; cv=none; b=tDlFpmSELww2q6jeWBTACF23QlsZWvlHTwEfwXAE8cxonPTTZY9xnCHvFSy3rMqV2IAQzAK0SYe7aKnBOzd4avh0a/RQDqRK7WgrRt7s4k2BHL02SNz3NOkJ+WCVSEyDx02WgtfpIttL7VollIUyUaUOxL4aoZQd91GO0DZB9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994357; c=relaxed/simple;
	bh=xhxvxur1R7nTKgjiuPnwJLrAHZqLwz0lvrWf9U7Mzus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gl985hyp2gsxtPUGjTXpQvq27JEw/V5jqEIznXsh/qlbCUWEvqNFl5IGcRkQaFW8cn/KP/fYNV7wBIFdwq29xnfxrOv9GQB4p6W3zN6VGIJGCxuECI4TQbX3DBBvachLMjm//q/3YLs7BTcD0VlhnSPt+1gga6tLl9H29+ALk84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHbfBgrG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHbfBgrG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A327EC2BCAF;
	Fri, 24 Apr 2026 01:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776994356;
	bh=xhxvxur1R7nTKgjiuPnwJLrAHZqLwz0lvrWf9U7Mzus=;
	h=From:To:Cc:Subject:Date:From;
	b=YHbfBgrGrpUiiG1yRTkupB1u4fuKpL9/HHw3dxgPbGBKvuhx4kcB/GpnO8w4lkwKH
	 WTJOUp/ZWjq1p9jTSJjKY77CSq5uekvFT9TK8aE1+YoQ9wui/DQ+Vl23/kDM4Cs3Pc
	 al1Ib0uSlp7sFdheCJiqg8BXO+eZnK9p4VoF3Wn7zh0F3+JQnvdG5g03zaM1z0Zjt7
	 x7SxFg1va+or5VhU/4WScLzZGhQWq7cLB7/44mon2ni506y1BoF2JfAiemKLEHQFN+
	 8fQm+sXdAjc531sRSxTF2QZfH9jfjU1WmuRVCJKSy9vRAhssz+GSLlarYoKCX4Qegm
	 c24XHe85HdiEg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomzhao@126.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 14/17] tools/sched_ext: scx_qmap: Restart on hotplug instead of cpu_online/offline
Date: Thu, 23 Apr 2026 15:32:17 -1000
Message-ID: <20260424013220.2923402-15-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cid mapping is built from the online cpu set at scheduler enable
and stays valid for that set; routine hotplug invalidates it. The
default cid behavior is to restart the scheduler so the mapping gets
rebuilt against the new online set, and that requires not implementing
cpu_online / cpu_offline (which suppress the kernel's ACT_RESTART).

Drop the two ops along with their print_cpus() helper - the cluster
view was only useful as a hotplug demo and is meaningless over the
dense cid space the scheduler will move to. Wire main() to handle the
ACT_RESTART exit by reopening the skel and reattaching, matching the
pattern in scx_simple / scx_central / scx_flatcg etc. Reset optind so
getopt re-parses argv into the fresh skel rodata each iteration.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 62 ----------------------------------
 tools/sched_ext/scx_qmap.c     | 13 +++----
 2 files changed, 7 insertions(+), 68 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index ba4879031dac..78a1dd118c7e 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -843,63 +843,6 @@ void BPF_STRUCT_OPS(qmap_cgroup_set_bandwidth, struct cgroup *cgrp,
 			   cgrp->kn->id, period_us, quota_us, burst_us);
 }
 
-/*
- * Print out the online and possible CPU map using bpf_printk() as a
- * demonstration of using the cpumask kfuncs and ops.cpu_on/offline().
- */
-static void print_cpus(void)
-{
-	const struct cpumask *possible, *online;
-	s32 cpu;
-	char buf[128] = "", *p;
-	int idx;
-
-	possible = scx_bpf_get_possible_cpumask();
-	online = scx_bpf_get_online_cpumask();
-
-	idx = 0;
-	bpf_for(cpu, 0, scx_bpf_nr_cpu_ids()) {
-		if (!(p = MEMBER_VPTR(buf, [idx++])))
-			break;
-		if (bpf_cpumask_test_cpu(cpu, online))
-			*p++ = 'O';
-		else if (bpf_cpumask_test_cpu(cpu, possible))
-			*p++ = 'X';
-		else
-			*p++ = ' ';
-
-		if ((cpu & 7) == 7) {
-			if (!(p = MEMBER_VPTR(buf, [idx++])))
-				break;
-			*p++ = '|';
-		}
-	}
-	buf[sizeof(buf) - 1] = '\0';
-
-	scx_bpf_put_cpumask(online);
-	scx_bpf_put_cpumask(possible);
-
-	bpf_printk("CPUS: |%s", buf);
-}
-
-void BPF_STRUCT_OPS(qmap_cpu_online, s32 cpu)
-{
-	if (print_msgs) {
-		bpf_printk("CPU %d coming online", cpu);
-		/* @cpu is already online at this point */
-		print_cpus();
-	}
-}
-
-void BPF_STRUCT_OPS(qmap_cpu_offline, s32 cpu)
-{
-	if (print_msgs) {
-		bpf_printk("CPU %d going offline", cpu);
-		/* @cpu is still online at this point */
-		print_cpus();
-	}
-}
-
 struct monitor_timer {
 	struct bpf_timer timer;
 };
@@ -1078,9 +1021,6 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 		slab[i].next_free = (i + 1 < max_tasks) ? &slab[i + 1] : NULL;
 	qa.task_free_head = &slab[0];
 
-	if (print_msgs && !sub_cgroup_id)
-		print_cpus();
-
 	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
 	if (ret) {
 		scx_bpf_error("failed to create DSQ %d (%d)", SHARED_DSQ, ret);
@@ -1174,8 +1114,6 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .cgroup_set_bandwidth	= (void *)qmap_cgroup_set_bandwidth,
 	       .sub_attach		= (void *)qmap_sub_attach,
 	       .sub_detach		= (void *)qmap_sub_detach,
-	       .cpu_online		= (void *)qmap_cpu_online,
-	       .cpu_offline		= (void *)qmap_cpu_offline,
 	       .init			= (void *)qmap_init,
 	       .exit			= (void *)qmap_exit,
 	       .timeout_ms		= 5000U,
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 725c4880058d..99408b1bb1ec 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -67,12 +67,14 @@ int main(int argc, char **argv)
 	struct bpf_link *link;
 	struct qmap_arena *qa;
 	__u32 test_error_cnt = 0;
+	__u64 ecode;
 	int opt;
 
 	libbpf_set_print(libbpf_print_fn);
 	signal(SIGINT, sigint_handler);
 	signal(SIGTERM, sigint_handler);
-
+restart:
+	optind = 1;
 	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
 
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
@@ -184,11 +186,10 @@ int main(int argc, char **argv)
 	}
 
 	bpf_link__destroy(link);
-	UEI_REPORT(skel, uei);
+	ecode = UEI_REPORT(skel, uei);
 	scx_qmap__destroy(skel);
-	/*
-	 * scx_qmap implements ops.cpu_on/offline() and doesn't need to restart
-	 * on CPU hotplug events.
-	 */
+
+	if (UEI_ECODE_RESTART(ecode))
+		goto restart;
 	return 0;
 }
-- 
2.53.0

