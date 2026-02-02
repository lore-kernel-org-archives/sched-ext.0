Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD5A303A37;
	Mon,  2 Feb 2026 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061224; cv=none; b=gXGn7fL6tCH2qcvahoyPjHnoqrk2zJbZgv5h9KfmtlpUwBqHdB/kFDCQeDBBRIZTun2jU0QVqwZw4fhLNpMNkX2Na8LujiMT4HZktsNgQna+TUy7KgfvMl6g6U0jSaBbggK9DB7NRuUNwqo+wuvRAcN1BS06EbmVHY0L/Ykv2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061224; c=relaxed/simple;
	bh=hEw7T2+5cUCWA/rrF46ZDF/Lb/3f2DSqHFyyZzcNOL8=;
	h=Date:Message-ID:From:To:Cc:Subject; b=FbaJISt3BmyVVMpMu8dOXg3yJ5VL6IetXqzUeqkgOwlfyXIHPYEl4UcnaWsIxuuDzE6HL/qCGLRDhUG12vkiReBzdsfS2ReqF19ueKXaXxCaL17sf6QC2NM7V/EAHb6dxJrgyuHWHHUxmm3WhuKTtCCBuxMvCxydikvpuf06yWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIFjKsLy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIFjKsLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903B7C116C6;
	Mon,  2 Feb 2026 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770061223;
	bh=hEw7T2+5cUCWA/rrF46ZDF/Lb/3f2DSqHFyyZzcNOL8=;
	h=Date:From:To:Cc:Subject:From;
	b=KIFjKsLyAVi8J0rbvT3stDMFb5sf/3C6FUHc7S3QAkOHSQxQ/cIkvRMJLVdQ4Qhqw
	 70ZoCzOu3HZfh9lO2weW4oUCb3HArnT24eh4vif2P0e996IsYjSiuRosLqoEdoQHAI
	 pm3QhkbgCcAdFtPzKZnVY+FOVmpr4ZGqB60W0FRFR2asIuDaRlxBpRDncSRCNy7QGt
	 fU+ffNA3guefFJzPIHZRCieErsU0o4KklVg2l7gku50mhpYzmY3HsUx46EJBNi71kV
	 3BBDasV8DWOSWRsam1sbGppth6Q87pfXqAVclk5Fne36aAYXgkrn3xCjA8i03mx5L6
	 MrO/KETOnrsVQ==
Date: Mon, 02 Feb 2026 09:40:22 -1000
Message-ID: <03982d7b5642c0ad003668178f9e5df7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.20] selftests/sched_ext: Fix init_enable_count
 flakiness
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

The init_enable_count test is flaky. The test forks 1024 children before
attaching the scheduler to verify that existing tasks get ops.init_task()
called. The children were using sleep(1) before exiting.

7900aa699c34 ("sched_ext: Fix cgroup exit ordering by moving sched_ext_free()
to finish_task_switch()") changed when tasks are removed from scx_tasks -
previously when the task_struct was freed, now immediately in
finish_task_switch() when the task dies.

Before the commit, pre-forked children would linger on scx_tasks until freed
regardless of when they exited, so the scheduler would always see them during
iteration. The sleep(1) was unnecessary. After the commit, children are
removed as soon as they die. The sleep(1) masks the problem in most cases but
the test becomes flaky depending on timing.

Fix by synchronizing properly using a pipe. All children block on read() and
the parent signals them to exit by closing the write end after attaching the
scheduler. The children are auto-reaped so there's no need to wait on them.

Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: David Vernet <void@manifault.com>
Cc: Andrea Righi <arighi@nvidia.com>
Cc: Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/testing/selftests/sched_ext/init_enable_count.c |   34 ++++++++++++------
 1 file changed, 23 insertions(+), 11 deletions(-)

--- a/tools/testing/selftests/sched_ext/init_enable_count.c
+++ b/tools/testing/selftests/sched_ext/init_enable_count.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2023 David Vernet <dvernet@meta.com>
  * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
  */
+#include <signal.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <sched.h>
@@ -23,6 +24,9 @@ static enum scx_test_status run_test(boo
 	int ret, i, status;
 	struct sched_param param = {};
 	pid_t pids[num_pre_forks];
+	int pipe_fds[2];
+
+	SCX_FAIL_IF(pipe(pipe_fds) < 0, "Failed to create pipe");

 	skel = init_enable_count__open();
 	SCX_FAIL_IF(!skel, "Failed to open");
@@ -38,26 +42,34 @@ static enum scx_test_status run_test(boo
 	 * ensure (at least in practical terms) that there are more tasks that
 	 * transition from SCHED_OTHER -> SCHED_EXT than there are tasks that
 	 * take the fork() path either below or in other processes.
+	 *
+	 * All children will block on read() on the pipe until the parent closes
+	 * the write end after attaching the scheduler, which signals all of
+	 * them to exit simultaneously. Auto-reap so we don't have to wait on
+	 * them.
 	 */
+	signal(SIGCHLD, SIG_IGN);
 	for (i = 0; i < num_pre_forks; i++) {
-		pids[i] = fork();
-		SCX_FAIL_IF(pids[i] < 0, "Failed to fork child");
-		if (pids[i] == 0) {
-			sleep(1);
+		pid_t pid = fork();
+
+		SCX_FAIL_IF(pid < 0, "Failed to fork child");
+		if (pid == 0) {
+			char buf;
+
+			close(pipe_fds[1]);
+			read(pipe_fds[0], &buf, 1);
+			close(pipe_fds[0]);
 			exit(0);
 		}
 	}
+	close(pipe_fds[0]);

 	link = bpf_map__attach_struct_ops(skel->maps.init_enable_count_ops);
 	SCX_FAIL_IF(!link, "Failed to attach struct_ops");

-	for (i = 0; i < num_pre_forks; i++) {
-		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
-			    "Failed to wait for pre-forked child\n");
-
-		SCX_FAIL_IF(status != 0, "Pre-forked child %d exited with status %d\n", i,
-			    status);
-	}
+	/* Signal all pre-forked children to exit. */
+	close(pipe_fds[1]);
+	signal(SIGCHLD, SIG_DFL);

 	bpf_link__destroy(link);
 	SCX_GE(skel->bss->init_task_cnt, num_pre_forks);
