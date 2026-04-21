Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB053603D3;
	Tue, 21 Apr 2026 07:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755989; cv=none; b=FZ0i5SOH+x76VNNAanBHdNZF3ht/lPl6u0JGIoanZv3GXO4Tu4rp/9sxhKYT4rgydzHJmfevI5PW1RHJFVxRpSibhstQBQO9q32re/YElAggi5O4nMw3C5S1MT+5TgOS5+Nm0izUkQeGNHg4R6MMkcE6vjCCsw06SxE/FCMAoRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755989; c=relaxed/simple;
	bh=y1ek2AuYo3QSe7UzaYosTJtcWWnxRjSdh3A7ubh0UJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyU2OSqFxMVdNbPMyzHL5U5TsTJhwatzL5CqSEaAWE8cYjxxkHiqEnigLNYJgCzv49WtJ6XzGdCqtIPGh/Pd+ikC8eRfIdtbM44ZdnIq9O4iVit9+jfa2Z709lQ6710smwP4OtVM2LjAO2UOQrhIHNyy9NDUuTeWm9X92QcXeJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdoFoyJy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdoFoyJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A7CC2BCB5;
	Tue, 21 Apr 2026 07:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776755988;
	bh=y1ek2AuYo3QSe7UzaYosTJtcWWnxRjSdh3A7ubh0UJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pdoFoyJy3XkGBwNMsUd3Z3XtmEjp1kL1IsSc6IIQUxB6Se7ewUUI2nK15hQjG3/PU
	 FtLp85g3Q2hs10AKXm6f6dRUAnlhYfDKO2SXrNTtcG/RptQR5aTU1W4xNnqlJVaEgP
	 5c2fTsdx5ILKCSuyUEe3KHShUmGIeeFXc010TbTyvejfKsezRGrW0MGZXpnI1tNk8j
	 TcU05uGQCQnpGaQJL9PxNnCncIVZVX4NlE4kb9tRLhgXGAo0hEjPvg+AUBtXJEwrDt
	 yY+gWC8HpdwMltX/KoTImfD5TAZj0r6rrlug6JhhBCe4LzVb+Aa0MIbcKgB1gGiyvf
	 0Kgcz8OQo9RfQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/16] sched_ext: Move scx_exit(), scx_error() and friends to ext_internal.h
Date: Mon, 20 Apr 2026 21:19:31 -1000
Message-ID: <20260421071945.3110084-3-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421071945.3110084-1-tj@kernel.org>
References: <20260421071945.3110084-1-tj@kernel.org>
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
---
 kernel/sched/ext.c          | 13 ++++---------
 kernel/sched/ext_internal.h |  8 ++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8c7450c5ebfa..5571f5995dd8 100644
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
@@ -6349,7 +6344,7 @@ static void scx_disable_irq_workfn(struct irq_work *irq_work)
 	kthread_queue_work(sch->helper, &sch->disable_work);
 }
 
-static bool scx_vexit(struct scx_sched *sch,
+bool scx_vexit(struct scx_sched *sch,
 		      enum scx_exit_kind kind, s64 exit_code,
 		      const char *fmt, va_list args)
 {
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 1345ccc01026..350b84876b2a 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1384,6 +1384,14 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id);
 
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

