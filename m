Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EDF4014A2;
	Wed,  8 Jul 2026 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545903; cv=none; b=TQHlrl1xyEpZ5OXz+Z6CikTxfK28HO5bJyu96fXO+ZGEdNTsGMp6lxVPHmgnjqz098TQECNVTyz1J0a5kG26CeQpq0j+kBOyR0azqjB76cNE0MqAlMTP1hJ6BPzKDW2+X6C9Xp3qZ6u4uB1oQAvYn/9Z6zFTsROQpmBXN3w1ov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545903; c=relaxed/simple;
	bh=W2r2WGsVI6gTbJmUk88z6COXBcOEgSF/gHZ11W71t4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U47HxV6kS6a6Rlhvi/hWKw6Vswx5HSCRnZ31E2ckrWBX2e2g0Z4o6eiXg6asGERZ3y7F9r1VZuOHg413AhUrfR9l78eHc97Kt8zd0r2DryvSt9Cu/pbvhfYF9tEF8t9QbLHmiBNubi3VPeX0QrzfLy/oBhzKsLAGxMMYPkVnjJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AW671d2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AW671d2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5A11F00A3A;
	Wed,  8 Jul 2026 21:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545901;
	bh=D+4I7SlnNIDtKTDzvvF79zpAFr9BeX0/otVXLLt6N4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AW671d2uLJj/NzdAP89kTnOMIKLzERiBigz5yozdh3BA13F020gT3Ygb2YDkRMaZG
	 ARMNi5hKCeFUDe37A7khVFtvZMjPPu6HE9wRgUlo7gLiT9DnK9Z/eU8qb/qTDpsESl
	 P5nLAnXvOlckrbN0LaSwb3p4/xjaNtvRCR/yXFltpBUnkJr94JNF6r+EeMrcupZZvc
	 Yza3wC298jTGr0Gip+yQz4gDEHC4Ljc3OTNk1UD7Jlqix70U35/0TbNpEBWxYLEEoK
	 HZ1Eh2+WZJtZxy4cgSHs84cbfxH8KK9ESqivGFLDCsd2AbGDva2TDc9dVWLcrWbcuv
	 PscmzugyB3MXQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 sched_ext/for-7.3 28/40] sched_ext: Assign a unique id to each scheduler instance
Date: Wed,  8 Jul 2026 11:24:17 -1000
Message-ID: <20260708212429.3405787-29-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708212429.3405787-1-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Neither a scx_sched pointer nor its cgroup id uniquely identifies a
scheduler instance. A freed sched's memory can be reallocated, and a cgroup
can detach one sched and attach another. Add a monotonic, never-reused u64
id. A later patch compares it to drop a slice request that outlived a change
of a task's owning scheduler.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c      | 4 ++++
 kernel/sched/ext/internal.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 977f2149f3ed..96e5e4a6a695 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -108,6 +108,9 @@ static bool dsq_is_rq_owned(struct scx_dispatch_q *dsq)
 	}
 }
 
+/* Cursor for unique scx_sched instance ids. id 0 is reserved. */
+static atomic64_t scx_sched_id_cursor = ATOMIC64_INIT(0);
+
 #ifdef CONFIG_EXT_SUB_SCHED
 /*
  * The sub sched being enabled. Used by scx_disable_and_exit_task() to exit
@@ -6460,6 +6463,7 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		       level * sizeof(parent->ancestors[0]));
 	sch->ancestors[level] = sch;
 	sch->level = level;
+	sch->id = atomic64_inc_return(&scx_sched_id_cursor);
 
 	if (ops->timeout_ms)
 		sch->watchdog_timeout = msecs_to_jiffies(ops->timeout_ms);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 6d33001b68f5..7842cade8d7d 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1445,6 +1445,9 @@ struct scx_sched {
 
 	struct list_head	all;
 
+	/* unique instance id, monotonic and never reused */
+	u64			id;
+
 #ifdef CONFIG_EXT_SUB_SCHED
 	struct rhash_head	hash_node;
 
-- 
2.54.0

