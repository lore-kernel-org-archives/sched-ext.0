Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25FA37F8A1;
	Tue, 21 Apr 2026 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776751990; cv=none; b=VKwzrLAQnXhjtQT9CZaDA65nrZhIbyjxa4YfzpjYTtjesSjhhnRR1ZZ87NtdiwF+9O67BUv+T4Lw0CEr32KU7JUkQ0fYgc1VJ93IFw+ZIvdFhJuLqxdKmFCmtp3aFgqHv43uCCPLTSgydQuPaY176yT4+Jw4GmzqxZvwzLa3Dxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776751990; c=relaxed/simple;
	bh=KV91lfAC2WsS9BzW8PsnW+AmKGOxNLyZol45jXyFIuU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=aFCt+SxHsZ+u4Da/lmGyC/CT0c0IOjgbf/fQnb5w78Mb1CdvrNn73ufjwc9lCQGtjEHbxVQaGkH+ZmMRVTQwqarsqkky3FBtXNdq44YP+zMkSqx0bG6sUbMjX4p5dfoypW7O2izR/7cRfk0O0hvbLIniFJI6+ftg+M6B6NJgjdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW1bANEe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW1bANEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52171C2BCB0;
	Tue, 21 Apr 2026 06:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776751990;
	bh=KV91lfAC2WsS9BzW8PsnW+AmKGOxNLyZol45jXyFIuU=;
	h=Date:From:To:Cc:Subject:From;
	b=dW1bANEe8VSNBRGOxtyeaVaZvG7bFGzyg9fWhVY7mdRt3T26aJukiCEyJRT05xhYj
	 cdbYMm0u6y0YfIAwsrjul7pu66DfGOMGCHMm7niKuWsUqYm6tHPyieo1GfyRMyV9lq
	 XTp1VsI6JbwG9Ah8wQb/gJAYC6RPc7tZv87yYL/WmpLQyR/gkRCUZJbqmnePXTFrhs
	 cUcb3AXJwlNiTOckSZbn9n17u7j+kGA1D6mUTV3W2DAlW9kxaFX/KPe6FAicKf370t
	 Tukh82Sy7I9oxql+nhl1p1lmmI/zyZ13jn0pLbU2HernFsI/L/0IRyeVbu0hXFgyO1
	 JOZ1R+ZnIZ2Jw==
Date: Mon, 20 Apr 2026 20:13:09 -1000
Message-ID: <59bc5171ee5aa02746c2f576d0f1e14f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1-fixes] tools/sched_ext: scx_qmap: Silence task_ctx lookup miss
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_fork() dispatches ops.init_task to exactly one scheduler - the one
owning the forking task's cgroup. A task forked inside a sub-scheduler's
cgroup is init'd into the sub only; the root scheduler has no task_ctx
entry for it. When that task later appears as @prev in the root's
qmap_dispatch() (or flows through core-sched comparison via task_qdist),
the bpf_task_storage_get() legitimately misses.

qmap treated those misses as fatal via scx_bpf_error("task_ctx lookup
failed") and aborted the scheduler as soon as the first cross-sched
task hit the root. Drop the error in the three sites where the miss is
legitimate: lookup_task_ctx() (helper; callers already check for NULL),
qmap_dispatch()'s @prev branch (bookkeeping-only), and task_qdist()
(returns 0 which makes the comparison a no-op). The existing scx_error
was a paranoid guard from the pre-sub-sched world where every task was
owned by the one and only scheduler.

Fixes: 4f8b122848db ("sched_ext: Add basic building blocks for nested sub-scheduler dispatching")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index b68abb9e760b..0330ba15210d 100644
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
