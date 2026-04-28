Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D177311954;
	Tue, 28 Apr 2026 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408550; cv=none; b=e24PUjIT9asSVBZGYZMGsKVtynriCuMldAQFvwAHJoQtmnkkHZHSPJ2F/OIBKdBCZDh55861quJHSEkLb6P05dDQ5owQeIG+WimRm9UNl7s785uALkuoCz80y70H6tKZfriY8RvG18qdxpWt+UEOqDqIPXvXScHXolR7DWvuKVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408550; c=relaxed/simple;
	bh=ZohPcoSgFnIGt5vD9xaT3i/+O+MbZx9w9fNoMThrRvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hovipjLmi3oJlrwTBkvccYreilv6m7qxbyTqrqOGx4mArmDlrS8ORGfw8hLbPohOYeb5ZM8t8JnqTLMaWc/5Rz8DLHgXxFs8QT9iFVivGuzf/BXCBTV86qYRcr4DrktMYWXQeuFNFOiqJJ4aOzJP/p5VOe58RyFzjP6ErIOTzoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt9nTfRO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt9nTfRO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0DFC2BCB9;
	Tue, 28 Apr 2026 20:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408550;
	bh=ZohPcoSgFnIGt5vD9xaT3i/+O+MbZx9w9fNoMThrRvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gt9nTfROCugivr/bWP7HkY+qx/p1p9rXgAxJj8tL5WGte5ymjIIQUfiweXC3Mu2ZN
	 MA2S7JIsMen+kRx9Lx2fYlj8vQwjytYVaZRIQA5ylX99h/Vx6OVXzv0mIBWPyOAsKS
	 Fx9TR4lApKpLT7YQSz+1KYiSUdlfFHLk+wP0GWzQbzV3YZiI/6+ODFZt8QavqTwhC9
	 6XqytINrEesX/CylvKQsbrkF2MnbPHSGwIBzZ4itX5qukdcyU5axewsDgGQ+T74KvH
	 fGeWTtLiGzs+IN/Jz2Nlhuz+5rrCksEIfN+fnk3RyPb8yxgR/N7sgRfUqAv9SVx3YO
	 L8H13sUV6TmsA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 03/17] sched_ext: Move scx_exit(), scx_error() and friends to ext_internal.h
Date: Tue, 28 Apr 2026 10:35:31 -1000
Message-ID: <20260428203545.181052-4-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428203545.181052-1-tj@kernel.org>
References: <20260428203545.181052-1-tj@kernel.org>
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

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c          | 13 ++++---------
 kernel/sched/ext_internal.h |  8 ++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 980231c547ec..8d41b4e2cce6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -231,12 +231,10 @@ static void run_deferred(struct rq *rq);
 static bool task_dead_and_done(struct task_struct *p);
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind);
-static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
-		      s64 exit_code, const char *fmt, va_list args);
 
-static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
-				    enum scx_exit_kind kind, s64 exit_code,
-				    const char *fmt, ...)
+__printf(4, 5) bool scx_exit(struct scx_sched *sch,
+			     enum scx_exit_kind kind, s64 exit_code,
+			     const char *fmt, ...)
 {
 	va_list args;
 	bool ret;
@@ -248,9 +246,6 @@ static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
 	return ret;
 }
 
-#define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
-#define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, fmt, args)
-
 #define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
 
 static long jiffies_delta_msecs(unsigned long at, unsigned long now)
@@ -6432,7 +6427,7 @@ static void scx_disable_irq_workfn(struct irq_work *irq_work)
 	kthread_queue_work(sch->helper, &sch->disable_work);
 }
 
-static bool scx_vexit(struct scx_sched *sch,
+bool scx_vexit(struct scx_sched *sch,
 		      enum scx_exit_kind kind, s64 exit_code,
 		      const char *fmt, va_list args)
 {
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index f59cd58b8175..d4960df23da4 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1354,6 +1354,14 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id);
 
 bool scx_cpu_valid(struct scx_sched *sch, s32 cpu, const char *where);
 
+bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind, s64 exit_code,
+	       const char *fmt, va_list args);
+__printf(4, 5) bool scx_exit(struct scx_sched *sch, enum scx_exit_kind kind,
+			     s64 exit_code, const char *fmt, ...);
+
+#define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, fmt, args)
+#define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
+
 /*
  * Return the rq currently locked from an scx callback, or NULL if no rq is
  * locked.
-- 
2.54.0

