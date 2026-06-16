Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E8438FEE
	for <sched-ext@lists.linux.dev>; Tue, 16 Jun 2026 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607383; cv=none; b=KNNoNrV8Qm7xnH7Tgfml0IzYVmeCF7THCR4y6a8Mpe8vse0w0oasSBawPsDGErtOxlXF2u5JH/MjiEW1LBW+3z8bSZKYLegFpCncUWzg0HLiaHqaKKzlJ+0kA8jtA2X9NDwWJIWn+A2KFf66KO6jvosT8tzSKnekJtfurMZCRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607383; c=relaxed/simple;
	bh=9AH6QMSRryDOTfJRxGukJID4bDV6I7wkQ4xXWH3c1ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmjRq3d+k1R1ciRhi5HFw8IViRJqeLWZfQ7nBxDeB9WfQMnKc9cMnYFkmMqbSdXzWx1j4R1etbVv6eRTpFuXjmPBk3TQ0Rr/eimwZ8ZfDFvAORmKISe9IC7ZbAb7jlPmyBdourufqJ2WsoGd+Uexhtu1ddD3WGqVg/9B35k0EPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=YhTTJNtH; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="YhTTJNtH"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bf046d4da1fso404007966b.3
        for <sched-ext@lists.linux.dev>; Tue, 16 Jun 2026 03:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1781607381; x=1782212181; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JFoi32RPtT16jhLdDNPUhdeEQXGpdyQg1sRcbSQgvlw=;
        b=YhTTJNtH/piywC24RtqknTaC4iT/3b2AnZm6oMqSkeyKdhtqf0UNDJHxvjgKuDGj4q
         FNo0torZ1GVQpZfrQLjllOZYb7Bs89cpxqgJ/w/INAGG+CeL/YX3Yuc0Qfrn2xK+rnA6
         vUh1UiZVY50WiYEOXNMCEoqUKWzKs7SFMqtnpiygikHD5ugpWiEV7FrISiZLL6eBtDZj
         IRnNmeVJe2tKNcd9jMAtLDe76wBJRY44vnuTHN9MbYqi522hk44U6FkyD/ULK8j/xXYs
         IwvVB7KTo5JTJ2+hEOJa6AX4UTSuM9UGtxiMdLKj7wsFGSSMrFwwkJHVCQc8v87gD8hv
         Xl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607381; x=1782212181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFoi32RPtT16jhLdDNPUhdeEQXGpdyQg1sRcbSQgvlw=;
        b=OuZ9a81E7m9za+cLsMTkyD3s4WJDQAZ8SCbdAcCKpHa0I1etoMn0KYByF8Xvm8k//w
         BM7yze01JKOWzwVh/31pC2oJOj+6vgxmytCJGZlKWGw3c7hZMh/ijut8Mv/QK64KhTAf
         GlwruBKOSiKxCy/52ezWa9KKVE+lpAcR7opZDYoTWIyrjH53SADguk4Ld6CmoD8Yhrq/
         P4W9OKjUEu+r5tVMcit3T3OR0HSbULWeZ4+EJvFjf4lkj4suB70g1VMIzFPx5sc2xS9+
         xAnQ+On649oreXcrbE4IZav3yG21iQhrbxQhpOho0anzdJG+AsB6vANgcTJVpGYXNvaf
         2uZA==
X-Forwarded-Encrypted: i=1; AFNElJ9x0E4wXHwWd/EtxO8shcUZGz4vZ32HvQYdqPe51JNNLmTBu5bTR3BOiqCMhvhn/55iVrcIdcUNdyA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy58V2XaPVfFh2fkpmVkHeUJGesrsn4mnEp487K48cAsN6AIplf
	rH8qRinSWkzmiWelL4JtW/kfls2gfXCfZQcIEIgI1Q0toajYWR3/8fcL9J5U/Q4DGc9QHu7Foqq
	334vR
X-Gm-Gg: Acq92OEIt2uu98mfSTcFBVgtIKoP3TAnSf5J0Q/LbvR0mhD9BR4hdgOBuxqOQXCNhfc
	hXHXJ4QPR9SRTRXHPL3RfWfJ52N4kMESy8VPKSCSH30cLcvQglye/Noa9ITHg81CYQcoMx1a+Og
	Gh1gPq0vMBM5udRcFezGJabXrYvBSyPLKwo7oX79XXmP/C6NUtnFg6u6FzVoTCKCFx/o3JcXDnj
	PqYIVFwec++qjbKSQInT22zVwdhhZpRSVmlRrnBpn9+4T8qcC4iRyZkoR8tWu99yk7tb3EJDBRK
	MzKf9DA+hEBxvfsvzSqh0mXxX4XTMOMxjOxgHlr0knuuRQmghVpwZ8bbYDQOrM+T2C3CsMN4K9f
	iHddfojSWNlHKvicYD0QuUrray7qhTd2sS1lhPGrjqAHwP85nQaVAB+7nxQYJudYYK+MrKumF5u
	rOx5TXAyytGQ==
X-Received: by 2002:a17:906:9c86:b0:bee:280b:8be5 with SMTP id a640c23a62f3a-bff4a10c535mr644235466b.21.1781607380561;
        Tue, 16 Jun 2026 03:56:20 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:1cdc::2e0:a5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb442083esm629814866b.3.2026.06.16.03.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:56:19 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:56:19 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: sched_ext/lavd hard lockup in old call_rcu_tasks_generic
 needadjust path
Message-ID: <ajErr_GEejCD7n47@matt-Precision-5490>
References: <20260609104733.1184001-1-mfleming@cloudflare.com>
 <2179fc11-3bd5-4d2e-9ad8-609e3356ec09@paulmck-laptop>
 <aiqxpzgl2YVVSARw@matt-Precision-5490>
 <1ad83f53-7897-40bc-a503-5a71031aa27f@paulmck-laptop>
 <aivaGbCzC4oaD05n@matt-Precision-5490>
 <3bbd4298-eb01-4784-bee5-caab3d3647b9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bbd4298-eb01-4784-bee5-caab3d3647b9@paulmck-laptop>

On Fri, Jun 12, 2026 at 07:00:31AM -0700, Paul E. McKenney wrote:
> 
> Huh.  Looks like I did not implement RCU Tasks Trace in terms of SRCU
> any time too soon.  But there is also RCU Tasks and RCU Tasks Rude.
> 
> If we don't backport the SRCU patches, then the obvious alternative is
> for call_rcu_tasks*() to defer to IRQ work when invoked with interrupts
> disabled.  Or is there a better way?

What about something like this?

----8<----

From 6b2dc5002f3413f4f89eb1735259d065b7003a52 Mon Sep 17 00:00:00 2001
From: Matt Fleming <mfleming@cloudflare.com>
Date: Mon, 15 Jun 2026 11:19:43 +0100
Subject: [PATCH] rcu-tasks: Defer callback queue adjustment to irq_work

call_rcu_tasks_generic() can run from BPF task-storage teardown while
sched_ext still holds rq->lock. The RCU Tasks kthread can concurrently
hold cbs_gbl_lock while printing under it, then wake a task on the same
rq while the caller waits for cbs_gbl_lock.

Queue the adjustment through irq_work instead. This keeps callback
enqueueing synchronous while moving cbs_gbl_lock acquisition out of the
caller context.

Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 kernel/rcu/tasks.h | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 2dc044fd126e..92aead9fc200 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -104,6 +104,7 @@ struct rcu_tasks {
 	unsigned long n_ipis;
 	unsigned long n_ipis_fails;
 	struct task_struct *kthread_ptr;
+	struct irq_work cbs_adjust_irq_work;
 	unsigned long lazy_jiffies;
 	rcu_tasks_gp_func_t gp_func;
 	pregp_func_t pregp_func;
@@ -129,6 +130,7 @@ struct rcu_tasks {
 };
 
 static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
+static void call_rcu_tasks_iw_adjust(struct irq_work *iwp);
 
 #define DEFINE_RCU_TASKS(rt_name, gp, call, n)						\
 static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
@@ -144,6 +146,7 @@ static struct rcu_tasks rt_name =							\
 	.call_func = call,								\
 	.wait_state = TASK_UNINTERRUPTIBLE,						\
 	.rtpcpu = &rt_name ## __percpu,							\
+	.cbs_adjust_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_adjust),	\
 	.lazy_jiffies = DIV_ROUND_UP(HZ, 4),						\
 	.name = n,									\
 	.percpu_enqueue_shift = order_base_2(CONFIG_NR_CPUS),				\
@@ -342,6 +345,24 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
 	rcuwait_wake_up(&rtp->cbs_wait);
 }
 
+static void call_rcu_tasks_iw_adjust(struct irq_work *iwp)
+{
+	unsigned long flags;
+	bool expanded = false;
+	struct rcu_tasks *rtp = container_of(iwp, struct rcu_tasks, cbs_adjust_irq_work);
+
+	raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
+	if (rtp->percpu_enqueue_lim != rcu_task_cpu_ids) {
+		WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
+		WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
+		smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
+		expanded = true;
+	}
+	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
+	if (expanded)
+		pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
+}
+
 // Enqueue a callback for the specified flavor of Tasks RCU.
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 				   struct rcu_tasks *rtp)
@@ -389,16 +410,8 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 		rtpcp->urgent_gp = 3;
 	rcu_segcblist_enqueue(&rtpcp->cblist, rhp);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
-	if (unlikely(needadjust)) {
-		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
-		if (rtp->percpu_enqueue_lim != rcu_task_cpu_ids) {
-			WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
-			WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
-			smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
-			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
-		}
-		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
-	}
+	if (unlikely(needadjust))
+		irq_work_queue(&rtp->cbs_adjust_irq_work);
 	rcu_read_unlock();
 	/* We can't create the thread unless interrupts are enabled. */
 	if (needwake && READ_ONCE(rtp->kthread_ptr))
-- 
2.43.0

