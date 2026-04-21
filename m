Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8661339B1;
	Tue, 21 Apr 2026 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755833; cv=none; b=Vujw0ztzLKaQoW9iBRttNwphLpq1Ze8P2XPxa52SMZ//FL5Y6BEIZ3EWBattitpaKbv/SB0B6sadZI6/sTMx0d5ZJoOlgJVz3B9B1FDfCjYo906W1ZqtWZ3FeIxVoS3clatYVlR7sk3cFF3CkaFd6wIJnunbu8FcWCdQ6rjzyvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755833; c=relaxed/simple;
	bh=lPxRQ5guX2I4vph30L0P4y4QgfEecldR9gfPaeHo3AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmHxqApecGv8GNdRGnn7JW0KE9ktvdgqbp0XCGayOhT08RpyehFYoPijPDBvlDQyMR3I2bRoQ3TU3uyuYtYBnTz4WE+dscgy8dKbo3DcA8tmbiWH3sxDW52JsRPbTxqkpj9uhYELcvGDRAualls/aRj822l/I4BJGjSEQStzZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXyqHqhw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXyqHqhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC9DC2BCB6;
	Tue, 21 Apr 2026 07:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776755832;
	bh=lPxRQ5guX2I4vph30L0P4y4QgfEecldR9gfPaeHo3AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXyqHqhwfblJA3rav7ij1rYkSwO95Juo2wv2I1KQmiaRhnms0cG4m3t9aSbQeE7ex
	 iCiYibiaE+u2414lcFZqNpp3dapCKTKEOtLsNEo5WJJTUHDdwYYDDfr7C6rc8ic6Ax
	 o9E0PsmceqaBwcOIcQ8p20w/XrJOZcrqkseUjGRIywzRD3SjnwtQ9shzEGRzlZmwv6
	 lEERrHJtJXRL44m0KC+g4TrAmZVxKP26KZMTKYAvZ/e81syohX/dlX050DskUeNP46
	 qhu/cicadFKa7ShNNGOgTnC2u8yVEgqPpLVntNhU2l8VfwrEOIfAs2KUJjvUGOhztL
	 zEAqaptH0DZSw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-7.1-fixes] tools/sched_ext: scx_qmap: Silence task_ctx lookup miss
Date: Mon, 20 Apr 2026 21:17:11 -1000
Message-ID: <20260421071711.3108449-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <59bc5171ee5aa02746c2f576d0f1e14f@kernel.org>
References: <59bc5171ee5aa02746c2f576d0f1e14f@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_fork() dispatches ops.init_task to exactly one scheduler - the one
owning the forking task's cgroup. A task forked inside a sub-scheduler's
cgroup is init'd into the sub only; the root scheduler has no task_ctx
entry for it. When that task later appears as @prev in the root's
qmap_dispatch() (or flows through core-sched comparison via task_qdist),
the bpf_task_storage_get() legitimately misses.

qmap treated those misses as fatal via scx_bpf_error("task_ctx lookup
failed") and aborted the scheduler as soon as the first cross-sched
task hit the root. Drop the error in the sites where the miss is
legitimate: lookup_task_ctx() (helper; callers already check for NULL),
qmap_dispatch()'s @prev branch (bookkeeping-only), task_qdist()
(returns 0 which makes the comparison a no-op), and qmap_select_cpu()
(returns prev_cpu as a no-op fallback instead of -ESRCH). The existing
scx_error was a paranoid guard from the pre-sub-sched world where every
task was owned by the one and only scheduler.

v2: qmap_select_cpu() returns prev_cpu on NULL instead of -ESRCH, so
    the root scheduler doesn't error on cross-sched tasks that pass
    through it (Andrea Righi).

Fixes: 4f8b122848db ("sched_ext: Add basic building blocks for nested sub-scheduler dispatching")
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 tools/sched_ext/scx_qmap.bpf.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index b68abb9e760b..aad698fe294b 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -159,13 +159,7 @@ static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu)
 
 static struct task_ctx *lookup_task_ctx(struct task_struct *p)
 {
-	struct task_ctx *tctx;
-
-	if (!(tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0))) {
-		scx_bpf_error("task_ctx lookup failed");
-		return NULL;
-	}
-	return tctx;
+	return bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
 }
 
 s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
@@ -175,7 +169,7 @@ s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 	s32 cpu;
 
 	if (!(tctx = lookup_task_ctx(p)))
-		return -ESRCH;
+		return prev_cpu;
 
 	if (p->scx.weight < 2 && !(p->flags & PF_KTHREAD))
 		return prev_cpu;
@@ -540,13 +534,9 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	 */
 	if (prev) {
 		tctx = bpf_task_storage_get(&task_ctx_stor, prev, 0, 0);
-		if (!tctx) {
-			scx_bpf_error("task_ctx lookup failed");
-			return;
-		}
-
-		tctx->core_sched_seq =
-			core_sched_tail_seqs[weight_to_idx(prev->scx.weight)]++;
+		if (tctx)
+			tctx->core_sched_seq =
+				core_sched_tail_seqs[weight_to_idx(prev->scx.weight)]++;
 	}
 }
 
@@ -584,10 +574,8 @@ static s64 task_qdist(struct task_struct *p)
 	s64 qdist;
 
 	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
-	if (!tctx) {
-		scx_bpf_error("task_ctx lookup failed");
+	if (!tctx)
 		return 0;
-	}
 
 	qdist = tctx->core_sched_seq - core_sched_head_seqs[idx];
 
-- 
2.53.0

