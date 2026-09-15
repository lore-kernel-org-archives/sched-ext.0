Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9C3F4822;
	Tue, 15 Sep 2026 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460848; cv=none; b=NCzG/yrtOVOvG0i5DReYHpBsOm01A+/qBCodvFmoN0rjsWdEEF1xqLq38EApTjxUZ9hxemAJxdw0uZVuWMAPqCppklg47TwMCI0ytbDzCrdkW7gaEM0AujilYjR+W44/OSHM4KeB3Yk3jUNAsvoSWMpjWzJ5WvG3QVsooKcrxEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460848; c=relaxed/simple;
	bh=EoITR9MgKRkdbU+Wd/pinOXtHCeQ2Li68ANN5DaaVtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDEcyjWuG09Gi7uAvXFFGis0Im8zDK8ilp2mgM7Ks4xpStoYSXqTujqv2WTY+NYN73B7IQuESYT3bNRfVn1PJ8qYEBoGQwwy/Qs7kUZDde1cMO3ze7TPvWqOrJzzrtIastP7UuUP6C+YVCpAIUonu36NlHlwtoO6NS9bHa4huzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Igb3laVz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Igb3laVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CAB1F000FF;
	Tue, 15 Sep 2026 08:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789460847;
	bh=qHRmm+cI246vD6A7bWbM6BkkYOUFWmeL5yk0BxRBmlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Igb3laVzqKq+kqEsteRVo2Jkx9lulR9ShlfAX2wNfRkx51ZDfokbpQm9I6sj+KtwO
	 ylHc1iBkVnp7l0ZYLJceGOpIZbSnagjE23lYzPXUSCuHNqnOs5LiVf47SrWn9janRv
	 tL/T3a4zqKp2QWBSEcBWJTV49nyDfiZGIIz71SYmFvuJ8W1u5YiMBe8/qoIm0aPt4T
	 7/daH63usEEtiqpi8JA+kS4mcTAug/V5qvIBa3xGgDBj6APwEmdobCOFJeGf4DJ3EW
	 ztSyoBt/U/y4LV3tbZNL6fxBP0zKQ+tDMnOGrxgpJcnv4D2wX3u2Rqn2xtqAn2Avph
	 0Eyn9HxdXeeoQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched_ext: scx_qmap: Restore unused idle claims from ops.dispatch()
Date: Mon, 14 Sep 2026 22:27:24 -1000
Message-ID: <20260915082725.3881071-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915082725.3881071-1-tj@kernel.org>
References: <20260915082725.3881071-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_qmap tracks idle cids itself. pick_direct_dispatch_cid() claims a cid by
clearing its bit and the task is inserted into that cid's local DSQ, which
kicks the CPU. When the task does not arrive, for example because the insert
fell back to the global DSQ after an affinity change, the CPU wakes, finds
nothing and picks idle again. That is not an idle transition, so
ops.update_idle() is not called and the cid stays marked busy until an
unrelated task runs on it.

Restore the claim from ops.dispatch(). The kick guarantees a dispatch on the
kicked CPU, and when it finds nothing to run with a NULL @prev, the CPU is
going back to idle. Document the pattern in ops.update_idle(), which reports
only actual transitions.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/internal.h    |  6 ++++++
 tools/sched_ext/scx_qmap.bpf.c | 14 ++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 076a351bb3f2..0adaf649d5e0 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -572,6 +572,12 @@ struct sched_ext_ops {
 	 *
 	 * Specify the %SCX_OPS_KEEP_BUILTIN_IDLE flag to keep the built-in idle
 	 * tracking.
+	 *
+	 * Only actual transitions are reported. A CPU that is claimed with an
+	 * idle pick and kicked but dispatches no task returns to idle without a
+	 * transition. A scheduler tracking idle CPUs itself must restore the
+	 * idle state from ops.dispatch() when it returns without the next task
+	 * to run.
 	 */
 	void (*update_idle)(s32 cpu, bool idle);
 
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index bda56c37acb5..67b7c01cae55 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -818,10 +818,10 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cid, struct task_struct *prev)
 			batch--;
 			cpuc->dsp_cnt--;
 			if (!batch || !scx_bpf_dispatch_nr_slots()) {
-				if (scan_shared_dsq(false))
+				if (scan_shared_dsq(false) ||
+				    scx_bpf_dsq_move_to_local(SHARED_DSQ, needs_immed(cid)))
 					return;
-				scx_bpf_dsq_move_to_local(SHARED_DSQ, needs_immed(cid));
-				return;
+				goto prev;
 			}
 			if (!cpuc->dsp_cnt)
 				break;
@@ -832,10 +832,14 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cid, struct task_struct *prev)
 
 	if (scan_shared_dsq(false))
 		return;
-
+prev:
 	/*
 	 * No other tasks. @prev will keep running. Update its core_sched_seq as
 	 * if the task were enqueued and dispatched immediately.
+	 *
+	 * No @prev to keep running means the CPU goes idle. If its claim was
+	 * never used, that is not a transition and ops.update_idle() stays
+	 * silent. Restore the claim here.
 	 */
 	if (prev) {
 		taskc = lookup_task_ctx(prev);
@@ -844,6 +848,8 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cid, struct task_struct *prev)
 
 		taskc->core_sched_seq =
 			qa.core_sched_tail_seqs[weight_to_idx(prev->scx.weight)]++;
+	} else {
+		cmask_set(cid, &qa.idle_cids.mask);
 	}
 }
 
-- 
2.55.0

