Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E73ED5D6;
	Wed,  4 Mar 2026 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661714; cv=none; b=r/OFTOV97xtBPLIVO7nhQBlVnKj5Qi7FBLIL64XQ1M21yoVOY9oe9r9vGaQXTEdtv/VuLpbNIz+tY+IG4MJgbR3hRwlUKXKhYaedVrm58phCAf33pS6d67Qx2tF3zWHrNTKyKASchUbVcHf4qeg1xZ44LjQiCFJOx85XSUYovj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661714; c=relaxed/simple;
	bh=0oZy895phTwKLJdOppslE/LO6noMIUuYyW21RcdTXhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=appKKST3MX6BNbNWAlYZny37EKb3Fg4txB4o7b94GFEVpI/IAD8oSORyDZOjsczSppjEEAK6GxoQOCVZGnYU6DcBbOBNdGo/5RXJ9mKB1ydZeR8y8EF/T4g+gsJD5Uq4xze2E/6yzI/dhZh/S83EyELkIuQE9itR7sLEglFoPt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csXV1C/W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csXV1C/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F6FC4CEF7;
	Wed,  4 Mar 2026 22:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661714;
	bh=0oZy895phTwKLJdOppslE/LO6noMIUuYyW21RcdTXhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=csXV1C/WqsKEnsKRKsLgkG9ZT/8LQZ+dmBahApJHUJgemqs7wbbOPYu7zPSv1e/y6
	 86p/YClFKuPNvWGYLYq67mS4YZwytVuV8F2nP3dcCt/WEOc6EDbmTV1kvOQxM8EpqU
	 U8XoKINgVkADk2Nqdb1A/I6yQQe4r50edObRB/sgPe6PNjLenLtFKVVTDEMKAgoWE8
	 KQtIHB6ptgdLbuWjB2FoSqROvAEhW/rhFnRmZBkmw2jPu5eWnKqmKlE8+Dggh+kr3/
	 /fL6lQhZxZDTqv+tU0Sj2Dv1RXwhbLHxS83ckuD7KAtE6e1e1RoYRhc3tH0L8pmNio
	 hxwJiFQuFKVRA==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 32/34] sched_ext: Factor out scx_link_sched() and scx_unlink_sched()
Date: Wed,  4 Mar 2026 12:01:17 -1000
Message-ID: <20260304220119.4095551-33-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
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
index 946cf4c946fd..0b7dc6573411 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4830,6 +4830,33 @@ static void refresh_watchdog(void)
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
 
@@ -4979,12 +5006,7 @@ static void scx_sub_disable(struct scx_sched *sch)
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
 
@@ -5120,11 +5142,7 @@ static void scx_root_disable(struct scx_sched *sch)
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
@@ -5888,11 +5906,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	 */
 	rcu_assign_pointer(scx_root, sch);
 
-	raw_spin_lock_irq(&scx_sched_lock);
-	list_add_tail_rcu(&sch->all, &scx_sched_all);
-	raw_spin_unlock_irq(&scx_sched_lock);
-
-	refresh_watchdog();
+	scx_link_sched(sch);
 
 	scx_idle_enable(ops);
 
@@ -6157,12 +6171,7 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
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
2.53.0

