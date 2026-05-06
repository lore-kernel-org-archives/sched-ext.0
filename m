Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25C2E9757
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 05:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778046008; cv=none; b=cYu+I796/a0uxQB4Gk3XEon0rSjymQhBn3UkSRwL6AAbezk9h/hdjYB7Y9H+tvwjaGlY9Ez9BfSS55G9JQ1eYxw9e0IpgbAJY2Aje8vqaxmPHvJNAKaleBWs8B6ZtHz0vDkkgP0RGTwXDnznqnmH7Ym0n0K4AoOC1hobzoHBvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778046008; c=relaxed/simple;
	bh=0oxnFNHfER71Cwu+YeeIpMGm295Jj197SCHbqAMmPxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCDq8OgRsaFvoDEBZqI1Iq3mXdL83ZBGSltp7gaGYamgGkAHraTfwjoI+joPzXi6M7NlSlrQWmg5xk8F9SwZjwHlfu12r+NLh+YdLN+LeuLLuMw6gfR2ojwb+9NJ0ixBxY5B7jOTTRBVLSDYdRHv/2RcGWbSQLy8OWC+kJ3n7ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlA9L1mK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlA9L1mK"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so4338744b3a.1
        for <sched-ext@lists.linux.dev>; Tue, 05 May 2026 22:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778046007; x=1778650807; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BH/zOpdVMe548X4mjycpdIqPmJXYXW7FrfDBJMM87/o=;
        b=FlA9L1mKPqE9exlwtI4j84KwOY4H7aRRCC7iUYdFs4OjG69O67zqlkZvhT07gWZya6
         5ytNFZGZ29iSw6qvE41WuMppswvP0imDOef5xhUFHD2GT2O8Fr3+59BTTVAEyjsjj8EU
         8x+IZFiZ/LYxpsWLS2y0nhlEObsS5pRkl0wwpeGVje2xklJQqCusatI+C+1EFZbTw7c4
         khAeE8unh6V9wXNWdjHoK5gPIcEldaYw4nIjbju+18NdConiMAxD9pHb676aAfcCddl/
         7cy5mOAWVo3WAflnu7kn7GBknA/RVAaljYm6s7Jo5V3Asl12DovKLe7HCDl5rf/2mXA3
         hwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778046007; x=1778650807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BH/zOpdVMe548X4mjycpdIqPmJXYXW7FrfDBJMM87/o=;
        b=ckduy71vyqslGzN4jodysU4OYbBl4OkvNJxv7QMDjyeLP/wmWl/yshnHrgVmLIr4HI
         VjpMBNzspMx5XMknczWYXMpPLkf+U8IDHbVaanuHS0C6fBxMl9f8MsGf7ZSgGjN48ics
         +WZXkxguW29eBXQTLOoywg6g3BfDNsyn+0QKQkx5WsmsALBmNTJMXjsCXdBu4Ixbzzu2
         V3qi2KNxplCx2FyGf7qq2mbRU8zshISgjLH/bfh1i2v2JrsgdeUv8A5AkNBe6OHOvED4
         ObHzAiSyDknDfmoLQGV3vp/Q+LMMV5U24p4sc7bG4q3PUE2n7Tqthkh4zqg5GN4tYYBe
         YZIw==
X-Forwarded-Encrypted: i=1; AFNElJ+fBckdqk1gJ4KU0ruAJlcC2bYGaSF8EKqGLOHtZlHvUFkKXMETyA3ntjyMLsjUkMPOPH4U+VNDHPY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyizm0XIiBimu+M6y0PucL0q3OE95v9ltCsaCH1UbDDUCDU0bWH
	7WWF8qWh+M1ioaUFtaCeqYy7AqD2nFgQr4UUgIU7kvPR1eiHYwB6LMVD
X-Gm-Gg: AeBDieuAxzkFhkgYx7HSqfs85ZX8K+KMbJpOnf7e3kBBztbi0VymubmauNUJjh8VDah
	Vzm/l/zQXUvgHgIsuI0TCdWQSv+4Z6kwjHBYDmvZzFISMl/p5nYenZuuqYOIjdHjtKWPXOBaECc
	7Y2JbuTMgOpGEKsgaSPLxG6EyYnEkkD1ZO5lmX0vQS1ii69/7xDdUw7jbyVgzYeePaatRiGjrpz
	8ReMBKcXrzZ1nTE8bwr+d5SEk4K04PI7fgTKQE6WNNhkGP0Z0doed9s4MSzCBhIXkbGvKapihiM
	RgY5KCkrgneDkOD3Ahhj625doSdFFfpIixbZfImZtvPrKFfDdSLm9JUx5ozUcPxnkv5lhovRRwk
	1uS4YhSPV2H3g4cs5aoWkbcLMtiMwdLQS1ZGZ+Ec6xLf7yzQmKzykvd5bKO975mFw4GTO/Yl8B9
	yvXO4oQwt8AwhXUAmFFO92FpmOt/PolSqqQ5kR/A1EWnb+9NSjmkQ137ZDk7AV5Hv4dLTVFV78k
	qC9nIvDL/AFsp8rPSmXxNHV
X-Received: by 2002:a05:6a00:844:b0:838:127d:a161 with SMTP id d2e1a72fcca58-83a5c4c5817mr1876113b3a.18.1778046006523;
        Tue, 05 May 2026 22:40:06 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8462sm4080514b3a.38.2026.05.05.22.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 22:40:06 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched_ext: Fix sched_ext_dead() race with scx_root_enable_workfn()
Date: Wed,  6 May 2026 13:40:01 +0800
Message-ID: <20260506054001.1105522-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429133155.3825247-1-suzhidao@xiaomi.com>
References: <20260429133155.3825247-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In CONFIG_EXT_SUB_SCHED, scx_task_sched(p) returns p->scx.sched instead
of scx_root.  scx_root_enable_workfn() iterates all tasks and for each
releases scx_tasks_lock via scx_task_iter_unlock() before calling
scx_init_task().  A concurrent sched_ext_dead() can race in this window.

Two bugs:

1. NULL deref: If sched_ext_dead() runs after scx_init_task() sets
   state=INIT but before the callsite sets p->scx.sched, the invariant
   "state != NONE => p->scx.sched != NULL" is broken.  sched_ext_dead()
   calls scx_disable_and_exit_task(scx_task_sched(p)=NULL, p), which
   crashes in SCX_HAS_OP(NULL, ...).

2. Resource leak: If sched_ext_dead() runs before scx_init_task() when
   state=NONE, it skips scx_disable_and_exit_task() (state check
   fails).  scx_init_task() then calls ops.init_task() and sets
   state=INIT.  The enable loop never calls ops.exit_task(), leaking
   whatever ops.init_task() allocated.

Fix both:

- Move scx_set_task_sched(p, sch) into scx_init_task(), before the
  state transition off NONE.  This restores the invariant so
  sched_ext_dead() always finds a valid scheduler pointer (fixes
  bug 1).

- After scx_init_task() returns, check under scx_tasks_lock whether
  @p is still on scx_tasks.  If not, sched_ext_dead() raced us.
  If state != NONE, ops.init_task() ran before sched_ext_dead() saw
  state=NONE, so call scx_disable_and_exit_task() with cancelled=true
  to release the resources (fixes bug 2).  If state=NONE,
  sched_ext_dead() already cleaned up.

Fixes: 88234b075c3f ("sched_ext: Introduce scx_task_sched[_rcu]()")
Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
v2: Rewrite as writer-side fix per Tejun's review:
 - Move scx_set_task_sched(p, sch) into scx_init_task() before the state
   transition off NONE, restoring the "state!=NONE => p->scx.sched!=NULL"
   invariant.  Bug 1 (NULL deref) is fixed without touching sched_ext_dead().
 - Handle bug 2 (resource leak) in the workfn's list_empty() path by
   calling scx_disable_and_exit_task() when state!=NONE, instead of the
   v1 reader-side branch in sched_ext_dead() that leaked resources.
 - Update Fixes: to 88234b075c3f ("sched_ext: Introduce scx_task_sched[_rcu]()")
   which is when scx_task_sched(p) started dereferencing p->scx.sched.


 kernel/sched/ext.c | 59 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f7b1b16e81a5..99560f77af81 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3583,7 +3583,15 @@ static int scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork
 		/*
 		 * While @p's rq is not locked. @p is not visible to the rest of
 		 * SCX yet and it's safe to update the flags and state.
+		 *
+		 * Install p->scx.sched before transitioning state off NONE so
+		 * that the invariant state!=NONE => p->scx.sched!=NULL holds as
+		 * soon as state becomes observable.  A concurrent sched_ext_dead()
+		 * that races the INIT window will then always find a valid
+		 * scheduler pointer and can call scx_disable_and_exit_task()
+		 * to release resources allocated by ops.init_task().
 		 */
+		scx_set_task_sched(p, sch);
 		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
 		scx_set_task_state(p, SCX_TASK_INIT);
 	}
@@ -3769,8 +3777,6 @@ void scx_pre_fork(struct task_struct *p)
 
 int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
-	s32 ret;
-
 	percpu_rwsem_assert_held(&scx_fork_rwsem);
 
 	p->scx.tid = scx_alloc_tid();
@@ -3781,10 +3787,7 @@ int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 #else
 		struct scx_sched *sch = scx_root;
 #endif
-		ret = scx_init_task(sch, p, true);
-		if (!ret)
-			scx_set_task_sched(p, sch);
-		return ret;
+		return scx_init_task(sch, p, true);
 	}
 
 	return 0;
@@ -6937,7 +6940,49 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 			goto err_disable_unlock_all;
 		}
 
-		scx_set_task_sched(p, sch);
+		/*
+		 * sched_ext_dead() may have raced while locks were dropped in
+		 * scx_task_iter_unlock().  Two cases:
+		 *
+		 * (a) sched_ext_dead() ran after scx_init_task() set state=INIT:
+		 *     it called scx_disable_and_exit_task() (cancelled=true) and
+		 *     reset state to NONE.  ops.exit_task() already ran; skip.
+		 *
+		 * (b) sched_ext_dead() ran before scx_init_task() (state=NONE at
+		 *     the time): it skipped scx_disable_and_exit_task() because
+		 *     state was NONE.  scx_init_task() subsequently called
+		 *     ops.init_task() and set state=INIT, leaving allocated
+		 *     resources with no owner.  We must call
+		 *     scx_disable_and_exit_task() here to release them.
+		 *
+		 * Distinguish case (a) from (b) by reading state: (a) leaves
+		 * state=NONE (reset by scx_disable_and_exit_task); (b) leaves
+		 * state=INIT (set by scx_init_task, never reset).
+		 */
+		{
+			bool p_dead = false, need_exit = false;
+
+			scoped_guard(raw_spinlock_irq, &scx_tasks_lock) {
+				if (list_empty(&p->scx.tasks_node)) {
+					p_dead = true;
+					need_exit = scx_get_task_state(p) != SCX_TASK_NONE;
+				}
+			}
+
+			if (p_dead) {
+				if (need_exit) {
+					struct rq_flags rf;
+					struct rq *rq;
+
+					rq = task_rq_lock(p, &rf);
+					scx_disable_and_exit_task(sch, p);
+					task_rq_unlock(rq, p, &rf);
+				}
+				put_task_struct(p);
+				continue;
+			}
+		}
+
 		scx_set_task_state(p, SCX_TASK_READY);
 
 		/*
-- 
2.43.0

