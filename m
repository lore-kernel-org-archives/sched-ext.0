Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3CB54704E;
	Tue,  6 Oct 2026 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318710; cv=none; b=IJe2TyyXnNVnW+gCpDItA4g+4ROk1I5nrHhQy01nyUh1o0fuUymr1/JmwJ3ivpOzNe0fh5e+gkXzl/5ClFaR+OchZBMXypmQjrqoTru5OhLbwQJ0B9jvWzJIXQZTOpGH8ne9PjJ/g2CtMUC3w3fNs2bMtH/84v25F9TjUwKpVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318710; c=relaxed/simple;
	bh=V7Gv65uoAqZTLkhYcmhQZ9YShvFoJTw47Jc6+LasNaQ=;
	h=Date:Message-ID:From:To:Cc:Subject; b=SwcRwePG1aDnXIgX765L7HNE3YRhbPa9zpjgOBQl8e5Ktx4lg443P6fQ2ulZ3S9jwkJIo8MJiH+MsYOa25M5fVUR0e148KPRDIMpMJT0vYB5SsmTnMSSteJirCCQTU5gXliR1HIZSs95H4a7wqHu9wcacwWS3O4pAikW27bXybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onGyJ2RJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onGyJ2RJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3321F0089B;
	Tue,  6 Oct 2026 20:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791318709;
	bh=HFXGCdHbtxUXg0/haVzs1NEis4YkT/UvMWDCoyn8U9E=;
	h=Date:From:To:Cc:Subject;
	b=onGyJ2RJ/8b2AbuRZwM3uqMTS8Dg02KonjaUgEExdclqOnWknZacurui4TTIi2jFc
	 +oy1uKUhl73DWhSauCrGTkA3ToQlJgPcGuKYi1ar8MDzvGDRkERSIbPudX6ar/ZQSr
	 8lP8CfeVV4v4jRaj1SNMuo87oWqEsSsMZnwQaL78Rohz9yfKRq46s70if9hiasGADb
	 IlOCX4Ge/mcrbL3mTh1ba+X6uZh7I1Q/PMAAo6wSAWmVt7PWvxtGF5m+BB4CRoj2fw
	 ptn624T82H5MUJTMRToNFiQdS8QFkwUxZoag6ypAFQ2MQrTj4Vfzsx+C/PWd/N/noA
	 xpJT9sIcomwVw==
Date: Tue, 06 Oct 2026 10:31:48 -1000
Message-ID: <b46300eda6da03d56262fcdcbfc9b4fa@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
	Tao Cui <cui.tao@linux.dev>
Subject: [PATCH sched_ext/for-7.4] sched_ext: Clear a sub-scheduler's caps
 before ops.sub_detach()
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

A sub-scheduler can leave standing state behind on the cids delegated to it,
cpuperf targets being the obvious case, and the kernel does not track who
wrote it. Restoring it is the parent's job and ops.sub_detach() is the place
for it. Today the parent can't rely on that: the dying sub-scheduler keeps
every cap until it is marked dead after ops.exit(), so its ops.exit() or a
late timer can write after the parent has cleaned up.

Clear every cap of the sub-scheduler before ops.sub_detach(). The pshard
caps go first as a pending sync recomputes ecaps from them, and ecaps are
then zeroed directly. A grant racing the clear is refused under the child's
pshard lock, so nothing hands the caps back.

Fixes: 86094b95efcf ("sched_ext: Add per-shard cap delegation for sub-schedulers")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applied to sched_ext/for-7.4.

 kernel/sched/ext/internal.h |    7 ++++++
 kernel/sched/ext/sub.c      |   49 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 4 deletions(-)

--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -828,6 +828,10 @@ struct sched_ext_ops {
 	/**
 	 * @sub_detach: Detach a sub-scheduler
 	 * @args: argument container, see the struct definition
+	 *
+	 * The sub-scheduler holds no caps by this point and can no longer
+	 * affect any cid. Whatever was delegated to it, e.g. cpuperf targets,
+	 * is the parent's to restore here.
 	 */
 	void (*sub_detach)(struct scx_sub_detach_args *args);
 
@@ -911,6 +915,9 @@ struct sched_ext_ops {
 	 * ops.exit() is also called on ops.init() failure, which is a bit
 	 * unusual. This is to allow rich reporting through @info on how
 	 * ops.init() failed.
+	 *
+	 * A sub-scheduler holds no caps by the time ops.exit() runs. Its
+	 * cap-gated kfuncs are denied.
 	 */
 	void (*exit)(struct scx_exit_info *info);
 
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1154,6 +1154,34 @@ void scx_offline_ecaps(struct rq *rq)
 }
 
 /*
+ * Clear every cap @sch holds. The pshard caps go first as they are the source a
+ * pending sync recomputes ecaps from. ecaps are then zeroed directly for the
+ * cap checks.
+ */
+static void clear_all_caps(struct scx_sched *sch)
+{
+	s32 si, cpu;
+	u32 cap_bit;
+
+	/* enable may have failed before scx_alloc_pshards() */
+	if (!sch->pshard)
+		return;
+
+	for (si = 0; si < sch->nr_pshards; si++) {
+		struct scx_pshard *ps = sch->pshard[si];
+
+		guard(raw_spinlock_irqsave)(&ps->lock);
+		for (cap_bit = 0; cap_bit < __SCX_NR_CAPS; cap_bit++)
+			scx_cmask_clear(&ps->caps[cap_bit].cmask);
+	}
+
+	for_each_possible_cpu(cpu) {
+		guard(rq_lock_irqsave)(cpu_rq(cpu));
+		WRITE_ONCE(per_cpu_ptr(sch->pcpu, cpu)->ecaps, 0);
+	}
+}
+
+/*
  * @pcpu's sched was unhashed before the grace period, so nothing re-queues its
  * sync node. Remove the node from @rq's pending list so the pcpu can be freed.
  */
@@ -1628,6 +1656,12 @@ dump:
 
 	scx_unlink_sched(sch);
 
+	/*
+	 * The parent restores what it delegated in ops.sub_detach(). @sch must
+	 * hold no caps by then.
+	 */
+	clear_all_caps(sch);
+
 	mutex_unlock(&scx_enable_mutex);
 
 	/*
@@ -2306,8 +2340,8 @@ static s32 sub_cap_preamble(u64 cgroup_i
  * All-or-nothing keeps the caller-visible result binary per cid, so the denied
  * mask is one mask to interpret rather than a per-cap matrix.
  *
- * Return 0 on full success, -EPERM if any cid was refused, or a negative
- * errno on other failures.
+ * Return 0 on full success, -EPERM if any cid was refused, -ENODEV if the child
+ * is gone or being disabled, or a negative errno on other failures.
  */
 __bpf_kfunc s32 scx_bpf_sub_grant(u64 cgroup_id, u64 caps,
 				  const struct scx_cmask *cmask__arena,
@@ -2361,6 +2395,12 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cg
 		scoped_guard (raw_spinlock, &pps->lock) {
 			guard(raw_spinlock_nested)(&cps->lock);
 
+			/* the child is being disabled, see clear_all_caps() */
+			if (unlikely(READ_ONCE(child->aborting))) {
+				ret = -ENODEV;
+				goto out;
+			}
+
 			/*
 			 * Narrow granted_cids to cids the parent holds every
 			 * requested cap on. All-or-nothing per cid.
@@ -2413,9 +2453,10 @@ __bpf_kfunc s32 scx_bpf_sub_grant(u64 cg
 		}
 	}
 
+	ret = any_denied ? -EPERM : 0;
+out:
 	caps_updated_deliver(&to_deliver);
-
-	return any_denied ? -EPERM : 0;
+	return ret;
 }
 
 /**
