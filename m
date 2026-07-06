Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9972384228;
	Mon,  6 Jul 2026 01:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783302086; cv=none; b=fhSmoa71mMDx1c8Nr7JbViPUTFjIhi3jQhAfTBipDy/JCM/lOR6vem2qy080k8JHfOOC9W9mtkWY/PYvofqRRI5FZGUbgZgVzvS0DwKPOeZwkKnSt05lCFwpV3gDMgY7MobpKdwCu6iz6h5S3gBvD71JuxCEa+DqtppGoxKLQCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783302086; c=relaxed/simple;
	bh=3IBUel2eEB+9x1iwNBfuAnafu0JgH7WzCBOMF+9DgQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svVaAQ2589d030kdgDUpH6mhJ5CHyG9n6obIByAr7ce2oW+bSOteWkOcMi/dRrefopyFVxDAFPcuBWWPZ6LCZ1ZBRlXQBGJWpycK95uL8runCOfF0Y4kgvbBufky7jLfJEL4n6kgS1BXE7H5htP5ifBLnOL4vDiAQT30FbsCXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fELC1hLW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fELC1hLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C0F1F00A3D;
	Mon,  6 Jul 2026 01:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783302084;
	bh=Df8izVnzjPaQZqUj2x9K6i1SiZo5FSk7Nrlgvr7xuc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fELC1hLWfq7cm3I6Wbv5I0XoDySj3h/uNwFaVmXxlR7R3/Du4eKFqnNKsH8YeFyzi
	 Gkk8zN0ajXAC4MeplGMeleWFuVILk3dSk5956bI/FCYFTDrZZXdhyD9D9OkAeVUbag
	 A202KqqLhNCxWAbH/zIZ1zo52OfvhB9BS8H70IRPtozaf1kyjbG8zXTe4ZEKwqGU9T
	 jZNqhe86T4Jd1VDORjiEPR1k3rb9vnpiinUdjyIUGM1elYZU9opwjNtbVFkEIww9Jd
	 rkDRn0auqdQQ49FnI2xSQ2zG97KgQJxdVtsMzLtpiXhZ1XVbBYEVIepiZ7+JlsISc4
	 lcvgKLP+gnhsQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 sched_ext/for-7.3 25/36] sched_ext: Add the SCX_CAP_ENQ_IMMED cap
Date: Sun,  5 Jul 2026 15:40:47 -1000
Message-ID: <20260706014058.439853-26-tj@kernel.org>
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

Replace the __SCX_CAP_DUMMY placeholder with SCX_CAP_ENQ_IMMED, which gates
inserting IMMED tasks onto a cid's local DSQ. An IMMED enqueue is guaranteed
to either get its task running on the cpu at once or hand it back to the
scheduler, so IMMED work can never pile up on the cpu's queue and a cpu can
be shared across sub-scheds through IMMED access without any of them
swamping it.

That makes ENQ_IMMED the natural baseline, the minimal cap to make any use
of a cpu. SCX_CAP_BASE aliases it so gates on basic cpu access can state the
intention instead of naming ENQ_IMMED.

Enforcement covers inserts and queued tasks. An insert without the cap is
diverted to the reject DSQ, and queued tasks are reenqueued when the cap is
lost. scx_bpf_sub_dispatch() skips a child that lacks the cap on the cpu, as
its inserts would only be rejected. Vacating the running task on cap loss
lands in a later patch.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |  2 +-
 kernel/sched/ext/internal.h | 11 ++++++++---
 kernel/sched/ext/sub.c      |  8 ++++++++
 kernel/sched/ext/sub.h      |  4 ++--
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9f41f77cfb17..796b857c7219 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4752,7 +4752,7 @@ SCX_ATTR(events);
 
 #ifdef CONFIG_EXT_SUB_SCHED
 static const char *scx_cap_names[__SCX_NR_CAPS] = {
-	[__SCX_CAP_DUMMY]	= "dummy",
+	[__SCX_CAP_ENQ_IMMED]	= "enq_immed",
 };
 
 static ssize_t scx_attr_caps_show(struct kobject *kobj,
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 7cc7e10457d7..5d4edd505ed1 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1270,17 +1270,22 @@ struct scx_sched_pnode {
  * topology-aligned and likely to serve as the locality unit when cids are
  * allocated to schedulers, so per-shard lock granularity scales naturally with
  * the allocation pattern.
+ *
+ * ENQ_IMMED  insert an IMMED task onto the cid's local DSQ
  */
 enum scx_cap_flags {
-	__SCX_CAP_DUMMY			= 0,
+	__SCX_CAP_ENQ_IMMED		= 0,
 
 	__SCX_NR_CAPS,
 	__SCX_CAP_ALL			= BIT_U64(__SCX_NR_CAPS) - 1,
 
-	SCX_CAP_DUMMY			= BIT_U64(__SCX_CAP_DUMMY),
+	SCX_CAP_ENQ_IMMED		= BIT_U64(__SCX_CAP_ENQ_IMMED),
+
+	/* alias for minimal cap to make any use of a cpu */
+	SCX_CAP_BASE			= SCX_CAP_ENQ_IMMED,
 
 	/* caps whose loss strands queued tasks, see scx_process_sync_ecaps() */
-	SCX_CAPS_REENQ_ON_LOSS		= 0,
+	SCX_CAPS_REENQ_ON_LOSS		= SCX_CAP_ENQ_IMMED,
 };
 
 #ifdef CONFIG_EXT_SUB_SCHED
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index e79d30aba0cc..380e6e5ea72f 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1248,6 +1248,14 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *
 		return false;
 	}
 
+	/*
+	 * Skip a child that does not effectively hold the base cap on this cpu:
+	 * its inserts would only be rejected. ecaps are synced at the top of
+	 * balance_one() before dispatch, so this reflects the in-effect state.
+	 */
+	if (scx_missing_caps(child, cpu_of(this_rq), SCX_CAP_BASE))
+		return false;
+
 	return scx_dispatch_sched(child, this_rq, this_rq->scx.sub_dispatch_prev,
 				  true);
 }
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 89d1458ff450..ea8bea347bb0 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -105,13 +105,13 @@ static inline u64 scx_missing_caps(struct scx_sched *sch, s32 cpu, u64 needed)
 /* map @enq_flags to the SCX_CAP_* bit required for the local-DSQ insert */
 static inline u64 scx_caps_for_enq(u64 enq_flags)
 {
-	return 0;
+	return SCX_CAP_ENQ_IMMED;
 }
 
 /* map queued @p to the SCX_CAP_* bit required to stay on its local DSQ */
 static inline u64 scx_caps_for_task(struct task_struct *p)
 {
-	return 0;
+	return SCX_CAP_ENQ_IMMED;
 }
 
 /* caps implied by holding @cap */
-- 
2.54.0

