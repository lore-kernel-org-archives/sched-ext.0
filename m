Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBBC361DA2;
	Fri, 10 Apr 2026 06:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802657; cv=none; b=QcomvKlWJnRZRwj7JAeGRSOqessb+7mFy/KxXcAH7957ibh6HKUqfzZAD6KZnNAs7zcOyn+UqXmL66XbyBAudAlNXf4GhibHQYA2s+cNXrErFlouYJLExbBb0RMIasoM3QFJ/2oys7DLQT/XoWdIiV4oOXGOOCNQNkz8AXSvYYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802657; c=relaxed/simple;
	bh=B0m1T6n2cheKJGJc+QE8uyo6+mrBbNMIfyRTS93RT6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NT5S4crk6UQjw8zp4hUQzZ9peqh6dMfZiv+68fXY6XtCAUh74ArZ8GbHMGkVFyjbZobvhXiLr3QOqzgq8XpzpapBbIkU3I5DsV+rQHZDWGKuR1jIZCQkylCn/J6IsFmnDDyG22BtGmmSGatDhVCuI0/MBD2gcsaW/1qLIYEx8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Myoam9dk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Myoam9dk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEFAC19424;
	Fri, 10 Apr 2026 06:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775802657;
	bh=B0m1T6n2cheKJGJc+QE8uyo6+mrBbNMIfyRTS93RT6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Myoam9dkDPhISmXjZ0yhAKLqsw5HzW9AEKdVaCl7iqgzedt+6NSVdFgwolUPg/Nod
	 4fz7UZg8mRNvSGm3AQUsM9sU3cl8FGpf/exLokALX0ELuM4/cagvs11DwPlpdMxFu3
	 UnuTlcFByFjUFTOszhE5PpCdJYZoA/GXcr9hfOEeh6o8HDMJKFSuTGtnIo9UsVy44l
	 lWgAEIK0/RM5kYn7aaI/kTAOL59XUYg7r391QYRWuusAbygXQAsQl0SI4YTQeut8Nq
	 WjDK62wzG8MLTrdoqdP4VdzhLEZYuHyUQQfzedtvuyas60YhT1OPAUU8cX2oZCa/AO
	 aMlCiECs0VkDg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/10] sched_ext: Rename scx_kf_allowed_on_arg_tasks() to scx_kf_arg_task_ok()
Date: Thu,  9 Apr 2026 20:30:45 -1000
Message-ID: <20260410063046.3556100-10-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410063046.3556100-1-tj@kernel.org>
References: <20260410063046.3556100-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "kf_allowed" framing on this helper comes from the old runtime
scx_kf_allowed() gate, which has been removed. Rename it to describe what it
actually does in the new model.

Pure rename, no functional change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 70e9434a9a0d..27091ae075a3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -494,7 +494,7 @@ do {										\
  * SCX_CALL_OP_TASK*() invokes an SCX op that takes one or two task arguments
  * and records them in current->scx.kf_tasks[] for the duration of the call. A
  * kfunc invoked from inside such an op can then use
- * scx_kf_allowed_on_arg_tasks() to verify that its task argument is one of
+ * scx_kf_arg_task_ok() to verify that its task argument is one of
  * those subject tasks.
  *
  * Every SCX_CALL_OP_TASK*() call site invokes its op with @p's rq lock held -
@@ -532,7 +532,7 @@ do {										\
 })
 
 /* see SCX_CALL_OP_TASK() */
-static __always_inline bool scx_kf_allowed_on_arg_tasks(struct scx_sched *sch,
+static __always_inline bool scx_kf_arg_task_ok(struct scx_sched *sch,
 							struct task_struct *p)
 {
 	if (unlikely((p != current->scx.kf_tasks[0] &&
@@ -9424,7 +9424,7 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
 	if (unlikely(!sch))
 		goto out;
 
-	if (!scx_kf_allowed_on_arg_tasks(sch, p))
+	if (!scx_kf_arg_task_ok(sch, p))
 		goto out;
 
 	cgrp = tg_cgrp(tg);
-- 
2.53.0

