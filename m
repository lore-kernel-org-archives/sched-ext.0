Received: from out-utut-a192.jellyfish.systems (out-utut-a192.jellyfish.systems [198.177.127.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C88346FA1
	for <sched-ext@lists.linux.dev>; Sun,  6 Sep 2026 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.177.127.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788705667; cv=none; b=NU653Y36Ubf3U4m3KPpga9Vvr6FEWlHI5RDFGWdyYs2sT+FQZ2G21NnmmCfAY8M/giGCx8dr+YbpTNc3c0WiyUD0P8JtTiQHTqSAsV3VRm5TotgCxquK16kDdxqo2TOcTmhvux2IkBFXzxRMJ5M52rhpmzlyXIKKC737CQGdClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788705667; c=relaxed/simple;
	bh=8nFx9yPRzKaj16U/gthA6bI9cl20f2jVshwFSMAEEek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJFOdYvgQ+cPlFCws3TtgTNRb13T4KANlcrH0blJk2EfqjFSm+HLbogzUFh88ycsnYKiH+rbeR3LT9jWfpOT30Yvz53paitG4nwpUH+7P6rfNbBq2MR/WiHUQq3WfWvrEF/NnFCPT7t4tey/KLONgLhRz6gbHXXQM5+k3q7K9H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=iM1agAwn; arc=none smtp.client-ip=198.177.127.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="iM1agAwn"
Received: from fedora (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdCYg3XcBz8sXt;
	Sun, 06 Sep 2026 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788705659;
	bh=j4yMbUzC3JdQhfwbNkbQdD8PV1ZrYrHZIUWMMMM+we8=;
	h=From:To:Cc:Subject:Date:From;
	b=iM1agAwndDus86sCchyIgLCK9fbtXHookdsMXs/FyWf/UuVXihRPpYXpa/K0D7IpZ
	 pM4ZuuloEIGYPimeRgwWjtU6AXaSBd3SBGcYHvFIRmmwPaoUZ3AcI4zWwjFolA8+aj
	 cG89hFlO5uEYlXkHDX75Tl5ZXvtMdseMWVXWltX9Ldv/X/F8su0ithbkjWOOJvuUKf
	 EYQGtnF3e2dsHm3Ga+IDEyRHkSfP7Oa3FLkmmbtU1puSlsvEZAJ+OuszcGqR+uUybM
	 uKQLRwbKk2/k4urS+eC3sfNL84/atr99fpGHh+CbbJbbxtlFsmPxutT6qiV/39ePn0
	 VEUsrTT3+GI4A==
From: Tianyi Chen <hi@tychen.cc>
To: tj@kernel.org,
	David Vernet <void@manifault.com>
Cc: Tianyi Chen <hi@tychen.cc>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/sched_ext: Cover duplicate DSQ creation and ID reuse
Date: Sun,  6 Sep 2026 22:40:44 +0800
Message-ID: <20260906144044.849222-1-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

The create_dsq test creates and destroys queues, but does not check the
-EEXIST contract for duplicate creation or whether the ID remains
accessible after the failed operation.

Extend the existing lifecycle loop to reject duplicate creation and
check that the empty queue is still accessible. After destruction,
require -ENOENT from the queue lookup, then recreate and destroy the
same ID. Check that all 1024 iterations complete.

This exercises empty queues during initialization, without concurrent
enqueueing or destruction of a nonempty queue. The create_dsq test
passes on a two-CPU matching-kernel VM.

Link: https://lore.kernel.org/all/Z-OZ7tJWhRZbUk1l@gpd3/
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../selftests/sched_ext/create_dsq.bpf.c      | 35 +++++++++++++++++++
 .../testing/selftests/sched_ext/create_dsq.c  |  4 ++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/create_dsq.bpf.c b/tools/testing/selftests/sched_ext/create_dsq.bpf.c
index 2cfc4ffd60e..680cc4b6d8c 100644
--- a/tools/testing/selftests/sched_ext/create_dsq.bpf.c
+++ b/tools/testing/selftests/sched_ext/create_dsq.bpf.c
@@ -10,6 +10,8 @@
 
 char _license[] SEC("license") = "GPL";
 
+u32 nr_lifecycle_tests;
+
 void BPF_STRUCT_OPS(create_dsq_exit_task, struct task_struct *p,
 		    struct scx_exit_task_args *args)
 {
@@ -43,7 +45,40 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(create_dsq_init)
 	}
 
 	bpf_for(i, 0, 1024) {
+		err = scx_bpf_create_dsq(i, -1);
+		if (err != -EEXIST) {
+			scx_bpf_error("Duplicate DSQ %d creation returned %d", i, err);
+			return -EINVAL;
+		}
+
+		/* A rejected duplicate must leave the original DSQ accessible. */
+		err = scx_bpf_dsq_nr_queued(i);
+		if (err) {
+			scx_bpf_error("Original DSQ %d queue count is %d", i, err);
+			return -EINVAL;
+		}
+
+		scx_bpf_destroy_dsq(i);
+		err = scx_bpf_dsq_nr_queued(i);
+		if (err != -ENOENT) {
+			scx_bpf_error("Destroyed DSQ %d queue count is %d", i, err);
+			return -EINVAL;
+		}
+
+		err = scx_bpf_create_dsq(i, -1);
+		if (err) {
+			scx_bpf_error("Failed to recreate DSQ %d: %d", i, err);
+			return err;
+		}
+
+		err = scx_bpf_dsq_nr_queued(i);
+		if (err) {
+			scx_bpf_error("Recreated DSQ %d queue count is %d", i, err);
+			return -EINVAL;
+		}
+
 		scx_bpf_destroy_dsq(i);
+		nr_lifecycle_tests++;
 	}
 
 	return 0;
diff --git a/tools/testing/selftests/sched_ext/create_dsq.c b/tools/testing/selftests/sched_ext/create_dsq.c
index d67431f57ac..422e6532ee7 100644
--- a/tools/testing/selftests/sched_ext/create_dsq.c
+++ b/tools/testing/selftests/sched_ext/create_dsq.c
@@ -37,6 +37,8 @@ static enum scx_test_status run(void *ctx)
 
 	bpf_link__destroy(link);
 
+	SCX_EQ(skel->bss->nr_lifecycle_tests, 1024);
+
 	return SCX_TEST_PASS;
 }
 
@@ -49,7 +51,7 @@ static void cleanup(void *ctx)
 
 struct scx_test create_dsq = {
 	.name = "create_dsq",
-	.description = "Create and destroy a dsq in a loop",
+	.description = "Create, reject duplicates, destroy and recreate DSQs",
 	.setup = setup,
 	.run = run,
 	.cleanup = cleanup,
-- 
2.55.0

