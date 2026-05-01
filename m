Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0017271443
	for <sched-ext@lists.linux.dev>; Fri,  1 May 2026 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777641396; cv=none; b=HVGWd1HX/z+eyEafkw8iOlCw0ZVl61hos1biuDQ7MFsavuvb41AlvlLUX15u7+oFPClBzLf4o1MKjLkOasZlA05IWtCqZEHxwe5fvseRWIr8VMy46AMB7pgC+ZnTPf9F0O1mBQFMM5zoTZABc3El/w5gprx/fMpZ/njRzsdLBc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777641396; c=relaxed/simple;
	bh=+yMsvqNuTCXfoMu2+1Pv6YNXX9sHTAEKX1fyl3k3IIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMB/tP2/BHX3b7uvwZwI5NAe8laVmOea6JcivAsPF44x2pDwD3ilnlpVmqWKj6gpqcgBQ05A0MIFV8OLYhYrw+zhSMgwA1M1dUj6jFHtBzBO6HNX+IgUyl69ylzJVVgq5GR3FXVcj58sgbKsSxvPyjd5t28bZw3SIe9duf2KI5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBJZuwtW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBJZuwtW"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b941cd869cso11651205ad.1
        for <sched-ext@lists.linux.dev>; Fri, 01 May 2026 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777641394; x=1778246194; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yZEJkZaBicNCwiNqFGstA5XafzgCy3rU/S3i0HrvL0=;
        b=jBJZuwtW0H6GxTmMnbV+sUFR2UxMmu5g7Yp5Z3f6gT5yPF+KCMpIp6JF4vVUj1iLUU
         ZEvs45FA2C36yUURDhSlPYodE/qneVBlRrcgXfgPI3FP06mVHi5NTHmrfT/ctFtmAROA
         lJr3Ia3xLeUZdO0nwv9e9FLa9HX5kzWrRQwWv/6iX+teohHA+TQMsrIwOSZrHR8Q3z5d
         Loe3BpZ3JqBtU6dtkI53lcNB15SydBmFUCPX5pVxsrpztFo5L/imM3Hod10dVLSGG9U3
         +uTp82ksjH1mpjR4v0K7Hfjccg6VGnW4T3SQrs//ZBaBul1X16a6QsmY+37wTnOxNf+E
         zf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777641394; x=1778246194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yZEJkZaBicNCwiNqFGstA5XafzgCy3rU/S3i0HrvL0=;
        b=A6BtguI6sQLIHNCwgQ6uG935jkHe/YzqUncRQGX00hmEjcRMcGqczxW5lJ1f0cLn6j
         rY19wUFTPQGtYkb1AxuykKEJ9UqEAEcEEDrm1WtDz8zlFc8Wob1BRN1p/zz1pC6akSRK
         dYeUrgcnKs52oWQd1HCKns1Q4SZqCFamoQnOZ+covQxSxFVtK4fLJ3HYBUmijhtF8bkS
         WMAaM9ODh3ezuG87ImBCn3VZunsn5Yz4hP7gDS8Xe+RZL4uI156PyydeyTkF3jbNLS6V
         CQjRoQ4DDHaFJ72bXNQWS+leleDxl0m/8uK0xzqm+vZhT+9IBXO5k1qpkDItDbnhB0KY
         kvMg==
X-Gm-Message-State: AOJu0YyCUodkxAjx8emMibpRYZSmq93o+6tjNh2yi4cSSEhHndbiE6Jl
	PoN5f/QPnaQy1o5c3q8yn64OdO27KyR2wRw7XsscA50xW97GsHeonnM3ku0WUQ==
X-Gm-Gg: AeBDieuX2Pzxx/gSvjxIMdzwEwrU6KwUfe/SIT/NobZHedcIJxTb6tdffkwOm/NiQiL
	jNBJMHcS6Dw24dwJhLlaItSpeVsnMwpmKlFDG9DmMVUmrDYIXmkqxav79XDB8GP+jdRt5VJ97J7
	3QGbAc1X96hcTTC0J4yO8+Q1jsF0SjjPveXYmVPquClkipQXeRGi8mW6ncXiol2O/nnIt/Ov71O
	5M/Rv8j3D1AGB1YbzXa/T6n8AguDECEAbnTXuNfDrIG6g1KCeS1ItPzYJ5aGXydvM89uWPIVKhT
	0DKgBcBGdL9PbGjSC0gsMIqee+taBpwuaAQsXHuPl/FKC4MEo09IY8UQmaRmvhYdnkLhgKbvLtf
	rNJfWb7/n316EQC5sdaeP1G/zbySX+k+pzXiGa38pFADx9LwSXtqAUxqP/FR+l6N/fOr7Qhyqsj
	5Ck1wUwATjX/ngCbTK4kMp5kwSbupyBv4piGAuuR/jge1FTqP+Ilu77gZ4POPPUYo=
X-Received: by 2002:a17:902:ef0e:b0:2b2:49a7:a5bc with SMTP id d9443c01a7336-2b9a2549738mr52431585ad.39.1777641394045;
        Fri, 01 May 2026 06:16:34 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:57df:16f5:b7ab:5d05])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae59f62sm22438005ad.70.2026.05.01.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 06:16:33 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH 2/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Date: Fri,  1 May 2026 21:14:57 +0800
Message-ID: <20260501131521.161852-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260501131521.161852-1-yphbchou0911@gmail.com>
References: <20260501131521.161852-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_lockup() uses raw_smp_processor_id() for exit_cpu, which is wrong
for two paths:

- scx_hardlockup_irq_workfn() has the hung CPU in a local variable but
  irq_work may run elsewhere; pass the local cpu explicitly.
- scx_rcu_cpu_stall() takes no CPU, recording the detector rather than
  the stalled one; add stalled_cpu to its signature and
  panic_on_rcu_stall(), threading it from print_cpu_stall() (current
  CPU) and print_other_cpu_stall() (first detected stalled CPU).

Add an exit_cpu parameter to handle_lockup() so callers pass the correct
CPU directly. Remove the now-unused scx_verror() macro.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 include/linux/sched/ext.h   |  4 ++--
 kernel/rcu/tree_exp.h       |  2 +-
 kernel/rcu/tree_stall.h     | 11 +++++++----
 kernel/sched/ext.c          | 14 ++++++++------
 kernel/sched/ext_internal.h |  2 --
 5 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index d05efcac794d..16bbf24089ca 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -259,7 +259,7 @@ void sched_ext_dead(struct task_struct *p);
 void print_scx_info(const char *log_lvl, struct task_struct *p);
 void scx_softlockup(u32 dur_s);
 bool scx_hardlockup(int cpu);
-bool scx_rcu_cpu_stall(void);
+bool scx_rcu_cpu_stall(int stalled_cpu);
 
 #else	/* !CONFIG_SCHED_CLASS_EXT */
 
@@ -267,7 +267,7 @@ static inline void sched_ext_dead(struct task_struct *p) {}
 static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
 static inline void scx_softlockup(u32 dur_s) {}
 static inline bool scx_hardlockup(int cpu) { return false; }
-static inline bool scx_rcu_cpu_stall(void) { return false; }
+static inline bool scx_rcu_cpu_stall(int stalled_cpu) { return false; }
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 82cada459e5d..2c9a99a9b68e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -675,7 +675,7 @@ static void synchronize_rcu_expedited_wait(void)
 
 		nbcon_cpu_emergency_exit();
 
-		panic_on_rcu_stall();
+		panic_on_rcu_stall(smp_processor_id());
 	}
 }
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b67532cb8770..172ac08e673d 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -159,7 +159,7 @@ static int __init check_cpu_stall_init(void)
 early_initcall(check_cpu_stall_init);
 
 /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
-static void panic_on_rcu_stall(void)
+static void panic_on_rcu_stall(int stalled_cpu)
 {
 	static int cpu_stall;
 
@@ -167,7 +167,7 @@ static void panic_on_rcu_stall(void)
 	 * Attempt to kick out the BPF scheduler if it's installed and defer
 	 * the panic to give the system a chance to recover.
 	 */
-	if (scx_rcu_cpu_stall())
+	if (scx_rcu_cpu_stall(stalled_cpu))
 		return;
 
 	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
@@ -631,6 +631,7 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
 static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 {
 	int cpu;
+	int first_stalled_cpu = -1;
 	unsigned long flags;
 	unsigned long gpa;
 	unsigned long j;
@@ -660,6 +661,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 			for_each_leaf_node_possible_cpu(rnp, cpu)
 				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
 					print_cpu_stall_info(cpu);
+					if (first_stalled_cpu < 0)
+						first_stalled_cpu = cpu;
 					ndetected++;
 				}
 		}
@@ -701,7 +704,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	nbcon_cpu_emergency_exit();
 
-	panic_on_rcu_stall();
+	panic_on_rcu_stall(first_stalled_cpu);
 
 	rcu_force_quiescent_state();  /* Kick them all. */
 }
@@ -754,7 +757,7 @@ static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	nbcon_cpu_emergency_exit();
 
-	panic_on_rcu_stall();
+	panic_on_rcu_stall(smp_processor_id());
 
 	/*
 	 * Attempt to revive the RCU machinery by forcing a context switch.
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 48c65ac8e230..8a0b1662a75a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5069,6 +5069,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
 
 /**
  * handle_lockup - sched_ext common lockup handler
+ * @exit_cpu: CPU to record in exit_info; pass the stalled/hung CPU, not current
  * @fmt: format string
  *
  * Called on system stall or lockup condition and initiates abort of sched_ext
@@ -5078,7 +5079,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
  * resolve the lockup. %false if sched_ext is not enabled or abort was already
  * initiated by someone else.
  */
-static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
+static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
 {
 	struct scx_sched *sch;
 	va_list args;
@@ -5094,7 +5095,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
 	case SCX_ENABLING:
 	case SCX_ENABLED:
 		va_start(args, fmt);
-		ret = scx_verror(sch, fmt, args);
+		ret = scx_vexit(sch, SCX_EXIT_ERROR, 0, exit_cpu, fmt, args);
 		va_end(args);
 		return ret;
 	default:
@@ -5114,9 +5115,9 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
  * resolve the reported RCU stall. %false if sched_ext is not enabled or someone
  * else already initiated abort.
  */
-bool scx_rcu_cpu_stall(void)
+bool scx_rcu_cpu_stall(int stalled_cpu)
 {
-	return handle_lockup("RCU CPU stall detected!");
+	return handle_lockup(stalled_cpu, "RCU CPU stall detected!");
 }
 
 /**
@@ -5131,7 +5132,8 @@ bool scx_rcu_cpu_stall(void)
  */
 void scx_softlockup(u32 dur_s)
 {
-	if (!handle_lockup("soft lockup - CPU %d stuck for %us", smp_processor_id(), dur_s))
+	if (!handle_lockup(smp_processor_id(), "soft lockup - CPU %d stuck for %us",
+			   smp_processor_id(), dur_s))
 		return;
 
 	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU %d stuck for %us, disabling BPF scheduler\n",
@@ -5150,7 +5152,7 @@ static void scx_hardlockup_irq_workfn(struct irq_work *work)
 {
 	int cpu = atomic_xchg(&scx_hardlockup_cpu, -1);
 
-	if (cpu >= 0 && handle_lockup("hard lockup - CPU %d", cpu))
+	if (cpu >= 0 && handle_lockup(cpu, "hard lockup - CPU %d", cpu))
 		printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
 				cpu);
 }
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b4f5dd28855e..2d04f27cf7c5 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1486,8 +1486,6 @@ __printf(5, 6) bool __scx_exit(struct scx_sched *sch, enum scx_exit_kind kind,
 	__scx_exit(sch, kind, exit_code, raw_smp_processor_id(), fmt, ##args)
 #define scx_error(sch, fmt, args...)						\
 	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
-#define scx_verror(sch, fmt, args)						\
-	scx_vexit((sch), SCX_EXIT_ERROR, 0, raw_smp_processor_id(), fmt, args)
 
 /*
  * Return the rq currently locked from an scx callback, or NULL if no rq is
-- 
2.48.1

