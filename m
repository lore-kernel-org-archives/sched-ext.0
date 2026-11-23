Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464835;
	b=e2XEwr4oriyDMs4z3PpL1PCWsIeTw3m7U4hgGdopmUL0pkZd1vBHprDZShm8L4TBWX++
	 ebYsu827jYfh5ITF1YoiGudDEcSub/CThCfQn3WO9m1kM1kpC3K5BZ2u8F7YgHFk9eYgB
	 zFAi+yDfMdZKz+W4/jPtpSqkYXfjYvzd3S475A/7t5xwV2Yo9WEwKUOmYudbVW+CQm6qx
	 kzz6SqeefZLVDX9iADJnCxjxSiyRWYuft3Dp26it+sbksdEOMd0y8NZ1k8SGiZM4Yr0j/
	 HL1prAYeCQv7NbFG4zByEmBtFqJDUXhMIAGalMNyjnTWfAVyu0ltbwPD/d8vTKqh1AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=OvpPMptrHzBE3IreIziZcS9fob5PN9ySIM3VZNI+Dzw=;
	b=dhrM5vyTPtf1qGa0TX4MZPdQoCllSu5bek+3i/rjPRja+3AGjoWv/cQRiDaYMyVDkIuY
	 ifUSnJCqLHuSe0UTtJHxipLkVCXEprLO4Hp/kSkn7Vr42gJVO06OgxuPrz28AgWcv5vqS
	 A0gYPR1ODn10Z3bMUa7gF7MmUnpH5z95JbLYkzh4dwUnE5lK/Usw5AZ/YKNzVo3ET18Au
	 wNi7prvD5aVFhZqpyQ52uFvg9okMjPg6jdMIBYbq48tWgqU2Rsx6lkQogROVp2lQSFO90
	 EXL7S2rTw4AS0H9GTL9URY8V+ySUEDdWLcemupwwdgvtSaTBNXoA5WL9pBFOzzuwpBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S3mh98fs;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14788606A33F
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 20:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14788606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S3mh98fs
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so6019691eec.1
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 12:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795464834; x=1796069634; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OvpPMptrHzBE3IreIziZcS9fob5PN9ySIM3VZNI+Dzw=;
        b=S3mh98fs+oPmiOodxFqb/ER/0AD72wzziN2JAzagpdlvjmZumtPwRUfMz9saCdoAda
         ZVmcBeNsRcwn+yQNRzjbQQ2c7Nt/U8uKeD2jK/EE2oT0kEO5nElOg26krKSQpvb0vo5/
         495Y3NMA2qxUjN76HlOo4uzJW6swvKgWJJHjQpJwJ5EaiO5WUr78S/wwWJQcGzSOC0X4
         jangH8lOJHzuWVXw2j1qfAWJYhQ2FCzLezzJCI6zmkfzQsZz9K4D3rnCF4wVLfkHRsc9
         IN9ttaKTxJAqe5tcg/dY2JH/KLpmhDKVmXCW+g/SwGDB/AjfgVLzKQZ/4qDJVkm/ofxU
         1TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795464834; x=1796069634;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OvpPMptrHzBE3IreIziZcS9fob5PN9ySIM3VZNI+Dzw=;
        b=rgpe5QDXiv8Pm867m4aTQNCDDUSmoPb99d6Cu1Db+VWhF9a8dhvPHtmVIpSvpQbUmG
         XmQQzKoVxt/b3ZmIUgzItHXbmvvo9vk5g71G6DoTjG0DcRDABUTf8qegxkPUIEiJrwXU
         VYGGrxubLYn1X9IJW6/NrWty8DnxAsG9AVxbH1zqBCK2ElVcCL31trMXdmix5TIli6Fl
         9HvmOiNkVuHlYrZSUJh7FlKow9G4XKRXh8fWGGgmALhfZoDCnT0b8Rd2XU2yPVpwjNKi
         0ux8SXTrJKgeltuO67mXvBDzDt9aJaega7T5gSk8bu99P1gcwBsps6o5ZcN+nOm8UlC0
         RA0Q==
X-Forwarded-Encrypted: i=1; AL+hErH1ZJ0X1NN+bblITjRgwZV9gph0jp57vC8x/AqF2KHkeIx2/+/gqSRZEU261isDoNguCKDdvugq0i8=@lists.linux.dev
X-Gm-Message-State: APuU4Z/uX6UK87fTBYPFTEpDyTh3QonnWkhWdSxvHOeFYupa5ykirWox
	aBYXWYIoBf5GMcP/DmzD74DHuRisO3cNCSefcnpQ0r+UQgEYmmX3QRVhC/Jkoc84b4QyLeWwMd9
	L4ZobU0feNCr4LDfoPg==
X-Received: from dlbts3-n1.prod.google.com ([2002:a05:7022:b043:10b0:1b2:5271:f03b])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2810:b0:192:74cf:1db2 with SMTP id a92af1059eb24-1b5568650b5mr11311923c88.11.1795464833720;
 Mon, 23 Nov 2026 12:13:53 -0800 (PST)
Date: Mon, 23 Nov 2026 12:13:51 -0800
In-Reply-To: <cover.1795462673.git.penghuang@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com> <cover.1795462673.git.penghuang@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <2b1ef28e12d12a1f894827b951910c1979d54d45.1795462673.git.penghuang@google.com>
Subject: [PATCH v2 2/2] sched_ext, sched/fair: Drain blocked load on scx_switched_all
From: Peng Huang <penghuang@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org, Peng Huang <penghuang@google.com>
Content-Type: text/plain; charset="UTF-8"

Tasks that exit or migrate while sleeping queue their PELT load and
utilization in cfs_rq->removed rather than deducting and propagating
immediately. When scx_enable() switches all fair tasks to sched_ext,
switched_from_fair() only visits cfs_rq chains that still hold live
fair tasks, leaving unvisited leaf cfs_rqs undrained in rq->cfs.avg.

Once __scx_switched_all is enabled, scheduler_tick() skips
sched_balance_trigger() and fair_sched_class is bypassed, freezing
blocked-load updates. Stale rq->cfs.avg.util_sum can then combine with
active RT/DL util_sum in update_idle_rq_clock_pelt() to exceed divider,
inflating rq->lost_idle_time and stalling rq_clock_pelt().

Export __sched_balance_update_blocked_averages() and call it on each
CPU in scx_enable()'s per-CPU scx_switched_all() loop so pending
cfs_rq->removed entries and task-group propagations are drained cleanly.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Peng Huang <penghuang@google.com>
---
 kernel/sched/ext/ext.c | 9 ++++-----
 kernel/sched/fair.c    | 7 ++++++-
 kernel/sched/sched.h   | 1 +
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10de6bd865e8..f7c573092e17 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9013,11 +9013,9 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		static_branch_enable(&__scx_switched_all);
 
 	/*
-	 * Detach the fair_server bandwidth reservation now that the switch
-	 * is fully committed. In full mode (!SCX_OPS_SWITCH_PARTIAL) no
-	 * task will ever run in the fair class, so give that bandwidth
-	 * back to the RT class. The matching ext_server attach already
-	 * happened earlier; this only releases bandwidth and cannot fail.
+	 * Detach the fair_server bandwidth reservation and drain any
+	 * remaining blocked or removed fair load now that the switch is
+	 * fully committed and periodic fair blocked-load updates stop.
 	 *
 	 * In partial mode keep fair_server attached.
 	 */
@@ -9028,6 +9026,7 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 			guard(rq_lock_irqsave)(rq);
 			update_rq_clock(rq);
 			dl_server_detach_bw(&rq->fair_server);
+			__sched_balance_update_blocked_averages(rq);
 		}
 	}
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f6c3bbb19557..f19f498e01a4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11655,10 +11655,15 @@ static unsigned long task_h_load(struct task_struct *p)
 }
 #endif /* !CONFIG_FAIR_GROUP_SCHED */
 
-static void __sched_balance_update_blocked_averages(struct rq *rq)
+/*
+ * Update blocked PELT averages for RT/DL/IRQ and fair cfs_rqs on @rq.
+ * Caller must hold @rq's lock and have updated @rq's clock.
+ */
+void __sched_balance_update_blocked_averages(struct rq *rq)
 {
 	bool decayed = false, done = true;
 
+	lockdep_assert_rq_held(rq);
 	update_blocked_load_tick(rq);
 
 	decayed |= __update_blocked_others(rq, &done);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 220927453a88..71a69f90e5df 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2977,6 +2977,7 @@ extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
 extern void update_group_capacity(struct sched_domain *sd, int cpu);
 
 extern void sched_balance_trigger(struct rq *rq);
+void __sched_balance_update_blocked_averages(struct rq *rq);
 
 extern int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx);
 extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx);
-- 
2.56.1.831.g720f3f5937-goog

