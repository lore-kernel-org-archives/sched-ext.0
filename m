Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D137BE7A
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776322051; cv=none; b=QRFvRmmzOnive69fjDtO/T2ecpVIG/IEZuyGHNoBzy4/5xDPvyDmzkHOnJDV4QXOIYoTIl2HTrwHXgn8TDwRtPrYu2S+8Ar6YjnE0OJYIoPEUODfBOOwEOjO/ZdNOzhhuVjd91HEy255iQB8n9+YpdQwNkp/gy5FegdBDiLDQiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776322051; c=relaxed/simple;
	bh=IoooIES1we9H4UrTS/V5m8VZsU5ybmywjWgdTLsb5Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mo30ArkqDUB4umSrdsjVSL0v8aQ8sMdDF/CM1LJIBJo7GHUpKsOsgu79y2SWDzeKwUFbx1Avy6fgrSeI4l+0g6/1sxZ/KMS+u59w2vVphf6E80qRtg/izuZovHh+YNDVB/DzKjJhK5ObK6KhJ02PWn99nuXZNc4rptVIvwYsJEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckbppZIo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckbppZIo"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82f69adeecbso640090b3a.2
        for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 23:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776322049; x=1776926849; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzHl15V6LaKZz5Nq0yjuiMpGczFONg84vITPocytaBw=;
        b=ckbppZIoh/N5jv6Kp6PICbEevrWJvsvXWpS81qJqmKNrm4yzMljRWZIlzCtYQ4OI0P
         f+AM1Cv82LzBfgDipsXGrVBDhiuynt/HRvf1z24ZvuXtZ2GRo4Ybc3o6AIXPrF80f1AZ
         3oamlM4KABUMsGLZ+xH5sO9+4YzkTzQ6rJSK2auB6NmwjsObKCtyXH+Z3C8xiWGp/B6J
         KEJ/x4z55sKrWLFZBoEni0BdpvrkRpJ1Zc9DMHJ6GsxHk040nH7LntPK9zDUvHsSkprJ
         8fh3YX02X/MMgM3SHvwa4EQ2CxcL729Uwb300+rGibznHw3sRniS1M8eCa8ZwkA1JT71
         YefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776322049; x=1776926849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YzHl15V6LaKZz5Nq0yjuiMpGczFONg84vITPocytaBw=;
        b=WXlrTIhe1wLrypAMCNN9GGpahNjhbfTC0aN7A+C1vRnbOgshK5iVdfh55aqlD7B4PZ
         2sN3tsm7gEnEaDMQ28z4bjkz696rHkjY4A5kBKQFYO5gzGBw4wPu5DEumvoUScT1Rf/i
         ftmXs6PbNE3Kapei9QfFtrGw6CLqK8XH4DJCje3Kk3vBgGMDZjBZJpkJtEfpNwwkzxQh
         1Or8s86kvE5/PQ55eb0weRX9wzfk0+Q2+gzzRgRn1o8NOxQcBYN67rEcg5/44/pmdwcV
         hBntHNtjNDUpWQnLqn//3MI3jOQtfh/hZvrmoJEAdct0vbNoHPTrUGTMnja/9D1XcW18
         Ku7g==
X-Gm-Message-State: AOJu0YxpJJ5NoQ+Y87oZB5uNabtN74GlWXjep/JRiaq9XB82LZa56frX
	GDtGBkzbZUn4rBGBQICg6BBaM4dtaFIscmumvwr/w8spaOS3mR9UtOZsItTEXoTa
X-Gm-Gg: AeBDiet6WnsfRBQUTPR9BYU0lfAxMrzlSMC8clFGE402OkuKJ3VZH3PrMo22mHlBI/o
	vjj+QsrIvLJGytmXIFAo8Tmzmx0euY1D5TZlJTLrsUke9CQ6XBzLnwIHvD1yCfu6Ytcr6my5L8p
	dCQlMWTvTxtM+k5OMRbul+dWTNC4FEzvz+L+4iC0Nkh8V3FVAX9yXKlsDtGm6u5EywtQ3YAnu8Y
	tVIurNtYLwKm1r2RBs+7IV6aaQlLFC9JFjXQ49++U1rSNoCed6/bCzSv9SMPHnzMIFF0YbnwWHD
	wft5O8CfN6J0Fcl+oouRwXipCjMfPeSQQJUNOCLc++d9Ch7O8C5yeHmBrZcWUXLpoysfgiP6lr9
	0RkOMRmXm0BKN8h67c7C5Lm+3SDW9y4qWmtofGz44Xv3sr4byDRElyeGhiiFFjzFXFf5sIjSAzd
	gBqeYahJdOStVrk3AO2Nb21BmwlDra0BWu/6lLzZlsyTBfjWBkLotXSpZcDJX+
X-Received: by 2002:a05:6a00:1c97:b0:823:9b7:9c0e with SMTP id d2e1a72fcca58-82f0c24cc51mr22176572b3a.34.1776322048665;
        Wed, 15 Apr 2026 23:47:28 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:49:cbd5:ab58:206c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6d922a38sm3212392b3a.7.2026.04.15.23.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 23:47:28 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH 2/2] selftests/sched_ext: Add non_scx_kfunc_deny test
Date: Thu, 16 Apr 2026 14:46:41 +0800
Message-ID: <20260416064715.1008437-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260416064715.1008437-1-yphbchou0911@gmail.com>
References: <20260416064715.1008437-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that the BPF verifier rejects a non-SCX struct_ops program
(tcp_congestion_ops) that attempts to call an SCX kfunc (scx_bpf_kick_cpu).
The test expects the load to fail with -EACCES from scx_kfunc_context_filter.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/Makefile    |  1 +
 .../sched_ext/non_scx_kfunc_deny.bpf.c        | 44 +++++++++++++++++
 .../selftests/sched_ext/non_scx_kfunc_deny.c  | 47 +++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/non_scx_kfunc_deny.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 789037be44c7..2880a122a214 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -190,6 +190,7 @@ auto-test-targets :=			\
 	test_example			\
 	total_bw			\
 	cyclic_kick_wait		\
+	non_scx_kfunc_deny		\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
 
diff --git a/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
new file mode 100644
index 000000000000..9f16d39255e7
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Verify that context-sensitive SCX kfuncs (even "unlocked" ones) are
+ * restricted to only SCX struct_ops programs. Non-SCX struct_ops programs,
+ * such as TCP congestion control programs, should be rejected by the BPF
+ * verifier when attempting to call these kfuncs.
+ *
+ * Copyright (C) 2026 Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
+ * Copyright (C) 2026 Cheng-Yang Chou <yphbchou0911@gmail.com>
+ */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/* SCX kfunc from scx_kfunc_ids_any set */
+void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
+
+SEC("struct_ops/ssthresh")
+__u32 BPF_PROG(tcp_ca_ssthresh, struct sock *sk)
+{
+	/*
+	 * This call should be rejected by the verifier because this is a
+	 * TCP congestion control program (non-SCX struct_ops).
+	 */
+	scx_bpf_kick_cpu(0, 0);
+	return 2;
+}
+
+SEC("struct_ops/cong_avoid")
+void BPF_PROG(tcp_ca_cong_avoid, struct sock *sk, __u32 ack, __u32 acked) {}
+
+SEC("struct_ops/undo_cwnd")
+__u32 BPF_PROG(tcp_ca_undo_cwnd, struct sock *sk) { return 2; }
+
+SEC(".struct_ops")
+struct tcp_congestion_ops tcp_non_scx_ca = {
+	.ssthresh   = (void *)tcp_ca_ssthresh,
+	.cong_avoid = (void *)tcp_ca_cong_avoid,
+	.undo_cwnd  = (void *)tcp_ca_undo_cwnd,
+	.name       = "tcp_kfunc_deny",
+};
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.c b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.c
new file mode 100644
index 000000000000..1c031575fb87
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.c
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Verify that context-sensitive SCX kfuncs (even "unlocked" ones) are
+ * restricted to only SCX struct_ops programs. Non-SCX struct_ops programs,
+ * such as TCP congestion control programs, should be rejected by the BPF
+ * verifier when attempting to call these kfuncs.
+ *
+ * Copyright (C) 2026 Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
+ * Copyright (C) 2026 Cheng-Yang Chou <yphbchou0911@gmail.com>
+ */
+
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include "non_scx_kfunc_deny.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status run(void *ctx)
+{
+	struct non_scx_kfunc_deny *skel;
+	int err;
+
+	skel = non_scx_kfunc_deny__open();
+	if (!skel) {
+		SCX_ERR("Failed to open skel");
+		return SCX_TEST_FAIL;
+	}
+
+	err = non_scx_kfunc_deny__load(skel);
+	non_scx_kfunc_deny__destroy(skel);
+
+	if (err == 0) {
+		SCX_ERR("non-SCX BPF program loaded when it should have been rejected");
+		return SCX_TEST_FAIL;
+	}
+
+	return SCX_TEST_PASS;
+}
+
+struct scx_test non_scx_kfunc_deny = {
+	.name = "non_scx_kfunc_deny",
+	.description = "Verify that non-SCX struct_ops programs cannot call SCX kfuncs",
+	.run = run,
+};
+REGISTER_SCX_TEST(&non_scx_kfunc_deny)
-- 
2.48.1

