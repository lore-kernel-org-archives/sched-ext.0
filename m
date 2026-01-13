Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B131065A
	for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322910; cv=none; b=co8f3PhdUoxQadToXOj7u9iPFwHQcu9fCO7iLsPfWmg9ztrlulKMlTRG6cEm8710Dj+WogvgOHauK0BCsGf9SAV0ytLnfcXHi85cKpkdcYdxvgHgjzGXfiASElKv2C/8dwHfzAaWy6CtEvOvkVpleP8EJXIbS1vYy2qj5Fuz6HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322910; c=relaxed/simple;
	bh=xWW41ahJ93zGLGN3YJ+nUO6Y/88kEFyoiW1IbWShCZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoC8mSEkEnLcY/xTS1JXxTceKorNk1KcaJznJWEV27GEwnAbvpfECJ7S5nt/0iWj9BnSmlEMJBpleet2UxACOIjIWKbDLz+yJczDoJAKyiKL0rxGVUiQ3JzSQRYl3UiHt5HeQL/zOx75xv3WpFaA3LhI8LnnNC4blA8sUf7Neow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=CcPh5zsK; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="CcPh5zsK"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8be92e393f8so708167185a.1
        for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 08:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1768322907; x=1768927707; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23Mp1G0k6gFFkMQeVZTK7HrAwlwPCYNZnXTR4dkkjYM=;
        b=CcPh5zsKTF1k0I926WffqIVWcPPlzRa+iiikcfOpxCTAUYleNQrWkRx+KCcNbtt+tL
         Olw9xsESYnB4OGRmelwyDKj2LlT0RxmzFv0R7NtF7k77/AgRd+8HY1r81nQnqx1gN7sn
         DLLvAlS1IROwyKrIdOFnG9HBoWIbR1pdXvK7YFxZyrKbiqe34yRgDTfQqiD757sybfmC
         /qn1ZeysZGky2wpD0hwfveQcIrp5OQjiNe+H9FiTmTGDv07dZA4/eAyJihT8fcB6R7NW
         mQe3NmLgOPci74NDivZVnh1Ip7/BiIZ6cN7AAvNn4FS1yybPi/WU6quNv8ZVGpcvH6vJ
         RrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768322907; x=1768927707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=23Mp1G0k6gFFkMQeVZTK7HrAwlwPCYNZnXTR4dkkjYM=;
        b=Vz0O2+Ui8xjDwDpAJymLiR1v/sJ7bP0LVLA5ypQIQUx5bpXE7wuPKS35EbTj8F7+si
         DSLG+6KHpV0K/+mRbSvU7NFg56kw3t/UU3/7TjFQh6VRfxkSxwYNKqIzBBuWducZ1JAR
         rIM1prBprAxkDYo7rFjmz/jqFV5K+erxM7G3jX4JNkCLmF3hPbn5ms+3b/28lnPkBmOD
         ihCQ27YegyMh5xfeiBECUxoXS+iALpJ4jiPpNXjfSkPu95JyUHk0ePkybkjMMvDiAnET
         YSSfwiSToAPFSepgnXYVLdsxRthHlLlYt4WZgjlw7GbIs8x4DuzFUjywAuZPJL1/1G8c
         VpiA==
X-Gm-Message-State: AOJu0Yw6ujoBreBn4OPyJ8tkrMcFEXBHocbDlA7YojSNi5YdZ1uxVdox
	nIP53GXJX06n0AImip9G5Uk6z94DeQqsGEUqVsWauUZOrenr7B3AHmWBb92uVq7xzHpixBmebvQ
	L08imylE=
X-Gm-Gg: AY/fxX7UXEvVFDZcoCj44XwR8j/P1QQOj7zxK3/Lil150BOdCtwKJfOrBUL4cQ3Q5La
	HvtBZFhnEF95nXOg3G71Fl/ssOZCKQByhArXvNNLlC0fStDUfkpZbXga/G7Ok9lPl2MbkV/wMQn
	6ViOyP2m38u0s8Og9WXy2r9o1AgTQ7hGxPZHZxTc+vbsqytSf4bJZaKUux6dNyInSDqudYovt5B
	njkwGyWZXFnyU1CS7lsai6qgX3eumTJ2xqDrwRxyEDzcl6b9q4xmcC6g2i+FVWDMgK6t7P5sgsm
	xtnIXCtrJNSqe5yBIlGZZmA/8orKDKLggHCSWIlLIa5DbllBA7GRcZfRcndFopfcY4eFeYymCfd
	t/hEoKOWLNkiT8jrEds4eQ4SM8mFseFUctDSTF4xvvbpcoyQ2ktvTicfhpvYe/yTIKAnpZTrlUJ
	/iHShCFqrAeA==
X-Received: by 2002:a05:620a:404f:b0:8b2:dd78:9288 with SMTP id af79cd13be357-8c52083a221mr491236685a.13.1768322906381;
        Tue, 13 Jan 2026 08:48:26 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a8956sm1690928085a.10.2026.01.13.08.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:48:25 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: sched-ext@lists.linux.dev
Cc: changwoo@igalia.com,
	arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <dvernet@meta.com>
Subject: [PATCH v2 2/3] tools/sched_ext: add scx_pair scheduler
Date: Tue, 13 Jan 2026 11:48:17 -0500
Message-ID: <20260113164818.14305-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260113164818.14305-1-emil@etsalapatis.com>
References: <20260113164818.14305-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the scx_pair cgroup-based core scheduler.

Cc: Tejun Heo <tj@kernel.org>
Cc: David Vernet <dvernet@meta.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/sched_ext/Makefile       |   2 +-
 tools/sched_ext/scx_pair.bpf.c | 610 +++++++++++++++++++++++++++++++++
 tools/sched_ext/scx_pair.c     | 180 ++++++++++
 tools/sched_ext/scx_pair.h     |   9 +
 4 files changed, 800 insertions(+), 1 deletion(-)
 create mode 100644 tools/sched_ext/scx_pair.bpf.c
 create mode 100644 tools/sched_ext/scx_pair.c
 create mode 100644 tools/sched_ext/scx_pair.h

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index 12043a82a1a9..208e8f8fe4d8 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -189,7 +189,7 @@ $(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BP
 
 SCX_COMMON_DEPS := include/scx/common.h include/scx/user_exit_info.h | $(BINDIR)
 
-c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_flatcg scx_userland
+c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_flatcg scx_userland scx_pair
 
 $(addprefix $(BINDIR)/,$(c-sched-targets)): \
 	$(BINDIR)/%: \
diff --git a/tools/sched_ext/scx_pair.bpf.c b/tools/sched_ext/scx_pair.bpf.c
new file mode 100644
index 000000000000..267011b57cba
--- /dev/null
+++ b/tools/sched_ext/scx_pair.bpf.c
@@ -0,0 +1,610 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A demo sched_ext core-scheduler which always makes every sibling CPU pair
+ * execute from the same CPU cgroup.
+ *
+ * This scheduler is a minimal implementation and would need some form of
+ * priority handling both inside each cgroup and across the cgroups to be
+ * practically useful.
+ *
+ * Each CPU in the system is paired with exactly one other CPU, according to a
+ * "stride" value that can be specified when the BPF scheduler program is first
+ * loaded. Throughout the runtime of the scheduler, these CPU pairs guarantee
+ * that they will only ever schedule tasks that belong to the same CPU cgroup.
+ *
+ * Scheduler Initialization
+ * ------------------------
+ *
+ * The scheduler BPF program is first initialized from user space, before it is
+ * enabled. During this initialization process, each CPU on the system is
+ * assigned several values that are constant throughout its runtime:
+ *
+ * 1. *Pair CPU*: The CPU that it synchronizes with when making scheduling
+ *		  decisions. Paired CPUs always schedule tasks from the same
+ *		  CPU cgroup, and synchronize with each other to guarantee
+ *		  that this constraint is not violated.
+ * 2. *Pair ID*:  Each CPU pair is assigned a Pair ID, which is used to access
+ *		  a struct pair_ctx object that is shared between the pair.
+ * 3. *In-pair-index*: An index, 0 or 1, that is assigned to each core in the
+ *		       pair. Each struct pair_ctx has an active_mask field,
+ *		       which is a bitmap used to indicate whether each core
+ *		       in the pair currently has an actively running task.
+ *		       This index specifies which entry in the bitmap corresponds
+ *		       to each CPU in the pair.
+ *
+ * During this initialization, the CPUs are paired according to a "stride" that
+ * may be specified when invoking the user space program that initializes and
+ * loads the scheduler. By default, the stride is 1/2 the total number of CPUs.
+ *
+ * Tasks and cgroups
+ * -----------------
+ *
+ * Every cgroup in the system is registered with the scheduler using the
+ * pair_cgroup_init() callback, and every task in the system is associated with
+ * exactly one cgroup. At a high level, the idea with the pair scheduler is to
+ * always schedule tasks from the same cgroup within a given CPU pair. When a
+ * task is enqueued (i.e. passed to the pair_enqueue() callback function), its
+ * cgroup ID is read from its task struct, and then a corresponding queue map
+ * is used to FIFO-enqueue the task for that cgroup.
+ *
+ * If you look through the implementation of the scheduler, you'll notice that
+ * there is quite a bit of complexity involved with looking up the per-cgroup
+ * FIFO queue that we enqueue tasks in. For example, there is a cgrp_q_idx_hash
+ * BPF hash map that is used to map a cgroup ID to a globally unique ID that's
+ * allocated in the BPF program. This is done because we use separate maps to
+ * store the FIFO queue of tasks, and the length of that map, per cgroup. This
+ * complexity is only present because of current deficiencies in BPF that will
+ * soon be addressed. The main point to keep in mind is that newly enqueued
+ * tasks are added to their cgroup's FIFO queue.
+ *
+ * Dispatching tasks
+ * -----------------
+ *
+ * This section will describe how enqueued tasks are dispatched and scheduled.
+ * Tasks are dispatched in pair_dispatch(), and at a high level the workflow is
+ * as follows:
+ *
+ * 1. Fetch the struct pair_ctx for the current CPU. As mentioned above, this is
+ *    the structure that's used to synchronize amongst the two pair CPUs in their
+ *    scheduling decisions. After any of the following events have occurred:
+ *
+ * - The cgroup's slice run has expired, or
+ * - The cgroup becomes empty, or
+ * - Either CPU in the pair is preempted by a higher priority scheduling class
+ *
+ * The cgroup transitions to the draining state and stops executing new tasks
+ * from the cgroup.
+ *
+ * 2. If the pair is still executing a task, mark the pair_ctx as draining, and
+ *    wait for the pair CPU to be preempted.
+ *
+ * 3. Otherwise, if the pair CPU is not running a task, we can move onto
+ *    scheduling new tasks. Pop the next cgroup id from the top_q queue.
+ *
+ * 4. Pop a task from that cgroup's FIFO task queue, and begin executing it.
+ *
+ * Note again that this scheduling behavior is simple, but the implementation
+ * is complex mostly because this it hits several BPF shortcomings and has to
+ * work around in often awkward ways. Most of the shortcomings are expected to
+ * be resolved in the near future which should allow greatly simplifying this
+ * scheduler.
+ *
+ * Dealing with preemption
+ * -----------------------
+ *
+ * SCX is the lowest priority sched_class, and could be preempted by them at
+ * any time. To address this, the scheduler implements pair_cpu_release() and
+ * pair_cpu_acquire() callbacks which are invoked by the core scheduler when
+ * the scheduler loses and gains control of the CPU respectively.
+ *
+ * In pair_cpu_release(), we mark the pair_ctx as having been preempted, and
+ * then invoke:
+ *
+ * scx_bpf_kick_cpu(pair_cpu, SCX_KICK_PREEMPT | SCX_KICK_WAIT);
+ *
+ * This preempts the pair CPU, and waits until it has re-entered the scheduler
+ * before returning. This is necessary to ensure that the higher priority
+ * sched_class that preempted our scheduler does not schedule a task
+ * concurrently with our pair CPU.
+ *
+ * When the CPU is re-acquired in pair_cpu_acquire(), we unmark the preemption
+ * in the pair_ctx, and send another resched IPI to the pair CPU to re-enable
+ * pair scheduling.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include <scx/common.bpf.h>
+#include "scx_pair.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* !0 for veristat, set during init */
+const volatile u32 nr_cpu_ids = 1;
+
+/* a pair of CPUs stay on a cgroup for this duration */
+const volatile u32 pair_batch_dur_ns;
+
+/* cpu ID -> pair cpu ID */
+const volatile s32 RESIZABLE_ARRAY(rodata, pair_cpu);
+
+/* cpu ID -> pair_id */
+const volatile u32 RESIZABLE_ARRAY(rodata, pair_id);
+
+/* CPU ID -> CPU # in the pair (0 or 1) */
+const volatile u32 RESIZABLE_ARRAY(rodata, in_pair_idx);
+
+struct pair_ctx {
+	struct bpf_spin_lock	lock;
+
+	/* the cgroup the pair is currently executing */
+	u64			cgid;
+
+	/* the pair started executing the current cgroup at */
+	u64			started_at;
+
+	/* whether the current cgroup is draining */
+	bool			draining;
+
+	/* the CPUs that are currently active on the cgroup */
+	u32			active_mask;
+
+	/*
+	 * the CPUs that are currently preempted and running tasks in a
+	 * different scheduler.
+	 */
+	u32			preempted_mask;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, u32);
+	__type(value, struct pair_ctx);
+} pair_ctx SEC(".maps");
+
+/* queue of cgrp_q's possibly with tasks on them */
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	/*
+	 * Because it's difficult to build strong synchronization encompassing
+	 * multiple non-trivial operations in BPF, this queue is managed in an
+	 * opportunistic way so that we guarantee that a cgroup w/ active tasks
+	 * is always on it but possibly multiple times. Once we have more robust
+	 * synchronization constructs and e.g. linked list, we should be able to
+	 * do this in a prettier way but for now just size it big enough.
+	 */
+	__uint(max_entries, 4 * MAX_CGRPS);
+	__type(value, u64);
+} top_q SEC(".maps");
+
+/* per-cgroup q which FIFOs the tasks from the cgroup */
+struct cgrp_q {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, MAX_QUEUED);
+	__type(value, u32);
+};
+
+/*
+ * Ideally, we want to allocate cgrp_q and cgrq_q_len in the cgroup local
+ * storage; however, a cgroup local storage can only be accessed from the BPF
+ * progs attached to the cgroup. For now, work around by allocating array of
+ * cgrp_q's and then allocating per-cgroup indices.
+ *
+ * Another caveat: It's difficult to populate a large array of maps statically
+ * or from BPF. Initialize it from userland.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, MAX_CGRPS);
+	__type(key, s32);
+	__array(values, struct cgrp_q);
+} cgrp_q_arr SEC(".maps");
+
+static u64 cgrp_q_len[MAX_CGRPS];
+
+/*
+ * This and cgrp_q_idx_hash combine into a poor man's IDR. This likely would be
+ * useful to have as a map type.
+ */
+static u32 cgrp_q_idx_cursor;
+static u64 cgrp_q_idx_busy[MAX_CGRPS];
+
+/*
+ * All added up, the following is what we do:
+ *
+ * 1. When a cgroup is enabled, RR cgroup_q_idx_busy array doing cmpxchg looking
+ *    for a free ID. If not found, fail cgroup creation with -EBUSY.
+ *
+ * 2. Hash the cgroup ID to the allocated cgrp_q_idx in the following
+ *    cgrp_q_idx_hash.
+ *
+ * 3. Whenever a cgrp_q needs to be accessed, first look up the cgrp_q_idx from
+ *    cgrp_q_idx_hash and then access the corresponding entry in cgrp_q_arr.
+ *
+ * This is sadly complicated for something pretty simple. Hopefully, we should
+ * be able to simplify in the future.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, MAX_CGRPS);
+	__uint(key_size, sizeof(u64));		/* cgrp ID */
+	__uint(value_size, sizeof(s32));	/* cgrp_q idx */
+} cgrp_q_idx_hash SEC(".maps");
+
+/* statistics */
+u64 nr_total, nr_dispatched, nr_missing, nr_kicks, nr_preemptions;
+u64 nr_exps, nr_exp_waits, nr_exp_empty;
+u64 nr_cgrp_next, nr_cgrp_coll, nr_cgrp_empty;
+
+UEI_DEFINE(uei);
+
+void BPF_STRUCT_OPS(pair_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct cgroup *cgrp;
+	struct cgrp_q *cgq;
+	s32 pid = p->pid;
+	u64 cgid;
+	u32 *q_idx;
+	u64 *cgq_len;
+
+	__sync_fetch_and_add(&nr_total, 1);
+
+	cgrp = scx_bpf_task_cgroup(p);
+	cgid = cgrp->kn->id;
+	bpf_cgroup_release(cgrp);
+
+	/* find the cgroup's q and push @p into it */
+	q_idx = bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
+	if (!q_idx) {
+		scx_bpf_error("failed to lookup q_idx for cgroup[%llu]", cgid);
+		return;
+	}
+
+	cgq = bpf_map_lookup_elem(&cgrp_q_arr, q_idx);
+	if (!cgq) {
+		scx_bpf_error("failed to lookup q_arr for cgroup[%llu] q_idx[%u]",
+			      cgid, *q_idx);
+		return;
+	}
+
+	if (bpf_map_push_elem(cgq, &pid, 0)) {
+		scx_bpf_error("cgroup[%llu] queue overflow", cgid);
+		return;
+	}
+
+	/* bump q len, if going 0 -> 1, queue cgroup into the top_q */
+	cgq_len = MEMBER_VPTR(cgrp_q_len, [*q_idx]);
+	if (!cgq_len) {
+		scx_bpf_error("MEMBER_VTPR malfunction");
+		return;
+	}
+
+	if (!__sync_fetch_and_add(cgq_len, 1) &&
+	    bpf_map_push_elem(&top_q, &cgid, 0)) {
+		scx_bpf_error("top_q overflow");
+		return;
+	}
+}
+
+static int lookup_pairc_and_mask(s32 cpu, struct pair_ctx **pairc, u32 *mask)
+{
+	u32 *vptr;
+
+	vptr = (u32 *)ARRAY_ELEM_PTR(pair_id, cpu, nr_cpu_ids);
+	if (!vptr)
+		return -EINVAL;
+
+	*pairc = bpf_map_lookup_elem(&pair_ctx, vptr);
+	if (!(*pairc))
+		return -EINVAL;
+
+	vptr = (u32 *)ARRAY_ELEM_PTR(in_pair_idx, cpu, nr_cpu_ids);
+	if (!vptr)
+		return -EINVAL;
+
+	*mask = 1U << *vptr;
+
+	return 0;
+}
+
+__attribute__((noinline))
+static int try_dispatch(s32 cpu)
+{
+	struct pair_ctx *pairc;
+	struct bpf_map *cgq_map;
+	struct task_struct *p;
+	u64 now = scx_bpf_now();
+	bool kick_pair = false;
+	bool expired, pair_preempted;
+	u32 *vptr, in_pair_mask;
+	s32 pid, q_idx;
+	u64 cgid;
+	int ret;
+
+	ret = lookup_pairc_and_mask(cpu, &pairc, &in_pair_mask);
+	if (ret) {
+		scx_bpf_error("failed to lookup pairc and in_pair_mask for cpu[%d]",
+			      cpu);
+		return -ENOENT;
+	}
+
+	bpf_spin_lock(&pairc->lock);
+	pairc->active_mask &= ~in_pair_mask;
+
+	expired = time_before(pairc->started_at + pair_batch_dur_ns, now);
+	if (expired || pairc->draining) {
+		u64 new_cgid = 0;
+
+		__sync_fetch_and_add(&nr_exps, 1);
+
+		/*
+		 * We're done with the current cgid. An obvious optimization
+		 * would be not draining if the next cgroup is the current one.
+		 * For now, be dumb and always expire.
+		 */
+		pairc->draining = true;
+
+		pair_preempted = pairc->preempted_mask;
+		if (pairc->active_mask || pair_preempted) {
+			/*
+			 * The other CPU is still active, or is no longer under
+			 * our control due to e.g. being preempted by a higher
+			 * priority sched_class. We want to wait until this
+			 * cgroup expires, or until control of our pair CPU has
+			 * been returned to us.
+			 *
+			 * If the pair controls its CPU, and the time already
+			 * expired, kick.  When the other CPU arrives at
+			 * dispatch and clears its active mask, it'll push the
+			 * pair to the next cgroup and kick this CPU.
+			 */
+			__sync_fetch_and_add(&nr_exp_waits, 1);
+			bpf_spin_unlock(&pairc->lock);
+			if (expired && !pair_preempted)
+				kick_pair = true;
+			goto out_maybe_kick;
+		}
+
+		bpf_spin_unlock(&pairc->lock);
+
+		/*
+		 * Pick the next cgroup. It'd be easier / cleaner to not drop
+		 * pairc->lock and use stronger synchronization here especially
+		 * given that we'll be switching cgroups significantly less
+		 * frequently than tasks. Unfortunately, bpf_spin_lock can't
+		 * really protect anything non-trivial. Let's do opportunistic
+		 * operations instead.
+		 */
+		bpf_repeat(BPF_MAX_LOOPS) {
+			u32 *q_idx;
+			u64 *cgq_len;
+
+			if (bpf_map_pop_elem(&top_q, &new_cgid)) {
+				/* no active cgroup, go idle */
+				__sync_fetch_and_add(&nr_exp_empty, 1);
+				return 0;
+			}
+
+			q_idx = bpf_map_lookup_elem(&cgrp_q_idx_hash, &new_cgid);
+			if (!q_idx)
+				continue;
+
+			/*
+			 * This is the only place where empty cgroups are taken
+			 * off the top_q.
+			 */
+			cgq_len = MEMBER_VPTR(cgrp_q_len, [*q_idx]);
+			if (!cgq_len || !*cgq_len)
+				continue;
+
+			/*
+			 * If it has any tasks, requeue as we may race and not
+			 * execute it.
+			 */
+			bpf_map_push_elem(&top_q, &new_cgid, 0);
+			break;
+		}
+
+		bpf_spin_lock(&pairc->lock);
+
+		/*
+		 * The other CPU may already have started on a new cgroup while
+		 * we dropped the lock. Make sure that we're still draining and
+		 * start on the new cgroup.
+		 */
+		if (pairc->draining && !pairc->active_mask) {
+			__sync_fetch_and_add(&nr_cgrp_next, 1);
+			pairc->cgid = new_cgid;
+			pairc->started_at = now;
+			pairc->draining = false;
+			kick_pair = true;
+		} else {
+			__sync_fetch_and_add(&nr_cgrp_coll, 1);
+		}
+	}
+
+	cgid = pairc->cgid;
+	pairc->active_mask |= in_pair_mask;
+	bpf_spin_unlock(&pairc->lock);
+
+	/* again, it'd be better to do all these with the lock held, oh well */
+	vptr = bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
+	if (!vptr) {
+		scx_bpf_error("failed to lookup q_idx for cgroup[%llu]", cgid);
+		return -ENOENT;
+	}
+	q_idx = *vptr;
+
+	/* claim one task from cgrp_q w/ q_idx */
+	bpf_repeat(BPF_MAX_LOOPS) {
+		u64 *cgq_len, len;
+
+		cgq_len = MEMBER_VPTR(cgrp_q_len, [q_idx]);
+		if (!cgq_len || !(len = *(volatile u64 *)cgq_len)) {
+			/* the cgroup must be empty, expire and repeat */
+			__sync_fetch_and_add(&nr_cgrp_empty, 1);
+			bpf_spin_lock(&pairc->lock);
+			pairc->draining = true;
+			pairc->active_mask &= ~in_pair_mask;
+			bpf_spin_unlock(&pairc->lock);
+			return -EAGAIN;
+		}
+
+		if (__sync_val_compare_and_swap(cgq_len, len, len - 1) != len)
+			continue;
+
+		break;
+	}
+
+	cgq_map = bpf_map_lookup_elem(&cgrp_q_arr, &q_idx);
+	if (!cgq_map) {
+		scx_bpf_error("failed to lookup cgq_map for cgroup[%llu] q_idx[%d]",
+			      cgid, q_idx);
+		return -ENOENT;
+	}
+
+	if (bpf_map_pop_elem(cgq_map, &pid)) {
+		scx_bpf_error("cgq_map is empty for cgroup[%llu] q_idx[%d]",
+			      cgid, q_idx);
+		return -ENOENT;
+	}
+
+	p = bpf_task_from_pid(pid);
+	if (p) {
+		__sync_fetch_and_add(&nr_dispatched, 1);
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+		bpf_task_release(p);
+	} else {
+		/* we don't handle dequeues, retry on lost tasks */
+		__sync_fetch_and_add(&nr_missing, 1);
+		return -EAGAIN;
+	}
+
+out_maybe_kick:
+	if (kick_pair) {
+		s32 *pair = (s32 *)ARRAY_ELEM_PTR(pair_cpu, cpu, nr_cpu_ids);
+		if (pair) {
+			__sync_fetch_and_add(&nr_kicks, 1);
+			scx_bpf_kick_cpu(*pair, SCX_KICK_PREEMPT);
+		}
+	}
+	return 0;
+}
+
+void BPF_STRUCT_OPS(pair_dispatch, s32 cpu, struct task_struct *prev)
+{
+	bpf_repeat(BPF_MAX_LOOPS) {
+		if (try_dispatch(cpu) != -EAGAIN)
+			break;
+	}
+}
+
+void BPF_STRUCT_OPS(pair_cpu_acquire, s32 cpu, struct scx_cpu_acquire_args *args)
+{
+	int ret;
+	u32 in_pair_mask;
+	struct pair_ctx *pairc;
+	bool kick_pair;
+
+	ret = lookup_pairc_and_mask(cpu, &pairc, &in_pair_mask);
+	if (ret)
+		return;
+
+	bpf_spin_lock(&pairc->lock);
+	pairc->preempted_mask &= ~in_pair_mask;
+	/* Kick the pair CPU, unless it was also preempted. */
+	kick_pair = !pairc->preempted_mask;
+	bpf_spin_unlock(&pairc->lock);
+
+	if (kick_pair) {
+		s32 *pair = (s32 *)ARRAY_ELEM_PTR(pair_cpu, cpu, nr_cpu_ids);
+
+		if (pair) {
+			__sync_fetch_and_add(&nr_kicks, 1);
+			scx_bpf_kick_cpu(*pair, SCX_KICK_PREEMPT);
+		}
+	}
+}
+
+void BPF_STRUCT_OPS(pair_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
+{
+	int ret;
+	u32 in_pair_mask;
+	struct pair_ctx *pairc;
+	bool kick_pair;
+
+	ret = lookup_pairc_and_mask(cpu, &pairc, &in_pair_mask);
+	if (ret)
+		return;
+
+	bpf_spin_lock(&pairc->lock);
+	pairc->preempted_mask |= in_pair_mask;
+	pairc->active_mask &= ~in_pair_mask;
+	/* Kick the pair CPU if it's still running. */
+	kick_pair = pairc->active_mask;
+	pairc->draining = true;
+	bpf_spin_unlock(&pairc->lock);
+
+	if (kick_pair) {
+		s32 *pair = (s32 *)ARRAY_ELEM_PTR(pair_cpu, cpu, nr_cpu_ids);
+
+		if (pair) {
+			__sync_fetch_and_add(&nr_kicks, 1);
+			scx_bpf_kick_cpu(*pair, SCX_KICK_PREEMPT | SCX_KICK_WAIT);
+		}
+	}
+	__sync_fetch_and_add(&nr_preemptions, 1);
+}
+
+s32 BPF_STRUCT_OPS(pair_cgroup_init, struct cgroup *cgrp)
+{
+	u64 cgid = cgrp->kn->id;
+	s32 i, q_idx;
+
+	bpf_for(i, 0, MAX_CGRPS) {
+		q_idx = __sync_fetch_and_add(&cgrp_q_idx_cursor, 1) % MAX_CGRPS;
+		if (!__sync_val_compare_and_swap(&cgrp_q_idx_busy[q_idx], 0, 1))
+			break;
+	}
+	if (i == MAX_CGRPS)
+		return -EBUSY;
+
+	if (bpf_map_update_elem(&cgrp_q_idx_hash, &cgid, &q_idx, BPF_ANY)) {
+		u64 *busy = MEMBER_VPTR(cgrp_q_idx_busy, [q_idx]);
+		if (busy)
+			*busy = 0;
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(pair_cgroup_exit, struct cgroup *cgrp)
+{
+	u64 cgid = cgrp->kn->id;
+	s32 *q_idx;
+
+	q_idx = bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
+	if (q_idx) {
+		u64 *busy = MEMBER_VPTR(cgrp_q_idx_busy, [*q_idx]);
+		if (busy)
+			*busy = 0;
+		bpf_map_delete_elem(&cgrp_q_idx_hash, &cgid);
+	}
+}
+
+void BPF_STRUCT_OPS(pair_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SCX_OPS_DEFINE(pair_ops,
+	       .enqueue			= (void *)pair_enqueue,
+	       .dispatch		= (void *)pair_dispatch,
+	       .cpu_acquire		= (void *)pair_cpu_acquire,
+	       .cpu_release		= (void *)pair_cpu_release,
+	       .cgroup_init		= (void *)pair_cgroup_init,
+	       .cgroup_exit		= (void *)pair_cgroup_exit,
+	       .exit			= (void *)pair_exit,
+	       .name			= "pair");
diff --git a/tools/sched_ext/scx_pair.c b/tools/sched_ext/scx_pair.c
new file mode 100644
index 000000000000..d3e97faa6334
--- /dev/null
+++ b/tools/sched_ext/scx_pair.c
@@ -0,0 +1,180 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <inttypes.h>
+#include <signal.h>
+#include <assert.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include "scx_pair.h"
+#include "scx_pair.bpf.skel.h"
+
+const char help_fmt[] =
+"A demo sched_ext core-scheduler which always makes every sibling CPU pair\n"
+"execute from the same CPU cgroup.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-S STRIDE]\n"
+"\n"
+"  -S STRIDE     Override CPU pair stride (default: nr_cpus_ids / 2)\n"
+"  -v            Print libbpf debug messages\n"
+"  -h            Display this help and exit\n";
+
+static bool verbose;
+static volatile int exit_req;
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
+{
+	if (level == LIBBPF_DEBUG && !verbose)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+static void sigint_handler(int dummy)
+{
+	exit_req = 1;
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_pair *skel;
+	struct bpf_link *link;
+	__u64 seq = 0, ecode;
+	__s32 stride, i, opt, outer_fd;
+
+	libbpf_set_print(libbpf_print_fn);
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+restart:
+	skel = SCX_OPS_OPEN(pair_ops, scx_pair);
+
+	skel->rodata->nr_cpu_ids = libbpf_num_possible_cpus();
+	assert(skel->rodata->nr_cpu_ids > 0);
+	skel->rodata->pair_batch_dur_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
+
+	/* pair up the earlier half to the latter by default, override with -s */
+	stride = skel->rodata->nr_cpu_ids / 2;
+
+	while ((opt = getopt(argc, argv, "S:vh")) != -1) {
+		switch (opt) {
+		case 'S':
+			stride = strtoul(optarg, NULL, 0);
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	bpf_map__set_max_entries(skel->maps.pair_ctx, skel->rodata->nr_cpu_ids / 2);
+
+	/* Resize arrays so their element count is equal to cpu count. */
+	RESIZE_ARRAY(skel, rodata, pair_cpu, skel->rodata->nr_cpu_ids);
+	RESIZE_ARRAY(skel, rodata, pair_id, skel->rodata->nr_cpu_ids);
+	RESIZE_ARRAY(skel, rodata, in_pair_idx, skel->rodata->nr_cpu_ids);
+
+	for (i = 0; i < skel->rodata->nr_cpu_ids; i++)
+		skel->rodata_pair_cpu->pair_cpu[i] = -1;
+
+	printf("Pairs: ");
+	for (i = 0; i < skel->rodata->nr_cpu_ids; i++) {
+		int j = (i + stride) % skel->rodata->nr_cpu_ids;
+
+		if (skel->rodata_pair_cpu->pair_cpu[i] >= 0)
+			continue;
+
+		SCX_BUG_ON(i == j,
+			   "Invalid stride %d - CPU%d wants to be its own pair",
+			   stride, i);
+
+		SCX_BUG_ON(skel->rodata_pair_cpu->pair_cpu[j] >= 0,
+			   "Invalid stride %d - three CPUs (%d, %d, %d) want to be a pair",
+			   stride, i, j, skel->rodata_pair_cpu->pair_cpu[j]);
+
+		skel->rodata_pair_cpu->pair_cpu[i] = j;
+		skel->rodata_pair_cpu->pair_cpu[j] = i;
+		skel->rodata_pair_id->pair_id[i] = i;
+		skel->rodata_pair_id->pair_id[j] = i;
+		skel->rodata_in_pair_idx->in_pair_idx[i] = 0;
+		skel->rodata_in_pair_idx->in_pair_idx[j] = 1;
+
+		printf("[%d, %d] ", i, j);
+	}
+	printf("\n");
+
+	SCX_OPS_LOAD(skel, pair_ops, scx_pair, uei);
+
+	/*
+	 * Populate the cgrp_q_arr map which is an array containing per-cgroup
+	 * queues. It'd probably be better to do this from BPF but there are too
+	 * many to initialize statically and there's no way to dynamically
+	 * populate from BPF.
+	 */
+	outer_fd = bpf_map__fd(skel->maps.cgrp_q_arr);
+	SCX_BUG_ON(outer_fd < 0, "Failed to get outer_fd: %d", outer_fd);
+
+	printf("Initializing");
+        for (i = 0; i < MAX_CGRPS; i++) {
+		__s32 inner_fd;
+
+		if (exit_req)
+			break;
+
+		inner_fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0,
+					  sizeof(__u32), MAX_QUEUED, NULL);
+		SCX_BUG_ON(inner_fd < 0, "Failed to get inner_fd: %d",
+			   inner_fd);
+		SCX_BUG_ON(bpf_map_update_elem(outer_fd, &i, &inner_fd, BPF_ANY),
+			   "Failed to set inner map");
+		close(inner_fd);
+
+		if (!(i % 10))
+			printf(".");
+		fflush(stdout);
+        }
+	printf("\n");
+
+	/*
+	 * Fully initialized, attach and run.
+	 */
+	link = SCX_OPS_ATTACH(skel, pair_ops, scx_pair);
+
+	while (!exit_req && !UEI_EXITED(skel, uei)) {
+		printf("[SEQ %llu]\n", seq++);
+		printf(" total:%10" PRIu64 " dispatch:%10" PRIu64 "   missing:%10" PRIu64 "\n",
+		       skel->bss->nr_total,
+		       skel->bss->nr_dispatched,
+		       skel->bss->nr_missing);
+		printf(" kicks:%10" PRIu64 " preemptions:%7" PRIu64 "\n",
+		       skel->bss->nr_kicks,
+		       skel->bss->nr_preemptions);
+		printf("   exp:%10" PRIu64 " exp_wait:%10" PRIu64 " exp_empty:%10" PRIu64 "\n",
+		       skel->bss->nr_exps,
+		       skel->bss->nr_exp_waits,
+		       skel->bss->nr_exp_empty);
+		printf("cgnext:%10" PRIu64 "   cgcoll:%10" PRIu64 "   cgempty:%10" PRIu64 "\n",
+		       skel->bss->nr_cgrp_next,
+		       skel->bss->nr_cgrp_coll,
+		       skel->bss->nr_cgrp_empty);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	ecode = UEI_REPORT(skel, uei);
+	scx_pair__destroy(skel);
+
+	if (UEI_ECODE_RESTART(ecode))
+		goto restart;
+	return 0;
+}
diff --git a/tools/sched_ext/scx_pair.h b/tools/sched_ext/scx_pair.h
new file mode 100644
index 000000000000..d9666a447d3f
--- /dev/null
+++ b/tools/sched_ext/scx_pair.h
@@ -0,0 +1,9 @@
+#ifndef __SCX_EXAMPLE_PAIR_H
+#define __SCX_EXAMPLE_PAIR_H
+
+enum {
+	MAX_QUEUED		= 4096,
+	MAX_CGRPS		= 4096,
+};
+
+#endif /* __SCX_EXAMPLE_PAIR_H */
-- 
2.49.0

