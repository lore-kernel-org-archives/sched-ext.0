Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445544;
	b=qxRtX027EPZdTxtjz5dvwTJrEnjI7Dvcf7e4Jop+atFNIEszq25u1zdmgtS5nG6Vtk/u
	 46kP6RPXIv944FbMDtc2sFc2qvl6gXj4YCmh35CLpNfugnR9Nj7dwiismD7LHoOS4ai/J
	 pOtmRiWKpq3PN3mxWAPkPEr3+FWvcOIShEReESYV+DJKUdxf+OolTYZr6F0bgHUtLsU0r
	 qqEUQb8PHUPgXu65JeDc7/fnC83J5gkhYAyzkzhFH3CbbowvmRb2Xi49h9+ByaQFumoee
	 HHYNqTGkHJBclypsmVmp84YXaHrqr1WgPE5LLJhrh5IjYPsQmSWp/AxI3/xZeP1QyUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=z9GvsEDuckMphGMjJIFYtPUmTzrOv5XPqKR74ZrQM74=;
	b=NjElmr5Y/Q5D+Lq/Uk8RhRxwgvOLi0VK5bcx1H+P3iG8X5A6xxldu9pVc2ESZJic9vpK
	 2hwVQ9fVYaw0n5KsRAiZS982o/4th31He1uDTUWjz6CXMpftkxTZe3r/VA6VUu/m/EqDk
	 kOM97So7GvL+71aKIqdSnE2jZEdC3N7qE+fcakn2CpUpTSuLPvIe4OZoad3Omqina7yYg
	 +nMjTQqHKwrp4uXUebJGbJUNCTKC8AUi/7u205cVcIv83yGSrzAfzquIYeseSqbB8w5iS
	 tOLkmpuDbx9WFl2pmcX5I+Z0gFYeNo6yTwa6nbzE5iKGCyozaXJ6iuefYL2GyxXHtSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rv0dVbqC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551BD606A321;
	Mon, 19 Oct 2026 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rv0dVbqC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0C01F000C5;
	Mon, 19 Oct 2026 21:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792445544;
	bh=z9GvsEDuckMphGMjJIFYtPUmTzrOv5XPqKR74ZrQM74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rv0dVbqC+MUvHwLJqmnJC9YJuExhh3mb0a5jna0Ll2mrnzu974OZTQ7cILFl8kQkh
	 uSLmeegFs7dBxQktw3CZSEV7Poi1qbtwRi/Iw/RhC06uCJVC/9MDTmCAA/XzPMjsEI
	 sHc36JQT48LBWSa0ymDmw/iPij3hbZZRI6IHYk67anqGmEFPeGG5fYFxCMmIMsdNhO
	 g4y5eW6bOVQ29CKOpDbX+hXfCBPcSKoTpALKnMM/btZGUOiuEbN22Or4mg5/9R6rWF
	 QlPA22cl/QlzJVjRH/iD3IzX23BRqDj3wDvpIn2n4G1I2ARoARi//NPekyC+B9zahE
	 HQY57SK6zrYiQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched_ext: scx_qmap: Drop the compat code
Date: Mon, 19 Oct 2026 11:32:20 -1000
Message-ID: <20261019213221.2919481-2-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019213221.2919481-1-tj@kernel.org>
References: <20261019213221.2919481-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_qmap demonstrates and tests the sched_ext features of the kernel it
ships with. It already requires that kernel, as it implements
ops.sub_cid_sched_updated() and ops.sub_child_ecaps_updated(), so its compat
checks only keep untested fallbacks around. Drop them, use the kernel
interfaces directly, and note the coupling in the top comment. No functional
change on a current kernel.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 31 ++++++++++++++++---------------
 tools/sched_ext/scx_qmap.c     | 14 +++++---------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 63e3c9080e77..77f02fb70a86 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -10,6 +10,10 @@
  * - Core-sched support.
  * - Hierarchical sub-scheduling: delegating cpus to child cgroup schedulers.
  *
+ * scx_qmap is often used to exercise sched_ext features as they land. It is
+ * coupled with the kernel it ships with and uses its sched_ext interfaces
+ * directly. It isn't expected to load on other kernels.
+ *
  * Base design: Five FIFOs (arena-backed doubly-linked lists through per-task
  * context). A task is assigned to a FIFO by its compound weight. Each cpu
  * round-robins the FIFOs, dispatching more from higher ones.
@@ -583,14 +587,13 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	}
 
 	/* see lowpri_timerfn() */
-	if (__COMPAT_has_generic_reenq() &&
-	    p->scx.weight < 2 && !(p->flags & PF_KTHREAD) && !(enq_flags & SCX_ENQ_REENQ)) {
+	if (p->scx.weight < 2 && !(p->flags & PF_KTHREAD) && !(enq_flags & SCX_ENQ_REENQ)) {
 		scx_bpf_dsq_insert(p, LOWPRI_DSQ, slice_ns, enq_flags);
 		return;
 	}
 
 	/* if select_cid() wasn't called, try direct dispatch */
-	if (!__COMPAT_is_enq_cpu_selected(enq_flags) &&
+	if (!(enq_flags & SCX_ENQ_CPU_SELECTED) &&
 	    (cid = pick_direct_dispatch_cid(p, scx_bpf_task_cid(p), taskc)) >= 0) {
 		__sync_fetch_and_add(&qa.nr_ddsp_from_enq, 1);
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | cid, slice_ns,
@@ -1316,7 +1319,7 @@ static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
 
 		dump_shared_dsq();
 
-		__COMPAT_scx_bpf_events(&events, sizeof(events));
+		scx_bpf_events(&events, sizeof(events));
 
 		bpf_printk("%35s: %lld", "SCX_EV_SELECT_CPU_FALLBACK",
 			   scx_read_event(&events, SCX_EV_SELECT_CPU_FALLBACK));
@@ -2097,17 +2100,15 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 	if (ret)
 		return ret;
 
-	if (__COMPAT_has_generic_reenq()) {
-		/* see lowpri_timerfn() */
-		timer = bpf_map_lookup_elem(&lowpri_timer, &key);
-		if (!timer)
-			return -ESRCH;
-		bpf_timer_init(timer, &lowpri_timer, CLOCK_MONOTONIC);
-		bpf_timer_set_callback(timer, lowpri_timerfn);
-		ret = bpf_timer_start(timer, LOWPRI_INTV_NS, 0);
-		if (ret)
-			return ret;
-	}
+	/* see lowpri_timerfn() */
+	timer = bpf_map_lookup_elem(&lowpri_timer, &key);
+	if (!timer)
+		return -ESRCH;
+	bpf_timer_init(timer, &lowpri_timer, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(timer, lowpri_timerfn);
+	ret = bpf_timer_start(timer, LOWPRI_INTV_NS, 0);
+	if (ret)
+		return ret;
 
 	/* sub-sched: drive the boundary-cid round-robin from a bpf timer */
 	timer = bpf_map_lookup_elem(&round_robin_timer, &key);
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 17cf584a2a3d..9b1cbe187ebd 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -294,7 +294,7 @@ int main(int argc, char **argv)
 	optind = 1;
 	skel = SCX_OPS_CID_OPEN(qmap_ops, scx_qmap);
 
-	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
+	skel->rodata->slice_ns = skel->rodata->__SCX_SLICE_DFL;
 	skel->rodata->max_tasks = 16384;
 
 	while ((opt = getopt(argc, argv,
@@ -512,14 +512,10 @@ int main(int argc, char **argv)
 		       (unsigned long long)qa->nr_expedited_remote,
 		       (unsigned long long)qa->nr_expedited_from_timer,
 		       (unsigned long long)qa->nr_expedited_lost);
-		if (__COMPAT_has_ksym("scx_bpf_cidperf_cur"))
-			printf("cpuperf: cur min/avg/max=%u/%u/%u target min/avg/max=%u/%u/%u\n",
-			       qa->cpuperf_min,
-			       qa->cpuperf_avg,
-			       qa->cpuperf_max,
-			       qa->cpuperf_target_min,
-			       qa->cpuperf_target_avg,
-			       qa->cpuperf_target_max);
+		printf("cpuperf: cur min/avg/max=%u/%u/%u target min/avg/max=%u/%u/%u\n",
+		       qa->cpuperf_min, qa->cpuperf_avg, qa->cpuperf_max,
+		       qa->cpuperf_target_min, qa->cpuperf_target_avg,
+		       qa->cpuperf_target_max);
 
 		invoke_flush_alloc(skel);
 		print_hier(qa, &hprev, own_cgid);
-- 
2.56.0

