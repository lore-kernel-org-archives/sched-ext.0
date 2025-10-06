Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C082264D6
	for <sched-ext@lists.linux.dev>; Mon,  6 Oct 2025 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770257; cv=none; b=HIBNeCY1JNOjonHb/Xtl5InM44ZTAydOEDiADdEDnO4Ls10yNRIObBLpqQapyNjFaf+eIEd5qe7d7CuuQ4hBgTGbMGaDY4fDsXL8fd6rEFDNxpTixCNB8ET6ORHZE5dRsxOdBtiY+BGIeotGlzB33a9zuu2DPp+yJbW4e4t56Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770257; c=relaxed/simple;
	bh=w9qQN86kH4uxofb0sYpXqZkSZGVFrTWqZBqMEXZZBbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isVXTu0q+pyGVmDqjt05IzQc00dh3rtpIpk8pd5Ww38nL5Fz80BUrM5VcceXaufrYYHDJ+FBBVQKxM5Vzc79LOpH5i1K/x2xQ7029g+vaQg8CB4rI8Icy32fFFI5NXplxb+GLOo7YHaTr5itBI0jZUx4ftvRwhdn/TY+VMiBHn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJ9LrTaF; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJ9LrTaF"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-90926724bceso436089939f.1
        for <sched-ext@lists.linux.dev>; Mon, 06 Oct 2025 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759770254; x=1760375054; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwV/3UDFHoCnSS4lQ5PWW6RJWQc6Qz60ALs0MB2kCq4=;
        b=fJ9LrTaFxkFYybpoceNr74NrruO3F+J1qmYgmbrv1oBzKTjMTSfNc3JH8tLkarso6r
         wirlYHUM+mZrZxIw0+/KEYAk5ePM+WSqsjQpU3NgcwP9o5IjywgBF5lCg6BWh0RtJ6Ho
         m0bjRx761FDorQZiXkjeqejXserjPV8o+7dms4VTXfs+bUW+7+ZF97JtFWB8EJq6Ihdu
         Yb9unuw6zT1zgo7gblzlfyJCOg5Ox9ldH1JHXmjDhz47cFvXAWb5vmz5cg9W3QYC9ISt
         QSYZJGqvlRP1nbGSPMxhehX4D8bytxxHbZd4mIz97RRqOBiWFT1wnPh8xmm6jf4rW4+S
         RlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759770254; x=1760375054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwV/3UDFHoCnSS4lQ5PWW6RJWQc6Qz60ALs0MB2kCq4=;
        b=PKm6xXzJo55LK70hcPjUaAAXguLt0EZ67MKJouZ6zLc2taj1Ggjw8VsL/EMetDDlwl
         OstLnMhT55Cb5VHelA5gCMylFfBAXtEIViX09RSJiqwXuX/G0UP6Tv8H8iYv5gA7MVwI
         jbIvem1j9un+5LY8auMFG5FO1P42akkHQwMzE7B4UdUwhVQcox5P0NDX0YteyzIknVGE
         P8ds866y9DWUQ5Fa5F7yumfcE3wkYfgdtnBsxWRzlj4eq5fI7ozFd0wlsq+12WxgCjHE
         WrJdyIoov68hnxG00AtFkXs6g2Xg+5BtQEkrvLVGEFIMJR/RLrM5ZNxol+Kh/3By4adi
         xfPA==
X-Gm-Message-State: AOJu0YwRrfFR5YAE4XU1ElFWZn9kof5mNGy/oT+2vuFv1Bb1Z/+SQQ+p
	9j+JxeW/Q7Wal9Y+Ge1zNRQewJvasPJuczahTM5OxUSgiTZAc6t37bzrnHSndjv3
X-Gm-Gg: ASbGncud9riAYTr666Pww+J2gw5m7YbDFaJYMIOfX8WW8iv1Q83cZjT9T1NcQ3dOxqJ
	T0cKaouNKTmPINbFsvQYaHVaB+rpQQckceZ4QFga3ryb1caMSjXfyxdZ2JJ8jLiOPsp3D183CN2
	+32owl2mUiDAVKzFaXrgrnbeTeROgCYCJUyPlFgaQ+aE1hYPWhplV0fmujE4MO0iIQXLq6kAyPO
	UNBGwcwXosshwRMjog60BeWOF62tJyjHLL6sNWgytM332IM7WMG5SpWK+ZeQt8Vp1Xu51gnxaoL
	ZRT7UtQQ1/tiMveercwSEOuuOH/oDkKl+fVwvpqP8HQdFyfBTn6Isne1TKWPkV08aoIOpL4pFQv
	INygpYnhyMlVIBfoyAmgLXzXegvd8m2PImIcIyqyWJDtRxaJQJaHY5ywrXpuZx6wri92GA4+Fyw
	Jj63iQA5SMvwR6kME3XXm1pjgxZuzIe71j7Xr8roMGtQhWww==
X-Google-Smtp-Source: AGHT+IEQyr1icEiH9XL29A+dKGJbzT3oasLp+qt/mL+BlNWHLAiU5LdkfhKygUePWZyHOwhkS3vVXA==
X-Received: by 2002:a05:6602:3fc8:b0:8d3:6ac1:4dd3 with SMTP id ca18e2360f4ac-93b969aa445mr2005054139f.6.1759770253768;
        Mon, 06 Oct 2025 10:04:13 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a87bb84b4sm488589539f.18.2025.10.06.10.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:04:12 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev,
	tj@kernel.org,
	arighi@nvidia.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v3 2/2] sched_ext: Add a selftest for scx_bpf_dsq_peek
Date: Mon,  6 Oct 2025 13:04:03 -0400
Message-ID: <20251006170403.3584204-3-rrnewton@gmail.com>
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

Perform the most basic unit test: make sure an empty queue peeks as
empty, and when we put one element in the queue, make sure peek returns
that element.

However, even this simple test is a little complicated by the different
behavior of scx_bpf_dsq_insert in different calling contexts:
 - insert is for direct dispatch in enqueue
 - insert is delayed when called from select_cpu

In this case we split the insert and the peek that verifies the
result between enqueue/dispatch. As a second phase, we stress test by
performing many peeks on an array of user DSQs.

Note: An alternative would be to call `scx_bpf_dsq_move_to_local` on an
empty queue, which in turn calls `flush_dispatch_buf`, in order to flush
the buffered insert. Unfortunately, this is not viable within the
enqueue path, as it attempts a voluntary context switch within an RCU
read-side critical section.

Signed-off-by: Ryan Newton <newton@meta.com>
---
 kernel/sched/ext.c                            |   2 +
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/peek_dsq.bpf.c        | 265 ++++++++++++++++++
 tools/testing/selftests/sched_ext/peek_dsq.c  | 230 +++++++++++++++
 4 files changed, 498 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6d3537e65001..ec7e791cd4c8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6120,6 +6120,7 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
 	sch = rcu_dereference(scx_root);
 	if (unlikely(!sch))
 		return NULL;
+
 	if (unlikely(dsq_id & SCX_DSQ_FLAG_BUILTIN)) {
 		scx_error(sch, "peek disallowed on builtin DSQ 0x%llx", dsq_id);
 		return NULL;
@@ -6130,6 +6131,7 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
 		scx_error(sch, "peek on non-existent DSQ 0x%llx", dsq_id);
 		return NULL;
 	}
+
 	return rcu_dereference(dsq->first_task);
 }
 
diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 9d9d6b4c38b0..5fe45f9c5f8f 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -174,6 +174,7 @@ auto-test-targets :=			\
 	minimal				\
 	numa				\
 	allowed_cpus			\
+	peek_dsq			\
 	prog_run			\
 	reload_loop			\
 	select_cpu_dfl			\
diff --git a/tools/testing/selftests/sched_ext/peek_dsq.bpf.c b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
new file mode 100644
index 000000000000..8d179d4c7efb
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A BPF program for testing DSQ operations including create, destroy,
+ * and peek operations. Uses a hybrid approach:
+ * - Syscall program for DSQ lifecycle (create/destroy)
+ * - Struct ops scheduler for task insertion/dequeue testing
+ *
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Ryan Newton <ryan.newton@alum.mit.edu>
+ */
+
+#include <scx/common.bpf.h>
+#include <scx/compat.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define MAX_SAMPLES 100
+#define MAX_CPUS 512
+#define DSQ_POOL_SIZE 8
+int max_samples = MAX_SAMPLES;
+int max_cpus = MAX_CPUS;
+int dsq_pool_size = DSQ_POOL_SIZE;
+
+/* Global variables to store test results */
+int dsq_create_result = -1;
+int dsq_destroy_result = -1;
+int dsq_peek_result1 = -1;
+long dsq_inserted_pid = -1;
+int insert_test_cpu = -1; /* Set to the cpu that performs the test */
+long dsq_peek_result2 = -1;
+long dsq_peek_result2_pid = -1;
+long dsq_peek_result2_expected = -1;
+int test_dsq_id = 1234; /* Use a simple ID like create_dsq example */
+int real_dsq_id = 1235; /* DSQ for normal operation */
+int enqueue_count = -1;
+int dispatch_count = -1;
+int debug_ksym_exists = -1;
+
+/* DSQ pool for stress testing */
+int dsq_pool_base_id = 2000;
+int phase1_complete = -1;
+int total_peek_attempts = -1;
+int successful_peeks = -1;
+
+/* BPF map for sharing peek results with userspace */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, MAX_SAMPLES);
+	__type(key, u32);
+	__type(value, long);
+} peek_results SEC(".maps");
+
+/* Test if we're actually using the native or compat version */
+int check_dsq_insert_ksym(void)
+{
+	return bpf_ksym_exists(scx_bpf_dsq_insert) ? 1 : 0;
+}
+
+int check_dsq_peek_ksym(void)
+{
+	return bpf_ksym_exists(scx_bpf_dsq_peek) ? 1 : 0;
+}
+
+static inline int get_random_dsq_id(void)
+{
+	u64 time = bpf_ktime_get_ns();
+
+	return dsq_pool_base_id + (time % DSQ_POOL_SIZE);
+}
+
+static inline void record_peek_result(long pid)
+{
+	u32 slot_key;
+	long *slot_pid_ptr;
+	int ix;
+
+	if (pid <= 0)
+		return;
+
+	/* Find an empty slot or one with the same PID */
+	bpf_for(ix, 0, 10) {
+		slot_key = (pid + ix) % MAX_SAMPLES;
+		slot_pid_ptr = bpf_map_lookup_elem(&peek_results, &slot_key);
+		if (!slot_pid_ptr)
+			continue;
+
+		if (*slot_pid_ptr == -1 || *slot_pid_ptr == pid) {
+			*slot_pid_ptr = pid;
+			break;
+		}
+	}
+}
+
+/* Scan all DSQs in the pool and try to move a task to local */
+static inline int scan_dsq_pool(void)
+{
+	struct task_struct *task;
+	int moved = 0;
+	int i;
+
+	bpf_for(i, 0, DSQ_POOL_SIZE) {
+		int dsq_id = dsq_pool_base_id + i;
+
+		total_peek_attempts++;
+
+		task = __COMPAT_scx_bpf_dsq_peek(dsq_id);
+		if (task) {
+			successful_peeks++;
+			record_peek_result(task->pid);
+
+			/* Try to move this task to local */
+			if (!moved && scx_bpf_dsq_move_to_local(dsq_id) == 0) {
+				moved = 1;
+				break;
+			}
+		}
+	}
+	return moved;
+}
+
+/* Struct_ops scheduler for testing DSQ peek operations */
+void BPF_STRUCT_OPS(peek_dsq_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_struct *peek_result;
+	int last_insert_test_cpu, cpu;
+
+	enqueue_count++;
+	cpu = bpf_get_smp_processor_id();
+	last_insert_test_cpu = __sync_val_compare_and_swap(
+		&insert_test_cpu, -1, cpu);
+
+	/* Phase 1: Simple insert-then-peek test (only on first task) */
+	if (last_insert_test_cpu == -1) {
+		bpf_printk("peek_dsq_enqueue beginning phase 1 peek test on cpu %d\n", cpu);
+
+		/* Test 1: Peek empty DSQ - should return NULL */
+		peek_result = __COMPAT_scx_bpf_dsq_peek(test_dsq_id);
+		dsq_peek_result1 = (long)peek_result; /* Should be 0 (NULL) */
+
+		/* Test 2: Insert task into test DSQ for testing in dispatch callback */
+		dsq_inserted_pid = p->pid;
+		scx_bpf_dsq_insert(p, test_dsq_id, 0, enq_flags);
+		dsq_peek_result2_expected = (long)p; /* Expected the task we just inserted */
+	} else if (!phase1_complete) {
+		/* Still in phase 1, use real DSQ */
+		scx_bpf_dsq_insert(p, real_dsq_id, 0, enq_flags);
+	} else {
+		/* Phase 2: Random DSQ insertion for stress testing */
+		int random_dsq_id = get_random_dsq_id();
+
+		scx_bpf_dsq_insert(p, random_dsq_id, 0, enq_flags);
+	}
+}
+
+void BPF_STRUCT_OPS(peek_dsq_dispatch, s32 cpu, struct task_struct *prev)
+{
+	dispatch_count++;
+
+	/* Phase 1: Complete the simple peek test if we inserted a task but
+	 * haven't tested peek yet
+	 */
+	if (insert_test_cpu == cpu && dsq_peek_result2 == -1) {
+		struct task_struct *peek_result;
+
+		bpf_printk("peek_dsq_dispatch completing phase 1 peek test on cpu %d\n", cpu);
+
+		/* Test 3: Peek DSQ after insert - should return the task we inserted */
+		peek_result = __COMPAT_scx_bpf_dsq_peek(test_dsq_id);
+		/* Store the PID of the peeked task for comparison */
+		dsq_peek_result2 = (long)peek_result;
+		dsq_peek_result2_pid = peek_result ? peek_result->pid : -1;
+
+		/* Now consume the task since we've peeked at it */
+		scx_bpf_dsq_move_to_local(test_dsq_id);
+
+		/* Mark phase 1 as complete */
+		phase1_complete = 1;
+		bpf_printk("Phase 1 complete, starting phase 2 stress testing\n");
+	} else if (!phase1_complete) {
+		/* Still in phase 1, use real DSQ */
+		scx_bpf_dsq_move_to_local(real_dsq_id);
+	} else {
+		/* Phase 2: Scan all DSQs in the pool and try to move a task */
+		if (!scan_dsq_pool()) {
+			/* No tasks found in DSQ pool, fall back to real DSQ */
+			scx_bpf_dsq_move_to_local(real_dsq_id);
+		}
+	}
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(peek_dsq_init)
+{
+	s32 err;
+	int i;
+
+	/* Always set debug values so we can see which version we're using */
+	debug_ksym_exists = check_dsq_peek_ksym();
+
+	/* Initialize state first */
+	insert_test_cpu = -1;
+	enqueue_count = 0;
+	dispatch_count = 0;
+	phase1_complete = 0;
+	total_peek_attempts = 0;
+	successful_peeks = 0;
+	dsq_create_result = 0; /* Reset to 0 before attempting */
+
+	/* Create the test and real DSQs */
+	err = scx_bpf_create_dsq(test_dsq_id, -1);
+	if (!err)
+		err = scx_bpf_create_dsq(real_dsq_id, -1);
+	if (err) {
+		dsq_create_result = err;
+		scx_bpf_error("Failed to create primary DSQ %d: %d", test_dsq_id, err);
+		return err;
+	}
+
+	/* Create the DSQ pool for stress testing */
+	bpf_for(i, 0, DSQ_POOL_SIZE) {
+		int dsq_id = dsq_pool_base_id + i;
+
+		err = scx_bpf_create_dsq(dsq_id, -1);
+		if (err) {
+			dsq_create_result = err;
+			scx_bpf_error("Failed to create DSQ pool entry %d: %d", dsq_id, err);
+			return err;
+		}
+	}
+
+	dsq_create_result = 1; /* Success */
+
+	/* Initialize the peek results map */
+	bpf_for(i, 0, MAX_SAMPLES) {
+		u32 key = i;
+		long pid = -1;
+
+		bpf_map_update_elem(&peek_results, &key, &pid, BPF_ANY);
+	}
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(peek_dsq_exit, struct scx_exit_info *ei)
+{
+	int i;
+
+	scx_bpf_destroy_dsq(test_dsq_id);
+	scx_bpf_destroy_dsq(real_dsq_id);
+	bpf_for(i, 0, DSQ_POOL_SIZE) {
+		int dsq_id = dsq_pool_base_id + i;
+
+		scx_bpf_destroy_dsq(dsq_id);
+	}
+
+	dsq_destroy_result = 1;
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops peek_dsq_ops = {
+	.enqueue = (void *)peek_dsq_enqueue,
+	.dispatch = (void *)peek_dsq_dispatch,
+	.init = (void *)peek_dsq_init,
+	.exit = (void *)peek_dsq_exit,
+	.name = "peek_dsq",
+};
diff --git a/tools/testing/selftests/sched_ext/peek_dsq.c b/tools/testing/selftests/sched_ext/peek_dsq.c
new file mode 100644
index 000000000000..182dbdce2400
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/peek_dsq.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test for DSQ operations including create, destroy, and peek operations.
+ *
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Ryan Newton <ryan.newton@alum.mit.edu>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <string.h>
+#include <sched.h>
+#include "peek_dsq.bpf.skel.h"
+#include "scx_test.h"
+
+#define NUM_WORKERS 100
+
+static bool workload_running = true;
+static pthread_t workload_threads[NUM_WORKERS];
+
+/**
+ * Background workload thread that sleeps and wakes rapidly to exercise
+ * the scheduler's enqueue operations and ensure DSQ operations get tested.
+ */
+static void *workload_thread_fn(void *arg)
+{
+	while (workload_running) {
+		/* Sleep for a very short time to trigger scheduler activity */
+		usleep(1000); /* 1ms sleep */
+		sched_yield();
+	}
+	return NULL;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct peek_dsq *skel;
+
+	skel = peek_dsq__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(peek_dsq__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static int print_observed_pids(struct bpf_map *map, int max_samples, const char *dsq_name)
+{
+	long count = 0;
+
+	printf("Observed %s DSQ peek pids:\n", dsq_name);
+	for (int i = 0; i < max_samples; i++) {
+		long pid;
+		int err;
+
+		err = bpf_map_lookup_elem(bpf_map__fd(map), &i, &pid);
+		if (err == 0) {
+			if (pid == 0) {
+				printf("  Sample %d: NULL peek\n", i);
+			} else if (pid > 0) {
+				printf("  Sample %d: pid %ld\n", i, pid);
+				count++;
+			}
+		} else {
+			printf("  Sample %d: error reading pid (err=%d)\n", i, err);
+		}
+	}
+	printf("Observed ~%ld pids in the %s DSQ(s)\n", count, dsq_name);
+	return count;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct peek_dsq *skel = ctx;
+	bool failed = false;
+	int seconds = 3;
+	int err;
+
+	printf("Enabling scheduler to test DSQ insert operations...\n");
+
+	struct bpf_link *link =
+		bpf_map__attach_struct_ops(skel->maps.peek_dsq_ops);
+
+	if (!link) {
+		SCX_ERR("Failed to attach struct_ops");
+		return SCX_TEST_FAIL;
+	}
+
+	printf("Starting %d background workload threads...\n", NUM_WORKERS);
+	workload_running = true;
+	for (int i = 0; i < NUM_WORKERS; i++) {
+		err = pthread_create(&workload_threads[i], NULL, workload_thread_fn, NULL);
+		if (err) {
+			SCX_ERR("Failed to create workload thread %d: %s", i, strerror(err));
+			/* Stop already-created threads */
+			workload_running = false;
+			for (int j = 0; j < i; j++)
+				pthread_join(workload_threads[j], NULL);
+			bpf_link__destroy(link);
+			return SCX_TEST_FAIL;
+		}
+	}
+
+	printf("Waiting for enqueue events.\n");
+	sleep(seconds);
+	while (skel->data->enqueue_count <= 0) {
+		printf(".");
+		fflush(stdout);
+		sleep(1);
+		seconds++;
+		if (seconds >= 30) {
+			printf("\n\u2717 Timeout waiting for enqueue events\n");
+			/* Stop workload threads and cleanup */
+			workload_running = false;
+			for (int i = 0; i < NUM_WORKERS; i++)
+				pthread_join(workload_threads[i], NULL);
+			bpf_link__destroy(link);
+			return SCX_TEST_FAIL;
+		}
+	}
+
+	workload_running = false;
+	for (int i = 0; i < NUM_WORKERS; i++) {
+		err = pthread_join(workload_threads[i], NULL);
+		if (err) {
+			SCX_ERR("Failed to join workload thread %d: %s", i, strerror(err));
+			bpf_link__destroy(link);
+			return SCX_TEST_FAIL;
+		}
+	}
+	printf("Background workload threads stopped.\n");
+
+	/* Detach the scheduler */
+	bpf_link__destroy(link);
+
+	if (skel->data->dsq_create_result != 1) {
+		printf("\u2717 DSQ create failed: got %d, expected 1\n",
+		       skel->data->dsq_create_result);
+		failed = true;
+	} else {
+		printf("\u2713 DSQ create succeeded\n");
+	}
+
+	printf("Enqueue/dispatch count over %d seconds: %d / %d\n", seconds,
+		skel->data->enqueue_count, skel->data->dispatch_count);
+	printf("Debug: ksym_exists=%d\n",
+	       skel->data->debug_ksym_exists);
+
+	printf("DSQ insert test done on cpu: %d\n", skel->data->insert_test_cpu);
+	if (skel->data->insert_test_cpu != -1)
+		printf("\u2713 DSQ insert succeeded !\n");
+	else {
+		printf("\u2717 DSQ insert failed or not attempted\n");
+		failed = true;
+	}
+
+	printf("  DSQ peek result 1 (before insert): %d\n",
+	       skel->data->dsq_peek_result1);
+	if (skel->data->dsq_peek_result1 == 0)
+		printf("\u2713 DSQ peek verification success: peek returned NULL!\n");
+	else {
+		printf("\u2717 DSQ peek verification failed\n");
+		failed = true;
+	}
+
+	printf("  DSQ peek result 2 (after insert): %ld\n",
+	       skel->data->dsq_peek_result2);
+	printf("  DSQ peek result 2, expected: %ld\n",
+	       skel->data->dsq_peek_result2_expected);
+	if (skel->data->dsq_peek_result2 ==
+	    skel->data->dsq_peek_result2_expected)
+		printf("\u2713 DSQ peek verification success: peek returned the inserted task!\n");
+	else {
+		printf("\u2717 DSQ peek verification failed\n");
+		failed = true;
+	}
+
+	printf("  Inserted test task -> pid: %ld\n", skel->data->dsq_inserted_pid);
+	printf("  DSQ peek result 2 -> pid: %ld\n", skel->data->dsq_peek_result2_pid);
+
+	if (skel->data->dsq_destroy_result != 1) {
+		printf("\u2717 DSQ destroy failed: got %d, expected 1\n",
+		       skel->data->dsq_destroy_result);
+		failed = true;
+	}
+
+	int pid_count;
+
+	pid_count = print_observed_pids(skel->maps.peek_results,
+					skel->data->max_samples, "DSQ pool");
+
+	if (skel->data->debug_ksym_exists && pid_count == 0) {
+		printf("\u2717 DSQ pool test failed: no successful peeks in native mode\n");
+		failed = true;
+	}
+	if (skel->data->debug_ksym_exists && pid_count > 0)
+		printf("\u2713 DSQ pool test success: observed successful peeks in native mode\n");
+
+	if (failed)
+		return SCX_TEST_FAIL;
+	else
+		return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct peek_dsq *skel = ctx;
+
+	if (workload_running) {
+		workload_running = false;
+		for (int i = 0; i < NUM_WORKERS; i++)
+			pthread_join(workload_threads[i], NULL);
+	}
+
+	peek_dsq__destroy(skel);
+}
+
+struct scx_test peek_dsq = {
+	.name = "peek_dsq",
+	.description =
+		"Test DSQ create/destroy operations and future peek functionality",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&peek_dsq)
-- 
2.51.0

