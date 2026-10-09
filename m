Received: from mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB64DEC0F
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553313; cv=none; b=ahmx5VyaRL1yjj8g1+s8n62dlKgn4mZ2I/R/3MvYNReu2TF2OLnTJHwLbUvLNa4V1jdrt4pWLdvC/LmoWV3LN/93eh6C0lMKxafT+DBM7rQTCHnK6ApWBh9uD3TMumypLC1SPsHq824NmdSlUY21l6JRdOqrEs/o6UDp6/X5udw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553313; c=relaxed/simple;
	bh=QzhstU5Q17ZzXKfFgtb39VvPbogVQOlCGzTyvhor9G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKnGCXznmBaNtcXQKLklUHwBgM5ldQUQJMccDNKEpGLpESg8QkiesFG3HnBv9RHb3vL+Gibm76G63IQFNtRFfJ19mP75KNP6MupAPpm4X8ojnzq52rsSYwV1I1H6sQLu+6F0P3oL/5vtdjwvP50a7D1bQ2yX+gHjG5w3ANDmhTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QreG798l; arc=none smtp.client-ip=91.218.175.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QreG798l"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=QzhstU5Q17ZzXKfFgtb39VvPbogVQOlCGzTyvhor9G8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791553305; v=1; x=1792158105;
 b=QreG798lFnwXaLjmK8OW8v2XbbW32P76SjhEZV8fll43JEmeJgP3ONPaDjaeBV+wryScgu/N
 iXjso4WuUJMRfuSrkXt3RtJbDkkqxMzNvW0Bjo0m+Wqg1n3Q2Ti24gqAuwdtZ+9AQwYwPPxdMpg
 eOvFTNJmo9oA1Pc7b6yfiapM=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 64006636e34c783f;
	Fri, 09 Oct 2026 13:41:45 +0000
X-Mizu-Trace-ID: 64006636e34c783f
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 5/5] selftests/sched_ext: Bound exit waits and report reload_loop failures
Date: Fri,  9 Oct 2026 21:41:04 +0800
Message-ID: <20261009134104.296891-6-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134104.296891-1-cui.tao@linux.dev>
References: <20261009134104.296891-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

exit, prog_run and hotplug wait for the scheduler to exit by spinning
on its uei with no time bound; a scheduler that never exits hangs the
runner instead of failing the test. Bound the waits to ~10s
(iteration-based) with the new SCX_TIMED_WAIT_UEI() helper.

reload_loop skips bpf_map__attach_struct_ops() failures silently:
measured on a loaded host, 1125-1233 of 2048 iterations failed (range across
boots), all with EBUSY (the single scheduler slot changing hands between the two
threads). Count the failures per thread and report them; fail the
test only on unexpected errnos or when every attach failed.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/testing/selftests/sched_ext/exit.c      |  4 +-
 tools/testing/selftests/sched_ext/hotplug.c   | 12 +++--
 tools/testing/selftests/sched_ext/prog_run.c  |  7 ++-
 .../testing/selftests/sched_ext/reload_loop.c | 47 ++++++++++++++++---
 tools/testing/selftests/sched_ext/scx_test.h  | 17 +++++++
 5 files changed, 73 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/exit.c b/tools/testing/selftests/sched_ext/exit.c
index 01b17092d5c8..9270d8e79eb6 100644
--- a/tools/testing/selftests/sched_ext/exit.c
+++ b/tools/testing/selftests/sched_ext/exit.c
@@ -43,8 +43,8 @@ static enum scx_test_status run(void *ctx)
 		}
 
 		/* Assumes uei.kind is written last */
-		while (skel->data->uei.kind == EXIT_KIND(SCX_EXIT_NONE))
-			sched_yield();
+		SCX_FAIL_IF(!SCX_TIMED_WAIT_UEI(skel, uei, 10000),
+			    "Timed out waiting for scheduler to exit");
 
 		SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG_BPF));
 		SCX_EQ(skel->data->uei.exit_code, tc);
diff --git a/tools/testing/selftests/sched_ext/hotplug.c b/tools/testing/selftests/sched_ext/hotplug.c
index 10b8d42bd89b..3c07686a93c8 100644
--- a/tools/testing/selftests/sched_ext/hotplug.c
+++ b/tools/testing/selftests/sched_ext/hotplug.c
@@ -85,8 +85,10 @@ static enum scx_test_status test_hotplug(bool onlining, bool cbs_defined)
 	if (toggle_online_status(onlining ? 1 : 0))
 		goto out_destroy_link;
 
-	while (!UEI_EXITED(skel, uei))
-		sched_yield();
+	if (!SCX_TIMED_WAIT_UEI(skel, uei, 10000)) {
+		SCX_ERR("Timed out waiting for scheduler to exit");
+		goto out_destroy_link;
+	}
 
 	SCX_EQ(skel->data->uei.kind, kind);
 	SCX_EQ(UEI_REPORT(skel, uei), code);
@@ -130,8 +132,10 @@ static enum scx_test_status test_hotplug_attach(void)
 		goto out_destroy_link;
 
 	SCX_ASSERT(link);
-	while (!UEI_EXITED(skel, uei))
-		sched_yield();
+	if (!SCX_TIMED_WAIT_UEI(skel, uei, 10000)) {
+		SCX_ERR("Timed out waiting for scheduler to exit");
+		goto out_destroy_link;
+	}
 
 	kind = SCX_KIND_VAL(SCX_EXIT_UNREG_KERN);
 	code = SCX_ECODE_VAL(SCX_ECODE_ACT_RESTART) |
diff --git a/tools/testing/selftests/sched_ext/prog_run.c b/tools/testing/selftests/sched_ext/prog_run.c
index 1129ec2aaddc..369c744ac06e 100644
--- a/tools/testing/selftests/sched_ext/prog_run.c
+++ b/tools/testing/selftests/sched_ext/prog_run.c
@@ -55,8 +55,11 @@ static enum scx_test_status run(void *ctx)
 	}
 
 	/* Assumes uei.kind is written last */
-	while (skel->data->uei.kind == EXIT_KIND(SCX_EXIT_NONE))
-		sched_yield();
+	if (!SCX_TIMED_WAIT_UEI(skel, uei, 10000)) {
+		SCX_ERR("Timed out waiting for scheduler to exit");
+		status = SCX_TEST_FAIL;
+		goto out;
+	}
 
 	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_UNREG_BPF)) {
 		SCX_ERR("Unexpected exit kind: %llu",
diff --git a/tools/testing/selftests/sched_ext/reload_loop.c b/tools/testing/selftests/sched_ext/reload_loop.c
index ecff86f59e6c..4ae6fb43b6c5 100644
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
@@ -11,8 +12,12 @@
 #include "maximal.bpf.skel.h"
 #include "scx_test.h"
 
+#define RELOAD_ITERS	1024
+#define RELOAD_THREADS	2
+
 static struct maximal *skel;
-static pthread_t threads[2];
+static pthread_t threads[RELOAD_THREADS];
+static int unexpected_errno;
 
 bool force_exit = false;
 
@@ -29,23 +34,36 @@ static enum scx_test_status setup(void **ctx)
 	return SCX_TEST_PASS;
 }
 
+
+
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
+	unsigned long failures = 0;
 	int err;
 	void *ret;
 
@@ -60,7 +78,24 @@ static enum scx_test_status run(void *ctx)
 	}
 
 	SCX_FAIL_IF(pthread_join(threads[0], &ret), "thread 0 failed");
+	failures += (unsigned long)ret;
+
 	SCX_FAIL_IF(pthread_join(threads[1], &ret), "thread 1 failed");
+	failures += (unsigned long)ret;
+
+	SCX_FAIL_IF(unexpected_errno, "unexpected attach errno %d",
+		    unexpected_errno);
+
+	if (failures) {
+		printf("reload_loop: %lu attach failures%s\n",
+		       (unsigned long)failures,
+		       unexpected_errno ? ", unexpected errno" :
+					  " (EBUSY: scheduler slot busy)");
+		fflush(stdout);
+	}
+
+	SCX_FAIL_IF(failures == RELOAD_ITERS * RELOAD_THREADS,
+		    "every attach failed");
 
 	return SCX_TEST_PASS;
 }
diff --git a/tools/testing/selftests/sched_ext/scx_test.h b/tools/testing/selftests/sched_ext/scx_test.h
index aa676cd5bb8d..be63447b8898 100644
--- a/tools/testing/selftests/sched_ext/scx_test.h
+++ b/tools/testing/selftests/sched_ext/scx_test.h
@@ -139,6 +139,23 @@ void scx_test_register(struct scx_test *test);
 				 (long long)(__skel)->data->__uei.exit_code);	\
 	} while (0)
 
+/*
+ * SCX_TIMED_WAIT_UEI - Wait for the scheduler under test to exit, i.e.
+ * its uei to be filled in, for up to @__ms iterations at ~1ms each.
+ * Returns true if the scheduler exited and false on timeout, so a
+ * scheduler that never exits fails the test instead of hanging it.
+ * The bound is iteration-based rather than wall-clock and stretches
+ * on a loaded system instead of failing early.
+ */
+#define SCX_TIMED_WAIT_UEI(__skel, __uei, __ms)					\
+	({									\
+		s64 __left = (__ms);						\
+										\
+		while (__left-- > 0 && !UEI_EXITED(__skel, __uei))		\
+			usleep(1000);						\
+		UEI_EXITED(__skel, __uei) != 0;					\
+	})
+
 #define SCX_ECODE_VAL(__ecode) ({						\
         u64 __val = 0;								\
 	bool __found = false;							\
-- 
2.53.0

