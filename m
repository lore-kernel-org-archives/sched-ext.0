Received: from mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF246A61C
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553306; cv=none; b=nK5fyrmQNAAytPjRmDsLxu4Zl5+iBD/52sagqxeIMJci5q85uGCf7B+5F+ZlR0fu3oomUglvKN0a7AqxOyFVYKQ2HmdoBxOhcxt/AzQpFHaXyL8beToh76i6q3VM4g7IHIlbxOOeH8aNaQ7m4chlQajTIUgMz8WZ0+E4SPsdpCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553306; c=relaxed/simple;
	bh=VZea4IKyd0oZXFfNqTCLAdJ675dx2SHgo1VL3Umyydw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgUaVv05obtpgWS1F3aXgIz82dCPMuhU12pkhKph7yW0nOhzLW2g97wis9ke4TonpwKyJ/vQDHqriZgWzj7YbOEYB8zmzH1qN0+8aPNN68SZVW7vXuQmO3vYFHccJxuJh6WF/QaLDifUIhPbhddwlxlr0aoYaimt31a2PBYbGes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lrby/emE; arc=none smtp.client-ip=91.218.175.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lrby/emE"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=VZea4IKyd0oZXFfNqTCLAdJ675dx2SHgo1VL3Umyydw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791553301; v=1; x=1792158101;
 b=lrby/emEC2ii4ly1D94olf3Jag7nhuqhwto1yAGb4Tgi12ojxInpa3iaiy+61uS+KAqegS0k
 KM/iaha98cDla51dRpD5CrsOvP7IqlRZ06Y/t4d7fj96neQmO3jcZMVGpvAp4763b03f/fGTAUi
 EvTK3lmB7nDahDgD5C8LUT7M=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 684a80784077b820;
	Fri, 09 Oct 2026 13:41:41 +0000
X-Mizu-Trace-ID: 684a80784077b820
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 4/5] selftests/sched_ext: Add SCX_ASSERT_ALIVE and adopt it
Date: Fri,  9 Oct 2026 21:41:03 +0800
Message-ID: <20261009134104.296891-5-cui.tao@linux.dev>
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

A scheduler that dies mid-test freezes the state that the test is
about to assert on, so the assertions can pass vacuously. Add
SCX_ASSERT_ALIVE(), which fails the test with the recorded exit kind
and code, and use it in maximal, create_dsq and init_enable_count.
Existing open-coded checks keep their goto-based cleanup and are not
converted. init_enable_count also clears the uei between its two
attach cycles, since the clean unregister of the first cycle would
otherwise trip the check of the second.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/testing/selftests/sched_ext/create_dsq.bpf.c |  8 ++++++++
 tools/testing/selftests/sched_ext/create_dsq.c     |  2 ++
 .../selftests/sched_ext/init_enable_count.bpf.c    |  8 ++++++++
 .../selftests/sched_ext/init_enable_count.c        | 13 +++++++++++++
 tools/testing/selftests/sched_ext/maximal.bpf.c    |  6 +++++-
 tools/testing/selftests/sched_ext/maximal.c        |  2 ++
 tools/testing/selftests/sched_ext/scx_test.h       | 14 ++++++++++++++
 7 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/create_dsq.bpf.c b/tools/testing/selftests/sched_ext/create_dsq.bpf.c
index 680cc4b6d8c7..24dacd1aab0c 100644
--- a/tools/testing/selftests/sched_ext/create_dsq.bpf.c
+++ b/tools/testing/selftests/sched_ext/create_dsq.bpf.c
@@ -12,6 +12,8 @@ char _license[] SEC("license") = "GPL";
 
 u32 nr_lifecycle_tests;
 
+UEI_DEFINE(uei);
+
 void BPF_STRUCT_OPS(create_dsq_exit_task, struct task_struct *p,
 		    struct scx_exit_task_args *args)
 {
@@ -84,10 +86,16 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(create_dsq_init)
 	return 0;
 }
 
+void BPF_STRUCT_OPS(create_dsq_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
 SEC(".struct_ops.link")
 struct sched_ext_ops create_dsq_ops = {
 	.init_task		= (void *) create_dsq_init_task,
 	.exit_task		= (void *) create_dsq_exit_task,
 	.init			= (void *) create_dsq_init,
+	.exit			= (void *) create_dsq_exit,
 	.name			= "create_dsq",
 };
diff --git a/tools/testing/selftests/sched_ext/create_dsq.c b/tools/testing/selftests/sched_ext/create_dsq.c
index 422e6532ee71..84143d5710f4 100644
--- a/tools/testing/selftests/sched_ext/create_dsq.c
+++ b/tools/testing/selftests/sched_ext/create_dsq.c
@@ -35,6 +35,8 @@ static enum scx_test_status run(void *ctx)
 		return SCX_TEST_FAIL;
 	}
 
+	SCX_ASSERT_ALIVE(skel, uei);
+
 	bpf_link__destroy(link);
 
 	SCX_EQ(skel->bss->nr_lifecycle_tests, 1024);
diff --git a/tools/testing/selftests/sched_ext/init_enable_count.bpf.c b/tools/testing/selftests/sched_ext/init_enable_count.bpf.c
index 5eb9edb1837d..c0a5dd8fe183 100644
--- a/tools/testing/selftests/sched_ext/init_enable_count.bpf.c
+++ b/tools/testing/selftests/sched_ext/init_enable_count.bpf.c
@@ -15,6 +15,8 @@ char _license[] SEC("license") = "GPL";
 u64 init_task_cnt, exit_task_cnt, enable_cnt, disable_cnt;
 u64 init_fork_cnt, init_transition_cnt;
 
+UEI_DEFINE(uei);
+
 s32 BPF_STRUCT_OPS_SLEEPABLE(cnt_init_task, struct task_struct *p,
 			     struct scx_init_task_args *args)
 {
@@ -43,11 +45,17 @@ void BPF_STRUCT_OPS(cnt_disable, struct task_struct *p)
 	__sync_fetch_and_add(&disable_cnt, 1);
 }
 
+void BPF_STRUCT_OPS(cnt_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
 SEC(".struct_ops.link")
 struct sched_ext_ops init_enable_count_ops = {
 	.init_task	= (void *) cnt_init_task,
 	.exit_task	= (void *) cnt_exit_task,
 	.enable		= (void *) cnt_enable,
 	.disable	= (void *) cnt_disable,
+	.exit		= (void *) cnt_exit,
 	.name		= "init_enable_count",
 };
diff --git a/tools/testing/selftests/sched_ext/init_enable_count.c b/tools/testing/selftests/sched_ext/init_enable_count.c
index 44577e30e764..c4a57038a1d6 100644
--- a/tools/testing/selftests/sched_ext/init_enable_count.c
+++ b/tools/testing/selftests/sched_ext/init_enable_count.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
  */
 #include <signal.h>
+#include <string.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <sched.h>
@@ -72,7 +73,17 @@ static enum scx_test_status run_test(bool global)
 	close(pipe_fds[1]);
 	signal(SIGCHLD, SIG_DFL);
 
+	SCX_ASSERT_ALIVE(skel, uei);
+
 	bpf_link__destroy(link);
+
+	/*
+	 * The clean unregister above is recorded in uei and would
+	 * otherwise trip the liveness check of the second cycle, which
+	 * reuses this skeleton.
+	 */
+	memset(&skel->data->uei, 0, sizeof(skel->data->uei));
+
 	SCX_GE(skel->bss->init_task_cnt, num_pre_forks);
 	SCX_GE(skel->bss->exit_task_cnt, num_pre_forks);
 
@@ -124,6 +135,8 @@ static enum scx_test_status run_test(bool global)
 			    status);
 	}
 
+	SCX_ASSERT_ALIVE(skel, uei);
+
 	bpf_link__destroy(link);
 
 	SCX_GE(skel->bss->init_task_cnt, 2 * num_children);
diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
index 04a369078aac..9ea664e2ff70 100644
--- a/tools/testing/selftests/sched_ext/maximal.bpf.c
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -14,6 +14,8 @@ char _license[] SEC("license") = "GPL";
 
 #define DSQ_ID 0
 
+UEI_DEFINE(uei);
+
 s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_struct *p, s32 prev_cpu,
 		   u64 wake_flags)
 {
@@ -132,7 +134,9 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(maximal_init)
 }
 
 void BPF_STRUCT_OPS(maximal_exit, struct scx_exit_info *info)
-{}
+{
+	UEI_RECORD(uei, info);
+}
 
 SEC(".struct_ops.link")
 struct sched_ext_ops maximal_ops = {
diff --git a/tools/testing/selftests/sched_ext/maximal.c b/tools/testing/selftests/sched_ext/maximal.c
index 1dc369224670..6c6b80e0446e 100644
--- a/tools/testing/selftests/sched_ext/maximal.c
+++ b/tools/testing/selftests/sched_ext/maximal.c
@@ -35,6 +35,8 @@ static enum scx_test_status run(void *ctx)
 	link = bpf_map__attach_struct_ops(skel->maps.maximal_ops);
 	SCX_FAIL_IF(!link, "Failed to attach scheduler");
 
+	SCX_ASSERT_ALIVE(skel, uei);
+
 	bpf_link__destroy(link);
 
 	return SCX_TEST_PASS;
diff --git a/tools/testing/selftests/sched_ext/scx_test.h b/tools/testing/selftests/sched_ext/scx_test.h
index fe0e6dabe7a4..aa676cd5bb8d 100644
--- a/tools/testing/selftests/sched_ext/scx_test.h
+++ b/tools/testing/selftests/sched_ext/scx_test.h
@@ -125,6 +125,20 @@ void scx_test_register(struct scx_test *test);
 #define SCX_ASSERT(_x) SCX_FAIL_IF(!(_x), "Expected %s to be true (%lu)",		\
 				   #_x, (u64)(_x))
 
+/*
+ * SCX_ASSERT_ALIVE - Fail the test if the scheduler under test exited
+ * on its own between attach and this check, e.g. from a runtime error.
+ * A scheduler that dies mid-test freezes whatever state the test is
+ * about to assert on, which can make the assertions pass vacuously.
+ */
+#define SCX_ASSERT_ALIVE(__skel, __uei)						\
+	do {									\
+		if (UEI_EXITED(__skel, __uei))					\
+			SCX_FAIL("Scheduler exited unexpectedly (kind=%llu code=%lld)", \
+				 (unsigned long long)(__skel)->data->__uei.kind, \
+				 (long long)(__skel)->data->__uei.exit_code);	\
+	} while (0)
+
 #define SCX_ECODE_VAL(__ecode) ({						\
         u64 __val = 0;								\
 	bool __found = false;							\
-- 
2.53.0

