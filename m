Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F73311967;
	Sat, 25 Jul 2026 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784940624; cv=none; b=bdfjmOmKSYEB1kw7hvUJrTI8+DNlxzNzbeZ66FPaZuxkeOqtHkKQrJPUhgUg+32HR+8BDelyd59T56FPdhSYM21dU5u3C92/EudiDv3VAWzLJDh1szk04EFWxflJYTNDZH22D74j5hnkRQWeZwOv3y+7/l0GIgUQMHYSTiZOU88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784940624; c=relaxed/simple;
	bh=XvfLwKCnm9xv0Ly2qi6kbtPN8fuGppM0jhDQiW9f1Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYEVAtAQDvEabYVdfYbsMMg1fSYtRnAr0dESt/FRfePkhxK6Wkgw0x2ncUDoNzeLA374GQ2EiHFRDohhGsFndVTVWDRKyIYpMfGHAefbfu2lykCmST3IN3K5Kf/TxH+IzuhcyhUBqBvFPj7KAua2uNW7g4V1R7VOeWSzBOhSP9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPQ6JN0m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPQ6JN0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2651F000E9;
	Sat, 25 Jul 2026 00:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784940622;
	bh=P6e3JXGNtjy6KYX7lCB/Z1zxdrUZosMK7M+KP7O1s4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SPQ6JN0ms9JmIV2IZi5C8Rx/48jQX8LxbIOU5lCWCIuFOyhZntWgxFxaZbYCnwhg6
	 p7oTdpigJ810RqeDFJhMxJxKeyTsUU2zwTNshyRvTYWAU+q8inCLBd+wLfGYCGY1GO
	 H/4CXFnYFT018sszdR/r3N/PJdHHlnQj6+16Uxph7uK7f7s/ZCVMwo8UzScHgC9yZt
	 ib1v1eqbDmYXBjDQ8zttJHhxNRs3SDXZo5991v5X3J0Sm1wAAODmkHniFQZdP0Nfi+
	 Z3MQaVAKJL1bt1HEFpDgfwyG6EFAbdDXiXT7pKgp1YhLr6CMH1vIKBL//6P732kisD
	 q2OC80cZXT/4A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/5] sched_ext: Format bstr exit messages after claiming the exit
Date: Fri, 24 Jul 2026 14:50:16 -1000
Message-ID: <20260725005019.1297049-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725005019.1297049-1-tj@kernel.org>
References: <20260725005019.1297049-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bstr exit kfuncs format the message into a shared static buffer under a
raw spinlock before initiating the exit. The lock can't be taken from NMI
and needlessly serializes all bstr exits system-wide.

Now that exit claiming is lock-free, reverse the order: claim the exit first
and format directly into the exit_info message buffer which the claim winner
owns exclusively. The new scx_exit_bstr() implements the sequence, replacing
scx_bstr_format(), and the shared buffer and lock are deleted; the formatter
itself is what bpf_trace_printk() already runs from NMI. scx_prog_sched()
callers were relying on the lock for RCU protection, which is now provided
explicitly.

A malformed format no longer changes or fails the requested operation:
scx_bpf_exit_bstr() keeps its graceful exit kind and scx_bpf_sub_kill_bstr()
still kills the child, with a fallback message carrying the formatting
errno, while the sched that supplied the bad format is aborted for its bug.

Before this and the previous patch, an "any" category kfunc called from NMI
context could trigger scx_error() and deadlock - e.g. a tracing prog
attached to a function running in NMI calling scx_bpf_dsq_peek() on a
non-existent DSQ would try to grab scx_sched_lock, which may be held by the
interrupted CPU. This and the previous patch fix the deadlock: scx_error()
and the bstr exit kfuncs, and thus scx_bpf_error() and scx_bpf_exit(), are
now safe to call from any context including NMI.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 90 ++++++++++++++++++++++++-------------
 kernel/sched/ext/internal.h |  7 ++-
 kernel/sched/ext/sub.c      |  7 +--
 3 files changed, 64 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 30ce4c9428cf..29ca5f5ec30b 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -196,9 +196,6 @@ static const struct rhashtable_params dsq_hash_params = {
 
 static LLIST_HEAD(dsqs_to_free);
 
-DEFINE_RAW_SPINLOCK(scx_exit_bstr_buf_lock);
-struct scx_bstr_buf scx_exit_bstr_buf;
-
 /* ops debug dump */
 static DEFINE_RAW_SPINLOCK(scx_dump_lock);
 
@@ -6749,17 +6746,12 @@ static void scx_disable_irq_workfn(struct irq_work *irq_work)
 	kthread_queue_work(sch->helper, &sch->disable_work);
 }
 
-bool scx_vexit(struct scx_sched *sch,
-	       enum scx_exit_kind kind, s64 exit_code, s32 exit_cpu,
-	       const char *fmt, va_list args)
+/* finish exit_info and kick the disable work, ei->msg must already be set */
+static void scx_finish_exit(struct scx_sched *sch, enum scx_exit_kind kind,
+			    s64 exit_code, s32 exit_cpu)
 {
 	struct scx_exit_info *ei = sch->exit_info;
 
-	guard(preempt)();
-
-	if (!scx_claim_exit(sch, kind))
-		return false;
-
 	ei->exit_code = exit_code;
 #ifdef CONFIG_STACKTRACE
 	/*
@@ -6769,8 +6761,6 @@ bool scx_vexit(struct scx_sched *sch,
 	if (kind >= SCX_EXIT_ERROR && !in_nmi())
 		ei->bt_len = stack_trace_save(ei->bt, SCX_EXIT_BT_LEN, 1);
 #endif
-	vscnprintf(ei->msg, SCX_EXIT_MSG_LEN, fmt, args);
-
 	/*
 	 * Set ei->kind and ->reason for scx_dump_state(). They'll be set again
 	 * in scx_disable_workfn().
@@ -6780,6 +6770,22 @@ bool scx_vexit(struct scx_sched *sch,
 	ei->exit_cpu = exit_cpu;
 
 	irq_work_queue(&sch->disable_irq_work);
+}
+
+bool scx_vexit(struct scx_sched *sch,
+	       enum scx_exit_kind kind, s64 exit_code, s32 exit_cpu,
+	       const char *fmt, va_list args)
+{
+	struct scx_exit_info *ei = sch->exit_info;
+
+	guard(preempt)();
+
+	if (!scx_claim_exit(sch, kind))
+		return false;
+
+	vscnprintf(ei->msg, SCX_EXIT_MSG_LEN, fmt, args);
+
+	scx_finish_exit(sch, kind, exit_code, exit_cpu);
 	return true;
 }
 
@@ -9593,12 +9599,38 @@ static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
 	return ret;
 }
 
-__printf(3, 0)
-s32 scx_bstr_format(struct scx_sched *sch, struct scx_bstr_buf *buf,
-		    char *fmt, unsigned long long *data, u32 data__sz)
+/*
+ * Exit @sch with the reason formatted from a BPF-supplied bstr format. The exit
+ * is claimed first and the reason is formatted directly into the winner-owned
+ * exit_info buffer, which allows use from any context including NMI.
+ *
+ * @fmt_blame is the sched blamed for formatting failures through the
+ * scx_error() calls in __bstr_format() and differs from @sch when a parent
+ * supplies the kill reason for a child. A formatting failure doesn't revert the
+ * claim - @sch still exits with the claimed kind and a fallback message.
+ */
+__printf(5, 0)
+bool scx_exit_bstr(struct scx_sched *sch, enum scx_exit_kind kind,
+		   s64 exit_code, struct scx_sched *fmt_blame, char *fmt,
+		   unsigned long long *data, u32 data__sz)
 {
-	return __bstr_format(sch, buf->data, buf->line, sizeof(buf->line),
-			     fmt, data, data__sz);
+	struct scx_exit_info *ei = sch->exit_info;
+	u64 data_buf[MAX_BPRINTF_VARARGS];
+	s32 ret;
+
+	guard(preempt)();
+
+	if (!scx_claim_exit(sch, kind))
+		return false;
+
+	ret = __bstr_format(fmt_blame, data_buf, ei->msg, SCX_EXIT_MSG_LEN,
+			    fmt, data, data__sz);
+	if (ret < 0)
+		scnprintf(ei->msg, SCX_EXIT_MSG_LEN,
+			  "exit message formatting failed (%d)", ret);
+
+	scx_finish_exit(sch, kind, exit_code, raw_smp_processor_id());
+	return true;
 }
 
 __bpf_kfunc_start_defs();
@@ -9620,14 +9652,13 @@ __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
 				   const struct bpf_prog_aux *aux)
 {
 	struct scx_sched *sch;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&scx_exit_bstr_buf_lock, flags);
+	guard(rcu)();
+
 	sch = scx_prog_sched(aux);
-	if (likely(sch) &&
-	    scx_bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
-		scx_exit(sch, SCX_EXIT_UNREG_BPF, exit_code, "%s", scx_exit_bstr_buf.line);
-	raw_spin_unlock_irqrestore(&scx_exit_bstr_buf_lock, flags);
+	if (likely(sch))
+		scx_exit_bstr(sch, SCX_EXIT_UNREG_BPF, exit_code, sch, fmt,
+			      data, data__sz);
 }
 
 /**
@@ -9645,14 +9676,13 @@ __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
 				    u32 data__sz, const struct bpf_prog_aux *aux)
 {
 	struct scx_sched *sch;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&scx_exit_bstr_buf_lock, flags);
+	guard(rcu)();
+
 	sch = scx_prog_sched(aux);
-	if (likely(sch) &&
-	    scx_bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
-		scx_exit(sch, SCX_EXIT_ERROR_BPF, 0, "%s", scx_exit_bstr_buf.line);
-	raw_spin_unlock_irqrestore(&scx_exit_bstr_buf_lock, flags);
+	if (likely(sch))
+		scx_exit_bstr(sch, SCX_EXIT_ERROR_BPF, 0, sch, fmt, data,
+			      data__sz);
 }
 
 /**
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 4b07f82bef40..a0659f74b065 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2007,15 +2007,14 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 int scx_validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops);
 int scx_sched_sysfs_add(struct scx_sched *sch);
 bool scx_is_descendant(struct scx_sched *sch, struct scx_sched *ancestor);
-__printf(3, 0) s32 scx_bstr_format(struct scx_sched *sch, struct scx_bstr_buf *buf,
-				   char *fmt, unsigned long long *data, u32 data__sz);
+__printf(5, 0) bool scx_exit_bstr(struct scx_sched *sch, enum scx_exit_kind kind,
+				  s64 exit_code, struct scx_sched *fmt_blame,
+				  char *fmt, unsigned long long *data, u32 data__sz);
 
 extern raw_spinlock_t scx_sched_lock;
 extern struct mutex scx_enable_mutex;
 extern struct percpu_rw_semaphore scx_fork_rwsem;
 extern bool scx_cgroup_enabled;
-extern raw_spinlock_t scx_exit_bstr_buf_lock;
-extern struct scx_bstr_buf scx_exit_bstr_buf;
 #ifdef CONFIG_EXT_SUB_SCHED
 extern const struct rhashtable_params scx_sched_hash_params;
 extern struct rhashtable scx_sched_hash;
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 76ff58de54e7..6b3f3cddf62c 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -2150,7 +2150,6 @@ __bpf_kfunc s32 scx_bpf_sub_kill_bstr(u64 cgroup_id, char *fmt,
 				      const struct bpf_prog_aux *aux)
 {
 	struct scx_sched *parent, *child;
-	s32 ret;
 
 	guard(rcu)();
 
@@ -2173,11 +2172,7 @@ __bpf_kfunc s32 scx_bpf_sub_kill_bstr(u64 cgroup_id, char *fmt,
 		return -EINVAL;
 	}
 
-	guard(raw_spinlock_irqsave)(&scx_exit_bstr_buf_lock);
-	ret = scx_bstr_format(parent, &scx_exit_bstr_buf, fmt, data, data__sz);
-	if (ret < 0)
-		return ret;
-	scx_exit(child, SCX_EXIT_PARENT_KILL, 0, "%s", scx_exit_bstr_buf.line);
+	scx_exit_bstr(child, SCX_EXIT_PARENT_KILL, 0, parent, fmt, data, data__sz);
 	return 0;
 }
 
-- 
2.55.0

