Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB451386557;
	Fri,  3 Jul 2026 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065744; cv=none; b=qlWFpalGMKXdh8m/mKX10saTNLcbK4CV5sXJTnvY1/ZMmO5cBJ4699klYDbr97kBojNRo/jbyuwEqt+Jvvtc5UmZTLn24AYsH9l96qaQOZ1tiSlB8gmE87nXnO8maTmcT0UNNuPj1qW44gASUw9vkd5beB3eQUXCXxxb0thjMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065744; c=relaxed/simple;
	bh=lKRPha6orYk+B4NDN3rjJhogqeZHdXj6syLKPKx5ez4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SblbKzr2uU/S6JKwv/zFfqYFu791pASFuJN89shljCpaiRiHgLru0dn4K1ywTRExbcfG/S0pi2Ks8b3mEEImcenPu+6yLpjUJinbnhEPsEfNqsFFVigjOZIuXxcctaeFeH2yj39beoN1NayPtnbN2TXuo1ojgfZjixYHca4etmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/gheE++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/gheE++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EEB1F000E9;
	Fri,  3 Jul 2026 08:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065742;
	bh=PCvohsBwgzLQ6uon5Nly29FoM7HcT5EsNjAN6gctvnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B/gheE++CsGcA3i2twkKgJTdWyppOC/L7+IF0TKiWPfJvFhQ6F1X1fX/1HTY5a04c
	 n82mz0sM+3MqcGjovb6KRMh1XtYX2E35pxPmp+QKIJUea0AcReVTkpHF5MvlA7gILX
	 bnjfy3PTE4tjk1mEIUfTZS3g41qCXePePHwP8WgU2LvhbyBLu3bVhZ/yoyDQlWmqkZ
	 hL3x1i8A2B+ta/c+GgKohicblkYbqem3vrBlfFSDuB/JDk1dOHoQJLlwYF9YPia+4+
	 Yk0lyxv6y4gTdVfWgXT39akZZ1+Qo/hnTFjb7+7EHEBdufjh5jGS5khtMgvYzmYiUE
	 dpS403S8OADXA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.3 22/32] sched_ext: Add the SCX_CAP_ENQ_IMMED cap
Date: Thu,  2 Jul 2026 22:01:49 -1000
Message-ID: <20260703080159.2314350-23-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703080159.2314350-1-tj@kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org>
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
index b6d68a80a04f..9309d57e3f4f 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4757,7 +4757,7 @@ SCX_ATTR(events);
 
 #ifdef CONFIG_EXT_SUB_SCHED
 static const char *scx_cap_names[__SCX_NR_CAPS] = {
-	[__SCX_CAP_DUMMY]	= "dummy",
+	[__SCX_CAP_ENQ_IMMED]	= "enq_immed",
 };
 
 static ssize_t scx_attr_caps_show(struct kobject *kobj,
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index ef6b4d0f7dee..20a1ffbe4c26 100644
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
index aea63484edc5..2f1e19db8e72 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1230,6 +1230,14 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *
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
index 89d1458ff450..ea8bea347bb0 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -105,13 +105,13 @@ static inline u64 scx_missing_caps(struct scx_sched *sch, s32 cpu, u64 needed)
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

