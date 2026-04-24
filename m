Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F33FE660;
	Fri, 24 Apr 2026 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063465; cv=none; b=LS+vXJJfTDFMq0nJ4ObdM8MYNDNzNRNWtj+3tomX2feo33jgcuYDnO3sAHWiou02F4ArHF60VzWJe0Y5OBAcQz4VkaFSHe+FIIeGQ2PWI9yA7UAMr1u90VEfs8bO9J9DUQxFDsKmU6KAlpMKiHbWtMZI8vG7ca3WbHVDr73qYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063465; c=relaxed/simple;
	bh=KJ4CKn2MyyiRwxId/cMnVNO22IZ0MhoY7pvjuAPS3Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HP3PF7QyeNylwPTWDDh8OLvc2dHCb9CSbpb5Mgwztj2B2GgjjTnt5BsmTa/E6dGOl+oUq2zKSvRR34T0Q7ugB5jIxY1H5+7ZsuKTzWArhISuWmJpazLEEfCBj0sTRlSKiaE4xbzgAto7rH2tpYsfbN9ZW8jm1Xe05t1/61Aunsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLtdM9Q7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLtdM9Q7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023E5C19425;
	Fri, 24 Apr 2026 20:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063465;
	bh=KJ4CKn2MyyiRwxId/cMnVNO22IZ0MhoY7pvjuAPS3Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HLtdM9Q7uTQgfsKIU4IeCtWi55qEZVmWK3xIH1UDSQSP+0+OKps3j59Xn6B1fGspX
	 Y7ynuH8G5dphI1XsKKubxUfy6lRMrIPIjJkDp+U/2Y8KyJ8jDzKBEVypHQSvRKkQ9y
	 OboxrWfuO5mS5g5knL0vxQf8ynb/hzD5eVBDxiI1P7iycrQPUKr+sstjdJ9ADhDrZM
	 2ccsVqlvpomgnMLYJXEm1ogXpvVxLV7jC2Va2fb/Dg2HiKDGsB+c6Go9HP9caI3gn/
	 wJkLgKeTs7zPd11eySOomPzcgZsEZXLxSoLqU7+mgMvSd04sidntuYj59roH3cPQcM
	 QwFc7szIwE+Qw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 05/13] sched_ext: Read scx_root under scx_cgroup_ops_rwsem in cgroup setters
Date: Fri, 24 Apr 2026 10:44:10 -1000
Message-ID: <20260424204418.3809733-6-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424204418.3809733-1-tj@kernel.org>
References: <20260424204418.3809733-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_group_set_{weight,idle,bandwidth}() cache scx_root before acquiring
scx_cgroup_ops_rwsem, so the pointer can be stale by the time the op runs.
If the loaded scheduler is disabled and freed (via RCU work) and another is
enabled between the naked load and the rwsem acquire, the reader sees
scx_cgroup_enabled=true (the new scheduler's) but dereferences the freed one
- UAF on SCX_HAS_OP(sch, ...) / SCX_CALL_OP(sch, ...).

scx_cgroup_enabled is toggled only under scx_cgroup_ops_rwsem write
(scx_cgroup_{init,exit}), so reading scx_root inside the rwsem read section
correlates @sch with the enabled snapshot.

Fixes: a5bd6ba30b33 ("sched_ext: Use cgroup_lock/unlock() to synchronize against cgroup operations")
Cc: stable@vger.kernel.org # v6.18+
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f7cca6f07a58..59445e95d2f2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4343,9 +4343,10 @@ void scx_cgroup_cancel_attach(struct cgroup_taskset *tset)
 
 void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 
 	percpu_down_read(&scx_cgroup_ops_rwsem);
+	sch = scx_root;
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_weight) &&
 	    tg->scx.weight != weight)
@@ -4358,9 +4359,10 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 
 void scx_group_set_idle(struct task_group *tg, bool idle)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 
 	percpu_down_read(&scx_cgroup_ops_rwsem);
+	sch = scx_root;
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_idle))
 		SCX_CALL_OP(sch, cgroup_set_idle, NULL, tg_cgrp(tg), idle);
@@ -4374,9 +4376,10 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
 void scx_group_set_bandwidth(struct task_group *tg,
 			     u64 period_us, u64 quota_us, u64 burst_us)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch;
 
 	percpu_down_read(&scx_cgroup_ops_rwsem);
+	sch = scx_root;
 
 	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_bandwidth) &&
 	    (tg->scx.bw_period_us != period_us ||
-- 
2.53.0

