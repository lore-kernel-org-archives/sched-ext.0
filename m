Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7858B1E25F9;
	Thu,  2 Apr 2026 02:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775097137; cv=none; b=d1zVC1B5xoO+YGqg0TykWVrnHro1fvTkhegrHiturcpmBDaWIObinz7xVw/4dbslXO/Ae5vj02b7Fktucgw7IhOz2+XBI29VcM0K6vMdXDDXkoUjxsqjGJiSAnV6Pt82zvwRSjk2RkY9sBNtsp+gqQVnfd7RkFMnz+p8UhiTkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775097137; c=relaxed/simple;
	bh=wzuLEmgINFmEPE3IKqlruzi0zrOAr+zWO1BeESdBMJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sr5SP7ZhaIevBHj95r5GaQpKk3lMXIhtbE3rr+gl4Zy8xdwfIUXKsqZ0Z0NrKVCQg4AMbyyOFAcxfUzD5MpYSKu90eESk2D9wQ7XjvzwCwVV3ck5FYVgdv+gprWdCM1GHC6vBHD4x7IUzJrY/zShCOOBRSKfEt8W9biuMSvUXWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kUKpTJoI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kUKpTJoI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MPedqWtIejABFLnxYnSR+o4TxN1waQ7/CJFSQOoLaMc=; b=kUKpTJoIG8BUfYMLtEdeFmOU3n
	N87BSgGoJdUTbE+MuUIZVR4h6jKA0Dg2xUaYrw0rNiGiABgUOcxIccLypm/mSZIeGZu7VWVQ0uueM
	uKMd6uJ1AfeWdsQcrBOb6QsUBwBQDGbx7Ros4aT+iXaR9EY8yyaza5+4EB2AbTqQiHxb0jmezEiNj
	/+ESWs8zTH+a0EKnpUpHcB0/IJ9y6D1BsSUJSuL9dRnfAAaXhDUuIsdzbUGpMPZKaFlf9L0t+m9zG
	4pyEDSS8Tz15nqwfCDlbfIhJ8lklHMMm8V504EPD68wDwznDYci4grdCWuzLnUs1olaO9OlPKFgG2
	CSaAxySQ==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w87qe-00AGn7-Dj; Thu, 02 Apr 2026 04:31:57 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Fix is_bpf_migration_disabled() false negative on non-PREEMPT_RCU
Date: Thu,  2 Apr 2026 11:31:50 +0900
Message-ID: <20260402023150.660967-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 8e4f0b1ebcf2 ("bpf: use rcu_read_lock_dont_migrate() for
trampoline.c"), the BPF prolog (__bpf_prog_enter) calls migrate_disable()
only when CONFIG_PREEMPT_RCU is enabled, via rcu_read_lock_dont_migrate().
Without CONFIG_PREEMPT_RCU, the prolog never touches migration_disabled,
so migration_disabled == 1 always means the task is truly
migration-disabled regardless of whether it is the current task.

The old unconditional p == current check was a false negative in this
case, potentially allowing a migration-disabled task to be dispatched to
a remote CPU and triggering scx_error in task_can_run_on_remote_rq().

Only apply the p == current disambiguation when CONFIG_PREEMPT_RCU is
enabled, where the ambiguity with the BPF prolog still exists.

Link: https://lore.kernel.org/lkml/20250821090609.42508-8-dongml2@chinatelecom.cn/
Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/ext_idle.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index a61339c36902..ecf7e09b54ae 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -881,25 +881,32 @@ static bool check_builtin_idle_enabled(struct scx_sched *sch)
  * code.
  *
  * We can't simply check whether @p->migration_disabled is set in a
- * sched_ext callback, because migration is always disabled for the current
- * task while running BPF code.
+ * sched_ext callback, because the BPF prolog (__bpf_prog_enter) may disable
+ * migration for the current task while running BPF code.
  *
- * The prolog (__bpf_prog_enter) and epilog (__bpf_prog_exit) respectively
- * disable and re-enable migration. For this reason, the current task
- * inside a sched_ext callback is always a migration-disabled task.
+ * Since the BPF prolog calls migrate_disable() only when CONFIG_PREEMPT_RCU
+ * is enabled (via rcu_read_lock_dont_migrate()), migration_disabled == 1 for
+ * the current task is ambiguous only in that case: it could be from the BPF
+ * prolog rather than a real migrate_disable() call.
  *
- * Therefore, when @p->migration_disabled == 1, check whether @p is the
- * current task or not: if it is, then migration was not disabled before
- * entering the callback, otherwise migration was disabled.
+ * Without CONFIG_PREEMPT_RCU, the BPF prolog never calls migrate_disable(),
+ * so migration_disabled == 1 always means the task is truly
+ * migration-disabled.
+ *
+ * Therefore, when migration_disabled == 1 and CONFIG_PREEMPT_RCU is enabled,
+ * check whether @p is the current task or not: if it is, then migration was
+ * not disabled before entering the callback, otherwise migration was disabled.
  *
  * Returns true if @p is migration-disabled, false otherwise.
  */
 static bool is_bpf_migration_disabled(const struct task_struct *p)
 {
-	if (p->migration_disabled == 1)
-		return p != current;
-	else
-		return p->migration_disabled;
+	if (p->migration_disabled == 1) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RCU))
+			return p != current;
+		return true;
+	}
+	return p->migration_disabled;
 }
 
 static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
-- 
2.53.0

