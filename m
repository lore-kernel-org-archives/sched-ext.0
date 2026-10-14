Received: from mta1.migadu.com (out-242.mta1.migadu.com [95.215.58.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A19938398F
	for <sched-ext@lists.linux.dev>; Wed, 14 Oct 2026 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983641; cv=none; b=R9EBh5RxVE8AXsCOqJq6ErmOv8yPjeEsAL+4n5ZNJ/+X6nZbz6is1lak1XN9sKd4URIf9H3HkKFWJcI5bxPm5I2kgD9SYdRS2QllbWfSaIt/zRxDHcIZhJBUXVHOHqF9YZ5OeGIWg/bPpRcAIA3Cvsp2ijr7S/fYcqt3MvyAK50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983641; c=relaxed/simple;
	bh=VfQIx+9jRI5hC3YmMfx8S9pCu8mVopIPDNq7NzPwBaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFlyjfx2DuWq2sJ/rKEJc0DtnoVfOF0Lk1avqkH45D+ZDT79HL8YZEZ6p3sY7kABEZMt6hRA8KZSUohSbNlsN3USWa2HN4Tgb3BXjhjTyVIg0yawu2wz3cWJqVq8QELasksv1e4+apLsVwE/kNGAw3y30dswjJec6/rj/RHwqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H7jnZHcz; arc=none smtp.client-ip=95.215.58.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H7jnZHcz"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=VfQIx+9jRI5hC3YmMfx8S9pCu8mVopIPDNq7NzPwBaY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791983638; v=1; x=1792588438;
 b=H7jnZHczXSCHWOJMAj9gGOaoPyzSu6R3Yu7Khwvc/CgFfrCel//m+YW9zbZOaER69t6mF6pb
 MV0W5807Q8z4rT8zrl0rd54OTYV3g95bM6w/0DPcDN2MzatN8CjAcnSFhKKxMb5Qs7Wdd5+ak5g
 ZxUaqq+t8Rs14TIR3dcD429M=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id fd256cc70fe10d15;
	Wed, 14 Oct 2026 13:13:58 +0000
X-Mizu-Trace-ID: fd256cc70fe10d15
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Tao Cui <cuitao@kylinos.cn>,
	cui.tao@linux.dev
Subject: [PATCH v2 5/6] selftests/sched_ext: Bound exit waits
Date: Wed, 14 Oct 2026 21:13:24 +0800
Message-ID: <20261014131325.793640-6-cui.tao@linux.dev>
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

exit, prog_run and hotplug wait for the scheduler under test to exit
with no time bound; a scheduler that never exits hangs the runner
instead of failing the test. Bound the waits to ~10s (iteration-based)
with the new SCX_TIMED_WAIT_UEI() helper, which stretches on a loaded
system instead of failing early.

exit.c returns straight from its timeout path, which would leave the
link and the skeleton alive and the unexited scheduler attached for
the rest of the runner run - every later test would then fail to
attach with EBUSY and bury the real failure. Destroy both before
failing, like prog_run and hotplug already destroy the link.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/testing/selftests/sched_ext/exit.c     |  8 ++++++--
 tools/testing/selftests/sched_ext/hotplug.c  | 12 ++++++++----
 tools/testing/selftests/sched_ext/prog_run.c |  7 +++++--
 tools/testing/selftests/sched_ext/scx_test.h | 17 +++++++++++++++++
 4 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/exit.c b/tools/testing/selftests/sched_ext/exit.c
index 01b17092d5c8..fd6f1c9ab2db 100644
--- a/tools/testing/selftests/sched_ext/exit.c
+++ b/tools/testing/selftests/sched_ext/exit.c
@@ -43,8 +43,12 @@ static enum scx_test_status run(void *ctx)
 		}
 
 		/* Assumes uei.kind is written last */
-		while (skel->data->uei.kind == EXIT_KIND(SCX_EXIT_NONE))
-			sched_yield();
+		if (!SCX_TIMED_WAIT_UEI(skel, uei, 10000)) {
+			SCX_ERR("Timed out waiting for scheduler to exit");
+			bpf_link__destroy(link);
+			exit__destroy(skel);
+			return SCX_TEST_FAIL;
+		}
 
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
diff --git a/tools/testing/selftests/sched_ext/scx_test.h b/tools/testing/selftests/sched_ext/scx_test.h
index 9e102d7f2893..8490b01fff74 100644
--- a/tools/testing/selftests/sched_ext/scx_test.h
+++ b/tools/testing/selftests/sched_ext/scx_test.h
@@ -126,6 +126,23 @@ void scx_test_register(struct scx_test *test);
 				 (__skel)->data->__uei.msg);			\
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

