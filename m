Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63B22B8B6;
	Sun,  9 Nov 2025 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762713081; cv=none; b=gdcK3Fr155+ssxFgpD1gYvl5wKnuNta+cTRppM/Yp7/bIZzsv8wfMQnXhLmxP4aLKWIFaoIqOlcCjk10UnInSQsPbFuSMPLI07kmtetgQUAdi2dGYSay0UECTK2w1p/2OmzIqmMYJvSZ05e8mdxaNocn9NAo8tSSeodR/ryNORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762713081; c=relaxed/simple;
	bh=5pzWYyqm8Lut7XSsYyAWLNrQ3DwaxeHay2IjnQOVGvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q83PQ6ePaSYcDDwya6BO3jv4mMxanC7ChSs0pnYj93BKvuW9F6mX62iN7oCk593OPVLJGskzZCF+U9TbRkWNAKtTqfLI5qy6nJKpnXbp0VQTGHK5dUwve/932bwGXG+11aB74GKNObJOPjAdyw0/Wo7Q7OgZowsL1Z2QuCMBFUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RW7CjuXu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RW7CjuXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51ADEC16AAE;
	Sun,  9 Nov 2025 18:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762713081;
	bh=5pzWYyqm8Lut7XSsYyAWLNrQ3DwaxeHay2IjnQOVGvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RW7CjuXuQLiBX9DYqzDuhhBMKAybvys8C7nD+pfSjLr8UbYLzN1h4G/UvvjJgy8aW
	 fwDhhJ8XxnMs99Q573rHN3Q2CtGOpsDDZ1SLBFnRmzqsMwOeYpG7a+gbuiIARfWwjz
	 FurZhsfLZxX2rsa9jqDpbBUaWMaBYcPKDSpMUQB5IvcR1sRXWlWjxfziR6YU5vD/vs
	 xGbrlYOA0L8bjLFtiKV6un8AGPPcdRpVfuhYq4CpzFSu20UbtKFv7AZJzDxbNbHQXX
	 /38eJRg7xVbowhRwiWoMm+U3hlc/CMdhXXsLbrVOMvGMrV6JTEZNYfwstU1sNlebbp
	 lQBKZzz6ZNtEA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/13] sched_ext: Make scx_exit() and scx_vexit() return bool
Date: Sun,  9 Nov 2025 08:31:06 -1000
Message-ID: <20251109183112.2412147-8-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109183112.2412147-1-tj@kernel.org>
References: <20251109183112.2412147-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make scx_exit() and scx_vexit() return bool indicating whether the calling
thread successfully claimed the exit. This will be used by the abort mechanism
added in a later patch.

Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index afa89ca3659e..033c8b8e88e8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -177,18 +177,21 @@ MODULE_PARM_DESC(slice_bypass_us, "bypass slice in microseconds, applied on [un]
 static void process_ddsp_deferred_locals(struct rq *rq);
 static u32 reenq_local(struct rq *rq);
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
-static void scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
+static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
 		      s64 exit_code, const char *fmt, va_list args);
 
-static __printf(4, 5) void scx_exit(struct scx_sched *sch,
+static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
 				    enum scx_exit_kind kind, s64 exit_code,
 				    const char *fmt, ...)
 {
 	va_list args;
+	bool ret;
 
 	va_start(args, fmt);
-	scx_vexit(sch, kind, exit_code, fmt, args);
+	ret = scx_vexit(sch, kind, exit_code, fmt, args);
 	va_end(args);
+
+	return ret;
 }
 
 #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
@@ -4399,14 +4402,14 @@ static void scx_error_irq_workfn(struct irq_work *irq_work)
 	kthread_queue_work(sch->helper, &sch->disable_work);
 }
 
-static void scx_vexit(struct scx_sched *sch,
+static bool scx_vexit(struct scx_sched *sch,
 		      enum scx_exit_kind kind, s64 exit_code,
 		      const char *fmt, va_list args)
 {
 	struct scx_exit_info *ei = sch->exit_info;
 
 	if (!scx_claim_exit(sch, kind))
-		return;
+		return false;
 
 	ei->exit_code = exit_code;
 #ifdef CONFIG_STACKTRACE
@@ -4423,6 +4426,7 @@ static void scx_vexit(struct scx_sched *sch,
 	ei->reason = scx_exit_reason(ei->kind);
 
 	irq_work_queue(&sch->error_irq_work);
+	return true;
 }
 
 static int alloc_kick_syncs(void)
-- 
2.51.1

