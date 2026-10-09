Received: from mta0.migadu.com (out-208.mta0.migadu.com [91.218.175.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC004DAF96
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553301; cv=none; b=bLV3M3H5/4t86rxuE9PnU9crUVV8+t3NtsP9aoZZ8Y2BWAFMNJyMm+K3rfBjcAgm2ENmasbZ4C1B7F7z8iSTuGxz9FMhcHHGMV4EhSI9ie6WR31tQ33ljkjYlYxGIASn32n3hmAQPMwI23f726K31PCh94f3/v+YO4gnbZYOyIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553301; c=relaxed/simple;
	bh=YC36J0RV1Y4GC1UnjXtVMuzi68LkLuS2F/i3P2WjQnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8Tk0bj4MnS1m7XoQ/dYLF+w5Tg3x4NVLme/DWW7DRfOWJht8bxP/gSakUVTvgY3NSVKy3yZ10NyGJkw3LpsUoPkAosMxarVkpQ9FYqP4R5UfPNsOPs9g6nSGqTpAWyEPJzFwPST1tFg/OI/BpcatGySBcMPswcckdufhHLnXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=geB86uoj; arc=none smtp.client-ip=91.218.175.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="geB86uoj"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=YC36J0RV1Y4GC1UnjXtVMuzi68LkLuS2F/i3P2WjQnY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791553294; v=1; x=1792158094;
 b=geB86uojFKJpmoPpzaDKkvUfkJsoJpY7Yn+PtnXBEhF5aU5PJFRWOnuPh2NPhPXoWVnx94GY
 ifIBcxo9RuHNrHZGHwJB/UERVIDRbmiRovGsbXodJwB9w5Bxk4jWyBTr8mC7Puzl3/9wDfmIo8K
 98olWD233kBUKcdT+C17hmhs=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 94b4e816a7a2417e;
	Fri, 09 Oct 2026 13:41:34 +0000
X-Mizu-Trace-ID: 94b4e816a7a2417e
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 3/5] selftests/sched_ext: Fail loudly when EXIT_KIND is missing from BTF
Date: Fri,  9 Oct 2026 21:41:02 +0800
Message-ID: <20261009134104.296891-4-cui.tao@linux.dev>
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

EXIT_KIND() resolves scx_exit_kind values through
__COMPAT_ENUM_OR_ZERO(), which maps a missing enum to 0. 0 is
SCX_EXIT_NONE, so on kernels whose BTF lacks the enum every
EXIT_KIND() comparison is meaningless.

Resolve the value with __COMPAT_read_enum() and fail the running test
when it is missing, matching SCX_ECODE_VAL() and SCX_KIND_VAL(). The
kick and nohz_tick polling helpers switch to UEI_EXITED() so they
keep their semantics without a BTF lookup.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/testing/selftests/sched_ext/kick.c      |  8 +++++---
 tools/testing/selftests/sched_ext/nohz_tick.c |  6 +++---
 tools/testing/selftests/sched_ext/scx_test.h  | 17 ++++++++++++++++-
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/kick.c b/tools/testing/selftests/sched_ext/kick.c
index 7f01602c75b2..591c250d475d 100644
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
@@ -421,6 +421,7 @@ static enum scx_test_status invalid_one(struct kick_ctx *ctx, u32 scenario)
 	enum scx_test_status ret = SCX_TEST_FAIL;
 	int cpu = ctx->target_cpu;
 	int i;
+	u64 error_kind;
 
 	victim = scx_test_spawn_gated_worker(cpu, false);
 	if (victim.pid < 0)
@@ -435,12 +436,13 @@ static enum scx_test_status invalid_one(struct kick_ctx *ctx, u32 scenario)
 	bpf_program__set_autoload(skel->progs.kick_wait_callback, false);
 	if (kick__load(skel))
 		goto out;
+	error_kind = EXIT_KIND(SCX_EXIT_ERROR);
 	ops_link = bpf_map__attach_struct_ops(skel->maps.kick_ops);
 	if (!ops_link || !scx_test_start_gated_worker(&victim))
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
index 90b8d6915bb7..fe0e6dabe7a4 100644
--- a/tools/testing/selftests/sched_ext/scx_test.h
+++ b/tools/testing/selftests/sched_ext/scx_test.h
@@ -9,6 +9,7 @@
 #define __SCX_TEST_H__
 
 #include <errno.h>
+#include <unistd.h>
 #include <scx/common.h>
 #include <scx/compat.h>
 
@@ -18,7 +19,21 @@ enum scx_test_status {
 	SCX_TEST_FAIL,
 };
 
-#define EXIT_KIND(__ent) __COMPAT_ENUM_OR_ZERO("scx_exit_kind", #__ent)
+/*
+ * EXIT_KIND - Resolve an scx_exit_kind enum value from kernel BTF.
+ *
+ * __COMPAT_ENUM_OR_ZERO() silently maps a missing enum to 0, which for
+ * exit kinds is indistinguishable from SCX_EXIT_NONE and would make
+ * every EXIT_KIND() comparison pass vacuously. Fail the test loudly
+ * instead, mirroring SCX_ECODE_VAL() and SCX_KIND_VAL() below.
+ */
+#define EXIT_KIND(__ent) ({							\
+	u64 __val = 0;								\
+										\
+	if (!__COMPAT_read_enum("scx_exit_kind", #__ent, &__val))		\
+		SCX_FAIL("scx_exit_kind.%s not found in kernel BTF", #__ent);	\
+	__val;									\
+})
 
 struct scx_test {
 	/**
-- 
2.53.0

