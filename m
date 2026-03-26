Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DE37B012
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774492122; cv=none; b=SpIJW/GQ47ojBsYxhTgnYTc5qyyRpYDQryoDl0oxYHUEcfFetbo4Uc8D+RNH8dIZLHAx6A9lLDBgVU6ktIVtyJGhiKE97DVJbdx6bxL9Y/aLjGYn3d4tziEQK02UsR05N5m6UKyEzipcTQXkljf3FdG91D3/LR/WmCECejdqkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774492122; c=relaxed/simple;
	bh=jKdTw/n54Y2ZNRZt3VQZric/iIugGGXpzoEO5uIeo3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFNB/MdhNr0DWMGhL3dW1NC8ikCGJ1t8+Az+3stCMsBrnstr2RzsnzzENcol0fp+whFXnyC5/O7hgtHbkdws2UgcqheXu3CbS7uVdTkwyep2tJYL1+hckslQ32iuReWeg4qmCe22fNY3mv4+fBTuWD/77AieFsLw5ONtn2Xbr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oSU3WON8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSU3WON8"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b0586d5bb8so3293705ad.3
        for <sched-ext@lists.linux.dev>; Wed, 25 Mar 2026 19:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774492120; x=1775096920; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9hhbyS9TRlvfiXJwNyVeX4CKdIK2TUqCnSVLrd2ANY=;
        b=oSU3WON8RkhiYMuPJdrxY6UTuGDZWoBsX8ayuQtk90pLlHKh9sF3BJngf8HIhAdDOx
         DejfHq7gyFgJSlfWwqaMNmCHCLis8wsPSw+1DUo9W1aP2bmdz1Zj2mci3zN3yeoclnkC
         7QWipSPZ+jYe4qqUMXjJ9v58NiZCucsimVZoKQG8apT/mmJ3a8ZrLe63s2hKPW1oW7pG
         FmQUxQ6zwbfxqIcnpgOeizqiLQa7BnuKz9laggLBIuNlBXy2+IDx1cgopeoTo1D010uF
         1S2uTYiXbOt4oliT65KzzS8E8WDi2nKzRsg5+j19kMSlLeTGiMtjwdDyloVGRfNFakMz
         3D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774492120; x=1775096920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T9hhbyS9TRlvfiXJwNyVeX4CKdIK2TUqCnSVLrd2ANY=;
        b=WYEgQjG35C5bt79i8+Pxg9fZ8VrrPnYb37p+en/tOhnodzHEkOHK+5C1jgRraiiSk5
         EMSmwz2yUAMFpXIWlXo4yojruaK0oVxYQYKyONmuREuQQfmjtAg3ZuOHU+7r3K+UBMev
         ONeu6sW5B0pu3D0Wkd0vjPlJB+OcJ4o35zcTIeCkM69CrLmy8Cq6nvcGyfZAsW+YqjY8
         rRjqyeEFEnzCRvegYfs9q+pLMu0bKWc9LzPNeV4MYjQGcw9NX/pp317Q4EVDjnZbU6wF
         ExKO1MsctoP+zrs9DYFZuWyGFStCxB3lmBwtPw7xfTiUHo8crJ/b1fN3I6yChXe1Ywwo
         Ixfw==
X-Gm-Message-State: AOJu0YxlixoqZVfZMwHHZWLXojUnu1MghuOUcWkM/2F9DE5z13GGBBKt
	ww6ys2U5qbilOzCHe3c7ZWNci4N+LDnXd8VI2Pijo0ft8Df590LYm80Yd9VJZA==
X-Gm-Gg: ATEYQzysy1jhjlGK5rtWpN/B3kjnX9xHz0v4Y9KNrY376FLeUwwEDxPFt42trP2O8I6
	uk9HeH6ZVQlpwoejvsJKRRSbNRh3YqAvazfQSIArXxylLaRvx67mzvQ0iaW4YfXo+WjQH8Xqfjv
	6sfiLnF9pXxsXNOc9hM6G5KzRGoQ/d1JQ81llEiErfrRXIfJkU12Hna8SBFied81nhrsAcxAZ+f
	uuG4QPb+84GNiqbhLDgZN9CVuF4db2y00RISQeJ99diYhJdf7DNf1BPAgQcEfh0SfYO2NYXDdQB
	AM4SAij5lQDNXEr4pldRvPzpwdPKr4Nqs+cH66/b9zpmxod4xJe9h8oywELXfj6QOPlLz0493RK
	EY5NFudZjlti/YdCAuDSS0oGS7pqpNa0f3oRcwbAup59QczMvearnl2YSkEwS2E/a9A/hzi6D60
	fj3CT/KKn1PDOoXWV72C/JW4dLEaRREJj9eS/HzpKLpW5HbVbLTek93XIDzoEUr1miogngv+qae
	F8=
X-Received: by 2002:a17:902:ef01:b0:2ae:d09c:5241 with SMTP id d9443c01a7336-2b0b0a0fb56mr64546785ad.2.1774492120141;
        Wed, 25 Mar 2026 19:28:40 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76f184sm12969355ad.9.2026.03.25.19.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 19:28:39 -0700 (PDT)
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
Subject: [PATCH 3/3] selftests/sched_ext: Fix consume_immed test reliability
Date: Thu, 26 Mar 2026 10:28:27 +0800
Message-ID: <20260326022827.3826287-3-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326022827.3826287-1-suzhidao@xiaomi.com>
References: <20260326022827.3826287-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The consume_immed test was failing because nr_consume_immed_reenq
stayed 0. Two issues:

1. Workers were spread across CPUs, so CPU 0's local DSQ rarely
   accumulated multiple tasks. Fix: pin all workers to CPU 0 and
   increase NUM_WORKERS to 8 to ensure USER_DSQ is always backlogged.

2. ops.dispatch() called scx_bpf_dsq_move_to_local() only once, so
   CPU 0's local DSQ would contain exactly 1 task after dispatch.
   The IMMED slow path requires dsq->nr > 1 at the time of insertion
   (in dsq_inc_nr()), so a single dispatch call never triggers it.

   Fix: call scx_bpf_dsq_move_to_local() in a loop (up to 4 times)
   within a single ops.dispatch() invocation. The second call finds
   dsq->nr already 1, so dsq->nr increments to 2, triggering
   schedule_reenq_local() and the IMMED slow path.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 .../selftests/sched_ext/consume_immed.bpf.c   | 25 ++++++++++++++-----
 .../selftests/sched_ext/consume_immed.c       | 14 ++++++++++-
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/consume_immed.bpf.c b/tools/testing/selftests/sched_ext/consume_immed.bpf.c
index 9c7808f5abe1..e99bea0b2c24 100644
--- a/tools/testing/selftests/sched_ext/consume_immed.bpf.c
+++ b/tools/testing/selftests/sched_ext/consume_immed.bpf.c
@@ -11,9 +11,9 @@
  *                   explicit SCX_ENQ_IMMED in enq_flags (requires v2 kfunc)
  *
  * Worker threads belonging to test_tgid are inserted into USER_DSQ.
- * ops.dispatch() on CPU 0 consumes from USER_DSQ with SCX_ENQ_IMMED.
- * With multiple workers competing for CPU 0, dsq->nr > 1 triggers the
- * IMMED slow path (reenqueue with SCX_TASK_REENQ_IMMED).
+ * ops.dispatch() on CPU 0 consumes multiple tasks from USER_DSQ with
+ * SCX_ENQ_IMMED in a single dispatch call, causing dsq->nr to exceed 1
+ * and triggering the IMMED slow path (reenqueue with SCX_TASK_REENQ_IMMED).
  *
  * Requires scx_bpf_dsq_move_to_local___v2() (v7.1+) for enq_flags support.
  */
@@ -55,10 +55,23 @@ void BPF_STRUCT_OPS(consume_immed_enqueue, struct task_struct *p,
 
 void BPF_STRUCT_OPS(consume_immed_dispatch, s32 cpu, struct task_struct *prev)
 {
-	if (cpu == 0)
-		scx_bpf_dsq_move_to_local(USER_DSQ, SCX_ENQ_IMMED);
-	else
+	int i;
+
+	if (cpu != 0) {
 		scx_bpf_dsq_move_to_local(SCX_DSQ_GLOBAL, 0);
+		return;
+	}
+
+	/*
+	 * Move multiple tasks into CPU 0's local DSQ with SCX_ENQ_IMMED in a
+	 * single dispatch call. When the second task is inserted (dsq->nr > 1),
+	 * dsq_inc_nr() triggers the IMMED slow path via schedule_reenq_local(),
+	 * which calls ops.enqueue() with SCX_ENQ_REENQ | SCX_TASK_REENQ_IMMED.
+	 */
+	for (i = 0; i < 4; i++) {
+		if (!scx_bpf_dsq_move_to_local(USER_DSQ, SCX_ENQ_IMMED))
+			break;
+	}
 }
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(consume_immed_init)
diff --git a/tools/testing/selftests/sched_ext/consume_immed.c b/tools/testing/selftests/sched_ext/consume_immed.c
index 7f9594cfa9cb..61cbc0fe3663 100644
--- a/tools/testing/selftests/sched_ext/consume_immed.c
+++ b/tools/testing/selftests/sched_ext/consume_immed.c
@@ -12,18 +12,30 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <pthread.h>
+#include <sched.h>
 #include <bpf/bpf.h>
 #include <scx/common.h>
 #include "consume_immed.bpf.skel.h"
 #include "scx_test.h"
 
-#define NUM_WORKERS		4
+/*
+ * Use more workers than CPUs, all pinned to CPU 0, so CPU 0's local DSQ
+ * accumulates multiple IMMED tasks at once, reliably triggering the slow path.
+ */
+#define NUM_WORKERS		8
 #define TEST_DURATION_SEC	3
 
 static volatile bool stop_workers;
 
 static void *worker_fn(void *arg)
 {
+	cpu_set_t cpuset;
+
+	/* Pin to CPU 0 to saturate its local DSQ */
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+	pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
+
 	while (!stop_workers) {
 		volatile unsigned long i;
 
-- 
2.43.0

