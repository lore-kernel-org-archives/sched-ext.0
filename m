Received: from out-zbxj-a87.jellyfish.systems (out-zbxj-a87.jellyfish.systems [198.54.127.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF86A3C37A5
	for <sched-ext@lists.linux.dev>; Sun,  6 Sep 2026 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788702962; cv=none; b=UntMZpM85Kz03dH/Ucs6ArgXTu5OQdxWbtVmT1sdcAMbyVTW3tWA61RPQcyRStVHzJjVirb+ssja7NjecRvmGqSy33IrFR8kVNPJFMW65W92mpLHcNGgV9XSYBHYpCPVIACQtI+8CG2SW1haAc1QpaNj+l07PjNeoh9iJj0pUBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788702962; c=relaxed/simple;
	bh=COd+kAaQDyip65PPi7omYsrkf1H/LFJxKJENx1+pDr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZPuAL8jO1D4Hjl9uIMEHZ4voXWC2L+dm4KEJ6juw+ELRtD1moy/+ONZPwuuac5UIHaUDBPlHvVAL0X6G5q0JWVoEIbJosUJPX+PB4HERJWI9GMOk0BiAb7/WjrixRvc9HBgLIhgXIx3XQCOgQYyxXGNQvisojVDBb/t2fmaoAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=YK25Gdu2; arc=none smtp.client-ip=198.54.127.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="YK25Gdu2"
Received: from fedora (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdBYX6thCz6tkS;
	Sun, 06 Sep 2026 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788702948;
	bh=K7IcHZi0LnYase/ANW87JayKjKxLyrrOICqxy87P0M0=;
	h=From:To:Cc:Subject:Date:From;
	b=YK25Gdu2+VNR7fEho2p9K8qZaOoLWNWO8gL81XUWHwwcwnUg6MmIQdpRtwO7tdcQg
	 Wtpb2D7yhFdGj0QTKMnivdXGcHGIqdqccC1E2PbQ8MPhVoYmL/c4jt/I0NcqyIde9U
	 ljLHVISniMKzCezV7hmRQpoaJ3GxHPN/SPLOy8G0d2gv6d9rKfFE+LPDNrtCACuh/W
	 wRekGrgEd/8CmUy6pOyUHwZM2G/yFieOQlRzdiykzpQyGoRbqpuy7AUZIPt3e9ZcQQ
	 PFkDG4lK4VhHegPQmKa85/CI8yYSZdAsSlnXDoNi5zpoNyVio8oPNc2/O0JCstKCC7
	 Z+fpVDqdkCsrQ==
From: Tianyi Chen <hi@tychen.cc>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Tianyi Chen <hi@tychen.cc>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/sched_ext: Handle CPU hotplug write failures
Date: Sun,  6 Sep 2026 21:55:22 +0800
Message-ID: <20260906135534.749534-1-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

toggle_online_status() logs failed CPU state changes but discards the
write result. The hotplug tests can consequently wait indefinitely for
a scheduler exit that the failed operation never triggered.

Return the write result and stop both hotplug tests when a required
CPU state change fails. Release the acquired scheduler resources on
these paths and let the existing cleanup callback retry restoring
CPU1. Also fail the test when its normal CPU restoration fails.

Tested in a two-vCPU VM running a kernel built from the same source
as the selftests. Injecting EIO with strace into each of the ten CPU
state writes makes the fixed test return 1, with CPU1 online and
sched_ext disabled after cleanup. The original test does not finish
within three seconds when either of the first two writes fails.
Normal hotplug tests pass before and after the change. Making the
online file read-only also produces a failure without hanging.

Fixes: a5db7817af78 ("sched_ext: Add selftests")
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 tools/testing/selftests/sched_ext/hotplug.c | 34 ++++++++++++++-------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/hotplug.c b/tools/testing/selftests/sched_ext/hotplug.c
index 0cfbb111a2d..10b8d42bd89 100644
--- a/tools/testing/selftests/sched_ext/hotplug.c
+++ b/tools/testing/selftests/sched_ext/hotplug.c
@@ -21,15 +21,17 @@ static bool is_cpu_online(void)
 	return file_read_long(online_path) > 0;
 }
 
-static void toggle_online_status(bool online)
+static int toggle_online_status(bool online)
 {
 	long val = online ? 1 : 0;
 	int ret;
 
 	ret = file_write_long(online_path, val);
 	if (ret != 0)
-		fprintf(stderr, "Failed to bring CPU %s (%s)",
+		fprintf(stderr, "Failed to bring CPU %s (%s)\n",
 			online ? "online" : "offline", strerror(errno));
+
+	return ret;
 }
 
 static enum scx_test_status setup(void **ctx)
@@ -44,6 +46,7 @@ static enum scx_test_status test_hotplug(bool onlining, bool cbs_defined)
 {
 	struct hotplug *skel;
 	struct bpf_link *link;
+	enum scx_test_status status = SCX_TEST_FAIL;
 	long kind, code;
 
 	SCX_ASSERT(is_cpu_online());
@@ -54,8 +57,8 @@ static enum scx_test_status test_hotplug(bool onlining, bool cbs_defined)
 	SCX_FAIL_IF(hotplug__load(skel), "Failed to load skel");
 
 	/* Testing the offline -> online path, so go offline before starting */
-	if (onlining)
-		toggle_online_status(0);
+	if (onlining && toggle_online_status(0))
+		goto out_destroy_skel;
 
 	if (cbs_defined) {
 		kind = SCX_KIND_VAL(SCX_EXIT_UNREG_BPF);
@@ -79,7 +82,8 @@ static enum scx_test_status test_hotplug(bool onlining, bool cbs_defined)
 		return SCX_TEST_FAIL;
 	}
 
-	toggle_online_status(onlining ? 1 : 0);
+	if (toggle_online_status(onlining ? 1 : 0))
+		goto out_destroy_link;
 
 	while (!UEI_EXITED(skel, uei))
 		sched_yield();
@@ -87,20 +91,23 @@ static enum scx_test_status test_hotplug(bool onlining, bool cbs_defined)
 	SCX_EQ(skel->data->uei.kind, kind);
 	SCX_EQ(UEI_REPORT(skel, uei), code);
 
-	if (!onlining)
-		toggle_online_status(1);
+	if (!onlining && toggle_online_status(1))
+		goto out_destroy_link;
 
+	status = SCX_TEST_PASS;
+out_destroy_link:
 	bpf_link__destroy(link);
+out_destroy_skel:
 	hotplug__destroy(skel);
 
-	return SCX_TEST_PASS;
+	return status;
 }
 
 static enum scx_test_status test_hotplug_attach(void)
 {
 	struct hotplug *skel;
 	struct bpf_link *link;
-	enum scx_test_status status = SCX_TEST_PASS;
+	enum scx_test_status status = SCX_TEST_FAIL;
 	long kind, code;
 
 	SCX_ASSERT(is_cpu_online());
@@ -115,10 +122,12 @@ static enum scx_test_status test_hotplug_attach(void)
 	 * Take the CPU offline to increment the global hotplug seq, which
 	 * should cause attach to fail due to us setting the hotplug seq above
 	 */
-	toggle_online_status(0);
+	if (toggle_online_status(0))
+		goto out_destroy_skel;
 	link = bpf_map__attach_struct_ops(skel->maps.hotplug_nocb_ops);
 
-	toggle_online_status(1);
+	if (toggle_online_status(1))
+		goto out_destroy_link;
 
 	SCX_ASSERT(link);
 	while (!UEI_EXITED(skel, uei))
@@ -130,7 +139,10 @@ static enum scx_test_status test_hotplug_attach(void)
 	SCX_EQ(skel->data->uei.kind, kind);
 	SCX_EQ(UEI_REPORT(skel, uei), code);
 
+	status = SCX_TEST_PASS;
+out_destroy_link:
 	bpf_link__destroy(link);
+out_destroy_skel:
 	hotplug__destroy(skel);
 
 	return status;
-- 
2.55.0

