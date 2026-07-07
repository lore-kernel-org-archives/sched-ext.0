Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615B919C556;
	Tue,  7 Jul 2026 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383157; cv=none; b=jU/Lj+taXYkhYeVvCpPp3tuopYepwNwm2ApayQXy3l4egyxnnXiadyQki0FqV4Tdm8NfhtBlhFB4nVTFG10hrBe0kDCexBVexjlW6YURDtqWFhaHo0rUa6zwQKjt9WfVPvv9q8KnSmKKg+85Ugm4YZCvxGaxTsZcO141l7O5AyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383157; c=relaxed/simple;
	bh=RZfXjQlqnBS15DaBCeoCptJQFie2pSYPSWpwhZvHfLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsEtwdnX+zee8LNjm4GYolx+IKeFNVGpJ3TfUcqyPIpYVKcF7Ka4jkJC6Iv3g8mtrsUaKktrxwrsWwBtIQ8Bra8t9mdmXyJ0XlKE7e4z/a/qRLYKixGnuJ5NAqH8+bUjYhypX+NMMaLEkqDZ0iZVbJUd+z5+ch/z8p7exCrHFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+xLzdkP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+xLzdkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DF51F00A3A;
	Tue,  7 Jul 2026 00:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783383156;
	bh=20J9KeGu5/0//2NZR0+VzN9AF5WzXb9KGpXi7wNanu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+xLzdkPwO4no0XEPDjHgBXSUnmA4JpCiZYzyX+VNQvaK3CpUBaMAnyQA/FqIIg9v
	 dbeRaT9VN49oPdMC96wUs8PxnEYc5ITcnT+5j4EXGUh43Ktb8E/X300XSusfUL79U7
	 HPR93MqBmgwmQn6lZk5PPqVolyvh4CZTDrOTlk61dMq2uUATIl0blYSrBWbqxAGwmp
	 HHoHRHjOvStGEsAyKRmeSNb24vDZcVzoJCO5evHyTiOnbW/LxwSa138HOTPR+eNG5b
	 fPbQ2rlb3ICd+ZVe7N0bl0kLFh3rTrz18bG4M6o+81WEWivBDo2l3s/Q2nYznnXZCz
	 sgCt/uyWbfalQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 sched_ext/for-7.3 06/36] tools/sched_ext: scx_qmap - Use bare u64/u32/s32 integer types
Date: Mon,  6 Jul 2026 14:11:59 -1000
Message-ID: <20260707001229.1410929-7-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707001229.1410929-1-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
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

