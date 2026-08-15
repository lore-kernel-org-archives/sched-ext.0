Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A8E2EEE9D;
	Sat, 15 Aug 2026 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786786973; cv=none; b=RyMACo2aEJimmg1sxYBSWEVyYwvl0z2ykICPaoXodVQXzk6JL5vOub5QrGNWXiIC1AaeeYYS36g6WP5C7rDbthVWHyWo8NXE9ZkrKLIOD6X5pWTmUKQom9pEHQELhqysSGazdqlbJ+/8pMxb4oIMioX9yaDmQ5vxvdlWiFo22ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786786973; c=relaxed/simple;
	bh=9yy3sj95Z97NhcelHOTx/nNKy5e+aQc7CnbS/XvBWKw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=lg4tYWpqMYg1+vX6ZL2+7L9kZ+SeT8q7embm+P+VCR7vZvO5rQyzXEWtRWCKeaINr7ugWq9yAZbbdHO8v7nvAiRfxGxgRWV3fe0gne2UJA/v72ss1E+2Iptg33QcCbDZaCDhOC8gSzoaHSQdIUQfboAjnt/tmUw89cTvQ1FOuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQO3T3fv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQO3T3fv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5B11F000E9;
	Sat, 15 Aug 2026 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786786972;
	bh=HAP2vv8ymX0zMD4XZbw3uBrK6ElVmgwDge2NNoiQCLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OQO3T3fva7k9dNj/KSOuOikTgI7dWPyMu43LQI5u4TFeLYb7UE6y9wld9RzpVPsq4
	 VPSw8Cxkn8eCEBUY6mcOlP0qzjhnQyLy1T5Bvt+d5uA5mkg37QLqRCwuUxC4vrSKk8
	 BFZwnnowl2VmffRmwcnsbacWRJH5f79vC/NajrwYgWphNRbuC5oUqa65UDWwfckxAF
	 etxtLqZKp46qWTy8Y+/urJh89S3BD9Lpw42CG3tIeLuYbn7eMJ5qiJsQf3jLlkc3cn
	 uKB48OW21cm9Tvp/o/QFqvYrCS4JNaV9ynd0/bkXKzWltElYDCyH0NPpO8oIKUWcaG
	 a299/Cj4ci8Jw==
Date: Fri, 14 Aug 2026 23:42:51 -1000
Message-ID: <d951ddf84a5978b1d213e914e102ebdc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 1/2] sched_ext: Drop unlocked scx_rq_clock_invalidate()
 from scx_root_disable()
In-Reply-To: <20260815055107.115671-2-tj@kernel.org>
References: <20260815055107.115671-1-tj@kernel.org>
 <20260815055107.115671-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

scx_root_disable() invalidates each rq's clock before taking the rq lock.
scx_rq_clock_invalidate() is a plain read-modify-write of rq->scx.flags and
every other writer of the word runs under the rq lock, so the unlocked
update can race a concurrent flags update and lose one side's bits.

The invalidation doesn't matter in the first place. The cached clock is read
only by scx_bpf_now() from a loaded scheduler's BPF programs, nothing can
re-validate the clock while sched_ext is disabled as scx_rq_clock_update()
is gated on scx_enabled() too, and the usual rq lock cycles under the next
scheduler refresh or invalidate it before it's practically observable. Drop
the invalidation instead of fixing the locking.

v2: Description and comment updated - the invalidation is unnecessary rather
    than subsumed by the rq lock cycle below.

Fixes: 3a9910b5904d ("sched_ext: Implement scx_bpf_now()")
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/ext/ext.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6367,12 +6367,9 @@ static void scx_root_disable(struct scx_
 	percpu_up_write(&scx_fork_rwsem);
 
 	/*
-	 * Invalidate all the rq clocks to prevent getting outdated
-	 * rq clocks from a previous scx scheduler.
-	 *
-	 * Also re-balance the dl_server bandwidth reservations: detach
-	 * ext_server (no more sched_ext tasks) and reinstate fair_server if it
-	 * was previously detached because we were running in full mode.
+	 * Re-balance the dl_server bandwidth reservations: detach ext_server
+	 * (no more sched_ext tasks) and reinstate fair_server if it was
+	 * previously detached because we were running in full mode.
 	 *
 	 * Unlike the enable path, this runs on a recovery path that cannot
 	 * fail, so we use dl_server_swap_bw() to atomically free ext_server's
@@ -6385,8 +6382,6 @@ static void scx_root_disable(struct scx_
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
 
-		scx_rq_clock_invalidate(rq);
-
 		scoped_guard(rq_lock_irqsave, rq) {
 			update_rq_clock(rq);
 			if (was_switched_all) {
