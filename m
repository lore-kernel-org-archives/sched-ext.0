Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCEE3BB57
	for <sched-ext@lists.linux.dev>; Tue,  3 Feb 2026 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087853; cv=none; b=rmZsrkBv2ee0NAW+pkdWloN6koOO3M+Sou5rR73nWdtJw3XZOjRAF/b7DeFP+XUhDsB9TO+wJO2okd25uPmP3gTIaoMyCz89ZXPfZV8T/6/7uXeiaZZ8WFxcEuxn44xQarNcReWC1ccxbPR0CdEQPSqnTbM6tYg8HzPVlEiG5p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087853; c=relaxed/simple;
	bh=oX+fdVlBvsXM8XeJprMSbEC3P7FuDL6fEIb2Mgv2lb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFlwdz/xXexdJSCsZ40xLkK3mhIsFoKClY6b01A003/8XKuLA9Bxy8ujqEA1pdoFyKNzelOPMMiq1+tlq3XWWlnpLuxuZGwO6wQ6zJPfNKix/sVzsgWJh3u2Ssc6otJ4yvMyXd7gLFR2M8DxIoTIfAGBTHEw6OKYuDpz8fwyDrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHX1ILWu; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHX1ILWu"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b7da62b487so6626988eec.1
        for <sched-ext@lists.linux.dev>; Mon, 02 Feb 2026 19:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770087851; x=1770692651; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2JLE6DM3qTziaQG75UpuvvvsMcKDWk2318vIqvOxhbs=;
        b=XHX1ILWujgL/0/f0FvTusjUiguL0GD3LhkemIpnzNwOO/W+h5sSgw2AK9b45f0U3uY
         itjmAQ4f6rG9D1p6X4vd9Exm2X/efFCvwaMtAhNeIoK+j99Xt/xuzxTzzfeIRm2yszth
         NvalZQMgVvlSdO0ghyEbDsUSLqZSPCjEKTQyRgmKJPOYDGTUyAxEXm1XjFEbSS6WPcFC
         qr03fHGPn7443Y+0Fd0j8xlCIDq4iJ5xK3n2bZawOCu7tRRAiRqZ6+7we47xgbcRTHmJ
         JI/QsItf2SQLE3+8XdOK9EkHMhAJEEZuGJQx6b/HNB0iMBxKqa3CqGJkEvSZ03orLYA1
         8DjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770087851; x=1770692651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JLE6DM3qTziaQG75UpuvvvsMcKDWk2318vIqvOxhbs=;
        b=GlopGrfJZzfFTrnicVtW77wAocOOSVPOqhr+M8juVrV/u8s2P77GFl1A1W0ryjorn2
         bPGLt/3h015CHtCEJWoPNb/StGIlePT1nQBwaSmfYRmZva1+uRgFxlbdlLjzOmJGqFLV
         VFMblW6qXgcvFGXKZ0E6eOvYYkX0z8SY54e9SDEox8Wx/Ot1nGrUVVmR1J+FvmWR+PKu
         D6+sczFG8BOvf4o5xmCniaOFKc1OVAiDGkquB3rL/2x2kbi3U4o7DMRzSPCt1bzl8UTm
         NfzBOrgdS5stKakQnIjSz84qlxuGW01SRCxCFdZesrIR4nz+0vWX9yBgXBewF78LfW+a
         pKpg==
X-Forwarded-Encrypted: i=1; AJvYcCV+eZnmKIQqEpTkj8kK6MxN8S9Buw47vYlFlIB7vZUbKSoMQeQ48RCZWfYGF0QNv6LAONAjbmAGpak=@lists.linux.dev
X-Gm-Message-State: AOJu0YxtwPqnIzVLTZFCb9ZeRAfQu4iKDbmo4TySp5zHuV8BALpKiKxV
	oSNbTB71owIQMTonfLnPH9TSFobHuNMXPnrly+sOz+A0K6s5fxP/F1Ps
X-Gm-Gg: AZuq6aIM/ydjNbncZn+MprIScTs0Ar0K8/q12FCWmR7IACCHTfGLTz+OSzu6IKKl/w0
	/rh5hVlyAXQUKpr2MUStlycxltvf5usEaa9QXdnbkOkuNgsQTPiNIzziDAnR6ENtJFffP8jZtT8
	m4b8BTan5JRCTN5VUDfs0Jcn8wC7imOV58Citb1Faj/QHW8hjsAwtc7p9h2ZW5fNA5dtxyvoN30
	4ucV70K2FLGrjOroFQlIjtA/CAwWnivyQ2Q4phCaekky+5YhL1hFhP8knve6OyK3zlulVC9X+dL
	/+PKKiHyLwywalbAD+dkzES+OKuu76FAjCwnK87L9hCloVSF/6JRpV602vcOk4kXJjeqEqplUyU
	dkUPVxPuz1xk5DUSXvY071++lu8GD5wFPYI2v6aN1NvGt8mC4rKbrTYBdATvU+o28QkEml5bzsn
	AiRws=
X-Received: by 2002:a05:693c:61c3:b0:2b7:ef84:9123 with SMTP id 5a478bee46e88-2b7ef8499d5mr3581505eec.41.1770087851435;
        Mon, 02 Feb 2026 19:04:11 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1adef97sm20980187eec.29.2026.02.02.19.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 19:04:10 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Qiliang Yuan <realwujing@gmail.com>,
	Ryan Newton <newton@meta.com>,
	David Dai <david.dai@linux.dev>,
	zhidao su <suzhidao@xiaomi.com>,
	Jake Hillion <jake@hillion.co.uk>
Cc: Qiliang Yuan <yuanql9@chinatelecom.cn>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/ext: Add cpumask to skip unsuitable dispatch queues
Date: Mon,  2 Feb 2026 22:03:46 -0500
Message-ID: <20260203030400.3313990-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a cpumask field to struct scx_dispatch_q to track the union of
allowed CPUs for all tasks in the queue. Use this mask to perform an
O(1) check in consume_dispatch_q() before scanning the queue.

When a CPU attempts to consume from a queue, it currently must iterate
through all N tasks to determine if any can run on that CPU. If the
queue contains only tasks pinned to other CPUs (via sched_setaffinity
or cgroups), this O(N) scan finds nothing.

With the cpumask, if the current CPU is not in the allowed set, skip
the entire queue immediately with a single bit test. This changes the
"queue is unsuitable" case from O(N) to O(1).

The mask is updated when tasks are enqueued and cleared when the queue
becomes empty, preventing permanent saturation from transient pinned
tasks.

This benefits large systems with CPU-pinned workloads, where CPUs
frequently scan queues containing no eligible tasks.

Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 include/linux/sched/ext.h |  1 +
 kernel/sched/ext.c        | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

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
index afe28c04d5aa..5a060c97cd64 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1120,8 +1120,12 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 
 	if (is_local)
 		local_dsq_post_enq(dsq, p, enq_flags);
-	else
+	else {
+		/* Update cpumask to track union of all tasks' allowed CPUs */
+		if (dsq->cpus_allowed)
+			cpumask_or(dsq->cpus_allowed, dsq->cpus_allowed, p->cpus_ptr);
 		raw_spin_unlock(&dsq->lock);
+	}
 }
 
 static void task_unlink_from_dsq(struct task_struct *p,
@@ -1138,6 +1142,10 @@ static void task_unlink_from_dsq(struct task_struct *p,
 	list_del_init(&p->scx.dsq_list.node);
 	dsq_mod_nr(dsq, -1);
 
+	/* Clear cpumask when queue becomes empty to prevent saturation */
+	if (dsq->nr == 0 && dsq->cpus_allowed)
+		cpumask_clear(dsq->cpus_allowed);
+
 	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN) && dsq->first_task == p) {
 		struct task_struct *first_task;
 
@@ -1897,6 +1905,14 @@ static bool consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
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
@@ -3397,6 +3413,9 @@ static void init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id)
 	raw_spin_lock_init(&dsq->lock);
 	INIT_LIST_HEAD(&dsq->list);
 	dsq->id = dsq_id;
+	
+	/* Allocate cpumask for tracking allowed CPUs */
+	dsq->cpus_allowed = kzalloc(cpumask_size(), GFP_KERNEL);
 }
 
 static void free_dsq_irq_workfn(struct irq_work *irq_work)
-- 
2.51.0

