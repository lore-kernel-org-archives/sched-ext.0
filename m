Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33CF45C0B;
	Tue,  7 Oct 2025 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759864018; cv=none; b=JmwvUFpqIhuDeV9YKWlwnOzZXsfNnZJLyMjMGJbSCM3CpX/iGtr1ZLaA2caTIP8T7cFuFklQ2iu/bDnSxnI5Q+ncrvwBRaXXecpGN0mFDrrbK0Mn2l8E2rTubyUC4UrE6g4/er7xnwwMk4mCouYDSzFQguCbQWtKIFmuV26n5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759864018; c=relaxed/simple;
	bh=SZJQ7IjL7u17J7+a7h9BaqxIi1C6AJMtxUOMSfLxNMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Smd/EX/O8aKKpSBStEidbsjIsIjM6oM0rc9PsfY7NIbkmH8EjI8zWoguOzQmGmzcLI0eGhIZKQytdOaXmjPCOOq1BZ2IchqicTO6xnU/zINNtNkKHfNJfBeY97lpS1uS7d190SNTZktWdUXZ1dRQDNV9ynnD/TCYyt994EfiFLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/odYhjl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/odYhjl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BBAC4CEF1;
	Tue,  7 Oct 2025 19:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759864018;
	bh=SZJQ7IjL7u17J7+a7h9BaqxIi1C6AJMtxUOMSfLxNMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/odYhjlJhZlKkae3ViuZvP8+RzsZGSZTRQNnll+W1HCwuXYlp+uJ+fSwN5yRiJ1l
	 NEhHg6iqihn5Y7Sfv70U+YJVnLvQ1Fv/WIwwp3if3ZLHQeIi8F74JIMpCtQtI1VlC6
	 SkH0A6VZ/MoEZCRTt63s6NcSrYu0Ho78FCabnWmDz5eTANqEM76KRrBLt8WlB0MXI8
	 DAXf2gQ4GYCHqB7ddkT3do8owAhKPJfd9gJXfp/NTSkuHOiliAjIfBH6PgX5Jlz1ia
	 UvVCi5poAugyYSpOHYLGi6vx9JMro28n1nuEJ2i0+nysuy2QrlaUYnlLBJ7ccbMQb9
	 iX/owYGkDbU0Q==
Date: Tue, 7 Oct 2025 09:06:57 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: [PATCH 5/4] sched_ext/tools: Add compat wrapper for
 scx_bpf_task_set_slice/dsq_vtime()
Message-ID: <aOVk0V9WigQq6Qc_@slm.duckdns.org>
References: <20251007015147.2496026-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007015147.2496026-1-tj@kernel.org>

for sub-scheduler authority checks. Add compat wrappers which fall back to
direct p->scx field writes on older kernels.

Suggested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/common.bpf.h |    2 --
 tools/sched_ext/include/scx/compat.bpf.h |   24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -101,8 +101,6 @@ s32 scx_bpf_pick_any_cpu_node(const cpum
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
-bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice) __ksym __weak;
-bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime) __ksym __weak;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct rq *scx_bpf_locked_rq(void) __ksym;
 struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -235,6 +235,30 @@ scx_bpf_dsq_insert(struct task_struct *p
 }
 
 /*
+ * v6.19: scx_bpf_task_set_slice() and scx_bpf_task_set_dsq_vtime() added to for
+ * sub-sched authority checks. Drop the wrappers and move the decls to
+ * common.bpf.h after v6.22.
+ */
+bool scx_bpf_task_set_slice___new(struct task_struct *p, u64 slice) __ksym __weak;
+bool scx_bpf_task_set_dsq_vtime___new(struct task_struct *p, u64 vtime) __ksym __weak;
+
+static inline void scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
+{
+	if (bpf_ksym_exists(scx_bpf_task_set_slice___new))
+		scx_bpf_task_set_slice___new(p, slice);
+	else
+		p->scx.slice = slice;
+}
+
+static inline void scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
+{
+	if (bpf_ksym_exists(scx_bpf_task_set_dsq_vtime___new))
+		scx_bpf_task_set_dsq_vtime___new(p, vtime);
+	else
+		p->scx.dsq_vtime = vtime;
+}
+
+/*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
  */
