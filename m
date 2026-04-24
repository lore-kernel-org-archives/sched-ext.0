Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981C3E5EFE;
	Fri, 24 Apr 2026 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051646; cv=none; b=KJTcST6GKLnEbRkKIi3VmUHyWyC2Wnt2tO5fmIhLkRyOzzNZ0ejtgEscK4Ob5adyFTOrZJ7P87svYuqsCPQ+repp3QozfHBX6b1R+9cRelwGULmzrvOzQIS39DACmDQtqcGySdGbzTLSiyGPX1bWOmW/1ajnxtIdQP+Kxyhkfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051646; c=relaxed/simple;
	bh=3yWn8bpako2+bezc0i0Gw+XSrGeBMTq4gz2c2XsSFvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3AB+3e7G/3roapTzQSMkJHiM4yOcI5myz9bRH5JuSlA89xyrXfDuUFpeYMhv/TMIrZT+RX4IqT/x0JRMdH4gXxpZqbE0YkmLSzI1Y7w9nFehABx4LLLLHvjwVFqGSATYsUFYR9j2BMZq9BGeQUQE+FtWKqhlC8yxP0iBJifJeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5rgUKb6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5rgUKb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6BEC19425;
	Fri, 24 Apr 2026 17:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051646;
	bh=3yWn8bpako2+bezc0i0Gw+XSrGeBMTq4gz2c2XsSFvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5rgUKb6VJEcr1rG1rnJ4ljhVZ8BfrW8xa39hMpe+vQqJByIQwZ7XRJ920kcy6xfh
	 V8wtm82aYgEWnAlsXHDXbR6QJUYookVlKqSdg8s+/uak+dbTe+isgXjBEeuWzUE/Xn
	 em4G62xD3/S0tjXcWoZSbj2c6Yz1xg8YEShqaNwolsOBKOwVcVMzZOVCi6bfbsJsAQ
	 49vXeYx2pKq2VnortVDLgCqtMZmKBmJcD5eSpkNG3PFs2mbHkPeAkY8fEwnLbdsBT0
	 +jwgG10T9irSDrJNxOC/ok0Ih5rBw1yzJqO++9gQLqs5cGAF/AwI1vMITnF5ik0/JF
	 3TaIysE3QJb6A==
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
Date: Fri, 24 Apr 2026 07:27:07 -1000
Message-ID: <20260424172721.3458520-4-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424172721.3458520-1-tj@kernel.org>
References: <20260424172721.3458520-1-tj@kernel.org>
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

