Received: from mta0.migadu.com (out-57.mta0.migadu.com [91.218.175.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1634E38398F
	for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983643; cv=none; b=MWeWM0W86tnyUysSPDdbDBb+5RiSEbHvy5gnUv7rDMT/dSWaxM/65wLnnyi34ln9bibc0KHCffFjQe+0gNACVF9R14u2DeXu02B71EYtBlSZWVfXoqEkEBoO8Upq6wVvIZpMciujdsz4YsAb8+9g6GjaKUZ24t+UJHDkFGOPS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983643; c=relaxed/simple;
	bh=5z5xNgvH8YEoYD/rtmBXzBEmdyHIqjS8kHTJ9OZ1pzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tx4CKxhuhCNtFRvD+fZZVsL19erHV7FSPicWvVaPvs0JmOjD9AIq2AFjhsXKhDrihWM0b3FyzGfGcK/lzSeMkH0ipDd5Odn4QC8iiFBiNr1EsbVJFfKHRhFaiB98ZtmNoiOY2X/rh2qSZvAFwGJMAYqeJUY8DbMSjPjTJWCFewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CBOqQK39; arc=none smtp.client-ip=91.218.175.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CBOqQK39"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=5z5xNgvH8YEoYD/rtmBXzBEmdyHIqjS8kHTJ9OZ1pzM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791983640; v=1; x=1792588440;
 b=CBOqQK39vmsvXw8LzjIbFYNXagXZwOgCn9a6QFrKpJOD7m1p7MXwdOZvo0D9sfTvo4MubxXW
 1b055CEQC1D2n9kVbFCEC9A6l7YgVEJlzA+F0mTM7ftNCm45qFRr4tjA5otU8XTQmRqFE3+vfMR
 M85gZEw5/IUZ7MuUckRc+lMY=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 0b0d43f562d5e3bb;
	Wed, 14 Oct 2026 13:14:00 +0000
X-Mizu-Trace-ID: 0b0d43f562d5e3bb
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Tao Cui <cuitao@kylinos.cn>,
	cui.tao@linux.dev
Subject: [PATCH v2 6/6] selftests/sched_ext: Report reload_loop attach failures
Date: Wed, 14 Oct 2026 21:13:25 +0800
Message-ID: <20261014131325.793640-7-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014131325.793640-1-cui.tao@linux.dev>
References: <20261014131325.793640-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

reload_loop skips bpf_map__attach_struct_ops() failures silently:
measured on a loaded host, 1125-1233 of 2048 iterations failed, all
with EBUSY (the single scheduler slot changing hands between the two
threads) - the test passed while roughly half of its iterations never
ran.

Count the failures per thread, recording any errno other than EBUSY
separately. Fail the test on an unexpected errno or when a thread
failed every attach; a thread that completed at least one attach has
exercised the reload path, so ordinary EBUSY no longer prints on
every run. The iteration and thread counts move from #defines to an
enum, and two stray blank lines after setup() are dropped.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 .../testing/selftests/sched_ext/reload_loop.c | 43 ++++++++++++++++---
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/reload_loop.c b/tools/testing/selftests/sched_ext/reload_loop.c
index a00f3964dba0..7d8880fa1a03 100644
--- a/tools/testing/selftests/sched_ext/reload_loop.c
+++ b/tools/testing/selftests/sched_ext/reload_loop.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2024 David Vernet <dvernet@meta.com>
  */
 #include <bpf/bpf.h>
+#include <errno.h>
 #include <pthread.h>
 #include <scx/common.h>
 #include <sys/wait.h>
@@ -11,8 +12,14 @@
 #include "maximal.bpf.skel.h"
 #include "scx_test.h"
 
+enum {
+	RELOAD_ITERS	= 1024,
+	RELOAD_THREADS	= 2,
+};
+
 static struct maximal *skel;
-static pthread_t threads[2];
+static pthread_t threads[RELOAD_THREADS];
+static int unexpected_errno;
 
 bool force_exit = false;
 
@@ -31,22 +38,33 @@ static enum scx_test_status setup(void **ctx)
 
 static void *do_reload_loop(void *arg)
 {
-	u32 i;
+	u32 i, failures = 0;
 
-	for (i = 0; i < 1024 && !force_exit; i++) {
+	for (i = 0; i < RELOAD_ITERS && !force_exit; i++) {
 		struct bpf_link *link;
 
+		errno = 0;
 		link = bpf_map__attach_struct_ops(skel->maps.maximal_ops);
-		if (link)
-			bpf_link__destroy(link);
+		if (!link) {
+			int e = errno;
+
+			if (e != EBUSY)
+				__atomic_store_n(&unexpected_errno, e,
+						 __ATOMIC_RELAXED);
+			failures++;
+			continue;
+		}
+
+		bpf_link__destroy(link);
 	}
 
-	return NULL;
+	return (void *)(unsigned long)failures;
 }
 
 static enum scx_test_status run(void *ctx)
 {
-	int err;
+	unsigned long failures[RELOAD_THREADS] = {};
+	int err, i;
 	void *ret;
 
 	err = pthread_create(&threads[0], NULL, do_reload_loop, NULL);
@@ -60,7 +78,18 @@ static enum scx_test_status run(void *ctx)
 	}
 
 	SCX_FAIL_IF(pthread_join(threads[0], &ret), "thread 0 failed");
+	failures[0] = (unsigned long)ret;
+
 	SCX_FAIL_IF(pthread_join(threads[1], &ret), "thread 1 failed");
+	failures[1] = (unsigned long)ret;
+
+	SCX_FAIL_IF(unexpected_errno, "unexpected attach errno %d",
+		    unexpected_errno);
+
+	for (i = 0; i < RELOAD_THREADS; i++)
+		SCX_FAIL_IF(failures[i] == RELOAD_ITERS,
+			    "thread %d: every attach failed (%lu EBUSY)",
+			    i, failures[i]);
 
 	return SCX_TEST_PASS;
 }
-- 
2.53.0

