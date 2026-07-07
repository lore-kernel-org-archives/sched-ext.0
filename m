Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97932D9EE4;
	Tue,  7 Jul 2026 00:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783383177; cv=none; b=SzeMJFNj/T88E63SbolX019OXvGwf5Kb3vaeZ8CKr2IZQjvtkzCq7NnGZ5lNeQ0ylAK68gh+7lniw/e5mQivuTVw5Hqsmuwbi35V8JxHEWvorgLEMPxU65Mxe5UVFYDGgu70Qp51OGzf5DgpQeGluCcc64y4wPnvLBzMX5Cdaa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783383177; c=relaxed/simple;
	bh=hnMpP70dqEPlDbpIPcjNRd3oQoEcT4EKwwDPWgUzsc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEeNYLr8V9IXGk8Nz4c0Vtt/2EEbk61zcgEi6cGDCQOHxMVKNOaMGGt1SsgWsksgKqe7DbDNBu8wlnnoa4D/3QTTgCMLEOQR6RrZjHPKNCpt7IkpJJmofmdv2Jez7An2KVduESIKiNOBXEX7t7zBQIrg/Gnu5OH+/yKzqW3mzvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izpup9rf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izpup9rf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958911F00A3A;
	Tue,  7 Jul 2026 00:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783383174;
	bh=FhAJxJ4xnflcp/pNswqLTzgL5ajQ2oOxTrjdIV2dGKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Izpup9rfUNDD8yaHokn5WzXE3ktwCpxZkCtVQvpQnYnXKktmIsIB3kehIZ4IwTZDr
	 wt6h4qofcVfDemMnLkBftO0z+5R3TH5OuLtvJJGbNig+AQ51N2opKP6bmcvxVRui/f
	 I4d1pYTgI2PK/aQWyCDntWTFMQQzlu9NEm1OglJUGVsheIGHFiXhSftyDLL5TTVwVk
	 HvX5j63CYcEGdLqSEVpDP7p2bt6blhzlKIYv9TpI04eDUHufXF560KDSnX/pOMdAZP
	 RG7qvTp5ysPPAq7UVPKBwjKIdl4DhUfhRYRPZL0rWo+ZOY929HTRdQstjlRnT6kw08
	 171NmMPjetVog==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 sched_ext/for-7.3 25/36] sched_ext: Add the SCX_CAP_ENQ_IMMED cap
Date: Mon,  6 Jul 2026 14:12:18 -1000
Message-ID: <20260707001229.1410929-26-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707001229.1410929-1-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the __SCX_CAP_DUMMY placeholder with SCX_CAP_ENQ_IMMED, which gates
inserting IMMED tasks onto a cid's local DSQ. An IMMED enqueue is guaranteed
to either get its task running on the cpu at once or hand it back to the
scheduler, so IMMED work can never pile up on the cpu's queue and a cpu can
be shared across sub-scheds through IMMED access without any of them
swamping it.

That makes ENQ_IMMED the natural baseline, the minimal cap to make any use
of a cpu. SCX_CAP_BASE aliases it so gates on basic cpu access can state the
intention instead of naming ENQ_IMMED.

Enforcement covers inserts and queued tasks. An insert without the cap is
diverted to the reject DSQ, and queued tasks are reenqueued when the cap is
lost. scx_bpf_sub_dispatch() skips a child that lacks the cap on the cpu, as
its inserts would only be rejected. Vacating the running task on cap loss
lands in a later patch.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      |  2 +-
 kernel/sched/ext/internal.h | 11 ++++++++---
 kernel/sched/ext/sub.c      |  8 ++++++++
 kernel/sched/ext/sub.h      |  4 ++--
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index d0966412ee42..d4e4340fdcd8 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4752,7 +4752,7 @@ SCX_ATTR(events);
 
 #ifdef CONFIG_EXT_SUB_SCHED
 static const char *scx_cap_names[__SCX_NR_CAPS] = {
-	[__SCX_CAP_DUMMY]	= "dummy",
+	[__SCX_CAP_ENQ_IMMED]	= "enq_immed",
 };
 
 static ssize_t scx_attr_caps_show(struct kobject *kobj,
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 7cc7e10457d7..5d4edd505ed1 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1270,17 +1270,22 @@ struct scx_sched_pnode {
  * topology-aligned and likely to serve as the locality unit when cids are
  * allocated to schedulers, so per-shard lock granularity scales naturally with
  * the allocation pattern.
+ *
+ * ENQ_IMMED  insert an IMMED task onto the cid's local DSQ
  */
 enum scx_cap_flags {
-	__SCX_CAP_DUMMY			= 0,
+	__SCX_CAP_ENQ_IMMED		= 0,
 
 	__SCX_NR_CAPS,
 	__SCX_CAP_ALL			= BIT_U64(__SCX_NR_CAPS) - 1,
 
-	SCX_CAP_DUMMY			= BIT_U64(__SCX_CAP_DUMMY),
+	SCX_CAP_ENQ_IMMED		= BIT_U64(__SCX_CAP_ENQ_IMMED),
+
+	/* alias for minimal cap to make any use of a cpu */
+	SCX_CAP_BASE			= SCX_CAP_ENQ_IMMED,
 
 	/* caps whose loss strands queued tasks, see scx_process_sync_ecaps() */
-	SCX_CAPS_REENQ_ON_LOSS		= 0,
+	SCX_CAPS_REENQ_ON_LOSS		= SCX_CAP_ENQ_IMMED,
 };
 
 #ifdef CONFIG_EXT_SUB_SCHED
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 23686c609336..778ae3f6f91f 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1270,6 +1270,14 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *
 		return false;
 	}
 
+	/*
+	 * Skip a child that does not effectively hold the base cap on this cpu:
+	 * its inserts would only be rejected. ecaps are synced at the top of
+	 * balance_one() before dispatch, so this reflects the in-effect state.
+	 */
+	if (scx_missing_caps(child, cpu_of(this_rq), SCX_CAP_BASE))
+		return false;
+
 	return scx_dispatch_sched(child, this_rq, this_rq->scx.sub_dispatch_prev,
 				  true);
 }
diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
index 51400e174cd0..f3548976800b 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -106,13 +106,13 @@ static inline u64 scx_missing_caps(struct scx_sched *sch, s32 cpu, u64 needed)
 /* map @enq_flags to the SCX_CAP_* bit required for the local-DSQ insert */
 static inline u64 scx_caps_for_enq(u64 enq_flags)
 {
-	return 0;
+	return SCX_CAP_ENQ_IMMED;
 }
 
 /* map queued @p to the SCX_CAP_* bit required to stay on its local DSQ */
 static inline u64 scx_caps_for_task(struct task_struct *p)
 {
-	return 0;
+	return SCX_CAP_ENQ_IMMED;
 }
 
 /* caps implied by holding @cap */
-- 
2.54.0

