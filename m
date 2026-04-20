Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA138A718
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677368; cv=none; b=HWDi7PRp9jAB+EaK15lc0mqgTcFDEGuQamVQ+EaAq0lBoJfeVszSkpDrfs6tgXfYuGEbWb37e9dQImk2QzEXKFdn6ZHho223TPRM9NUoPNgjpRJPrX1/hRDOPBoHTSh4HueRWBpIIVfR0wyf2W/UoN4PQ8DxmRdw91UHtLId55g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677368; c=relaxed/simple;
	bh=1iIpUoOuFeBxQEY30CkZcPtRjHeKTymZ914j0afi26s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGF/zJa8bAwa6Qy1kk0c1XE8KsAv+NAVfLrbhTlxB6YPzjdlB+gRqJ4DAN3W1LA2W9UYw+lrt64tbsLPMdxXfBr0ntE7IhzgNMoo30PErwN59ezoQawxTUX826y/RwUaFK5Rt9noxvkagOfkwAx26E49JoBgB8jaUbmVwZDKgoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6h6UKMq; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6h6UKMq"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c795f096fa5so1056164a12.3
        for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 02:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776677365; x=1777282165; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FDnMwVIQsGbSxT1/WPrN6xjBvYGmkxajwz3iTsphVs=;
        b=S6h6UKMqStzRli15fl15cT/h7PW9mqd/YiXPFCFkY8ASOMcJZGRO8B0YD4xSXPHH3I
         ZkIKEzBTRFlk6HNBXwREeo0fcZ8ahH9biiRZhQEDTa/WWEElNizveoxi/pc5mXipzzY5
         qYTSfziGoGthontFJGDdw2UYuFAtkolTfqXeBo0Kt2ljb4pvYS2gfp61kk8kWs00jqVG
         3AkCn16xgIjzkp4m4r0FeKgkPHL9Ty2BbHNYlza6OLQSM6MQj/c4tpA5EouMNPwKTgIz
         /nD5c6UJP2HBN4TqgsJqGbHQ06+pHvbkmbTjD9nyEfuvDKyCirtMkvFxAPGil47duph3
         xRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776677365; x=1777282165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3FDnMwVIQsGbSxT1/WPrN6xjBvYGmkxajwz3iTsphVs=;
        b=qADyab3Rievq5Si/sweYBBpIK6vsvY84KS0YXr2uqk5oYoixjzUUrj8Ml5NvkEUSUq
         r7rVXQ4lojFRE/O/Y5aPfRm6YrAkw6tC0ajjvAR2zm7HWw3DwlVF2MB6hqspojzFDp64
         e+/wXq2rcUzfzRr+AXvGZiMW2peTwwhDUhMe4lLTmTi6ZYTRnSZJ4rA57k6H0gYEGRnX
         BWw7ixEotKVgd8+LYZ/W35fMY4KjF0RYj35rxZ4N5EvTDzAfUaKubZ36W69fkBclHDJ0
         RYHaobE3nYJaI833G5wy9QihKKiktDMNATfkuAGwh2wN02zipApYLVGDbLqjmUR+IdVp
         ou3Q==
X-Gm-Message-State: AOJu0YyRXe2dXUdRbMmd9j3JqwjeMwVaxx2UuraJcxbQF7Ka6PmCPuZ4
	FapgWMTgQ6JtpJDnT2X5+cI10jOSudFqRDbzSw3rnrXo0d4nL5Bc3ugKzR1KQQ==
X-Gm-Gg: AeBDievBn3pLaODlLnRq7jNSYC05YkbpgyF2JQSf2ktTqiwZ6fn0c2DIVhYHy4OxY/C
	tspw/fu2TACOqYcjPQrOx+fOriaG3XPuT+iszCYnRv1Vb9Esp32ETSRF8RtSG7bUb0J/zVoLwZZ
	9eNsZjAqk26Y50GJwl5PSVb3CkqbkkZQVj7kl5syw3fdaL+oe1cau4Cf4LGkgCRvWBDYQ9ua1Iz
	RKiWXk0CVtSHLtnvZgj8UnD5jmMhX7XD9sv0rVJi5aeW26u0K4eNbLPjuHOrffWG+003Eg3LBNR
	D6rsKHVRSLxwOHV97iaVc0C/R+/74Cz1BqmoLwnoDDRWySRRejla5JiHpb6qCG7tVG4GrPAfFHx
	IJy91cGK9r6F70KhdYCnZkiich6kvh8kxEu5rW2De0J2fBMTlrtFFUMyJLb97mZTWclr0xLJ+fa
	ZdAexiRtysUQRu9BquTkwimfxVwQGrOpY8dvk+tbVQ0ZcQ8RPHyRfobBohMCyIQLLw/+HKAe5N
X-Received: by 2002:a17:903:1aae:b0:2b2:45b7:306e with SMTP id d9443c01a7336-2b5f9e85fa7mr126392275ad.3.1776677364769;
        Mon, 20 Apr 2026 02:29:24 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:21f5:5215:464d:5ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0dafcsm101273545ad.52.2026.04.20.02.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:29:24 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v2 2/2] selftests/sched_ext: Add non_scx_kfunc_deny test
Date: Mon, 20 Apr 2026 17:28:48 +0800
Message-ID: <20260420092913.440989-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260420092913.440989-1-yphbchou0911@gmail.com>
References: <20260420092913.440989-1-yphbchou0911@gmail.com>
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
index 789037be44c7..5d2dffca0e91 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -175,6 +175,7 @@ auto-test-targets :=			\
 	maximal				\
 	maybe_null			\
 	minimal				\
+	non_scx_kfunc_deny		\
 	numa				\
 	allowed_cpus			\
 	peek_dsq			\
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

