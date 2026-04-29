Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BE436DA13;
	Wed, 29 Apr 2026 06:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777442881; cv=none; b=ihWLPUsPYa8O16g76aSczneRFyFOFywvlT1IbLGsI9RBUx7fTTXPA4KHYkll43wx/0ppPkMs5rCPX3vc5KD9UnEFlUZ1mscJb/937B9bZrGjBRHdhR/0WhxEut+GEfTksV02jjrSDQHkNg8zNwP3FYVwlhG3qhbg52lSPFSYTFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777442881; c=relaxed/simple;
	bh=MzkGOIQZmAlxtv9jbJE3n0cz9aG7n+FPf8/CrqMObJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAlV2BUHY2zeii+Q06s5LV/vSCVY0NtSpHTyE56GOW+KoKfADF+GZRqCoIJhZtvBukcBcstMv38xshorEmrifIA51OL+swkeP8x2u3iiIxKMpT55WNfxjTt52fK3CHk1SQR7GlgYEsT4lvXVNcL8Np3LGWvVlH/sliQG3PAPDY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DUoM65R/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DUoM65R/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BW36nr8kIqpjT8I1PC2ncsZ47BXza7ZFAyF3zgV2BZE=; b=DUoM65R/5Zkm4Y8NM1B22C/Pd/
	SGf7GahdtHHqcCi4PCeGPDGcje1LB9jsF52wg/Whyl8muZpad37Z+yJKEz+h7pQ970vNwP6vWb7VM
	4TU/rF/Fm2zs4AqyVJA8XZQxTeEchANX3+vBwzU8mfLrgoVytiT0zVtVrPHlvEgY3kgVJRPkHrNKw
	QHfc3WZ5aYo3hoxU9SULGAO1xAyIPDuxGo+0pYyfhk4hgrQW6tILuDe9ZGQE4a2tKX9WVUKzPxnOP
	UamwhIfb61tKIhlJWnD3zpDTFO5pA95QXhLaOHx21WnBW6lbg6RTKjyn+5ZvF4GkYYClOE303DHZb
	h6HStN2A==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wHy5R-003k5P-63; Wed, 29 Apr 2026 08:07:53 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] sched_ext: Dump the exit CPU first
Date: Wed, 29 Apr 2026 15:07:25 +0900
Message-ID: <20260429060726.359024-3-changwoo@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429060726.359024-1-changwoo@igalia.com>
References: <20260429060726.359024-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sched_ext is disabled by an error, the CPU that triggered the exit
is the most relevant piece of information for diagnosing the problem.
However, if there are many CPUs, the dump can get truncated and that
CPU's information may not appear in the output.

Add an exit_cpu field to scx_exit_info and thread it through scx_vexit()
/ __scx_exit(). For the watchdog stall path, populate it from cpu_of(rq)
in check_rq_for_timeouts(). For all other exit paths, define a scx_exit()
macro that wraps __scx_exit() with raw_smp_processor_id(), so the CPU
that initiated the exit is captured automatically, with no call-site
changes needed.

In scx_dump_state(), report the exit CPU in the dump header ("on cpu N")
and dump that CPU first, skipping it in the per-CPU loop, so the most
relevant CPU is never truncated out of the dump. The SysRq-D path
initializes exit_cpu to -1 so debug dumps not tied to an exit don't
arbitrarily promote CPU 0.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/ext.c          | 52 +++++++++++++++++++++++++++----------
 kernel/sched/ext_internal.h |  6 +++++
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 025bd8c6f429..958935b96d05 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -234,24 +234,29 @@ static bool task_dead_and_done(struct task_struct *p);
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind);
 static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
-		      s64 exit_code, const char *fmt, va_list args);
+		      s64 exit_code, int exit_cpu, const char *fmt,
+		      va_list args);
 
-static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
-				    enum scx_exit_kind kind, s64 exit_code,
-				    const char *fmt, ...)
+static __printf(5, 6) bool __scx_exit(struct scx_sched *sch,
+				      enum scx_exit_kind kind, s64 exit_code,
+				      int exit_cpu, const char *fmt, ...)
 {
 	va_list args;
 	bool ret;
 
 	va_start(args, fmt);
-	ret = scx_vexit(sch, kind, exit_code, fmt, args);
+	ret = scx_vexit(sch, kind, exit_code, exit_cpu, fmt, args);
 	va_end(args);
 
 	return ret;
 }
 
+#define scx_exit(sch, kind, exit_code, fmt, args...)				\
+	__scx_exit(sch, kind, exit_code, raw_smp_processor_id(), fmt, ##args)
+
 #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
-#define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, fmt, args)
+#define scx_verror(sch, fmt, args)						\
+	scx_vexit((sch), SCX_EXIT_ERROR, 0, raw_smp_processor_id(), fmt, args)
 
 #define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
 
@@ -3389,9 +3394,10 @@ static bool check_rq_for_timeouts(struct rq *rq)
 					last_runnable + READ_ONCE(sch->watchdog_timeout)))) {
 			u32 dur_ms = jiffies_to_msecs(jiffies - last_runnable);
 
-			scx_exit(sch, SCX_EXIT_ERROR_STALL, 0,
-				 "%s[%d] failed to run for %u.%03us",
-				 p->comm, p->pid, dur_ms / 1000, dur_ms % 1000);
+			__scx_exit(sch, SCX_EXIT_ERROR_STALL, 0, cpu_of(rq),
+				   "%s[%d] failed to run for %u.%03us",
+				   p->comm, p->pid, dur_ms / 1000,
+				   dur_ms % 1000);
 			timed_out = true;
 			break;
 		}
@@ -5528,6 +5534,7 @@ static struct scx_exit_info *alloc_exit_info(size_t exit_dump_len)
 	if (!ei)
 		return NULL;
 
+	ei->exit_cpu = -1;
 	ei->bt = kzalloc_objs(ei->bt[0], SCX_EXIT_BT_LEN);
 	ei->msg = kzalloc(SCX_EXIT_MSG_LEN, GFP_KERNEL);
 	ei->dump = kvzalloc(exit_dump_len, GFP_KERNEL);
@@ -6384,8 +6391,13 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 	if (ei->kind == SCX_EXIT_NONE) {
 		dump_line(&s, "Debug dump triggered by %s", ei->reason);
 	} else {
-		dump_line(&s, "%s[%d] triggered exit kind %d:",
-			  current->comm, current->pid, ei->kind);
+		if (ei->exit_cpu >= 0)
+			dump_line(&s, "%s[%d] triggered exit kind %d on cpu %d:",
+				  current->comm, current->pid, ei->kind,
+				  ei->exit_cpu);
+		else
+			dump_line(&s, "%s[%d] triggered exit kind %d:",
+				  current->comm, current->pid, ei->kind);
 		dump_line(&s, "  %s (%s)", ei->reason, ei->msg);
 		dump_newline(&s);
 		dump_line(&s, "Backtrace:");
@@ -6402,8 +6414,15 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 	dump_line(&s, "CPU states");
 	dump_line(&s, "----------");
 
+	/*
+	 * Dump the exit CPU first so it isn't lost to dump truncation, then
+	 * walk the rest in order, skipping the one already dumped.
+	 */
+	if (ei->exit_cpu >= 0)
+		scx_dump_cpu(sch, &s, &dctx, ei->exit_cpu, dump_all_tasks);
 	for_each_possible_cpu(cpu) {
-		scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
+		if (cpu != ei->exit_cpu)
+			scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
 	}
 
 	dump_newline(&s);
@@ -6442,7 +6461,7 @@ static void scx_disable_irq_workfn(struct irq_work *irq_work)
 }
 
 static bool scx_vexit(struct scx_sched *sch,
-		      enum scx_exit_kind kind, s64 exit_code,
+		      enum scx_exit_kind kind, s64 exit_code, int exit_cpu,
 		      const char *fmt, va_list args)
 {
 	struct scx_exit_info *ei = sch->exit_info;
@@ -6465,6 +6484,7 @@ static bool scx_vexit(struct scx_sched *sch,
 	 */
 	ei->kind = kind;
 	ei->reason = scx_exit_reason(ei->kind);
+	ei->exit_cpu = exit_cpu;
 
 	irq_work_queue(&sch->disable_irq_work);
 	return true;
@@ -7730,7 +7750,11 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
 
 static void sysrq_handle_sched_ext_dump(u8 key)
 {
-	struct scx_exit_info ei = { .kind = SCX_EXIT_NONE, .reason = "SysRq-D" };
+	struct scx_exit_info ei = {
+		.kind		= SCX_EXIT_NONE,
+		.exit_cpu	= -1,
+		.reason		= "SysRq-D",
+	};
 	struct scx_sched *sch;
 
 	list_for_each_entry_rcu(sch, &scx_sched_all, all)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index a54903bb74b3..58d675b57d04 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -97,6 +97,12 @@ struct scx_exit_info {
 	/* %SCX_EXIT_* - broad category of the exit reason */
 	enum scx_exit_kind	kind;
 
+	/*
+	 * CPU that initiated the exit, valid once @kind has been set.
+	 * Negative if the exit path didn't identify a CPU.
+	 */
+	int			exit_cpu;
+
 	/* exit code if gracefully exiting */
 	s64			exit_code;
 
-- 
2.54.0

