Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11E223323;
	Sun, 18 Oct 2026 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792288795; cv=none; b=NubORwRG6hiaFeE0N0ucYn0zmI00j1bUJeKVzcgXo5uJlcnp8XN8tRDXWm+jcG6xdhVp78yIPva27uDleTUu5RYp09DwKHxAfcVJ14OMOKNqAcnAXT0bFtqH0jIQCFiTq7jGofHOJ9UDLMA+6KouZgiJ1pvNAaS02t7lZI43oG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792288795; c=relaxed/simple;
	bh=S8ZnW9b5wBDEvs0B3EbM0diMK7kmoSneeUzBiezaON8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt1+X6ke6Yc3fJhEYt7oaVsC1aXEcjqjK9uvqC0pW+qlzPZN95v3Z5tY9Eh8fZIiL57ssrk4fU2JlYmfMNPQyEHcARavnQkQAmuAZGszxamQNaIEenc7sc5vHkJcemXdIJ4iFWKD+YBrlW/LntRRtLGjQ1aR6jfsTK5gHMDS3xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7lnfIyX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7lnfIyX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AB81F000C5;
	Sun, 18 Oct 2026 01:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792288794;
	bh=2fPesr1PfJP7Wky5pNPj4awxPZ4MH4KIlkjzx82QrEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P7lnfIyXwV633MEtYcX/tuQymupZs/0dT6Dw1CqdoaPCeOjljhNBYDqqEy0tnUPLn
	 AJ+CSwDTPBMOCk4AeW05W+4aNuu+geTc6auYuia3qJvj35M7yWtbafo42SJpHKyNYS
	 lr8ww9xE0mOo6q4pSBtgVB7Bq4lyITj8nxj9rergQFgLTfg1wFWrTPUHRf81Fu0xl8
	 yxI/TEnzD9xym5+UeFN9i3RcDi+kTBa/XU1+5gYT+HmVJe46aa1RANEOMpb/vHW38c
	 A9GLN4XZUBmGLBoO/wkR0eDPXk5iHzK0SrPV+bgup3lnxuXZZ+ci7LuxqmXh5CzGx1
	 5BgctybaM6CIA==
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
Date: Sat, 17 Oct 2026 15:59:47 -1000
Message-ID: <20261018015952.1499528-2-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018015952.1499528-1-tj@kernel.org>
References: <20261018015952.1499528-1-tj@kernel.org>
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

