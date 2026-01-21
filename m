Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE744DB8F;
	Wed, 21 Jan 2026 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037103; cv=none; b=GRJRQcMKkZVg5wTj4o05bPFKke48brHfI0I7SYcwtHYVjQ7MJPvzjQDPeRWxVPFtjrlsKVBlNzfTBsO6ERSi1wgrsIR+7DDORk9RrPehAYOrWAzIm5PwFHSemG2qhsx5v7TjgBhRelqO4kBMFuy3+l9+Ium1TYty8xy6PvyZunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037103; c=relaxed/simple;
	bh=Dg0sPFatznabNkMGPkfmrNWALrj8cGATh2+dgreyUM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TP+eKzXFTG9oN8dn+Hnz5MC4dTEdLPDwEBbvU7YRmPe+NA9794z8ssVg6G7F1k0Hg7dGbdn0tvusxzAgbZK3hUh06ilgjiRtg+b5CjWno6kSeX9R0GiZ+XCSRENBnyVVVt/Y+zVjS2g/htMBps9s0r48LPbdSKbw8R3pPNiZlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+ttDRrd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+ttDRrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370DCC4CEF1;
	Wed, 21 Jan 2026 23:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769037103;
	bh=Dg0sPFatznabNkMGPkfmrNWALrj8cGATh2+dgreyUM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+ttDRrd6AjNkxlVtlUxyw7uGwe0yZMvnFEc7+H5I3OHi8U59dHyCSDqmNnRkyAfm
	 8G+m/U7LegnUI56vNvArUBbDirQg3gf7BIbkXlJCsVPRSCmEQShi4xkc9/A2uvIvB8
	 0Hd8iNcqJIIOcEu9irSP9jNFl2vLHB4lwyraTz5eABUSXtfA+8eqogh7x8iAjthHWr
	 11F4Qs2ycuvnPH2SzDYrZ7/FoETKcfne4ERTJl/ljC+6MTSV9PkMOqypJVJDCnPrRg
	 o4GCnaiI9fGiFXmUiFnYZHWYyPNIZZYUwG3KgPH5WHSEpmDuq9Po6QyRCFgL2wiFUN
	 wp4jaHZ39coog==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	andrea.righi@linux.dev,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 02/34] sched_ext: Add @kargs to scx_fork()
Date: Wed, 21 Jan 2026 13:11:08 -1000
Message-ID: <20260121231140.832332-3-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121231140.832332-1-tj@kernel.org>
References: <20260121231140.832332-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sched_cgroup_fork() pass @kargs to scx_fork(). This will be used to
determine @p's cgroup for cgroup sub-sched support.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c | 2 +-
 kernel/sched/ext.c  | 2 +-
 kernel/sched/ext.h  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 60afadb6eede..9d73b5b84272 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4696,7 +4696,7 @@ int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 		p->sched_class->task_fork(p);
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 
-	return scx_fork(p);
+	return scx_fork(p, kargs);
 }
 
 void sched_cancel_fork(struct task_struct *p)
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ba2a72752e13..213f421b00e5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3033,7 +3033,7 @@ void scx_pre_fork(struct task_struct *p)
 	percpu_down_read(&scx_fork_rwsem);
 }
 
-int scx_fork(struct task_struct *p)
+int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
 	percpu_rwsem_assert_held(&scx_fork_rwsem);
 
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 43429b33e52c..0b7fc46aee08 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -11,7 +11,7 @@
 void scx_tick(struct rq *rq);
 void init_scx_entity(struct sched_ext_entity *scx);
 void scx_pre_fork(struct task_struct *p);
-int scx_fork(struct task_struct *p);
+int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs);
 void scx_post_fork(struct task_struct *p);
 void scx_cancel_fork(struct task_struct *p);
 bool scx_can_stop_tick(struct rq *rq);
@@ -44,7 +44,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 
 static inline void scx_tick(struct rq *rq) {}
 static inline void scx_pre_fork(struct task_struct *p) {}
-static inline int scx_fork(struct task_struct *p) { return 0; }
+static inline int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs) { return 0; }
 static inline void scx_post_fork(struct task_struct *p) {}
 static inline void scx_cancel_fork(struct task_struct *p) {}
 static inline u32 scx_cpuperf_target(s32 cpu) { return 0; }
-- 
2.52.0

