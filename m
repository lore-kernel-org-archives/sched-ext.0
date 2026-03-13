Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F330433D6E3;
	Fri, 13 Mar 2026 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401477; cv=none; b=nxJDRHOE017bpZ1l95p6+bu4hT35nOHb6nmOSqjEzLjA4LIS+m2jyLEuXcKEGF2RUXzwlco2296qb1zR+fRGDPm8WhiC4MJoB4LRnNFN7OtMcYEUYwRORCGMQcHM+OSL6RQRhHJa+sEiDsUdffWDa/vAg1AtAiDTLUInEkD19kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401477; c=relaxed/simple;
	bh=4Czoi1FJR6dDWbxIi7bSh75meuYEjar71Nv9USmcoVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbRL7mi8PWOSEqUv8ow5QvWPaws+FbfDX73Sk+IGC2UJjkDwPyxWtph8fr1K9Zx1xYCapMSacAl3qUfF1gV5YnY7KuoVRnovEJiSTajZcnhSQDzo9Zpa/iGB94Uqge3JTloimWpuZ8VFXBLgFnvBQPQyCzCP23XaY7sRonVHEVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0RCuuid; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0RCuuid"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFD9C19424;
	Fri, 13 Mar 2026 11:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773401476;
	bh=4Czoi1FJR6dDWbxIi7bSh75meuYEjar71Nv9USmcoVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0RCuuidAFHIvYoy9tDa98e1d/PXkdA2ZCOkX59g4WoWyeJoIATJB2m884auPpbxp
	 6BA4QycGjgHg6b3yxyiiWVA6oM0xaaoafQTcSadtIy6iEw0iF9xCmBerZyXyn9TUSw
	 adwarQoVKOGdsDi7zimdy7amxP581paO5qiPMqYdHEBW8p9cMQAarUcWa35jSwccgX
	 d/cPn1oaRQF6wPxj6mJsBY1unzKhhbvqcFKGHx+wXCsovcANTiK0gIhLQvOR+6/721
	 w1mV5tJcTfqeDTTAiJ1wo3Qe07gLeLTDSckrVuWCse6SXZ4n5k3by6rfo5NrDCfZCf
	 9hFmQ4NdDrJCA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] sched_ext: Split task_should_reenq() into local and user variants
Date: Fri, 13 Mar 2026 01:31:09 -1000
Message-ID: <20260313113114.1591010-2-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313113114.1591010-1-tj@kernel.org>
References: <20260313113114.1591010-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split task_should_reenq() into local_task_should_reenq() and
user_task_should_reenq(). The local variant takes reenq_flags by pointer.

No functional change. This prepares for SCX_ENQ_IMMED which will add
IMMED-specific logic to the local variant.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e7ab3647e35f..774c012831e6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3725,13 +3725,10 @@ static void process_ddsp_deferred_locals(struct rq *rq)
 	}
 }
 
-static bool task_should_reenq(struct task_struct *p, u64 reenq_flags, u32 *reason)
+static bool local_task_should_reenq(struct task_struct *p, u64 *reenq_flags, u32 *reason)
 {
 	*reason = SCX_TASK_REENQ_KFUNC;
-
-	if (reenq_flags & SCX_REENQ_ANY)
-		return true;
-	return false;
+	return *reenq_flags & SCX_REENQ_ANY;
 }
 
 static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
@@ -3769,7 +3766,7 @@ static u32 reenq_local(struct scx_sched *sch, struct rq *rq, u64 reenq_flags)
 		if (!scx_is_descendant(task_sch, sch))
 			continue;
 
-		if (!task_should_reenq(p, reenq_flags, &reason))
+		if (!local_task_should_reenq(p, &reenq_flags, &reason))
 			continue;
 
 		dispatch_dequeue(rq, p);
@@ -3826,6 +3823,12 @@ static void process_deferred_reenq_locals(struct rq *rq)
 	}
 }
 
+static bool user_task_should_reenq(struct task_struct *p, u64 reenq_flags, u32 *reason)
+{
+	*reason = SCX_TASK_REENQ_KFUNC;
+	return reenq_flags & SCX_REENQ_ANY;
+}
+
 static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flags)
 {
 	struct rq *locked_rq = rq;
@@ -3846,7 +3849,7 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 		if (!p)
 			break;
 
-		if (!task_should_reenq(p, reenq_flags, &reason))
+		if (!user_task_should_reenq(p, reenq_flags, &reason))
 			continue;
 
 		task_rq = task_rq(p);
-- 
2.53.0

