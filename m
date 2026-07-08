Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487853F58D1;
	Wed,  8 Jul 2026 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545879; cv=none; b=oq11rceoitUI4CtHHiliQeqTe8clKY78k5AbiNhioRgj5fGPbTXgu28oEOe3v1X7qwlxqpjd6MhF621cy3lMcvQv+et6RHccKgeuT51iHMLTmxBY1K8Eu6fdJCgNGb3QaROYsLcoBA3xg94jPUH+j2ZfLML44cDp7Bq96YFUYiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545879; c=relaxed/simple;
	bh=RZfXjQlqnBS15DaBCeoCptJQFie2pSYPSWpwhZvHfLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A81B1wacSCdCism5kDawPUXap3APjadPHTotRBk9ZqpH5zoGkMN7iD5fJS/fL6ZHuTwvoQyfrb250Ole/UZLO8zbkYh9oJfMSkTGrG1mbLorIAQwAaHpnnMI3hyCs0CrOB4CCWwGL21TDUV9TXhv5AoKcSc9BByS/ec+Ko6w2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAJYGhq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAJYGhq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39231F000E9;
	Wed,  8 Jul 2026 21:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545878;
	bh=20J9KeGu5/0//2NZR0+VzN9AF5WzXb9KGpXi7wNanu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PAJYGhq0EpehGjGxJKIe9aBmhBMR1OJDUNHTnZcMuahsdc64grcHPogtWWfXIzDBy
	 phWtLfyS7B0PNvL9QuhaRnCqhqwbdMQ/I1FEjcW1I8gRH5lR5jsaNCuTZyxNWUrGmg
	 3DwjphL//PP6ag3yNpraEwgPPj0zVhRZxMixr/b5A+HgTGAWYRRuuTh4gqYTGE3oFv
	 Bd1R3dRd0mv++eUP+EyKZyirrnJgrh+5aoDAhtJKPlj9ZQaxZTfHTI8ulyy5UGzuc2
	 bwW4v078RpbQz/H6XFe7bz3gGpa2AUJ6ASVpNU+JJmTZZfTcdbcLIeUEhmUiry+N3g
	 yFujvR26oqYrg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 07/40] tools/sched_ext: scx_qmap - Use bare u64/u32/s32 integer types
Date: Wed,  8 Jul 2026 11:23:56 -1000
Message-ID: <20260708212429.3405787-8-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708212429.3405787-1-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_qmap.c and the shared scx_qmap.h mixed __u64/__u32/__s32 with the bare
typedefs that scx/common.h provides. Convert the remaining __-prefixed
integer types to the bare forms for consistency. The struct fields become
bare u64 (uint64_t), so the stats printfs that fed them to %llu now cast to
unsigned long long. No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.c | 21 +++++++++++----------
 tools/sched_ext/scx_qmap.h | 34 +++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 67ddd483a4c7..f1eaebcab5dc 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -67,8 +67,8 @@ int main(int argc, char **argv)
 	struct scx_qmap *skel;
 	struct bpf_link *link;
 	struct qmap_arena *qa;
-	__u32 test_error_cnt = 0;
-	__u64 ecode;
+	u32 test_error_cnt = 0;
+	u64 ecode;
 	int opt;
 
 	libbpf_set_print(libbpf_print_fn);
@@ -202,15 +202,16 @@ int main(int argc, char **argv)
 
 		printf("stats  : enq=%lu dsp=%lu delta=%ld reenq/cid0=%llu/%llu deq=%llu core=%llu enq_ddsp=%llu\n",
 		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
-		       qa->nr_reenqueued, qa->nr_reenqueued_cid0,
-		       qa->nr_dequeued,
-		       qa->nr_core_sched_execed,
-		       qa->nr_ddsp_from_enq);
+		       (unsigned long long)qa->nr_reenqueued,
+		       (unsigned long long)qa->nr_reenqueued_cid0,
+		       (unsigned long long)qa->nr_dequeued,
+		       (unsigned long long)qa->nr_core_sched_execed,
+		       (unsigned long long)qa->nr_ddsp_from_enq);
 		printf("         exp_local=%llu exp_remote=%llu exp_timer=%llu exp_lost=%llu\n",
-		       qa->nr_expedited_local,
-		       qa->nr_expedited_remote,
-		       qa->nr_expedited_from_timer,
-		       qa->nr_expedited_lost);
+		       (unsigned long long)qa->nr_expedited_local,
+		       (unsigned long long)qa->nr_expedited_remote,
+		       (unsigned long long)qa->nr_expedited_from_timer,
+		       (unsigned long long)qa->nr_expedited_lost);
 		if (__COMPAT_has_ksym("scx_bpf_cidperf_cur"))
 			printf("cpuperf: cur min/avg/max=%u/%u/%u target min/avg/max=%u/%u/%u\n",
 			       qa->cpuperf_min,
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index d15a705d5ac5..808237540f5c 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -28,10 +28,10 @@
 #define SCX_QMAP_MAX_CPUS	1024
 
 struct cpu_ctx {
-	__u64 dsp_idx;		/* dispatch index */
-	__u64 dsp_cnt;		/* remaining count */
-	__u32 avg_weight;
-	__u32 cpuperf_target;
+	u64 dsp_idx;		/* dispatch index */
+	u64 dsp_cnt;		/* remaining count */
+	u32 avg_weight;
+	u32 cpuperf_target;
 };
 
 /* Opaque to userspace; defined in scx_qmap.bpf.c. */
@@ -40,25 +40,25 @@ struct task_ctx;
 struct qmap_fifo {
 	struct task_ctx __arena *head;
 	struct task_ctx __arena *tail;
-	__s32 idx;
+	s32 idx;
 };
 
 struct qmap_arena {
 	/* userspace-visible stats */
-	__u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cid0;
-	__u64 nr_dequeued, nr_ddsp_from_enq;
-	__u64 nr_core_sched_execed;
-	__u64 nr_expedited_local, nr_expedited_remote;
-	__u64 nr_expedited_lost, nr_expedited_from_timer;
-	__u64 nr_highpri_queued;
-	__u32 test_error_cnt;
-	__u32 cpuperf_min, cpuperf_avg, cpuperf_max;
-	__u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
+	u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_reenqueued_cid0;
+	u64 nr_dequeued, nr_ddsp_from_enq;
+	u64 nr_core_sched_execed;
+	u64 nr_expedited_local, nr_expedited_remote;
+	u64 nr_expedited_lost, nr_expedited_from_timer;
+	u64 nr_highpri_queued;
+	u32 test_error_cnt;
+	u32 cpuperf_min, cpuperf_avg, cpuperf_max;
+	u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
 
 	/* kernel-side runtime state */
-	__u64 sub_sched_cgroup_ids[MAX_SUB_SCHEDS];
-	__u64 core_sched_head_seqs[5];
-	__u64 core_sched_tail_seqs[5];
+	u64 sub_sched_cgroup_ids[MAX_SUB_SCHEDS];
+	u64 core_sched_head_seqs[5];
+	u64 core_sched_tail_seqs[5];
 
 	struct cpu_ctx cpu_ctxs[SCX_QMAP_MAX_CPUS];
 
-- 
2.54.0

