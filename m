Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8712FC037;
	Mon, 10 Nov 2025 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808206; cv=none; b=lF08Ce8nta+N0q9ubWiKcCnf7qJ7TXgXycX2F/s8p96RzvswWmeRoxhO30+9rFSyyuGgH4OV09JEG3r1P2h4s4pvruer+q0tRcrl1TyTEXQNt2pHbpRMjIoQlo+i34PSa+eD2c+iZGBasvpmGfzIc67+j8GK1OqkTBNRuoOJFsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808206; c=relaxed/simple;
	bh=UG/ROA07VOZOvjrbjjIJEdIXVNmyWQg7uMyQIB40flU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6o6VG2TNM3gmBck0msjcB1WCNOt5zN6eEJfmpy80SnNDv5+Bpt9xcLg539YmSd0OL57sdkpCiAiJ/WbDbo1mRg8Gvi4wtj8SGx0N8q98OYBovkDNp16ayjl09om/aA6tOPFyS2+G6YOwzD/M9/Bl2tMgGJ1zQ3rJ6XEGiwmmg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmFi5iM0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmFi5iM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4432C19421;
	Mon, 10 Nov 2025 20:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762808205;
	bh=UG/ROA07VOZOvjrbjjIJEdIXVNmyWQg7uMyQIB40flU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RmFi5iM0JksqFOwFY8xTOUWzJONnbgAgCB61S9MtAHsJC7CoBJnSfFiH+TGizdOgE
	 +naovUjobLOyU7SjfzudOcMoFNV45yTaDekQsyNbYyowK/G5nNdmAmmxfDM507hN6F
	 /su05dm7SCweV1AMJPdoQNcYpSTfI2bG1tgrTzZuODZCs2eOY97lG9n1ZO1rcnbudK
	 0P0BMl+UjB3ZqMgc4fydawNZdUjopwutkrb97NMGzUO/iEbefyBIrZfVS2I6q0taB5
	 te+k6g8yfVjUQeEoeBZUfy+okOxq4nR6pbbvOopMSWS5xSi+BHIUKM3k8W5WyVqgx5
	 Spq05z9eTb2pA==
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
Subject: [PATCH v2 08/14] sched_ext: Refactor lockup handlers into handle_lockup()
Date: Mon, 10 Nov 2025 10:56:30 -1000
Message-ID: <20251110205636.405592-9-tj@kernel.org>
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

scx_rcu_cpu_stall() and scx_softlockup() share the same pattern: check if the
scheduler is enabled under RCU read lock and trigger an error if so. Extract
the common pattern into handle_lockup() helper. Add scx_verror() macro and use
guard(rcu)().

This simplifies both handlers, reduces code duplication, and prepares for
hardlockup handling.

Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 65 ++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 600918095245..d9572bf99b5b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -192,6 +192,7 @@ static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
 }
 
 #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
+#define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, fmt, args)
 
 #define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
 
@@ -3650,39 +3651,40 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
 	return false;
 }
 
-/**
- * scx_rcu_cpu_stall - sched_ext RCU CPU stall handler
- *
- * While there are various reasons why RCU CPU stalls can occur on a system
- * that may not be caused by the current BPF scheduler, try kicking out the
- * current scheduler in an attempt to recover the system to a good state before
- * issuing panics.
- */
-bool scx_rcu_cpu_stall(void)
+static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
 {
 	struct scx_sched *sch;
+	va_list args;
 
-	rcu_read_lock();
+	guard(rcu)();
 
 	sch = rcu_dereference(scx_root);
-	if (unlikely(!sch)) {
-		rcu_read_unlock();
+	if (unlikely(!sch))
 		return false;
-	}
 
 	switch (scx_enable_state()) {
 	case SCX_ENABLING:
 	case SCX_ENABLED:
-		break;
+		va_start(args, fmt);
+		scx_verror(sch, fmt, args);
+		va_end(args);
+		return true;
 	default:
-		rcu_read_unlock();
 		return false;
 	}
+}
 
-	scx_error(sch, "RCU CPU stall detected!");
-	rcu_read_unlock();
-
-	return true;
+/**
+ * scx_rcu_cpu_stall - sched_ext RCU CPU stall handler
+ *
+ * While there are various reasons why RCU CPU stalls can occur on a system
+ * that may not be caused by the current BPF scheduler, try kicking out the
+ * current scheduler in an attempt to recover the system to a good state before
+ * issuing panics.
+ */
+bool scx_rcu_cpu_stall(void)
+{
+	return handle_lockup("RCU CPU stall detected!");
 }
 
 /**
@@ -3697,28 +3699,11 @@ bool scx_rcu_cpu_stall(void)
  */
 void scx_softlockup(u32 dur_s)
 {
-	struct scx_sched *sch;
-
-	rcu_read_lock();
-
-	sch = rcu_dereference(scx_root);
-	if (unlikely(!sch))
-		goto out_unlock;
-
-	switch (scx_enable_state()) {
-	case SCX_ENABLING:
-	case SCX_ENABLED:
-		break;
-	default:
-		goto out_unlock;
-	}
-
-	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU%d stuck for %us, disabling \"%s\"\n",
-			smp_processor_id(), dur_s, scx_root->ops.name);
+	if (!handle_lockup("soft lockup - CPU %d stuck for %us", smp_processor_id(), dur_s))
+		return;
 
-	scx_error(sch, "soft lockup - CPU#%d stuck for %us", smp_processor_id(), dur_s);
-out_unlock:
-	rcu_read_unlock();
+	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU %d stuck for %us, disabling BPF scheduler\n",
+			smp_processor_id(), dur_s);
 }
 
 /**
-- 
2.51.2

