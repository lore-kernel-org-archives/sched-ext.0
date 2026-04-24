Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE4C75801;
	Fri, 24 Apr 2026 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994345; cv=none; b=UHwQxWLVmRERa8OCujsZxWFCwaRUh6aqkTrNEsQS4P/DBq/hk2jpAQuotTPnMFojmd94Dld0CbOj4tOtyi+7FNcwTIJSupxTR/NEkYUu9ah3x5kfubnH0mlo7m2kKdkeIjSD7A1yeQEh/LczMPy9bc4jUykKtYYckw4KTnn6K2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994345; c=relaxed/simple;
	bh=3yWn8bpako2+bezc0i0Gw+XSrGeBMTq4gz2c2XsSFvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h9SGUK8anRodkXOCfbHVFAjZbht5Tu7J+w+6EX4IurvPZOu9pXXe4zQpJRjrdAgWO0vR/BSyR7ZxRNSoplWXO+YbV3jLt4b2TeV3sMEyOP9lzrEN3IQxrvzdmOYlEfP4v/t1Ux0Zp2ode0i4tfBf4YPVMZPuLCFmanfuCXTicW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0K1mHXI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0K1mHXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4758C2BCB9;
	Fri, 24 Apr 2026 01:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776994345;
	bh=3yWn8bpako2+bezc0i0Gw+XSrGeBMTq4gz2c2XsSFvk=;
	h=From:To:Cc:Subject:Date:From;
	b=D0K1mHXIL/3V3HlDGUse5y4Hgj026LwZxSsdGkSc2lQZ5xDvo0mR02KsXNHToOsxf
	 DXuB/Uz1pevSheiIRy5pNRRKO1XDoE7M4Fbq0kikF8KM8qW+F6i5q/VSrJuY3czApv
	 LHH+BvRPgoXF/0VzYyFdn53/8utz5+pK3WOkZVrjjQBv0zgxN4JSWfsTvoaY3UxV9I
	 NQ/e3iChh0hSRZz4USADKH7P+IdnLUkQZbc8FDBt802ZDRAyOh6QxXQgmR1A7kXB2M
	 hY9lxxLR5Z+2Y622dyc/EAyrmbv4Q9PoKj3ncpcAxxXce5ke/3w9I0GX3H1pFK8E8C
	 Pix3sUqQb8cHQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomzhao@126.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/17] sched_ext: Move scx_exit(), scx_error() and friends to ext_internal.h
Date: Thu, 23 Apr 2026 15:32:06 -1000
Message-ID: <20260424013220.2923402-4-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
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
index 1d6613dc4d3b..d57ba3df0c8c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -235,12 +235,10 @@ static void run_deferred(struct rq *rq);
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
@@ -252,9 +250,6 @@ static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
 	return ret;
 }
 
-#define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
-#define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, fmt, args)
-
 #define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
 
 static long jiffies_delta_msecs(unsigned long at, unsigned long now)
@@ -6350,7 +6345,7 @@ static void scx_disable_irq_workfn(struct irq_work *irq_work)
 	kthread_queue_work(sch->helper, &sch->disable_work);
 }
 
-static bool scx_vexit(struct scx_sched *sch,
+bool scx_vexit(struct scx_sched *sch,
 		      enum scx_exit_kind kind, s64 exit_code,
 		      const char *fmt, va_list args)
 {
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 5e3b79963d41..fb1a555faaaa 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1352,6 +1352,14 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id);
 
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
2.53.0

