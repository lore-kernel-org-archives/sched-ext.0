Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729B219CD03
	for <sched-ext@lists.linux.dev>; Thu,  8 Jan 2026 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767840209; cv=none; b=juBjsRVwkxbCpGmLtbw9hfqrtb3Kl+APjc4vSuYjCHhqQpGrQ53642eIfRP7sVTRhyNiARPkVR4ySNeXTT0hrDlER9HeAcJIAdO+yDHlrWoRGW251Yfm71n5oENIT3VvPGNHm3873hJZ0h72O5HT1QguoPIZB3O+UvAv6K/Q/yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767840209; c=relaxed/simple;
	bh=pV7nKUsmV0ycOI/J3NX0vIlJSSUJlDm8CIIePiC4f2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XLrVTMqUh6M1fdrIkrBrbUfBjc+8lrlsKajulHGwE0jqtY8J9dSLoqsw14T6PZZbLKrNlXdt6DIrDFVLSNA9m7szgjBbDAK8QJcUDrVDDWH2gqAJ4gr6bdT2A4I5PwWalpe2g1jkOA3apiym9LbWIWr2+56SE1vbtPcCpqq0YSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBD6L5B6; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBD6L5B6"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bcfd82f55ebso630660a12.1
        for <sched-ext@lists.linux.dev>; Wed, 07 Jan 2026 18:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767840207; x=1768445007; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1kcAJMO4egsMxZoR77v7VHbdTKin7I8kze8KTsR7pLU=;
        b=LBD6L5B6GJFaZa0we0P1zDFZMLwPL0BTqB/jjWDAgX8v5CIB3uc6rZtxJIdBCs5XwH
         V5HRfGbMcz+c3v+/VELa230sneWzzu4UXA/39mmbcOI7ENOxG2kOlnZJwi2de0lopr5G
         ccIWk8Gb4YVKlfKxqV1ETgpH5/svLuRqsyHDWnecDEBe5xlFjrgfaWhRSNPvDOXkG/rm
         R4q+tBb28yfNVYD7a20DmZiW7EkaTLlWJvBMyDVdmqUCAgDYFemfyXKxty6Fp7N0DJdJ
         d1CJkIlg5XXOm/PlmPgsY3SsfTT597FD4gKueuJp9GpAF+WqtkfH6lYUg18Ghw8npnqj
         MNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767840207; x=1768445007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kcAJMO4egsMxZoR77v7VHbdTKin7I8kze8KTsR7pLU=;
        b=K3VQgkRxPM6/z5FnB1mP6fuNcLfE3LaGOOnC1kRgbilcCaRWP6otd/cBGPpvvMl37G
         7mivuTMekwGklxP0HYc6acsnxsU2nugTLZ+U4tcMywecyxkWz/Nyucz2Lv8EFjcDGwF9
         2chgf6WdkS17JPUpaT6zT4oY9IrLdUci4LcCoHMpPsgrMHUyDvYsNTuQc87NsJ1E1Kv0
         LwGuepmE5VFxS7Wz0s9uNiKWdfq20UJkzbkPqH0xBAj3ikJATtzwj1HGzFB0kDpGbuBu
         vpC9SS3iYNZZzlO6EnuYWJ4SwUPan2btn7ZZ8JPSqg9/Lhr5PJqQvhyYjoEgxQMDuoG0
         0orQ==
X-Gm-Message-State: AOJu0YyESS7Bq0Ooc2u6e5nOxuI6HU4f/y5puAzMt44ywi9izwcji1wl
	gANsgKjIZx/DRU69V/QU1pjDIGTXzSCHcGj35sZ7ob0An1h1e1kiCpRO
X-Gm-Gg: AY/fxX4oIGaLnCbpcQo7Lia2/QvI59e4Cj/vFENq0o0G244W9yCqBnDjsbBhRjzA6rl
	hevADObwQS0fCh01LlSrn1qT1btb5hRM0U/kwe55zegG8yjO41sZvLBqIbAV5dThdYVlN6xztXH
	c995obTjrwU7It11Ns5bQWWHuq8Zx4PMV/TJKcXncsCGqfIOVJ2p9Mv/hIskADbep78zZRVvvuQ
	ee2DYm/7Os3V59C0xzBrdoJVy8+EG6lPE5KEqBd2GUgr1OuvRz2N/tqzevlpF6PMJkInrUH8Yoo
	jlTuURmTwLSYMNrVkbccten+ggxd6LxhglVlUBK10Zq9ksij5BIP/yAaRfZhBDim8t0QQEhH2iV
	y8Tkfu3rte966usMbgnDyE+judC4j16p86TYRNxqddn5pTaZaMgi15LGtBLZW8aAJm19UDVA8wa
	3lkUZ2vz7P1EvXZHWu69pYdDFcYzlK8z4+daU2DiQ2G0wP2O1WxXd10k0t9tYBiA==
X-Google-Smtp-Source: AGHT+IHEzq6SUR5Cuv7HfTy1t8yQHzRRNY7b6h/ul0CSCb5+Uy4M3ZeCnFTcc3IEYq3sFElKVS1QEA==
X-Received: by 2002:a17:902:da8f:b0:2a0:c92e:a378 with SMTP id d9443c01a7336-2a3edb24516mr45800115ad.7.1767840206551;
        Wed, 07 Jan 2026 18:43:26 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc8ddfsm61676225ad.74.2026.01.07.18.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:43:26 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] sched_ext: Add DSQ statistics collection functionality
Date: Thu,  8 Jan 2026 10:35:54 +0800
Message-ID: <20260108023554.1735052-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds statistics collection to the Dispatch Queue (DSQ) system in
the sched_ext scheduler. Statistics tracked:

1. Total enqueue count (number of tasks enqueued to a DSQ)
2. Total dequeue count (number of tasks dequeued from a DSQ)
3. Peak queue length (maximum number of tasks simultaneously queued)

New BPF interface functions:
- scx_bpf_dsq_enqueue_count(dsq_id): Get total enqueue count
- scx_bpf_dsq_dequeue_count(dsq_id): Get total dequeue count
- scx_bpf_dsq_peak_nr(dsq_id): Get peak queue length

Implementation uses atomic operations for concurrency safety and follows
existing kernel patterns for statistics collection. Compatibility macros
are provided in compat.bpf.h for backward compatibility.

A comprehensive test case (dsq_stats) is included to verify functionality.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 include/linux/sched/ext.h                     |   6 +
 kernel/sched/ext.c                            | 156 +++++++++++++++++-
 tools/sched_ext/include/scx/compat.bpf.h      |  17 ++
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/dsq_stats.bpf.c       | 101 ++++++++++++
 tools/testing/selftests/sched_ext/dsq_stats.c | 147 +++++++++++++++++
 6 files changed, 427 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/sched_ext/dsq_stats.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dsq_stats.c

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index bcb962d5ee7d..b79bedc26388 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -13,6 +13,7 @@
 
 #include <linux/llist.h>
 #include <linux/rhashtable-types.h>
+#include <linux/atomic.h>
 
 enum scx_public_consts {
 	SCX_OPS_NAME_LEN	= 128,
@@ -79,6 +80,11 @@ struct scx_dispatch_q {
 	struct rhash_head	hash_node;
 	struct llist_node	free_node;
 	struct rcu_head		rcu;
+
+	/* Statistics fields */
+	atomic64_t		enqueue_count;
+	atomic64_t		dequeue_count;
+	atomic_t		peak_nr;
 };
 
 /* scx_entity.flags */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 136b01950a62..a025d68acdef 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -972,8 +972,20 @@ static bool scx_dsq_priq_less(struct rb_node *node_a,
 
 static void dsq_mod_nr(struct scx_dispatch_q *dsq, s32 delta)
 {
+	u32 new_nr;
+
 	/* scx_bpf_dsq_nr_queued() reads ->nr without locking, use WRITE_ONCE() */
-	WRITE_ONCE(dsq->nr, dsq->nr + delta);
+	new_nr = dsq->nr + delta;
+	WRITE_ONCE(dsq->nr, new_nr);
+
+	/* Update peak queue length */
+	if (delta > 0) {
+
+		u32 peak = atomic_read(&dsq->peak_nr);
+
+		if (new_nr > peak)
+			atomic_set(&dsq->peak_nr, new_nr);
+	}
 }
 
 static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
@@ -1099,6 +1111,7 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 	p->scx.dsq_seq = dsq->seq;
 
 	dsq_mod_nr(dsq, 1);
+	atomic64_inc(&dsq->enqueue_count);  /* Increment enqueue count */
 	p->scx.dsq = dsq;
 
 	/*
@@ -1136,6 +1149,7 @@ static void task_unlink_from_dsq(struct task_struct *p,
 
 	list_del_init(&p->scx.dsq_list.node);
 	dsq_mod_nr(dsq, -1);
+	atomic64_inc(&dsq->dequeue_count);  /* Increment dequeue count */
 
 	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN) && dsq->first_task == p) {
 		struct task_struct *first_task;
@@ -3396,6 +3410,11 @@ static void init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id)
 	raw_spin_lock_init(&dsq->lock);
 	INIT_LIST_HEAD(&dsq->list);
 	dsq->id = dsq_id;
+
+	/* Initialize statistics */
+	atomic64_set(&dsq->enqueue_count, 0);
+	atomic64_set(&dsq->dequeue_count, 0);
+	atomic_set(&dsq->peak_nr, 0);
 }
 
 static void free_dsq_irq_workfn(struct irq_work *irq_work)
@@ -6476,6 +6495,138 @@ __bpf_kfunc s32 scx_bpf_dsq_nr_queued(u64 dsq_id)
 	return ret;
 }
 
+/**
+ * scx_bpf_dsq_enqueue_count - Return the total number of enqueued tasks
+ * @dsq_id: id of the DSQ
+ *
+ * Return the total number of tasks that have been enqueued to the DSQ
+ * matching @dsq_id. If not found, -%ENOENT is returned.
+ */
+__bpf_kfunc s64 scx_bpf_dsq_enqueue_count(u64 dsq_id)
+{
+	struct scx_sched *sch;
+	struct scx_dispatch_q *dsq;
+	s64 ret;
+
+	preempt_disable();
+
+	sch = rcu_dereference_sched(scx_root);
+	if (unlikely(!sch)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (dsq_id == SCX_DSQ_LOCAL) {
+		ret = atomic64_read(&this_rq()->scx.local_dsq.enqueue_count);
+		goto out;
+	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
+		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
+
+		if (ops_cpu_valid(sch, cpu, NULL)) {
+			ret = atomic64_read(&cpu_rq(cpu)->scx.local_dsq.enqueue_count);
+			goto out;
+		}
+	} else {
+		dsq = find_user_dsq(sch, dsq_id);
+		if (dsq) {
+			ret = atomic64_read(&dsq->enqueue_count);
+			goto out;
+		}
+	}
+	ret = -ENOENT;
+out:
+	preempt_enable();
+	return ret;
+}
+
+/**
+ * scx_bpf_dsq_dequeue_count - Return the total number of dequeued tasks
+ * @dsq_id: id of the DSQ
+ *
+ * Return the total number of tasks that have been dequeued from the DSQ
+ * matching @dsq_id. If not found, -%ENOENT is returned.
+ */
+__bpf_kfunc s64 scx_bpf_dsq_dequeue_count(u64 dsq_id)
+{
+	struct scx_sched *sch;
+	struct scx_dispatch_q *dsq;
+	s64 ret;
+
+	preempt_disable();
+
+	sch = rcu_dereference_sched(scx_root);
+	if (unlikely(!sch)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (dsq_id == SCX_DSQ_LOCAL) {
+		ret = atomic64_read(&this_rq()->scx.local_dsq.dequeue_count);
+		goto out;
+	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
+		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
+
+		if (ops_cpu_valid(sch, cpu, NULL)) {
+			ret = atomic64_read(&cpu_rq(cpu)->scx.local_dsq.dequeue_count);
+			goto out;
+		}
+	} else {
+		dsq = find_user_dsq(sch, dsq_id);
+		if (dsq) {
+			ret = atomic64_read(&dsq->dequeue_count);
+			goto out;
+		}
+	}
+	ret = -ENOENT;
+out:
+	preempt_enable();
+	return ret;
+}
+
+/**
+ * scx_bpf_dsq_peak_nr - Return the peak number of queued tasks
+ * @dsq_id: id of the DSQ
+ *
+ * Return the peak number of tasks that have been simultaneously queued in
+ * the DSQ matching @dsq_id. If not found, -%ENOENT is returned.
+ */
+__bpf_kfunc s32 scx_bpf_dsq_peak_nr(u64 dsq_id)
+{
+	struct scx_sched *sch;
+	struct scx_dispatch_q *dsq;
+	s32 ret;
+
+	preempt_disable();
+
+	sch = rcu_dereference_sched(scx_root);
+	if (unlikely(!sch)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (dsq_id == SCX_DSQ_LOCAL) {
+		ret = atomic_read(&this_rq()->scx.local_dsq.peak_nr);
+		goto out;
+	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
+		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
+
+		if (ops_cpu_valid(sch, cpu, NULL)) {
+			ret = atomic_read(&cpu_rq(cpu)->scx.local_dsq.peak_nr);
+			goto out;
+		}
+	} else {
+		dsq = find_user_dsq(sch, dsq_id);
+		if (dsq) {
+			ret = atomic_read(&dsq->peak_nr);
+			goto out;
+		}
+	}
+	ret = -ENOENT;
+out:
+	preempt_enable();
+	return ret;
+}
+
 /**
  * scx_bpf_destroy_dsq - Destroy a custom DSQ
  * @dsq_id: DSQ to destroy
@@ -7221,6 +7372,9 @@ BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
+BTF_ID_FLAGS(func, scx_bpf_dsq_enqueue_count)
+BTF_ID_FLAGS(func, scx_bpf_dsq_dequeue_count)
+BTF_ID_FLAGS(func, scx_bpf_dsq_peak_nr)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
 BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_RCU_PROTECTED | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index f2969c3061a7..8222ef8055df 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -375,6 +375,23 @@ static inline void scx_bpf_reenqueue_local(void)
 		scx_bpf_reenqueue_local___v1();
 }
 
+/*
+ * v6.20: Add DSQ statistics functions.
+ *
+ * Preserve the following macros until v6.22.
+ */
+#define __COMPAT_scx_bpf_dsq_enqueue_count(dsq_id)		\
+	(bpf_ksym_exists(scx_bpf_dsq_enqueue_count) ?		\
+	 scx_bpf_dsq_enqueue_count(dsq_id) : -ENOENT)
+
+#define __COMPAT_scx_bpf_dsq_dequeue_count(dsq_id)		\
+	(bpf_ksym_exists(scx_bpf_dsq_dequeue_count) ?		\
+	 scx_bpf_dsq_dequeue_count(dsq_id) : -ENOENT)
+
+#define __COMPAT_scx_bpf_dsq_peak_nr(dsq_id)			\
+	(bpf_ksym_exists(scx_bpf_dsq_peak_nr) ?			\
+	 scx_bpf_dsq_peak_nr(dsq_id) : -ENOENT)
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5fe45f9c5f8f..546534159d74 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -161,6 +161,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
 
 auto-test-targets :=			\
 	create_dsq			\
+	dsq_stats			\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
diff --git a/tools/testing/selftests/sched_ext/dsq_stats.bpf.c b/tools/testing/selftests/sched_ext/dsq_stats.bpf.c
new file mode 100644
index 000000000000..bd3f8ac78456
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dsq_stats.bpf.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A BPF program for testing DSQ statistics functionality.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ */
+
+#include <scx/common.bpf.h>
+#include <scx/compat.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei); /* Error handling */
+
+#define TEST_DSQ_ID 1234
+
+/* Test variables to store results */
+s64 test_enqueue_count = -1;
+s64 test_dequeue_count = -1;
+s32 test_peak_nr = -1;
+s32 current_nr = -1;
+
+/* Test completion flag */
+int test_completed;
+
+/* Test task */
+int test_pid = -1;
+
+static void test_dsq_stats(void)
+{
+	s64 enqueue_count, dequeue_count;
+	s32 peak_nr, nr;
+
+	/* Test the new statistics functions */
+	enqueue_count = __COMPAT_scx_bpf_dsq_enqueue_count(TEST_DSQ_ID);
+	dequeue_count = __COMPAT_scx_bpf_dsq_dequeue_count(TEST_DSQ_ID);
+	peak_nr = __COMPAT_scx_bpf_dsq_peak_nr(TEST_DSQ_ID);
+	nr = scx_bpf_dsq_nr_queued(TEST_DSQ_ID);
+
+	/* Store results */
+	test_enqueue_count = enqueue_count;
+	test_dequeue_count = dequeue_count;
+	test_peak_nr = peak_nr;
+	current_nr = nr;
+
+	test_completed = 1;
+}
+
+void BPF_STRUCT_OPS(dsq_stats_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	/* Create DSQ on first task */
+	if (test_pid == -1) {
+		test_pid = p->pid;
+
+		/* Create test DSQ */
+		if (scx_bpf_create_dsq(TEST_DSQ_ID, -1)) {
+			bpf_printk("Failed to create test DSQ\n");
+			return;
+		}
+
+		/* Insert task into DSQ to test statistics */
+		scx_bpf_dsq_insert(p, TEST_DSQ_ID, 0, enq_flags);
+	}
+}
+
+void BPF_STRUCT_OPS(dsq_stats_dispatch, s32 cpu, struct task_struct *prev)
+{
+	/* Run test if not completed */
+	if (!test_completed && test_pid != -1) {
+		test_dsq_stats();
+
+		/* Consume the task to complete the test */
+		scx_bpf_dsq_move_to_local(TEST_DSQ_ID);
+	}
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(dsq_stats_init)
+{
+	/* Initialize test variables */
+	test_pid = -1;
+	test_completed = 0;
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(dsq_stats_exit, struct scx_exit_info *ei)
+{
+	/* Destroy test DSQ */
+	scx_bpf_destroy_dsq(TEST_DSQ_ID);
+
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops dsq_stats_ops = {
+	.enqueue = (void *)dsq_stats_enqueue,
+	.dispatch = (void *)dsq_stats_dispatch,
+	.init = (void *)dsq_stats_init,
+	.exit = (void *)dsq_stats_exit,
+	.name = "dsq_stats",
+};
diff --git a/tools/testing/selftests/sched_ext/dsq_stats.c b/tools/testing/selftests/sched_ext/dsq_stats.c
new file mode 100644
index 000000000000..b54912a0d2ca
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dsq_stats.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test for DSQ statistics functionality.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <string.h>
+#include <sched.h>
+#include "dsq_stats.bpf.skel.h"
+#include "scx_test.h"
+
+#define NUM_WORKERS 2
+
+static bool workload_running = true;
+static pthread_t workload_threads[NUM_WORKERS];
+
+/**
+ * Background workload thread that exercises the scheduler to trigger
+ * DSQ operations and statistics collection.
+ */
+static void *workload_thread_fn(void *arg)
+{
+	while (workload_running) {
+		/* Sleep for a very short time to trigger scheduler activity */
+		usleep(1000); /* 1ms sleep */
+		/* Yield to ensure we go through the scheduler */
+		sched_yield();
+	}
+	return NULL;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct dsq_stats *skel;
+	int i, ret;
+
+	skel = dsq_stats__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(dsq_stats__load(skel), "Failed to load skel");
+
+	/* Start background workload threads */
+	for (i = 0; i < NUM_WORKERS; i++) {
+		ret = pthread_create(&workload_threads[i], NULL, workload_thread_fn, NULL);
+		SCX_FAIL_IF(ret, "Failed to create workload thread %d", i);
+	}
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct dsq_stats *skel = ctx;
+	struct bpf_link *link;
+	int duration = 2; /* Run test for 2 seconds */
+
+	link = bpf_map__attach_struct_ops(skel->maps.dsq_stats_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	/* Let the scheduler run for a while to collect statistics */
+	sleep(duration);
+
+	workload_running = false;
+
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status check_results(void *ctx)
+{
+	struct dsq_stats *skel = ctx;
+
+	/* Wait for test to complete */
+	int timeout = 50; /* 5 seconds timeout */
+
+	while (!skel->bss->test_completed && timeout > 0) {
+		usleep(100000); /* 100ms */
+		timeout--;
+	}
+
+	SCX_FAIL_IF(timeout <= 0, "Test timed out waiting for completion");
+
+	/* Check that statistics were collected */
+	SCX_FAIL_IF(skel->bss->test_enqueue_count < 0,
+		   "Enqueue count not collected: %lld",
+		   (long long)skel->bss->test_enqueue_count);
+
+	SCX_FAIL_IF(skel->bss->test_dequeue_count < 0,
+		   "Dequeue count not collected: %lld",
+		   (long long)skel->bss->test_dequeue_count);
+
+	SCX_FAIL_IF(skel->bss->test_peak_nr < 0,
+		   "Peak NR not collected: %d",
+		   skel->bss->test_peak_nr);
+
+	/* Basic sanity checks */
+	SCX_FAIL_IF(skel->bss->test_enqueue_count != skel->bss->test_dequeue_count,
+		   "Enqueue count (%lld) != Dequeue count (%lld)",
+		   (long long)skel->bss->test_enqueue_count,
+		   (long long)skel->bss->test_dequeue_count);
+
+	SCX_FAIL_IF(skel->bss->test_peak_nr < skel->bss->current_nr,
+		   "Peak NR (%d) < Current NR (%d)",
+		   skel->bss->test_peak_nr, skel->bss->current_nr);
+
+	bpf_printk("DSQ Stats Test Results:\n");
+	bpf_printk("  Enqueue Count: %lld\n", (long long)skel->bss->test_enqueue_count);
+	bpf_printk("  Dequeue Count: %lld\n", (long long)skel->bss->test_dequeue_count);
+	bpf_printk("  Peak NR: %d\n", skel->bss->test_peak_nr);
+	bpf_printk("  Current NR: %d\n", skel->bss->current_nr);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct dsq_stats *skel = ctx;
+	int i;
+
+	/* Stop workload threads */
+	workload_running = false;
+	for (i = 0; i < NUM_WORKERS; i++) {
+		if (workload_threads[i])
+			pthread_join(workload_threads[i], NULL);
+	}
+
+	dsq_stats__destroy(skel);
+}
+
+struct scx_test dsq_stats = {
+	.name = "dsq_stats",
+	.description = "Test DSQ statistics functionality",
+	.setup = setup,
+	.run = run,
+	.check_results = check_results,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&dsq_stats)
-- 
2.43.0

