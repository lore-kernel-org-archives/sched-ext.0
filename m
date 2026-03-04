Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE57B1C68F;
	Wed,  4 Mar 2026 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661683; cv=none; b=FuxnDyjBHC7qI8htZkBKbzxQUbcHOmKpOZbdqcSt8ELuvitz9aKxxtzhv+q/JQyumjFO1HOzmsMIjvH/HR6MITc2YPSrr3SiPmFtiFg8kVYGxPFE5CnW+3EPJtwBeAL84yg3xh/FYAl7rvyvgxvwVsJe67++o2eryWSd84xlKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661683; c=relaxed/simple;
	bh=TwAFQbDdK/uGRb9tNtr2C1NA9/tXwgL0dbvA30rSqNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDKPbRCEdzN52uEMs/dFwg1EjFHOP2A8pXkpj1bF3aoF+UVbB+NeJCr0frWVjtA3Xy2p+i2wdliktaUQphN97I+c+s0TwKzfCvY8cnP0hmQfDaAhjeWQiES47PFOEUkAsLJbzp2FnjIUgokY7vBA/ubVzIyy/8tVg3BxZ3sikPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUXfPCaP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUXfPCaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64455C4CEF7;
	Wed,  4 Mar 2026 22:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661682;
	bh=TwAFQbDdK/uGRb9tNtr2C1NA9/tXwgL0dbvA30rSqNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUXfPCaPujVwHwimtRCR6zU2oZXaAPjglhs3A1j4FLnSIvzAGYzgctS0OiwfSmLRz
	 GbgEUAJQ/+rWT2mYXmeMV5DgJKtkBxYphuo1Dth/51YOWibUgLd0DNpPQDghwPHiH9
	 CNDMxDBRRZK9IcoE7zlhR5w0RUmyxg8bbwm8jUXzok103dZe5RUxT4kSriR5JRRDnw
	 LzXT61SC6FIXbE+Rf/zDD8WGndlZJXq8M56OtB9nspLSTWwsEJa8Z143ZjwsOSBtRL
	 BkGUismZCAVhWYEKSHlmdjABe2EfIWX5/+dbNJM+nHSD8/omwazlBn4eANUwzfly8q
	 KOnT0xeCifo4Q==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	Tejun Heo <tj@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 02/34] sched_ext: Add @kargs to scx_fork()
Date: Wed,  4 Mar 2026 12:00:47 -1000
Message-ID: <20260304220119.4095551-3-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304220119.4095551-1-tj@kernel.org>
References: <20260304220119.4095551-1-tj@kernel.org>
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
index b7f77c165a6e..dfe680e78be3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4721,7 +4721,7 @@ int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 		p->sched_class->task_fork(p);
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 
-	return scx_fork(p);
+	return scx_fork(p, kargs);
 }
 
 void sched_cancel_fork(struct task_struct *p)
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0bd86540472d..7e6abe7303a2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3171,7 +3171,7 @@ void scx_pre_fork(struct task_struct *p)
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
2.53.0

