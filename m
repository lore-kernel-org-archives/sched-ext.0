Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66812560AAE
	for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092253; cv=none; b=u33WbKqgq/8k3T8nrLN1IfSlPWEnacmHOPwBLFlNjuGM7JoTkMttF6oqh0EcEP62PrLDQ0qukI5OsA0oa7AlwDANzBTIu9bSnmbsn/gYU1Z/UR1J9hClJnD4mlCQQBojJR0BaMPBsKLXmO8ntpcC1Mbbv1x2K5pvL1FQquXkcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092253; c=relaxed/simple;
	bh=rgzYzCDG9ildpCGXEj6xurCzWT2v2wrHAOFhEDpNLeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOssKx1hOHAKa+SeUxdpQjW2SJXmZXFVEWrH3jXdv5uVW/MYjVD6J5AIb4ofcl9jnrnqAgmPcELeSXKXBvJTQdN6hjwUmB59PXbKjZKbuvxoqI6QVSMLl/kzktKr/KJcGVLNmjW8cJsegNYD57ioVp/oYDPeRzcj+ABWTS/hSNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KC8Zf173; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC8Zf173"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cef0so56352a91.0
        for <sched-ext@lists.linux.dev>; Tue, 22 Sep 2026 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790092252; x=1790697052; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UVqEvmCZkA3mXO6Mi2UxH/AaK/ycjWfvrNW+JUDVq+k=;
        b=KC8Zf173uhs6gfwXyXpNnJTPFmJ7PNhr1mVa2h+ecxLRUkFb8lVy67p+2UlEq5EX4X
         u32GmmH+6FXWI0VmbiKeZQsH2sPX02kuluJYY35PklR1XPTBoe9drTL57T8fD3VKoFvH
         rRtbbrKkOAAhr58tNUpgA3NLwBnK7M2fsn1+vTIz5lvrLh+Z/HfxS2606A/y7aaWeAl8
         7rV0PE6zUN9ZGiEHH7o67PhSQu16IneGROULBmFZ2w4Rl/pTH/DNWxrJJAD5YWGNKHgP
         jWUFLvYnbAGylgM4wlt7WSP5smRZg5uZklAmBKRekgxM2zQKS1YdSZrO98mXt7Fk49G6
         uWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790092252; x=1790697052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVqEvmCZkA3mXO6Mi2UxH/AaK/ycjWfvrNW+JUDVq+k=;
        b=Ifgn64ePkRKXlG2YkQmVmx4V8dS4pa7rnxTjXFdGQcfdpPCBvUe3oIbiX6xsVzy5/z
         Xgtr11ZmbVRgs2db5pr/ubf6fD3F2S3DS2VIbjphbDJaLkF0Y/LWj39MNMPgRcqlCBWT
         MoJrhXarDSNAG8MlgJznDj9Qf/ids/iGsyciBmTUG+GQie8bgObLK9VB81RYXxbZFqBz
         R0Q1fglVi7exAS4ZAlGK9KhEZscCbo2hI9xfpSoMl4BqBXTmJDFlo4V2yXFQD2bUm1KT
         QKUKP0EikgiqdUWzApAKttWhCu+BnSlr3nxbwtQx3BWk32hoEJJjAjUlzYwV/n9+9EIs
         APag==
X-Gm-Message-State: AFuF++lrqSopWjG3lTYUL+w5vhAQKM1Ys0gLt7CR401MLCjN/SD3MIBS
	ZCdSuQogULExUeBVLAS/a8pfAjgfvK5kkc/vBXCJel0JYgPtnc3pC6QvBxDv/w==
X-Gm-Gg: AYBFou0DJEJ/U39KU46x3yKLqjzzoL+R/tx4G0sSmy36NyRy05OFSiUmR3ksloDUvTP
	v04StSi7D9BXvf9YYZXcI/nOYoVMWsxvnAJlIV6iLp05Peuag/GiquHz1lmKheOYEbAQbVAGaGo
	+EGsSDmIRrm0JLmjgIYW6TStJjnh+p0VQI4Vrp7XxtUR5kPGbiUYyYpN/KwxV4197K/iAx10D7x
	cwA2wYxNFURkeczvDCFy04B6t9sqRGic1j6R6qKs6xmUKhICKTz6bi2tt4UCx/xDi09YmOzclYg
	6g9lc6lJwqEOQhlfd5yMCN03zcxFsLwjiD8yOB28ksuzBbSJ7ofu0c/rpRlI627fCw8uBdlQ2JV
	fUK8oFr3Q32w7XkRO+hf7b0M1vP8Lr6L4GXDbyVYmzFmAJVK7PK9YWFvDk1J2DayLd66tVxg44B
	2nARy2euWLyA9GrCUy9TdrCYxYWqDyefvMfkZG7BBFoLJ00yFtJ5ef/P4Ot4Rj0QlKuRrhCGXLP
	GyTMu6B/bC0Dvz127TsWUh6UO+8VMBybY5uqviStikhW2g7mVXHBl3FBL79WebX7PhqDHt/qfeQ
	VGWqfg==
X-Received: by 2002:a17:90a:c2ce:b0:39e:6a81:f350 with SMTP id 98e67ed59e1d1-3a07320037cmr1703946a91.42.1790092251437;
        Tue, 22 Sep 2026 08:50:51 -0700 (PDT)
Received: from cchengyang.duckdns.org (1-164-66-129.dynamic-ip.hinet.net. [1.164.66.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07ddf23desm16090a91.10.2026.09.22.08.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:50:50 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	chengyang.chou@mediatek.com,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH sched_ext for-7.4] selftests/sched_ext: Fix rt_stall runner abort
Date: Tue, 22 Sep 2026 23:50:00 +0800
Message-ID: <20260922155037.17494-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rt_stall uses ksft_exit_fail() and friends, which call exit(), so a
single rt_stall failure or a fork() error kills the runner and skips
the remaining tests.

Drop the ksft_* usage, report the handshake failure back from
wait_ready(), and let run() return SCX_TEST_FAIL so the runner records
the failure and moves on. Since the test now returns rather than
exiting, route every path after the forks through one cleanup label, so
a failure cannot leave the SCHED_FIFO task spinning on CORE_ID for the
tests that follow.

Also destroy the struct_ops link before checking the exit kind, so the
link is released when that check fails.

Fixes: be621a76341c ("selftests/sched_ext: Add test for sched_ext dl_server")
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/rt_stall.c | 80 ++++++++++----------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
index a5041fc2e44f..a1552b38a6e8 100644
--- a/tools/testing/selftests/sched_ext/rt_stall.c
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -17,7 +17,6 @@
 #include <scx/common.h>
 #include "rt_stall.bpf.skel.h"
 #include "scx_test.h"
-#include "../kselftest.h"
 
 #define CORE_ID		0	/* CPU to pin tasks to */
 #define RUN_TIME        5	/* How long to run the test in seconds */
@@ -35,15 +34,17 @@ static void signal_ready(int fd)
 }
 
 /* Wait for a child to signal readiness via a pipe */
-static void wait_ready(int fd)
+static bool wait_ready(int fd)
 {
+	bool ready;
 	char c;
 
-	if (read(fd, &c, 1) != 1) {
+	ready = read(fd, &c, 1) == 1;
+	if (!ready)
 		perror("read from ready pipe");
-		exit(EXIT_FAILURE);
-	}
 	close(fd);
+
+	return ready;
 }
 
 /* Simple busy-wait function for test tasks */
@@ -151,13 +152,11 @@ static bool sched_stress_test(bool is_ext)
 	float ext_runtime, rt_runtime, actual_ratio;
 	int ext_pid, rt_pid;
 	int ext_ready[2], rt_ready[2];
-
-	ksft_print_header();
-	ksft_set_plan(1);
+	bool ret = false;
 
 	if (pipe(ext_ready) || pipe(rt_ready)) {
 		perror("pipe");
-		ksft_exit_fail();
+		return false;
 	}
 
 	/* Create and set up a EXT task */
@@ -172,7 +171,7 @@ static bool sched_stress_test(bool is_ext)
 		exit(0);
 	} else if (ext_pid < 0) {
 		perror("fork task");
-		ksft_exit_fail();
+		return false;
 	}
 
 	/* Create an RT task */
@@ -188,7 +187,7 @@ static bool sched_stress_test(bool is_ext)
 		exit(0);
 	} else if (rt_pid < 0) {
 		perror("fork for RT task");
-		ksft_exit_fail();
+		goto out_kill_ext;
 	}
 
 	/*
@@ -199,45 +198,47 @@ static bool sched_stress_test(bool is_ext)
 	 */
 	close(ext_ready[1]);
 	close(rt_ready[1]);
-	wait_ready(ext_ready[0]);
-	wait_ready(rt_ready[0]);
+	if (!wait_ready(ext_ready[0]) || !wait_ready(rt_ready[0]))
+		goto out_kill;
 
 	/* Let the processes run for the specified time */
 	sleep(RUN_TIME);
 
 	/* Get runtime for the EXT task */
 	ext_runtime = get_process_runtime(ext_pid);
-	if (ext_runtime == -1)
-		ksft_exit_fail_msg("Error getting runtime for %s task (PID %d)\n",
-				   class_str, ext_pid);
-	ksft_print_msg("Runtime of %s task (PID %d) is %f seconds\n",
-		       class_str, ext_pid, ext_runtime);
+	if (ext_runtime == -1) {
+		fprintf(stderr, "Failed to read %s task runtime\n", class_str);
+		goto out_kill;
+	}
 
 	/* Get runtime for the RT task */
 	rt_runtime = get_process_runtime(rt_pid);
-	if (rt_runtime == -1)
-		ksft_exit_fail_msg("Error getting runtime for RT task (PID %d)\n", rt_pid);
-	ksft_print_msg("Runtime of RT task (PID %d) is %f seconds\n", rt_pid, rt_runtime);
-
-	/* Kill the processes */
-	kill(ext_pid, SIGKILL);
-	kill(rt_pid, SIGKILL);
-	waitpid(ext_pid, NULL, 0);
-	waitpid(rt_pid, NULL, 0);
+	if (rt_runtime == -1) {
+		fprintf(stderr, "Failed to read RT task runtime\n");
+		goto out_kill;
+	}
 
 	/* Verify that the scx task got enough runtime */
 	actual_ratio = ext_runtime / (ext_runtime + rt_runtime);
-	ksft_print_msg("%s task got %.2f%% of total runtime\n",
-		       class_str, actual_ratio * 100);
+	fprintf(stderr, "%s task ran %.3fs, RT task ran %.3fs (%.2f%% of runtime)\n",
+		class_str, ext_runtime, rt_runtime, actual_ratio * 100);
 
-	if (actual_ratio >= expected_min_ratio) {
-		ksft_test_result_pass("PASS: %s task got more than %.2f%% of runtime\n",
-				      class_str, expected_min_ratio * 100);
-		return true;
+	if (actual_ratio < expected_min_ratio) {
+		fprintf(stderr, "%s task got less than %.2f%% of runtime\n",
+			class_str, expected_min_ratio * 100);
+		goto out_kill;
 	}
-	ksft_test_result_fail("FAIL: %s task got less than %.2f%% of runtime\n",
-			      class_str, expected_min_ratio * 100);
-	return false;
+
+	ret = true;
+
+out_kill:
+	kill(rt_pid, SIGKILL);
+	waitpid(rt_pid, NULL, 0);
+out_kill_ext:
+	kill(ext_pid, SIGKILL);
+	waitpid(ext_pid, NULL, 0);
+
+	return ret;
 }
 
 static enum scx_test_status run(void *ctx)
@@ -263,14 +264,17 @@ static enum scx_test_status run(void *ctx)
 			link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
 			SCX_FAIL_IF(!link, "Failed to attach scheduler");
 		}
+
 		res = sched_stress_test(is_ext);
+
 		if (is_ext) {
-			SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+			int exit_kind = skel->data->uei.kind;
 			bpf_link__destroy(link);
+			SCX_EQ(exit_kind, EXIT_KIND(SCX_EXIT_NONE));
 		}
 
 		if (!res)
-			ksft_exit_fail();
+			return SCX_TEST_FAIL;
 	}
 
 	return SCX_TEST_PASS;
-- 
2.55.0

