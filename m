Received: from mta0.migadu.com (out-141.mta0.migadu.com [91.218.175.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7332C4FDA57
	for <sched-ext@lists.linux.dev>; Mon, 21 Sep 2026 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017196; cv=none; b=jFzPnO5jR2vqtSyNCKdsd6CkO5D1uWRVzW0zsZ5ZSCzmrHQkaIx/aSmvDxPGueYTTR0fQCaG1baQZydvIwAjnRnSx1GHaWI4M2/lxAj/FKSgu/aTRoHsFCdpLEPngETyzV+0e2UOgmyCEt6hVMYqRNE5tsp2tZn3UD5lZy/Qxi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017196; c=relaxed/simple;
	bh=owL6q3Fk9/55Zw1NYDaaYKrFvFrDV8FYtck2SkEVXUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSN2dlnW+bnaP28ONeRn9VGG5rix6cnbKRK/Q28Eo4gT1nxh0TB24XTvPFEM97onai3YgH7RwOQFlzeO4+1x6l53AuanMZWBQNfrJ9yf8lrqWs+hlstyYJFX1++b2iG8RZ9lMoOfc3hePbUc0iEXzB1l8oSUIM41bSNB6HuGOck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vGRQM2Gx; arc=none smtp.client-ip=91.218.175.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vGRQM2Gx"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=owL6q3Fk9/55Zw1NYDaaYKrFvFrDV8FYtck2SkEVXUk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790017192; v=1; x=1790621992;
 b=vGRQM2GxPtn9yhfYeP2kSB6orQZ641hGUiBhFnYhqS5p7qdGdFaDtTV8j6WKOLHq+0+Q5Y8A
 xh056bi544xXDJunL9Qe989UPO9HzxXb+6K4EcKZsDwnOdDNjlwCbsFRv3ql1Bx7HoJXlaRJlX6
 Uq3pEZcHOENlusOytBwcE8cY=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id c7c189aa1dad7a7d;
	Mon, 21 Sep 2026 18:59:52 +0000
X-Mizu-Trace-ID: c7c189aa1dad7a7d
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
Subject: [PATCH 2/2] sched_ext: Specialize the scheduler hashtable compare
Date: Mon, 21 Sep 2026 11:59:12 -0700
Message-ID: <20260921185943.4031480-3-usama.arif@linux.dev>
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

scx_sched_hash_params does not provide an object comparison function,
so rhashtable falls back to rhashtable_compare(). Although the
sub-cgroup ID key is one naturally aligned u64, the generic comparison
reads the key offset and length from the table parameters at runtime and
emits an out-of-line memcmp() for each element walked.

Supply an obj_cmpfn so lookups specialize to a single equality test
against ops.sub_cgroup_id. ext.c and sub.c are included in the same
build_policy.c translation unit, so the compiler can fold the const
callback into scx_find_sub_sched() even though its source is in sub.c.

The result is only tested against zero, so the ordering provided by
memcmp() is not observable. No functional change intended.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/sched/ext/ext.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 288d6b80bbca0..87fa09c71eb0f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -41,10 +41,21 @@ struct scx_sched __rcu *scx_root;
 LIST_HEAD(scx_sched_all);
 
 #ifdef CONFIG_EXT_SUB_SCHED
+static __always_inline int scx_sched_cmpfn(struct rhashtable_compare_arg *arg,
+					   const void *ptr)
+{
+	const struct scx_sched *sch = ptr;
+
+	BUILD_BUG_ON(sizeof_field(struct scx_sched, ops.sub_cgroup_id) != sizeof(u64));
+
+	return sch->ops.sub_cgroup_id != *(const u64 *)arg->key;
+}
+
 const struct rhashtable_params scx_sched_hash_params = {
 	.key_len		= sizeof_field(struct scx_sched, ops.sub_cgroup_id),
 	.key_offset		= offsetof(struct scx_sched, ops.sub_cgroup_id),
 	.head_offset		= offsetof(struct scx_sched, hash_node),
+	.obj_cmpfn		= scx_sched_cmpfn,
 	.insecure_elasticity	= true,	/* inserted under scx_sched_lock */
 };
 
-- 
2.53.0-Meta

