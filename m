Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497F441C31A;
	Wed, 29 Apr 2026 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486896; cv=none; b=nt3Ms3bV1laRUyMyg2lp1UueQm4Mg5bYZ8+KTeMym0hyEjmDG5ZukN+DAcPdO3GlwKjGAOibvOiM8RcSnF3GHRLjwcAvM0AL5x1FlkyYZ3OYF1iYj8o73h+ZsJ96pA8ty1VDEvlbcDt+JTP338S6J1fVJBu0e4tUVHAdAmtVH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486896; c=relaxed/simple;
	bh=4XlA/UWLc3Q1kI4auMT3fjfjLTGUnBOms4Cx04XloUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdGdiCSI/PlmnENc4N6MKJ2z5QappSo31Ci+zxT5eMg5Q3tOhHOXuX0iZx+uGpQ2aIOnX3pFOcUjcuAagjNtTU5xtqiwNx+PI1+6ZSLIUFeSQEKOcLbXLV6UFURM+9kL8TmB/8aL6ADCEhwrMlQ0ct+4ZFFzwAJM2zlkaxRgPVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRUAhQrn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRUAhQrn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088F7C19425;
	Wed, 29 Apr 2026 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486896;
	bh=4XlA/UWLc3Q1kI4auMT3fjfjLTGUnBOms4Cx04XloUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRUAhQrnEhg7D8J2LlOVeRAwhUgJsTTCqJ39VsnuPczAHC3B2UKfX/9rBgle4J2ml
	 hWaKOqxt7JVz85AJJwk6QUy9RyUW+8tlyyaE/jNxHu1rXWyDSkNS3fSN3DQj928kze
	 qG+C+Ls8b0ekmKnECsnJ4hALzRGJ9JLl8PFX8SXEwN45JhA3YVO+llbs3v9vmJcCL9
	 SKZLwzJpnqQNShxrATVQY8bjxq1ztS/279iswaq+jTAydks8fEkisKopkinve1mhFL
	 O7ozxYSdepF9FyAUXZFe06BguqlYAbqOTJQT0H9X0kxVLAs6GxbbDDMq6L7PfC+S5Q
	 8Xfnc9F+6CudA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 03/17] sched_ext: Move scx_exit(), scx_error() and friends to ext_internal.h
Date: Wed, 29 Apr 2026 08:21:17 -1000
Message-ID: <20260429182131.1780125-4-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429182131.1780125-1-tj@kernel.org>
References: <20260429182131.1780125-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Things shared across multiple .c files belong in a header. scx_exit() /
scx_error() (and their scx_vexit() / scx_verror() siblings) are already
called from ext_idle.c and the upcoming ext_cid.c, and it was only
build_policy.c's textual inclusion of ext.c that made the references
resolve. Move the whole family to ext_internal.h.

Pure visibility change.

v4: Rebased over the exit_cpu plumbing. scx_exit() and scx_verror()
    are now macros wrapping raw_smp_processor_id(); move both macros
    plus the underlying __scx_exit() / scx_vexit() declarations to
    the header.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Reviewed-by: Changwoo Min <changwoo@igalia.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c          | 22 ++++++----------------
 kernel/sched/ext_internal.h | 12 ++++++++++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0d0833bd8d20..2f16dc2b814b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -231,13 +231,10 @@ static void run_deferred(struct rq *rq);
 static bool task_dead_and_done(struct task_struct *p);
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind);
-static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
-		      s64 exit_code, s32 exit_cpu, const char *fmt,
-		      va_list args);
 
-static __printf(5, 6) bool __scx_exit(struct scx_sched *sch,
-				      enum scx_exit_kind kind, s64 exit_code,
-				      s32 exit_cpu, const char *fmt, ...)
+__printf(5, 6) bool __scx_exit(struct scx_sched *sch,
+			       enum scx_exit_kind kind, s64 exit_code,
+			       s32 exit_cpu, const char *fmt, ...)
 {
 	va_list args;
 	bool ret;
@@ -249,13 +246,6 @@ static __printf(5, 6) bool __scx_exit(struct scx_sched *sch,
 	return ret;
 }
 
-#define scx_exit(sch, kind, exit_code, fmt, args...)				\
-	__scx_exit(sch, kind, exit_code, raw_smp_processor_id(), fmt, ##args)
-
-#define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
-#define scx_verror(sch, fmt, args)						\
-	scx_vexit((sch), SCX_EXIT_ERROR, 0, raw_smp_processor_id(), fmt, args)
-
 #define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
 
 static long jiffies_delta_msecs(unsigned long at, unsigned long now)
@@ -6458,9 +6448,9 @@ static void scx_disable_irq_workfn(struct irq_work *irq_work)
 	kthread_queue_work(sch->helper, &sch->disable_work);
 }
 
-static bool scx_vexit(struct scx_sched *sch,
-		      enum scx_exit_kind kind, s64 exit_code, s32 exit_cpu,
-		      const char *fmt, va_list args)
+bool scx_vexit(struct scx_sched *sch,
+	       enum scx_exit_kind kind, s64 exit_code, s32 exit_cpu,
+	       const char *fmt, va_list args)
 {
 	struct scx_exit_info *ei = sch->exit_info;
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index d8fb0b0b652c..0c55c5481fa5 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1360,6 +1360,18 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id);
 
 bool scx_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where);
 
+bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind, s64 exit_code,
+	       s32 exit_cpu, const char *fmt, va_list args);
+__printf(5, 6) bool __scx_exit(struct scx_sched *sch, enum scx_exit_kind kind,
+			       s64 exit_code, s32 exit_cpu, const char *fmt, ...);
+
+#define scx_exit(sch, kind, exit_code, fmt, args...)				\
+	__scx_exit(sch, kind, exit_code, raw_smp_processor_id(), fmt, ##args)
+#define scx_error(sch, fmt, args...)						\
+	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
+#define scx_verror(sch, fmt, args)						\
+	scx_vexit((sch), SCX_EXIT_ERROR, 0, raw_smp_processor_id(), fmt, args)
+
 /*
  * Return the rq currently locked from an scx callback, or NULL if no rq is
  * locked.
-- 
2.54.0

