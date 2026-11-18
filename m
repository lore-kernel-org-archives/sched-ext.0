Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997497;
	b=PxXZUB4o6+KCGlOjApaWXbKYc8EOQ4QDTFi+ZhiczPa4A0tWX2Z3BUhzW1QWf6Cv541d
	 q3RYdz9t9djBfho/tyLEEO003FrL+GnfK72SCxujol82s+Iadvhx6coJuNyJytT1ejrhK
	 PTcrb5cbJEeZU024WO/gPoRcnyvJvVoQ7gGEGOfajxwopEBGofeIRlvamy0Xgiao9uRjM
	 teanxKFHze94NW0acovejx9ido9dXVrGbKcRnJdM3JnXN0iZt9odoezP7DD9nW3olPElx
	 /zLBNwKCPlPka0cQpOKz7aWv6Q05Z13yjeWJLrbF8n3hvwd3EXWQcFccoPhecypgBnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=If0wiTaVRkXQ5kmmpt319RkHXOqmyU3DcRDOmq3khpg=;
	b=EIm6bKMppaDTnvjGeZRSS3mUefP8KOH0r5PZqRlCBBZzMbqaXzvD+Qxu1t1b/eVGqgdZ
	 n15iHv2yn6qQpuP7tFW4PWWyKcw8yIefi3ubl5tF4nENGMTbDf+b92ezkZhtNkx9dIL61
	 azHjDGkPW6wmrBWq0Tqcke3lASKvqJlj1TR8/2vEjhN/ChVLUmhWu7UFoZ82Hbn2tcJSW
	 y67tTicd74ZGx8KpCyz47LHVDpoHzHOGM5i9ees8Y8DOwvv13twcjUU8JQX61H1mGTBUk
	 QhTUCrOkdhkXmk6pxiJLsFXLhVEi0gQnNSbz8FJsU75tMidrb7A67c0gxOCcwk9ryfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HPA4EQVq;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BDD606A31C
	for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 10:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29BDD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HPA4EQVq
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4a4191ae436so755305f8f.2
        for <sched-ext@lists.linux.dev>; Wed, 18 Nov 2026 02:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794997495; x=1795602295; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=If0wiTaVRkXQ5kmmpt319RkHXOqmyU3DcRDOmq3khpg=;
        b=HPA4EQVqwunBPIqmWhVimoGqUJ9FnE3RZc6M0RHGcu0tvpVkxW6i14sMlzq92ZhYRz
         D+/eLxuh4moO3G1P0PkCO9ASjo7lI28m2hfqUvvQcbAzA3oewOCAYVkGKpVkQvZTAppL
         em1hHhVQmqxH57vIogh2DdbYM5AEWkM/wkt0Mbeb0FQR1AYPtX/ULKOJDJgtrtId153T
         ttaLmvADSsmE1OtTwdtia4MPSYpug4Ktq6kcsIlAnx6eoneBxkJ1NGC11ljVW//XIpC0
         NrYJQyZ1QmWJ3FGDB/tnjLOk0szhr4A8rrlz+E0kq1qGoX4Kmi6kGoo4dhW0BXSDnH6W
         t9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794997495; x=1795602295;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=If0wiTaVRkXQ5kmmpt319RkHXOqmyU3DcRDOmq3khpg=;
        b=bABLwFPWijq61HS1df6dhJmhoFRI3EA5Gg9Jll9l4S6r8hdtTHUxee9YT7L7LkdRF6
         qve17ZKZStxNC3c3laUOO4nF55xHKtOiX6+RtfHGDKHAmQZV2ph0nY08y7BhywBNOiL9
         wk6JGnxQ8Qs4MQu21EqtU7QxHmTKDOytQlidNcPDNWCCq8JaAuWfvlDveC0iI1+UTT62
         7zt0u2WLr55qwKZtPZXoUdJYALQB3B02AhTA2MUAfmD9MZWwDKuySyMxDev1fJi7OFMz
         GCn4mJaQilmmmifwNMsRYBseKvU79dtZ553XR/N6Ba8tKYbpvEL0dYIASxN+tOoMpFe4
         qXyg==
X-Forwarded-Encrypted: i=1; AL+hErFlyDbCBsCzucRYCLQe3cL1oki0GAcVPYsZ4WCUTEz2q2atpWF6E2HX0hPqOb7YO5YyecLfQju1izQ=@lists.linux.dev
X-Gm-Message-State: APuU4Z/I6JmZyEGPTl5cnKjR8FAfOMJy/02gwsUJo3eOCsyHxFKgyJP7
	Ic7qD4vrKU9lvJ2DsLqNAXGA2ve/PFr7HpRrNmBNtFRZqkrSnNYVrvy7otmU2Ze23bSPFHzbVuA
	J7KFDn+TgoivWOg==
X-Received: from wmuh1.prod.google.com ([2002:a05:600d:4121:b0:4a1:f082:d6ca])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3111:b0:4a6:4d6b:a840 with SMTP id 5b1f17b1804b1-4bb7da2bb49mr40194335e9.31.1794997495263;
 Wed, 18 Nov 2026 02:24:55 -0800 (PST)
Date: Wed, 18 Nov 2026 10:24:52 +0000
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118102453.1315267-1-jpiecuch@google.com>
Subject: [PATCH sched_ext/for-7.4-fixes] sched_ext: Don't route tasks to SCX
 before __scx_enabled is fully patched
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

scx_root_enable_workfn() sets scx_switching_all and calls
static_branch_enable(&__scx_enabled) before switching tasks, and
task_should_scx() gates only on scx_enabled(). static_branch_enable()
patches jump-label sites in address order rather than atomically:
task_should_scx() may be patched before __schedule().

If a concurrent fork or sched_setscheduler() runs in that window,
task_should_scx() observes scx_enabled() and moves the running task
from fair_sched_class to ext_sched_class, setting need_resched on the
class degradation. The following __schedule() can still observe
!scx_enabled() in next_active_class(), skip ext_sched_class, and pick
rq->idle while the runnable SCX task is still rq->donor:

  WARNING: kernel/sched/ext/ext.c:3840 at put_prev_task_scx+0x405/0x7a0
  Sched_ext: enq_select_cpu (enabling+all), task: runnable_at=+0ms
  Call Trace:
   __schedule+0x5cc/0x1100
   preempt_schedule_common+0x12/0x40
   preempt_schedule_thunk+0x16/0x40
   __sched_setscheduler+0x8d8/0x920

Gate task_should_scx() on a scx_task_switch_enabled flag that is set with
release semantics only after static_branch_enable(&__scx_enabled) has
finished patching all call sites and scx_switching_all is updated, and
cleared on disable alongside scx_switching_all.

This bug was found and the patch was written with the help of an AI
coding assistant.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext/ext.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10de6bd865e8..e8c30a21e03e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -134,6 +134,7 @@ DEFINE_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_enable_state_var = ATOMIC_INIT(SCX_DISABLED);
 static DEFINE_RAW_SPINLOCK(scx_bypass_lock);
 static bool scx_init_task_enabled;
+static bool scx_task_switch_enabled;
 static bool scx_switching_all;
 DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
 static DEFINE_STATIC_KEY_FALSE(__scx_tid_to_task_enabled);
@@ -6493,6 +6494,15 @@ bool task_should_scx(int policy)
 	if (!scx_enabled())
 		return false;
 
+	/*
+	 * static_branch_enable(&__scx_enabled) patches call sites one by one.
+	 * Wait until all sites are patched before routing tasks to SCX, so
+	 * __schedule() never sees !scx_enabled() when a task is on SCX. Pairs
+	 * with smp_store_release() in scx_root_enable_workfn().
+	 */
+	if (unlikely(!smp_load_acquire(&scx_task_switch_enabled)))
+		return false;
+
 	/* scx is taking over all SCHED_OTHER and SCHED_EXT tasks */
 	if (READ_ONCE(scx_switching_all))
 		return true;
@@ -7568,6 +7578,7 @@ static void scx_root_disable(struct scx_sched *sch)
 
 	static_branch_disable(&__scx_switched_all);
 	WRITE_ONCE(scx_switching_all, false);
+	WRITE_ONCE(scx_task_switch_enabled, false);
 
 	/*
 	 * Shut down cgroup support before tasks so that the cgroup attach and
@@ -8965,11 +8976,14 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 	percpu_up_write(&scx_fork_rwsem);
 
 	/*
-	 * All tasks are READY. It's safe to turn on scx_enabled() and switch
-	 * all eligible tasks.
+	 * All tasks are READY. Finish patching all scx_enabled() sites before
+	 * opening task_should_scx() and switching eligible tasks.
 	 */
-	WRITE_ONCE(scx_switching_all, !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
+	WARN_ON_ONCE(scx_task_switch_enabled);
 	static_branch_enable(&__scx_enabled);
+	WRITE_ONCE(scx_switching_all, !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
+	/* pairs with smp_load_acquire() in task_should_scx() */
+	smp_store_release(&scx_task_switch_enabled, true);
 
 	/*
 	 * We're fully committed and can't fail. The task READY -> ENABLED

base-commit: 700a332c3fe33014bbd5ae852d71ba679fc29e0a
-- 
2.56.0.679.gc527c65306-goog

