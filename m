Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113483A6EE1
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557780; cv=none; b=SRkbOq7+rItlJt0IMUeelsvNC1YVSNHM4o+0xES2YHtfp8lTeSRLa7hVi9uWMbwIyH2J8p6EUquHIxQgP/rf3j5jBjVXSCUcypemGyCurvZmU9M07n1fAdkbrsRkaZlmYVg84z41WTvYjmnlvwo0Ga4wucjCsvn10S+WMNwYNhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557780; c=relaxed/simple;
	bh=ETl5BcbglksFteo5kDYeab5aTtRy2qhdq/fkOmHb96o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utOUuo+xTou4V6A4qV+K+Ed2UrC8cunwG+DyIBT2ZD6/X8wwzvHp8Okr32rphnqy6MYEHtQJGmM2NDJl3jtwuCc708tfPPp1W9qSpGbf/j95Vk8+2jIB7bnJ/qu5c4nKqrD7cWYng8/BddyYN7pmJ0gs/nC1DZqX6cCK70aIi9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8yXNRU9; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8yXNRU9"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c73a5473bbdso627273a12.2
        for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774557778; x=1775162578; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlGZ0nbQG26TwYl+c9kepBTMonB66LTBudTEARXlFvI=;
        b=N8yXNRU9N1+Ir6zeK3ib9/+EN0yYnaaD/gvleDJ1Bw2Umcl1SHc/sCGNvbck/nzfua
         5vcwj/yM3nY442FhsgMBO+gs6fDJaNrJRNYJb/pYg2XUcItRqqC20Xr2XWV9FW9izH9A
         R5wIjtiTnnSLAKmC9hDHPJ2Btn41V+fVLueYIjzxOUsZHq7WdCVr7i37/GV9x7EwWQqX
         ov67J4SGblyE+HK67X0OPJRyE3qGjgTKK9hpmKj/UM4CuZZ8098IexIgCffWCcCvL9dS
         ZJUKOtkc/GM0u7sjdt0cNdLN5EEcQDh9wAH6OCCeTSpiXyrai/DQvzGpQYFAONK2PVTq
         OT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557778; x=1775162578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlGZ0nbQG26TwYl+c9kepBTMonB66LTBudTEARXlFvI=;
        b=k4Jo4yM5iYOjADJJznCQ331s6/gwa5/d2sx3ZXBEWfOyLIvF4odTnWN3o8NR36BaGt
         GJEuVLB7BCoUGKssgK+LKMP5YJ3ffV7Hs+faeYfCLJGAbNau2vOqsC0zEFIhAagKA8HY
         KVafRcJJNvFTLGK6xs+ISFuD69E/ZL1ESadJ1JsmqK5BB+rOMOqR1IoZq+v6YIEjvAaa
         SPaHA0MCToiVhnC94NMmVv3WmrANhQYgbZVPxXhklUHckNqkuDh1FTW0maoSpmXdDL51
         6+7nrxz3pjR7V0AJhRMs7SxX9N7svJ4/xP7NErHCt27ayeLhy85tBHxD70NQtWU5Q0NM
         TxlQ==
X-Gm-Message-State: AOJu0YyNiFPC8SdLJlm6NIxbp28qV8Yqj7uPoqTugoDKZg6Bm/06X7PC
	8GbEYGwfDF5mRt4CuOrlZzIJWTh0sU73vMCe6Hh7nCPW4QgD1O31cIkJrpOZhg==
X-Gm-Gg: ATEYQzwYMNuWRzz+fQxhzKdFJb4KW0uX/pitVXTwTa5TmmaexWMqPepgLov+sOsgphV
	5MwrWLZWDbIIRGhphMMfIHtUXsyZLUehKy8TUky0ldKUaPf1Djzv8h5NKiU7epCEhCrYHW3zTfS
	HjWISLKco7fOnTv253LhK1zpOjDni12ODOCrzuw8N8ltZVIoOeyOpZrDddq+YcmPmhmsZ/0ZS7J
	yo6dx5KDCunoWM2t0sWDP/IwgsVh8FhLhCPbsd6qRLiDHhJpwegPJnYZXdNuBLwarMp3HPdjQ5p
	trBHd1Q20sQrwUDNAUo4KhXdki7eyrxx852WtiMGwj2T+VQ2TWKzp2IdwKiVgT2FOxkgX57Yznh
	G8mHjqd+spf/M+5guuxftmpHs98dQMw2C3b4usDW3HEX+L4mffTZQYxTDt2IhLm2W9nhU8FHuD8
	w+KyLr4vY4/NQL8W6DsZDNOffTZE5uHyfKzBKq2RyaEttmFnOsIsrTS4lY8fAfj+sykTlIEKcrN
	RQ7Pw2OjCnjFg==
X-Received: by 2002:a17:903:1450:b0:2b0:5626:f75d with SMTP id d9443c01a7336-2b0cdcb7d29mr112655ad.26.1774557778157;
        Thu, 26 Mar 2026 13:42:58 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0cbfd17d9sm4004905ad.25.2026.03.26.13.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:42:57 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH 4/4] selftests/sched_ext: consume_immed: fix reliability with CPU affinity
Date: Fri, 27 Mar 2026 04:42:38 +0800
Message-ID: <20260326204238.3755737-5-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326204238.3755737-1-suzhidao@xiaomi.com>
References: <20260326204238.3755737-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two bugs prevented the IMMED slow path from triggering reliably:

1. Dispatch consumed at most one task per ops.dispatch() call.  The IMMED
   slow path requires dsq->nr > 1 in the local DSQ after a
   scx_bpf_dsq_move_to_local() call.  With only one call per dispatch,
   the local DSQ never accumulated two tasks.

   Fix: loop up to 8 times in dispatch, draining USER_DSQ into the local
   DSQ.  On the second iteration the local DSQ already has one task;
   inserting a second raises dsq->nr to 2, triggering schedule_reenq_local
   and calling ops.enqueue() with SCX_TASK_REENQ_IMMED.

2. Workers were not pinned to CPU 0, so the scheduler spread them across
   all CPUs.  USER_DSQ typically had only 0-1 tasks when CPU 0 dispatched,
   so the loop's second iteration rarely found a second task.

   Fix: pin all NUM_WORKERS threads to CPU 0 via
   pthread_attr_setaffinity_np().  With all workers competing for CPU 0,
   USER_DSQ always has a backlog, and every dispatch loop reliably
   accumulates 2+ tasks.

Also move nr_consume_immed_reenq read to after bpf_link__destroy() so
the kernel has fully flushed all counter updates before we check the
assertion.

Fixes: c50dcf533149 ("selftests/sched_ext: Add tests for SCX_ENQ_IMMED and scx_bpf_dsq_reenq()")
Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 .../selftests/sched_ext/consume_immed.bpf.c   | 19 +++++++++++++++----
 .../selftests/sched_ext/consume_immed.c       | 15 ++++++++++++---
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/consume_immed.bpf.c b/tools/testing/selftests/sched_ext/consume_immed.bpf.c
index 9c7808f5abe1..a2a4ee2ee95b 100644
--- a/tools/testing/selftests/sched_ext/consume_immed.bpf.c
+++ b/tools/testing/selftests/sched_ext/consume_immed.bpf.c
@@ -55,10 +55,21 @@ void BPF_STRUCT_OPS(consume_immed_enqueue, struct task_struct *p,
 
 void BPF_STRUCT_OPS(consume_immed_dispatch, s32 cpu, struct task_struct *prev)
 {
-	if (cpu == 0)
-		scx_bpf_dsq_move_to_local(USER_DSQ, SCX_ENQ_IMMED);
-	else
-		scx_bpf_dsq_move_to_local(SCX_DSQ_GLOBAL, 0);
+	int i;
+
+	if (cpu != 0)
+		return;
+
+	/*
+	 * Drain USER_DSQ into the local DSQ with SCX_ENQ_IMMED. Once two or
+	 * more tasks accumulate in the local DSQ, dsq->nr > 1 triggers the
+	 * IMMED slow path (schedule_reenq_local), re-enqueuing IMMED tasks
+	 * through ops.enqueue() with SCX_TASK_REENQ_IMMED.
+	 */
+	for (i = 0; i < 8; i++) {
+		if (!scx_bpf_dsq_move_to_local(USER_DSQ, SCX_ENQ_IMMED))
+			break;
+	}
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(consume_immed_init)
diff --git a/tools/testing/selftests/sched_ext/consume_immed.c b/tools/testing/selftests/sched_ext/consume_immed.c
index 7f9594cfa9cb..41e66cd5e879 100644
--- a/tools/testing/selftests/sched_ext/consume_immed.c
+++ b/tools/testing/selftests/sched_ext/consume_immed.c
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <pthread.h>
+#include <sched.h>
 #include <bpf/bpf.h>
 #include <scx/common.h>
 #include "consume_immed.bpf.skel.h"
@@ -77,20 +78,28 @@ static enum scx_test_status run(void *ctx)
 
 	stop_workers = false;
 	for (i = 0; i < NUM_WORKERS; i++) {
-		SCX_FAIL_IF(pthread_create(&workers[i], NULL, worker_fn, NULL),
+		pthread_attr_t attr;
+		cpu_set_t cpuset;
+
+		pthread_attr_init(&attr);
+		CPU_ZERO(&cpuset);
+		CPU_SET(0, &cpuset);
+		pthread_attr_setaffinity_np(&attr, sizeof(cpuset), &cpuset);
+		SCX_FAIL_IF(pthread_create(&workers[i], &attr, worker_fn, NULL),
 			    "Failed to create worker %d", i);
+		pthread_attr_destroy(&attr);
 	}
 
 	sleep(TEST_DURATION_SEC);
 
-	reenq = skel->bss->nr_consume_immed_reenq;
-
 	stop_workers = true;
 	for (i = 0; i < NUM_WORKERS; i++)
 		pthread_join(workers[i], NULL);
 
 	bpf_link__destroy(link);
 
+	reenq = skel->bss->nr_consume_immed_reenq;
+
 	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG));
 	SCX_GT(reenq, 0);
 
-- 
2.43.0

