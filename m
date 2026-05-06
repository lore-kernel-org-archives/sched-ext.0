Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B03044D02F
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083469; cv=none; b=MdOj1907kexlIHX/8QZ72AEx1sY+MR2tdZbrcaFHhrWYxOS6YmQv6zlIZ6oS8aKgLEmWAVv+CfpjtGaZbtAbFAdrqbBwJIz8Iqh5BVbcQTQGCRszqCMaM6gOeickMcJ5NJUUHpmsxqumdPqxKPNp9pWwJByt3kzvlTBXf6y6NbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083469; c=relaxed/simple;
	bh=RwJDsZgYiKCWrQf3GUjFjVlW6mtbUn50P9uc+QItOWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQYKi+kC5DY9BKtFEvoHRbDHzmWTN0m1hlQ/Dy/A2BWna3ivNBkIOdtdyMTvq6Q/oH+7KZ+tvuowzzpuGd/cW4g2x9JHBObs2ZZ/Da2/GOJ3LjhmAccca0163FnTNwBe+pKmN0A49Ja3gNhkv1Se2DSeFu2XKk/sOv7TJ4JPiJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8Tk9NQY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8Tk9NQY"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-365312a27abso3835191a91.3
        for <sched-ext@lists.linux.dev>; Wed, 06 May 2026 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778083463; x=1778688263; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtFp072Sp39NO6KvJ94rAXgRy5S/ZQz0QfRiPcZobE4=;
        b=A8Tk9NQYe0pmXsVSFiLFxiEWk+s8wCb5lVCuMbr0uc0kw8Y1uvkyPDvxbpzZrX4Yq1
         otMTYGkdAj72EFXiAjRaxyPzWa2uOdtpk1kSaC6gr3WjySre0vNiFrfJCKwJs+oHC5kd
         KNzbwXtxeesu8VfrHflnI3K3nk3J1I0MadPq9ilFgdJsIY2SLLTEVx8KMWfbXBvqDSRv
         sYBTd/OPVsNLK1HnYLOjYi93RKREP1p3CJ+PaatlMibZcRIwRcUszhls34lqP+v/bWOf
         6RRi3MpCu4d1XD8kNglvxXOelK8Ql7RT441FF2Xv4bAjpEVUycHTEL7ALJ6Jfc3izKru
         lGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083463; x=1778688263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtFp072Sp39NO6KvJ94rAXgRy5S/ZQz0QfRiPcZobE4=;
        b=lSQm2jumo86a52rKkKJfQ48kZ/BWPRpM68pKhbTl6sGxx4EkBnjtWDSNXcBG2tx4TE
         cwFD2fUtxNK3fVRcBeOizcHReGn6BtXloq7gjWFQg13R3PjbBytzwbm3SvBGmbRwV3eI
         WnubqzlvtjFdIfeqiwPtixA2tvtPWbVGF5t5EADCh0fsTpi48S/xgzqIouU45kgq/Abq
         RcHr6rj1/jUnuhUp1aPEjRKnSVitjk6ljGIw326SmS4Mk7hmDUM5+UL5vkjdbcapY5Am
         llRiiGA0NVQbyGQy3T7/FTM+tye4IW83H1TtmYTXa/frqSlcMUaN5w6V3U7+La4m35y5
         Ca7w==
X-Gm-Message-State: AOJu0YyHu6/teDT3vuU9SLrek41mSDCocgRvOT2CQ+CCe4cY5tIzCj0u
	zYXMh7pVoh4oeD6B2szcy6IkgudkY05CD3x/B+nSDwnnM0rIosikdTLUJ6ViJg==
X-Gm-Gg: AeBDietMZgrNpSZvNa0YmqXrTVAicL6m1QSa/UUBhK9Hf6tcL+hkWQ0BiVz5Jaj+do0
	XJU1NAyv7F6jyGEraMXKPCCOnLFmLkRb+8qepGzph8MxGe1Mf36iIpMxbF54KF2axT6Xqwa+LnM
	JeuamU0P8ung9k4cIQUIvEFn6xt3PmlGgZnZnaDJPUvMyX0lB274eMqN0VwhopAFpUGcOsbSGw4
	nvClxxO5pV4OmczvsGCaXD6ei4lvv6b1KDEMe/bVkYzTbBuyKIBVi6/rXT6aCnZoTP9z5JrqtGu
	XQ+MfdqJEBXY/ZAyO9VW6Cx+NfjbHWjygl08rCVO5xR069FqTCN9ZT3McfyrWyG6Vn4bv5I7ht/
	NMgDFl85XHrP1WkrgWK0omaZvjlpsWJeaxmCHrrqWRHhFX/fEo/A+jXWxfAdeyQ9O0x7kZstSiK
	iu5qoJ8VorLSABccN1HNqYQk4qvV4jbdrcek6py9S7C7HhLcwVNwYOuoJAFS7P/g==
X-Received: by 2002:a17:90b:5284:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-365ac766d8fmr4523733a91.23.1778083463025;
        Wed, 06 May 2026 09:04:23 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:5aa6:d56d:38a9:469])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4fb36f4sm2777448a91.13.2026.05.06.09.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:04:22 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v2 2/2] selftests/sched_ext: Add dispatch_cookie test
Date: Thu,  7 May 2026 00:04:02 +0800
Message-ID: <20260506160412.522199-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260506160412.522199-1-yphbchou0911@gmail.com>
References: <20260506160412.522199-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test scx_bpf_task_get_cookie() and scx_bpf_dsq_insert_with_cookie().

The scheduler captures a cookie via scx_bpf_task_get_cookie() before
performing pre-dispatch validity checks, then dispatches tasks through
scx_bpf_dsq_insert_with_cookie(). The userspace side verifies all
children complete successfully and that nr_cookie_dispatched reflects
actual cookie-based dispatch activity.

Suggested-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/Makefile    |  1 +
 .../selftests/sched_ext/dispatch_cookie.bpf.c | 38 ++++++++++
 .../selftests/sched_ext/dispatch_cookie.c     | 74 +++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dispatch_cookie.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5d2dffca0e91..ae3dc0913378 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -164,6 +164,7 @@ all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubs
 auto-test-targets :=			\
 	create_dsq			\
 	dequeue				\
+	dispatch_cookie			\
 	enq_last_no_enq_fails		\
 	ddsp_bogus_dsq_fail		\
 	ddsp_vtimelocal_fail		\
diff --git a/tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c b/tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c
new file mode 100644
index 000000000000..cb198a5f50e8
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dispatch_cookie.bpf.c
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Test scx_bpf_task_get_cookie() and scx_bpf_dsq_insert_with_cookie().
+ *
+ * Copyright (C) 2026 Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
+ * Copyright (C) 2026 Cheng-Yang Chou <yphbchou0911@gmail.com>
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+long nr_cookie_dispatched;
+
+void BPF_STRUCT_OPS(dispatch_cookie_enqueue, struct task_struct *p,
+		    u64 enq_flags)
+{
+	u64 cookie = scx_bpf_task_get_cookie(p);
+
+	if (scx_bpf_dsq_insert_with_cookie(p, SCX_DSQ_GLOBAL, 0, cookie))
+		__sync_fetch_and_add(&nr_cookie_dispatched, 1);
+	else
+		scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+}
+
+void BPF_STRUCT_OPS(dispatch_cookie_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops dispatch_cookie_ops = {
+	.enqueue		= (void *) dispatch_cookie_enqueue,
+	.exit			= (void *) dispatch_cookie_exit,
+	.name			= "dispatch_cookie",
+	.timeout_ms		= 5000U,
+};
diff --git a/tools/testing/selftests/sched_ext/dispatch_cookie.c b/tools/testing/selftests/sched_ext/dispatch_cookie.c
new file mode 100644
index 000000000000..f799b5828f9d
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dispatch_cookie.c
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Test scx_bpf_task_get_cookie() and scx_bpf_dsq_insert_with_cookie().
+ *
+ * Copyright (C) 2026 Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
+ * Copyright (C) 2026 Cheng-Yang Chou <yphbchou0911@gmail.com>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "dispatch_cookie.bpf.skel.h"
+#include "scx_test.h"
+
+#define NUM_CHILDREN 128
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct dispatch_cookie *skel;
+
+	skel = dispatch_cookie__open();
+	SCX_FAIL_IF(!skel, "Failed to open skel");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(dispatch_cookie__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct dispatch_cookie *skel = ctx;
+	struct bpf_link *link;
+	pid_t pids[NUM_CHILDREN];
+	int i, status;
+
+	link = bpf_map__attach_struct_ops(skel->maps.dispatch_cookie_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	for (i = 0; i < NUM_CHILDREN; i++) {
+		pids[i] = fork();
+		if (pids[i] == 0)
+			exit(0);
+	}
+
+	for (i = 0; i < NUM_CHILDREN; i++) {
+		SCX_EQ(waitpid(pids[i], &status, 0), pids[i]);
+		SCX_EQ(status, 0);
+	}
+
+	bpf_link__destroy(link);
+
+	SCX_GT(skel->bss->nr_cookie_dispatched, 0);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct dispatch_cookie *skel = ctx;
+
+	dispatch_cookie__destroy(skel);
+}
+
+struct scx_test dispatch_cookie = {
+	.name		= "dispatch_cookie",
+	.description	= "Verify scx_bpf_task_get_cookie() and "
+			  "scx_bpf_dsq_insert_with_cookie() dispatch tasks correctly",
+	.setup		= setup,
+	.run		= run,
+	.cleanup	= cleanup,
+};
+REGISTER_SCX_TEST(&dispatch_cookie)
-- 
2.48.1

