Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B222FDE6;
	Sat,  5 Sep 2026 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788648826; cv=none; b=A7cOcZlgrBdYimRtj1fR0tC1Ja3bsD6bixD+gN184xLVQ3wuVtyLxRKDajtMbuzUf0JjdNoXAgjuW5MX36YodAhGdAISAFKwQkJjBC99wOLvQYEcDATO5Ajvtzh6ks/EXSK+erHWTcRXLlm848h840DzHXNJWl1ZI2HjaCRvdv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788648826; c=relaxed/simple;
	bh=gH73bEaYqVrvxvYAb5eFpbQH7QrRREuafFnVWCTjdVY=;
	h=Date:Message-ID:From:To:Cc:Subject; b=pEzNgpxl84sPI2CEblTKrrb/qF3Hia61IUeFa7DUBx22TlzyAft6gCnSyCHMjsKgnti4Yhw9ycj/WFn06j6PPHDTSj7KQrCc+S3eJdOih8vT0nQceLAmunuJGnZjIxprMXrSUFuW10yBmvkJW0qtfFCCQapWjLvdmYpB68jlpC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2F1dn9z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2F1dn9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2D51F00A3A;
	Sat,  5 Sep 2026 22:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788648825;
	bh=gd/IeUVK+DxhoLibjj2psEVNSWp1h3uwLEGqfbUdezQ=;
	h=Date:From:To:Cc:Subject;
	b=E2F1dn9zvqZlmO3ph88UOFlUg21VxC/p7nw8OU97VB8oekwmlGRU+bWVQIUUR26Lz
	 PgDngssyt9Q9pJcpe03FvAWrwzXJIrVacrsX7SvUuS76thuG0TFGpWN9NHSjiz4FYY
	 if1JfYUkhWqL2px2wEYFCNBmhJsdyAu3QxYGPri4TlEEWSluIPvfaDHefKgo55n75u
	 MWGzU+PAXkjEOsOYwtpV7QfVVmypU+303KrU+OisJNvAN8nbf4cYyPDWJygiJIZztd
	 5tmW4NKv9Zt6YLso/ZmGCTp0dhWXDhZQhY+sLIdH2nPJxHFlSNmGGmqOMWmDw41dsp
	 3dNYBcs8W26ZA==
Date: Sat, 05 Sep 2026 12:53:44 -1000
Message-ID: <4c9a9c9cabc3547e23bae5ae00421a52@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.3-fixes] sched_ext: scx_qmap: Fix pending
 partition work handoff
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

qmap can leave partition work pending with no runner. The effective-cap
callback publishes its request after failing to acquire part_busy, while
redistribute() checks for pending work before releasing it. Either ordering
can miss a request arriving as the current runner finishes, delaying the
update until the round-robin timer runs.

Publish requests before trying to become the runner and release part_busy
before checking for more work. Have all holders drain pending requests after
releasing it, including the stats flush. Distinguish mask refreshes from
repartitions so an effective-cap update only rebuilds the partition when a
repartition was also requested.

Fixes: e9151ed5c944 ("tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling")
Reported-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.bpf.c |   75 +++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -1295,11 +1295,16 @@ struct {
 	__type(value, struct round_robin_timer);
 } round_robin_timer SEC(".maps");
 
+enum part_pending_flags {
+	PART_REFRESH = BIT_U64(0),
+	PART_REDISTRIBUTE = BIT_U64(1),
+};
+
 /*
  * Partition update synchronization. qa.part can be written from concurrent
  * contexts. This single-runner guard admits one writer at a time without
  * holding a lock across the grant/revoke kfuncs. part_pending coalesces
- * repartition requests that arrive while it is held.
+ * refresh and repartition requests that arrive while it is held.
  *
  * They live in .bss, not the arena: rr_advance() runs from a bpf_timer
  * callback, where the verifier rejects atomic ops on arena memory.
@@ -1668,33 +1673,46 @@ __noinline void apply_partition(void)
 	}
 }
 
-/*
- * Recompute the split off the node's held caps and apply it. The contexts this
- * runs from (the sub-sched and cgroup callbacks, the rr timer) are not
- * serialized by the kernel, so a single runner does the work. A caller that
- * finds the guard held leaves part_pending set; the holder drains it before
- * releasing, with the rr timer as a backstop.
+/**
+ * execute_partition - Run pending partition updates
+ *
+ * The rr timer is the backstop if the loop reaches its iteration limit.
  */
-static void redistribute(void)
+static void execute_partition(void)
 {
+	u64 pending;
 	s32 i;
 
-	__sync_fetch_and_or(&part_pending, 1);
+	bpf_for(i, 0, 1024) {
+		if (!part_try_start())
+			break;
 
-	if (!part_try_start())
-		return;
+		pending = __sync_fetch_and_and(&part_pending, 0);
+		if (pending & PART_REDISTRIBUTE) {
+			/* charge elapsed time before repartitioning */
+			account_alloc();
+			compute_partition();
+			apply_partition();
+		} else if (pending & PART_REFRESH) {
+			refresh_usable();
+		}
 
-	bpf_for(i, 0, 1024) {
-		__sync_fetch_and_and(&part_pending, 0);
-		/* charge elapsed time to the current partition before rebuilding it */
-		account_alloc();
-		compute_partition();
-		apply_partition();
+		/*
+		 * Requests are published before trying the guard. Releasing it
+		 * before checking pending work ensures a racing request is
+		 * either observed here or handled by a caller that acquires the
+		 * guard.
+		 */
+		part_end();
 		if (!__sync_fetch_and_or(&part_pending, 0))
 			break;
 	}
+}
 
-	part_end();
+static void redistribute(void)
+{
+	__sync_fetch_and_or(&part_pending, PART_REDISTRIBUTE);
+	execute_partition();
 }
 
 /*
@@ -1708,6 +1726,7 @@ int flush_alloc(void *ctx)
 	if (part_try_start()) {
 		account_alloc();
 		part_end();
+		execute_partition();
 	}
 	return 0;
 }
@@ -1765,9 +1784,7 @@ static void rr_advance(void)
 
 	part_end();
 
-	/* a resplit queued while we held the guard supersedes this rotation */
-	if (__sync_fetch_and_or(&part_pending, 0))
-		redistribute();
+	execute_partition();
 }
 
 /* advance the time-shared cid pool every round_robin_ns */
@@ -2041,20 +2058,8 @@ void BPF_STRUCT_OPS(qmap_sub_ecaps_updat
 		cmask_clear(cid, &qa.avail_cids.mask);
 	}
 
-	/*
-	 * When another runner holds the partition guard, set part_pending:
-	 * redistribute() drains it before releasing and rr_advance() checks it
-	 * after, so the deferred refresh lands by the next rr tick. A
-	 * repartition that lost the guard to us runs here.
-	 */
-	if (part_try_start()) {
-		refresh_usable();
-		part_end();
-		if (__sync_fetch_and_or(&part_pending, 0))
-			redistribute();
-	} else {
-		__sync_fetch_and_or(&part_pending, 1);
-	}
+	__sync_fetch_and_or(&part_pending, PART_REFRESH);
+	execute_partition();
 }
 
 SCX_OPS_CID_DEFINE(qmap_ops,
