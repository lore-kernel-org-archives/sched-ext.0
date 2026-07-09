Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364B3E6388;
	Thu,  9 Jul 2026 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637468; cv=none; b=q7ORUYTyCOEZNpKQXRpNxGKsiWahhjIZ5RUjyu8Riksk1byXDF2+Y4mYy7cZ3AOFi/CYRt6TxlK9tqASD7ug8sC4Gdz/fbMVGOP1tKtc2x7bDzxzB8NXuWosbNmKFh6zpz+yNQin1fTIGAVvmfZXIZic0Ls2W5ITbr3Q+eVxzCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637468; c=relaxed/simple;
	bh=0XlOks45V4BnYKA4XChh+CtBzIx3rJATmxcuLCvmTBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diYOF9MlJwip5tooPZPUv0gAMHujsL8ngia766XpiS5Zj6qFasDhzCDXx0GRzGX3DZxgjY0UMG3/IpIryhWEP6h29SeiKC0PKkMZmgMYdU9wmtlRvl6Mrs43vk1/TcGjwgNpGeY/hrzWemJqUGDtyuzbc5SSTTKxaCxqjdPbOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6zdiPo4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6zdiPo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9807A1F00A3A;
	Thu,  9 Jul 2026 22:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637464;
	bh=RMCi9tud+WL0oRxxgsOd8myAJ/siZDQzj5hMiGVomus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I6zdiPo4yLdhK83GTvuIrD4W19weuSohiC6QD/+azxDop9cqce56FV63Lmn14t/fV
	 EHvpeg7YQUOm1yZ9EiqYQ/mSbVSFysJPTD6mb9yLh/DcFAPwXpCHqfseFtUH9XBrgJ
	 No18EWi+dlUfhYFtbOq9GzSu3ruRBsY+obPM6qCslQEab3HvJjeTgwmxwu6vEnFui5
	 rBoSsPuxFzws6BcPMuaU5Zxz+CVq37oc7L2iPtGiTV/zhzenI6IwzsKoRvwfMduW70
	 YOXK2D5pD42/0hDGrYuc/T0tNGw6LxERkBNJ7LtdLIfP+sIHNtnlmxIClDc0UbL0CB
	 Ws4PodAoqtd5g==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 sched_ext/for-7.3 20/33] sched_ext: Add the SCX_CAP_ENQ_IMMED cap
Date: Thu,  9 Jul 2026 12:50:28 -1000
Message-ID: <20260709225041.1695495-21-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709225041.1695495-1-tj@kernel.org>
References: <20260709225041.1695495-1-tj@kernel.org>
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
index 80c8971638f9..54ba5b57f283 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4792,7 +4792,7 @@ SCX_ATTR(events);
 
 #ifdef CONFIG_EXT_SUB_SCHED
 static const char *scx_cap_names[__SCX_NR_CAPS] = {
-	[__SCX_CAP_DUMMY]	= "dummy",
+	[__SCX_CAP_ENQ_IMMED]	= "enq_immed",
 };
 
 static ssize_t scx_attr_caps_show(struct kobject *kobj,
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 079ee941b343..e735812e77a5 100644
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
index bbd068bfd86c..11fda1d3828d 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1279,6 +1279,14 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *
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
index a1a2825dc04e..8abc4a262f28 100644
--- a/kernel/sched/ext/sub.h
+++ b/kernel/sched/ext/sub.h
@@ -109,13 +109,13 @@ static inline u64 scx_caps_for_enq(u64 enq_flags)
 	/* a restored task must be put into the local DSQ regardless of caps */
 	if (enq_flags & SCX_ENQ_IGNORE_CAPS)
 		return 0;
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
2.55.0

