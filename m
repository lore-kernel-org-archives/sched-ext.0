Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8093D7D7F;
	Wed, 21 Jan 2026 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037114; cv=none; b=Tl7xcD/VHF8YL4JuknwcfrOxTo8Nk4HWJr6B3ZmAYDpjF8+cCNxuE7BJ7gSukeZ7r3tL0t8u6MQfXaz+TiXGRwc5J+E+gr+GN8jmQkUHFLz3RV5d8kN/c4YnMkOPWBE58FwAo/VWNMSMGQCJ4untEg7idvusuPCa/Gkq9EFhwAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037114; c=relaxed/simple;
	bh=fVGwUHm6yH7yJE+ApdLhQqOSbUzeq5Ly1ZfpZPul2Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkzIkjEyhutXgdO2j7X+SNTL4qd+RjR/jRfoBIOMGY4N20QYgLFMt+zdGoDdzmjFbGYqYyhla86KEuGyKjKZAV/lGe3SvuooNmaf3b1x5f1AzJzGiEqA6HiB6oVtjmDYHzdgBH8+gqj+8Qs97zGv+OmBZXPtbqwKF88hrwOyPWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDHl6VUl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDHl6VUl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00740C4CEF1;
	Wed, 21 Jan 2026 23:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037113;
	bh=fVGwUHm6yH7yJE+ApdLhQqOSbUzeq5Ly1ZfpZPul2Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDHl6VUlXY1p6q9pwPfuB9IpCej8QjZpVqIaSGmVAraXF1P6k+Xm3Q8hzpJIbX4/V
	 czAGMXaGsJUwxEkgOj/i/hoT7fXrXhw+N/G0mpFCcbQ9Z9w40hC0ItkBJItkAVBDzX
	 mjdGS5PuGAQzkxdPUzBfY6ukGudDSodVfJcogQsGDdfAub+gwo5AzPO/2zFPmBZI0d
	 0DWFxjV7h0XbeXDBkeD0nmiIVBYxxKAzfAlOFrnmMMRaX2yfRrWT0FmRgT7hjViUxN
	 tgpkmHGKSp/HxYPkyenl48dbVhU6uWUjdFtysjojjt8NQzRShKyee1fL7nXwustExs
	 wo3hTAfX4pFyg==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 11/34] sched_ext: Enforce scheduler ownership when updating slice and dsq_vtime
Date: Wed, 21 Jan 2026 13:11:17 -1000
Message-ID: <20260121231140.832332-12-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121231140.832332-1-tj@kernel.org>
References: <20260121231140.832332-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_task_set_slice() and scx_bpf_task_set_dsq_vtime() now verify that
the calling scheduler has authority over the task before allowing updates.
This prevents schedulers from modifying tasks that don't belong to them in
hierarchical scheduling configurations.

Direct writes to p->scx.slice and p->scx.dsq_vtime are deprecated and now
trigger warnings. They will be disallowed in a future release.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index bdcb46f42625..aad3af8e8377 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5684,12 +5684,17 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 
 	t = btf_type_by_id(reg->btf, reg->btf_id);
 	if (t == task_struct_type) {
-		if (off >= offsetof(struct task_struct, scx.slice) &&
-		    off + size <= offsetofend(struct task_struct, scx.slice))
-			return SCALAR_VALUE;
-		if (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
-		    off + size <= offsetofend(struct task_struct, scx.dsq_vtime))
+		/*
+		 * COMPAT: Will be removed in v6.23.
+		 */
+		if ((off >= offsetof(struct task_struct, scx.slice) &&
+		     off + size <= offsetofend(struct task_struct, scx.slice)) ||
+		    (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
+		     off + size <= offsetofend(struct task_struct, scx.dsq_vtime))) {
+			pr_warn("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()");
 			return SCALAR_VALUE;
+		}
+
 		if (off >= offsetof(struct task_struct, scx.disallow) &&
 		    off + size <= offsetofend(struct task_struct, scx.disallow))
 			return SCALAR_VALUE;
@@ -6908,12 +6913,21 @@ __bpf_kfunc_start_defs();
  * scx_bpf_task_set_slice - Set task's time slice
  * @p: task of interest
  * @slice: time slice to set in nsecs
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Set @p's time slice to @slice. Returns %true on success, %false if the
  * calling scheduler doesn't have authority over @p.
  */
-__bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
+__bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
+					const struct bpf_prog_aux *aux)
 {
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = scx_prog_sched(aux);
+	if (unlikely(!scx_task_on_sched(sch, p)))
+		return false;
+
 	p->scx.slice = slice;
 	return true;
 }
@@ -6922,12 +6936,21 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
  * scx_bpf_task_set_dsq_vtime - Set task's virtual time for DSQ ordering
  * @p: task of interest
  * @vtime: virtual time to set
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Set @p's virtual time to @vtime. Returns %true on success, %false if the
  * calling scheduler doesn't have authority over @p.
  */
-__bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
+__bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime,
+					    const struct bpf_prog_aux *aux)
 {
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = scx_prog_sched(aux);
+	if (unlikely(!scx_task_on_sched(sch, p)))
+		return false;
+
 	p->scx.dsq_vtime = vtime;
 	return true;
 }
@@ -7807,8 +7830,8 @@ __bpf_kfunc void scx_bpf_events(struct scx_event_stats *events,
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_any)
-BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_RCU);
-BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_RCU);
+BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_IMPLICIT_ARGS | KF_RCU);
+BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
-- 
2.52.0

