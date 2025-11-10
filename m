Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDBD2FB998;
	Mon, 10 Nov 2025 20:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808205; cv=none; b=SJvwMA0Y7tEqXuCF3WbgGCrxwqCTzsaSfhvxSsW0FAkp7nllG3PjsB0gOhip7sTIIbSnISPI+0JpMVl7ZKxYhJnBNYFDPp7iDdXObQt1Z4cUWE0Iw95yGAZriWXolBYjkRX3GEWYgjhszNLa+c0doeSOpJhYES3nLB5oPhX6UM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808205; c=relaxed/simple;
	bh=Uwo6UiAnoImQ2QxcuCLZOBeSBcP09sWxJuKjtg9MkQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcAc+iwQhHV1xCYXM+BUnoAOHNF9ExNBum7IR2c5fwvpr1pCpEBMVFrGaYmikXbfxEkykExRn/mVz00x9ufPTisnRSUt6cApRmEZqz+M+i5T/86P3HtLQ1Vtm2+LQfVonPPDGhAjcf7mBzBOFIl5u1RidDq6Jq5ZyCVKa0+akjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOqoH8Me; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOqoH8Me"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99610C19423;
	Mon, 10 Nov 2025 20:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762808204;
	bh=Uwo6UiAnoImQ2QxcuCLZOBeSBcP09sWxJuKjtg9MkQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOqoH8MelruCeu3t62YGfx9HvJ9VC194q0uCL6usmABiYf2PYcMozHT4TrWE/cZbx
	 q4F3uGHy7BymeYWzGGuVI301ZrqxPLaJRasHdr4nQbM6qK/bKo3BE72XTZfrW39tzb
	 gQbYwjbh4PHeAEsejh0udZT6gr4KN7fAti6Mf0pRIocsieJg5htiWXKIHZPEvN8+He
	 0Yb84+rPA1HnyJRVH4E01xljuv0pMf/3cOUFd7hJpBRWHGHaPwwtG4tyVFGI9+7qt8
	 LSM3ANjmsuQkzLtngzjCAQzxIj2nlb9vXoJUAQbUAAmVIyE8HoGSfpdGvhz2BPw6yM
	 xNdUGjQFqXf9A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH v2 07/14] sched_ext: Make scx_exit() and scx_vexit() return bool
Date: Mon, 10 Nov 2025 10:56:29 -1000
Message-ID: <20251110205636.405592-8-tj@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110205636.405592-1-tj@kernel.org>
References: <20251110205636.405592-1-tj@kernel.org>
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
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8e4619b4f832..600918095245 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -174,18 +174,21 @@ MODULE_PARM_DESC(slice_bypass_us, "bypass slice in microseconds, applied on [un]
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
@@ -4396,14 +4399,14 @@ static void scx_error_irq_workfn(struct irq_work *irq_work)
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
@@ -4420,6 +4423,7 @@ static void scx_vexit(struct scx_sched *sch,
 	ei->reason = scx_exit_reason(ei->kind);
 
 	irq_work_queue(&sch->error_irq_work);
+	return true;
 }
 
 static int alloc_kick_syncs(void)
-- 
2.51.2

