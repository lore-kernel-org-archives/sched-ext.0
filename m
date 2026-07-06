Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3F37CD37;
	Mon,  6 Jul 2026 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302098; cv=none; b=j0TrC4BuWb/nLn+CgUHT52mbOsMEiUmQglOYAQcyakyBAVeLEYQ85KppIEk+oMaPZjVRj8uA90uhMF55LGpBeMrxSs5mw+1CwLi8UzWJ4jnv6h7eXKDCVMbSnw7Az0+TWw6MRCAM3BgStdhqFZtGVKrly1/ZktvJlAGGYDcpqsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302098; c=relaxed/simple;
	bh=RGKfyV1SOs8zMBTDs67UZhxGPZu6Wbtr4GrZfqixGzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLQx6ymz+jQjGcrJzdp4/mCPYhokA73uUPbJBearCRKrQcf/GraILdjbRsF98CJPL098Pd1QN2tmEE+/daFzKOefkFwE5oJSItysgtqw4iaZovdtYK5CZp37qZzH1AaLfPv9sXpPQeiWeOl6AMDnj6L537nNC0SF/OxcGmHmMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3f1VqY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3f1VqY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF981F00A3E;
	Mon,  6 Jul 2026 01:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302096;
	bh=uRK3i8pudc/U6e4Sfqy4BKS4q95uVeTuLU2sv/v4ErE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D3f1VqY38x1MObv2AvbqRxv3xE1L5J+uQ4RU9Qie2Km+NkOK0Y0pzHkEA3n1SLqKI
	 GEA2mdT5sQ6LhjL1cPak6jlqDGajpeqE2I5YnPUx9OjyW5dp2LBXpDvvIWTbOT3U5X
	 ZzecTtiP8pMQK0LKFoMfJibEiW8bdNjhyQLmnR9+PT24MSBgek1wgJXt0Q5JfYsZaV
	 HxbYoiAsM/BShGBSr2UXk/+ule4eCmMA3uZHEy1QUxEWG/ZKFbCNU88E58b6bXuzZL
	 Ini4+ew146XGi9rXFb3MPpbbl/pTK0tRvqMl9SlTo/aMJPCF1Exu/fRsYyeCGO1D1Q
	 NTqajhIC/lvNA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 36/36] tools/sched_ext: scx_qmap - Add sub-sched cap fault injection
Date: Sun,  5 Jul 2026 15:40:58 -1000
Message-ID: <20260706014058.439853-37-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706014058.439853-1-tj@kernel.org>
References: <20260706014058.439853-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a fault-injection mode to the scx_qmap sub-scheduler that deliberately
dispatches one of its own tasks to a cid it does not hold. The kernel cap
check must reject it and re-enqueue with SCX_TASK_REENQ_CAP, so the
nr_inject_attempts counter tracks nr_reenq_cap one to one, exercising the
delivery-time cap enforcement.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 40 ++++++++++++++++++++++++++++++++++
 tools/sched_ext/scx_qmap.c     | 20 +++++++++++++----
 tools/sched_ext/scx_qmap.h     |  8 +++++++
 3 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 64422e9e1db8..73d769f9a2aa 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -376,6 +376,24 @@ static u64 needs_immed(s32 cid)
 	return qa.cid_shared[cid] ? SCX_ENQ_IMMED : 0;
 }
 
+/* first cid this node does NOT hold for fault injection, -1 if none */
+static s32 first_unavail_cid(void)
+{
+	s32 nr_cids = qa.nr_cids, c;
+
+	if (nr_cids > SCX_QMAP_MAX_CPUS) {
+		scx_bpf_error("-ERANGE");
+		return -1;
+	}
+
+	bpf_for(c, 0, nr_cids) {
+		if (!cmask_test(c, &qa.held_excl.mask) &&
+		    !cmask_test(c, &qa.held_shared.mask))
+			return c;
+	}
+	return -1;
+}
+
 static int weight_to_idx(u32 weight)
 {
 	/* Coarsely map the compound weight to a FIFO. */
@@ -452,6 +470,28 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		}
 	}
 
+	/*
+	 * Fault injection: deliberately dispatch one of our own tasks to a cid
+	 * we don't hold. The kernel cap check must reject it and re-enqueue
+	 * with SCX_TASK_REENQ_CAP, so nr_inject_attempts tracks nr_reenq_cap
+	 * and proves delivery-time enforcement. Throttled.
+	 */
+	if (qa.inject_mode == QMAP_INJ_WRONG_CID && p->nr_cpus_allowed > 1 &&
+	    !(enq_flags & SCX_ENQ_REENQ)) {
+		static u32 inj_cnt;
+
+		if (!(++inj_cnt % 64)) {
+			s32 bad = first_unavail_cid();
+
+			if (bad >= 0 && cmask_test(bad, &taskc->cpus_allowed)) {
+				__sync_fetch_and_add(&qa.nr_inject_attempts, 1);
+				scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL_ON | bad,
+						   slice_ns, enq_flags);
+				return;
+			}
+		}
+	}
+
 	/*
 	 * IMMED stress testing: Every immed_stress_nth'th enqueue, dispatch
 	 * directly to prev_cpu's local DSQ even when busy to force dsq->nr > 1
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 1efffaaa8fe8..d3f766b692b8 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -52,7 +52,7 @@ const char help_fmt[] =
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-l COUNT] [-b COUNT]\n"
 "       [-N COUNT] [-P] [-M] [-H] [-c CG_PATH] [-d PID] [-D LEN] [-S] [-p] [-I]\n"
-"       [-F COUNT] [-i SEC] [-R MS] [-v]\n"
+"       [-F COUNT] [-i SEC] [-R MS] [-J MODE] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
@@ -74,6 +74,7 @@ const char help_fmt[] =
 "  -C MODE       cid-override test (shuffle|bad-dup|bad-range|bad-mono)\n"
 "  -i SEC        Stats and weight-refresh interval, seconds (default 5)\n"
 "  -R MS         Round-robin period for time-shared cpus, ms (default 200)\n"
+"  -J MODE       Fault injection (wrong-cid: dispatch to a cid not held)\n"
 "  -v            Print libbpf debug messages\n"
 "  -h            Display this help and exit\n";
 
@@ -183,6 +184,7 @@ struct hier_prev {
 	u64 nr_dsps[MAX_SUB_SCHEDS];
 	u64 nr_reenq_cap;
 	u64 nr_reenq_immed;
+	u64 nr_inject_attempts;
 };
 
 /* current wall-clock time as "HH:MM:SS" for the startup and interval headers */
@@ -264,12 +266,14 @@ static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cg
 	}
 
 	format_cid_ranges(qa, CID_SHARED, ranges, sizeof(ranges));
-	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu\n",
+	printf("hier   : nsub=%llu excl=%u shared=%s rr=%s reenq cap/immed +%llu/+%llu inj=+%llu\n",
 	       (unsigned long long)qa->nr_sub_scheds, qa->part.nr_excl, ranges, rr,
 	       (unsigned long long)(qa->nr_reenq_cap - prev->nr_reenq_cap),
-	       (unsigned long long)(qa->nr_reenq_immed - prev->nr_reenq_immed));
+	       (unsigned long long)(qa->nr_reenq_immed - prev->nr_reenq_immed),
+	       (unsigned long long)(qa->nr_inject_attempts - prev->nr_inject_attempts));
 	prev->nr_reenq_cap = qa->nr_reenq_cap;
 	prev->nr_reenq_immed = qa->nr_reenq_immed;
+	prev->nr_inject_attempts = qa->nr_inject_attempts;
 
 	printf("hier   : %-4s %10s %4s %6s %8s  %s\n",
 	       "", "cgroup", "w", "alloc", "disp/s", "cids");
@@ -310,6 +314,7 @@ int main(int argc, char **argv)
 	struct hier_prev hprev = {};
 	const char *sub_cg_path = NULL;
 	char tbuf[32];
+	u32 inject_mode = 0;
 	u64 own_cgid = 0;
 
 	libbpf_set_print(libbpf_print_fn);
@@ -330,7 +335,7 @@ int main(int argc, char **argv)
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 	skel->rodata->max_tasks = 16384;
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:vh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:J:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -464,6 +469,12 @@ int main(int argc, char **argv)
 			if (round_robin_ms < 10)
 				round_robin_ms = 10;
 			break;
+		case 'J':
+			if (!strcmp(optarg, "wrong-cid"))
+				inject_mode = QMAP_INJ_WRONG_CID;
+			else
+				inject_mode = strtoul(optarg, NULL, 0);
+			break;
 		case 'v':
 			verbose = true;
 			break;
@@ -480,6 +491,7 @@ int main(int argc, char **argv)
 
 	qa = &skel->arena->qa;
 	qa->test_error_cnt = test_error_cnt;
+	qa->inject_mode = inject_mode;
 
 	if (sub_cg_path)
 		printf("%s scx_qmap started: sub-scheduler on %s, stats every %ds\n",
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index c87d61c37fe1..7b22b0f9737f 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -60,6 +60,12 @@ struct qmap_fifo {
 	s32 idx;
 };
 
+/* -J fault-injection modes. Selects inject_mode in struct qmap_arena. */
+enum qmap_inject {
+	QMAP_INJ_OFF		= 0,
+	QMAP_INJ_WRONG_CID	= 1,	/* dispatch to a cid we don't hold */
+};
+
 /*
  * scx_cmask's are embedded in struct qmap_arena with inline backing storage.
  * The bpf side uses &field.mask with the normal cmask_* helpers. Userspace
@@ -167,6 +173,8 @@ struct qmap_arena {
 	/* bpf -> userspace: stats */
 	u64 nr_reenq_cap;		/* SCX_TASK_REENQ_CAP bounces */
 	u64 nr_reenq_immed;		/* SCX_TASK_REENQ_IMMED bounces */
+	u64 nr_inject_attempts;		/* fault-injection: dispatches to an unheld cid */
+	u32 inject_mode;		/* fault-injection mode (QMAP_INJ_*) */
 };
 
 #endif /* __SCX_QMAP_H */
-- 
2.54.0

