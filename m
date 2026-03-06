Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC881421A10;
	Fri,  6 Mar 2026 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823987; cv=none; b=i72cosWKZay5Pkf06qXCYKKYgdui3ElB6G2TN6YtGMT8uYZhVcgTOQJQb1bN96j2lj751OYf+ZE7fxnh8STtmV6ZNJ//FOJOENEPmvIVBwua+6Tl7PXYR5p/HGo39z+jhD6jAW9bkKXftru2P22qy+Z5BZxCcNP+FmyKPK4zcqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823987; c=relaxed/simple;
	bh=6TnyFirkOesEQ8Nbpy8yR4CrpapX+9/ceE1KbOPQ1gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4+gIO1FTOg+mWN+QpmOxWQmvR8L6Y5uxHAeiWt077B9ObmvhAR63M7PAwmb79R13qlZ+kwBITLRLs6vjCqVCAJgdyHUFeh9sjhPrYTPqG2kn0EOrAdBDQb0n9DHvVSCk2unshbcGUVVoCcMCE0S2NQhDYGMMUIQzJukXmo8LLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyTfnYk7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyTfnYk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77887C4CEF7;
	Fri,  6 Mar 2026 19:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772823987;
	bh=6TnyFirkOesEQ8Nbpy8yR4CrpapX+9/ceE1KbOPQ1gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MyTfnYk7gIilmaIkG2xU1O5lsM3f0HOQpPEYpp/SD1CIL6VMWPwVIaN9Xa7u2lKNU
	 +/HIOT+UT9VDn9M48tfzigGbllMfWTfWqS97MRKoH0ORvrxvSSW4VgHmCiA4/cK5Km
	 XIyb4E1Yf6GbfS1CAdN+T6relsC2PWmUK/I0tkxhfKMfLRp/6CRgl4+DN7gB/jYmWk
	 n+qP7cjvoCIq00rTXJUYT5naeIzh5JG/qYwuHkXsdMR7f0Y6GRUTNIYkfK4BVevZZF
	 zrY7Wq1tWX2aC3CfT9dFeyZapjpMQwE1E4aLo0nEEtOsLVU8Fozhi4Ih3wI7H2thZZ
	 ZYPoe6Pvv3oBA==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/15] sched_ext: Factor out pnode allocation and deallocation into helpers
Date: Fri,  6 Mar 2026 09:06:11 -1000
Message-ID: <20260306190623.1076074-4-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306190623.1076074-1-tj@kernel.org>
References: <20260306190623.1076074-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract pnode allocation and deallocation logic into alloc_pnode() and
free_pnode() helpers. This simplifies scx_alloc_and_add_sched() and prepares
for adding more per-node initialization and cleanup in subsequent patches.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9232abea4f22..c36d399bca3e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4114,6 +4114,7 @@ static const struct attribute_group scx_global_attr_group = {
 	.attrs = scx_global_attrs,
 };
 
+static void free_pnode(struct scx_sched_pnode *pnode);
 static void free_exit_info(struct scx_exit_info *ei);
 
 static void scx_sched_free_rcu_work(struct work_struct *work)
@@ -4148,7 +4149,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	free_percpu(sch->pcpu);
 
 	for_each_node_state(node, N_POSSIBLE)
-		kfree(sch->pnode[node]);
+		free_pnode(sch->pnode[node]);
 	kfree(sch->pnode);
 
 	rhashtable_walk_enter(&sch->dsq_hash, &rht_iter);
@@ -5685,6 +5686,24 @@ static int alloc_kick_syncs(void)
 	return 0;
 }
 
+static void free_pnode(struct scx_sched_pnode *pnode)
+{
+	kfree(pnode);
+}
+
+static struct scx_sched_pnode *alloc_pnode(struct scx_sched *sch, int node)
+{
+	struct scx_sched_pnode *pnode;
+
+	pnode = kzalloc_node(sizeof(*pnode), GFP_KERNEL, node);
+	if (!pnode)
+		return NULL;
+
+	init_dsq(&pnode->global_dsq, SCX_DSQ_GLOBAL, sch);
+
+	return pnode;
+}
+
 static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 						 struct cgroup *cgrp,
 						 struct scx_sched *parent)
@@ -5714,16 +5733,11 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	}
 
 	for_each_node_state(node, N_POSSIBLE) {
-		struct scx_sched_pnode *pnode;
-
-		pnode = kzalloc_node(sizeof(*pnode), GFP_KERNEL, node);
-		if (!pnode) {
+		sch->pnode[node] = alloc_pnode(sch, node);
+		if (!sch->pnode[node]) {
 			ret = -ENOMEM;
 			goto err_free_pnode;
 		}
-
-		init_dsq(&pnode->global_dsq, SCX_DSQ_GLOBAL, sch);
-		sch->pnode[node] = pnode;
 	}
 
 	sch->dsp_max_batch = ops->dispatch_max_batch ?: SCX_DSP_DFL_MAX_BATCH;
@@ -5821,7 +5835,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	free_percpu(sch->pcpu);
 err_free_pnode:
 	for_each_node_state(node, N_POSSIBLE)
-		kfree(sch->pnode[node]);
+		free_pnode(sch->pnode[node]);
 	kfree(sch->pnode);
 err_free_hash:
 	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
-- 
2.53.0

