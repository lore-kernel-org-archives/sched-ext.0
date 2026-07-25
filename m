Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38D3148C9;
	Sat, 25 Jul 2026 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784940626; cv=none; b=bE6/1WsdAp2wEJz0L62WiUoBjL0EM1B6lzJRFNsvg9nBW9mrtm8x0M8KStyB9oG1/paLQrqoY+PUEcazLpOTwzUFvcvtNNP8Wizp+Tm5JFRz5GLZ28LCV9z5Xsh5iphJYveVK5GNsH4PL44df9VMs+z4XGJ0hkZFYpdDYvdpyHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784940626; c=relaxed/simple;
	bh=Bq3lsxzRbdRD6SlAaUSwSHDsXCtZUokXjXNoYVAXHpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOX9yTPuc9r0K1nLbJZ1OVjiIUSxNIlwIu0eFY8nElXYHH4rdVlCTf0pq2a3HRtJvcSKDnISj2Y2sI75d0f2C7Qzy6mumhFdvy5YYAyUlcZK8c60cFCQgylGSgt9Wl2vwnC+wpGUAGnQwpgFUpE8qwrklZoAQX9c3t9DUylCKAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKXcCzUp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKXcCzUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09191F000E9;
	Sat, 25 Jul 2026 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784940625;
	bh=zIURcdZJ14o7YSNSnWxDJuQ/88H3OSY+BWnG3usn9hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZKXcCzUpVj82GWjwT9RTQehZ3nZjbUpAlTusAW2xmbRBo0QVOLVXQdE9ajHZb2eXw
	 /5381xyvGljBHlAKO+Bg/4fK0uzFMJGkYw0K+DgW2pmf73XXMprrfEdmkzRAHjOo19
	 QJX9GtYDws/Eo6nTzesSrqCZlqrIPJevatSKCdzE6QXqjnPvsIqK5+LfwUB35X1xxT
	 RRm7hRpo0tJ0dubAgu+LIoX2sXbyLyQfJJ8ZPf4rQq4itOCL5blhzDfKzmtdtcz2Kd
	 Bpp62Rp7qnIoFNIr7fJqr/kry7oeR6kgiqNqgklXFBRvYERIKO/F1v0Ry5bI4vmTMa
	 Vtaq4PxSUmetw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/5] sched_ext: Report scx_link_sched() failures inline
Date: Fri, 24 Jul 2026 14:50:19 -1000
Message-ID: <20260725005019.1297049-6-tj@kernel.org>
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

scx_link_sched() carries each failure out of the locked section through
err_msg and ret because scx_error() used to take scx_sched_lock and couldn't
be called under it. That restriction is gone, so report each failure at the
site it's detected and return directly. The scx_error() here claims the exit
on the sched being linked, which has no descendants yet, and the locked
propagation walk is deferred, so nothing reacquires scx_sched_lock inline.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 9f5729c2c5e2..6ed9818491f3 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -5965,31 +5965,30 @@ static void refresh_watchdog(void)
 
 s32 scx_link_sched(struct scx_sched *sch)
 {
-	const char *err_msg = "";
-	s32 ret = 0;
-
 	scoped_guard(raw_spinlock_irqsave, &scx_bypass_lock)	/* for the parent bypass check */
 	scoped_guard(raw_spinlock, &scx_sched_lock) {
 #ifdef CONFIG_EXT_SUB_SCHED
 		struct scx_sched *parent = scx_parent(sch);
 
 		if (parent) {
+			s32 ret;
+
 			/*
 			 * Bypass state is spread across per-cpu flags and a
 			 * depth count, so inheriting it is tricky and has no
 			 * valid use case. Refuse it.
 			 */
 			if (READ_ONCE(parent->bypass_depth)) {
-				err_msg = "parent bypassing";
-				ret = -EBUSY;
-				break;
+				scx_error(sch, "parent bypassing (%d)", -EBUSY);
+				return -EBUSY;
 			}
 
 			ret = rhashtable_lookup_insert_fast(&scx_sched_hash,
 					&sch->hash_node, scx_sched_hash_params);
 			if (ret) {
-				err_msg = "failed to insert into scx_sched_hash";
-				break;
+				scx_error(sch, "failed to insert into scx_sched_hash (%d)",
+					  ret);
+				return ret;
 			}
 
 			list_add_tail_rcu(&sch->sibling, &parent->children);
@@ -6004,9 +6003,8 @@ s32 scx_link_sched(struct scx_sched *sch)
 				rhashtable_remove_fast(&scx_sched_hash, &sch->hash_node,
 						       scx_sched_hash_params);
 				list_del_rcu(&sch->sibling);
-				err_msg = "parent disabled";
-				ret = -ENOENT;
-				break;
+				scx_error(sch, "parent disabled (%d)", -ENOENT);
+				return -ENOENT;
 			}
 
 			sch->linked = true;
@@ -6016,15 +6014,6 @@ s32 scx_link_sched(struct scx_sched *sch)
 		list_add_tail_rcu(&sch->all, &scx_sched_all);
 	}
 
-	/*
-	 * scx_error() takes scx_sched_lock via scx_claim_exit(), so it must run after
-	 * the guard above is released.
-	 */
-	if (ret) {
-		scx_error(sch, "%s (%d)", err_msg, ret);
-		return ret;
-	}
-
 	refresh_watchdog();
 	return 0;
 }
-- 
2.55.0

