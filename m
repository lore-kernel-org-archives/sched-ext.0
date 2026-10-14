Received: from mta1.migadu.com (out-235.mta1.migadu.com [95.215.58.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B022DCBE3
	for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983628; cv=none; b=GXcoVBAj68HL3gjmOIlgUApif7NEdCzhyVFL84TCamblubDDSlb3PnY+QSwRnQ8ROGoGtwYVLcDkiZ/sacMVcD3qhPDy3E9HOZG4pQL7L5QDSCVqFDQt+HDjm9BQwt8iMh8ozfWBOhMh+FvcMRYjzxVEp6nF9h5X9L8RzCXoi88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983628; c=relaxed/simple;
	bh=uy9lxaNgsBqWjoiNid2RrUG6hWU7b6bcgIk3P4K6D78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TL2B16gTYZKAkSqYYotmjZlccJhKf9KHMtO2/tj+X9wuqYFNAh4W6wTFzjpZ5XxZKXjw5XVQJB6bP0DnY7MVGhFFvTSyE0hFZ/fDzwPVCswPFFdk3xyQqnB53gNY5Pw1ke70tk74NSlJDSs5RpF9/wTnUvbZiCahgcS13VwfsP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ovoBnLAO; arc=none smtp.client-ip=95.215.58.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ovoBnLAO"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=uy9lxaNgsBqWjoiNid2RrUG6hWU7b6bcgIk3P4K6D78=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791983625; v=1; x=1792588425;
 b=ovoBnLAOj8kJ1X4pyxnwFU152P8FxRqk8XlS7DWF2C4cnO4hXTMvQ6uSubjXA+y3WLwMGvD9
 AZ0srBHuUnzVuWXAymB+OwgBI8fZ2H8p6F9Lye0mvSmGr8Ru9HPNJC1M7e7DsFVQM+3SSh5NshK
 0UGSk9OvN6dd+7tMQJajNWHo=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id db890ba061b1e6da;
	Wed, 14 Oct 2026 13:13:44 +0000
X-Mizu-Trace-ID: db890ba061b1e6da
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Tao Cui <cuitao@kylinos.cn>,
	cui.tao@linux.dev
Subject: [PATCH v2 3/6] selftests/sched_ext: Fail loudly when EXIT_KIND is missing from BTF
Date: Wed, 14 Oct 2026 21:13:22 +0800
Message-ID: <20261014131325.793640-4-cui.tao@linux.dev>
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

EXIT_KIND() resolved scx_exit_kind values through
__COMPAT_ENUM_OR_ZERO(), which maps a missing enumerator to 0 (==
SCX_EXIT_NONE). struct scx_exit_info carries the enum itself, so the
BTF of any loaded scheduler always has the type, and every enumerator
the tests resolve today exists on all sched_ext kernels: the fallback
got the value right, and the single comparison that could pass
vacuously was the kick.c error poll.

Still, a silently-zeroed lookup is a trap. EXIT_KIND() is now an
alias of SCX_KIND_VAL(), which fails the test loudly when the
enumerator is missing. Convert the remaining
`kind != EXIT_KIND(SCX_EXIT_NONE)` checks (allowed_cpus,
cgroup_nr_cpus, cyclic_kick_wait and enq_blocked) to UEI_EXITED() so
they keep their semantics without a BTF lookup, and hoist kick.c
invalid_one()'s error_kind resolution above the gated-worker spawn so
a failing lookup cannot bypass its cleanup path. The <unistd.h>
include that the v1 posting added is not needed here; compat.h
already pulls it in.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 .../selftests/sched_ext/allowed_cpus.c        |  2 +-
 .../selftests/sched_ext/cgroup_nr_cpus.c      |  2 +-
 .../selftests/sched_ext/cyclic_kick_wait.c    |  2 +-
 .../testing/selftests/sched_ext/enq_blocked.c |  2 +-
 tools/testing/selftests/sched_ext/kick.c      |  8 ++++---
 tools/testing/selftests/sched_ext/nohz_tick.c |  6 ++---
 tools/testing/selftests/sched_ext/scx_test.h  | 22 ++++++++++++++-----
 7 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/allowed_cpus.c b/tools/testing/selftests/sched_ext/allowed_cpus.c
index 773699d120ea..76311728a6b1 100644
--- a/tools/testing/selftests/sched_ext/allowed_cpus.c
+++ b/tools/testing/selftests/sched_ext/allowed_cpus.c
@@ -149,7 +149,7 @@ static enum scx_test_status run(void *ctx)
 
 	/* Just sleeping is fine, plenty of scheduling events happening. */
 	sleep(1);
-	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE)) {
+	if (UEI_EXITED(skel, uei)) {
 		SCX_ERR("Scheduler exited unexpectedly");
 		goto out;
 	}
diff --git a/tools/testing/selftests/sched_ext/cgroup_nr_cpus.c b/tools/testing/selftests/sched_ext/cgroup_nr_cpus.c
index 4973f7080353..1475a8b3f05f 100644
--- a/tools/testing/selftests/sched_ext/cgroup_nr_cpus.c
+++ b/tools/testing/selftests/sched_ext/cgroup_nr_cpus.c
@@ -400,7 +400,7 @@ static enum scx_test_status run(void *arg)
 	    !wait_nr_cpus(&ctx, ctx.leaf, nr_child, "leaf after cpuset disable"))
 		goto out;
 
-	if (ctx.skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE)) {
+	if (UEI_EXITED(ctx.skel, uei)) {
 		SCX_ERR("Scheduler exited unexpectedly");
 		goto out;
 	}
diff --git a/tools/testing/selftests/sched_ext/cyclic_kick_wait.c b/tools/testing/selftests/sched_ext/cyclic_kick_wait.c
index c2e5aa9de715..178d1d75f332 100644
--- a/tools/testing/selftests/sched_ext/cyclic_kick_wait.c
+++ b/tools/testing/selftests/sched_ext/cyclic_kick_wait.c
@@ -152,7 +152,7 @@ static enum scx_test_status run(void *ctx)
 
 	sleep(5);
 
-	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE)) {
+	if (UEI_EXITED(skel, uei)) {
 		SCX_ERR("Scheduler exited unexpectedly (kind=%llu code=%lld)",
 			(unsigned long long)skel->data->uei.kind,
 			(long long)skel->data->uei.exit_code);
diff --git a/tools/testing/selftests/sched_ext/enq_blocked.c b/tools/testing/selftests/sched_ext/enq_blocked.c
index 26204548bbf0..1d5e090b54bc 100644
--- a/tools/testing/selftests/sched_ext/enq_blocked.c
+++ b/tools/testing/selftests/sched_ext/enq_blocked.c
@@ -844,7 +844,7 @@ static enum scx_test_status run_one(bool enq_blocked, bool cross_cpu,
 		}
 	}
 
-	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE)) {
+	if (UEI_EXITED(skel, uei)) {
 		SCX_ERR("Scheduler exited unexpectedly (kind=%llu code=%lld)",
 			(unsigned long long)skel->data->uei.kind,
 			(long long)skel->data->uei.exit_code);
diff --git a/tools/testing/selftests/sched_ext/kick.c b/tools/testing/selftests/sched_ext/kick.c
index 7f01602c75b2..40c91d54c1eb 100644
--- a/tools/testing/selftests/sched_ext/kick.c
+++ b/tools/testing/selftests/sched_ext/kick.c
@@ -97,7 +97,7 @@ static bool wait_for_state(struct kick *skel, u32 wanted)
 	for (i = 0; i < WAIT_LOOPS; i++) {
 		if (__atomic_load_n(&skel->bss->state, __ATOMIC_ACQUIRE) == wanted)
 			return true;
-		if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE))
+		if (UEI_EXITED(skel, uei))
 			return false;
 		usleep(1000);
 	}
@@ -111,7 +111,7 @@ static bool wait_for_counter(struct kick *skel, const u64 *counter, u64 wanted)
 	for (i = 0; i < WAIT_LOOPS; i++) {
 		if (__atomic_load_n(counter, __ATOMIC_ACQUIRE) >= wanted)
 			return true;
-		if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE))
+		if (UEI_EXITED(skel, uei))
 			return false;
 		usleep(1000);
 	}
@@ -421,7 +421,9 @@ static enum scx_test_status invalid_one(struct kick_ctx *ctx, u32 scenario)
 	enum scx_test_status ret = SCX_TEST_FAIL;
 	int cpu = ctx->target_cpu;
 	int i;
+	u64 error_kind;
 
+	error_kind = EXIT_KIND(SCX_EXIT_ERROR);
 	victim = scx_test_spawn_gated_worker(cpu, false);
 	if (victim.pid < 0)
 		return SCX_TEST_FAIL;
@@ -440,7 +442,7 @@ static enum scx_test_status invalid_one(struct kick_ctx *ctx, u32 scenario)
 		goto out;
 
 	for (i = 0; i < WAIT_LOOPS; i++) {
-		if (skel->data->uei.kind == EXIT_KIND(SCX_EXIT_ERROR)) {
+		if (UEI_EXITED(skel, uei) == error_kind) {
 			ret = SCX_TEST_PASS;
 			break;
 		}
diff --git a/tools/testing/selftests/sched_ext/nohz_tick.c b/tools/testing/selftests/sched_ext/nohz_tick.c
index df40976b9166..e19a97034b7f 100644
--- a/tools/testing/selftests/sched_ext/nohz_tick.c
+++ b/tools/testing/selftests/sched_ext/nohz_tick.c
@@ -165,7 +165,7 @@ static bool wait_for_counter(struct nohz_tick *skel, const u64 *counter, u64 val
 	for (elapsed = 0; elapsed < timeout_ms; elapsed++) {
 		if (__atomic_load_n(counter, __ATOMIC_RELAXED) >= value)
 			return true;
-		if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE))
+		if (UEI_EXITED(skel, uei))
 			return false;
 		usleep(1000);
 	}
@@ -182,7 +182,7 @@ static bool wait_for_tick_stop(struct nohz_tick *skel, const u64 *counter, int t
 		u64 curr;
 
 		usleep(1000);
-		if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE))
+		if (UEI_EXITED(skel, uei))
 			return false;
 		curr = __atomic_load_n(counter, __ATOMIC_RELAXED);
 		if (curr == prev) {
@@ -461,7 +461,7 @@ static enum scx_test_status run(void *ctx_ptr)
 	scx_test_stop_gated_worker(&challenger);
 
 check_exit:
-	if (skel->data->uei.kind != EXIT_KIND(SCX_EXIT_NONE)) {
+	if (UEI_EXITED(skel, uei)) {
 		SCX_ERR("Scheduler exited unexpectedly (kind=%llu code=%lld)",
 			(unsigned long long)skel->data->uei.kind,
 			(long long)skel->data->uei.exit_code);
diff --git a/tools/testing/selftests/sched_ext/scx_test.h b/tools/testing/selftests/sched_ext/scx_test.h
index 90b8d6915bb7..319e67f19b6d 100644
--- a/tools/testing/selftests/sched_ext/scx_test.h
+++ b/tools/testing/selftests/sched_ext/scx_test.h
@@ -18,8 +18,6 @@ enum scx_test_status {
 	SCX_TEST_FAIL,
 };
 
-#define EXIT_KIND(__ent) __COMPAT_ENUM_OR_ZERO("scx_exit_kind", #__ent)
-
 struct scx_test {
 	/**
 	 * name - The name of the testcase.
@@ -119,13 +117,25 @@ void scx_test_register(struct scx_test *test);
 	(s64)__val;								\
 })
 
+/*
+ * SCX_KIND_VAL - Resolve an scx_exit_kind enumerator from kernel BTF.
+ *
+ * Unlike __COMPAT_ENUM_OR_ZERO(), a missing enumerator fails the test
+ * loudly instead of silently resolving to 0 (== SCX_EXIT_NONE), which
+ * would make the comparison vacuous.
+ */
 #define SCX_KIND_VAL(__kind) ({							\
-        u64 __val = 0;								\
-	bool __found = false;							\
+	u64 __val = 0;								\
 										\
-	__found = __COMPAT_read_enum("scx_exit_kind", #__kind, &__val);		\
-	SCX_ASSERT(__found);							\
+	if (!__COMPAT_read_enum("scx_exit_kind", #__kind, &__val))		\
+		SCX_FAIL("scx_exit_kind.%s not found in kernel BTF", #__kind);	\
 	__val;									\
 })
 
+/*
+ * EXIT_KIND - Alias of SCX_KIND_VAL() for resolving scx_exit_kind
+ * enumerator values, kept for readability at the EXIT_KIND() call sites.
+ */
+#define EXIT_KIND(__ent) SCX_KIND_VAL(__ent)
+
 #endif  // # __SCX_TEST_H__
-- 
2.53.0

