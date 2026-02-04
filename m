Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC08C313526
	for <sched-ext@lists.linux.dev>; Wed,  4 Feb 2026 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197686; cv=none; b=jD5VBzujAHTgs8M3sZyj5VCuE1M1eEgyodr6kR0vPIuWCwuUeQXf8H0nu7b6Yipw/fZdt2eUq+qMdtdzFLfmP5Zs3uVhOh3e8lnzx/M3Xx7P3/pGSBV9TgB4HpPBB1lwPvc35eYjZv5ukHLkgxRNieI9moBu5C0vFgjMn33y9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197686; c=relaxed/simple;
	bh=CRoEjsErLKmZgCHhsxldyfsjMOvokOoZYgxJ5C4gOQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bkbo/CJIxiPm22pbXOyivp1kp3q3ktjd7cEHYYY9FD7RSPP58pUri/B4vJ85rBR19r3eNtl+ADQu2ZZ4cwDsdtPwJzdpBylKyEkd8kTCehx6zdhsqolKkD6LVOmSHnTMAcfbtAF0J86btsI0hzEf8f99NIVQ3mEEbZaztfDEXZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8m35E1d; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8m35E1d"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b7070acfdcso7116238eec.0
        for <sched-ext@lists.linux.dev>; Wed, 04 Feb 2026 01:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770197686; x=1770802486; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o72PYQSE1sHioGlc1ptWPScARuFf9bKlEV/m1NDU5ws=;
        b=J8m35E1dz+lUwegpBFyjz1Sckn7FVxE3t6Frluw2dAZL4tllbSpKgg37v4QtxyzBln
         OppIRa6E6xTj5qvBSKMiOGDJQe3CiFq5KMnLbHgCxoWHipWt4DPFHi1oib65UGOHFgBB
         8nTPn19hRHodEp/zwYGvlcFebXEjNqXi+zEdZdrTUqJomEgmlHgwGdao7R0GX+eJvSak
         BzeA/eacGBN2+AmOcXqol3sjW38rp13gsGPQUyEvOQICNaj6W6WfWSVG3FvGn/pEgKaG
         a9bUGL2CKGIGe+vGWQr4du2magKtMJYmRVpgRDpEc8e2QWE7syAw+1I28s9VJ4eYc+P7
         m+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770197686; x=1770802486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o72PYQSE1sHioGlc1ptWPScARuFf9bKlEV/m1NDU5ws=;
        b=cdwnkRW34NjwM/iGTHA2xeEwwn0dRx2jKkg29MQ5QsgNcav/MH2bzMeaZXnHNVHmAn
         ysN12/cLRZh4gwNZHuMEQxOgxkwoqma5vtCIA601G2SUuLROoL4FLt4kE/MKN9GBBXGp
         gzyORGSnqy0aG+CIngmNcfbQlLUSiSZ9SwIGuFTUWzINwLySmTkuduPfe4ej88l2qYT4
         Uu2aYziJuEW6Sb1p8ROa1dXfJxTk/uQIoX6zRN/WZkrsDpcnOyhis2NJZIfXMBvDhUQF
         BnTLuUCpOLnsHqV1kH+VesznhAnWhvoHwNex3FmvZ/a/Z2zrJ2mRCCc10WAud9F0vh4D
         mDZw==
X-Forwarded-Encrypted: i=1; AJvYcCXbb9kbs/5KBU2YutU+JWCz/yoNI275uwJpqF6WKMmnI6FhOss5PPfhoBzAm6V/tmSPNG3PhLzUVGE=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywx5foMFImIt/kdZwj7Zbi6BTeeJX9qRu4IubVZ0aUm+h+EQ34L
	nbq2x+P1Hhc124HndT5iXtMpVbADBvjWFdcmKoJM+mxQ8jPp10pCehfM
X-Gm-Gg: AZuq6aK5XJ1KdYhvY9w+K9hUZWWMyQiWCyoa2WPNtSDiAiEq5GOq8FE9AyRIu+V0N/8
	XokakLXAVF3jQEvMjypQzD2v/qEMkWKXbZD8/5+Q/RSIek8LF6g5PzIhwRZ8meOn4M08Qz3kR1V
	wu7Ui+x4qmD/wZnIq/wb4NiOnhkU9l4wa0bIOCnWXFNxxFCBq5XXjrS5nEQmV99UX0qZwZgOS/X
	tbCOu3rgQbEAPEHtCxsN4BNX5A+1dfcQYZkPmMQe7uPdtDhzSdd/VLVVuABsP+rYhegz7fAMSPC
	JlGxJwXO25SPFUbe+44gtOjb9bclMiWD0hA4nzkBthMt6hy34HXkev2MndnPmRl6wrdmq4AnKAz
	gQCoBTWbWanfu0N/D5yvoPS4n8B0KTPNEd5IfGpvyTkApM1OT2tpYfS0KhtJYb7ouFsmeAo/X6e
	Ju+Kg=
X-Received: by 2002:a05:7300:dc17:b0:2b4:5514:38fd with SMTP id 5a478bee46e88-2b83296003fmr1026526eec.20.1770197685714;
        Wed, 04 Feb 2026 01:34:45 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e1290csm1199397eec.1.2026.02.04.01.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:34:45 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Qiliang Yuan <realwujing@gmail.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Jake Hillion <jake@hillion.co.uk>,
	zhidao su <suzhidao@xiaomi.com>,
	David Dai <david.dai@linux.dev>
Cc: Qiliang Yuan <yuanql9@chinatelecom.cn>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ryan Newton <newton@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/ext: Add cpumask to skip unsuitable dispatch queues
Date: Wed,  4 Feb 2026 04:34:18 -0500
Message-ID: <20260204093435.3915393-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a cpus_allowed cpumask to struct scx_dispatch_q to track the union
of affinity masks for all tasks enqueued in a user-defined DSQ. This
allows a CPU to quickly skip DSQs that contain no tasks runnable on the
current CPU, avoiding wasteful O(N) scans.

- Allocate/free cpus_allowed only for user-defined DSQs.
- Use free_dsq_rcu_callback to safely free the DSQ and its nested mask.
- Update the mask in dispatch_enqueue() using cpumask_copy() for the
  first task and cpumask_or() for subsequent ones. Skip updates if the
  mask is already full.
- Update the DSQ mask in set_cpus_allowed_scx() when a task's affinity
  changes while enqueued.
- Handle allocation failures in scx_create_dsq() to prevent memory leaks.

This optimization improves performance with many DSQs and tight affinity
constraints. The bitwise overhead is significantly lower than potential
cache misses during task iteration.

Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
v2:
 - Fix memory leak by adding RCU callback to free dsq->cpus_allowed.
 - Handle affinity changes while task is in DSQ via set_cpus_allowed_scx().
 - Ensure dsq->cpus_allowed is only allocated for user DSQs.
 - Handle allocation failures in scx_create_dsq().
 - Optimize enqueue path by using cpumask_copy() for the first task and
   skipping OR if mask is already full.

 include/linux/sched/ext.h |  1 +
 kernel/sched/ext.c        | 68 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index bcb962d5ee7d..f20e57cf53a3 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -79,6 +79,7 @@ struct scx_dispatch_q {
 	struct rhash_head	hash_node;
 	struct llist_node	free_node;
 	struct rcu_head		rcu;
+	struct cpumask		*cpus_allowed; /* union of all tasks' allowed cpus */
 };
 
 /* scx_entity.flags */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index afe28c04d5aa..0ae3728e08b8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1120,8 +1120,16 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 
 	if (is_local)
 		local_dsq_post_enq(dsq, p, enq_flags);
-	else
+	else {
+		/* Update cpumask to track union of all tasks' allowed CPUs */
+		if (dsq->cpus_allowed) {
+			if (dsq->nr == 1)
+				cpumask_copy(dsq->cpus_allowed, p->cpus_ptr);
+			else if (!cpumask_full(dsq->cpus_allowed))
+				cpumask_or(dsq->cpus_allowed, dsq->cpus_allowed, p->cpus_ptr);
+		}
 		raw_spin_unlock(&dsq->lock);
+	}
 }
 
 static void task_unlink_from_dsq(struct task_struct *p,
@@ -1138,6 +1146,10 @@ static void task_unlink_from_dsq(struct task_struct *p,
 	list_del_init(&p->scx.dsq_list.node);
 	dsq_mod_nr(dsq, -1);
 
+	/* Clear cpumask when queue becomes empty to prevent saturation */
+	if (dsq->nr == 0 && dsq->cpus_allowed)
+		cpumask_clear(dsq->cpus_allowed);
+
 	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN) && dsq->first_task == p) {
 		struct task_struct *first_task;
 
@@ -1897,6 +1909,14 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 	if (list_empty(&dsq->list))
 		return false;
 
+	/*
+	 * O(1) optimization: Check if any task in the queue can run on this CPU.
+	 * If the cpumask is allocated and this CPU is not in the allowed set,
+	 * we can skip the entire queue without scanning.
+	 */
+	if (dsq->cpus_allowed && !cpumask_test_cpu(cpu_of(rq), dsq->cpus_allowed))
+		return false;
+
 	raw_spin_lock(&dsq->lock);
 
 	nldsq_for_each_task(p, dsq) {
@@ -2616,9 +2636,25 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 				 struct affinity_context *ac)
 {
 	struct scx_sched *sch = scx_root;
+	struct scx_dispatch_q *dsq;
 
 	set_cpus_allowed_common(p, ac);
 
+	/*
+	 * If the task is currently in a DSQ, update the DSQ's allowed mask.
+	 * As the task's affinity has changed, the DSQ's union mask must
+	 * be updated to reflect the new allowed CPUs.
+	 */
+	dsq = p->scx.dsq;
+	if (dsq && dsq->cpus_allowed) {
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&dsq->lock, flags);
+		if (p->scx.dsq == dsq)
+			cpumask_or(dsq->cpus_allowed, dsq->cpus_allowed, p->cpus_ptr);
+		raw_spin_unlock_irqrestore(&dsq->lock, flags);
+	}
+
 	/*
 	 * The effective cpumask is stored in @p->cpus_ptr which may temporarily
 	 * differ from the configured one in @p->cpus_mask. Always tell the bpf
@@ -3390,13 +3426,29 @@ DEFINE_SCHED_CLASS(ext) = {
 #endif
 };
 
-static void init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id)
+static int init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id)
 {
 	memset(dsq, 0, sizeof(*dsq));
 
 	raw_spin_lock_init(&dsq->lock);
 	INIT_LIST_HEAD(&dsq->list);
 	dsq->id = dsq_id;
+
+	/* Allocate cpumask for tracking allowed CPUs only for user DSQs */
+	if (!(dsq_id & SCX_DSQ_FLAG_BUILTIN)) {
+		dsq->cpus_allowed = kzalloc(cpumask_size(), GFP_KERNEL);
+		if (!dsq->cpus_allowed)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+static void free_dsq_rcu_callback(struct rcu_head *rcu)
+{
+	struct scx_dispatch_q *dsq = container_of(rcu, struct scx_dispatch_q, rcu);
+
+	kfree(dsq->cpus_allowed);
+	kfree(dsq);
 }
 
 static void free_dsq_irq_workfn(struct irq_work *irq_work)
@@ -3405,7 +3457,7 @@ static void free_dsq_irq_workfn(struct irq_work *irq_work)
 	struct scx_dispatch_q *dsq, *tmp_dsq;
 
 	llist_for_each_entry_safe(dsq, tmp_dsq, to_free, free_node)
-		kfree_rcu(dsq, rcu);
+		call_rcu(&dsq->rcu, free_dsq_rcu_callback);
 }
 
 static DEFINE_IRQ_WORK(free_dsq_irq_work, free_dsq_irq_workfn);
@@ -6298,7 +6350,11 @@ __bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node)
 	if (!dsq)
 		return -ENOMEM;
 
-	init_dsq(dsq, dsq_id);
+	ret = init_dsq(dsq, dsq_id);
+	if (ret) {
+		kfree(dsq);
+		return ret;
+	}
 
 	rcu_read_lock();
 
@@ -6310,8 +6366,10 @@ __bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node)
 		ret = -ENODEV;
 
 	rcu_read_unlock();
-	if (ret)
+	if (ret) {
+		kfree(dsq->cpus_allowed);
 		kfree(dsq);
+	}
 	return ret;
 }
 
-- 
2.51.0

