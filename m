Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9F23EDE5D;
	Thu,  9 Jul 2026 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637480; cv=none; b=utu5wztYPsbmYlih4MrZ2yv5aTZiunwWlw9Efdgmt5xaSyMkXwlLXgfrblznHR9ZXlwobN/2Esgdw5Tiw8A7KA17hVP6vSYi2aO5rltJDnwIa2j3teKIu9o4vHXqPWAI6DLxkQTNWLjsdX7jbsmni4xCPa1OfnkJNEyzfWK/rEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637480; c=relaxed/simple;
	bh=kzeD+K+tLXCgL4NTWoT0D15WcGG5T6hI48dOkQ8dDRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7GLxLHLaD5kO6oDvfmnIAgP8uKzEUb8MO3FVaOSjz6S7f2pmtRJx5unP1MOVtkvkis98hTKbBW/paDnEAh5+mjeVmcgnNU8zidgqwJ9POrRfofR1eHGfIDSpKgTaCXjgGMezB0GR6ZJdKca+Zqn72Kl2hrMPppxt14erTxFUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwmbtl/+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwmbtl/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD541F000E9;
	Thu,  9 Jul 2026 22:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637479;
	bh=DWh7ovSM85yq4DJo7Ysr6PBSlf48q7qYVC4ZnRfTtcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mwmbtl/+18hE0Ib1d/wwx4YJRmfaWtnTqXCjfkeo/Wys8fKPn9qKGBOcAqvBjxgWI
	 oi2eD2CT3X325jQ1l94BOjr/4QF1ujrtid+8peuqrhToKv7U3PEjWzUU1AGjZkF3wx
	 zOg4pqOjAfB/DXvo5/OhhG6WicnwS5e6yO9+gYOLN1AyvpM19fMQ8Z6Q5wfg6S0zFB
	 g/bsMli+jASUeITA+9u/YDBlnXLJZqFGcPXHIxXJeq+JFgYJP7fZtlWSI2CYXB53k4
	 R7cRcwBXArNYanjjHayfJ+JiBdLeoSN+PxcvZ9ft/qw5K4Pi6S5IMjc0hvV0k8fuWN
	 v0P5qsSV25yIw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 sched_ext/for-7.3 33/33] tools/sched_ext: scx_qmap - Add sub-sched cap fault injection
Date: Thu,  9 Jul 2026 12:50:41 -1000
Message-ID: <20260709225041.1695495-34-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709225041.1695495-1-tj@kernel.org>
References: <20260709225041.1695495-1-tj@kernel.org>
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
index 49840c49d1fa..66c53182cb02 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -378,6 +378,24 @@ static u64 needs_immed(s32 cid)
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
@@ -454,6 +472,28 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
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
index 8249229f25bd..dda3ddf5b749 100644
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
 
@@ -184,6 +185,7 @@ struct hier_prev {
 	u64 nr_dsps[MAX_SUB_SCHEDS];
 	u64 nr_reenq_cap;
 	u64 nr_reenq_immed;
+	u64 nr_inject_attempts;
 };
 
 /* current wall-clock time as "HH:MM:SS" for the startup and interval headers */
@@ -265,12 +267,14 @@ static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cg
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
@@ -311,6 +315,7 @@ int main(int argc, char **argv)
 	struct hier_prev hprev = {};
 	const char *sub_cg_path = NULL;
 	char tbuf[32];
+	u32 inject_mode = 0;
 	u64 own_cgid = 0;
 
 	libbpf_set_print(libbpf_print_fn);
@@ -331,7 +336,7 @@ int main(int argc, char **argv)
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 	skel->rodata->max_tasks = 16384;
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:vh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:N:PMHc:d:D:SpIF:C:i:R:J:vh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -465,6 +470,12 @@ int main(int argc, char **argv)
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
@@ -481,6 +492,7 @@ int main(int argc, char **argv)
 
 	qa = &skel->arena->qa;
 	qa->test_error_cnt = test_error_cnt;
+	qa->inject_mode = inject_mode;
 
 	if (sub_cg_path)
 		printf("%s scx_qmap started: sub-scheduler on %s, stats every %ds\n",
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index 5d44c11c75dd..87642d21fce3 100644
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
2.55.0

