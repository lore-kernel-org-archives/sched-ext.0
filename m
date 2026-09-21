Received: from mta0.migadu.com (out-135.mta0.migadu.com [91.218.175.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936D350128C
	for <sched-ext@lists.linux.dev>; Mon, 21 Sep 2026 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017194; cv=none; b=Vjv1zczCfYAXrNKQs96b9ix89WqRFyufEdVmky1loarOnQFl2/h24EQQkUpMt1MJM/h1XIxj+KfKmgykAc4oKhTeC6Ap/i3NFZ+gW1k/4nTx1fwMG8/DTxqY+wn6nqmiL7agI/Z8Lm6Gx/42DDMhYJcHrruBohhrnI92bqzT77o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017194; c=relaxed/simple;
	bh=Pofm77rzod73Bt78uY4E3DD44RNhgOcg2uywXtDlWwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bT+yk+XpC+3cO1e3JO7eSvtw3r5GdzOVza/RZnoKdx3WYvjITU7h+gfEWyzQv9YHsmycHG42Wm+IXguct54KB0rVoR24HbqIKChIPD1tNctHb0tLj2xTnRa0DMYX43hrf9iCGWqz8/rgf/piyt+OjVo7D53L3Pf2n1m6WxwTm30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nb8aaqsY; arc=none smtp.client-ip=91.218.175.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nb8aaqsY"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Pofm77rzod73Bt78uY4E3DD44RNhgOcg2uywXtDlWwI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790017190; v=1; x=1790621990;
 b=Nb8aaqsYC7gc15nF4KAHNxgQHBbHU0FUWw4HuzyQZ5+r4AokV7j4ul92QCgBPz1TsCVuqPnS
 JYaW8UbwnacPJRaPcPTYwlUf6s4BXIMJhOGE9UFJwCeky/tiP2Q36ZetzIvpTwAyk8yO5sEd3Gh
 FZFKJQGCJfUa5ngHkfwMysZ0=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id 3e8edb1392227131;
	Mon, 21 Sep 2026 18:59:50 +0000
X-Mizu-Trace-ID: 3e8edb1392227131
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: arighi@nvidia.com,
	bpf@vger.kernel.org,
	bsegall@google.com,
	changwoo@igalia.com,
	dietmar.eggemann@arm.com,
	etsal@meta.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	vincent.guittot@linaro.org,
	void@manifault.com,
	vschneid@redhat.com,
	yphbchou0911@gmail.com
Cc: Usama Arif <usama.arif@linux.dev>
Subject: [PATCH 1/2] sched_ext: Specialize the TID hashtable compare
Date: Mon, 21 Sep 2026 11:59:11 -0700
Message-ID: <20260921185943.4031480-2-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921185943.4031480-1-usama.arif@linux.dev>
References: <20260921185943.4031480-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_tid_hash_params does not provide an object comparison function, so
rhashtable falls back to rhashtable_compare(). Although the key is one
naturally aligned u64, the generic comparison reads the key offset and
length from the table parameters at runtime and emits an out-of-line
memcmp() for each element walked.

scx_bpf_tid_to_task() can sit on hot scheduling paths. Supply an
obj_cmpfn so the const parameters passed into the inlined rhashtable
lookup specialize the comparison to a single equality test against
scx->tid.

The result is only tested against zero, so the ordering provided by
memcmp() is not observable. No functional change intended.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/sched/ext/ext.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 646affba4e3c4..288d6b80bbca0 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -52,10 +52,21 @@ struct rhashtable scx_sched_hash;
 #endif
 
 /* see SCX_OPS_TID_TO_TASK */
+static __always_inline int scx_tid_cmpfn(struct rhashtable_compare_arg *arg,
+					 const void *ptr)
+{
+	const struct sched_ext_entity *scx = ptr;
+
+	BUILD_BUG_ON(sizeof_field(struct sched_ext_entity, tid) != sizeof(u64));
+
+	return scx->tid != *(const u64 *)arg->key;
+}
+
 static const struct rhashtable_params scx_tid_hash_params = {
 	.key_len		= sizeof_field(struct sched_ext_entity, tid),
 	.key_offset		= offsetof(struct sched_ext_entity, tid),
 	.head_offset		= offsetof(struct sched_ext_entity, tid_hash_node),
+	.obj_cmpfn		= scx_tid_cmpfn,
 	.insecure_elasticity	= true,	/* inserted/removed under scx_tasks_lock */
 };
 static struct rhashtable scx_tid_hash;
-- 
2.53.0-Meta

