Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5F3B19BF;
	Sat, 17 Oct 2026 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255559; cv=none; b=JXVR3ePibNUPu9xGASjescz3WJN6CbN/RPEHUWKz+dF/NIQM7UHCL3XZDnxDwnfHkuGDXwQo2CXGE1cwz2//KXjYTv/JCSFd1IQxymVAk2iJg4U5X6XPckKDHYMbdqEOtFZ4Cn7SnUL/QRODMb1dI2mfw86YsxmvETjGC3iaMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255559; c=relaxed/simple;
	bh=S8ZnW9b5wBDEvs0B3EbM0diMK7kmoSneeUzBiezaON8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQYFEIbwrd8ytSQyNqQ3NnOH2nsp5cPZw2EkmhPchjtEke9gX7i3QHMm4iC0b2AHgbHkxH0SccjE5J7IEuN70d9DNnHYz1IWCa9TJry5I5cgVNIWD5qJ6y2WX2ipQphyunNWYsQO79nSA1sxQEslOgUdyjPdGew42FTkT3T5xgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhJ3zq8V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhJ3zq8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399131F000C7;
	Sat, 17 Oct 2026 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792255558;
	bh=2fPesr1PfJP7Wky5pNPj4awxPZ4MH4KIlkjzx82QrEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZhJ3zq8VJkgY6AA+mnJK7SPlLywnfaZSXD/8iOPjZcDAkg6fUDf4vjiQOmY9CJt8z
	 uqdTG/Vbf1mLzRyUd6EtLYATdg6EUa/zUDJwsSQeFMZ9JyStcaFmLiALsJoRrkGaNZ
	 mIGksnsjdnepPBnQ+EuMEHJcGrCnKC1yCHBEzOo0Paykapal+9Mts/9SCRhaWRklFl
	 BWANl8Z0Cfbab7b7I6ms+0VGqHMVh7Wr+mEJTkFl5103T6/8p/dOcfJWa2FMJII/bq
	 7cVbM5K9NmtPQHskG3u/y9c4WdhnOBCuZCxDnb6MIeZiiPzE2Sfz/LPq6KnWUuj5H7
	 GpW0CR5J/PadA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] sched_ext: Factor out cid_pshard()
Date: Sat, 17 Oct 2026 06:45:51 -1000
Message-ID: <20261017164556.4136807-2-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017164556.4136807-1-tj@kernel.org>
References: <20261017164556.4136807-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor the cid to pshard lookup out of the ecaps sync paths into
cid_pshard() so that new sync paths can share it. No functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/sub.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 1345e4174775..7edad2ddaa54 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1063,6 +1063,12 @@ static void discard_queued_syncs(struct rq *rq)
 		init_llist_node(pos);
 }
 
+/* the pshard holding @sch's caps on @cid */
+static struct scx_pshard *cid_pshard(struct scx_sched *sch, s32 cid)
+{
+	return sch->pshard[rcu_dereference_all(scx_cid_to_shard)[cid]];
+}
+
 /**
  * __scx_process_sync_ecaps - Sync this cpu's ecaps to pshard->caps[]
  * @rq: the cid's cpu rq
@@ -1079,7 +1085,7 @@ static void discard_queued_syncs(struct rq *rq)
 void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 {
 	s32 cpu = cpu_of(rq);
-	s32 cid, shard;
+	s32 cid;
 	struct llist_node *batch, *pos, *tmp;
 	u64 lost_all = 0;
 
@@ -1101,13 +1107,12 @@ void __scx_process_sync_ecaps(struct rq *rq, struct task_struct *prev)
 
 	/* @cid is valid here: the cpu is active with queued syncs */
 	cid = __scx_cpu_to_cid(cpu);
-	shard = rcu_dereference_all(scx_cid_to_shard)[cid];
 
 	batch = llist_del_all(&rq->scx.ecaps_to_sync);
 	llist_for_each_safe(pos, tmp, batch) {
 		struct scx_sched_pcpu *pcpu =
 			container_of(pos, struct scx_sched_pcpu, ecaps_to_sync_node);
-		struct scx_pshard *ps = pcpu->sch->pshard[shard];
+		struct scx_pshard *ps = cid_pshard(pcpu->sch, cid);
 		u64 old, ecaps, lost, gained;
 
 		init_llist_node(pos);
@@ -1229,7 +1234,7 @@ void scx_unbypass_replay_ecaps(struct rq *rq, struct scx_sched *sch)
 void scx_online_ecaps(struct rq *rq)
 {
 	struct scx_sched *root, *pos;
-	s32 cid, shard;
+	s32 cid;
 
 	/*
 	 * Only a live hierarchy can have ecaps to reseed. This also keeps the
@@ -1244,7 +1249,6 @@ void scx_online_ecaps(struct rq *rq)
 
 	root = scx_root_protected();
 	cid = __scx_cpu_to_cid(cpu_of(rq));
-	shard = rcu_dereference_all(scx_cid_to_shard)[cid];
 
 	scx_for_each_descendant_pre(pos, root) {
 		struct scx_pshard *ps;
@@ -1253,7 +1257,7 @@ void scx_online_ecaps(struct rq *rq)
 		if (!pos->level)
 			continue;
 
-		ps = pos->pshard[shard];
+		ps = cid_pshard(pos, cid);
 		guard(raw_spinlock)(&ps->lock);
 		queue_sync_ecaps(pos, cid);
 	}
-- 
2.56.0

