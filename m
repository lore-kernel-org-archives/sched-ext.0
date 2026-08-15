Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B02730C37C;
	Sat, 15 Aug 2026 05:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786773070; cv=none; b=AUOqHks+sKlkzUrKYITb/W+tY/N8y7NiX71LdfzoMyrVz8uc/89Uionax+aSXyBqIFCDs2Ohd1+X34R8DiGJ4Icw3WxU1Z5HXXCMcOdACa6xmA5SjU7JwwZMFG0YB/WhRv3+igqszLs8VWUKB15ZPjVXorU1uYVYJNy6CzBsvbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786773070; c=relaxed/simple;
	bh=PzI0sWwZJr1kCVk3VHJREkqc0fMIqoCRXNbgZx/Xesg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrZaAHWLDlpmvtAL0oHRv2dql9GMW4YWWpekEXsv4X2c8WTqhLC+pELJH/t3q9P/fqPMdk5G7TbaWLiPCZjBmG1Ej3vbTydCaHyfXVzk457HobnYyP7Ib9JpVwO6naZL5TzRB1kot7e8yAeBt2ftZ7mNMeDIhdx9iyp2Uw8f3SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIM5gz9+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIM5gz9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EFF1F00A3D;
	Sat, 15 Aug 2026 05:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786773069;
	bh=OL44huM6R4qJPURPJTyh6/xTPmhLLXjPCHL+qLf8Jfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fIM5gz9+t+Jjy0Hcp1+xl7MZpWfubQWxM0st46c3+pBFM4EimGRaGKU5EyU3zGHWO
	 5JK9Q/acrbFw6gyLcOGlc0ToLnLWjLVm3KvBFbHAMm/ZDD+UeNtttD7qLfoy9TadPB
	 W0gDFFNQmLfCv3A/tHGgudCSS4m+OVGvfKTH0TVB/f9RrbpN0RhoOlTxZLIW7zgsJk
	 73u5e3qP59vVScTL9eXhFiEfGm3aGC8WhC/K4MBfW0d4TW/avTbxGhjsbRxDBaK6+4
	 HR5E7h2veR5R+6baalw41hzvTT8IX3sXwYHPcJkWOmLvY24oZP9/rRrhYZqmBKg3cU
	 2HqwUI81Oihsg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] sched_ext: Drop unlocked scx_rq_clock_invalidate() from scx_root_disable()
Date: Fri, 14 Aug 2026 19:51:06 -1000
Message-ID: <20260815055107.115671-2-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815055107.115671-1-tj@kernel.org>
References: <20260815055107.115671-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_root_disable() invalidates each rq's clock before taking the rq lock.
scx_rq_clock_invalidate() is a plain read-modify-write of rq->scx.flags and
every other writer of the word runs under the rq lock, so the unlocked
update can race a concurrent flags update and lose one side's bits.

The invalidation is also redundant. The dl_server rebalancing right below
cycles each rq's lock and rq_unpin_lock() clears SCX_RQ_CLK_VALID on every
unlock, while __scx_enabled is turned off only later in the function, so the
clocks end up invalidated either way. Drop the call and note the
invalidation in the comment.

Fixes: 3a9910b5904d ("sched_ext: Implement scx_bpf_now()")
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/ext/ext.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 2adf2bde0cb1..d301fe757193 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6476,12 +6476,13 @@ static void scx_root_disable(struct scx_sched *sch)
 	percpu_up_write(&scx_fork_rwsem);
 
 	/*
-	 * Invalidate all the rq clocks to prevent getting outdated
-	 * rq clocks from a previous scx scheduler.
+	 * Re-balance the dl_server bandwidth reservations: detach ext_server
+	 * (no more sched_ext tasks) and reinstate fair_server if it was
+	 * previously detached because we were running in full mode.
 	 *
-	 * Also re-balance the dl_server bandwidth reservations: detach
-	 * ext_server (no more sched_ext tasks) and reinstate fair_server if it
-	 * was previously detached because we were running in full mode.
+	 * The rq lock cycle also invalidates each rq's clock (rq_unpin_lock()
+	 * clears SCX_RQ_CLK_VALID on unlock), preventing the next enable from
+	 * seeing outdated rq clocks from this scheduler.
 	 *
 	 * Unlike the enable path, this runs on a recovery path that cannot
 	 * fail, so we use dl_server_swap_bw() to atomically free ext_server's
@@ -6494,8 +6495,6 @@ static void scx_root_disable(struct scx_sched *sch)
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
 
-		scx_rq_clock_invalidate(rq);
-
 		scoped_guard(rq_lock_irqsave, rq) {
 			update_rq_clock(rq);
 			if (was_switched_all) {
-- 
2.55.0

