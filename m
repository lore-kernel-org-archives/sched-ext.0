Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689345104C;
	Wed, 21 Jan 2026 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037138; cv=none; b=indnqH0vqby9Jgm/pxI7iaA6M6+TvsxGZGmy3dwCAKxM1SBEBcNcgW/nQpLM/DoPc8fHN8+m49tB9cBi2CHcPDxDYyLWge4wL6EK6CONKw7H071b165JK59AjZEzB08RrTTRAxFbyhe+f5Mhh/P9r0Yh6nf1gUkZALR+Eq2/vDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037138; c=relaxed/simple;
	bh=UfGqdzW+aWpCaHcFsCfpbXeiMblwjxmKS35CX6pxlZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8kFrDnadlQ+V9e/bMxU83yYGJx1RtIhhVGw5EPe9AgarI0M8Pei3O0PA5+DGIZkGOtFQhv1Mm242rapfxR6zHwHsoHERIxslU3rPYVuNl2r9kEjt4ZZ99lZwr0KE513LX6Pl3l1dGz0q+USBnS/hcgaokkgbxmdREWBvpSYAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+9io4Nl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+9io4Nl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3E4C16AAE;
	Wed, 21 Jan 2026 23:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037135;
	bh=UfGqdzW+aWpCaHcFsCfpbXeiMblwjxmKS35CX6pxlZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+9io4NlipUzYLGRSzD9PdHB5wBcT1ZJwJYFEuc+wwjhYw/RNwgWfbCba8TMoftfM
	 Ch4i6lRwac/DjxywWtGn8gKuswX2WnoofPuXG8E+ZWGKzQjdJot89IYTxrB7zeWTvm
	 5szm1hI9eMVz0ARx/8qhOEisbmoZF/h42Hv07ZDB/Z4FhOxdIAL6TW1NnHgHVLMyPd
	 A5R4AwRMklk8XsvH7RIpOWAdPmMb/pJS+Usy3GnsWMK9UYcbr/mvIMvqVgAzvvDQyS
	 1liWaqPm94c1cdHqZcYAUXVbl6HsvWMDb3ns1JZ7Za+wialSNikHtzU8QYXCjciEvu
	 rokC4uPF89z/w==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 32/34] sched_ext: Factor out scx_link_sched() and scx_unlink_sched()
Date: Wed, 21 Jan 2026 13:11:38 -1000
Message-ID: <20260121231140.832332-33-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121231140.832332-1-tj@kernel.org>
References: <20260121231140.832332-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out scx_link_sched() and scx_unlink_sched() functions to reduce
code duplication in the scheduler enable/disable paths.

No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 53 +++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 469fcbe4611c..89160d080743 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4629,6 +4629,33 @@ static void refresh_watchdog(void)
 		cancel_delayed_work_sync(&scx_watchdog_work);
 }
 
+static void scx_link_sched(struct scx_sched *sch)
+{
+	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
+#ifdef CONFIG_EXT_SUB_SCHED
+		struct scx_sched *parent = scx_parent(sch);
+		if (parent)
+			list_add_tail(&sch->sibling, &parent->children);
+#endif	/* CONFIG_EXT_SUB_SCHED */
+		list_add_tail_rcu(&sch->all, &scx_sched_all);
+	}
+
+	refresh_watchdog();
+}
+
+static void scx_unlink_sched(struct scx_sched *sch)
+{
+	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
+#ifdef CONFIG_EXT_SUB_SCHED
+		if (scx_parent(sch))
+			list_del_init(&sch->sibling);
+#endif	/* CONFIG_EXT_SUB_SCHED */
+		list_del_rcu(&sch->all);
+	}
+
+	refresh_watchdog();
+}
+
 #ifdef CONFIG_EXT_SUB_SCHED
 static DECLARE_WAIT_QUEUE_HEAD(scx_unlink_waitq);
 
@@ -4778,12 +4805,7 @@ static void scx_sub_disable(struct scx_sched *sch)
 	synchronize_rcu_expedited();
 	disable_bypass_dsp(sch);
 
-	raw_spin_lock_irq(&scx_sched_lock);
-	list_del_init(&sch->sibling);
-	list_del_rcu(&sch->all);
-	raw_spin_unlock_irq(&scx_sched_lock);
-
-	refresh_watchdog();
+	scx_unlink_sched(sch);
 
 	mutex_unlock(&scx_enable_mutex);
 
@@ -4919,11 +4941,7 @@ static void scx_root_disable(struct scx_sched *sch)
 	if (sch->ops.exit)
 		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, exit, NULL, ei);
 
-	raw_spin_lock_irq(&scx_sched_lock);
-	list_del_rcu(&sch->all);
-	raw_spin_unlock_irq(&scx_sched_lock);
-
-	refresh_watchdog();
+	scx_unlink_sched(sch);
 
 	/*
 	 * scx_root clearing must be inside cpus_read_lock(). See
@@ -5667,11 +5685,7 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	rcu_assign_pointer(scx_root, sch);
 
-	raw_spin_lock_irq(&scx_sched_lock);
-	list_add_tail_rcu(&sch->all, &scx_sched_all);
-	raw_spin_unlock_irq(&scx_sched_lock);
-
-	refresh_watchdog();
+	scx_link_sched(sch);
 
 	scx_idle_enable(ops);
 
@@ -5932,12 +5946,7 @@ static s32 scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		goto out_put_cgrp;
 	}
 
-	raw_spin_lock_irq(&scx_sched_lock);
-	list_add_tail(&sch->sibling, &parent->children);
-	list_add_tail_rcu(&sch->all, &scx_sched_all);
-	raw_spin_unlock_irq(&scx_sched_lock);
-
-	refresh_watchdog();
+	scx_link_sched(sch);
 
 	if (sch->level >= SCX_SUB_MAX_DEPTH) {
 		scx_error(sch, "max nesting depth %d violated",
-- 
2.52.0

