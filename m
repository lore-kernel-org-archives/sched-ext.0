Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9976151991;
	Sat, 25 Oct 2025 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761351532; cv=none; b=SpkAEHmBetNQBv5OwVE2ykAj6ZBbP8QcHWUc4LimZVOLcydjdAsfPKgMIA+UZY+OzsCOCQtABpdvR32Y8EHiNV+8u2hrq3JP2TmYOdjhC/mQy8qNx/ZBuOfWDrb0up5NGqCilnip639e9o/JAW/isjr80MtIUAr/W6mdmDoSVs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761351532; c=relaxed/simple;
	bh=D0cN6ZPy+rP+c0RA8XNA3BI6huhtVTa4OqN+uJKky9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXD7uaD4xNvz/D2ckOL/oSnRH0g/+jMG9GQudh66vZUhtMBPnrw3NBnLdraU4HAnPuaFe0x8NP0U/Usu60X400Pn0h9keRDa0sOuoeGoOFCOcz2+2zYLo9IFZlRlGddwYCueWaoIXYmpPZYz+6SAEs4cn8k8t18IlFZEN6mcHA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKFjrAWZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKFjrAWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C046C4CEFB;
	Sat, 25 Oct 2025 00:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761351532;
	bh=D0cN6ZPy+rP+c0RA8XNA3BI6huhtVTa4OqN+uJKky9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKFjrAWZqdwPfB6AlgVS/hLW7MSw8JdthVViYSyExB+LJ1u2vFp9coZok+xOb5xJk
	 D+hv/oU4Kv2bgNwHXVnaXCbtQI9tCDRCj4gPy+5rGajrjt167xKNgP04v5HfxyrH1n
	 7OIGCLZbxX9s6rxOn69ZKDCuA5U7wX2/20DlivMqhg2euZq3ns/hJWC4CBQmrBDR4B
	 pBx7VgU0OL7Re7LjBDeTlEfiUpPbUEpmSMCdg/i0Lx3qj+PM/ikA+ts2iZDV4n0OtI
	 crrCASdCBfZ5RMV/PnLVLP/kFlppXBInXFP0QxPtX9eA+yRId7wgBG7jWIFbseBLMt
	 UvdmvH2NIWMgA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Wen-Fang Liu <liuwenfang@honor.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/3] sched_ext: Factor out reenq_local() from scx_bpf_reenqueue_local()
Date: Fri, 24 Oct 2025 14:18:48 -1000
Message-ID: <20251025001849.1915635-3-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251025001849.1915635-1-tj@kernel.org>
References: <20251025001849.1915635-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out the core re-enqueue logic from scx_bpf_reenqueue_local() into a
new reenq_local() helper function. scx_bpf_reenqueue_local() now handles the
BPF kfunc checks and calls reenq_local() to perform the actual work.

This is a prep patch to allow reenq_local() to be called from other contexts.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 111111111111..222222222222 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5881,32 +5881,12 @@ static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
 	.set			= &scx_kfunc_ids_dispatch,
 };

-__bpf_kfunc_start_defs();
-
-/**
- * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
- *
- * Iterate over all of the tasks currently enqueued on the local DSQ of the
- * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the number of
- * processed tasks. Can only be called from ops.cpu_release().
- */
-__bpf_kfunc u32 scx_bpf_reenqueue_local(void)
+static u32 reenq_local(struct rq *rq)
 {
-	struct scx_sched *sch;
 	LIST_HEAD(tasks);
 	u32 nr_enqueued = 0;
-	struct rq *rq;
 	struct task_struct *p, *n;

-	guard(rcu)();
-	sch = rcu_dereference(scx_root);
-	if (unlikely(!sch))
-		return 0;
-
-	if (!scx_kf_allowed(sch, SCX_KF_CPU_RELEASE))
-		return 0;
-
-	rq = cpu_rq(smp_processor_id());
 	lockdep_assert_rq_held(rq);

 	/*
@@ -5943,6 +5923,34 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
 	return nr_enqueued;
 }

+__bpf_kfunc_start_defs();
+
+/**
+ * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
+ *
+ * Iterate over all of the tasks currently enqueued on the local DSQ of the
+ * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the number of
+ * processed tasks. Can only be called from ops.cpu_release().
+ */
+__bpf_kfunc u32 scx_bpf_reenqueue_local(void)
+{
+	struct scx_sched *sch;
+	struct rq *rq;
+
+	guard(rcu)();
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return 0;
+
+	if (!scx_kf_allowed(sch, SCX_KF_CPU_RELEASE))
+		return 0;
+
+	rq = cpu_rq(smp_processor_id());
+	lockdep_assert_rq_held(rq);
+
+	return reenq_local(rq);
+}
+
 __bpf_kfunc_end_defs();

 BTF_KFUNCS_START(scx_kfunc_ids_cpu_release)
--
2.47.1
