Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB70F34AB19;
	Wed,  8 Apr 2026 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775617904; cv=none; b=TlXIZTKx1IcqHcqkWAsRmV6PafdBB/O1oFFElJWbRu++y8oBz7l4Mw25PpDV18ZW7+yydTsKcpwPGzqurixj+ew+CKAVHGFF1wuQNMzlx6Kh7aJv0BeGwoTRoN5nsx3tS4tStguavJlhEKVzOo40oYn7745KCGj6Sv63qJqARv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775617904; c=relaxed/simple;
	bh=nlyYSPueSkl/8lHLDtFpXbWXOfEHiNME7NUG//wj59I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyBANdhhhhwwOJfxQBJpJf4OCWjxNHfGHWf52BpcAo8E6sD9Y/M+KMbW+TU9QOAklSxw1qFHqF6WnyCdNwOgH3DlklxSACkIOWrApDNu7LTi32wvBm0YR8mDAygUEnPcx3ofhgIqyuooYthV7GQ2A3ACADIM9dsb+pFElBn4q70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Qxc/i3QY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Qxc/i3QY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qe5J3vuK1t3+/2lw61k0vIDuy0Vsms58ZkJwwnPZ13k=; b=Qxc/i3QYhgHG7GSMVoVl8G0Iu/
	GQYhLZbKrlPYSGD/7dh3qSzlvwP5NDIvsoqujtsAGMV/YZKSfdVKfGfzn6myBaeeUjCPej/+t2ldY
	1RCHj/nbX/XtuR14FVO16Q8KifkX1gTsnCqKL/HVBAGqgxbCvit+2j/SslUMdnVxy3Aktt0+BMMHD
	16KmpAEM8/7bviXzycfhCM7IgFElNMKbUB/m0ljWiO/PmNHzRpte5PyeaP2EDz/mcVTFMKppdOoLG
	txWVC2uUneHpAAiR3o4GWhLjq+ORyqq5yXiw8jRGZCtuTcEIDmzWWa/FqX38JQ/ZTzkDxBeYNR7JO
	Ns65WMFA==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wAJKH-00DIY7-RL; Wed, 08 Apr 2026 05:11:34 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sched_ext: Dump the stall CPU first in watchdog exit
Date: Wed,  8 Apr 2026 12:11:13 +0900
Message-ID: <20260408031113.76005-3-changwoo@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408031113.76005-1-changwoo@igalia.com>
References: <20260408031113.76005-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a watchdog timeout fires, the CPU where the stalled task was
running is the most relevant piece of information for diagnosing the
hang. However, if there are many CPUs, the dump can get truncated and
the stall CPU's information may not appear in the output.

Add a stall_cpu field to scx_exit_info, thread it through scx_vexit()
and __scx_exit(), and populate it from cpu_of(rq) in
check_rq_for_timeouts(). In scx_dump_state(), dump the stall CPU
before iterating the rest so it always appears at the top of the output.

Introduce a scx_exit() macro that wraps __scx_exit() with stall_cpu=0
for all non-stall exit paths, keeping call sites unchanged.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/ext.c          | 31 ++++++++++++++++++++-----------
 kernel/sched/ext_internal.h |  3 +++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8f7d5c1556be..671a1713aedb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -200,24 +200,28 @@ static bool task_dead_and_done(struct task_struct *p);
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind);
 static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
-		      s64 exit_code, const char *fmt, va_list args);
+		      s64 exit_code, int stall_cpu, const char *fmt,
+		      va_list args);
 
-static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
-				    enum scx_exit_kind kind, s64 exit_code,
-				    const char *fmt, ...)
+static __printf(5, 6) bool __scx_exit(struct scx_sched *sch,
+				      enum scx_exit_kind kind, s64 exit_code,
+				      int stall_cpu, const char *fmt, ...)
 {
 	va_list args;
 	bool ret;
 
 	va_start(args, fmt);
-	ret = scx_vexit(sch, kind, exit_code, fmt, args);
+	ret = scx_vexit(sch, kind, exit_code, stall_cpu, fmt, args);
 	va_end(args);
 
 	return ret;
 }
 
+#define scx_exit(sch, kind, exit_code, fmt, args...)				\
+					__scx_exit(sch, kind, exit_code, 0, fmt, ##args)
+
 #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
-#define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, fmt, args)
+#define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, 0, fmt, args)
 
 #define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
 
@@ -3433,9 +3437,10 @@ static bool check_rq_for_timeouts(struct rq *rq)
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
@@ -6337,8 +6342,11 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 	dump_line(&s, "CPU states");
 	dump_line(&s, "----------");
 
+	/* Dump the stall CPU first, then dump the rest in order. */
+	scx_dump_cpu(sch, &s, &dctx, ei->stall_cpu, dump_all_tasks);
 	for_each_possible_cpu(cpu) {
-		scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
+		if (cpu != ei->stall_cpu)
+			scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
 	}
 
 	dump_newline(&s);
@@ -6377,7 +6385,7 @@ static void scx_disable_irq_workfn(struct irq_work *irq_work)
 }
 
 static bool scx_vexit(struct scx_sched *sch,
-		      enum scx_exit_kind kind, s64 exit_code,
+		      enum scx_exit_kind kind, s64 exit_code, int stall_cpu,
 		      const char *fmt, va_list args)
 {
 	struct scx_exit_info *ei = sch->exit_info;
@@ -6400,6 +6408,7 @@ static bool scx_vexit(struct scx_sched *sch,
 	 */
 	ei->kind = kind;
 	ei->reason = scx_exit_reason(ei->kind);
+	ei->stall_cpu = stall_cpu;
 
 	irq_work_queue(&sch->disable_irq_work);
 	return true;
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b4f36d8b9c1d..a0a09e8f2ac2 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -93,6 +93,9 @@ struct scx_exit_info {
 	/* %SCX_EXIT_* - broad category of the exit reason */
 	enum scx_exit_kind	kind;
 
+	/* CPU where a task stall happened. */
+	int			stall_cpu;
+
 	/* exit code if gracefully exiting */
 	s64			exit_code;
 
-- 
2.53.0

