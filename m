Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833A0308F32
	for <sched-ext@lists.linux.dev>; Wed, 15 Oct 2025 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493447; cv=none; b=YIreTrguyA4AFdtJBkmcQ9orZGi9KJu9poCfsUwM5C1CctBz/71D3XTRJVyExJHqzsR/vLmtzPrbe3rsU2U08Z/YoUCkPel50+ibIJUFLZIaE3p9JXwbAr92nMLo/+bFg3r3++8kXhU224Xka0Ur8r0KM1aCDlsv1FqL9NaXT18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493447; c=relaxed/simple;
	bh=AGVEwgAxw9PZ3K0QB6om9+1OxXQU5jAObifyBN7dCHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGezyulONzhNge3TvenErPCSLlXJWGqHpLHQqz4v4okeafIVqTBjFCMZCyIny6wsrgmuUuOmFY55vToEew3NOZHgoHn8Llnbb2mDmgKxviS1hKAnXlHcd9dGRsHyLRVy7PN2qNz+xyHMBc+OoMVcP8/g3O2tyqBx+dJ9h8QcU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j26h5dhv; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j26h5dhv"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-93b9022d037so247034239f.2
        for <sched-ext@lists.linux.dev>; Tue, 14 Oct 2025 18:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760493444; x=1761098244; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18Hn4CAq2FpBNTkC8INCXhCkdRwJu5aFP3uAHNnh2tg=;
        b=j26h5dhvfIJgIjkf1ZX9wnK/rV7HisuTJwNjnIa2+5yh/3vrciBuE0xHZ5zWw+Y0EW
         5/Wfw74TjjPC5jnlAJVDwnzgcYz6Bu59IWip3Nv4OLBlhHU7gLSW362qDpbfvyM2hkws
         PxQd47b79pfu4FGW/FqCIRQXAlyKZYopBcswOOuUiPe/T0Iv8q/GhIn/r77C84b6NDZ3
         ZHKPJ/JRjYW3Uc8z1BFLQXUzJ+H2kTJWdPle0rDNURltMMLVrbdhpQZljkmGY+rXhmaI
         lWamT/9SzWQm4jHeofJKMkpdkLc5sa4jSnJSaiIommlHy0Ew7FMLFMKMfbWEipk5FW+v
         F5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493444; x=1761098244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18Hn4CAq2FpBNTkC8INCXhCkdRwJu5aFP3uAHNnh2tg=;
        b=GKPob4YVQldS1P6ES+SnN3owNsFR1Loqls29gPtQ0PwmHaRamgeJ4g1WHHe5t+l6Ar
         SL+iKMb2XfkLRKsnsRtAvnKTcvxEXKkXSw4xP6xfvga2K8TYVpbfk+o0rrKSH0U0rn+0
         kp80FL5imo40/kzUPdU1K2A2HBPnqLJvAuPlUaFfVbHICfHLDh8QplzGd39i2QPIDkrY
         Icm8t298F4Gr0Rsnuo2K8euYdK9DWFn4ykznXplSy+KtFYBxeajLM6FNPII2YXadJYFA
         2GIfKHKy9ojk0ISFt3hPED7GOcj0K3qtVZfjvFt8fCEzldmIgQBFnBMR+p882+555L+a
         h3Kw==
X-Gm-Message-State: AOJu0YwbBI/WdOQgQ8Wz3GvQTU/KLUZWdmmTz81zQ1d/0PyMTGt8y9ox
	rxWRlnU9JID+9Xyg1pR6wgCaAUSo+gtdu2Y/RT+CCUc+hswtTTUAEW3n
X-Gm-Gg: ASbGncumXtoVzAgD7QjlAMSEZl5c2l2aXFXG8pUUbS+nMuKVuyZnrfXv9lf3Y2o0DTa
	II/0Ajw0NBX43Xml0vkKa5HvRX2SLsncvDKnJ02Ui0I09kxW1u3fqxKWMTbobIf7+7fKtVjV1kz
	7q3BReBXqJaQSt6Z45rENXc6g6hPvzs6xqJCsi7kLDESxeXlJhizcqsfziw5hMf7/6Cc4h+FvZ5
	tGD7oY+9/XvN/43wNQlTvlYr84uBJKvjPfMryTUJHeF7VCrjCvDljFMCYJ7VuCFUG/Lt50vflut
	JZsH/1JyHlHzisPn6fV1LIn74D786QIkn6Dj09T20GZFLuJ2R9HHNYmiC/XH8RGM28jw9k4MBCf
	aa+tJ0jBZymQjU8DW2Ho/HTkQOvDm27nCYvRnNCe9bKhxNE/dh+s5NS8+QRR5fa14x/XKwYo9Zq
	v+M9aDdZfcNl7nT38PFnMKJO865iyGdQkJsuKzTdmwVVanR9Bf86g=
X-Google-Smtp-Source: AGHT+IFPhZtdVdLJel3t88WCEO3asXsrDVJYl9mqICvuB+Hm3gN/emrZ2Z88Cw7UMZ50UMkXEpDZug==
X-Received: by 2002:a05:6602:6b12:b0:92e:298e:eeac with SMTP id ca18e2360f4ac-93bd1891211mr3135130739f.2.1760493444445;
        Tue, 14 Oct 2025 18:57:24 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c496ed8sm5254772173.13.2025.10.14.18.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:57:23 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev,
	tj@kernel.org,
	arighi@nvidia.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v4 1/2] sched_ext: Add lockless peek operation for DSQs
Date: Tue, 14 Oct 2025 21:57:11 -0400
Message-ID: <20251015015712.3996346-2-rrnewton@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015015712.3996346-1-rrnewton@gmail.com>
References: <20251015015712.3996346-1-rrnewton@gmail.com>
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
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                |  1 +
 kernel/sched/ext.c                       | 56 +++++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 tools/sched_ext/include/scx/compat.bpf.h | 18 ++++++++
 4 files changed, 74 insertions(+), 2 deletions(-)

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
index 4b1467d3541a..430eaa7cfbbe 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -965,8 +965,11 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
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
@@ -974,10 +977,19 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
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
@@ -1032,6 +1044,13 @@ static void task_unlink_from_dsq(struct task_struct *p,
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
@@ -6278,6 +6297,38 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
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
+
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
+
+	return rcu_dereference(dsq->first_task);
+}
+
 __bpf_kfunc_end_defs();
 
 static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
@@ -6837,6 +6888,7 @@ BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
+BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_RCU_PROTECTED | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index eb3c99445cb3..e65b1eb668ea 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -74,6 +74,7 @@ u32 scx_bpf_reenqueue_local(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
+struct task_struct *scx_bpf_dsq_peek(u64 dsq_id) __ksym __weak;
 int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
 struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
 void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index e487c10b5e07..619a16f0d39a 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -26,6 +26,24 @@ int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym
 	(bpf_ksym_exists(bpf_cpumask_populate) ?			\
 	 (bpf_cpumask_populate(cpumask, src, size__sz)) : -EOPNOTSUPP)
 
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

