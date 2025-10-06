Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13572222AC
	for <sched-ext@lists.linux.dev>; Mon,  6 Oct 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770255; cv=none; b=QBjuTImRFKubyznPDer/ID9/sJPxa1lsbtCaTnHuxmJK72gRn7shz/9ByPBF+dKD+/6A9s52QFNJ1/ldH733/to+aZu0ghjAzK7DFG9hMcv/y16VD3yDAYuMmFN/xgd9owFtPE6ufgjdSfoSjvyGVkwKntoNiYGbMDraiRiN9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770255; c=relaxed/simple;
	bh=WSOhLCP47bTTI2G1Dx59qp5+Llml7tOV3z6rZZ0BA6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7Gahney4YgnHATdNlroW69Tejc7RihoPzJc8bIZHskEW//vUdxKPf3IqnW+6JN/h849rx22/zVv7ql+ZNdJUFXSnAXMxYeJLyqbUXl7q1q2OfSZRXbLzzCB4G1++9RBq3LR02kG7uObgW9RaZlgd7IOc5TKcQPx7M4k9u01Kv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7nOMV7p; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7nOMV7p"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-917be46c59bso471277039f.1
        for <sched-ext@lists.linux.dev>; Mon, 06 Oct 2025 10:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759770252; x=1760375052; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP5lbLel6FeQQkI2Vhrf17nln8NYIgCIUzjg9SwJbmA=;
        b=e7nOMV7pFFas5hkE0/1Fq9XAEL3AxtcNMwm8T/cKAMPA9iaTVyGZHaLB1RdFfgZpN0
         btLqFXBCcFqHD2fUtuTgMk+c2jDHlB8ad4jkEJRh/vlDEslSYJeObSwX+w8qfAqFpGqL
         lea0pFBythQdeBX2GCMO3TdT3z0RczA1PyKOpWn3tXkeQ1F3Le3zaGeE5SyY7WvDP7Z8
         4Qe9dRFKq9+sOj3wHTn9hlrBmCXDOITyd6YXCHX1U8giJrG7c3TBz8OSPNJyHoGWvQwc
         qby8uifjBkY/AMCY6YQviFUmOtSMCzai0LzcknybXKqBy+8bUBc8E6be1xZWJV0HHOg9
         J47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759770252; x=1760375052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hP5lbLel6FeQQkI2Vhrf17nln8NYIgCIUzjg9SwJbmA=;
        b=T5cVowkCD/mT2PsyA7Hg4LaDdY0SSiMaFr7rC3aW1/ne4UI9IKyVPbzUwq9QoJcWFX
         khlQ3GAF179RcQ60eg4WJ1VDzFBrjnbfkV+68mYW26mMsi11y0BbxrHIpHysjBdwHu7O
         TBzGsJL9VdjM2e9fr+n1VtxvnbrETagjm1cXneHzzZdDuv5ZkOxDvqoz0yoSPGDF9pxj
         r2v48tPtG67C6JqSFpFalviF/H21swMEn5oTejppA97kclscCVirl2yi4wpOH0lm+ZmT
         LImUdlJe1wkDQ/BsPTyJZPIR/d+SEzobkry7xhwKSehfjEUo/44UExAUDB/lRFbzw8wz
         FL1w==
X-Gm-Message-State: AOJu0YwUGqxfpI+P+H3wCGcYaxjeHeLgWyqijLmbCK7Pc2ZDrVXIXcN9
	2XvowQBp8yAZ5d58BXBVo7PpW0neTrHpPAETVc50ciqTwvZF6s/btjrY
X-Gm-Gg: ASbGncuLxSD6FA9j/WGAuStp82obIdG9mCcoHNHUR8sPFKlk+SsEFYACGPGN+b1UISl
	vYujGkNr6kX+LkAF209vift114bEkBDOyiIQmHDMr0cwmdZ0HhFvAwWHoZfCdtUHY4xZaciJw2Y
	BuY/sD7mq3QDjH5NQ7mIj7Lb5j3M8uTlm8vsGQKfJ1Ryyakbv3K74bmmuHgoy+lj76ZvdfTgWj6
	UTAZXwyjd/v5WaHbtHQJ9wig8ylS/x1PcQkzIxTxSRvoTkWWi6IXD7azZpfaVspn4Vq45qEIgZW
	ns265vr6LjCuORvd51fJPTA2rJaOANuIa+VaJS2JSk/+6NY+QvwFuj17MPFSRnEmGGULsUdY5Gv
	GNWUSWYTBXYStJehu6DfTfw2i65TRJbJsuM6F6Uwqiv7ph9b+cpzHw3ZDmbAD3a5U8ddzjCxpg7
	G+9O6+wP8vw2Ci0ejaKCmDLYEJjMmnsNubTeM+pANYqce3E6F1gXIRoMnK
X-Google-Smtp-Source: AGHT+IHtXrzkafzb/xJHKEdIZvSUMa4i5nvKxN/qFCoBRPJYFlRlsqk1i6a2OetdRygINP8sROrbkw==
X-Received: by 2002:a05:6602:740e:b0:937:6516:62e9 with SMTP id ca18e2360f4ac-93b96a4fba2mr1685764439f.9.1759770251943;
        Mon, 06 Oct 2025 10:04:11 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a87bb84b4sm488589539f.18.2025.10.06.10.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:04:11 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev,
	tj@kernel.org,
	arighi@nvidia.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v3 1/2] sched_ext: Add lockless peek operation for DSQs
Date: Mon,  6 Oct 2025 13:04:02 -0400
Message-ID: <20251006170403.3584204-2-rrnewton@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006170403.3584204-1-rrnewton@gmail.com>
References: <20251006170403.3584204-1-rrnewton@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Newton <newton@meta.com>

The builtin DSQ queue data structures are meant to be used by a wide
range of different sched_ext schedulers with different demands on these
data structures. They might be per-cpu with low-contention, or
high-contention shared queues. Unfortunately, DSQs have a coarse-grained
lock around the whole data structure. Without going all the way to a
lock-free, more scalable implementation, a small step we can take to
reduce lock contention is to allow a lockless, small-fixed-cost peek at
the head of the queue.

This change allows certain custom SCX schedulers to cheaply peek at
queues, e.g. during load balancing, before locking them. But it
represents a few extra memory operations to update the pointer each
time the DSQ is modified, including a memory barrier on ARM so the write
appears correctly ordered.

This commit adds a first_task pointer field which is updated
atomically when the DSQ is modified, and allows any thread to peek at
the head of the queue without holding the lock.

Signed-off-by: Ryan Newton <newton@meta.com>
---
 include/linux/sched/ext.h                |  1 +
 kernel/sched/ext.c                       | 54 +++++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 tools/sched_ext/include/scx/compat.bpf.h | 19 +++++++++
 4 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index d82b7a9b0658..81478d4ae782 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -58,6 +58,7 @@ enum scx_dsq_id_flags {
  */
 struct scx_dispatch_q {
 	raw_spinlock_t		lock;
+	struct task_struct __rcu *first_task; /* lockless peek at head */
 	struct list_head	list;	/* tasks in dispatch order */
 	struct rb_root		priq;	/* used to order by p->scx.dsq_vtime */
 	u32			nr;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2b0e88206d07..6d3537e65001 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -944,8 +944,11 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 				container_of(rbp, struct task_struct,
 					     scx.dsq_priq);
 			list_add(&p->scx.dsq_list.node, &prev->scx.dsq_list.node);
+			/* first task unchanged - no update needed */
 		} else {
 			list_add(&p->scx.dsq_list.node, &dsq->list);
+			/* not builtin and new task is at head - use fastpath */
+			rcu_assign_pointer(dsq->first_task, p);
 		}
 	} else {
 		/* a FIFO DSQ shouldn't be using PRIQ enqueuing */
@@ -953,10 +956,19 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			scx_error(sch, "DSQ ID 0x%016llx already had PRIQ-enqueued tasks",
 				  dsq->id);
 
-		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
+		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT)) {
 			list_add(&p->scx.dsq_list.node, &dsq->list);
-		else
+			/* new task inserted at head - use fastpath */
+			if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN))
+				rcu_assign_pointer(dsq->first_task, p);
+		} else {
+			bool was_empty;
+
+			was_empty = list_empty(&dsq->list);
 			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
+			if (was_empty && !(dsq->id & SCX_DSQ_FLAG_BUILTIN))
+				rcu_assign_pointer(dsq->first_task, p);
+		}
 	}
 
 	/* seq records the order tasks are queued, used by BPF DSQ iterator */
@@ -1011,6 +1023,13 @@ static void task_unlink_from_dsq(struct task_struct *p,
 		p->scx.dsq_flags &= ~SCX_TASK_DSQ_ON_PRIQ;
 	}
 
+	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN) && dsq->first_task == p) {
+		struct task_struct *first_task;
+
+		first_task = nldsq_next_task(dsq, NULL, false);
+		rcu_assign_pointer(dsq->first_task, first_task);
+	}
+
 	list_del_init(&p->scx.dsq_list.node);
 	dsq_mod_nr(dsq, -1);
 }
@@ -6084,6 +6103,36 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
 	kit->dsq = NULL;
 }
 
+/**
+ * scx_bpf_dsq_peek - Lockless peek at the first element.
+ * @dsq_id: DSQ to examine.
+ *
+ * Read the first element in the DSQ. This is semantically equivalent to using
+ * the DSQ iterator, but is lockfree.
+ *
+ * Returns the pointer, or NULL indicates an empty queue OR internal error.
+ */
+__bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
+{
+	struct scx_sched *sch;
+	struct scx_dispatch_q *dsq;
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return NULL;
+	if (unlikely(dsq_id & SCX_DSQ_FLAG_BUILTIN)) {
+		scx_error(sch, "peek disallowed on builtin DSQ 0x%llx", dsq_id);
+		return NULL;
+	}
+
+	dsq = find_user_dsq(sch, dsq_id);
+	if (unlikely(!dsq)) {
+		scx_error(sch, "peek on non-existent DSQ 0x%llx", dsq_id);
+		return NULL;
+	}
+	return rcu_dereference(dsq->first_task);
+}
+
 __bpf_kfunc_end_defs();
 
 static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
@@ -6641,6 +6690,7 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
+BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_RCU_PROTECTED | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 06e2551033cb..fbf3e7f9526c 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -75,6 +75,7 @@ u32 scx_bpf_reenqueue_local(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
+struct task_struct *scx_bpf_dsq_peek(u64 dsq_id) __ksym __weak;
 int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
 struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
 void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index dd9144624dc9..97b10c184b2c 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -130,6 +130,25 @@ int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym
 	false;									\
 })
 
+
+/*
+ * v6.19: Introduce lockless peek API for user DSQs.
+ *
+ * Preserve the following macro until v6.21.
+ */
+static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id)
+{
+	struct task_struct *p = NULL;
+	struct bpf_iter_scx_dsq it;
+
+	if (bpf_ksym_exists(scx_bpf_dsq_peek))
+		return scx_bpf_dsq_peek(dsq_id);
+	if (!bpf_iter_scx_dsq_new(&it, dsq_id, 0))
+		p = bpf_iter_scx_dsq_next(&it);
+	bpf_iter_scx_dsq_destroy(&it);
+	return p;
+}
+
 /**
  * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
  * in a compatible way. We will preserve this __COMPAT helper until v6.16.
-- 
2.51.0

