Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35248413243;
	Wed, 29 Apr 2026 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486908; cv=none; b=YOFkzzi1P1bvy8ecQzNg7QU8r374MBXxXV9ApKNVzDstuhjuKKFlJ62v1GTpoJ8cTDO7W1DrIMH0sw0viE10U7lIc7PnlVUOiM8qnXOe0j8MqT0xYlhz9gYx/qDRU2R6A4/xD/KQdpe3KkcZI1A4IFIOIN47sjtS82XKL5DCY9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486908; c=relaxed/simple;
	bh=SiWl4FiwlfAGbK5wC9+bpKGMph5yt/QzjwWSkwjOePI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnIlnY5uNgvFBKtm0WKB1A5LcqiPvZMJLSz912AyDBIO7aKslzWin8BOr+NoKVLnjmaHhiVpUjZzFQqfsPslfMtOV2ZLXWYaIf38y2Axv+J1e+1bLud25tVpQQ8Hitd16VdJdbausFrYNCAEYJKLUFw3k+LjfMCfLcXhkQ1RZOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1elOMqk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1elOMqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE46C2BCC6;
	Wed, 29 Apr 2026 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486908;
	bh=SiWl4FiwlfAGbK5wC9+bpKGMph5yt/QzjwWSkwjOePI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1elOMqk/R7csNPIKwtKuufO04cMRn6Z1sYIr3TZi1RuQqfuNGat5LdsOC1i5iNNq
	 89H91+phbHwcQjWrzm3yBM4OsgI6geRgUmfyUTawhP05v68xNRt3WnWrSeOeXBYB5O
	 TG/AT2pHYi+awT50KYlSOAAf1jr95o64KiTfxkiFyxpopUUsiDo9RJ7OREOtpzhF+G
	 ARwu7vu8MIbAhQnEG9d9L4h7rmGy3ycX2R6T3dfjimGLol1ClUEYuNTEUKRZxif+7t
	 ShfRYsT6ggaEXnwgJP3RorUVUpVvnol24/gWyq8hSkynIQcbEUP322CkhCE5yJLH9L
	 flQxvhNnEmdQg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 14/17] tools/sched_ext: scx_qmap: Restart on hotplug instead of cpu_online/offline
Date: Wed, 29 Apr 2026 08:21:28 -1000
Message-ID: <20260429182131.1780125-15-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429182131.1780125-1-tj@kernel.org>
References: <20260429182131.1780125-1-tj@kernel.org>
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
Reviewed-by: Changwoo Min <changwoo@igalia.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
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
2.54.0

